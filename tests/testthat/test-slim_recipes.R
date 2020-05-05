test_that("All slim recipes work", {
  slim_scripts <- list()
  for(i in seq_along(slim_recipes)) {
    slim_scripts[[i]] <- slim_script_from_text(slim_recipes[[i]])
    expect_true(slim_script_is_valid(slim_scripts[[!!i]]))
  }
  slim_scripts <- purrr::map(slim_scripts,
                             ~slim_script_remove_output(.x))
  skip_on_ci()
  skip_on_cran()

  test_scripts <- list()
  for(i in seq_along(slim_scripts)) {
    test_scripts[[i]] <- slim_run_script(slim_scripts[[i]], .progress = FALSE)
    expect_identical(test_scripts[[!!i]]$exit_status, 0L)
  }
})
