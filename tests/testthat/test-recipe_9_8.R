test_that("Recipe 9.8: Fixation probabilities under Hill-Robertson interference works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_8.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_8_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from file
  output <- readLines(result$output_file)
  output_text <- paste(output, collapse = "\n")

  # Should report fixation probability, expected, actual, and ratio
  expect_true(grepl("P\\(fix\\)", output_text), info = "Should report fixation probability")
  expect_true(grepl("Expected fixations", output_text), info = "Should report expected fixations")
  expect_true(grepl("Actual fixations", output_text), info = "Should report actual fixations")
  expect_true(grepl("Ratio", output_text), info = "Should report ratio")
})
