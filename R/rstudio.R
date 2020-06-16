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

minimal_slim_sim <- function(command) {

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

#' Copy original slimrlang code used to create a slimr_script object to the clipboard
#'
#' @param slimr_script_name Name of slimr_script to copy its original code
#' to the clipboard, as a string
#'
#' @return The code as a string (invisibly)
#' @export
#'
#' @examples
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
