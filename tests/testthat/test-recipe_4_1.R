test_that("Recipe 4.1: A basic neutral simulation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_4_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_4_1_script)

  # Verify success - this basic recipe produces no output, just runs
  expect_equal(result$exit_status, 0)
})
