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


  ## replace % with %%
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^.])%([^.])",
                                           "\\1%%\\2")

  ## replace mid-expression else with %slimr_else% fake operator
  # code_snippet <- stringr::str_replace_all(code_snippet,
  #                                          "(.*?)else(.*?)",
  #                                          "%slimr_else%")

  ## remove overhanging elses
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "\\}\n[:blank:]*\\Qelse\\E",
                                           "} else")
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           ";[:blank:]*\n[:blank:]*\\Qelse\\E",
                                           " else")
  ## make sure do statements are on their own line (R treats it as a variable then)
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "do[:blank:]*\\{",
                                           "do\n{")
  ## convert return x; to return(x);
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "return[:space:]+(.*?)([;[:space:]])",
                                           "return(\\1)\\2")
  ## replace . with %.% (shim operator)
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^[:digit:]])\\.([^[:digit:]])",
                                           "\\1%.%\\2")
  ## add {..slimr_special..} construct to while statements to make R parse it OK.
  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "(while[:blank:]*\\((.*?)\\))[:blank:]*;",
                                           "\\1{..slimr_special..}")

  code_snippet

}

#' Rify some SLiM code
#'
#' Utility code to convert Rified (via \code{\link(slim_code_Rify)}) SLiM code back to valid SLiM code!
#'
#' @param code_snippet SLiM code to Rify as a character vector
#'
#' @return SLiMified code snippet
slim_code_SLiMify <- function(code_snippet, ansi_aware = FALSE) {

  # code_snippet <- stringr::str_replace_all(code_snippet,
  #                                          stringr::fixed("%slimr_else%"),
  #                                          stringr::fixed("else"))

  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "return\\((.*?)\\)([;[:space:]])",
                                           "return \\1\\2")


  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "[:space:]*%.%[:space:]*",
                                           stringr::fixed("."))

  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "\\{[\n]*[:blank:]*(.*?)\\Q..slimr_special..\\E[[:blank:]\n]*(.*?)\\}",
                                           ";")

  code_snippet <- stringr::str_replace_all(code_snippet,
                                           "([^.])%%([^.])",
                                           "\\1%\\2")


  code_snippet

}

