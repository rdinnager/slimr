
#' Run a SLiM script from R
#'
#' This function runs a SLiM script, specified as a \code{slimr_script} object,
#' a character vector, or a text file.
#'
#' @param x Object containing script to run (e.g. a character vector or a slimr_script object)
#' @param script_file If the script you want to run is in a text file, you can add the pather here. If this is
#' argument is not \code{NULL} argument \code{x} will be ignored
#' @param simple_run Whether to do a "simple run", which just runs the script, capturing all output is \code{capture_output}
#' is \code{TRUE} and additionally sending all output to the R console if \code{show_output} is \code{TRUE}
#' the script to the R console if show_output is TRUE
#' @param capture_output If \code{TRUE}, output from the script will be captured and included in the returned object. Unless
#' \code{keep_all_output} is \code{TRUE}, only non-data output will be kept (e.g. output not produced by a \code{slimr_output}
#' call)
#' @param keep_all_output If there is data produced by \code{slimr_output} calls, should it be captured as well? Ignored if
#' \code{capture_output} is not \code{TRUE}
#' @param show_output Should output from the script be sent to the R console? Note that SLiM scripts can sometimes produce a
#' large amount of output, which could overwhelm the console if you are not careful, potentially locking it up. Be careful
#' with this option if you are using any of SLiM's output functions that output genomic data. This can be handy though
#' for simply status print outs..
#' @param slim_path Path to the SLiM executable. If left \code{NULL} \code{slimr} will attempt to automatically determine
#' it, typically by examining environmental variables.
#' @param callbacks A list of functions to be called during the SLiM run. This can be used to
#' dynamically transform or visualise output from the simulation while it is running. It should
#' be of the form \code{function(data, ...) \{do something..\}}. If using \code{\link{slimr_output}}
#' to get formatted data output from SLiM, data will be a four column \code{tibble}
#' containing output from the current iteration of the simulation. Columns are:
#' \describe{
#' \item{generation}{A vector of generations processed in the current iteration}
#' \item{name}{Names of the output data.}
#' \item{expression}{The SLiM expression used to generate the output}
#' \item{data}{The raw data output from SLiM as a character vector}
#' }
#' @param new_grdev Should a new graphics device window be opened on RStudio? This is mainly useful if you are using
#' custom callbacks that generate live figures, and want a faster plotting experience. This is because the
#' default plot viewer in RStudio can be quite slow. Setting this to \code{TRUE} also allows \code{record_graphics} to work.
#' @param record_graphics An optional character string specifying a file to record video output from the graphics device.
#' If you have custom graphics output for the simulation this lets you record that output live, saving the trouble of producing
#' separate animations after the simulation is complete (also allowing you to save memory because you don't need to keep the
#' entire simulation output to make a post-hoc animation).
#' @param rec_args An optional list containing named arguments to be passed to \code{\link[av]{av_capture_graphics}} for graphics recording.
#' Ignored if \code{record_graphics} is not \code{TRUE}.
#' @param ... Additional arguments to be passed to or from other methods.
#' @param cb_args Additional arguments to be passed to any callback functions. Should be a named
#' list where the names refer to the callback's arguments.
#' @param parallel If \code{x} is a \code{slimr_script_coll}, should the elements in \code{x}
#' be run in parallel. For this to work, you must have setup a parallel plan using \code{\link[future]{plan}}
#' @param progress Should a progress bar be displayed?
#' @param throw_error Should an error be thrown in R is an error is encountered in SLiM?
#' If \code{FALSE}, the error message from SLiM is stored in the object returned
#' by \code{slim_run}, but execution continues in R. Setting this to \code{TRUE} is useful
#' in a script if subsequent code assumes that the simulation finished successfully.
#'
#' @return A \code{slimr_results} object which has the following components:
#' \describe{
#' \item{output}{A character vector of raw output. Will be NULL if \code{capture_output is \code{FALSE}}}
#' \item{exit_status}{The exit status code returned by the SLiM process. 0 means success.}
#' }
#' @export
#'
slim_run <- function(x, slim_path = NULL,
                     script_file = NULL,
                     simple_run = FALSE,
                     capture_output = "file",
                     keep_all_output = FALSE,
                     show_output = FALSE,
                     callbacks = NULL,
                     cb_args = NULL,
                     new_grdev = FALSE,
                     record_graphics = "",
                     rec_args = NULL,
                     parallel = FALSE,
                     progress = FALSE,
                     throw_error = FALSE,
                     ...) {
  UseMethod("slim_run", x)
}

