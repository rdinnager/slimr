test_that("Recipe 15.2: Age structure (a life table model) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output contains age distribution output
  # Pattern: "cycle: age1 age2 age3..." (ages separated by spaces)
  expect_true(any(grepl("^\\d+: ", output)))

  # Should have output showing age distributions across generations
  expect_true(length(output) > 0)

  # Output should contain fixed mutations at generation 2000
  expect_true(any(grepl("Mutations", output)))
})
