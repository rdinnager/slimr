test_that("Recipe 12.1: Social learning of cultural traits works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_12_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_12_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates gene-culture coevolution with social learning
  # No specific output checks needed - success is running without errors
})
