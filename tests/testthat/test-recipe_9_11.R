test_that("Recipe 9.11: Effective population size versus census population size works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_11.R", package = "slimr"))

  # Run the recipe (this will take longer - 20000 generations with large genome)
  result <- slim_run(recipe_9_11_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that log file was created (Ne_log.csv)
  # Note: File is written to working directory by SLiM
  expect_true(file.exists("Ne_log.csv"), info = "Should create Ne_log.csv file")

  # Clean up log file if it exists
  if (file.exists("Ne_log.csv")) {
    unlink("Ne_log.csv")
  }
})
