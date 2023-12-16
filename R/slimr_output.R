#' Tell SLiM to produce easily parseable output
#'
#' Use this function in a \code{\link{slim_block}} call and it will be
#' converted in the SLiM script into code to make formatted output.
#' This output can easily be read into R and even dynamically read
#' during simulation runs with \code{\link[slimr]{slim_run}} from the
#' \code{slimr} package. This function should generally only be
#' used within a \code{\link{slim_block}} call
#'
#' @param slimr_expr A SLiM expression to generate output. This can either be
#' a SLiM expression designed to create output, such as \code{outputFull()},
#' or an object created in the SLiM code, in which case \code{slimr_output}
#' will automatically concatenate it to a string and output it
#' @param name The name to use to identify this output.
#' @param do_every How often should the output be produced? Expressed
#' as an integer saying how many generations to run before producing output.
#' e.g. \code{do_every = 10} means to output every 10 generations of the
#' simulation.
#' @param send_to \strong{*deprecated*} Where to send the output? This could be used
#' to send the output to be stored in the results object ("data"), or to an external file ("file").
#' This will no longer be available in future versions in favour of an option to have the results
#' stored as a pointer to an external file (to save memory).
#' @param file_name \strong{*deprecated*} The file name to save output to if \code{send_to = "file"}
#' @param format \strong{*deprecated*} The file format to save data if \code{send_to = "file"}, Only "csv" is implemented
#' but there are plans to support "fst" and "disk.frame".
#' @param type Provide a custom type to the output. Used mostly for internal purposes.
#' @param expression Provide a custom expression to be included with the output.
#' Used mostly for internal purposes.
#' @param time_counter Expression used to extract the simulation time from SLiM. By default this
#' uses the global timing mechanism in SLiM version >4.0: `community.tick`. For versions <4.0,
#' use `sim.generation` instead (this parameter is for backwards compatability with old SLiM versions)
#'
#' @return An expression with the code to be run in SLiM.
#'
#' @export
#'
#' @examples
#' if(slim_is_avail()) {
#' slim_script(
#'   slim_block(initialize(),
#'              {
#'                initializeMutationRate(1e-7);
#'                initializeMutationType("m1", 0.5, "f", 0.0);
#'                initializeGenomicElementType("g1", m1, 1.0);
#'                initializeGenomicElement(g1, 0, 99999);
#'                initializeRecombinationRate(1e-8);
#'              }),
#'   slim_block(1,
#'              {
#'                sim.addSubpop("p1", 100);
#'              }),
#'   slim_block(100,
#'              {
#'                r_output(p1.outputVCFSample(sampleSize = 10), name = "VCF");
#'                sim.simulationFinished();
#'              })
#' ) %>%
#' slim_run() -> run_w_out
#'
#' cat(run_w_out$output_data$data[[1]])
#' }
r_output <- function(slimr_expr, name, do_every = 1,
                         send_to = c("data", "file"),
                         file_name = tempfile(fileext = ".txt"),
                         format = c("csv", "fst"),
                         type = NULL,
                         expression = NULL,
                         time_counter = community.tick) {

  send_to = match.arg(send_to)
  format = match.arg(format)

  if(send_to == "file" & format == "fst") {
    assert_package("fst")
  }

  slimr_expr <- rlang::enexpr(slimr_expr)

  if(is.null(expression)) {
    expr_txt <- expr_deparse_fast(slimr_expr)
  } else {
    expr_txt <- expression
  }


  if(!is.null(type)) {

    new_code <- rlang::expr(
      if(!!rlang::enexpr(time_counter) %% !!do_every == 0) {
        cat("\n<slimr_out:start>\n" + paste(!!rlang::enexpr(time_counter)) + ",'" +
              !!name + "','" + !!expr_txt + "','" + !!type + "','")
        cat(!!slimr_expr)
        cat("'\n<slimr_out:end>\n")
      }
    )

  } else {

    if(slimr_code_detect_output(expr_txt)) {
      new_code <- rlang::expr(
        if(!!rlang::enexpr(time_counter) %% !!do_every == 0) {
          cat("\n<slimr_out:start>\n" + paste(!!rlang::enexpr(time_counter)) + ",'" +
                !!name + "','" + !!expr_txt + "','" + "slim_output','")
          !!slimr_expr
          cat("'\n<slimr_out:end>\n")
        }
      )
    } else {

      new_code <- rlang::expr(
        if(!!rlang::enexpr(time_counter) %% !!do_every == 0) {
          cat("\n<slimr_out:start>\n" + paste(!!rlang::enexpr(time_counter)) + ",'" +
                !!name + "','" + !!expr_txt + "','")
          str(!!slimr_expr)
          cat("','")
          cat(paste(!!slimr_expr))
          cat("'\n<slimr_out:end>\n")
        })

    }
  }

  code_for_display <- paste0("{", rlang::expr_text(slimr_expr, width = 500),
                             " -> ", name, "}")

  .resources$temp_slimr_output$code_for_slim <- c(.resources$temp_slimr_output$code_for_slim,
                                                  rlang::expr_text(new_code, width = 500))
  .resources$temp_slimr_output$code_for_display <- c(.resources$temp_slimr_output$code_for_display,
                                                     code_for_display)
  .resources$temp_slimr_output$output_name <- c(.resources$temp_slimr_output$output_name,
                                                name)

  if(send_to == "file") {
    .resources$temp_slimr_output$file_name <- c(.resources$temp_slimr_output$file_name,
                                                file_name)
    .resources$temp_slimr_output$format <- c(.resources$temp_slimr_output$format,
                                                format)
  } else {
    .resources$temp_slimr_output$file_name <- c(.resources$temp_slimr_output$file_name,
                                                NA)
    .resources$temp_slimr_output$format <- c(.resources$temp_slimr_output$format,
                                                NA)
  }

  rlang::sym(paste0(".__slmr_output_object_",
                    length(.resources$temp_slimr_output$code_for_slim),
                    "___"))
  #new_code

}

