#' Rify some SLiM code
#'
#' Utility code to convert SLiM code into a form that can be parsed by R
#' (e.g. in \code{styler} or \code{prettycode}). Don't forget to re-SLiMify
#' afterwards (via \code{\link(slim_code_SLiMify))!
#'
#' @param code_snippet SLiM code to Rify as a character vector
#'
#' @return Rified code snippet
slim_code_Rify <- function(code_snippet) {


  ## replace SLiM modulus % with R modulus %%
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^.])%([^.])",
                                           "\\1%%\\2")

  ## replace ? else with fake operators
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "(.*?)\\?(.*?)else(.*?)",
                                           "\\1%?%\\2%else%\\3")

  ## remove overhanging elses and ; elses
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "\n+[:blank:]*\\Qelse\\E",
                                           " else")

  code_snippet <- stringr::str_replace_all(code_snippet,
                                           ";[:blank:]*\\Qelse\\E",
                                           " else")

  ## make sure do statements are on their own line (R treats it as a variable then)
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "do[:blank:]+(.*?);",
                                           "do\n{\\1;}")

  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "do[:blank:]*\\{",
                                           "do\n{")

  ## convert return x; to return(x);
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "return[:space:]+?(.*)(;| else)",
                                           "return(\\1)\\2")

  ## replace . with %.% (shim operator)
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^[:digit:]])\\.([^[:digit:]])",
                                           "\\1%.%\\2")

  ## add slimr_special__ keyword to while statements to make R parse it OK.
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "(while[:blank:]*\\((.*?)\\))[:blank:]*;",
                                           "\\1slimr_special__")

  code_snippet

}

#' Rify some SLiM code
#'
#' Utility code to convert Rified (via \code{\link{slim_code_Rify}}) SLiM code back to valid SLiM code!
#'
#' @param code_snippet SLiM code to Rify as a character vector
#'
#' @return SLiMified code snippet
slim_code_SLiMify <- function(code_snippet) {

  # code_snippet <- stringr::str_replace_all(code_snippet,
  #                                          stringr::fixed("do;"),
  #                                          stringr::fixed("do"))

    # code_snippet <- stringr::str_replace_all(code_snippet,
  #                                          "(\n[^}]*)[:blank:]*\\Qelse\\E",
  #                                          "\\1; else")

  ## replace elses not preceded by } with ; else
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "(?<!\\})[:blank:]\\Qelse\\E",
                                           "; else")

  ## change back to SLiM return syntax (e.g no brackets)
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "return\\((.*)\\)[:blank:]*(;| else)",
                                           "return \\1\\2")

  ## go back to regular dots from special dot operator
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "[:space:]*%\\.%[:space:]*",
                                           stringr::fixed("."))

  ## remove special keyword used to make do while state,ents work with R parser
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           stringr::fixed("slimr_special__"),
                                           ";")

  ## put ternary operators right
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "(.*?)%\\?%(.*?)%else%(.*?)",
                                           "\\1?\\2else\\3")

  ## turn R modulus %% back into SLiM modulus %
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^.])%%([^.])",
                                           "\\1%\\2")


  code_snippet

}

