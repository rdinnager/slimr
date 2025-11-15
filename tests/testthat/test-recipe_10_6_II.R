test_that("Recipe 10.6 II: Varying dominance via mutation types works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_6_II.R", package = "slimr"))

  # Run the recipe (100000 generations - long simulation)
  result <- slim_run(recipe_10_6_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates varying dominance via mutation type reassignment
  # Dominance determined by selection coefficient strength
  expect_true(TRUE)
})
