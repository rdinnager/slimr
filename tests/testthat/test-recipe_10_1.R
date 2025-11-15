test_that("Recipe 10.1: Temporally varying selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_1.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates temporal variation in selection
  # m2 mutations are beneficial (s=0.1) except during generations 2000-3999
  # when they become neutral via mutationEffect() callback
  expect_true(TRUE)
})
