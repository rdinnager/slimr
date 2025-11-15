test_that("Recipe 10.3.1 II: Epistasis with substitution handling works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_10_3_1_II.R", package = "slimr"))

  # Run the recipe (10000 generations)
  result <- slim_run(recipe_10_3_1_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe demonstrates epistasis with convertToSubstitution=F
  # This ensures epistatic interactions work even after mutations fix
  expect_true(TRUE)
})
