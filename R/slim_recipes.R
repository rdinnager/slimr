#' Get a SLiM recipe
#'
#' @param recipe Integer or Character specifying the recipe number, or the recipe name.
#'
#' @return A SLiM recipe as a length 1 character vector
#' @export
#'
#' @examples
#' slim_get_recipe(recipe = "4.1")
slim_get_recipe <- function(recipe = 1) {
  .slim_assets$slim_recipes[[recipe]]
}

#' Get a list of SLiM recipes (as text)
#'
#' @param recipes Integer or Character specifying the recipe numbers / names, or "all", to retrieve all recipes.
#'
#' @return List of SLiM recipes, each element a length 1 character vector.
#' @export
#'
#' @examples
#' recipes <- slim_get_recipes("all")
#' recipes[[12]]
slim_get_recipes <- function(recipes = "all") {
  if(is.numeric(recipes)) {
    .slim_assets$slim_recipes[recipes]
  } else {
   if(recipes == "all") {
     .slim_assets$slim_recipes
   }
  }

}


