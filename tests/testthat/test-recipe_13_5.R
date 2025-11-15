test_that("Recipe 13.5: Two traits with pleiotropy works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_5.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_5_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs DFE info, cycle updates, and final QTL analysis
  expect_true(length(output) > 0)
  # Should contain QTL DFE information
  expect_true(any(grepl("QTL DFE", output)))
  # Should contain cycle updates
  expect_true(any(grepl("Cycle:", output)))
  # Should contain mean phenotype reports
  expect_true(any(grepl("Mean phenotype", output)))
  # Should contain covariance analysis
  expect_true(any(grepl("Covariance", output)))
})
