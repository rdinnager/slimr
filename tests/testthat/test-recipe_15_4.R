test_that("Recipe 15.4: Monogamous mating and variable litter size works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output contains cycle info
  expect_true(any(grepl("^\\d+: \\d+ \\(\\d+\\)", output)))

  # Should have output
  expect_true(length(output) > 0)

  # Output should contain full state at generation 2000
  expect_true(any(grepl("#OUT:", output)))
})
