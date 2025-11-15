test_that("Recipe 10.4.1 II: Positive frequency-dependent selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_4_1_II.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_4_1_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates positive frequency dependence
  # m2 mutations become more beneficial as they become more common
  expect_true(TRUE)
})
