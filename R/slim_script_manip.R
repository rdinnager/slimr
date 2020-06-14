insert_generation_output <- function(slim_script, line = NULL, start_gen = 1, end_gen = NULL) {
  split_script <- stringr::str_split(slim_script, "\n")[[1]]

  script_len <- length(split_script)
  if(is.null(line)) {
    line <- script_len
  }

  output_lines <- glue::glue('\n<<start_gen>>:<<end_gen>> late() { cat("generation: " + paste(sim.generation) + "\\n"); }', .open = "<<", .close = ">>")

  if(line >= script_len) {
    new_script <- c(split_script, output_lines) %>%
      paste(collapse = "\n")
  } else {
    new_script <- c(split_script[1:line], output_lines, split_script[(line + 1):script_len]) %>%
      paste(collapse = "\n")
  }

  new_script
}


#' Title
#'
#' @param slim_script
#'
#' @return
#' @export
#'
#' @examples
slim_find_block_starting_at <- function(slim_script, start_gen) {
  block_1 <- which(slim_script$start == start_gen & slim_script$colon == "")
  if(length(block_1) == 0) {
    block_1 <- ""
  } else {
    block_1 <- slim_script$block_name[block_1]
  }
  block_1
}

slim_script_change_duration <- function(slim_script,
                                        duration) {
  last_gen <- max(as.numeric(c(slim_script$start, slim_script$end)), na.rm = TRUE)
  slim_script$end[which(slim_script$end == last_gen)] <- duration
  slim_script$end[which(slim_script$start == last_gen)] <- duration
  slim_script <- slim_script %>%
    dplyr::mutate(start = ifelse(!is.na(.data$start) &
                                   !is.na(.data$end) &
                                   .data$start > .data$end,
                                 .data$end,
                                 .data$start))
  slim_script
}

#' Add code into a block in a slim_script.
#'
#' @param slim_script \code{slim_script} object to modify
#' @param block Block id to add code into
#' @param what Code to add into script, of class character
#' @param where Where in the block should it be added? Can be either line number, or a character specifying "start" or "end". Default is "end".
#'
#' @return Modified \code{slim_script} object
#' @export
#'
#' @examples
slim_script_add_code <- function(slim_script, block, what = NULL, where = NULL) {

  block_end <- length(slim_script$code[[which(slim_script$block_name == block)]])


  if(inherits(where, "character")) {
    where <- dplyr::case_when(where == "end" ~ block_end,
                              where == "start" ~ 1L,
                              NA ~ block_end)
  }

  slim_script$code[[which(slim_script$block_name == block)]] <-
    append(slim_script$code[[which(slim_script$block_name == block)]], what, where)

  slim_script

}

#' Remove line from a slim_script pertaining to output
#'
#' @param slim_script The \code{slim_script} object to remove output related line from
#' @param no_file_only Should only output to stout be removed, leaving output to files? Note if TRUE, this will only work properly if the script does not construct filenames programmatically.
#'
#' @return A \code{slim_script} object with output related lines removed
#' @export
#'
#' @examples
slim_script_remove_output <- function(slim_script, no_file_only = FALSE) {
   cats_here <- purrr::map(slim_script$code,
                           ~stringr::str_detect(.x, "cat\\(|catn\\(.*\\)"))

   outputs_here <- purrr::map(slim_script$code,
                              ~stringr::str_detect(.x, "output[a-zA-Z]*\\(.*\\)"))


   if(no_file_only) {

     writes_here <- purrr::map(slim_script$code,
                               ~stringr::str_detect(.x, "write[a-zA-Z]*\\(.*\\)"))

     no_files_here <- purrr::map(slim_script$code,
                                 ~!(stringr::str_detect(.x, "output[a-zA-Z]*\\(\"(.*?)\"\\)") |
                                   stringr::str_detect(.x, "write[a-zA-Z]*\\(\"(.*?)\"\\)")))

     outputs_here <- purrr::pmap(list(outputs_here, no_files_here),
                                 ~..1 & ..2)


     all_here <- purrr::pmap(list(cats_here, outputs_here, writes_here),
                             ~..1 | ..2 | ..3)
   } else {
     all_here <- purrr::pmap(list(cats_here, outputs_here),
                             ~..1 | ..2)
   }



   slim_script$code <- purrr::map2(all_here, slim_script$code,
                                  ~{.y[.x] <- ";";.y})

   slim_script
}

