test_that("Recipe 18.3 II: Conditional sweep with tree-seq and metadata works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_3_II.R", package = "slimr"))

  # Run the recipe - allow it to run with potential restarts
  result <- slim_run(recipe_18_3_II_script, throw_error = FALSE, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output contains some content
  output <- paste(result$output, collapse = "\n")
  expect_true(nchar(output) > 0)

  # Clean up temporary files if they exist
  temp_files <- list.files(tempdir(), pattern = "^slim_.*\\.trees$", full.names = TRUE)
  if (length(temp_files) > 0) {
    unlink(temp_files)
  }

  # Also clean up FIXED output files in working directory
  fixed_files <- list.files(".", pattern = "^slim_.*_FIXED\\.trees$", full.names = TRUE)
  if (length(fixed_files) > 0) {
    unlink(fixed_files)
  }
})
