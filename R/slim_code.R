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
    markup <- "<slimr_output:generation_start>"
  } else {
    markup <- "<slimr_output:generation_end>"
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
slim_gen_output_code <- function(output_type = c("individuals", "genomes"),
                                 output_format = c("VCF", "slim_tibble"),
                                 output_sample = 0) {

  output_type <- match.arg(output_type)
  output_format <- match.arg(output_format)

  if(output_sample == 0) {

  } else {

  }

  glue::glue('catn("<<markup>>" + paste(sim.generation));', .open = "<<", .close = ">>")

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
