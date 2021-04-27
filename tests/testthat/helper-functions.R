on_covr <- function() {
  identical(Sys.getenv("R_COVR"), "true")
}

on_ci <- function() {
  isTRUE(as.logical(Sys.getenv("CI")))
}

if(on_ci()) {

  ## this generates a folder to save test objects to only on
  ## github actions, which is uploaded as an artifact and then
  ## downloaded only when doing covr

  covr_test_folder <- "~/covr_test_objects"

  if(!dir.exists(covr_test_folder)) {
    dir.create(covr_test_folder)
  }

}
