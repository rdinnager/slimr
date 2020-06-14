.slim_settings <- new.env(parent = emptyenv())
.slim_assets <- new.env(parent = emptyenv())
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

.onAttach <- function(libname, pkgname) {

  slim_avail <- get_slim_call()
  if(!is.null(slim_avail)) {
    packageStartupMessage("Welcome to the slimr package for forward population genetics simulation in SLiM. For more information on SLiM please visit https://messerlab.org/slim/ .")

  } else {
    packageStartupMessage("Welcome to the slimr package. slimr requires SLiM population genetics forward simulation software. Run slim_setup() for slimr to attempt to download and install the package automatically. If that doesn't work, try installing manually by going to https://messerlab.org/slim/ and following the instructions.")

  }



}

.onLoad <- function(libname, pkgname) {

  .slim_settings$slim_dir <- get_slim_dir()

  slim_avail <- try(get_slim_call(), silent = TRUE)
  if(!is.null(slim_avail) || inherits(slim_avail, "try-error")) {
    #packageStartupMessage("Welcome to the slimr package for forward population genetics simulation in SLiM. For more information on SLiM please visit https://messerlab.org/slim/ .")
    .slim_settings$slim_call <- slim_avail
    .slim_settings$slim_avail <- TRUE
  } else {
    #packageStartupMessage("Welcome to the slimr package. slimr requires SLiM population genetics forward simulation software. Run slim_setup() for slimr to attempt to download and install the package automatically. If that doesn't work, try installing manually by going to https://messerlab.org/slim/ and following the instructions.")
    .slim_settings$slim_avail <- FALSE
  }

  .slim_assets$keywords <- list()


  ## replace all mentions of external files in recipes with their proper internal package file paths
  resources <- list.files(system.file("extdata", "recipe_resources", package = "slimr"), full.names = TRUE)
  resources <- resources[!stringr::str_detect(resources, stringr::fixed("FIN_samples.txt"))]

  if(get_os() == "windows") {
    resources <- convert_to_wsl_path(resources)
  }

  recipe_vec <- unlist(slim_recipes)

  recipes_using_resources <- purrr::map_int(resources,
                                            ~stringr::str_which(recipe_vec,
                                                                stringr::coll(basename(.x))))

  slim_recipes[recipes_using_resources] <- purrr::map2(slim_recipes[recipes_using_resources],
                                                       resources,
                                                       ~stringr::str_replace_all(.x,
                                                                                 paste0('\"[^"]*\\Q', basename(.y), '\\E\"'), ## some handy regex here
                                                                                 paste0('"', .y, '"')))
  .slim_assets$slim_recipes <- slim_recipes


}

#' @import slimrlang
NULL
