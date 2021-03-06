
SLiMify <- function(code, for_script = FALSE) {
  code <- slimr_code_add_semicolons(code) %>%
    slimr_code_replace_arrows() %>%
    slimr_code_remove_special_classes() %>%
    slimr_code_replace_dollars() %>%
    slimr_code_replace_dots(for_script = for_script)

  if(for_script) {
    code <- slimr_code_replace_ternary(code) %>%
      slimr_code_replace_modulus() %>%
      slimr_code_replace_returns() %>%
      slimr_code_remove_slimr_special()
  }

  code
}


SLiMify_all <- function(code, for_script = FALSE) {

  code <- purrr::map(code,
                     ~SLiMify(.x, for_script = for_script))

  code
}

slimr_code_add_semicolons <- function(code_one) {
  brace_lines <- stringr::str_detect(code_one,
                                     "(\\{|\\}|\\+|\\,|\\-|\\*|\\/)[:blank:]*$")
  do_lines <- stringr::str_detect(code_one,
                                  "do$")
  # if_lines <- stringr::str_detect(code_one,
  #                                 "if[:blank:]*\\((.*?)\\)[:blank:]*$")
  #
  # get_semi <- which(!brace_lines & !if_lines)
  get_semi <- which(!brace_lines & !do_lines)
  code_one[get_semi] <- paste0(code_one[get_semi], ";")
  code_one
}

slimr_code_replace_arrows <- function(code_one) {
  stringr::str_replace_all(code_one, stringr::fixed("<-"), stringr::fixed("="))
}

slimr_code_replace_dollars <- function(code_one) {
  stringr::str_replace_all(code_one, stringr::fixed("$"), stringr::fixed(" %.% "))
}


slimr_code_replace_dots <- function(code_one, for_script = FALSE) {

  if(for_script) {
    code <- stringr::str_replace_all(code_one,
                                     glue::glue(" \\%\\.\\% {.resources$classes_regex}\\$"),
                                     ".")
    code <- stringr::str_replace_all(code,
                             " \\%\\.\\% ",
                             ".")
  } else {
    code <- stringr::str_replace_all(code_one,
                                     glue::glue("([^\\]\\)]) \\%\\.\\% {.resources$classes_regex}\\$"),
                                     "\\1.")
    code <- stringr::str_replace_all(code,
                             "([^\\]\\)]) \\%\\.\\% ",
                             "\\1.")
  }

  code

}

slimr_code_remove_special_classes <- function(code_one) {
  code <- stringr::str_remove_all(code_one,
                           "(\\.Init|Initialize|\\.SS|SLiMBuiltin)\\$")
  code <- stringr::str_remove_all(code,
                                   glue::glue("{.resources$classes_regex}\\$"))
  code
}

slimr_code_remove_slimr_special <- function(code_one) {
  stringr::str_remove_all(code_one,
                          "slimr_special__")
}

slimr_code_replace_ternary <- function(code_one) {
  code <- stringr::str_replace_all(code_one,
                                   "\\%?\\%",
                                   "?")
  stringr::str_replace_all(code_one,
                           "\\%else\\%",
                           "else")
}

slimr_code_replace_modulus <- function(code_one) {
  ## turn R modulus %% back into SLiM modulus %
  stringr::str_replace_all(code_one,
                           "([^.])%%([^.])",
                           "\\1%\\2")
}

slimr_code_replace_returns <- function(code_one) {
  ## turn R's return(...) syntax back into SLiM's return ...; syntax.
  stringr::str_replace_all(code_one,
                           "return\\((.*)\\)[:blank:]*(;| else)",
                           "return \\1\\2")
}


slimr_code_remove_comments <- function(code_one) {
  #code <- stringr::str_replace_all(code_one, "//([^\"]+?)(\\n|$)", "\n")
  code <- stringr::str_replace_all(code_one, '(?<!")//(.*?)(\\n|$)', "\n")
  stringr::str_remove_all(code, stringr::regex("/\\*(.*?)\\*/", dotall = TRUE))

}