#' @rdname r_output
#' @export
slimr_output <- r_output

sout <- function(slimr_expr, name, do_every = NULL,
                 send_to = c("data", "file"),
                 file_name = tempfile(fileext = ".txt"),
                 format = c("csv", "fst")) {
  slimr_output(slimr_expr, name, do_every,
               send_to, file_name, format)
}

out_replace <- function(code) {
  code <- stringr::str_replace_all(code, "slimr_output", "!!slimr_output")
  code <- stringr::str_replace_all(code, "([^m])r_output", "\\1!!r_output")
  code <- stringr::str_replace_all(code, "^r_output", "!!r_output")
  code <- stringr::str_replace_all(code, "sout", "!!sout")
  code_expr <- rlang::parse_exprs(paste(code, collapse = "\n"))
  code <- purrr::map(code_expr, ~rlang::expr_interp(.x)) %>%
    unlist()
  code <- purrr::map(code,
                     ~expr_deparse_fast(.x))

  if(any(purrr::map_lgl(code, ~inherits(.x, "list")))) {
    code <- code %>%
      purrr::flatten()
  }
  code
}

gather_out_one <- function(code_one) {
  .resources$temp_slimr_output$code_for_slim <- list()
  .resources$temp_slimr_output$output_name <- list()
  .resources$temp_slimr_output$code_for_display <- list()
  .resources$temp_slimr_output$file_name <- list()
  .resources$temp_slimr_output$format <- list()

  code_one <- out_replace(code_one)
  output_info <- list(code_for_slim = .resources$temp_slimr_output$code_for_slim,
                      code_for_display = .resources$temp_slimr_output$code_for_display,
                      output_name = .resources$temp_slimr_output$output_name,
                      file_name = .resources$temp_slimr_output$file_name,
                      format = .resources$temp_slimr_output$format)
  list(new_code = code_one, output_info = output_info)
}

gather_out <- function(code) {
  res <- purrr::map(code,
                    ~gather_out_one(.x))
  res
}

process_output <- function(code, block_names) {
  output_processed <- gather_out(as.character(code)) %>%
    purrr::transpose()

  slimr_output_attr <- purrr::transpose(output_processed$output_info) %>%
    dplyr::as_tibble() %>%
    dplyr::mutate("block_name" := block_names) %>%
    tidyr::unnest(c("code_for_slim", "code_for_display", "output_name",
                    "file_name", "format"),
                  keep_empty = TRUE) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display", "output_name",
                       "file_name", "format"),
                     ~purrr::map(.,
                                 ~ purrr::`%||%`(.x, NA))) %>%
    dplyr::mutate_at(c("code_for_slim", "code_for_display", "output_name",
                       "file_name", "format"),
                     ~list_unchop(.))

  #new_code <- SLiMify_all(output_processed$new_code)

  new_code <- purrr::map(output_processed$new_code,
                         ~unlist(.x))

  list(new_code, slimr_output_attr)
}

#' Utility function to tell SLiM to output its outputFull() output
#'
#' @param name Name of output to use to label it in \code{slimr_results object}. Default is \code{"full_output"}
#' @param ... Other arguments to be passed to \code{\link{r_output}}
#' @export
r_output_full <- function(name = "full_output", ...) {
  r_output(sim.outputFull(), name)
}

#' @rdname r_output_full
#' export
slimr_output_full <- r_output_full


