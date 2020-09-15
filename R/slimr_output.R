#' Tell SLiM to produce easily parseable output
#'
#' Use this function in a \code{\link{slim_block}} call and it will be
#' converted in the SLiM script into code to make formatted output.
#' This output can easily be read into R and even dynamically read
#' during simulation runs with \code{\link[slimr]{slim_run}} from the
#' \code{slimr} package. This function should generally only be
#' used within a \code{\link{slim_block}} call
#'
#' @param slimr_expr A SLiM expression to generate output. This can either be
#' a SLiM expression designed to create output, such as \code{outputFull()},
#' or an object created in the SLiM code, in which case \code{slimr_output}
#' will automatically concatenate it to a string and output it
#' @param name The name to use to identify this output.
#' @param do_every How often should the output be produced? Expressed
#' as an integer saying how many generations to run before producing output.
#' e.g. \code{do_every = 10} means to output every 10 generations of the
#' simulation.
#'
#' @return An expression with the code to be run in SLiM.
#'
#' @export
#'
#' @examples
slimr_output <- function(slimr_expr, name, do_every = 1,
                         send_to = c("data", "file"),
                         file_name = tempfile(fileext = ".txt"),
                         format = c("csv", "fst")) {

  send_to = match.arg(send_to)
  format = match.arg(format)

  if(send_to == "file" & format == "fst") {
    assert_package("fst")
  }

  slimr_expr <- rlang::enexpr(slimr_expr)

  expr_txt <- rlang::expr_deparse(slimr_expr)

  if(slimr_code_detect_output(expr_txt)) {
    new_code <- rlang::expr(
      if(sim.generation %% !!do_every == 0) {
        cat("\n<slimr_out:start>\n" + paste(sim.generation) + ",'" +
              !!name + "','" + !!expr_txt + "','" + "','")
        !!slimr_expr
        cat("'\n<slimr_out:end>\n")
      }
    )
  } else {
    new_code <- rlang::expr(
      if(sim.generation %% !!do_every == 0) {
        cat("\n<slimr_out:start>\n" + paste(sim.generation) + ",'" +
              !!name + "','" + !!expr_txt + "','")
        str(!!slimr_expr)
        cat("','")
        cat(paste(!!slimr_expr))
        cat("'\n<slimr_out:end>\n")
    })
  }

  code_for_display <- paste0("{", rlang::expr_text(slimr_expr), " -> ", name, "}")

  .resources$temp_slimr_output$code_for_slim <- c(.resources$temp_slimr_output$code_for_slim,
                                                  rlang::expr_text(new_code))
  .resources$temp_slimr_output$code_for_display <- c(.resources$temp_slimr_output$code_for_display,
                                                     code_for_display)
  .resources$temp_slimr_output$output_name <- c(.resources$temp_slimr_output$output_name,
                                                name)

  if(send_to == "file") {
    .resources$temp_slimr_output$file_name <- c(.resources$temp_slimr_output$file_name,
                                                file_name)
    .resources$temp_slimr_output$format <- c(.resources$temp_slimr_output$format,
                                                format)
  } else {
    .resources$temp_slimr_output$file_name <- c(.resources$temp_slimr_output$file_name,
                                                NA)
    .resources$temp_slimr_output$format <- c(.resources$temp_slimr_output$format,
                                                NA)
  }

  new_code

}

sout <- function(slimr_expr, name, do_every = NULL,
                 send_to = c("data", "file"),
                 file_name = tempfile(fileext = ".txt"),
                 format = c("csv", "fst")) {
  slimr_output(slimr_expr, name, do_every,
               send_to, file_name, format)
}

out_replace <- function(code) {
  code <- stringr::str_replace_all(code, "slimr_output", "!!slimr_output")
  code <- stringr::str_replace_all(code, "sout", "!!sout")
  code_expr <- rlang::parse_exprs(paste(code, collapse = "\n"))
  code <- purrr::map(code_expr, ~rlang::expr_interp(.x)) %>%
    unlist()
  code <- purrr::map(code,
                     ~rlang::expr_deparse(.x, width = 500L))

  if(any(purrr::map_lgl(code, ~inherits(.x, "list")))) {
    code <- code %>%
      purrr::flatten()
  }
  code
}

gather_out_one <- function(code_one) {
  .resources$temp_slimr_output$code_for_slim <- list()
  .resources$temp_slimr_output$output_name <- list()
  .resources$temp_slimr_output$code_for_display <- list()
  .resources$temp_slimr_output$file_name <- list()
  .resources$temp_slimr_output$format <- list()

  code_one <- out_replace(code_one)
  output_info <- list(code_for_slim = .resources$temp_slimr_output$code_for_slim,
                      code_for_display = .resources$temp_slimr_output$code_for_display,
                      output_name = .resources$temp_slimr_output$output_name,
                      file_name = .resources$temp_slimr_output$file_name,
                      format = .resources$temp_slimr_output$format)
  list(new_code = code_one, output_info = output_info)
}

gather_out <- function(code) {
  res <- purrr::map(code,
                    ~gather_out_one(.x))
  res
}

process_output <- function(code, block_names) {
  output_processed <- gather_out(as.character(code)) %>%
    purrr::transpose()

  slimr_output_attr <- purrr::transpose(output_processed$output_info) %>%
    dplyr::as_tibble() %>%
    dplyr::mutate("block_name" := block_names) %>%
    tidyr::unnest(c("code_for_slim", "code_for_display", "output_name",
                    "file_name", "format"),
                  keep_empty = TRUE) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display", "output_name",
                       "file_name", "format"),
                     ~purrr::map(.,
                                 ~ purrr::`%||%`(.x, NA))) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display", "output_name",
                       "file_name", "format"),
                     ~vec_unchop(.))

  #new_code <- SLiMify_all(output_processed$new_code)

  new_code <- purrr::map(output_processed$new_code,
                         ~unlist(.x))

  list(new_code, slimr_output_attr)
}

slimr_output_full <- function(name = "full_output") {
  slimr_output(sim.outputFull(), name)
}