slimr_code_from_text_modulus <- function(code) {
  ## replace SLiM modulus % with R modulus %%
  stringr::str_replace_all(code,
                           "([^.])%([^.])",
                           "\\1%%\\2")
}

slimr_code_from_text_ternary <- function(code) {
  ## replace ? else with fake operators
  stringr::str_replace_all(code,
                           "(.*?)\\?(.*?)else(.*?)",
                           "\\1%?%\\2%else%\\3")
}

slimr_code_from_text_else_overhang <- function(code) {
  ## remove overhanging elses and ; elses
  code <- stringr::str_replace_all(code,
                                   "\n+[:blank:]*\\Qelse\\E",
                                   " else")

  stringr::str_replace_all(code,
                           ";[:blank:]*\\Qelse\\E",
                           " else")
}

slimr_code_from_text_dos <- function(code) {
  ## make sure do statements are on their own line (R treats it as a variable then)
  code <- stringr::str_replace_all(code,
                                   "do[:blank:]+(.*?);",
                                   "do\n{\\1;}")

  stringr::str_replace_all(code,
                           "do[:blank:]*\\{",
                           "do\n{")
}

slimr_code_from_text_returns <- function(code) {
  ## convert return x; to return(x);
  stringr::str_replace_all(code,
                           "return[:space:]+?(.*)(;| else)",
                           "return(\\1)\\2")
}

slimr_code_from_text_dots <- function(code) {
  ## replace . with %.% (shim operator)
  # stringr::str_replace_all(code,
  #                          "([^[:digit:]%])\\.([^[:digit:]%])",
  #                          "\\1%.%\\2")

  stringr::str_replace_all(code,
                           "([\\]\\)])\\.([:alnum:])",
                           "\\1%.%\\2")
}

slimr_code_from_text_whiles <- function(code) {
  ## add slimr_special__ keyword to while statements to make R parse it OK.
  stringr::str_replace_all(code,
                           "(while[:blank:]*\\((.*?)\\))[:blank:]*;",
                           "\\1slimr_special__")
}

slimr_code_from_text_style <- function(code) {
  rlang::parse_exprs(code) %>%
    purrr::map_chr(~expr_deparse_fast(.x) %>%
                     paste(collapse = "\n"))
}

slimr_code_from_text_style_all <- function(code) {
  purrr::map(code,
             ~slimr_code_from_text_style(.x))
}


#' Rify some SLiM code
#'
#' Utility code to convert SLiM code into a form that can be parsed by R
#' (e.g. in \code{styler} or \code{prettycode}). Don't forget to re-SLiMify
#' afterwards (via \code{\link(slim_code_SLiMify))!
#'
#' @param code_snippet SLiM code to Rify as a character vector
#'
#' @noRd
#'
#' @return Rified code snippet
slimr_code_Rify <- function(code) {

  code <- code %>%
    slimr_code_from_text_modulus() %>%
    slimr_code_from_text_ternary() %>%
    slimr_code_from_text_else_overhang() %>%
    slimr_code_from_text_dos() %>%
    slimr_code_from_text_returns() %>%
    slimr_code_from_text_dots() %>%
    slimr_code_from_text_whiles()

  code

}

slimr_code_Rify_all <- function(code) {

  code %>%
    purrr::map(~slimr_code_Rify(.x))

}

assert_valid_code <- function(code_txt) {
  code <- try(parse(text = code_txt))
  if(inherits(code, "try-error")) {
    rlang::abort(paste("Not valid R code; something went wrong in translation.", "error:", code))
  }
  code_txt
}

slimr_code_detect_output <- function(code) {
  any(stringr::str_detect(code,
                          "(output|cat\\(|catn\\()"))
}

slimr_code_detect_nucleotides <- function(code) {
  any(stringr::str_detect(code,
                          "nucleotide"))
}
