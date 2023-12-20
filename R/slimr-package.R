.slim_settings <- new.env()
.slim_assets <- new.env()
.resources <- new.env()
if(getRversion() >= "2.15.1")  utils::globalVariables(c(".",
                                                        "Eidos",
                                                        ".E",
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
                                                        ".LF",
                                                        "LogFile",
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
                                                        ".Sp",
                                                        "Species",
                                                        ".SG",
                                                        "SLiMgui",
                                                        ".SM",
                                                        "SpatialMap",
                                                        ".c",
                                                        "Chromosome",
                                                        ".Init",
                                                        "Initialize",
                                                        ".SEB",
                                                        "SLiMEidosBlock",
                                                        ".x",
                                                        "sim.generation",
                                                        "community.tick",
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
                                                        "sim.subpopulations.individuals.z",
                                                        "setSeed",
                                                        "defineConstant",
                                                        "sim.mutations",
                                                        "sim.mutations.position",
                                                        "sim.subpopulations.individuals",
                                                        "sim.subpopulations.individuals.genomes.containsMutations",
                                                        "size"
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
  #resources <- resources[!stringr::str_detect(resources, stringr::fixed("FIN_samples.txt"))]

  # if(get_os() == "windows") {
  #   resources <- convert_to_wsl_path(resources)
  # }

  slim_recipes <- slimr::slim_recipes

  recipe_vec <- unlist(slim_recipes)

  recipes_using_resources <- purrr::map(resources,
                                            ~stringr::str_which(recipe_vec,
                                                                stringr::coll(basename(.x))))

  resources_used <- purrr::map_lgl(recipes_using_resources,
                               ~!purrr::is_empty(.x) > 0)
  recipes_using_resources <- recipes_using_resources %>%
    purrr::simplify()

  slim_recipes[recipes_using_resources] <- purrr::map2(slim_recipes[recipes_using_resources],
                                                       resources[resources_used],
                                                       ~stringr::str_replace_all(.x,
                                                                                 paste0('\"[^"]*\\Q', basename(.y), '\\E\"'), ## some handy regex here
                                                                                 paste0('"', .y, '"')))
  .slim_assets$slim_recipes <- slim_recipes
  .slim_assets$recipes_using_resources <- recipes_using_resources


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


  ## setup slim class environments
  Init <- list2env(.Init, Initialize)
  Ch <- list2env(.Ch, Chromosome)
  Co <- list2env(.Co, Community)
  E <- list2env(.E, Eidos)
  G <- list2env(.G, Genome)
  GE <- list2env(.GE, GenomicElement)
  GET <- list2env(.GET, GenomicElementType)
  In <- list2env(.I, Individual)
  IT <- list2env(.IT, InteractionType)
  LF <- list2env(.LF, LogFile)
  M <- list2env(.M, Mutation)
  MT <- list2env(.MT, MutationType)
  SB <- list2env(.SB, SLiMBuiltin)
  SEB <- list2env(.SEB, SLiMEidosBlock)
  SG <- list2env(.SG, SLiMgui)
  SM <- list2env(.SM, SpatialMap)
  SS <- list2env(.SS, SLiMSim)
  Sp <- list2env(.Sp, Species)
  P <- list2env(.P, Subpopulation)
  S <- list2env(.S, Substitution)

  ##### make class nesting ############
  SLiMSim$chromosome <- Chromosome
  SLiMSim$genomicElementTypes <- GenomicElementType
  SLiMSim$interactionTypes <- InteractionType
  SLiMSim$logFiles <- LogFile
  SLiMSim$mutationTypes <- MutationType
  SLiMSim$mutations <- Mutation
  SLiMSim$scriptBlocks <- SLiMEidosBlock
  SLiMSim$subpopulations <- Subpopulation
  SLiMSim$substitutions <- Substitution

  Species$chromosome <- Chromosome
  Species$genomicElementTypes <- GenomicElementType
  Species$mutationTypes <- MutationType
  Species$mutations <- Mutation
  Species$scriptBlocks <- SLiMEidosBlock
  Species$subpopulations <- Subpopulation
  Species$substitutions <- Substitution

  Community$logFiles <- LogFile
  Community$allGenomicElementTypes <- GenomicElementType
  Community$allInteractionTypes <- InteractionType
  Community$allMutationTypes <- MutationType
  Community$allScriptBlocks <-  SLiMEidosBlock
  Community$allSpecies <- Species
  Community$allSubpopulations <- Subpopulation

  Chromosome$genomicElements <- GenomicElement

  Genome$individual <- Individual
  Genome$mutations <- Mutation

  GenomicElement$genomicElementType <- GenomicElementType

  Individual$genome1 <- Genome
  Individual$genome2 <- Genome
  Individual$genomes <- Genome
  Individual$uniqueMutations <- Mutation
  Individual$subpopulation <- Subpopulation

  Mutation$mutationType <- MutationType

  Subpopulation$individuals <- Individual
  Subpopulation$genomes <- Genome
  Subpopulation$individuals <- Individual

}

.onUnload <- function(libname, pkgname) {
  slim_unload_globals()
}
