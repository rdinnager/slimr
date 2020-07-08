slimr_inline <- function(r_expr, unquote_strings = FALSE) {

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
