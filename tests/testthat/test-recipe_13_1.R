test_that("Recipe 13.1: Polygenic selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs mutation frequencies - should have numeric output
  expect_true(length(output) > 0)
  # Output should contain numbers (mutation frequencies)
  expect_true(any(grepl("[0-9]", output)))
})
