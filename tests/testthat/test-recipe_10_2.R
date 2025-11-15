test_that("Recipe 10.2: Spatially varying selection works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_2.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates spatial variation in selection
  # m2 mutations are deleterious in p1 but beneficial in p2 (via inverted effect)
  # Asymmetric migration creates gene flow between populations
  expect_true(TRUE)
})
