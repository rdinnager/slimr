test_that("Recipe 14.2 I: Mortality-based fitness works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_2_I.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_2_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output was generated
  expect_true(length(output) > 0)

  # The outputMutations() call should produce mutation data
  # Format: "#OUT: 10000 M <mutation_info>"
  # Check for mutation output lines (contain "M" for mutation records)
  mutation_lines <- grep("^#OUT:", output, value = TRUE)
  expect_true(length(mutation_lines) > 0)
})
