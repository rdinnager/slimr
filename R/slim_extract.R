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

#' Convert output data from a slimr_results object to a tibble
#'
#' This function tries to automate the process of converting
#' output in the \code{slimr_results} object returned by
#' \code{\link{slim_run}} function into usable data in the
#' form of a \code{tibble}. If this process fails you will
#' end up with the data as a character string, and you will
#' have to manually convert this into something you can use.
#'
#' @param dat A \code{slimr_results} object to extract data from.
#' You can alternatively specify the \code{output_data} from the \code{slimr_results}
#' directly in this parameter.
#' @param generations For what generations do you want to extract data?
#' Default is all generations that have data. The special value \code{0}
#' can be used to specify just the most recent generation in the data.
#'
#' @return A tibble with three columns, name: the name of the outputs,
#' generation: the generations of the outputs, and data: the outputs as converted data.
#' This final column will be a list column, where each element will usually
#' be a vector or a tibble, depending on what kind of data was returned
#' by the simulation.
#'
#' @export
slim_results_to_data <- function(dat, generations = NULL) {

  if(inherits(dat, "slimr_results")) {
    dat <- dat$output_data
  }

  if(!is.null(generations)) {
    if(generations == 0) {
      generations <- max(dat$generation, na.rm = TRUE)
    }
    dat <- dat %>%
      dplyr::filter(.data$generation %in% generations)
  }

  res_dat <- dat %>%
    dplyr::mutate("ord" := seq_len(dplyr::n())) %>%
    dplyr::group_by(.data$type, .data$expression) %>%
    dplyr::group_modify(~slim_extract_to_data(.x, unlist(.y$type[1]))) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(.data$ord) %>%
    dplyr::select(-.data$ord)

  return(res_dat)

}

slim_extract_to_data <- function(dat, type) {

  if(type == "slim_output") {
    first_line <- readr::read_lines(dat$data[[1]],
                                    n_max = 1L) %>%
      stringr::str_split(" ") %>%
      .[[1]]

    output_type <- first_line[3]

    res <- switch(output_type,
                  A = purrr::map(purrr::transpose(dat),
                                 ~slim_extract_full(.x,
                                                          type = "full_individual",
                                                          join = FALSE)),
                  GS = purrr::map(purrr::transpose(dat),
                                  ~slim_outputGS_extract(.x,
                                                        type = "full",
                                                        join = FALSE))
                  )

  } else {
    res <- slim_to_Rob(dat$data, type)
  }

  #print(dplyr::glimpse(res))

  dat <- dat %>%
    dplyr::mutate("data" := res)

  if(type == "slim_nucleotides") {
    assert_package("Biostrings", install = "BiocManager::install")
    if(any(stringr::str_detect(dat$name, "_subpops"))) {
      name_name <- dat$name[stringr::str_which(dat$name, "_subpops")][1]
      seq_name <- stringr::str_remove(name_name, "_subpops")
      subpops <- dat %>%
        dplyr::filter(.data$name == name_name) %>%
        dplyr::pull(.data$data)
    } else {
      seq_name <- dat$name[1]
      subpops <- rep("1", length(dat$data[1]))
    }

    seq_dat <- dat %>%
      dplyr::filter(.data$name == seq_name)

    dna <- purrr::map(seq_dat %>%
                        dplyr::pull(.data$data),
                      ~ Biostrings::DNAStringSet(.x))

    dat <- seq_dat %>%
      dplyr::mutate("data" := dna,
                    "subpops" = subpops)

  }

  dat
}

slim_to_Rob <- function(dat, type) {
  dat_res <- stringr::str_split(dat, " ")
  # dat_res <- switch(type,
  #                   )
  dat_res
}



