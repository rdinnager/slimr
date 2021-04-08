test_that("All SLiM recipes can be converted to slimr_script objects properly", {
  slim_scripts <- list()
  slim_recipes <- slim_get_recipes()

  skip_on_ci()
  skip_on_cran()
  skip_on_covr()

  for(i in seq_along(slim_recipes)) {
    #print(i)
    expect_snapshot_output(print(as_slimr_script(slim_recipes[[!!i]])))
    #expect_s3_class(slim_scripts[[!!i]], "slimr_script")
  }
  # slim_scripts <- purrr::map(slim_scripts,
  #                            ~slim_script_remove_output(.x))

})
