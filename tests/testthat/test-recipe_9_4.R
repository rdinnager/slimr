test_that("Recipe 9.4: Partial sweeps works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Note: Simulation ends when mutation is lost OR at generation 10000
  # The mutation may reach 50% and become neutral (partial sweep)
  # Or may be lost before reaching 50%
  # Both outcomes are valid for this stochastic simulation
})
