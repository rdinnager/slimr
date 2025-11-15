test_that("Recipe 13.2: Variable QTL effect sizes works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs mean phenotype every 100 generations and final frequency-effect table
  expect_true(length(output) > 0)
  # Should contain "Mean phenotype" reports
  expect_true(any(grepl("Mean phenotype", output)))
  # Should contain numeric values (frequencies and effects)
  expect_true(any(grepl("[0-9]", output)))
})