slim_script_set_wd <- function(slim_script, slim_wd) {

  replace_wd_output <- function(s, out_key = "output") {
    if(any(stringr::str_detect(s, glue::glue("({out_key}[a-zA-Z]*\\(\")(.*\\/)(.*?)(\",*)")))) {
      file_match <- stringr::str_match(s,
                                       glue::glue("({out_key}[a-zA-Z]*\\(\")(.*\\/)(.*?)(\",*)")) %>%
        na.omit()

      if(nrow(file_match) > 0) {
        for(i in 1:nrow(file_match)) {
          s <- stringr::str_replace_all(s,
                                        stringr::fixed(file_match[i, 3]),
                                        paste0(slim_wd, "/"))

        }
        files_again <- file_match[ , 3:4, drop = FALSE]
      } else {
        files_again <- NULL
      }

      # s <- stringr::str_replace_all(s,
      #                        "(output[a-zA-Z]*\\(\")(.*\\/)(.*?)(\",*)",
      #                        paste0("\\1", slim_wd, "\\/\\3\\4"))
    } else {

      file_match <- stringr::str_match(s,
                                       glue::glue("({out_key}[a-zA-Z]*\\(\")(.*?)(\",*)")) %>%
        na.omit()

      if(nrow(file_match) > 0) {
        for(i in 1:nrow(file_match)) {
          s <- stringr::str_replace_all(s,
                                        stringr::fixed(file_match[i, 3]),
                                        paste0(slim_wd, "/", file_match[i, 3]))

        }
        files_again <- cbind("", file_match[ , 3, drop = FALSE])
      } else {
        files_again <- NULL
      }
    }
    list(s, files_again)
  }

  to_replace <- purrr::map(slim_script$code,
             ~replace_wd_output(.x))

  new_code <- purrr::map(to_replace,
                         ~.x[[1]])

  files_to_replace <- purrr::map(to_replace,
                                 ~.x[[2]]) %>%
    do.call(rbind, .)

  to_replace <- purrr::map(slim_script$code,
                           ~replace_wd_output(.x, out_key = "write"))

  new_code <- purrr::map(to_replace,
                         ~.x[[1]])

  files_to_replace2 <- purrr::map(to_replace,
                                 ~.x[[2]]) %>%
    do.call(rbind, .)

  files_to_replace <- rbind(files_to_replace, files_to_replace2)

  if(length(files_to_replace) > 0) {
    for(i in 1:nrow(files_to_replace)) {

      new_code <- purrr::map(new_code,
                             ~stringr::str_replace_all(.x,
                                           stringr::fixed(paste0(files_to_replace[i, 1],
                                                                 files_to_replace[i, 2])),
                                           stringr::fixed(paste0(slim_wd,
                                                                 "/",
                                                                 files_to_replace[i, 2])))
      )
    }

  }
  slim_script$code <- new_code

  slim_script
  # stringr::str_replace_all(slim_script$code[[3]],
  #                          "(output[a-zA-Z]*\\(\"[/]*)(.*?)(\",*)",
  #                          paste0("\\1", slim_wd, "\\3"))
  #
  #
  # stringr::str_match_all(slim_script$code[[3]],
  #                          "(output[a-zA-Z]*\\(\")(.*\\/)(.*?)(\",*)")
}

#' Print a slim_script object with highlighting
#'
#' @param x slim_script object to print.
#'
#' @return The formatted string (invisibly)
#' @export
#'
#' @examples
#' print(slimr::slim_get_recipe() %>% slimr::slim_script_from_text())
print.slim_script <- function(x, ...) {

  code <- purrr::map(x$code,
                     ~slim_code_Rify(.x))
  code_pretty <- purrr::map(code,
                            ~prettycode::highlight(.x))
  code_pretty <- purrr::map(code_pretty,
                            ~slim_code_SLiMify(.x))
  x$code <- code_pretty
  string <- as.character(x)

  # string <- purrr::map(code,
  #                      ~stringr::str_replace_all(.x, "([-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?)",
  #                                                "<highlight>crayon::green('\\1')</highlight>"))

  names(string) <- x$block_name

  string <- purrr::imap_chr(string,
                            ~purrr::assign_in(.x, 1, paste0("<highlight>crayon::bold$bgCyan('", .y, "')</highlight> ", .x[1])) %>%
                              paste(collapse = "\n")) %>%
    paste(collapse = "\n")


  string <- glue::glue(string, .open = "<highlight>", .close = "</highlight>")

  cat(string)

  return(invisible(string))


}

slim_script_is_valid <- function(slim_script) {
  class_correct <- inherits(slim_script, "slim_script")
  if(!class_correct) {
    stop('The input is not of class "slim_script", which is required')
  }
  istibble <- inherits(slim_script, "tbl_df")
  if(!istibble) {
    stop('The format of the input appears to be corrupted, as it does not inherit from tbl_df')
  }

  has_correct_columns <- sets_equal(colnames(slim_script), c("block_name",
                                                             "block_id",
                                                            "start",
                                                            "colon",
                                                            "end",
                                                            "callback",
                                                            "code"))
  if(!has_correct_columns) {
    stop('Input does not have the correct elements to be a "slim_script" object')
  }

  return(invisible(TRUE))

}
