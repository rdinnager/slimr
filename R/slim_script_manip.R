insert_generation_output <- function(slim_script, line = NULL, start_gen = 1, end_gen = NULL) {
  split_script <- stringr::str_split(slim_script, "\n")[[1]]

  script_len <- length(split_script)
  if(is.null(line)) {
    line <- script_len
  }

  output_lines <- glue::glue('<<start_gen>>:<<end_gen>> late() { cat("generation: " + paste(sim.generation) + "\\n"); }', .open = "<<", .close = ">>")

  if(line >= script_len) {
    new_script <- c(split_script, output_lines) %>%
      paste(collapse = "\n")
  } else {
    new_script <- c(split_script[1:line], output_lines, split_script[(line + 1):script_len]) %>%
      paste(collapse = "\n")
  }

  new_script
}
