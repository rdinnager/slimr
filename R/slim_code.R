#' Generate SLiM output markup codes.
#'
#' @param keyword Keyword to use in markup. e.g. "generation", "coordinates", etc
#' @param begin Whether to generate the begin markup, or if FALSE, the end markup tag.
#'
#' @return The markup tag ("character")
#'
#' @examples
slim_code_markup <- function(keyword, begin = TRUE) {
  if(begin) {
    markup <- "<slimr_output:{keyword}_start>"
  } else {
    markup <- "<slimr_output:{keyword}_end>"
  }
  glue::glue(markup)
}

#' Title
#'
#' @param begin
#'
#' @return
#' @export
#'
#' @examples
slim_gen_output_markup_code <- function(begin = TRUE) {
  if(begin) {
    markup <- slim_code_markup("generation")
  } else {
    markup <- slim_code_markup("generation", FALSE)
  }
  glue::glue('catn("<<markup>>" + paste(sim.generation));', .open = "<<", .close = ">>")
}

slim_gen_output_code_one <- function(output_type = c("individuals", "genomes", "coordinates", "sexes"),
                                 output_format = c("VCF", "slim_tibble")) {

  output_type <- match.arg(output_type)
  output_format <- match.arg(output_format)

  sampling_code <- dplyr::case_when(output_type == "individuals" & output_format == "VCF" ~ "samp.genomes.outputVCF();",
                                    output_type == "individuals" & output_format == "slim_tibble" ~ "samp.genomes.output();",
                                    output_type == "genomes" & output_format == "VCF" ~ "samp.outputVCF();",
                                    output_type == "genomes" & output_format == "slim_tibble" ~ "samp.genomes.output();",
                                    output_type == "coordinates" ~ "catn(paste(c(samp.x, samp.y)));",
                                    output_type == "sexes" ~ "catn(paste(samp.sex));")

  markup_begin <- glue::glue('cat("{slim_code_markup(output_type, begin = TRUE)}"); catn("{output_format}");')
  markup_end <- glue::glue('catn("{slim_code_markup(output_type, begin = FALSE)}");')
  code_snippet <- paste(markup_begin, sampling_code, markup_end)

  code_snippet

}


#' Title
#'
#' @param output_type
#' @param output_format
#'
#' @return
#' @export
#'
#' @examples
slim_gen_output_code <- function(output_type = c("individuals", "genomes", "coordinates", "sexes"),
                                 output_format = c("VCF", "slim_tibble"),
                                 output_sample = 0,
                                 subpops = "all") {


  if(output_sample == 0) {
    output_sample <- "size(inds)"
  }

  if(length(subpops) == 1 & subpops[[1]] == "all") {
    subpops <- "sim.subpopulations"
  } else {
    subpops <- paste0('c("', paste(subpops, collapse = '", "'), '")')
  }

  if(length(output_type) == 1) {
    if(output_type == "genomes") {
      setup_code <- glue::glue("ps = <<subpops>>; inds = ps.individuals; inds = inds.genomes; nsamp = min(<<output_sample>>, size(inds)); samp = sample(inds, nsamp);",
                               .open = "<<", .close = ">>")
    } else {
      setup_code <- glue::glue("ps = <<subpops>>; inds = ps.individuals; nsamp = min(<<output_sample>>, size(inds)); samp = sample(inds, nsamp);",
                               .open = "<<", .close = ">>")
    }
  } else {
    if(any(output_type == "genomes")) {
      stop("I'm afraid slimr currently only allows outputting genomes by themselves.")
    }
    setup_code <- glue::glue("ps = <<subpops>>; inds = ps.individuals; nsamp = min(<<output_sample>>, size(inds)); samp = sample(inds, nsamp);",
                             .open = "<<", .close = ">>")
  }


  sampling_code <- purrr::map2(output_type, output_format,
                               ~slim_gen_output_code_one(.x, .y))

  code_snippet <- paste(setup_code, paste(sampling_code, collapse = " "))

  code_snippet

}

#' Title
#'
#' @param code_snippet
#' @param output_every
#' @param auto_bracket
#'
#' @return
#' @export
#'
#' @examples
slim_output_every_code <- function(code_snippet, output_every, auto_bracket = TRUE) {
  if(auto_bracket) {
    code_snippet <- paste0("{", code_snippet, "}")
  }
  glue::glue("if(sim.generation % <<output_every>> == 0) <<code_snippet>>", .open = "<<", .close = ">>")
}

#' Title
#'
#' @param code_snippet
#' @param start_gen
#' @param last_gen
#'
#' @return
#' @export
#'
#' @examples
slim_register_event_code <- function(code_snippet, start_gen = 1, last_gen = NULL, auto_bracket = TRUE) {
  if(auto_bracket) {
    code_snippet <- paste0("{", code_snippet, "}")
  }
  code_bit <- glue::glue("sim.registerLateEvent(NULL, '<<code_snippet>>', start = <<start_gen>>, end = <<last_gen>>);",
                         .open = "<<", .close = ">>")
  code_bit
}

#' Rify some SLiM code
#'
#' Utility code to convert SliM code into a form that can be parsed by R
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
slim_code_SLiMify <- function(code_snippet, prettycode = FALSE) {

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
#'
#' @return
#' @export
#' @examples load_slim_globals(c(p = 4, g = 2))
slim_load_globals <- function(max = 10, sim = TRUE, self = TRUE) {

  if(sim) {
    rlang::env_bind_lazy(rlang::global_env(),
                         sim = SLiMSim)
  }

  if(self) {
    rlang::env_bind_lazy(rlang::global_env(),
                         self = SLiMEidosBlock)
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

  .resources$loaded_globals <- union(.resources$loaded_globals,
                                     as.list(ob_names_all) %>%
                                       purrr::flatten_chr())

  rlang::warn(paste0("slim_load_globals modifies the global environment so please be careful when using this function!\n",
                    "It has assigned values to the following names:\n\n",
                    rlang::format_error_bullets(ob_names),
                    "\n\nIf there were already objects with any of these names in the global environment\nthen their values have been replaced.\n",
                    "Use slim_unload_globals() to remove them."),
              .frequency = "once",
              .frequency_id = "load_slim_globals")

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
#' slim_load_globals(p = 1)
#' slim_unload_globals
slim_unload_globals <- function() {
  rm(list = .resources$loaded_globals, pos = rlang::global_env())
  .resources$loaded_globals <- NULL
}
