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

callbacks$fitness <- function(mut_type_id = "", subpop_id = "") {
  cb <- glue::glue("fitness({mut_type_id}, {subpop_id})")
  class(cb) <- "callback"
  cb
}

callbacks$mateChoice <- function(subpop_id = "") {
  if(missing(subpop_id)) {
    cb <- glue::glue('mateChoice()')
  } else {
    cb <- glue::glue('mateChoice("{subpop_id}")')
  }
  class(cb) <- "callback"
  cb
}

callbacks$modifyChild <- function(subpop_id) {
  cb <- glue::glue("modifyChild({subpop_id})")
  class(cb) <- "callback"
  cb
}

callbacks$recombination <- function(subpop_id) {
  cb <- glue::glue("recombination({subpop_id})")
  class(cb) <- "callback"
  cb
}

callbacks$interaction <- function(int_type_id = NULL, subpop_id = NULL) {
  cb <- glue::glue("interaction({int_type_id}, {subpop_id})")
  class(cb) <- "callback"
  cb
}

callbacks$reproduction <- function(subpop_id, sex) {
  cb <- glue::glue("reproduction({subpop_id}, {sex})")
  class(cb) <- "callback"
  cb
}

callbacks <- list2env(callbacks)