#' @describeIn slim_run Run a SLiM script from character vector
#' @export
slim_run.character <- function(x, slim_path = NULL,
                               script_file = NULL,
                               simple_run = FALSE,
                               capture_output = "file",
                               keep_all_output = FALSE,
                               show_output = FALSE,
                               callbacks = NULL,
                               cb_args = NULL,
                               new_grdev = FALSE,
                               record_graphics = "",
                               rec_args = NULL,
                               parallel = FALSE,
                               progress = FALSE,
                               throw_error = FALSE,
                               ...) {

  assert_slim_installed()

  if(length(x) > 1) {
    rlang::warn("Input has more than one element. Concatenating them with newline separators...")
    x <- paste(x, collapse = "\n")
  }

  slim_run_script(x, slim_path = slim_path,
                  script_file = script_file,
                  simple_run = simple_run,
                  capture_output = capture_output,
                  keep_all_output = keep_all_output,
                  show_output = show_output,
                  callbacks = callbacks,
                  cb_args = cb_args,
                  new_grdev = new_grdev,
                  record_graphics = record_graphics,
                  rec_args = rec_args,
                  parallel = parallel,
                  progress = progress,
                  throw_error = throw_error,
                  ...)

}

#' @describeIn slim_run Run a SLiM script from slimr_script object
#' @export
slim_run.slimr_script <- function(x, slim_path = NULL,
                                  script_file = NULL,
                                  simple_run = FALSE,
                                  capture_output = "file",
                                  keep_all_output = FALSE,
                                  show_output = FALSE,
                                  callbacks = NULL,
                                  cb_args = NULL,
                                  new_grdev = FALSE,
                                  record_graphics = "",
                                  rec_args = NULL,
                                  parallel = FALSE,
                                  progress = FALSE,
                                  throw_error = FALSE,
                                  ...) {

    assert_slim_installed()

    if(!attr(x, "script_info")$rendered) {
      rlang::inform("slimr_script is unrendered. Trying to render now...")
      x <- slim_script_render(x)
    }

    script <- as_slim_text(x)
    end_gen <- attr(x, "script_info")$end_gen
    output_info <- attr(x, "slimr_output")

    if(any(!is.na(output_info$file_name))) {
      save_to_file <- output_info %>%
        dplyr::select(.data$output_name, .data$file_name, .data$format) %>%
        tidyr::drop_na(.data$file_name)
    } else {
      save_to_file <- NULL
    }

    slim_run_script(script, end_gen = end_gen,
                    slim_path = slim_path,
                    script_file = script_file,
                    simple_run = simple_run,
                    capture_output = capture_output,
                    keep_all_output = keep_all_output,
                    show_output = show_output,
                    callbacks = callbacks,
                    cb_args = cb_args,
                    new_grdev = new_grdev,
                    record_graphics = record_graphics,
                    rec_args = rec_args,
                    parallel = parallel,
                    progress = progress,
                    save_to_file = save_to_file,
                    throw_error = throw_error,
                    ...)

}

