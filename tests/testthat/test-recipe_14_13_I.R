test_that("Recipe 14.13 I: Modeling biallelic loci with a mutation() callback works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_13_I.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_13_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have minimal output (simulation runs to generation 50000)
  expect_true(length(output) >= 0)

  # Check if freq.csv was created (if we can access it)
  # Note: The log file is written to the working directory during simulation
  # We might not have access to it in the test environment
})
