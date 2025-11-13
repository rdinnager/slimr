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

#' Metadata for SLiM recipes converted to slimr format
#'
#' A dataset containing metadata about all SLiM recipes that have been converted
#' to slimr format. This includes information about recipe titles, features,
#' conversion status, and notes about the conversion process.
#'
#' @format A tibble with 204 rows and 9 variables:
#' \describe{
#'   \item{recipe_num}{Character. Recipe number/identifier (e.g., "4.1", "5.2.3", "10.6_I")}
#'   \item{recipe_title}{Character. Descriptive title of the recipe}
#'   \item{slim_version}{Character. SLiM version the recipe is compatible with (typically "5" for SLiM 5.x)}
#'   \item{features}{Character. Comma-separated list of features demonstrated in the recipe}
#'   \item{status}{Character. Conversion status (typically "completed")}
#'   \item{converted_date}{Date. Date when the recipe was converted to slimr format}
#'   \item{tested_date}{Date. Date when the converted recipe was tested}
#'   \item{notes}{Character. Notes about the conversion process, including important conversion patterns and caveats}
#'   \item{feature_list}{List. List of feature tags for easier filtering}
#' }
#'
#' @details
#' The recipes cover a wide range of population genetics concepts including:
#' \itemize{
#'   \item Basic neutral simulations and demographic models
#'   \item Selection (directional, balancing, frequency-dependent, spatially varying)
#'   \item Population structure and migration
#'   \item Quantitative genetics and QTL models
#'   \item Sexual reproduction, recombination, and gene conversion
#'   \item Non-Wright-Fisher (nonWF) models with overlapping generations
#'   \item Spatial models with continuous space
#'   \item Tree-sequence recording
#'   \item Nucleotide-based models
#'   \item Multispecies models
#' }
#'
#' @source Converted from SLiM recipes available at \url{https://github.com/MesserLab/SLiM}
#'
#' @examples
#' # Load the metadata
#' data(slim_recipe_metadata)
#'
#' # View recipes by chapter
#' table(sub("\\..*", "", slim_recipe_metadata$recipe_num))
#'
#' # Find recipes with specific features
#' library(dplyr)
#' slim_recipe_metadata %>%
#'   filter(grepl("spatial", features)) %>%
#'   select(recipe_num, recipe_title)
#'
#' # Find recipes about selection
#' slim_recipe_metadata %>%
#'   filter(grepl("selection", features)) %>%
#'   select(recipe_num, recipe_title, features)
"slim_recipe_metadata"
