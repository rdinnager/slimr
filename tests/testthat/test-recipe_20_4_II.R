test_that("Recipe 20.4 II: An individual-based host-parasitoid model II works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_20_4_II.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_20_4_II_script, capture_output = TRUE)

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

  # Individual-based model should complete successfully
  # May have stochastic extinctions but should finish 250 generations
  expect_true(result$exit_status == 0)
})
