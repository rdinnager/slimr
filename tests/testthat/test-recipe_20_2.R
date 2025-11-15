test_that("Recipe 20.2: A two-species model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_20_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_20_2_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- if (length(result$output) > 0) {
    paste(result$output, collapse = "\n")
  } else if (file.exists(result$output_file)) {
    paste(readLines(result$output_file), collapse = "\n")
  } else {
    ""
  }

  # Should have output from both species
  expect_true(nchar(output) > 0)
  # Output should show two species' fixed mutations
  expect_true(grepl("Mutations", output))
})
