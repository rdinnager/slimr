#' Title
#'
#' @param last_gen
#'
#' @return
#' @export
#'
#' @examples
slim_output_gens_code <- function(last_gen = NULL) {

  code_bit <- glue::glue('{catn("generation: " + paste(sim.generation));}', .open = "<<", .close = ">>")
  if(!is.null(last_gen)) {
    code_bit <- glue::glue("sim.registerLateEvent(NULL, '<<code_bit>>', start = 1, end = <<last_gen>>);",
                           .open = "<<", .close = ">>")
  }

  code_bit
}
