.slim_settings <- new.env()
.slim_assets <- new.env()
.resources <- new.env()
if(getRversion() >= "2.15.1")  utils::globalVariables(c(".",
                                                        ".G",
                                                        "Genome",
                                                        ".GE",
                                                        "GenomicElement",
                                                        ".GET",
                                                        "GenomicElementType",
                                                        ".I",
                                                        "Individual",
                                                        ".IT",
                                                        "InteractionType",
                                                        ".M",
                                                        "Mutation",
                                                        ".MT",
                                                        "MutationType",
                                                        ".P",
                                                        "Subpopulation",
                                                        ".S",
                                                        "Substitution",
                                                        ".SB",
                                                        "SLiMBuiltin",
                                                        ".SS",
                                                        "SLiMSim",
                                                        ".c",
                                                        "Chromosome",
                                                        ".Init",
                                                        "Initialize",
                                                        ".SEB",
                                                        "SLiMEidosBlock",
                                                        ".x",
                                                        "sim.generation",
                                                        "catn",
                                                        "initialize",
                                                        "m1",
                                                        "g1",
                                                        "sim.addSubpop",
                                                        "sim.simulationFinished",
                                                        "str",
                                                        "sim.outputFull",
                                                        "sim.subpopulations.individuals.genome1.nucleotides",
                                                        "sim.subpopulations.individuals.sex",
                                                        "sim.subpopulations.individuals.subpopulation",
                                                        "sim.subpopulations.individuals.x",
                                                        "sim.subpopulations.individuals.y",
                                                        "sim.subpopulations.individuals.z"
                                                        ))




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


  ## load slim language objects
  utils::data(slim_classes, package = pkgname,
              envir = parent.env(environment()))
  .resources$classes_regex <- paste0("(", paste(c(slim_classes$class_name, slim_classes$class_abbr),
                                                collapse = "|"), ")")

  ## create temporary variables

  .resources$temp_slimr_template <- list()
  .resources$temp_slimr_template$var_name <- list()
  .resources$temp_slimr_template$default <- list()
  .resources$temp_slimr_template$unquote <- list()
  .resources$temp_slimr_inline <- list()
  .resources$temp_slimr_inline$code_for_slim <- list()
  .resources$temp_slimr_inline$code_for_display <- list()
  .resources$temp_slimr_output <- list()
  .resources$temp_slimr_output$code_for_slim <- list()
  .resources$temp_slimr_output$output_name <- list()
  .resources$temp_slimr_output$code_for_display <- list()
  .resources$temp_slimr_output$file_name <- list()
  .resources$temp_slimr_output$format <- list()
  .resources$loaded_globals <- NULL

}

.onUnload <- function(libname, pkgname) {
  slim_unload_globals()
}