#' Load SLiM Globals into R Global environment
#'
#' This function loads R objects to stand in for standard Globals used in SLiM.
#' These will be available in the global environment and can be used to aid in
#' autocompletion and help retrieval, saving typing of this pattern: \code{p1%.%Subpopulation$setSubpopulationSize(N)} --
#' instead one can just type: \code{p1$setSubpopulationSize(N)}: this will be replaced by correct SLiM code:
#' \code{p1.setSubpopulationSize(N)}
#'
#' By default this will load ten of each of the standard SLiM Globals (e.g. objects prefixed with "p",
#' "m", "i", "g", and "s"), as well as the "sim" and "self" singular Globals. Note: be careful with
#' this function. If you have any objects in your R session's global environment with these names
#' they will be overwritten.
#'
#' @param max A single integer values indicating how many of
#' each numbered Globals to load, or a named integer vector where the names
#' refer to different Global types (see details for more information), and the value
#' refers to how many of that Global type to load.
#' @param sim Should the \code{sim} global be loaded?
#' @param self Should the \code{self} global be loaded?
#' @param pseudo Should 'pseudo-variables' be loaded? These are similar to SLiM
#' globals but are only available inside certain callbacks.
#' @return None
#' @export
#' @examples slim_load_globals(c(p = 4, g = 2))
slim_load_globals <- function(max = 10, sim = TRUE, self = TRUE, pseudo = TRUE) {

  if(sim) {
    rlang::env_bind_lazy(rlang::global_env(),
                         sim = SLiMSim)
  }

  if(self) {
    rlang::env_bind_lazy(rlang::global_env(),
                         self = SLiMEidosBlock)
  }

  if(pseudo) {
    rlang::env_bind_lazy(rlang::global_env(),
                         genome1 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         genome2 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         childGenome1 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         childGenome2 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent1Genome1 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent1Genome2 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent2Genome1 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent2Genome2 = Genome)
    rlang::env_bind_lazy(rlang::global_env(),
                         subpop = Subpopulation)
    rlang::env_bind_lazy(rlang::global_env(),
                         sourceSubpop = Subpopulation)
    rlang::env_bind_lazy(rlang::global_env(),
                         individual = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         receiver = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         exerter = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         child = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent1 = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         parent2 = Individual)
    rlang::env_bind_lazy(rlang::global_env(),
                         mut = Mutation)
  }

  if(!rlang::is_named(max)) {
    if(length(max) > 1) {
      rlang::abort("Argument max must be named if it has length > 1")
    }
    if(max == 0) {
      max <- NULL
    } else {
      max <- c(g = max, i = max, m = max, p = max, s = max)
    }
  } else {
    if(all(max == 0)) {
      max <- NULL
    } else {
      if(any(max == 0)) {
        max <- max[max != 0]
      }
    }
  }

  if(!is.null(max)) {
    types <- names(max)
    obs <- list(g = GenomicElementType,
                i = InteractionType,
                m = MutationType,
                p = Subpopulation,
                s = SLiMEidosBlock)

    class_obs <- purrr::imap(max,
                             ~ replicate(.x, obs[[.y]], simplify = FALSE) %>%
                               setNames(paste0(.y, seq_len(.x))))

    ob_names_all <- purrr::map(class_obs,
                           ~names(.x))

    class_obs <- class_obs %>%
      purrr::flatten()

    do.call(rlang::env_bind_lazy,
            c(list(.env = rlang::global_env()),
              class_obs),
            envir = rlang::global_env())

    ob_names <- purrr::map_chr(ob_names_all,
                               ~paste(.x, collapse = ", ")) %>%
      unname()

  } else {
    ob_names <- NULL
    ob_names_all <- NULL
  }

  if(sim) {
    ob_names <- c(ob_names, "sim")
    ob_names_all <- c(ob_names_all, "sim")
  }

  if(self) {
    ob_names <- c(ob_names, "self")
    ob_names_all <- c(ob_names_all, "self")
  }

  if(pseudo) {
    ob_names <- c(ob_names, c("genome1",
                              "genome2",
                              "childGenome1",
                              "childGenome2",
                              "parent1Genome1",
                              "parent1Genome2",
                              "parent2Genome1",
                              "parent2Genome2",
                              "subpop",
                              "sourceSubpop",
                              "individual",
                              "receiver",
                              "exerter",
                              "child",
                              "parent1",
                              "parent2",
                              "mut"))

    ob_names_all <- c(ob_names_all, c("genome1",
                                      "genome2",
                                      "childGenome1",
                                      "childGenome2",
                                      "parent1Genome1",
                                      "parent1Genome2",
                                      "parent2Genome1",
                                      "parent2Genome2",
                                      "subpop",
                                      "sourceSubpop",
                                      "individual",
                                      "receiver",
                                      "exerter",
                                      "child",
                                      "parent1",
                                      "parent2",
                                      "mut"))
  }

  .resources$loaded_globals <- union(.resources$loaded_globals,
                                     as.list(ob_names_all) %>%
                                       purrr::flatten_chr())

  rlang::warn(paste0("slim_load_globals modifies the global environment so please be careful when using this function!\n",
                    "It has assigned values to the following names:\n\n",
                    rlang::format_error_bullets(ob_names),
                    "\n\nIf there were already objects with any of these names in the global environment\nthen their values have been replaced.\n",
                    "Use slim_unload_globals() to remove them."),
              .frequency = "once",
              .frequency_id = "slim_load_globals")

  }


#' Unload SLiM Globals from R Global environment
#'
#' This will remove any objects added to the global environment by
#' \code{\link{slim_load_globals}}
#'
#' @return
#' @export
#'
#' @examples
#' slim_load_globals(c(p = 1))
#' slim_unload_globals()
slim_unload_globals <- function() {
  rm(list = .resources$loaded_globals, pos = rlang::global_env())
  .resources$loaded_globals <- NULL
}
