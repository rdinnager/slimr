test_that("Recipe 14.11 I: Modeling opposite ends of a chromosome works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_11_I.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_11_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output (fixed mutations)
  expect_true(length(output) > 0)
})
