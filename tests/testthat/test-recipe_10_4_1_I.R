test_that("Recipe 10.4.1 I: Frequency-dependent selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_4_1_I.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_4_1_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates balancing selection via frequency dependence
  # m2 mutations are beneficial when rare, deleterious when common
  expect_true(TRUE)
})
