
#' Run a SLiM script from R
#'
#' This function runs a SLiM script, specified as a \code{slimr_script} object,
#' a character vector, or a text file.
#'
#' @param x
#' @param script_file
#' @param simple_run
#' @param capture_output
#' @param show_output
#' @param slim_path
#' @param callbacks A list of functions to be called during the SLiM run. This can be used to
#' dynamically transform or visualise output from the simulation while it is running. It should
#' be of the form \code{function(data, ...) \{do something..\}}. If using \code{\link[slimrlang]{slimr_output}}
#' to get formatted data output from SLiM, data will be a four column \code{tibble}
#' containing output from the current iteration of the simulation. Columns are:
#' \describe{
#' \item{generation}{A vector of generations processed in the current iteration}
#' \item{name}{Names of the output data.}
#' \item{expression}{The SLiM expression used to generate the output}
#' \item{data}{The raw data output from SLiM as a character vector}
#' }
#' @param vis_callbacks
#' @param ... Additional arguments to be passed to any callback functions.
#'
#' @return A \code{slimr_results} object which has the following components:
#' \describe{
#' \item{output}{A character vector of raw output. Will be NULL if \code{capture_output is \code{FALSE}}}
#' \item{exit_status}{The exit status code returned by the SLiM process. 0 means success.}
#' }
#' @export
#'
#' @examples
slim_run <- function(x, slim_path = NULL,
                     script_file = NULL,
                     simple_run = FALSE,
                     capture_output = TRUE,
                     show_output = !capture_output,
                     callbacks = NULL,
                     vis_callbacks = NULL,
                     ...) {
  UseMethod("slim_run", x)
}

#' @describeIn slim_run Run a SLiM script from character vector
#' @export
slim_run.character <- function(x, ...) {

  if(length(x) > 1) {
    warning("Input has more than one element. Concatenating them with newline separators...")
    x <- paste(x, collapse = "\n")
  }

  slim_run_script(x, ...)

}

#' @describeIn slim_run Run a SLiM script from slimr_script object
#' @export
slim_run.slimr_script <- function(x, ...) {

  script <- as_slim_text(x)
  end_gen <- attr(x, "script_info")$end_gen
  slim_run_script(script, end_gen = end_gen, ...)

}

slim_run_script <- function(script_txt,
                            slim_path = NULL,
                            script_file = NULL,
                            simple_run = FALSE,
                            capture_output = TRUE,
                            show_output = FALSE,
                            end_gen = NULL,
                            vis_callbacks = NULL,
                            callbacks = NULL,
                            ...) {

  platform <- get_os()

  if(is.null(script_file)) {
    script_file <- tempfile(fileext = ".txt")
  }

  slimr_write(script_txt, script_file)

  if(platform == "windows") {
    script_file <- convert_to_wsl_path(script_file)
  }

  slim_p <- setup_slim_process(script_file, slim_path, platform, simple_run)

  on.exit({
    try(slim_p$kill(), silent = TRUE)
  }, add = TRUE)

  pb <- progress::progress_bar$new(format = ":spin SLiM running.. Time Elapsed: :elapsedfull",
                                   clear = FALSE,
                                   total = NA,
                                   width = 60,
                                   show_after = 0)

  simple_pb <- TRUE

  all_output <- list()
  output_data <- list()
  leftovers <- NULL
  out_i <- 0L
  data_i <- 0L
  not_finished <- TRUE

  while(slim_p$is_alive() || not_finished) {

    if(!slim_p$is_alive()) {
      not_finished <- FALSE
    }

    slim_p$poll_io(10000)

    out_lines <- c(leftovers, slim_p$read_output_lines())

    leftovers <- NULL

    if(simple_run) {
      pb$tick(0)
      if(length(out_lines) > 0) {
        if(show_output) {
          pb$message(paste(out_lines, collapse = "\n"))
        }
        if(capture_output) {
          out_i <- out_i + 1L
          all_output[[out_i]] <- out_lines
        }
      }
      pb$tick()
    } else {


      if(length(out_lines) > 0) {

        output_list <- slim_process_output(out_lines)

        if(!is.null(output_list$data)) {
          data_i <- data_i + 1L
          output_data[[data_i]] <- output_list$data
          pb <- slim_update_progress(output_list, pb, show_output, simple_pb, end_gen)
          if(simple_pb) {
            simple_pb <- FALSE
          }
        }

        if(capture_output) {
          if(length(output_list$extra_out) > 0) {
            out_i <- out_i + 1L
            all_output[[out_i]] <- output_list$extra_out
          }
        }

        leftovers <- output_list$leftovers

      }
    }
  }


  exit <- slim_p$get_exit_status()

  slim_cleanup(slim_p, pb = pb, simple_pb)

  message("\n\nSimulation finished with exit status: ", exit)

  res <- list()
  res$output <- do.call(c, all_output)
  res$exit_status <- exit
  res$output_data <- dplyr::bind_rows(output_data)

  invisible(res)

}

