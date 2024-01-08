#' Dataset of all recipes available in SLiM
#'
#' A Dataset containing all SLiM recipes found in the SLiM Manual
#'
#' @format A List with 190 elements, each containing a character vector
#' @source \url{https://github.com/MesserLab/SLiM/releases/download/v4.1/SLiM_Manual.pdf}
"slim_recipes"

#' Download and load herm.rdata file containing SNP data from Sandy Inland Mouse
#' Details can be found in the article at https://rdinnager.github.io/slimr/articles/Main_manuscript_example_v2.html
#'
#' @param file_name File name to download data file to. It is recommended to use the default.
#' @param download Should the file be downloaded? Default is `TRUE`. If `FALSE`, only the URL to
#' the file will be returned.
#'
#' @return A `genlight` object with SNP data
#' @export
#'
#' @examples
#' herm <- load_herm(download = FALSE)
#' herm
load_herm <- function(file_name = file.path(system.file(package = "slimr", "extdata"), "herm.rdata"),
                      download = TRUE) {

  if(!download) {
    return("https://figshare.com/ndownloader/files/43810926")
  }

  if(file.exists(file_name)) {
    return(readr::read_rds(file_name))
  } else {
    download.file("https://figshare.com/ndownloader/files/43810926",
                  file_name,
                  mode = "wb")
    return(readr::read_rds(file_name))
  }
}

