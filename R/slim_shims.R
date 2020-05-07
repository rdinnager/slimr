#' Use this to replace "." operator in SLiM code
#'
#' This is a simple shim used to allow SLiM-like code to be parsed by the R interpreter.
#' When writing SLiM code in R use this instead of "." to maintain code highlighting and
#' code completion. See \code{vignette("SLiM_IDE_tutorial")} for details on how to use this
#' in an R IDE to write SLiM code.
#'
#' @param lhs Left hand side
#' @param rhs Right hand side
#'
#' @return NULL (invisibly)
#' @export
`%.%` <- function(lhs, rhs) {
  invisible(NULL)
}