#' Extract Elements from SLiM's outputFull()
#'
#' @param output_full A character vector where each element is the result of a
#' call to \code{outputFull()} in SLiM
#' @param type Which type of data to return: "mutations", "individuals", "genomes", "coordinates",
#' "sexes", or "ages"
#' @param join If asking for multiple output type, should they be joined into one tibble (\code{join = TRUE})
#' or left as separate tibbles returned in a list (\code{join = FALSE})?
#' @param expand_mutations If asking for "genomes" output, should mutations be expanded into their own column (\code{expand_mutations = TRUE})
#' or left as a vector of mutation ids in a list column (\code{expand_mutations = FALSE})?
#'
#' @return A tibble
#' @export
#'
#' @examples
slim_extract_full <- function(output_full, type = c("mutations", "individuals",
                                                          "genomes", "coordinates",
                                                          "sexes", "ages", "full_individual"), join = TRUE,
                                    expand_mutations = FALSE) {

  if(length(type) == 1) {
    type_orig <- match.arg(type)
  } else {
    type_orig <- type
  }


  if(length(type_orig) == 1) {
    if(type_orig == "full_individual") {
      type <- c("individuals", "genomes", "mutations")
    }
  } else {
    type <- type[type != "full_individual"]
  }

  #type[type %in% c("coordinates", "sexes", "ages")] <- "individuals"


  get_one <- function(type, data, generation) {
    purrr::map2_dfr(data, generation,
                    ~slim_extract_full_one(.x, type, expand_mutations, generation = .y)) %>%
      dplyr::select(.data$generation, dplyr::everything())
  }

  dat <- purrr::map(type,
                    ~get_one(.x, output_full$data, output_full$generation))

  if(join) {
    ## not the ideal solution but I don't have time to check which
    ## variable name to join by for every join in the code right now
    ## it is on my to do list though
    suppressMessages(
      dat <- purrr::reduce(dat,
                           ~dplyr::left_join(.x, .y))
    )
    class(dat) <- c("slimr_outputFull_joined",
                    class(dat))
  } else {
    names(dat) <- type
    class(dat) <- c("slimr_outputFull_list",
                    class(dat))
  }

  if(length(dat) == 1) {
    dat <- dat[[1]]
  }

  dat

}

slim_extract_full_one <- function(string, type, expand_mutations, generation) {

  if(stringr::str_detect(string, "Ancestral sequence:")) {
    ancs <- TRUE
  } else {
    ancs <- FALSE
  }

  if(type %in% c("coordinates", "sexes", "ages")) {
    new_type <- "individuals"
  } else {
    new_type <- type
  }

  dat <- switch(new_type,

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
                                                    dotall = TRUE))[ , 2] %>%
                    stringr::str_replace_all(stringr::regex("(^p[:digit:]+\\:[:digit:]+[:blank:]+[:upper:])([:blank:]+)(.*?)$",
                                                            multiline = TRUE),
                                             '\\1\\2"\\3"')
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
                                                                col_names = c("mut_id", "unique_mut_id",
                                                                              "mut_type", "chrome_pos",
                                                                              "selection", "dominance",
                                                                              "subpop", "first_gen",
                                                                              "prevalence",
                                                                              "nucleotide"))),

                individuals = suppressWarnings(readr::read_table2(dat,
                                                                  col_types = "ccccc",
                                                                  col_names = c("unique_ind_id", "sex",
                                                                                "gen_id_1", "gen_id_2",
                                                                                "extra"))) %>%
                  tidyr::separate("unique_ind_id", c("pop_id", "ind_id"), sep = ":", remove = FALSE) %>%
                  tidyr::pivot_longer(c("gen_id_1", "gen_id_2"),
                                      names_prefix = "gen_id_",
                                      names_to = "genome_num",
                                      values_to = "gen_id"),

                coordinates = suppressWarnings(readr::read_table2(dat,
                                                                  col_types = "ccccddd",
                                                                  col_names = c("unique_ind_id", "sex",
                                                                                "gen_id_1", "gen_id_2",
                                                                                "x", "y", "z"))) %>%
                  tidyr::separate("unique_ind_id", c("pop_id", "ind_id"), sep = ":", remove = FALSE),

                genomes = suppressWarnings(read_with_excess(dat,
                                                            col_types = "ccc",
                                                            col_names = c("gen_id", "gen_type",
                                                                          "mut_list"))) %>%
                  dplyr::mutate("mut_list" := stringr::str_split(.data$mut_list, " ")),

                NULL
  )

  if(expand_mutations) {
    if(type == "genomes") {
      dat <- dat %>%
        tidyr::unnest_longer(col = "mut_list",
                             values_to = "mut_id",
                             indices_include = FALSE) %>%
        dplyr::mutate("mut_id" := as.integer(.data$mut_id)) %>%
        tidyr::drop_na(.data$mut_id)
    }
  } else {
    if(type == "genomes") {
      dat <- dat %>%
        dplyr::mutate("mut_list" := purrr::map(.data$mut_list,
                                          as.integer))
    }
  }

  dat %>%
    dplyr::mutate("generation" := generation)
}


