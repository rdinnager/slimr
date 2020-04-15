#' Title
#'
#' @param slim_script A character vector (of length 1) containing the SLiM script to run
#'
#' @return
#' @export
#'
#' @examples
slim_run_script <- function(slim_script, slim_path = NULL, asis = TRUE, .progress = TRUE, save_every = 100, write_data_live = FALSE) {

  on.exit({
        try(slim_p$kill(), silent = TRUE)
      }, add = TRUE)

  if(is.null(slim_path)) {
    slim_path <- slimr:::get_slim_call()
  }

  mentioned_gens <- slimr:::get_generation_lines(slim_script)

  print(mentioned_gens)

  if(.progress) {
    last_gen <- max(mentioned_gens$generations)
    print(last_gen)
    slim_script <- slimr:::insert_generation_output(slim_script, end_gen = last_gen)
    pb <- progress::progress_bar$new(format = "[:bar] :spin :current/:total (:percent)", total = last_gen,
                                     clear = FALSE, show_after = 0)
  }

  cat(slim_script)

  script_file <- tempfile(fileext = ".txt")
  readr::write_file(slim_script, script_file)

  if(slimr:::get_os() == "windows") {
    script_file <- convert_to_wsl_path(script_file)
  }

  if(.progress) {
    pb$tick(0)
  }
  slim_p <- processx::process$new(normalizePath(slim_path), script_file,
                                  stdout = "|", stderr = "|")
  current_gen <- 0
  #previous_gen <- 0
  while(slim_p$is_alive()) {
    slim_p$poll_io(10000)
    out <- slim_p$read_output_lines()

    gens <- grep("generation: ", out, value = TRUE) %>%
      readr::parse_number()
    print(gens)
    print(slim_p$is_alive())
    if(length(gens) != 0) {

      current_gen <- max(gens)
      if(.progress) {
        pb$update(current_gen/last_gen)
      }
    } else {
      if(.progress) {
        pb$tick(0)
      }
    }


  }

  gens <- grep("generation: ", out, value = TRUE) %>%
    readr::parse_number()
  if(length(gens) != 0) {
    current_gen <- max(gens)
    if(.progress) {
      pb$update(current_gen/last_gen)
    }
  }

  #pb$terminate


  err <- slim_p$read_all_error_lines()

  slim_p$kill()
  err
}

#' Title
#'
#' @param slim_script_template A slim script with sections enclosed in '<<' and '>>'. Anything between double
#' triangular brackets will be replaced by its corresponding named element in \code{param_list}. For example,
#' '<<x>>' will be replace by the value \code{param_list$x}
#' @param param_list
#'
#' @return
#' @export
#'
#' @examples
slim_run_script_template <- function(slim_script_template, param_list, slim_path = NULL) {

}