#' @describeIn slim_run Run a SLiM script from slimr_script object
#' @export
slim_run.slimr_script_coll <- function(x, slim_path = NULL,
                                       script_file = NULL,
                                       simple_run = FALSE,
                                       capture_output = "file",
                                       keep_all_output = FALSE,
                                       show_output = FALSE,
                                       callbacks = NULL,
                                       cb_args = NULL,
                                       new_grdev = FALSE,
                                       record_graphics = "",
                                       rec_args = NULL,
                                       parallel = FALSE,
                                       progress = FALSE,
                                       throw_error = FALSE,
                                       ...) {

  assert_slim_installed()
  assert_package("future")
  assert_package("furrr")

  # arg_list <- dplyr::tibble(x = x,
  #                           slim_path = slim_path,
  #                           script_file = script_file,
  #                           simple_run = simple_run,
  #                           capture_output = capture_output,
  #                           keep_all_output = keep_all_output,
  #                           show_output = show_output,
  #                           callbacks = callbacks,
  #                           cb_args = cb_args,
  #                           new_grdev = new_grdev,
  #                           parallel = parallel,
  #                           progress = FALSE) %>%
  #   purrr::transpose()

  if(parallel) {
    # all_results <- furrr::future_map(arg_list,
    #                                  ~suppressMessages(do.call(slim_run, .x)),
    #                                  .progress = progress,
    #                                  .options = furrr::future_options(globals = FALSE,
    #                                                                   lazy = TRUE))
    all_results <- furrr::future_map(x,
                                     ~suppressMessages(slim_run(.x,
                                               slim_path = slim_path,
                                               script_file = script_file,
                                               simple_run = simple_run,
                                               capture_output = capture_output,
                                               keep_all_output = keep_all_output,
                                               show_output = show_output,
                                               callbacks = callbacks,
                                               cb_args = cb_args,
                                               new_grdev = new_grdev,
                                               record_graphics = record_graphics,
                                               rec_args = rec_args,
                                               parallel = parallel,
                                               progress = FALSE,
                                               throw_error = throw_error,
                                               ...)),
                                     .progress = progress,
                                     .options = furrr::furrr_options(globals = FALSE,
                                                                     seed = TRUE))
  } else {
    all_results <- purrr::map(x,
                               ~suppressMessages(slim_run(.x,
                                         slim_path = slim_path,
                                         script_file = script_file,
                                         simple_run = simple_run,
                                         capture_output = capture_output,
                                         keep_all_output = keep_all_output,
                                         show_output = show_output,
                                         callbacks = callbacks,
                                         cb_args = cb_args,
                                         new_grdev = new_grdev,
                                         record_graphics = record_graphics,
                                         rec_args = rec_args,
                                         parallel = parallel,
                                         progress = progress,
                                         throw_error = throw_error,
                                         ...)))
  }

  class(all_results) <- "slimr_results_coll"
  all_results

}

