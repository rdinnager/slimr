#' Title
#'
#' @param slim_script A character vector (of length 1) containing the SLiM script to run
#'
#' @return
#' @export
#'
#' @examples
slim_run_script <- function(slim_script, slim_path = NULL) {
  script_file <- tempfile(fileext = ".txt")
  readr::write_file(slim_script, script_file)
  if(get_os() == "windows") {
    script_file <- convert_to_wsl_path(script_file)
  }
  slim_options <- script_file
  if(is.null(slim_path)) {
    slim_string <- get_slim_call() %>%
      glue::glue()
  } else {
    slim_string <- paste(slim_path, slim_options)
  }
  out <- system(slim_string)
  out
}

#' Title
#'
#' @param slim_script_template A slim script with sections enclosed in '<<' and '>>'. Anything between double
#' triangular brackets will be replaced by its corresponding named element in \code{param_list}. For example,
#' '<<x>>' will be replace by the value \code{param_list$x}
#' @param param_list
#'
#' @return
#' @export
#'
#' @examples
slim_run_script_template <- function(slim_script_template, param_list, slim_path = NULL) {

}
