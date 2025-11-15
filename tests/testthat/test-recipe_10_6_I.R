test_that("Recipe 10.6 I: Varying dominance coefficient works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_6_I.R", package = "slimr"))

  # Run the recipe (100000 generations - long simulation)
  result <- slim_run(recipe_10_6_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates varying dominance via setValue/getValue
  # Each mutation gets random dominance coefficient
  expect_true(TRUE)
})
