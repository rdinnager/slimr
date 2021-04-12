#' Internal vctrs methods
#'
#' @import vctrs
#' @keywords internal
#' @name slimrlang-vctrs
NULL

#' @export
new_slimr_code <- function(x = list()) {
  assert_valid_code(x)
  new_list_of(x, ptype = character(), class = "slimr_code")
}

#' @export
slimr_code <- function(...) {
  x <- list(...)
  x <- lapply(x, vec_cast, character())
  new_slimr_code(x)
}

#' @export
vec_ptype_full.slimr_code <- function(x, ...) "slimr_code"
#' @export
vec_ptype_abbr.slimr_code <- function(x, ...) "s-code"

#' @export
format.slimr_code <- function(x, ...) {
  format_one <- function(x) {
    if (length(x) == 0) {
      return(prettycode::highlight("{}"))
    } else {
      prettycode::highlight(paste0("{", paste(stringr::str_trim(x), collapse = "; "), "}"))
    }
  }
  purrr::map_chr(x,
                 ~format_one(.x))
}

#' @export
obj_print_data.slimr_code <- function(x, ...) {
  if (length(x) == 0)
    return()
  cat(format(x))
}

#' @export
vec_ptype2.slimr_code.slimr_code <- function(x, to, ...) x


#' @export
as.character.slimr_code <- function(x, as_list = FALSE, ...) {
  if(as_list) {
    unclass(x)
  } else {
    purrr::map_chr(x,
                   ~paste(.x, collapse = "\n"))
  }
}


#' @export
new_slimr_script <- function(block_name = character(),
                             block_id = character(),
                             start_gen = character(),
                             end_gen = character(),
                             callback = character(),
                             code = new_slimr_code(),
                             slimr_output = NULL,
                             slimr_inline = NULL,
                             slimr_template = NULL,
                             slimrlang_orig = NULL,
                             script_info = NULL) {

  vec_assert(block_name, ptype = character())
  vec_assert(block_id, ptype = character())
  vec_assert(start_gen, ptype = character())
  vec_assert(end_gen, ptype = character())
  vec_assert(callback, character())
  vec_assert(code, new_slimr_code())

  new_rcrd(list(block_name = block_name,
                block_id = block_id,
                start_gen = start_gen,
                end_gen = end_gen,
                callback = callback,
                code = code),
           slimr_output = slimr_output,
           slimr_inline = slimr_inline,
           slimr_template = slimr_template,
           slimrlang_orig = slimrlang_orig,
           script_info = script_info,
           class = "slimr_script")
}

#' @export
vec_ptype_full.slimr_script <- function(x, ...) "slimr_script"
#' @export
vec_ptype_abbr.slimr_script <- function(x, ...) "s-scrpt"
#' @export
vec_ptype2.slimr_script.slimr_script <- function(x, y, ...) {
  slimr_output <- dplyr::bind_rows(attr(x, "slimr_output"),
                                   attr(y, "slimr_output"))

  slimr_inline <- dplyr::bind_rows(attr(x, "slimr_inline"),
                                  attr(y, "slimr_inline"))

  slimr_template <- dplyr::bind_rows(attr(x, "slimr_template"),
                                     attr(y, "slimr_template"))

  slimrlang_orig <- NULL

  script_info <- list()
  script_info$end_gen <- max(as.numeric(attr(x, "script_info")$end_gen),
                             as.numeric(attr(y, "script_info")$end_gen),
                             na.rm = TRUE)

  script_info$rendered <- all(attr(x, "script_info")$rendered,
                              attr(y, "script_info")$rendered)

  new_slimr_script(block_name = field(x, "block_name"),
                   block_id = field(x, "block_id"),
                   start_gen = field(x, "start_gen"),
                   end_gen = field(x, "end_gen"),
                   callback = field(x, "callback"),
                   code = field(x, "code"),
                   slimr_output = slimr_output,
                   slimr_inline = slimr_inline,
                   slimr_template = slimr_template,
                   slimrlang_orig = slimrlang_orig,
                   script_info = script_info)
}

