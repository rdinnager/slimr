#' Insert R objects into SLiM scripts
#'
#' By calling this function inside a \code{\link{slim_block}} function call you can insert R objects
#' into the script using direct inlining. This function should generally only be used within a
#' \code{\link{slim_block}} call
#'
#' @param object R object to inline into the SLiM script.
#' @param delay By default \code{r_inline} will insert the
#' value of \code{object} into the script when the script is
#' created (e.g. when \code{\link{slim_script}} is called).
#' However, setting \code{delay = TRUE} will delay the evaluation
#' of \code{object} until the script is rendered instead (e.g. when
#' \code{\link{slim_script_render}} is called). This allows you to
#' write a \code{slimr_script} before you have an object available
#' to be inlined (e.g. it allows you to have a 'placeholder'
#' for an object you plan to generate in R later).
#'
#' @return A character vector with the code generated for inlining.
#' @export
#'
#' @details Currently supported R objects include all atomic vectors, matrices and arrays and \code{RasterLayer} objects.
#' Non-atomic vectors like factors are currently not supported and neither are any other special object types, though we
#' plan to support some in the future.
#' @examples
#' popsizes <- c(100, 200, 300)
#' slim_script(
#'  slim_block(initialize(),
#'         {
#'           initializeMutationRate(1e-7);
#'           initializeMutationType("m1", 0.5, "f", 0.0);
#'           initializeGenomicElementType("g1", m1, 1.0);
#'           initializeGenomicElement(g1, 0, 99999);
#'           initializeRecombinationRate(1e-8);
#'         }),
#'  slim_block(1,
#'         {
#'           popsizes <- r_inline(popsizes)
#'           sim.addSubpop("p1", popsizes[1]);
#'           sim.addSubpop("p2", popsizes[2]);
#'           sim.addSubpop("p3", popsizes[3]);
#'         }),
#'  slim_block(10000,
#'         {
#'           sim.simulationFinished();
#'         })
#' )
r_inline <- function(object, delay = FALSE) {

  if(delay) {
    object <- rlang::enexpr(object)
    return(rlang::expr(r_inline(!!object)))
  }

  if(inherits(object, "RasterLayer")) {
    assert_package("raster")
    object <- raster::as.matrix(object)
  }

  if(!is.array(object)) {
    object <- unname(unclass(object))
    code_for_display <- utils::capture.output(utils::str(as.vector(object)))
    if(length(object) > 1) {
      code_for_slim <- rlang::expr(c(!!!object))
      code_for_display <- paste0("c(", paste(stringr::str_split(code_for_display, " ")[[1]][c(-1:-3)], collapse = ", "), ")")
    } else {
      code_for_slim <- rlang::expr(!!object)
      code_for_display <- rlang::expr_text(code_for_slim)
    }
  } else {
    code_for_display <- utils::capture.output(utils::str(as.vector(object)))
    if(is.matrix(object)) {
      code_for_slim <- rlang::expr(matrix(!!as.vector(object), nrow = !!nrow(object), ncol = !!ncol(object)))
      code_for_display <- paste0("matrix(c(", paste(stringr::str_split(code_for_display, " ")[[1]][c(-1:-3)], collapse = ", "),
                                 "), nrow = ", nrow(object), ", ncol = ", ncol(object), ")")
    } else {
      code_for_slim <- rlang::expr(array(!!as.vector(object), dim = !!dim(object)))
      code_for_display <- paste0("array(c(", paste(stringr::str_split(code_for_display, " ")[[1]][c(-1:-3)], collapse = ", "),
                                 "), dim = c(", paste(dim(object), collapse = ", "), "))")
    }
  }



  code_for_display <- paste0("{. <- ", code_for_display, "}")



  .resources$temp_slimr_inline$code_for_slim <- c(.resources$temp_slimr_inline$code_for_slim,
                                                  rlang::expr_text(code_for_slim, width = 500L))
  .resources$temp_slimr_inline$code_for_display <- c(.resources$temp_slimr_inline$code_for_display,
                                                     code_for_display)

  rlang::sym(paste0(".__slmr_inline_object_",
                    length(.resources$temp_slimr_inline$code_for_slim),
                    "___"))
  #code_for_slim

}

#' @rdname r_inline
#' @export
slimr_inline <- r_inline

sinln <- function(object) {
  slimr_inline(object)
}

inline_replace <- function(code) {
  code <- stringr::str_replace_all(code, "slimr_inline", "!!slimr_inline")
  code <- stringr::str_replace_all(code, "([^m])r_inline", "\\1!!r_inline") ## probably a better solution..
  code <- stringr::str_replace_all(code, "^r_inline", "!!r_inline") ## deals with special case
  code <- stringr::str_replace_all(code, "sinln", "!!sinln")
  code_expr <- rlang::parse_exprs(paste(code, collapse = "\n"))
  code <- purrr::map(code_expr, ~rlang::expr_interp(.x)) %>%
    unlist()
  code <- purrr::map(code,
                     ~expr_deparse_fast(.x))

  if(any(purrr::map_lgl(code, ~inherits(.x, "list")))) {
    code <- code %>%
      purrr::flatten()
  }
  code
}

gather_inline_one <- function(code_one, slimr_inline_attr) {
  .resources$temp_slimr_inline$code_for_slim <- stats::na.omit(slimr_inline_attr$code_for_slim)
  .resources$temp_slimr_inline$code_for_display <- stats::na.omit(slimr_inline_attr$code_for_display)

  code_one <- inline_replace(code_one)
  inline_info <- list(code_for_slim = stats::na.omit(.resources$temp_slimr_inline$code_for_slim),
                      code_for_display = stats::na.omit(.resources$temp_slimr_inline$code_for_display))
  list(new_code = code_one, inline_info = inline_info)
}

gather_inline <- function(code, slimr_inline_attr) {
  res <- purrr::map2(code, slimr_inline_attr,
                    ~gather_inline_one(.x, .y))
  res
}

process_inline <- function(code, block_names, slimr_inline_attr) {

  slimr_inline_attr <- slimr_inline_attr %>%
    dplyr::group_by(.data$block_name)

  slimr_inline_attr_blocks <- slimr_inline_attr %>%
    dplyr::group_split()

  names(slimr_inline_attr_blocks) <- slimr_inline_attr %>%
    dplyr::group_keys() %>%
    dplyr::pull(.data$block_name)

  slimr_inline_attr_blocks <- slimr_inline_attr_blocks[block_names]

  inline_processed <- gather_inline(as.character(code),
                                    slimr_inline_attr_blocks) %>%
    purrr::transpose()

  slimr_inline_attr <- purrr::transpose(inline_processed$inline_info) %>%
    dplyr::as_tibble() %>%
    dplyr::mutate("block_name" := block_names) %>%
    tidyr::unnest(c("code_for_slim", "code_for_display"),
                  keep_empty = TRUE) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display"),
                     ~purrr::map(.,
                                 ~ purrr::`%||%`(.x, NA))) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display"),
                     ~list_unchop(.))

  new_code <- purrr::map(inline_processed$new_code,
                         ~unlist(.x))

  list(new_code, slimr_inline_attr)
}



#' Convert a string to a SLiM object name
#'
#' @param name A string with the SLiM object name
#'
#' @return A symbol
#' @export
#'
#' @examples
#' slimr_name("p1")
slimr_name <- function(name) {
  rlang::sym(name)
}
