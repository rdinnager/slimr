#' Title
#'
#' @param slim_script A character vector (of length 1) containing the SLiM script to run
#' @param slim_path
#' @param .progress
#' @param output_every
#' @param write_data_live
#' @param log_output_to
#'
#' @return
#' @export
#'
#' @examples
slim_run_script <- function(slim_script = NULL, script_file = NULL, slim_path = NULL, output = NULL, output_every = NULL, output_sample = NULL, .progress = TRUE, write_data_live = FALSE, log_output_to = NULL) {

  if(is.null(slim_script) & is.null(script_file)) {
    stop("One of slim_script or script_file must be specified")
  }

  on.exit({
        try(slim_p$kill(), silent = TRUE)
      }, add = TRUE)

  if(is.null(slim_path)) {
    slim_path <- slimr:::get_slim_call()
  }

  if(inherits(slim_script, "character") | (is.null(slim_script) & !is.null(script_file))) {

    if(!inherits(slim_script, "character")) {

    } else {
      if(length(slim_script) > 1) {
        warning("slim_script has more than one element. We will concatenate them with newline separators...")
      }
      slim_script <- paste(slim_script, collapse = "\n")
    }

    if(!is.null(output)) {
      warning("Sorry, no slimr output is available when running scripts as a character object or from a script file.
              output parameters ignored. You will only see output if the SLiM script itself produces output.
              If you'd like slimr to track output for you, please convert to a slim_script object first,
              via slimr::slim_script_from_text()")
    }

    if(inherits(slim_script, "character")) {
      script_file <- tempfile(fileext = ".txt")
      readr::write_file(slim_script, script_file)
    }
    if(slimr:::get_os() == "windows") {
      script_file <- convert_to_wsl_path(script_file)
    }


    if(interactive()) {
      pb <- progress::progress_bar$new(
        format = ":spin",
        clear = FALSE, total = NA, width = 3)
    }


    slim_p <- processx::process$new(normalizePath(slim_path), script_file,
                                    stdout = "|", stderr = "2>&1")

    while(slim_p$is_alive()) {
      out <- slim_p$read_output_lines()
      if(length(out) > 0) {
        cat("\r   \r")
        cat(out, sep = "\n")
      } else {
        if(interactive()) {
          pb$tick(0)
        }
      }
    }

    if(interactive()) {
      cat("\r   \r")
      pb$terminate()
    }

    exit <- slim_p$get_exit_status()

    cat("Simulation finished with exit status: ", exit)

    slim_p$kill()

    return(exit)


  } else {

    if(inherits(slim_script, "slim_script")) {
      if(!is.null(output)) {
        block_1 <- slim_find_block_1(slim_script)
        slim_script <- slim_modify_block_code(slim_script, block_1, what = "stuff", where = "end")
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
    } else {
      stop("Sorry, slim_script must be a character or slim_script object or script_file must be specified.")
    }

  }
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