#' @export
vec_cast.slimr_script.slimr_script <- function(x, to, ...) {
  slimr_output <- dplyr::bind_rows(attr(x, "slimr_output"),
                                   attr(to, "slimr_output"))

  slimr_inline <- dplyr::bind_rows(attr(x, "slimr_inline"),
                                  attr(to, "slimr_inline"))

  slimr_template <- dplyr::bind_rows(attr(x, "slimr_template"),
                                  attr(to, "slimr_template"))

  slimrlang_orig <- NULL

  script_info <- list()
  script_info$end_gen <- max(as.numeric(attr(x, "script_info")$end_gen),
                             as.numeric(attr(to, "script_info")$end_gen))

  new_slimr_script(block_name = field(x, "block_name"),
                   block_id = field(x, "block_id"),
                   start_gen = field(x, "start_gen"),
                   end_gen = field(x, "end_gen"),
                   callback = field(x, "callback"),
                   code = field(x, "code"),
                   slimr_output = slimr_output,
                   slimr_inline = slimr_inline,
                   slimr_template = slimr_template,
                   slimrlang_orig = slimrlang_orig,
                   script_info = script_info)
}

#' @export
as.character.slimr_script <- function(x, for_script = FALSE, ...) {


  new_code <- as.character(code(x), as_list = TRUE) %>%
    purrr::map(~paste(.x, collapse = "\n"))

  block_names <- vctrs::field(x, "block_name")

  atts <- attributes(x)

  if(any(!is.na(atts$slimr_inline$code_for_slim))) {

    inline_df <- atts$slimr_inline %>%
      dplyr::group_by(.data$block_name)

    inline_list <- inline_df %>%
      dplyr::group_split()

    names(inline_list) <- dplyr::group_keys(inline_df) %>%
      dplyr::pull(.data$block_name)

    inline_list <- inline_list[block_names]


    if(!for_script) {
      replacements <- purrr::map(inline_list,
                                 ~stringr::fixed(.x$code_for_display) %>%
                                   stats::setNames(paste0(".__slmr_inline_object_", seq_along(.x$code_for_display),
                                                   "___")))
    } else {
      replacements <- purrr::map(inline_list,
                                 ~stringr::fixed(.x$code_for_slim) %>%
                                   stats::setNames(paste0(".__slmr_inline_object_", seq_along(.x$code_for_display),
                                                   "___")))
    }


    new_code <- purrr::map2(new_code, replacements,
                            ~ stringr::str_replace_all(.x, .y))

  }

  if(any(!is.na(atts$slimr_output$code_for_slim))) {

    output_df <- atts$slimr_output %>%
      dplyr::group_by(.data$block_name)

    output_list <- output_df %>%
      dplyr::group_split()

    names(output_list) <- dplyr::group_keys(output_df) %>%
      dplyr::pull(.data$block_name)

    output_list <- output_list[block_names]


    if(!for_script) {
      replacements <- purrr::map(output_list,
                                 ~stringr::fixed(.x$code_for_display) %>%
                                   stats::setNames(paste0(".__slmr_output_object_", seq_along(.x$code_for_display),
                                                   "___")))
    } else {
      replacements <- purrr::map(output_list,
                                 ~stringr::fixed(.x$code_for_slim) %>%
                                   stats::setNames(paste0(".__slmr_output_object_", seq_along(.x$code_for_display),
                                                   "___")))
    }


    new_code <- purrr::map2(new_code, replacements,
                            ~ stringr::str_replace_all(.x, .y))

  }

  new_code <- new_code %>%
    purrr::map(~stringr::str_split(.x, "\n")[[1]])

  code <- SLiMify_all(new_code, for_script = for_script)

  code <- fix_integers(code)

  string <- paste0(ifelse(is.na(field(x, "block_id")), "", paste0(field(x, "block_id"), " ")),
                   ifelse(is.na(field(x, "start_gen")), "", field(x, "start_gen")),
                   ifelse(is.na(field(x, "end_gen")), "", paste0(":", field(x, "end_gen"))),
                   " ",
                   field(x, "callback"),
                   " {\n    ",
                   purrr::map_chr(code, ~paste(.x, collapse = "\n    ")),
                   "\n}\n") %>%
    stringr::str_trim("left")


  string
}

