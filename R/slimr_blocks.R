#' Insert slim_block to track progress when using slim_run
#'
#' @param update_every How often to update progress, expressed as the number
#' of generations after which an update should be tracked.
#'
#' @return A \code{slimr_block} object
#' @export
#' @example
#' slim_script(
#'   slim_block_init_minimal(),
#'   slim_block_progress(10),
#'   slim_block_finish(100)
#' )
slim_block_progress <- function(update_every = 1) {
  slim_block(late(), {
    slimr_output(sim.generation, "progress", do_every = !!update_every)
  })
}

#' Generate minimal initialize() block
#'
#' This function creates a minimal initialize block, allowing you to
#' set some basic parameters, but generally only allowing for one type
#' of mutation, which is distributed across the whole genome.
#'
#' @param mutation_rate The overall mutation rate.
#' @param dominance The overall dominance value.
#' @param selection Mean selection strength for mutations
#' @param dist_type Distribution from which to draw mutation selection values (see
#' \code{\link{initializeMutationType}} for possible values).
#' @param genome_size Genome size of the population, in number of loci.
#' @param recombination_rate Overall recombination rate.
#' @param seed An optional integer used to set a random seed for the SLiM simulation.
#'
#' @return A \code{slimr_block} object
#' @export
#' @example
#' slim_script(
#'   slim_block_init_minimal(),
#'   slim_block_finish(100)
#' )
slim_block_init_minimal <- function(mutation_rate = 1e-7,
                                   dominance = 0.5,
                                   selection = 0.0,
                                   dist_type = "f",
                                   genome_size = 100000,
                                   recombination_rate = 1e-8,
                                   seed = NULL) {

  if(is.null(seed)) {
    slim_block(initialize(), {
      initializeMutationRate(!!rlang::enexpr(mutation_rate));
      initializeMutationType("m1", !!rlang::enexpr(dominance),
                             "f", !!rlang::enexpr(selection));
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, !!rlang::enexpr(genome_size) - 1L);
      initializeRecombinationRate(!!rlang::enexpr(recombination_rate));
    })
  } else {
    slim_block(initialize(), {
      setSeed(!!seed);
      initializeMutationRate(!!rlang::enexpr(mutation_rate));
      initializeMutationType("m1", !!rlang::enexpr(dominance),
                             "f", !!rlang::enexpr(selection));
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, !!rlang::enexpr(genome_size) - 1L);
      initializeRecombinationRate(!!rlang::enexpr(recombination_rate));
    })
  }

}

#' Generate simulationFinished Block
#'
#' This generates a simple block to end a SLiM simulation.
#'
#' @param generation Generation to end the simulation at.
#'
#' @return A \code{slimr_block} object
#' @export
#'
#' @examples
#' slim_script(
#'   slim_block_init_minimal(),
#'   slim_block_finish(100)
#' )
slim_block_finish <- function(generation) {
  slim_block(!!generation, {
    sim.simulationFinished()
  })
}

#' Generate a code block that just adds subpopulations to a SLiM simulation
#'
#' @param n_pop Number of subpopulations to add
#' @param sizes Population sizes of subpopulations. Should have a length equal to \code{n_pop}, or
#' else a length of 1 (in which case it will be recycled to \code{n_pop})
#' @param generation The generation to add the subpopulations (default: 1)
#' @param when When to add the subpopulations ("early" or "late"). Default: "early"
#'
#' @return A \code{slimr_block} object
#' @export
#'
#' @examples
#' slim_block_add_subpops(2, 100)
slim_block_add_subpops <- function(n_pop = 1, sizes, generation = 1, when = c("early", "late")) {
  when <- match.arg(when)

  if(length(sizes) != 1 && length(sizes) != n_pop) {
    rlang::abort("length of sizes should be equal to n_pop or 1")
  } else {
    if(length(sizes) == 1 && n_pop > 1) {
      sizes <- rep(sizes, n_pop)
    }
  }

  if(n_pop == 1) {
    if(when == "early") {
      slim_block(!!generation, early(), {
        sim.addSubpop("p1", !!sizes[1])
      })
    } else {
      slim_block(!!generation, late(), {
        sim.addSubpop("p1", !!sizes[1])
      })
    }
  } else {
    if(when == "early") {
      slim_block(!!generation, early(), {
        !!rlang::parse_expr(c("{\n", purrr::map_chr(seq_len(n_pop),
                                                  ~glue::glue("sim.addSubpop(p{.x}, {sizes[.x]})")),
                            "\n}") %>%
                            paste(collapse = "\n"))

      })
    } else {
      slim_block(!!generation, late(), {
        !!rlang::parse_expr(c("{\n", purrr::map_chr(seq_len(n_pop),
                                                  ~glue::glue("sim.addSubpop(p{.x}, {sizes[.x]})")),
                            "\n}") %>%
                            paste(collapse = "\n"))

      })
    }
  }
}
