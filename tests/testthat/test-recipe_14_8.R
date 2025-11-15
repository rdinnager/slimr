test_that("Recipe 14.8: Using mutation rate variation to model varying functional density works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_8.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_8_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output of fixed mutations at the end
  expect_true(length(output) > 0)

  # The script outputs fixed mutations
  # Look for mutation output markers
  expect_true(any(grepl("Mutations|#OUT:", output)))
})
