#' Extract data from a single generation's output
#' @param output_one Lines output in a single generation from SLiM
#'
#' @return A four column tibble.
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

#' Extract data from SLiM output
#'
#' @param output_this Lines of SLiM output to extract from. Should be a  list, each element of which has a single generations worth of output (encloded in <slimr_output:generation_start> and <slimr_output:generation_end>.
#' @param generations Generation numbers corresponding to the \code{output_this} list. Should be a numeric vector of the same length of \code{output_this}.
#'
#' @return A four column tibble containing the output type, output format, the raw data, and the generation. There will be one row per generation in the \code{output_this} list.
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
                          NA ~ raw_data)

  if(output_type == "coordinates") {
    out <- out  %>%
      matrix(ncol = 2) %>%
      dplyr::as_tibble(.repair_names = make.names) %>%
      dplyr::rename(x = .data$V1, y = .data$V2) %>%
      dplyr::mutate_all(~as.numeric(.))
  }
  if(output_type == "sexes") {
    out <- dplyr::tibble(sexes = out)
  }

  out

}

slim_output_process <- function(slim_output) {
  nongenomes <- slim_output %>%
    dplyr::filter(!.data$output_type %in% c("genomes", "individuals"))

  processed_nongenomes <- nongenomes %>%
    dplyr::mutate(tibbles = purrr::pmap(nongenomes %>%
                                          dplyr::select(.data$output_type,
                                                        .data$output_format,
                                                        .data$raw_data),
                                        ~slim_output_process_one(..1, ..2, ..3))) %>%
    dplyr::group_by(.data$generation) %>%
    dplyr::group_modify(~dplyr::bind_cols(.$tibbles))

}


# slim_process_output <- function(out, data_only = FALSE) {
#
#   out_all <- paste(out, collapse = "\n")
#
#   dat <- stringr::str_match_all(out_all,
#                                 stringr::regex("<slimr_out:start>(?:(.*?))<slimr_out:end>",
#                                                dotall = TRUE))[[1]][ , 2]
#
#   if(length(dat) > 0) {
#     df <- readr::read_csv(dat,
#                           col_names = c("generation", "name", "expression", "data"),
#                           quote = "\'",
#                           col_types = "iccc")
#   } else {
#     df <- NULL
#   }
#
#   if(!data_only) {
#
#     pre <- stringr::str_match_all(out_all,
#                                   stringr::regex("^((?:(?!<slimr_out:end>).)*)<slimr_out:start>",
#                                                  dotall = TRUE))[[1]][ , 2] %>%
#       stringr::str_split("\n") %>%
#       purrr::flatten_chr()
#
#
#     inter <- stringr::str_match_all(out_all,
#                                     stringr::regex("<slimr_out:end>(?:(.*?))<slimr_out:start>",
#                                                    dotall = TRUE))[[1]][ , 2] %>%
#       stringr::str_split("\n") %>%
#       purrr::flatten_chr()
#
#     post <- stringr::str_match_all(out_all,
#                                    stringr::regex("<slimr_out:start>((?:(?!<slimr_out:end>).)*)$",
#                                                   dotall = TRUE))[[1]][ , 1] %>%
#       stringr::str_split("\n") %>%
#       purrr::flatten_chr()
#
#     hangers <- stringr::str_match_all(out_all,
#                                       stringr::regex("<slimr_out:end>((?:(?!<slimr_out:start>).)*)$",
#                                                      dotall = TRUE))[[1]][ , 2] %>%
#       stringr::str_split("\n") %>%
#       purrr::flatten_chr()
#
#     return(list(data = df, leftovers = post, extra_out = c(pre, inter, hangers)))
#
#   } else {
#
#     return(df)
#
#   }
#
# }
