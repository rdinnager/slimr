test_that("Recipe 18.3 I: Conditional sweep with ancestry preservation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_3_I.R", package = "slimr"))

  # Run the recipe - allow it to run with potential restarts
  # Use throw_error=FALSE since it may take many attempts
  # Use capture_output=TRUE to capture cat() output to stdout
  result <- slim_run(recipe_18_3_I_script, throw_error = FALSE, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output contains some content (at least initialization info)
  output <- paste(result$output, collapse = "\n")
  expect_true(nchar(output) > 0)

  # Note: The conditional sweep may or may not complete within the timeframe
  # If the mutation is still segregating, no FIXED/LOST message will appear
  # If it fixes or is lost, we should see a message
  # Either outcome is valid for this test

  # Clean up temporary files if they exist
  temp_files <- list.files(tempdir(), pattern = "^slim_.*\\.trees$", full.names = TRUE)
  if (length(temp_files) > 0) {
    unlink(temp_files)
  }
})
