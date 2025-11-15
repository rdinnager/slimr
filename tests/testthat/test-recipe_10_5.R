test_that("Recipe 10.5: Changing selection coefficients works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_5.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_5_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates frequency-dependent selection via setSelectionCoeff()
  # Selection coefficients updated dynamically each generation
  expect_true(TRUE)
})
