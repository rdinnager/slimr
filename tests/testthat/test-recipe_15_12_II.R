test_that("Recipe 15.12 II: WF with nonWF (fitness-weighted parents) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_12_II.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_12_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have fixed mutations output
  expect_true(any(grepl("Mutations", output)))
})