slim_run_script <- function(script_txt,
                            slim_path = NULL,
                            script_file = NULL,
                            simple_run = FALSE,
                            capture_output = "file",
                            keep_all_output = FALSE,
                            show_output = FALSE,
                            end_gen = NULL,
                            callbacks = NULL,
                            cb_args = NULL,
                            new_grdev = FALSE,
                            record_graphics = "",
                            rec_args = NULL,
                            parallel = FALSE,
                            progress = !parallel,
                            save_to_file = NULL,
                            throw_error = FALSE,
                            ...) {


  platform <- get_os()

  process_during <- progress || !is.null(callbacks) || !is.null(save_to_file) || simple_run

  if(new_grdev) {
    assert_package("grDevices")
    grDevices::dev.new(noRStudioGD = TRUE)
  }

  file_out <- FALSE
  if(is.character(capture_output)) {
    conn <- capture_output
    capture_output <- TRUE
    if(conn != "|") {
      file_out <- TRUE
      if(conn == "file") {
        conn <- tempfile(fileext = ".txt")
      }
    }
  } else {
    if(capture_output) {
      conn <- "|"
    }
  }

  if(is.null(script_file)) {
    script_file <- tempfile(fileext = ".txt")
  }

  slimr_write(script_txt, script_file)

  # if(platform == "windows") {
  #   script_file <- convert_to_wsl_path(script_file)
  # }

  slim_p <- setup_slim_process(script_file, slim_path, platform, simple_run, conn = conn)

  on.exit({
    try(slim_p$kill(), silent = TRUE)
  }, add = TRUE)

  if(progress) {
    pb <- progress::progress_bar$new(format = ":spin SLiM running.. Time Elapsed: :elapsedfull",
                                     clear = FALSE,
                                     total = NA,
                                     width = 60,
                                     show_after = 0)
  }

  simple_pb <- TRUE

  all_output <- list()
  output_data <- list()
  leftovers <- NULL
  out_i <- 0L
  data_i <- 0L
  not_finished <- TRUE
  data_bound <- dplyr::tibble(NULL)
  cb_every <- 1L
  last_bound <- 0L
  gens_past <- 0

  if(file_out) {
    curr_line <- 0L
  }

  while(slim_p$is_alive() || not_finished) {

    if(slim_p$is_alive()) {

      if(file_out) {
        # out_lines <- readr::read_lines(conn, skip = curr_line, lazy = FALSE,
        #                                progress = FALSE)
        if(process_during) {
          out_lines <- read_out_lines(conn, skip = curr_line)
        }
      } else {
        slim_p$poll_io(10000)
        out_lines <- c(leftovers, slim_p$read_output_lines())
      }

    } else {

      not_finished <- FALSE
      if(file_out) {
        # out_lines <- readr::read_lines(conn, skip = curr_line, lazy = FALSE,
        #                                progress = FALSE)
        if(process_during) {
          out_lines <- read_out_lines(conn, skip = curr_line)
        }
      } else {
        out_lines <- c(leftovers, slim_p$read_all_output_lines())
      }

    }

    leftovers <- NULL

    if(simple_run) {
      if(progress) {
        pb$tick(0)
      }
      if(length(out_lines) > 0) {

        curr_line <- curr_line + length(out_lines)


        if(show_output) {
          cat("\r                                               \r")
          cat(out_lines, sep = "\n")
        }

        if(capture_output) {
          out_i <- out_i + 1L
          all_output[[out_i]] <- out_lines
        }
        out_lines <- NULL
      }
      if(progress) {
        pb$tick()
      }
    } else {

      if(process_during) {
        if(length(out_lines) > 0) {

          output_list <- slim_process_output(out_lines)

          if(!is.null(output_list$last_line)) {
            curr_line <- curr_line + output_list$last_line
          }

          ## save results so far to file
          if(nrow(output_list$data) > 0 & !is.null(save_to_file)) {
            dat_to_save <- output_list$data %>%
              dplyr::filter(.data$name %in% save_to_file$output_name)
            output_list$data <- output_list$data %>%
              dplyr::filter(!.data$name %in% save_to_file$output_name)
            slim_save_data(dat_to_save, save_to_file)
            if(nrow(output_list$data) == 0) {
              output_list$data <- NULL
            }
          }

          if(nrow(output_list$data) > 0) {
            data_i <- data_i + 1L

            output_data[[data_i]] <- output_list$data

            gen_curr <- max(output_data[[data_i]]$generation)
            gens_past <- gen_curr - gens_past
            if(!is.null(callbacks) && !is.na(gens_past) && !is.null(gens_past) && gens_past > cb_every) {
              data_bound <- dplyr::bind_rows(output_data[(last_bound + 1L):data_i])
              last_bound <- data_i
              gen_past <- gen_curr
              if(!is.null(callbacks)) {
                purrr::walk(callbacks,
                            ~do.call(.x, c(list(data = data_bound),
                                           cb_args)))
              }
            }

            if(progress) {
              pb <- slim_update_progress(output_list, pb, show_output, simple_pb, end_gen)
            }
            if(simple_pb) {
              simple_pb <- FALSE
            }
          }

          if(capture_output) {

            if(keep_all_output) {
              out_i <- out_i + 1L
              all_output[[out_i]] <- out_lines
            } else {
              if(length(output_list$extra_out) > 0) {
                out_i <- out_i + 1L
                all_output[[out_i]] <- output_list$extra_out
              }
            }
          }

          leftovers <- output_list$leftovers
          out_lines <- NULL

        }
      }
    }
  }

  if(!simple_run) {
    if(process_during) {
      final_output <- slim_process_output(leftovers)
      output_data[[data_i + 1L]] <- final_output$data
      if(capture_output) {
        all_output[[out_i + 1L]] <- final_output$extra_out
      }
    } else {
      out <- read_out_lines(conn, skip = 0)
      final_output <- slim_process_output(out)
      output_data[[1]] <- final_output$data
      if(capture_output) {
        if(keep_all_output) {
          all_output[[1]] <- out
        } else {
          all_output[[1]] <- final_output$extra_out
          if(!is.null(final_output$leftovers)) {
            all_output[[2]] <- final_output$leftovers
          }
        }
      }
    }
  }


  exit <- slim_p$get_exit_status()
  if(!simple_run) {
    error <- slim_p$read_all_error_lines()
  } else {
    error <- NULL
  }

  slim_cleanup(slim_p, pb = pb, simple_pb, progress)

  rlang::inform(paste0("\n\nSimulation finished with exit status: ", exit))

  if(exit == 0) {
    rlang::inform("\nSuccess!")
  } else {
    if(throw_error) {
      stop(paste(error, collapse = "\n"))
    } else {
      rlang::warn("\nFailed! Error:\n")
      cat(error, sep = "\n")
    }
  }

  res <- list()
  res$output <- do.call(c, all_output)
  res$exit_status <- exit
  res$output_data <- dplyr::bind_rows(output_data)
  res$process <- slim_p
  res$error <- error

  if(file_out) {
    res$output_file <- conn
  }

  class(res$output_data) <- c("slimr_output_data",
                              class(res$output_data))

  class(res) <- "slimr_results"

  invisible(res)

}

