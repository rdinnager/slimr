test_that("Recipe 17.2: Spatial competition works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_17_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_17_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Check that output was generated
  expect_true(length(output) > 0)

  # Spatial competition model should complete successfully
  expect_true(any(grepl("Mutations|#OUT", output)))
})
