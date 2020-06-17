#' Extract data produced by SLiM
#'
#' This function takes output produced from a \code{slimr_script} which uses
#' \code{\link{slimr_output}}, and converts it into a \code{tibble}
#'
#' @param output Character vector produced from SLiM run.
#'
#' @return A \code{tibble} with four columns:
#' \describe{
#' \item{generation}{A vector of generations where output was produced.}
#' \item{name}{Names of the output data.}
#' \item{expression}{The SLiM expression used to generate the output.}
#' \item{data}{The raw data output from SLiM as a character vector.}
#' }
#' @export
#'
#' @examples
slim_extract_output_data <- function(output) {

  slim_process_output(output, data_only = TRUE)

}

extract_output_data <- function(dat) {
  if(length(dat) )
  df <- readr::read_csv(dat,
                        col_names = c("generation", "name", "expression", "data"),
                        quote = "\'",
                        col_types = "iccc")

  readr::read_csv(paste(leftovers, collapse = "\n"),
                  col_names = c("generation", "name", "expression", "data"),
                  quote = "\'",
                  col_types = "iccc")
}
