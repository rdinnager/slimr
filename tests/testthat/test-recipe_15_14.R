test_that("Recipe 15.14: Logistic growth with Beverton-Holt works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_14.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_14_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that log file was created
  expect_true(file.exists("sim_log.txt"))

  # Read log file (comma-separated, not tab-separated)
  log_data <- read.csv("sim_log.txt", header = TRUE)

  # Should have 200 rows (one per generation, with final manual row)
  expect_true(nrow(log_data) >= 200)

  # All three populations should start at 50
  expect_equal(log_data$p1_num_individuals[1], 50)
  expect_equal(log_data$p2_num_individuals[1], 50)
  expect_equal(log_data$p3_num_individuals[1], 50)

  # All three populations should grow (final size > initial size)
  expect_true(tail(log_data$p1_num_individuals, 1) > 50)
  expect_true(tail(log_data$p2_num_individuals, 1) > 50)
  expect_true(tail(log_data$p3_num_individuals, 1) > 50)

  # Clean up log file
  if (file.exists("sim_log.txt")) unlink("sim_log.txt")
})
