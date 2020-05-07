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

#' Convert a character vector into a slim_script object
#'
#' @param slim_script_text A character vector of length 1 giving the full SLiM script to convert to a \code{slim_script} object
#'
#' @return A \code{slim_script} object, which inherits from [tibble][tibble::tibble-package].
#' @export
#'
#' @examples
slim_script_from_text <- function(slim_script_text) {

  suppressWarnings(
    block_regx <- gregexpr("\\{(?:[^{}]*|(?R))*\\}",
                           slim_script_text,
                           perl = TRUE)
  )

  starts <- block_regx[[1]]
  match_len <- attr(block_regx[[1]], "match.length")
  ends <- starts + match_len
  starts <- c(0, ends[-length(ends)])

  blocks <- purrr::map2_chr(starts, ends, ~substr(slim_script_text, .x, .y))

  n_blocks <- length(blocks)

  ## remove comments
  blocks <- stringr::str_replace_all(blocks, "//([^\"]+?)(\\n|$)", "\n")

  heads <- stringr::str_match(blocks, "([\\S\\s]*?)\\{")[ , 2]
  heads <- stringr::str_remove_all(heads, stringr::fixed("\n"))

  blocks <- stringr::str_trim(blocks)
  blocks <- stringr::str_remove_all(blocks, "^([\\S\\s]*?)\\{")
  blocks <- stringr::str_remove_all(blocks, "\\}$")

  start_nums <- stringr::str_extract(heads, "^(\\d+)")
  end_nums <- stringr::str_match(heads, ":(\\d+)")[ , 2]
  max_num <- max(c(as.numeric(start_nums), as.numeric(end_nums)), na.rm = TRUE)
  has_colon <- grepl(":", heads, fixed = TRUE)
  end_nums <- ifelse(has_colon & is.na(end_nums), as.character(max_num), end_nums)

  block_names <- paste0("s", stringr::str_pad(seq_along(blocks),
                                              nchar(trunc(n_blocks)),
                                              pad = "0"))

  blocks <- stringr::str_trim(blocks)

  ## trick to get styler to work
  blocks <- purrr::map(blocks,
                       ~slim_code_Rify(.x))
  blocks <- purrr::map(blocks,
                       ~styler::style_text(.x, scope = "line_breaks"))

  # blocks <- purrr::map(blocks,
  #                      ~stringr::str_trim(.x))
  blocks <- purrr::map(blocks,
                       ~paste(.x, collapse = "\n"))

  blocks <- purrr::map(blocks,
               ~slim_code_SLiMify(.x))


  blocks <- stringr::str_split(blocks, stringr::fixed("\n"))
  # block_list <- purrr::map(block_list,
  #                          ~.x[.x != ""])

  heads <- stringr::str_remove_all(heads, "^(\\d+)")
  heads <- stringr::str_remove_all(heads, ":(\\d+)")
  heads <- stringr::str_remove_all(heads, "^:")

  res <- dplyr::tibble(block_id = block_names,
                       start = start_nums,
                       colon = ifelse(has_colon, ":", ""),
                       end = end_nums,
                       callback = heads,
                       code = blocks)

  class(res) <- c("slim_script", "tbl_df", "tbl", "data.frame")

  res

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
    block_1 <- slim_script$block_id[block_1]
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

  block_end <- length(slim_script$code[[which(slim_script$block_id == block)]])


  if(inherits(where, "character")) {
    where <- dplyr::case_when(where == "end" ~ block_end,
                              where == "start" ~ 1L,
                              NA ~ block_end)
  }

  slim_script$code[[which(slim_script$block_id == block)]] <-
    append(slim_script$code[[which(slim_script$block_id == block)]], what, where)

  slim_script

}

#' Remove line from a slim_script pertaining to output
#'
#' @param slim_script The \code{slim_script} object to remove output related line from
#' @param no_file_only Should only output to stout be removed, leaving output to files? Note if TRUE, this will only work properly if the script contains arguments named filePath. If filenames are specified using unnamed arguments in SLiM, this function currently fails to keep them.
#'
#' @return A \code{slim_script} object with output related lines removed
#' @export
#'
#' @examples
slim_script_remove_output <- function(slim_script, no_file_only = FALSE) {
   cats_here <- purrr::map(slim_script$code,
                           ~stringr::str_detect(.x, "cat\\(|catn\\(.*\\)"))

   outputs_here <- purrr::map(slim_script$code,
                              ~stringr::str_detect(.x, "output[a-zA-Z]+\\(.*\\)"))


   if(no_file_only) {

     writes_here <- purrr::map(slim_script$code,
                               ~stringr::str_detect(.x, "write[a-zA-Z]+\\(.*\\)"))

     no_files_here <- purrr::map(slim_script$code,
                                 ~!stringr::str_detect(.x, "filePath"))

     outputs_here <- purrr::pmap(list(outputs_here, no_files_here),
                                 ~..1 & ..2)


     all_here <- purrr::pmap(list(cats_here, outputs_here, writes_here),
                             ~..1 | ..2 | ..3)
   } else {
     all_here <- purrr::pmap(list(cats_here, outputs_here),
                             ~..1 | ..2)
   }



   slim_script$code <- purrr::map2(all_here, slim_script$code,
                                  ~.y[!.x])

   slim_script
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

  names(string) <- x$block_id

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

  has_correct_columns <- sets_equal(colnames(slim_script), c("block_id",
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
