slim_output_extract_one <- function(output_one) {
  output_starts <- stringr::str_which(output_one, "<slimr_output:[a-zA-Z]+_start>")
  output_ends <- stringr::str_which(output_one, "<slimr_output:[a-zA-Z]+_end>")
  output_types <- unglue::unglue_data(output_one[output_starts], "<slimr_output:{output_type}_start>{output_format}")

  raw_data <- purrr::map2_chr(output_starts, output_ends,
                          ~output_one[(.x + 1L):(.y - 1L)] %>%
                            paste(collapse = "\n"))
  return(output_types %>%
           dplyr::mutate(raw_data = raw_data))
}

#' Title
#'
#' @param output_this
#' @param generations
#'
#' @return
#' @export
#'
#' @examples
slim_output_extract <- function(output_this, generations) {
  output_here <- purrr::map(output_this,
                            ~slim_output_extract_one(.x))
  output_it <- purrr::map2_dfr(output_here, generations,
                                 ~.x %>%
                                   dplyr::mutate(generation = .y))

  output_it
}