#' @export
format.slimr_script <- function(x, add_block_names = TRUE, ...) {

  if(length(x) == 0) {
    return("{}")
  } else {

    string <- as.character(x)

    if(add_block_names) {
      string <- paste0(field(x, "block_name"), ":\n", string)
    }

  }

  string
}

#' @export
obj_print_data.slimr_script <- function(x, add_block_names = TRUE, suppress_cat = FALSE, ...) {
  if (length(x) == 0) {
    return()
  } else {

    string <- format(x, add_block_names)
    if(add_block_names) {
      if (requireNamespace("crayon", quietly = TRUE)) {
        string <- stringr::str_replace_all(string,
                                           "(block_(.*?)\\:)\n",
                                           glue::glue("<<crayon::bold$bgCyan('\\\\1')>>\n",
                                                      .open = "<<",
                                                      .close = ">>"))
      }

    }

    code <- stringr::str_match_all(string,
                                   stringr::regex("\\{\n(.*)\n\\}$", dotall = TRUE))

    prettify_code <- function(code) {
      code <- stringr::str_split(code, "\n")[[1]] %>%
        prettycode::highlight() %>%
        paste(collapse = "\n")
      code
    }

    string <- stringr::str_replace_all(string,
                                       stringr::regex("\\{\n((.*))\n\\}$", dotall = TRUE),
                                       prettify_code)

    if (requireNamespace("crayon", quietly = TRUE)) {
      string <- stringr::str_replace_all(string,
                                         "(\\.\\.[:word:]+\\.\\.)",
                                         crayon::green)
    }

    string <- paste(string, collapse = "\n")

  }
  if(!suppress_cat) {
    cat(string)
  }
  return(invisible(string))

}