#' Extract Elements from SLiM's output() for genomes
#'
#' @param output A character vector where each element is the result of a
#' call to \code{genomes.output()} in SLiM
#' @param type Which type of data to return: "mutations", or "genomes" or
#' both.
#' @param join If asking for multiple output type, should they be joined into one tibble (\code{join = TRUE})
#' or left as separate tibbles returned in a list (\code{join = FALSE})?
#' @param expand_mutations If asking for "genomes" output, should mutations be expanded into their own column (\code{expand_mutations = TRUE})
#' or left as a vector of mutation ids in a list column (\code{expand_mutations = FALSE})?
#'
#' @return A tibble
#' @export
#'
#' @examples
slim_outputGS_extract <- function(output, type = c("mutations",
                                                   "genomes",
                                                   "full"),
                                  join = TRUE,
                                  expand_mutations = FALSE) {

  if(length(type) == 1) {
    type_orig <- match.arg(type)
  } else {
    type_orig <- type
  }

  if(length(type_orig) == 1) {
    if(type_orig == "full") {
      type <- c("genomes", "mutations")
    }
  } else {
    type <- type[type != "full"]
  }

  get_one <- function(type, data, generation) {
    purrr::map2_dfr(data, generation,
                    ~slim_outputGS_extract_one(.x, type, expand_mutations, generation = .y)) %>%
      dplyr::select(.data$generation, dplyr::everything())
  }

  dat <- purrr::map(type,
                    ~get_one(.x, output$data, output$generation))

  if(join) {
    suppressMessages(
      dat <- purrr::reduce(dat,
                           ~dplyr::left_join(.x, .y))
    )
    class(dat) <- c("slimr_genome_output_joined",
                    class(dat))
  } else {
    names(dat) <- type
    class(dat) <- c("slimr_genome_output_list",
                    class(dat))
  }

  if(length(dat) == 1) {
    dat <- dat[[1]]
  }

  dat

}

slim_outputGS_extract_one <- function(string, type, expand_mutations, generation) {

  dat <- switch(type,

                metadat = stringr::str_match(string,
                                             stringr::regex("^(?:(.*?))\nMutations:",
                                                            dotall = TRUE))[ , 2],

                mutations = stringr::str_match(string,
                                               stringr::regex("Mutations:\n(?:(.*?))\nGenomes:",
                                                              dotall = TRUE))[ , 2],

                genomes = stringr::str_match(string,
                                     stringr::regex("Genomes:\n(?:(.*?))$",
                                                    dotall = TRUE))[ , 2] %>%
                    stringr::str_replace_all(stringr::regex("(^p[:digit:]+\\:[:digit:]+[:blank:]+[:upper:])([:blank:]+)(.*?)$",
                                                            multiline = TRUE),
                                             '\\1\\2"\\3"'),

                NULL

  )

  if(!is.na(dat)){
    if(stringr::str_detect(dat, "\n", negate = TRUE)) {
      dat <- paste(dat, "\n")
    }

    dat <- switch(type,

                  metadat = dplyr::tibble(metadata = dat),

                  mutations = suppressWarnings(readr::read_table2(dat,
                                                                  col_types = "iiciddcii",
                                                                  col_names = c("mut_id", "unique_mut_id",
                                                                                "mut_type", "chrome_pos",
                                                                                "selection", "dominance",
                                                                                "subpop", "first_gen",
                                                                                "prevalence",
                                                                                "nucleotide"))),

                  genomes = suppressWarnings(read_with_excess(dat,
                                                              col_types = "ccc",
                                                              col_names = c("gen_id", "gen_type",
                                                                            "mut_list"))) %>%
                    dplyr::mutate("mut_list" := stringr::str_split(.data$mut_list, " ")),

                  NULL
    )
  } else {
    dat <- switch(type,

                  metadat = dplyr::tibble(metadata = dat),

                  mutations = dplyr::tibble("mut_id" = NA,
                                            "unique_mut_id" = NA,
                                            "mut_type" = NA,
                                            "chrome_pos" = NA,
                                            "selection" = NA,
                                            "dominance" = NA,
                                            "subpop" = NA,
                                            "first_gen" = NA,
                                            "prevalence" = NA,
                                            "nucleotide" = NA),

                  genomes = suppressWarnings(read_with_excess(dat,
                                                              col_types = "ccc",
                                                              col_names = c("gen_id", "gen_type",
                                                                            "mut_list"))) %>%
                    dplyr::mutate("mut_list" := stringr::str_split(.data$mut_list, " ")),

                  NULL
    )
  }

  if(expand_mutations) {
    if(type == "genomes") {
      dat <- dat %>%
        tidyr::unnest_longer(col = "mut_list",
                             values_to = "mut_id",
                             indices_include = FALSE) %>%
        dplyr::mutate("mut_id" := as.integer(.data$mut_id))
    }
  } else {
    if(type == "genomes") {
      dat <- dat %>%
        dplyr::mutate("mut_list" := purrr::map(.data$mut_list,
                                               as.integer))
    }
  }

  dat %>%
    dplyr::mutate("generation" := generation)
}