setup_slim_process <- function(script_file, slim_path = NULL, platform = get_os(), simple_run = FALSE, conn = "|") {

  if(is.null(slim_path)) {
    slim_call <- get_slim_call()
  } else {
    if(platform == "windows") {
      #slim_call <- list(call = "wsl", args = c(slim_path, "{script_file}"))
      slim_call <- list(call = slim_path, args = "{script_file}")
    } else {
      slim_call <- list(call = slim_path, args = "{script_file}")
    }
  }

  slim_call$args <- purrr::map_chr(slim_call$args,
                                   ~glue::glue(.x, .envir = list(script_file = script_file)))

  if(simple_run) {

    slim_p <- processx::process$new(slim_call$call, slim_call$args,
                                    stdout = conn, stderr = "2>&1",
                                    windows_verbatim_args = TRUE,
                                    windows_hide_window = TRUE)

  } else {
    slim_p <- processx::process$new(slim_call$call, slim_call$args,
                                    stdout = conn, stderr = "|",
                                    windows_verbatim_args = TRUE,
                                    windows_hide_window = TRUE)
  }

  slim_p

}


# slim_process_output <- function(out, data_only = FALSE) {
#
#   starts <- stringr::str_which(out,
#                                "<slimr_out:start>")
#   ends <- stringr::str_which(out,
#                              "<slimr_out:end>")
#
#   df <- NULL
#   if(length(starts) > 0) {
#     if(length(ends) > 0 && length(ends) <= length(starts)) {
#       dat <- purrr::map2(starts[1:length(ends)], ends,
#                             ~out[(.x + 1L):(.y - 1L)]) %>%
#         purrr::flatten_chr()
#
#       ## fixes issue with read_csv not working with literal data if of length one
#       if(length(dat) == 1) {
#         dat <- paste0(dat, "\n")
#       }
#
#       df <- readr::read_csv(dat,
#                             col_names = c("generation", "name", "expression", "type", "data"),
#                             quote = "\'",
#                             col_types = "icccc")
#     }
#   }
#
#   if(!data_only) {
#
#     if((length(starts) > 0 & length(ends) > 0)) {
#
#       if(starts[1] > 1) {
#         pre <- out[1:(starts[1] - 1L)]
#       } else {
#         pre = character(0)
#       }
#
#       if(length(ends) > 1) {
#         inter <- purrr::map2(ends[1:(length(starts) - 1)], starts[2:length(starts)],
#                              ~out[(.x + 1L):(.y - 1L)]) %>%
#           purrr::flatten_chr()
#       } else {
#         inter <- character(0)
#       }
#
#       if(ends[length(ends)] < length(out)) {
#         post <- out[(ends[length(ends)] + 1L):length(out)]
#       } else {
#         post <- character(0)
#       }
#
#       return(list(data = df, leftovers = post, extra_out = c(pre, inter)))
#
#     } else {
#
#       return(list(data = NULL, leftovers = out, extra_out = character(0)))
#
#     }
#
#
#
#   } else {
#
#     return(df)
#
#   }
#
# }


