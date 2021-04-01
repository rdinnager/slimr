#' Create a templated variable
#'
#' Create a templated variable inside a SLiM script. This function can be used directly inside a \code{slim_block} function call,
#' to generate a placemarker that can be replaced with different values dynamically using \code{\link{slimr_script_render}}.
#'
#' @param var_name Name to use as a placemarker for the variable. This name will be used for replacing values later.
#' @param default A default value to be inserted during script rendering if a value is not otherwise provided.
#' @param unquote_strings If the value being inserted is of class character, should it be 'unquoted', that is,
#' should double quotes around the value be removed? This is useful when you want to refer to a SLiM object, e.g.
#' to insert \code{p1.setMigrationRate(...)} instead of \code{"p1".setMigrationRate(...)}, the latter of which is not
#' valid SLiM code.
#'
#' @return Returns the placemarker if used outside
#' @export
#'
#' @details Note that this function is only designed to be used inside a \code{\link{slim_block}} function call. If run in any other
#' situation, it won't really do anything, just returning a reference to the placemarker that would have been inserted if run in
#' its correct context.
slimr_template <- function(var_name, default = NULL, unquote_strings = FALSE) {
  .resources$temp_slimr_template$var_name <- c(.resources$temp_slimr_template$var_name,
                                               var_name)
  .resources$temp_slimr_template$default <- c(.resources$temp_slimr_template$default,
                                              default)
  .resources$temp_slimr_template$unquote <- c(.resources$temp_slimr_template$unquote,
                                              unquote_strings)

  rlang::sym(paste0("..", var_name, ".."))
}

stmplt <- function(var_name, default = NULL, unquote_strings = FALSE) {
  slimr_template(var_name, default, unquote_strings)
}

tmplt_replace <- function(code) {
  code <- stringr::str_replace_all(code, "slimr_template", "!!slimr_template")
  code <- stringr::str_replace_all(code, "stmplt", "!!stmplt")
  code_expr <- rlang::parse_exprs(paste(code, collapse = ""))

  code <- purrr::map(code_expr, ~rlang::expr_interp(.x) %>%
                       rlang::expr_deparse(width = 500L))

  if(any(purrr::map_lgl(code, ~inherits(.x, "list")))) {
    code <- code %>%
      purrr::flatten()
  }

  code
}

gather_tmplt_one <- function(code_one) {
  .resources$temp_slimr_template$var_name <- list()
  .resources$temp_slimr_template$default <- list()
  .resources$temp_slimr_template$unquote <- list()
  code_one <- tmplt_replace(code_one)
  input_info <- list(var_names = .resources$temp_slimr_template$var_name,
                     defaults = .resources$temp_slimr_template$default,
                     unquote = .resources$temp_slimr_template$unquote)
  list(new_code = code_one, input_info = input_info)
}

gather_tmplt <- function(code) {
  res <- purrr::map(code,
                    ~gather_tmplt_one(.x))

  res
}

process_template <- function(code, block_names) {

  template_processed <- gather_tmplt(as.character(code)) %>%
    purrr::transpose()

  slimr_template_attr <- purrr::transpose(template_processed$input_info) %>%
    dplyr::as_tibble() %>%
    dplyr::mutate("block_name" := block_names) %>%
    tidyr::unnest(c("var_names", "defaults", "unquote"),
                  keep_empty = TRUE) %>%
    dplyr::mutate_at(c("var_names", "defaults", "unquote"),
                     ~purrr::map(.,
                                 ~ purrr::`%||%`(.x, NA))) %>%
    dplyr::mutate_at(c("var_names", "unquote"),
                     ~vec_unchop(.))

  #new_code <- SLiMify_all(template_processed$new_code)
  new_code <- purrr::map(template_processed$new_code,
                         ~unlist(.x))

  list(new_code, slimr_template_attr)
}


