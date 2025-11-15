test_that("Recipe 15.13 II: Range expansion (individual migration) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_13_II.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_13_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that log file was created
  expect_true(file.exists("sim_log.txt"))

  # Read output
  output <- readLines(result$output_file)

  # Should have fixed mutations output
  expect_true(any(grepl("Mutations", output)))

  # Clean up log file
  if (file.exists("sim_log.txt")) unlink("sim_log.txt")
})