slim_process_output <- function(out, data_only = FALSE) {

  starts <- stringr::str_which(out,
                               "<slimr_out:start>")
  ends <- stringr::str_which(out,
                             "<slimr_out:end>")

  if(length(starts) > 0) {
    ends <- ends[ends > starts[1]]
    if(length(ends) > 0) {
      starts <- starts[1:length(ends)]
      line_mat <- cbind(starts, ends)
      data_lines <- purrr::map(purrr::array_branch(line_mat, 1),
                               ~(.x[1] + 1L):(.x[2] - 1L)) %>%
        purrr::flatten_int()
      dat <- out[data_lines]

      ## fixes issue with read_csv not working with literal data if of length one
      if(length(dat) == 1) {
        dat <- paste0(dat, "\n")
      }

      df <- readr::read_csv(I(paste0(dat,
                                   "\n", collapse = "")),
                            col_names = c("generation", "name", "expression", "type", "data"),
                            quote = "\'",
                            col_types = "icccc",
                            num_threads = 1,
                            lazy = FALSE,
                            progress = FALSE)

      end_data <- max(data_lines)
      last_line <- end_data + 1L

      if(!data_only) {

        extra_out <- out[1:end_data]
        extra_out <- extra_out[-data_lines]
        if((end_data + 1L) < length(out)) {
          leftovers <- out[(end_data + 2L):length(out)]
        } else {
          leftovers <- character(0)
        }

      } else {

        extra_out <- character(0)
        leftovers <- character(0)

      }

    } else {
      df <- dplyr::tibble()
      extra_out <- character(0)
      leftovers <- character(0)
      last_line <- NULL
    }

  } else {
    df <- dplyr::tibble()
    extra_out <- character(0)
    leftovers <- character(0)
    last_line <- NULL
  }

  return(list(data = df, extra_out = extra_out,
              leftovers = leftovers,
              last_line = last_line))

}



slim_update_progress <- function(output_list, pb, show_output, simple_pb, end_gen) {
  if(simple_pb) {
    pb <- progress::progress_bar$new("[:bar] :spin Gen::current/:total(:percent) Time: past::elapsedfull|left::eta",
                                     total = end_gen,
                                     clear = FALSE,
                                     show_after = 0)
    pb$tick(0)

  }

  current_gen <- max(output_list$data$generation)

  if(!pb$finished) {
    pb$update(current_gen / end_gen)
  }


  if(show_output) {
    pb$message(paste(output_list$extra_out, collapse = "\n"))
  }

  invisible(pb)

}

slim_cleanup <- function(slim_p, pb, simple_pb, progress) {

  if(progress) {
    if(!simple_pb) {
      if(!pb$finished) {
        pb$update(1)
      }
    }

    pb$terminate()
  }

  slim_p$kill()

  invisible()
}

slim_save_data <- function(dat_to_save, save_to_file) {
  purrr::pwalk(save_to_file,
                ~slim_save_data_one(dat_to_save %>%
                                      dplyr::filter(.data$name == ..1),
                                    ..2,
                                    ..3))
}

slim_save_data_one <- function(df, file_name, format) {
  if(format == "csv") {
    readr::write_csv(df, file_name, append = TRUE)
  } else {
    rlang::abort("Only csv format is currently supported")
  }
}

#' Title
#'
#' @param slimr_script A slimr_script object to open in SLiMGUI
#' (or QtSLiM if on Linux or Windows)
#' @param slim_gui_path Full path to SLiMGUI or QtSLiM executable
#'
#' @return Invisibly return the process object used to launch the
#' GUI (for debugging purposes)
#'
#' @export
slim_open <- function(slimr_script,
                      slim_gui_path = Sys.getenv("slim_gui_path")) {


  platform <- get_os()

  script_text <- as_slim_text(slimr_script)
  suppressWarnings(script_file <- tempfile(fileext = ".txt"))
  slimr_write(script_text, script_file)

  # if(platform == "windows") {
  #   script_file <- convert_to_wsl_path(script_file)
  # }

  proc <- processx::run(slim_gui_path, script_file,
                        windows_verbatim_args = TRUE)
  invisible(proc)

}

read_out_lines <- function(conn, skip = curr_line) {
  out_lines <- try(readr::read_lines(conn, skip = skip, lazy = FALSE,
                                 progress = FALSE),
                   silent = TRUE)
  while(inherits(out_lines, "try-error")) {
    out_lines <- try(readr::read_lines(conn, skip = skip, lazy = FALSE,
                                 progress = FALSE),
                     silent = TRUE)
  }
  out_lines

}
