test_that("Recipe 13.3: Discrete QTL effects across multiple chromosomes works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs fitness and phenotype statistics at cycles 2 and 2001
  expect_true(length(output) > 0)
  # Should contain fitness reports
  expect_true(any(grepl("mean fitness", output)))
  # Should contain phenotype reports
  expect_true(any(grepl("mean phenotype", output)))
  # Should contain QTL frequency reports
  expect_true(any(grepl("QTL", output)))
})
