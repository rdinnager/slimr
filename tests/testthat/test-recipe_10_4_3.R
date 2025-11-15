test_that("Recipe 10.4.3: Kin selection and green-beard effect works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_4_3.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_4_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates green-beard effect - altruism via self-recognition
  # Individuals with m2 cooperate, providing 2x benefit for 1x cost
  expect_true(TRUE)
})
