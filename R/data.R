#' Dataset of all recipes available in SLiM
#'
#' A Dataset containing all SLiM recipes found in the SLiM Manual
#'
#' @format A List with 190 elements, each containing a character vector
#' @source \url{https://github.com/MesserLab/SLiM/releases/download/v4.1/SLiM_Manual.pdf}
"slim_recipes"

load_herm <- function() {
  files <- list.files(system.file(package = "slimr", "extdata/herm"), full.names = TRUE)
}

