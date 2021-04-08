test_that("All slim recipes work", {
  slim_scripts <- list()
  slim_recipes <- slim_get_recipes()

  skip_on_ci()
  skip_on_cran()
  skip_on_covr()

  skip_if_not(identical(Sys.getenv("test_recipes"), "true"))

  for(i in seq_along(slim_recipes)) {
    slim_scripts[[i]] <- as_slimr_script(slim_recipes[[i]])
  }
  # slim_scripts <- purrr::map(slim_scripts,
  #                            ~slim_script_remove_output(.x))

  test_scripts <- list()
  for(i in seq_along(slim_scripts)[1:length(slim_scripts)]) {
    #print(i)
    if(i %in% c(77, 86, 88, 115, 129, 132, 133, 139, 140, 141, 142, 143, 144, 145, 156, 157)) next
    expect_identical(suppressMessages(slim_run(slim_scripts[[!!i]], progress = FALSE))$exit_status, 0L)
  }
})
