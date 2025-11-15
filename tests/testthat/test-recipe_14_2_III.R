test_that("Recipe 14.2 III: Mortality-based fitness (fitnessScaling) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_2_III.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_2_III_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output was generated
  expect_true(length(output) > 0)

  # The outputFull() call should produce population data
  # Check for output lines
  full_output <- grep("^#OUT:", output, value = TRUE)
  expect_true(length(full_output) > 0)
})
