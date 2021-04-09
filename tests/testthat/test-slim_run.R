test_that("slim_run can run a SLiM script", {
  test_script <- as_slimr_script(slim_get_recipe(1))
  test_script <- slim_script_duration(test_script, 500)
  res <- slim_run(test_script, throw_error = TRUE)

  expect_s3_class(res, "slimr_results")
  expect_identical(res$exit_status, 0L)
  expect_length(res$error, 0L)
  expect_length(res$output, 0L)
})
