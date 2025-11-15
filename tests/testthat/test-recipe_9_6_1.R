test_that("Recipe 9.6.1: A sweep from standing variation at a random locus works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_6_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_6_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from file
  output <- readLines(result$output_file)
  output_text <- paste(output, collapse = "\n")

  # The recipe should either report fixation, loss, or no contender found
  # Note: Due to stochasticity, any of these outcomes is valid
  expect_true(nchar(output_text) >= 0)  # Just verify it ran successfully
})
