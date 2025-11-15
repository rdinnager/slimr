test_that("Recipe 15.6: Metapopulation extinction-colonization model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_6.R", package = "slimr"))

  # Run the recipe - global extinction is a valid stochastic outcome
  # Capture output to check for extinction messages
  result <- slim_run(recipe_15_6_script, throw_error = FALSE, capture_output = TRUE)

  # Verify exit status is either success (0) or controlled stop (1)
  expect_true(result$exit_status %in% c(0, 1))

  # Check both output_file and captured output for messages
  output_file_content <- readLines(result$output_file)
  captured_output <- result$output

  # Global extinction is a valid outcome in this stochastic model
  # Check for extinction message in captured output or mutations in file
  has_mutations <- any(grepl("Mutations", output_file_content))
  has_extinction <- grepl("Global extinction", captured_output)

  # Either successful completion or global extinction is acceptable
  expect_true(has_mutations || has_extinction)
})
