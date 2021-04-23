callbacks <- list()

callbacks$initialize <- function() {
  cb <- "initialize()"
  class(cb) <- "callback"
  cb
}

callbacks$early <- function() {
  cb <- "early()"
  class(cb) <- "callback"
  cb
}

callbacks$late <- function() {
  cb <- "late()"
  class(cb) <- "callback"
  cb
}

callbacks$fitness <- function(mut_type_id, subpop_id) {

  argus <- rlang::enexprs(mut_type_id, subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(fitness(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks$mateChoice <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(mateChoice(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks$modifyChild <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(modifyChild(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks$recombination <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(recombination(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks$interaction <- function(int_type_id, subpop_id) {

  argus <- rlang::enexprs(int_type_id, subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(interaction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM reproduction() callback
#'
#' This callback specifies that a code block is providing logic for the production
#' of offspring. It is called once per individual for each generation in which it is active,
#' and is expected to add new individuals to the simulation using the SLiM functions provided
#' for that purpose. This is only used in "nonWF" simulations.
#' For more information on how to use \code{reproduction()} callback
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=606}{SLiM Manual: page 606}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{individual}{The focal individual that is expected to reproduce}
#'   \item{genome1}{One genome of the focal individual}
#'   \item{genome2}{The other genome of the focal individual}
#'   \item{subpop}{The subpopulation to which the focal individual belongs}
#' }
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @param sex The sex of the individuals to apply this callback to.
#'
#' @return None
#' @export
#'
#' @examples
#' slim_block(reproduction()) {
#'
#'   subpop.addCrossed(individual, subpop.sampleIndividuals(1))
#'
#' }
reproduction <- function(subpop_id, sex) {
  callbacks$reproduction(subpop_id, sex)
}

callbacks$reproduction <- function(subpop_id, sex) {

  argus <- rlang::enexprs(subpop_id, sex)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(reproduction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks <- list2env(callbacks)
