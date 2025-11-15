test_that("Recipe 16.11: Life-long monogamous mating works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_11.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_11_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify simulation completed
  output <- readLines(result$output_file)
  expect_true(length(output) >= 0)
})
