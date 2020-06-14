slim_process_output <- function(out, data_only = FALSE) {

  out_all <- paste(out, collapse = "\n")

  dat <- stringr::str_match_all(out_all,
                                 stringr::regex("<slimr_out:start>(.*?)<slimr_out:end>",
                                                dotall = TRUE))[[1]][ , 2]

  if(length(dat) > 0) {
    df <- readr::read_csv(dat,
                          col_names = c("generation", "name", "expression", "data"),
                          quote = "\'",
                          col_types = "iccc")
  } else {
    df <- NULL
  }

  if(!data_only) {

    pre <- stringr::str_match_all(out_all,
                                  stringr::regex("^((?:(?!<slimr_out:start>).)*)<slimr_out:start>",
                                                 dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()


    inter <- stringr::str_match_all(out_all,
                                    stringr::regex("<slimr_out:end>(.*?)<slimr_out:start>",
                                                   dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()

    post <- stringr::str_match_all(out_all,
                                   stringr::regex("<slimr_out:end>((?:(?!<slimr_out:end>).)*)$",
                                                  dotall = TRUE))[[1]][ , 2] %>%
      stringr::str_split("\n") %>%
      purrr::flatten_chr()

    return(list(data = df, leftovers = post, extra_out = c(pre, inter)))

  } else {

    return(df)

  }

}

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
