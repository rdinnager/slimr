test_that("Recipe 15.1: A minimal nonWF model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output contains expected patterns
  # Should have cycle numbers with population sizes and ages
  expect_true(any(grepl("^\\d+: \\d+ \\(\\d+\\)", output)))

  # Should have some population size output (growth from 10 toward K=500)
  expect_true(length(output) > 0)

  # Output should contain full state at generation 2000
  expect_true(any(grepl("#OUT:", output)))
})
