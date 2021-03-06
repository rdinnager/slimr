#' Create a file to initialise a population in SLiM
#'
#' Make a SLiM file in the style of \code{outputFull()} which can be read by SLiM. This is useful to
#' start a simulation with a particular population state that you define in R
#'
#' @param snps R object containing SNPs. Can be a matrix with 0, 1, or 2 as its elements,
#' or a \code{genlight} object. Rows correspond to individuals, columns to loci.
#' @param file_name Path to file where the population input file should be saved.
#' @param sim_gen What generation to write in the file. This doesn't really do anything, but is just a requirement
#' for the format.
#' @param ind_pops An optional character vector with length equal to \code{nrow(snps)} with Subpopulation indicators for
#' each individual. Should be "p1", "p2", etc. as this is how subpopulations are named in SLiM.
#' @param ind_sex An optional character vector with length equal to \code{nrow(snps)} with the sex for each individual (can be
#' "H" for hermaphrodite, "F" for female, or "M" for male.)
#' @param mut_pos An optional integer vector with length equal to \code{ncol(snps)} specifying the positions in the genome
#' of each loci.
#' @param mut_type An optional character vector with length equal to \code{nrow(snps)} with the mutation type of each loci.
#' Should be "m1", "m2", etc. as this is how mutation types are named in SLiM.
#' @param mut_sel An optional numeric vector with length equal to \code{nrow(snps)} with the selection coefficient for the
#' mutation type of each loci.
#' @param mut_dom An optional numeric vector with length equal to \code{nrow(snps)} with the dominance coefficient for the
#' mutation type of each loci.
#' @param mut_pop An optional character vector with length equal to \code{nrow(snps)} with the subpopulation of origin
#' for the mutation at each loci. Should be "p1", "p2", etc. as this is how subpopulations are named in SLiM.
#' @param mut_gen An optional integer vector with length equal to \code{ncol(snps)} specifying the generation of origin
#' for the mutation at each loci.
#' @param mut_nuc An optional character vector with length equal to \code{nrow(snps)} with the nucleotide of the
#' mutation. Should be "A", "C", "G", or "T".
#' @param version SLiM output version number to use.
#'
#' @return Returns the file name where the population data was saved
#' @export
#'
#' @examples
#' pop_file <- slim_make_pop_input(matrix(rbinom(1000, 2, 0.25), nrow = 100, ncol = 100))
#' cat(readLines(pop_file))
slim_make_pop_input <- function(snps, file_name = tempfile(), sim_gen = 10000, ind_pops = NULL,
                                ind_sex = NULL, mut_pos = NULL, mut_type = NULL, mut_sel = NULL,
                                mut_dom = NULL, mut_pop = NULL, mut_gen = NULL, mut_nuc = NULL,
                                version = 4) {

  if(inherits(snps, "genlight")) {
    snps <- as.matrix(snps)
  }

  if(inherits(snps, "matrix")) {
    n_inds <- nrow(snps)
    if(max(snps) < 2) {
      n_gen <- n_inds * 2
    } else {
      n_gen <- n_inds
    }
    mut_prev <- apply(snps, 2, sum)
    real_snps <- mut_prev > 0
    n_mut <- sum(real_snps)
    snps <- snps[ , real_snps]
  }

  nas <- apply(snps, 2, function(x) !any(!is.finite(x)))
  if(any(!nas)) {
    rlang::warn("snp matrix has missing values.. snp positions with missing values have been removed.")
  }
  snps <- snps[ , nas]

  if(ncol(snps) == 0) {
    rlang::abort("no snps left after removing positions with missing value")
  }

  first_line <- glue::glue("#OUT {sim_gen} A")
  # line_2 <- if(is.null(ind_age)) {
  #   "Version: 3"
  # } else {
  #   "Version: 4"
  # }

  line_2 <- paste0("Version: ", version)

  if(is.null(ind_pops)) {
    ind_pops <-  rep("p1", n_inds)
  } else {
    ind_pops <- as.factor(ind_pops)
    levels(ind_pops) <- paste0("p", 1:nlevels(ind_pops))
  }
  if(is.null(ind_sex)) {
    ind_sex <- rep("H", n_inds)
  }

  pops <- dplyr::tibble(pop = ind_pops, sex = ind_sex) %>%
    dplyr::group_by(.data$pop) %>%
    dplyr::summarise("size" := dplyr::n(),
                     "sim_sex" := ifelse(.data$sex[1] == "H", "H", "S"),
                     "sex_ratio" := table(.data$sex)[1] / .data$size,
                     .groups = "drop")
  if(pops$sim_sex[1] == "H") {
    pops <- pops %>%
      dplyr::select(-.data$sex_ratio)
  }
  tmp <-tempfile()
  readr::write_delim(pops, tmp, " ", col_names = FALSE)
  pops_txt <- readr::read_lines(tmp) %>%
    paste(collapse = "\n")

  if(is.null(mut_type)) {
    mut_type <- rep("m1", n_mut)
  } else {
    mut_type <- mut_type[real_snps]
  }
  if(is.null(mut_pos)) {
    mut_pos <- 0:(n_mut - 1L)
  } else {
    mut_pos <- mut_pos[real_snps]
  }
  if(is.null(mut_sel)) {
    mut_sel <- rep(0, n_mut)
  } else {
    mut_sel <- mut_sel[real_snps]
  }
  if(is.null(mut_dom)) {
    mut_dom <- rep(0.5, n_mut)
  } else {
    mut_dom <- mut_dom[real_snps]
  }
  if(is.null(mut_pop)) {
    mut_pop <- rep("p1", n_mut)
  } else {
    mut_pop <- mut_type[real_snps]
  }
  if(is.null(mut_gen)) {
    mut_gen <- rep(1, n_mut)
  } else {
    mut_gen <- mut_gen[real_snps]
  }
  if(is.null(mut_prev)) {
    mut_prev <- rep(1, n_mut)
  } else {
    mut_prev <- mut_prev[real_snps]
  }
  muts <- dplyr::tibble(id = 0:(n_mut - 1L),
                        id_orig = 0:(n_mut - 1L),
                        mut_type = mut_type,
                        mut_pos = mut_pos + 1L,
                        mut_sel = mut_sel,
                        mut_dom = mut_dom,
                        mut_pop = mut_pop,
                        mut_gen = mut_gen,
                        mut_prev = mut_prev)
  if(!is.null(mut_nuc)) {
    muts <- muts %>%
      dplyr::mutate("mut_nuc" := mut_nuc[real_snps])
  }

  readr::write_delim(muts, tmp, " ", col_names = FALSE)
  muts_txt <- readr::read_lines(tmp) %>%
    paste(collapse = "\n")

  suppressMessages(
    all_gens <- paste(rep(pops$pop, times = pops$size * 2),
                      sequence(pops$size * 2) - 1L,
                      sep = ":") %>%
      matrix(nrow = n_inds, byrow = TRUE) %>%
      dplyr::as_tibble(.name_repair = "universal") %>%
      dplyr::mutate("pop" := rep(pops$pop, times = pops$size))
  )

  inds <- dplyr::tibble(pop = ind_pops,
                        sex = ind_sex) %>%
    dplyr::group_by(.data$pop) %>%
    dplyr::mutate("ind_num" := 0:(dplyr::n() - 1L),
                  "ind" := paste0("i", .data$ind_num),
                  "gen_1" := (.data$ind_num) * 2,
                  "gen_2" = (.data$ind_num) * 2 + 1L) %>%
    dplyr::ungroup() %>%
    dplyr::mutate("pop_ind" := paste(.data$pop, .data$ind, sep = ":"),
                  "genome_1" := paste(.data$pop, .data$gen_1, sep = ":"),
                  "genome_2" := paste(.data$pop, .data$gen_2, sep = ":")) %>%
    dplyr::select(.data$pop_ind, .data$sex, .data$genome_1, .data$genome_2)
  # if(!is.null(ind_coord)) {
  #   inds <- inds %>%
  #     dplyr::mutate("coords" := ind_coord)
  # }
  #
  # if(!is.null(ind_age)) {
  #   inds <- inds %>%
  #     dplyr::mutate("age" := ind_age)
  # }

  readr::write_delim(inds, tmp, " ", col_names = FALSE)
  inds_txt <- readr::read_lines(tmp) %>%
    paste(collapse = "\n")

  one_genome <- purrr::map(purrr::array_branch(snps, 1),
                           ~which(.x == 1) - 1L)
  two_genome <- purrr::map(purrr::array_branch(snps, 1),
                           ~which(.x == 2) - 1L)

  make_gen <- function(ind, gen_type, one, two) {
    one_muts <- sample(one, stats::rbinom(1, length(one), 0.5))
    two_muts <- setdiff(one, one_muts)
    one_muts <- c(one_muts, two)
    two_muts <- c(two_muts, two)
    paste(paste(ind[1], gen_type[1], paste(unname(one_muts[order(one_muts)]), collapse = " ")),
          paste(ind[2], gen_type[1], paste(unname(two_muts[order(two_muts)]), collapse = " ")),
          sep = "\n")
  }

  #if(is.null(gen_type)) {
  gen_type <- matrix(rep("A", n_gen), nrow = n_inds, byrow = TRUE)
  #}
  gens_txt <- purrr::pmap_chr(list(purrr::array_branch(inds %>%
                                                     dplyr::select(-.data$pop_ind, -.data$sex) %>%
                                                     as.matrix(), 1),
                               purrr::array_branch(gen_type, 1),
                               one_genome,
                               two_genome),
                          ~make_gen(..1, ..2, ..3, ..4)) %>%
    paste(collapse = "\n")

  full_text <- glue::glue(
  "{first_line}
{line_2}
Populations:
{pops_txt}
Mutations:
{muts_txt}
Individuals:
{inds_txt}
Genomes:
{gens_txt}")

  readr::write_lines(full_text, file_name)

  file_name
}
