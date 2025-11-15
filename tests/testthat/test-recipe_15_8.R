test_that("Recipe 15.8: Evolutionary rescue after environmental change works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_8.R", package = "slimr"))

  # Run the recipe - extinction is a possible outcome
  result <- slim_run(recipe_15_8_script, throw_error = FALSE, capture_output = TRUE)

  # Verify exit status is either success (0) or controlled stop (1)
  expect_true(result$exit_status %in% c(0, 1))

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Should have output (either phenotype data or extinction message)
  expect_true(nchar(output) > 0)

  # Check for either phenotype output or extinction message
  has_phenotype <- grepl("phenotype mean", output)
  has_extinction <- grepl("Extinction in cycle", output)
  expect_true(has_phenotype || has_extinction)
})