#' @export
obj_print_footer.slimr_script <- function(x, ...) {
  slimr_template_attr <- attr(x, "slimr_template")
  if(any(!is.na(slimr_template_attr$var_names))) {
    blocks_w_template <- !is.na(slimr_template_attr$var_names)

    if (requireNamespace("crayon", quietly = TRUE)) {
      template_text <- glue::glue("This slimr_script has templating in block(s)
      {paste(crayon::bold$bgCyan(unique(slimr_template_attr$block_name[blocks_w_template])),
      collapse = ' and ')} for variables
      {paste(crayon::green(slimr_template_attr$var_names[blocks_w_template]),
                                  collapse = ' and ')}.\n") %>%
      stringr::str_wrap()
    } else {
      template_text <- glue::glue("This slimr_script has templating in block(s)
      {paste(unique(slimr_template_attr$block_name[blocks_w_template]),
      collapse = ' and ')} for variables
      {paste(slimr_template_attr$var_names[blocks_w_template],
                                  collapse = ' and ')}.\n") %>%
        stringr::str_wrap()
    }
  } else {
    template_text <- ""
  }

  cat(template_text)
  invisible(template_text)
}

process_code_blocks <- function(slim_script_text) {

  if(length(slim_script_text) > 1) {
    slim_script_text <- paste(slim_script_text,
                              collapse = "\n")
  }

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
  blocks <- slimr_code_remove_comments(blocks)

  heads <- stringr::str_match(blocks, "([\\S\\s]*?)\\{")[ , 2]
  heads <- stringr::str_remove_all(heads, stringr::fixed("\n"))

  blocks <- stringr::str_trim(blocks)
  blocks <- stringr::str_remove_all(blocks, "^([\\S\\s]*?)\\{")
  blocks <- stringr::str_remove_all(blocks, "\\}$")

  block_ids <- stringr::str_extract(heads, "^s(\\d+)")
  heads <- stringr::str_remove_all(heads, "^s(\\d+) ")
  start_nums <- stringr::str_match(heads, "^([:digit:]*e?(?!a)[:digit:]*)[[:space:]:]?")[ , 2]
  start_nums <- stringr::str_trim(start_nums)
  end_nums <- stringr::str_match(heads, ":(\\d+)")[ , 2]
  max_num <- max(c(as.numeric(start_nums), as.numeric(end_nums)), na.rm = TRUE)
  has_colon <- grepl(":", heads, fixed = TRUE)
  if(is.infinite(max_num)) {
    max_num <- ""
  }
  end_nums <- ifelse(has_colon & is.na(end_nums), as.character(max_num), end_nums)

  block_names <- paste0("block_", stringr::str_pad(seq_along(blocks),
                                                   nchar(trunc(n_blocks)),
                                                   pad = "0"))

  block_names[heads == "initialize()"] <- "block_init"

  blocks <- stringr::str_trim(blocks)

  callbacks <- stringr::str_remove_all(heads, "^([:digit:]*e?(?!a)[:digit:]*)")
  callbacks <- stringr::str_remove_all(callbacks, ":(\\d+)")
  callbacks <- stringr::str_remove_all(callbacks, "^:")

  callbacks <- stringr::str_trim(callbacks)

  callbacks[callbacks == ""] <- "early()"

  list(block_names = block_names,
       block_ids = block_ids,
       start_nums = start_nums,
       end_nums = end_nums,
       callbacks = callbacks,
       blocks = blocks,
       max_num = max_num)
}

#' Convert a character vector into a slim_script object
#'
#' @param slim_script_text A character vector giving the full SLiM script to
#' convert to a \code{slimr_script} object. Character vectors with length greater than
#' 1 will be concatenated with newline separators
#'
#' @return A \code{slimr_script} object
#' @export
#'
#' @examples
as_slimr_script <- function(slim_script_text) {

  if(!inherits(slim_script_text, "character")) {
    rlang::abort("as_slimr_script only accepts character arguments")
  }

  c(block_names, block_ids, start_nums, end_nums, callbacks, blocks, max_num) %<-%
    process_code_blocks(slim_script_text)

  ## make code parseable

  code <- slimr_code_Rify_all(blocks)
  code <- slimr_code_from_text_style_all(code)


  code <- purrr::map(code,
                     ~paste(.x, collapse = "\n"))

  code <- purrr::map(code,
                     ~slimr_code_from_text_else_overhang(.x)) %>%
    stringr::str_split(stringr::fixed("\n"))

  code <- new_slimr_code(code)

  script <- new_slimr_script(block_name = block_names,
                             block_id = block_ids,
                             start_gen = start_nums,
                             end_gen = end_nums,
                             callback = callbacks,
                             code = code,
                             script_info = list(end_gen = max_num,
                                                rendered = TRUE))

  script

}


#' @export
get_block <- function(x, i) {
  #vec_assert(x, new_slimr_script())
  vec_slice(x, vec_as_location(i, vec_size(x), names = field(x, "block_name")))
}

#' @export
code <- function(x) {
  field(x, "code")
}

#' @export
`code<-` <- function(x, value) {
  field(x, "code") <- value
}

#' @export
end_gen <- function(x) {
  field(x, "end_gen")
}

#' @export
`end_gen<-` <- function(x, position, value) {
  field(x, "end_gen") <- value
}

#' @export
`modify<-` <- function(x, value, ...) {
  UseMethod("modify<-", x)
}

#' @export
`modify<-.slimr_script` <- function(x, field, position, value) {
  if(field == "end_gen") {
    old_end_gen <- attr(x, "script_info")$end_gen
  }
  field(x, field)[position] <- value
  if(field %in% c("start_gen", "end_gen")) {
    end_gen <- max(as.numeric(c(field(x, "end_gen"), field(x, "start_gen"))), na.rm = TRUE)
    attr(x, "script_info")$end_gen <- end_gen
  }
  if(field == "end_gen") {
    field(x, "start_gen")[field(x, "start_gen") == old_end_gen] <- end_gen
    field(x, "end_gen")[field(x, "end_gen") == old_end_gen] <- end_gen
  }
  x
}

#' Set the duration of a slimr_script
#'
#' @param x slimr_script object to set the duration of
#' @param duration Final generation number to run for this simulation
#'
#' @return A \code{slimr_script} object with new duration
#' @export
#'
#' @examples
slim_script_duration <- function(x, duration) {
  start_gens <- as.numeric(vctrs::field(x, "start_gen"))
  end_gens <- as.numeric(end_gen(x))
  start_gens[start_gens > duration] <- duration
  end_gens[end_gens > duration] <- duration
  vctrs::field(x, "start_gen") <- as.character(start_gens)
  vctrs::field(x, "end_gen") <- as.character(end_gens)
  x

}

#' @export
as_slim_text <- function(x, ...) {
  UseMethod("as_slim_text", x)
}


#' Convert a slimr_script to a length 1 character vector
#'
#' @param x \code{slimr_script} object to convert
#' @param ... Further arguments, passed to or from other methods.
#'
#' @return A length 1 character vector
#' @export
#'
#' @examples
#' slim_script(
#'    slim_block(initialize(),
#'           {
#'             initializeMutationRate(1e-7);
#'             initializeMutationType("m1", 0.5, "f", 0.0);
#'             initializeGenomicElementType("g1", m1, 1.0);
#'             initializeGenomicElement(g1, 0, 99999);
#'             initializeRecombinationRate(1e-8);
#'           }),
#'    slim_block(1,
#'           {
#'             sim.addSubpop("p1", 500);
#'           }),
#'    slim_block(10000,
#'           {
#'             sim.simulationFinished();
#'           })
#') -> script
#'as_slim_text(script)
as_slim_text.slimr_script <- function(x, ...) {
  paste(as.character(x, for_script = TRUE, ...), collapse = "\n")
}

#' Write a slimr_script object to a text file
#'
#' Write a slimr_script object to a text file, which can be run in
#' SLiM as a SLiM script
#'
#' @param x \code{slimr_script} object to write to file
#' @param file File path to write to
#' @param ... Further arguments to be passed to or from other objects
#'
#' @return Returns \code{x}, invisibly
#' @export
#'
#' @examples
#' slim_script(
#'    slim_block(initialize(),
#'           {
#'             initializeMutationRate(1e-7);
#'             initializeMutationType("m1", 0.5, "f", 0.0);
#'             initializeGenomicElementType("g1", m1, 1.0);
#'             initializeGenomicElement(g1, 0, 99999);
#'             initializeRecombinationRate(1e-8);
#'           }),
#'    slim_block(1,
#'           {
#'             sim.addSubpop("p1", 500);
#'           }),
#'    slim_block(10000,
#'           {
#'             sim.simulationFinished();
#'           })
#') -> script
#'temp_file <- tempfile(fileext = ".txt")
#'slimr_write(script, temp_file)
#'readLines(temp_file)
slimr_write <- function(x, file, ...) {
  UseMethod("slimr_write", x)
}

#' @export
slimr_write.slimr_script <- function(x, file, ...) {

  script <- as.character(x)

  writeLines(script, file)

}

#' @export
slimr_write.character <- function(x, file, ...) {

  readr::write_lines(x, file)

}

#' @export
reconstruct <- function(x, ...) {
  UseMethod("reconstruct", x)
}

#' Reconstruct slimrlang code to make this slimr_script
#'
#' This reconstructs a \code{slimrlang} input sequence to regenerate the given \script(slimr_script)
#' object. This is useful if you want to edit the SLiM script to add additional functionality,
#' for example, where you want to incorporate the results of \code{slimrlang}'s internal edits, e.g.
#' such as removing \code{\link{%.%}} special operators, etc. It is also useful when the
#' \code{slimr_script} object has been created from converting a text-based SLiM script, such as when
#' using \code{\link[slimr]{as.slimr_script}} from the \code{slimr} package on a character variable.
#'
#' @param x slimr_script object to reconstruct
#' @param ... Further arguments, passed to or from other methods.
#'
#' @return A character vector of length one containing the reconstructed code.
#' @export
#'
#' @examples
#'slim_script(
#'     slim_block(initialize(),
#'          {
#'               .Init$initializeMutationRate(1e-7);
#'               .Init$initializeMutationType("m1", 0.5, "f", 0.0);
#'               .Init$initializeGenomicElementType("g1", m1, 1.0);
#'               .Init$initializeGenomicElement(g1, 0, 99999);
#'               .Init$initializeRecombinationRate(1e-8);
#'          }),
#'            slim_block(1,
#'            {
#'               sim%.%.SS$addSubpop("p1", 500);
#'            }),
#'    slim_block(10000,
#'          {
#'               sim%.%.SS$simulationFinished();
#'          })
#') -> script
#'reconstruct(script)
reconstruct.slimr_script <- function(x, ...) {
  code <- paste0("    slim_block(",
                 ifelse(is.na(field(x, "block_id")), "", paste0(field(x, "block_id"), ", ")),
                 ifelse(is.na(field(x, "start_gen")), "", paste0(field(x, "start_gen"), ", ")),
                 ifelse(is.na(field(x, "end_gen")), "", ifelse(field(x, "end_gen") == "", ".., ",
                                                               paste0(field(x, "end_gen"), ", "))),
                 field(x, "callback"), ", ",
                 " {\n    ",
                 purrr::map_chr(field(x, "code"), ~paste(paste0("    ", .x),
                                                         collapse = "\n    ")),
                 "\n    })")
  code <- paste0("slim_script(\n\n",
                 paste(code, collapse = ",\n\n"),
                 "\n)")

  code
}


#' @export
new_slimr_script_coll <- function(x = list()) {
  new_list_of(x, ptype = new_slimr_script(), class = "slimr_script_coll")
}

#' @export
slimr_script_coll <- function(...) {
  x <- list(...)
  x <- lapply(x, vec_cast, new_slimr_script())
  new_slimr_script_coll(x)
}

#' @export
format.slimr_script_coll <- function(x, add_block_names = TRUE, ...) {

  if(length(x) == 0) {
    return("{}")
  } else {

    string <- vapply(x, format, character(), add_block_names = add_block_names)

  }

  paste(string, collapse = "\n\n")
}

#' @export
obj_print_data.slimr_script_coll <- function(x, add_block_names = TRUE, max_show = 3, ...) {

  max_exceeded <- FALSE

  if(length(x) == 0) {
    return("{}")
  } else {

    if(length(x) > max_show) {
      max_exceeded <- TRUE
      how_many_more <- length(x) - max_show
      x <- x[1:max_show]
    }

    string <- vapply(x, obj_print_data, character(1),
                     add_block_names = add_block_names,
                     suppress_cat = TRUE)

  }

  if (!requireNamespace("crayon", quietly = TRUE)) {
    string <- paste0(crayon::red(paste0("<", 1:length(x), ">")),
                     "\n\n",
                     string)
  } else {
    string <- paste0(paste0("<", 1:length(x), ">"),
                     "\n\n",
                     string)
  }
  string <- paste(string, collapse = "\n")
  if(max_exceeded) {
    if (!requireNamespace("crayon", quietly = TRUE)) {
      string <- paste0(string,
                       "\n\n",
                       crayon::red("<...>"),
                       "\n\n",
                       glue::glue("and {crayon::cyan(how_many_more)} more."),
                       "\n")
    } else {
      string <- paste0(string,
                       "\n\n",
                       "<...>",
                       "\n\n",
                       glue::glue("and {how_many_more} more."),
                       "\n")
    }
  }
  cat(string)
}

#' @export
vec_ptype_full.slimr_script_coll <- function(x, ...) "slimr_script_coll"
#' @export
vec_ptype_abbr.slimr_script_coll <- function(x, ...) "s-s-col"