slim_extract_individuals <- function(output_data, format = c("genlight", "tibble")) {

  format <- match.arg(format)

  if(inherits(output_data, "slimr_results")) {
    output_data <- output_data$output_data
  }

  dat <- purrr::pmap_dfr(list(output_data$expression, output_data$data, output_data$generation),
                        ~slim_extract_individuals_one(..1, ..2, ..3)) %>%
    dplyr::select(.data$generation, dplyr::everything())

  if(format == "genlight") {
    assert_package("adegenet")

    alleles <- dat %>%
      dplyr::select(.data$ind_id, .data$mut_id) %>%
      dplyr::group_by(.data$ind_id, .data$mut_id)

    dat_gen <- methods::new("genlight", gen = dat %>%
                   dplyr::select(dplyr::starts_with("i", ignore.case = FALSE)) %>%
                   as.matrix() %>%
                     t(),
                   position = dat$POS,
                   loc.names = dat$MID,
                   other = dat %>%
                     dplyr::select(.data$generation, .data$S:.data$MULTIALLELIC))
    adegenet::pop(dat_gen) <- dat$pop_id
    dat <- dat_gen
  }

  dat

}

slim_extract_individuals_one <- function(expression, data, generation) {
  if(any(stringr::str_detect(expression, "outputVCF"))) {
    dat <- read_VCF(data)
  } else {
    if(any(stringr::str_detect(expression, "outputFull"))) {
      dat <- slim_extract_full(dplyr::tibble(generation = generation,
                                                   expression = expression,
                                                   data = data),
                                     c("individuals", "genomes", "mutations"),
                                     join = TRUE, expand_mutations = TRUE)
    } else {
      rlang::abort(glue::glue("slimr currently doesn't support extracting individual data produced by {expression}"))
    }
  }

  dat

}

read_VCF <- function(string) {
  all_lines <- readr::read_lines(string)
  meta <- stringr::str_detect(all_lines, stringr::regex("^#"))
  meta_rle <- rle(meta)

  n_pos <- sum(meta_rle$values)

  dat_indices <- matrix(cumsum(meta_rle$lengths),
                         nrow = n_pos, byrow = TRUE)

  meta_indices <- cbind(c(1L, dat_indices[-n_pos, 2] + 1L), dat_indices[ , 1] - 1L)

  pops <- stringr::str_split(all_lines[meta_indices[ , 1]], " ") %>%
    purrr::map_chr(4)



  data <- purrr::map2_dfr(purrr::array_branch(dat_indices, 1), pops,
                          ~readr::read_tsv(all_lines[.x[1]:.x[2]]) %>%
                            dplyr::rename_at(dplyr::vars(dplyr::starts_with("i", ignore.case = FALSE)),
                                             function(z) paste0(.y, "_", z))) %>%
    dplyr::mutate("INFO" := purrr::map(.data$INFO,
                                    ~eval(rlang::parse_expr(paste0("c(",
                                                                   stringr::str_replace_all(.x, c(";" = ",", "MULTIALLELIC" = "MULTIALLELIC = 1")),
                                                                   ")"))))) %>%
    tidyr::unnest_wider(col = .data$INFO) %>%
    dplyr::mutate("MULTIALLELIC" := ifelse(is.na(.data$MULTIALLELIC), 0, .data$MULTIALLELIC)) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with("p", ignore.case = FALSE)),
                     ~stringr::str_split(.x, "\\|", simplify = TRUE) %>%
                       apply(2, as.numeric) %>% rowSums())

  data

}

#' Extract data into a genlight object
#'
#' @param x \code{slimr_results} object containing data generated by \code{slimr_output} using \code{outputVCF()} or
#' @param ... Arguments passed to or from other methods.
#' \code{outputFull()} in SLiM
#' @return A \code{genlight} object
#' @export
slim_extract_genlight <- function(x, ...) {
  UseMethod("slim_extract_genlight", x)
}