replace_double_dots <- function(slimr_script, envir = parent.frame(), slimr_template_attr, replace_NAs) {

  templated <- !is.na(slimr_template_attr$var_names)
  templated_vars <- slimr_template_attr$var_names[templated]
  not_specified <- !(templated_vars %in% names(envir))

  if(any(not_specified)) {
    defaults <- slimr_template_attr$defaults[templated][not_specified]
    missing_defaults <- purrr::map_lgl(defaults,
                                       ~is.na(.x))

    if(any(missing_defaults)) {
      stop("Some templated variables have not been fully specified in template, and no default was provided")
    } else {
      new_envir <- defaults
      names(new_envir) <- templated_vars[not_specified]
      envir <- c(envir, new_envir)
      warning("Warning: A templated variable was not specified in the template and has been replaced by its default value.\n")
    }

  }

  missing_dat <- purrr::map_lgl(envir,
                                ~is.na(.x))
  if(any(missing_dat)) {
    if(replace_NAs) {
      the_defaults <- slimr_template_attr$defaults[templated]
      names(the_defaults) <- templated_vars
      envir[missing_dat] <- the_defaults[names(envir)[missing_dat]]
      warning("Warning: There are missing values in template and replace_NAs = TRUE, so they will be replaced by their defaults\n")
    } else {
      warning("Warning: There are missing values in template and replace_NAs = FALSE, so the rendered script will have NA values\n")
    }
  }

  char_vars <- names(envir)[purrr::map_lgl(envir,
                              ~inherits(.x, "character"))]

  if(length(char_vars) > 0) {
    unquote <- slimr_template_attr$unquote[slimr_template_attr$var_names %in% char_vars]
    names(unquote) <- slimr_template_attr$var_names[slimr_template_attr$var_names %in% char_vars]
    envir[names(unquote)[!unquote]] <- paste0("\"", envir[names(unquote)[!unquote]], "\"")
  }


  code_text <- as.character.slimr_code(code(slimr_script))
  new_code <- purrr::map(code_text,
                         ~glue::glue(.x,
                                     .envir = envir,
                                     .open = "..",
                                     .close = "..") %>%
                           stringr::str_split("\n") %>%
                           unlist())

  block_names <- field(slimr_script, "block_name")

  new_code <- new_slimr_code(new_code)

  c(new_code, slimr_template_attr) %<-% process_template(new_code, block_names)


  new_code <- purrr::map(new_code,
                         ~unlist(.x))

  new_code <- new_slimr_code(new_code)

  script_info <- attr(slimr_script, "script_info")
  script_info$rendered <- TRUE

  slimr_script <- new_slimr_script(block_name = block_names,
                                   block_id = field(slimr_script, "block_id"),
                                   start_gen = field(slimr_script, "start_gen"),
                                   end_gen = field(slimr_script, "end_gen"),
                                   callback = field(slimr_script, "callback"),
                                   code = new_code,
                                   slimr_template = slimr_template_attr,
                                   slimr_output = attr(slimr_script, "slimr_output"),
                                   slimr_inline = attr(slimr_script, "slimr_inline"),
                                   slimrlang_orig = attr(slimr_script, "slimrlang_orig"),
                                   script_info = script_info)
  slimr_script
}

#' Get information on templating in a slimr_script
#'
#' Returns information on templated variables and their default values in a \code{slimr_script}
#'
#' @param script_temp A templated \code{slimr_script} to retrieve information from
#'
#' @return A list of lists. The top-level is named for the blocks in which templated variables exist.
#' For each block with templated variables the element is a list named with all templated variables
#' in that block, and its values are equal to the default values for those variables.
#' @export
#'
#' @examples
slimr_template_info <- function(script_temp) {
  slimr_template_attr <- attr(script_temp, "slimr_template")
  if(any(!is.na(slimr_template_attr$var_names))) {
    info_group <- slimr_template_attr %>%
      dplyr::group_by(.data$block_name)

    temp_split <- dplyr::group_split(info_group)
    temp_names <- dplyr::group_keys(info_group)

    temp_info <- purrr::map(temp_split,
                            ~.x$defaults %>%
                              stats::setNames(.x$var_names))

    names(temp_info) <- temp_names$block_name

    temp_info <- purrr::map(temp_info,
                            ~if(all(is.na(names(.x)))) {
                              NULL
                            } else {
                              .x
                            }) %>%
      purrr::compact()

    temp_info
  } else {
    NULL
  }
}
