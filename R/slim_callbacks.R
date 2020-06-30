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

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks$mateChoice <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(mateChoice(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks$modifyChild <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(modifyChild(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks$recombination <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(recombination(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks$interaction <- function(int_type_id, subpop_id) {

  argus <- rlang::enexprs(int_type_id, subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(interaction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks$reproduction <- function(subpop_id, sex) {

  argus <- rlang::enexprs(subpop_id, sex)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(reproduction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_deparse(cb)

  class(cb) <- "callback"
  cb

}

callbacks <- list2env(callbacks)
