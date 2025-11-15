test_that("Recipe 17.17: A spatial epidemiological S-I-R model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_17_17.R", package = "slimr"))

  # Run the recipe - may end early if infection is lost
  result <- slim_run(recipe_17_17_script, capture_output = TRUE)

  # Verify success (exit_status 0 for either completion or early stop)
  expect_equal(result$exit_status, 0)

  # Check for SIR output
  output <- paste(result$output, collapse = "\n")
  expect_true(grepl("\\d+, \\d+, \\d+,", output))  # Should have S,I,R counts
})
