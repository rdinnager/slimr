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
#' @param slim_script_text A character vector of length 1 giving the full SLiM script to convert to a \code{slim_script} object
#'
#' @return A \code{slim_script} object.
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
  blocks <- stringr::str_replace_all(blocks, "//(.*?)(\\n|$)", "")

  heads <- stringr::str_match(blocks[], "([\\S\\s]*?)\\{")[ , 2]
  heads <- gsub("\n", "", heads, fixed = TRUE)
  start_nums <- stringr::str_extract(heads, "^(\\d+)")
  end_nums <- stringr::str_match(heads, ":(\\d+)")[ , 2]
  max_num <- max(c(start_nums, end_nums), na.rm = TRUE)
  has_colon <- grepl(":", heads, fixed = TRUE)
  end_nums <- ifelse(has_colon & is.na(end_nums), max_num, end_nums)

  block_names <- paste0("s", stringr::str_pad(seq_along(blocks),
                                              nchar(trunc(n_blocks)),
                                              pad = "0"))

  blocks <- stringr::str_trim(blocks)
  block_list <- stringr::str_split(blocks, stringr::fixed("\n"))
  names(block_list) <- block_names

  res <- list(code_blocks = block_list,
              start_gens = start_nums,
              end_gens = end_nums,
              colons = has_colon)

  class(res) <- "slim_script"

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
slim_find_block_1 <- function(slim_script) {
  block_1 <- which(slim_script$start_gens == 1 & !slim_script$colons)
  if(length(block_1) == 0) {
    block_1 <- ""
  } else {
    block_1 <- names(slim_script$code_blocks)[block_1]
  }
  block_1
}

slim_modify_block_code <- function(slim_script, block, what = NULL, where = NULL) {


  block_end <- length(slim_script$code_blocks[[block]] == "}")

  if(inherits(where, "character")) {
    where <- dplyr::case_when(where == "end" ~ block_end,
                              where == "start" ~ 1L,
                              NA ~ block_end)
  }


}


#' Title
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
print.slim_script <- function(x) {

  string <- purrr::map(x$code_blocks,
                       ~stringr::str_replace_all(.x, "([-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?)",
                                                 "<highlight>crayon::green('\\1')</highlight>"))

  string <- purrr::imap_chr(string,
                            ~purrr::assign_in(.x, 1, paste0("<highlight>crayon::bgBlue('", .y, "')</highlight> ", .x[1])) %>%
                              paste(collapse = "\n")) %>%
    paste(collapse = "\n")


  string <- glue::glue(string, .open = "<highlight>", .close = "</highlight>")

  cat(string)


}
