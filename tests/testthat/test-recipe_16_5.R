test_that("Recipe 16.5: Meiotic drive works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_5.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_5_script, capture_output = TRUE)

  # Verify success (drive allele either fixes or is lost)
  expect_equal(result$exit_status, 0)

  # Check output
  if (length(result$output) > 0) {
    output <- paste(result$output, collapse = "\n")
  } else if (file.exists(result$output_file)) {
    output <- paste(readLines(result$output_file), collapse = "\n")
  } else {
    output <- ""
  }

  # Should have either "FIXED" or "LOST" message
  expect_true(grepl("FIXED|LOST", output))
})
