test_that("All slim recipes work", {
  slim_scripts <- list()
  slim_recipes <- slim_get_recipes()

  skip_on_ci()
  skip_on_cran()
  skip_on_covr()

  for(i in seq_along(slim_recipes)) {
    print(i)
    slim_scripts[[i]] <- as_slimr_script(slim_recipes[[i]])
    expect_s3_class(slim_scripts[[!!i]], "slimr_script")
  }
  # slim_scripts <- purrr::map(slim_scripts,
  #                            ~slim_script_remove_output(.x))

  skip_if_not(identical(Sys.getenv("test_recipes"), "true"))

  test_scripts <- list()
  for(i in seq_along(slim_scripts)[115:length(slim_scripts)]) {
    print(i)
    if(i %in% c(77, 86, 88, 115, 129, 132, 133, 139, 140, 141, 142, 143, 144, 145, 156, 157)) next
    test_scripts[[i]] <- slim_run_script(slim_scripts[[i]], .progress = FALSE)
    expect_identical(test_scripts[[!!i]]$exit_status, 0L)
  }
})
