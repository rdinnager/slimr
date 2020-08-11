#' Insert slim_block to track progress when using slim_run
#'
#' @param update_every
#'
#' @return
#' @export
slim_block_progress <- function(update_every = 1) {
  slim_block(late(), {
    slimr_output(sim.generation, "progress", do_every = !!update_every)
  })
}

slim_block_init_single <- function(mutation_rate = 1e-7,
                                   dominance = 0.5,
                                   selection = 0.0,
                                   dist_type = "f",
                                   genome_size = 100000,
                                   recombination_rate = 1e-8) {

  slim_block(initialize(), {
    initializeMutationRate(!!mutation_rate);
    initializeMutationType("m1", !!dominance, "f", !!selection);
    initializeGenomicElementType("g1", m1, 1.0);
    initializeGenomicElement(g1, 0, !!genome_size - 1L);
    initializeRecombinationRate(!!recombination_rate);
  })

}
