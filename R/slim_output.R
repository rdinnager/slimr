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

slim_output_process_one <- function(output_type, output_format = "text", raw_data) {
  out <- dplyr::case_when(output_type == "sexes" ~ stringr::str_split(raw_data, " ")[[1]],
                          output_type == "coordinates" ~ stringr::str_split(raw_data, " ")[[1]],
                          NA ~ slim_output_one$raw_data)

  if(output_type == "coordinates") {
    out <- out  %>%
      matrix(ncol = 2) %>%
      dplyr::as_tibble(.repair_names = make.names) %>%
      dplyr::rename(x = V1, y = V2) %>%
      dplyr::mutate_all(~as.numeric(.))
  }
  if(output_type == "sexes") {
    out <- dplyr::tibble(sexes = out)
  }

  out

}

slim_output_process <- function(slim_output) {
  nongenomes <- slim_output %>%
    dplyr::filter(!output_type %in% c("genomes", "individuals"))

  processed_nongenomes <- nongenomes %>%
    dplyr::mutate(tibbles = purrr::pmap(nongenomes %>%
                                          dplyr::select(output_type, output_format, raw_data),
                                        ~slim_output_process_one(..1, ..2, ..3))) %>%
    dplyr::group_by(generation) %>%
    dplyr::group_modify(~dplyr::bind_cols(.$tibbles))

}
