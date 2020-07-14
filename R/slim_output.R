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

#' Extract Elements from SLiM's outputFull()
#'
#' @param output_full A character vector where each element is the result of a
#' call to \code{outputFull()} in SLiM
#' @param type Which type of data to return: "mutations", "individuals", "genomes", "coordinates",
#' "sexes", or "ages"
#'
#' @return A tibble
#' @export
#'
#' @examples
slim_outputFull_extract <- function(output_full, type = c("mutations", "individuals",
                                                          "genomes", "coordinates",
                                                          "sexes", "ages")) {

  type_orig <- match.arg(type)

  if(type_orig %in% c("coordinates", "sexes", "ages")) {
    type <- "individuals"
  } else {
    type <- type_orig
  }

  dat <- purrr::map2_dfr(output_full$data, output_full$generation,
                         ~slim_outputFull_extract_one(.x, type) %>%
                           dplyr::mutate(generation = .y)) %>%
    dplyr::select(generation, dplyr::everything())

  dat

}

slim_outputFull_extract_one <- function(string, type) {

  if(stringr::str_detect(string, "Ancestral sequence:")) {
    ancs <- TRUE
  }

  dat <- switch(type,

                metadat = stringr::str_match(string,
                                             stringr::regex("^(?:(.*?))\nPopulations:",
                                                            dotall = TRUE))[ , 2],

                populations = stringr::str_match(string,
                                                 stringr::regex("Populations:\n(?:(.*?))\nMutations:",
                                                                dotall = TRUE))[ , 2],

                mutations = stringr::str_match(string,
                                              stringr::regex("Mutations:\n(?:(.*?))\nIndividuals:",
                                                             dotall = TRUE))[ , 2],

                individuals = stringr::str_match(string,
                                stringr::regex("Individuals:\n(?:(.*?))\nGenomes:",
                                               dotall = TRUE))[ , 2],

                genomes = if(ancs) {
                  stringr::str_match(string,
                                     stringr::regex("Genomes:\n(?:(.*?))\nAncestral sequence:",
                                                    dotall = TRUE))[ , 2]
                } else {
                  stringr::str_match(string,
                                     stringr::regex("Genomes:\n(?:(.*?))$",
                                                    dotall = TRUE))[ , 2]
                },

                NULL

  )

  if(stringr::str_detect(dat, "\n", negate = TRUE)) {
    dat <- paste(dat, "\n")
  }

  dat <- switch(type,

                metadat = dplyr::tibble(metadata = dat),

                populations = suppressWarnings(readr::read_table2(dat,
                                                                  col_types = "cicd",
                                                                  col_names = c("subpop", "n_ind",
                                                                                "sex_type", "sex_ratio"))),

                mutations = suppressWarnings(readr::read_table2(dat,
                                                                col_types = "iiciddcii",
                                                                col_names = c("id", "unique_id",
                                                                              "mut_type", "chrome_pos",
                                                                              "selection", "dominance",
                                                                              "subpop", "first_gen",
                                                                              "prevalence",
                                                                              "nucleotide"))),

                individuals = suppressWarnings(readr::read_table2(dat,
                                                                  col_types = "ccccc",
                                                                  col_names = c("ind_id", "sex",
                                                                                "genome_1", "genome_2",
                                                                                "extra"))),

                genomes = suppressWarnings(readr::read_table2(dat,
                                                              col_types = "ccc",
                                                              col_names = c("gen_id", "gen_type",
                                                                            "mut_list"))),

                NULL
  )

  dat
}

slim_output_genlight <- function(output) {

}
