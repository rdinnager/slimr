#' Insert slim_block to track progress when using slim_run
#'
#' @param update_every How often to update progress, expressed as the number
#' of generations after which an update should be tracked.
#'
#' @return
#' @export
slimr_block_progress <- function(update_every = 1) {
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
#' \code{\link{InitializeMutationType}} for possible values).
#' @param genome_size Genome size of the population, in number of loci.
#' @param recombination_rate Overall recombination rate.
#'
#' @export
slimr_block_init_minimal <- function(mutation_rate = 1e-7,
                                   dominance = 0.5,
                                   selection = 0.0,
                                   dist_type = "f",
                                   genome_size = 100000,
                                   recombination_rate = 1e-8) {

  slim_block(initialize(), {
    initializeMutationRate(!!rlang::enexpr(mutation_rate));
    initializeMutationType("m1", !!rlang::enexpr(dominance),
                           "f", !!rlang::enexpr(selection));
    initializeGenomicElementType("g1", m1, 1.0);
    initializeGenomicElement(g1, 0, !!rlang::enexpr(genome_size) - 1L);
    initializeRecombinationRate(!!rlang::enexpr(recombination_rate));
  })

}
