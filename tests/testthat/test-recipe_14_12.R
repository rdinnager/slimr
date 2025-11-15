test_that("Recipe 14.12: Visualizing ancestry and admixture with mutation() callbacks works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_12.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_12_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output (fixed mutations)
  expect_true(length(output) > 0)

  # The simulation outputs fixed mutations at the end
  # Should have mutation output markers
  expect_true(any(grepl("Mutations|#OUT:", output)))
})
