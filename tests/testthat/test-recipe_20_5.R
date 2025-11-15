test_that("Recipe 20.5: A continuous-space host-parasitoid model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_20_5.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_20_5_script, capture_output = TRUE)

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

  # Spatial model should complete successfully
  expect_true(result$exit_status == 0)
})
