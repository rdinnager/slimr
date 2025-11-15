test_that("Recipe 18.5: Mapping admixture (Python analysis) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_5.R", package = "slimr"))

  # Run the recipe (don't throw error on controlled stop())
  result <- slim_run(recipe_18_5_script, throw_error = FALSE, capture_output = TRUE)

  # Accept either success (fixation) or controlled stop (didn't reach fixation)
  expect_true(result$exit_status %in% c(0, 1))

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Check for valid outcome (success OR expected failure message)
  has_success <- grepl("Writing tree", output) || file.exists("./admix.trees")
  has_valid_failure <- grepl("Did not reach fixation", output)

  expect_true(has_success || has_valid_failure)

  # Clean up output file if it exists
  if (file.exists("./admix.trees")) {
    unlink("./admix.trees")
  }
})