#' @export
slim_extract_genlight.slimr_results_coll <- function(x, name = NULL, by = NULL, ...) {
  if(is.null(names(x))) {
    names(x) <- paste0("rep_", seq_along(x))
  }
  furrr::future_imap_dfr(x, ~ slim_extract_genlight(.x, name = name, by = by, ...) %>%
                       dplyr::mutate(rep = .y),
                       .options = furrr::furrr_options(seed = TRUE))
}

#' @export
slim_extract_genlight.slimr_results <- function(x, name = NULL, by = NULL, ...) {

  assert_package("adegenet")

  output_data <- x$output_data

  if(!is.null(name)) {
    output_data <- output_data %>%
      dplyr::filter(.data$name == !!name)
  }

  if(!is.null(by)) {
    output_data_grouped <- output_data %>%
      dplyr::group_by(!!!rlang::syms(by))

    data_split <- output_data_grouped %>%
      dplyr::group_split() %>%
      purrr::map(~{class(.x) <- c("slimr_output_data",
                                 class(.x)); .x})

    gls <- purrr::map(data_split,
                      ~slim_extract_genlight(.x))

    dat <- dplyr::group_keys(output_data_grouped) %>%
      dplyr::mutate(genlight = gls)

  } else {
    dat <- slim_extract_genlight(output_data)
  }

  dat

}

#' @export
slim_extract_genlight.slimr_output_data <- function(x, ...) {

  assert_package("adegenet")

  alleles <- mut_dat <- NULL

  output_full <- x %>%
    dplyr::filter(stringr::str_detect(expression, "outputFull"))

  output_VCF <- x %>%
    dplyr::filter(stringr::str_detect(expression, "outputVCF"))

  output_GS <- x %>%
    dplyr::filter(stringr::str_detect(expression, "\\.output\\("))

  if(nrow(output_full) == 0 && nrow(output_VCF) == 0 && nrow(output_GS) == 0) {
    rlang::abort("You must have output generated by outputFull(), outputVCF(), or output() to extract a genlight object.")
  }

  if(nrow(output_full) > 0) {
    c(alleles, mut_dat) %<-% slim_extract_genlight_tibble_full(output_full)
    dat_gen_full <- methods::new("genlight", gen = alleles %>%
                                   dplyr::select(-.data$pop_id, -.data$ind_id) %>%
                                   as.matrix(),
                                 position = mut_dat$chrome_pos,
                                 loc.names = mut_dat$unique_mut_id,
                                 ind.names = paste0(alleles$pop_id, ":", alleles$ind_id),
                                 other = mut_dat %>%
                                   dplyr::select(.data$mut_type, .data$prevalence))
    adegenet::pop(dat_gen_full) <- alleles$pop_id
  } else {
    dat_gen_full <- NULL
  }
  if(nrow(output_VCF) > 0) {

    rlang::abort("Sorry, VCF output not yet supported.")
    #dat_VCF <- slim_extract_genlight_tibble_VCF(output_VCF)
    # dat_gen_VCF <- methods::new("genlight", gen = alleles %>%
    #                               dplyr::select(-.data$pop_id, -.data$ind_id) %>%
    #                               as.matrix(),
    #                             position = mut_dat$chrome_pos,
    #                             loc.names = mut_dat$unique_mut_id,
    #                             ind.names = paste0(alleles$pop_id, ":", alleles$ind_id),
    #                             other = mut_dat %>%
    #                               dplyr::select(.data$mut_type, .data$prevalence))
    # adegenet::pop(dat_gen_VCF) <- alleles$pop_id
  } else {
    dat_gen_VCF <- NULL
  }

  if(nrow(output_GS) > 0) {
    c(alleles, mut_dat) %<-% slim_extract_genlight_tibble_GS(output_GS)
    dat_gen_GS <- methods::new("genlight", gen = alleles %>%
                                   dplyr::select(-.data$ind_id) %>%
                                   as.matrix(),
                                 position = mut_dat$chrome_pos,
                                 loc.names = mut_dat$unique_mut_id,
                                 ind.names = alleles$ind_id,
                                 other = mut_dat %>%
                                   dplyr::select(.data$mut_type, .data$prevalence))
  } else {
    dat_gen_GS <- NULL
  }


  if(!is.null(dat_gen_full)) {
    if(!is.null(dat_gen_VCF)) {
      if(!is.null(dat_gen_GS)) {
        dat <- list(full = dat_gen_full, VCF = dat_gen_VCF,
                    GS = dat_gen_GS)
      } else {
        dat <- list(full = dat_gen_full, VCF = dat_gen_VCF)
      }
    } else {
      if(!is.null(dat_gen_GS)) {
        dat <- list(full = dat_gen_full, GS = dat_gen_GS)
      } else {
        dat <- dat_gen_full
      }
    }
  } else {
    if(!is.null(dat_gen_VCF)) {
      if(!is.null(dat_gen_GS)) {
        dat <- list(VCF = dat_gen_VCF, GS = dat_gen_GS)
      } else {
        dat <- dat_gen_VCF
      }
    } else {
      if(!is.null(dat_gen_GS)) {
        dat <- dat_gen_GS
      } else {
        dat <- list()
      }
    }
  }

  dat

}

