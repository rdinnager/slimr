test_that("Recipe 9.12: Observing the site frequency spectrum (SFS) during selective sweeps works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_12.R", package = "slimr"))

  # Run the recipe (35,000 generations - will take a few minutes)
  # Note: SLiMgui plotting will not work in non-GUI mode, but simulation will run
  result <- slim_run(recipe_9_12_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Recipe completes successfully even though plots aren't generated in non-GUI mode
  expect_true(TRUE)
})
