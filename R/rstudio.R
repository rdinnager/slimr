slim_run_snippet <- function(x) {

  if(inherits(x, "character")) {
    if(length(x) > 1) {
      parsed <- rlang::parse_expr("{" %+% paste(x, collapse = "\n") %+% "}")
    } else {
      pasrsed <- rlang::parse_expr(paste(x, collapse = "\n"))
    }
  } else {
    parsed <- rlang::enexpr(x)
  }

  t_script <- eval(rlang::expr(!!minimal_slim_sim(!!parsed)))

  scrpt_txt <- as_slim_text(t_script) %>%
    paste(collapse = "\n")

  slim_run(scrpt_txt)

}

#' Generate a minimal SLiM simulation script
#'
#' This function is mainly used to quickly create a script which does
#' not does not do much, but can be used to test other code.
#'
#' @param command
#'
#' @return An R `expression`.
#' @export
#'
#' @examples
#' minimal_slim_sim()
minimal_slim_sim <- function(command = print("Hello world!")) {

  rlang::expr(slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
      !!rlang::enexpr(command);
      sim.simulationFinished();
    })
  ))

}

#' Generate a minimal slimr_script object
#'
#' This function is mainly used to quickly create a script which does
#' not does not do much, but can be used to test other code that work
#' on `slimr_script` objects. Mainly used for documentation examples.
#'
#' @param command
#'
#' @return A `slimr_script` object
#' @export
#'
#' @examples
#' minimal_slimr_script()
minimal_slimr_script <- function(command = print("Hello world!")) {

  rlang::eval_tidy(minimal_slim_sim(!!rlang::enexpr(command)))

}

#' Copy original slimrlang code used to create a slimr_script object to the clipboard
#'
#' @param slimr_script_name Name of slimr_script to copy its original code
#' to the clipboard, as a string
#'
#' @return The code as a string (invisibly)
#' @export
#'
#' @examples
#' test <- minimal_slimr_script()
#' if(rlang::is_installed("clipr") && interactive()) {
#'     slimr_clip_original("test")
#' }
slimr_clip_original <- function(slimr_script_name = NULL) {
  assert_package("clipr")

  if(is.null(slimr_script_name)) {
    assert_package("rstudioapi")
    sel <- rstudioapi::getActiveDocumentContext()$selection
    slimr_script_name <- sel[[length(sel)]]$text %>%
      stringr::str_trim()
  }

  slimr_script <- get(slimr_script_name)

  orig_code <- deparse(attr(slimr_script, "slimrlang_orig"))
  clipr::write_clip(orig_code)
  invisible(orig_code)
}

#' Open original slimrlang code used to create a slimr_script object in a new document
#'
#' Open the original code used to create a slimr_script in a new document. Requires RStudio.
#'
#' @param slimr_script_name Name of slimr_script to open in a new document as a string.
#'
#' @return The code as a string (invisibly)
#' @export
#'
#' @examples
#' test <- minimal_slimr_script()
#' if(rlang::is_installed("rstudioapi") && interactive()) {
#'     slimr_open_original("test")
#' }
slimr_open_original <- function(slimr_script_name = NULL) {
  assert_package("rstudioapi")

  if(is.null(slimr_script_name)) {
    sel <- rstudioapi::getActiveDocumentContext()$selection
    slimr_script_name <- sel[[length(sel)]]$text %>%
      stringr::str_trim()
  }

  slimr_script <- get(slimr_script_name)

  orig_code <- deparse(attr(slimr_script, "slimrlang_orig"))
  rstudioapi::documentNew(paste(orig_code, collapse = "\n"))
  invisible(orig_code)
}