slim_extract_genlight_tibble_full <- function(output_full) {

  inds <- slim_extract_full(output_full,
                                  c("individuals",
                                    "genomes"),
                                  join = TRUE,
                                  expand_mutations = TRUE)

  muts <- slim_extract_full(output_full,
                                  "mutations")

  suppressMessages(
    alleles <- inds %>%
      dplyr::left_join(muts %>% dplyr::select(.data$mut_id, .data$unique_mut_id)) %>%
      dplyr::select(.data$pop_id, .data$ind_id, .data$unique_mut_id) %>%
      dplyr::mutate("present" := 1) %>%
      dplyr::group_by(.data$pop_id, .data$ind_id, .data$unique_mut_id) %>%
      dplyr::summarise("count" := sum(.data$present), .groups = "drop") %>%
      dplyr::sample_frac()
  )

  suppressMessages(
    mut_dat <- alleles %>%
      dplyr::select(.data$unique_mut_id) %>%
      dplyr::distinct() %>%
      dplyr::left_join(muts %>%
                         dplyr::select(.data$unique_mut_id,
                                       .data$chrome_pos,
                                       .data$mut_type,
                                       .data$prevalence))
  )
  alleles <- alleles %>%
    tidyr::pivot_wider(id_cols = c("pop_id", "ind_id"),
                       names_from = "unique_mut_id",
                       values_from = "count",
                       values_fill = 0)

  list(alleles = alleles, mut_dat = mut_dat)

}

slim_extract_genlight_tibble_GS <- function(output_GS) {

  inds <- slim_outputGS_extract(output_GS,
                                c("genomes"),
                                join = TRUE,
                                expand_mutations = TRUE)

  ind_df <- dplyr::tibble(gen_id = unique(inds$gen_id)) %>%
    dplyr::mutate(ind_id = rep(1:(dplyr::n() / 2), each = 2))

  suppressMessages(
    inds <- inds %>%
      dplyr::left_join(ind_df)
  )

  muts <- slim_outputGS_extract(output_GS,
                                "mutations")

  suppressMessages(
    alleles <- inds %>%
      dplyr::left_join(muts %>% dplyr::select(.data$mut_id, .data$unique_mut_id)) %>%
      dplyr::select(.data$ind_id, .data$unique_mut_id) %>%
      dplyr::mutate("present" := 1) %>%
      dplyr::group_by(.data$ind_id, .data$unique_mut_id) %>%
      dplyr::summarise("count" := sum(.data$present), .groups = "drop") %>%
      dplyr::sample_frac()
  )

  suppressMessages(
    mut_dat <- alleles %>%
      dplyr::select(.data$unique_mut_id) %>%
      dplyr::distinct() %>%
      dplyr::left_join(muts %>%
                         dplyr::select(.data$unique_mut_id,
                                       .data$chrome_pos,
                                       .data$mut_type,
                                       .data$prevalence))
  )
  alleles <- alleles %>%
    tidyr::pivot_wider(id_cols = c("ind_id"),
                       names_from = "unique_mut_id",
                       values_from = "count",
                       values_fill = 0)

  list(alleles = alleles, mut_dat = mut_dat)

}

read_with_excess <- function(string, col_names, col_types) {

  txt <- readr::read_lines(string)
  ncol <- length(col_names)
  split_it <- stringr::str_split_fixed(txt, " ", ncol) %>%
    as.data.frame() %>%
    stats::setNames(col_names) %>%
    readr::type_convert(col_types)

  return(split_it)

}
