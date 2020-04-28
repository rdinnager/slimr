#' Run a SLiM script and optionally return output from it to R.
#'
#' @param slim_script This can either be a character vector (of length 1) containing the SLiM script to run or a \code{slim_script} object such as created by \code{\link{slim_script_from_text}}. If this is \code{NULL} then you must provide a text file with your script in \code{script_file}.
#' @param slim_path Path to SLiM executable. If \code{NULL} \code{slimr} will try and find the SLiM executable through default locations or environmental variables. See documentation for \code{\link{slim_setup()}} for details.
#' @param .progress Should a progress bar be displayed while the SLiM script is running?
#' @param output_every How often should R collect output from SLiM? Output will be collected once every \code{output_every} generations.
#' @param write_data_live Should the output being read into R from SLiM be saved as it is running? Use \code{log_output_to} to specify a file to save to.
#' @param log_output_to File path to save output to. Ignored if \code{write_data_live} is \code{FALSE}
#' @param script_file A file path specifying a text file with a valid SLiM script to run. If you specify both this and \code{slim_script}, \code{slim_script} will be run and this parameter will be ignored.
#' @param output What would you like to output from SLiM to R? A character vector containing the names of output to generate. See details for valid output names.
#' @param output_sample When generating output from SLiM, how many samples of the population to take? 0 means sample all extant members of the population.
#' @param output_format In what format should the genomic data be outputted? Valid values are: "VCF", "genlight", or "tibble". Regardless of your choice the genomes will be contained in a list column of the \code{slim_sim} tibble output (named "genomes".
#'
#' @details Valid output names that can be added to the \code{output} parameter include:
#' \itemize{
#'   \item{"genomes"}{"Add this to get output on simulated genomes."}
#'   \item{"individuals}{"Add this for output on individuals, specifically their (two) genomes."}
#'   \item{"coordinates}{"If running a spatially explicit simulation, add this to output spatial coordinates of individuals."}
#' }
#'
#' @return A \code{slim_sim} object with output from the simulation if \code{output} is specified. If \code{output} is not specified or if \code{slim_script} is of class \code{character}, this will be the exit code of the SLiM run (exit code 0 means it ran successfully)
#' @export
#'
#' @examples
slim_run_script <- function(slim_script = NULL, script_file = NULL, slim_path = NULL, output = NULL, output_every = 1, output_sample = NULL, output_format = c("genlight", "slim_tibble", "vcf_tibble"), .progress = TRUE, write_data_live = FALSE, log_output_to = NULL) {

  output_format <- match.arg(output_format)

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

    if(inherits(slim_script, "character")) {
      if(length(slim_script) > 1) {
        warning("slim_script has more than one element. We will concatenate them with newline separators...")
        slim_script <- paste(slim_script, collapse = "\n")
      }
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

    return(invisible(exit))


  } else {

    if(inherits(slim_script, "slim_script")) {

      last_gen <- max(as.numeric(c(slim_script$start, slim_script$end)), na.rm = TRUE)

      if(!is.null(output) | .progress) {
        block_1 <- slim_find_block_starting_at(slim_script, 1L)
        if(!is.null(output)) {
          output_gens <- slim_gen_output_markup_code(begin = TRUE) %+%
            slim_gen_output_markup_code(begin = FALSE) %>%
            slim_output_every_code(output_every) %>%
            slim_register_event_code(1, last_gen)

        } else {
          output_gens <- slim_gen_output_markup_code(begin = TRUE) %+%
            slim_gen_output_markup_code(begin = FALSE) %>%
            slim_output_every_code(output_every) %>%
            slim_register_event_code(1, last_gen)
        }
        slim_script <- slim_modify_block_code(slim_script, block_1, what = output_gens, where = "end")

        if(.progress) {
          fmt <- glue::glue("[:bar] :spin Generation: :current/:total (:percent) Estimated time to completion: :eta") %>%
            as.character()
          pb <- progress::progress_bar$new(format = fmt, total = last_gen,
                                           clear = FALSE, show_after = 0)
        }
      }


      script_file <- tempfile(fileext = ".txt")
      slim_write_script(slim_script, script_file)


      if(slimr:::get_os() == "windows") {
        script_file <- convert_to_wsl_path(script_file)
      }

      if(.progress) {
        pb$tick(0)
      }
      slim_p <- processx::process$new(normalizePath(slim_path), script_file,
                                      stdout = "|", stderr = "|")
      current_gen <- 0
      leftovers <- NULL
      while(slim_p$is_alive()) {
        slim_p$poll_io(10000)
        out <- slim_p$read_output_lines()
        out <- c(leftovers, out)

        if(length(out) > 0){

          lines_started <- stringr::str_which(out, "<slimr_output:generation_start>")
          gens_started <-  unglue::unglue_data(out[lines_started], "<slimr_output:generation_start>{gen_start}")

          lines_ended <- stringr::str_which(out, "<slimr_output:generation_end>")
          gens_ended <-  unglue::unglue_data(out[lines_ended], "<slimr_output:generation_end>{gen_end}")

          finished <- which(gens_ended$gen_end %in% gens_started$gen_start)
          gens_finished <- gens_ended$gen_end[finished] %>% as.integer()

          if(length(lines_ended[finished]) > 0) {
            last_line <- max(lines_ended[finished])

            if(last_line < length(out)) {
              leftovers <- out[(last_line + 1L):length(out)]
            }
          }

          intervals <- cbind(lines_started[finished], lines_ended[finished],
                             lines_ended[finished] - lines_started[finished] - 1L)

          if(any(intervals[ , 3] > 0)) {
            output_this <- purrr::map(purrr::array_branch(intervals, 1),
                                   ~out[(.x[1] - 1L):(.x[2] - 1L)])
            dat_this <- extract_output(output_this)
          }
        }

        if(length(gens_finished) != 0) {

          current_gen <- max(gens_finished)

          if(.progress) {
            pb$update(current_gen/last_gen)
          }
        } else {
          if(.progress) {
            pb$tick(0)
          }
        }
      }

      out <- slim_p$read_output_lines()

      pb$update(1)

      pb$terminate()

      slim_p$read_all_error_lines()

      exit <- slim_p$get_exit_status()

      cat("Simulation finished with exit status: ", exit)

      slim_p$kill()

      return(invisible(exit))

    } else {
      stop("Sorry, slim_script must be a character or slim_script object or script_file must be specified.")
    }

  }
}

#' Title
#'
#' @param slim_script
#'
#' @return
#' @export
#'
#' @examples
as.character.slim_script <- function(x) {
  code <- paste0(ifelse(is.na(x$start), "", x$start),
                 x$colon, ifelse(is.na(x$end), "", x$end),
                 " ",
                 x$callback,
                 " {\n\t\t",
                 purrr::map_chr(x$code, ~paste(.x, collapse = "\n")),
                 "\n}")
  code
}

#' Title
#'
#' @param slim_script
#' @param script_file
#'
#' @return
#' @export
#'
#' @examples
slim_write_script <- function(slim_script, script_file) {

  script <- as.character(slim_script)

  readr::write_lines(script, script_file)

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
