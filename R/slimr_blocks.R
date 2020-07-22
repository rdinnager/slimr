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
