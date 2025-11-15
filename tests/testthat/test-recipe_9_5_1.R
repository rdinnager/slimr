test_that("Recipe 9.5.1: A soft sweep from recurrent de novo mutations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_5_1.R", package = "slimr"))

  # Run the recipe (may take longer due to large population size)
  result <- slim_run(recipe_9_5_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that output contains mutation information
  expect_true(file.exists(result$output_file))
  output_content <- paste(readLines(result$output_file), collapse = "\n")

  # Should show total mutations and origin times
  expect_true(grepl("Total mutations:", output_content))
  expect_true(grepl("Origin", output_content))

  # Note: This is a soft sweep, so multiple mutations should be present
  # The output will show multiple mutations from different origin generations
})
