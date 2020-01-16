#' Get a SLiM recipe
#'
#' @param recipe Integer or Character specifying the recipe number, or the recipe name.
#'
#' @return
#' @export
#'
#' @examples
get_recipe <- function(recipe = 1) {
  recipes[recipe]
}


