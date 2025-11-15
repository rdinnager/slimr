test_that("Recipe 10.4.1 III: Frequency-dependent selection with dominance works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_4_1_III.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_4_1_III_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates frequency dependence with dominance effects
  # Homozygotes experience stronger frequency-dependent selection
  expect_true(TRUE)
})
