test_that("Recipe 16.4: Alternation of generations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_16_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_16_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)
})