setup_slim_process <- function(script_file, slim_path = NULL, platform = get_os(), simple_run = FALSE) {
  if(is.null(slim_path)) {
    slim_call <- get_slim_call()
  } else {
    if(platform == "windows") {
      slim_call <- list(call = "bash", args = c("-c", paste0('"', slim_path,
                                                             ' {script_file}"')))
    } else {
      slim_call <- list(call = slim_path, args = "{script_file}")
    }
  }

  slim_call$args <- purrr::map_chr(slim_call$args,
                                   ~glue::glue(.x))

  if(simple_run) {

    slim_p <- processx::process$new(slim_call$call, slim_call$args,
                                    stdout = "|", stderr = "2>&1",
                                    windows_verbatim_args = TRUE,
                                    windows_hide_window = TRUE)

  } else {
    slim_p <- processx::process$new(slim_call$call, slim_call$args,
                                    stdout = "|", stderr = "|",
                                    windows_verbatim_args = TRUE,
                                    windows_hide_window = TRUE)
  }

  slim_p

}

slim_process_output <- function(out, data_only = FALSE) {

  out_all <- paste(out, collapse = "\n")

  dat <- stringr::str_match_all(out_all,
                                stringr::regex("<slimr_out:start>(.*?)<slimr_out:end>",
                                               dotall = TRUE))[[1]][ , 2]

  if(length(dat) > 0) {
    df <- readr::read_csv(dat,
                          col_names = c("generation", "name", "expression", "data"),
                          quote = "\'",
                          col_types = "iccc")
  } else {
    df <- NULL
  }

  if(!data_only) {

    pre <- stringr::str_match_all(out_all,
                                  stringr::regex("^((?:(?!<slimr_out:start>).)*)<slimr_out:start>",
                                                 dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()


    inter <- stringr::str_match_all(out_all,
                                    stringr::regex("<slimr_out:end>(.*?)<slimr_out:start>",
                                                   dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()

    post <- stringr::str_match_all(out_all,
                                   stringr::regex("<slimr_out:end>((?:(?!<slimr_out:end>).)*)$",
                                                  dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()

    return(list(data = df, leftovers = post, extra_out = c(pre, inter)))

  } else {

    return(df)

  }

}


slim_update_progress <- function(output_list, pb, show_output, simple_pb, end_gen) {
  if(simple_pb) {
    pb <- progress::progress_bar$new("[:bar] :spin Generation: :current/:total (:percent) Estimated time to completion: :eta",
                                     total = end_gen,
                                     clear = FALSE,
                                     show_after = 0)
    pb$tick(0)

  }

  current_gen <- max(output_list$data$generation)

  pb$update(current_gen / end_gen)


  if(show_output) {
    pb$message(paste(output_list$extra_out, collapse = "\n"))
  }

  invisible(pb)

}

slim_cleanup <- function(slim_p, pb, simple_pb) {

  if(!simple_pb) {
    if(!pb$finished) {
      pb$update(1)
    }
  }

  pb$terminate()

  slim_p$kill()

  invisible()
}