#' Utility function to tell SLiM to output Nucleotides
#'
#' @param name Name of output to use to label it in \code{slimr_results object}. Default is \code{"seqs"}.
#' @param subpops Should the subpopulation of each sequence be outputted as well?
#' @param inds SLiM expression that returns the individuals to get nucleotides from. By default all
#' individuals are returned.
#' @param ... Other arguments to be passed to \code{\link{r_output}}
#' @return None
#' @export
r_output_nucleotides <- function(name = "seqs", subpops = FALSE, both_genomes = FALSE, inds = NULL, ...) {

  inds <- rlang::enexpr(inds)
  if(is.null(inds)) {
    inds <- rlang::expr(sim.subpopulations.individuals)
  }

  if(!both_genomes) {
    if(subpops) {
      out1 <- slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".genome1.nucleotides())")),
                   name, type = "slim_nucleotides",
                   expression = "slimr_output_nucleotides()",
                   ...)
      out2 <- slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".subpopulation)")),
                   paste0(name, "_subpops"), type = "slim_nucleotides",
                   expression = "slimr_output_nucleotides()",
                   ...)
      return(list(out1, out2))
    } else {
      slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".genome1.nucleotides())")),
                   name, type = "slim_nucleotides",
                   expression = "slimr_output_nucleotides()",
                   ...)
    }
  } else {

    if(subpops) {
      out1 <- slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".genomes.nucleotides())")),
                           name, type = "slim_nucleotides_both",
                           expression = "slimr_output_nucleotides()",
                           ...)
      out2 <- slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".subpopulation)")),
                           paste0(name, "_subpops"), type = "slim_nucleotides_both",
                           expression = "slimr_output_nucleotides()",
                           ...)
      return(list(out1, out2))
    } else {
      slimr_output(!!rlang::parse_expr(paste0("paste(", rlang::expr_deparse(inds), ".genomes.nucleotides())")),
                   name, type = "slim_nucleotides_both",
                   expression = "slimr_output_nucleotides()",
                   ...)
    }

  }
}

#' @rdname r_output_nucleotides
#' @export
slimr_output_nucleotides <- r_output_nucleotides

#' Utility function to tell SLiM to output coordinates from spatial simulations
#'
#' @param dimensionality What dimensionality should be output? Can be
#' "x", "xy", or "xyz".
#' @param ... Other arguments to be passed to \code{\link{r_output}}
#' @details Outputs x, y, and z coordinates as separate entries in \code{slimr_results},
#' with names "x", "y", and "z".
#'
#' @return None
#'
#' @export
r_output_coords <- function(dimensionality = c("x", "xy", "xyz"),
                                ...) {

  out <- slimr_output(sim.subpopulations.individuals.x,
               "x", ...)

  if(dimensionality %in% c("xy", "xyz")) {
    y_out <- slimr_output(sim.subpopulations.individuals.y,
                          "y", ...)
    out <- list(out, y_out)
  }

  if(dimensionality %in% c("xyz")) {
    z_out <- slimr_output(sim.subpopulations.individuals.z,
                          "z", ...)
    out <- c(out, list(z_out))
  }

  return(out)

}

#' @rdname r_output_coords
#' @export
slimr_output_coords <- r_output_coords

#' Utility function to tell SLim to output sexes of individuals
#'
#' @param name Name of output to use to label it in \code{slimr_results object}. Default is \code{"sex"}.
#'
#' @param ... Other arguments to be passed to \code{\link{r_output}}
#'
#' @return None
#'
#' @export
r_output_sex <- function(name = "sex", ...) {

  r_output(sim.subpopulations.individuals.sex,
           name, ...)

}

#' @rdname r_output_sex
#' @export
slimr_output_sex <- r_output_sex

#' Utility function to tell SLiM to output SNP format data
#'
#' Use \code{\link{slim_results_to_data}} on the \code{\link{slim_run}} results to get this in a nice SNP matrix form.
#'
#' @param name Name of output to use to label it in \code{slimr_results object}. Default is \code{"snp"}.
#' @param subpops Should the subpopulation of each sequence be outputted as well?
#' @param ... Other arguments to be passed to \code{\link{r_output}}
#'
#' @return None
#' @export
#'
#' @examples
r_output_snp <- function(name = "snp", subpops = FALSE, ...) {
  if(subpops) {
    snp_out <- slimr_output(paste(size(sim.subpopulations.individuals),
                                  size(sim.mutations),
                                  sim.subpopulations.individuals.genomes.containsMutations(sim.mutations)),
                            name, type = "slim_snp",
                            expression = "slimr_output_snp()",
                            ...)
    pos_out <- slimr_output(sim.mutations.position,
                           paste0(name, "_pos"), type = "slim_snp",
                           expression = "slimr_output_snp()",
                           ...)
    subpop_out <- slimr_output(paste(sim.subpopulations.individuals.subpopulation),
                         paste0(name, "_subpops"), type = "slim_snp",
                         expression = "slimr_output_snp()",
                         ...)
    return(list(snp_out, pos_out, subpop_out))
  } else {
    snp_out <- slimr_output(paste(size(sim.subpopulations.individuals),
                                  size(sim.mutations),
                                  sim.subpopulations.individuals.genomes.containsMutations(sim.mutations)),
                            name, type = "slim_snp",
                            expression = "slimr_output_snp()",
                            ...)
    pos_out <- slimr_output(sim.mutations.position,
                           paste0(name, "_pos"), type = "slim_snp",
                           expression = "slimr_output_snp()",
                           ...)
    return(list(snp_out, pos_out))
  }
}

#' @rdname r_output_snp
#' @export
slimr_output_snp <- r_output_snp
