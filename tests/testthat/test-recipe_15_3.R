test_that("Recipe 15.3: Big bang reproduction works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output contains cycle info with population size and max age
  # Pattern: "cycle: size (max_age)"
  expect_true(any(grepl("^\\d+: \\d+ \\(\\d+\\)", output)))

  # Should have output showing population growth
  expect_true(length(output) > 0)

  # Output should contain full state at generation 2000
  expect_true(any(grepl("#OUT:", output)))
})
