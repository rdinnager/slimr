#' Title
#'
#' @param keyword
#' @param begin
#'
#' @return
#' @export
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

  output_type <- match.arg(output_type)
  output_format <- match.arg(output_format)

  if(output_sample == 0) {
    output_sample <- "size(inds)"
  }

  if(length(subpops) == 1 & subpops[[1]] == "all") {
    subpops <- "sim.subpopulations"
  } else {
    subpops <- paste0('c("', paste(subpops, collapse = '", "'), '")')
  }

  if(output_type == "genomes") {
    setup_code <- glue::glue("ps = <<subpops>>; inds = ps.individuals; inds = inds.genomes; nsamp = min(<<output_sample>>, size(inds)); samp = sample(inds, nsamp);",
                             .open = "<<", .close = ">>")
  } else {
    setup_code <- glue::glue("ps = <<subpops>>; inds = ps.individuals; nsamp = min(<<output_sample>>, size(inds)); samp = sample(inds, nsamp);",
                             .open = "<<", .close = ">>")
  }


  sampling_code <- dplyr::case_when(output_type == "individuals" & output_format == "VCF" ~ "samp.genomes.outputVCF();",
                                    output_type == "individuals" & output_format == "slim_tibble" ~ "samp.genomes.output();",
                                    output_type == "genomes" & output_format == "VCF" ~ "samp.outputVCF();",
                                    output_type == "genomes" & output_format == "slim_tibble" ~ "samp.genomes.output();",
                                    output_type == "coordinates" ~ "catn(paste(samp.spatialPosition));",
                                    output_type == "sexes" ~ "catn(paste(samp.sex));")

  markup_begin <- glue::glue('cat("{slim_code_markup(output_type, begin = TRUE)}"); catn("{output_format}");')
  markup_end <- glue::glue('catn("{slim_code_markup(output_type, begin = FALSE)}");')
  code_snippet <- paste(setup_code, markup_begin, sampling_code, markup_end)

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
