test_that("Recipe 4.2.5: Log files with FST calculation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_4_2_5.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_4_2_5_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify log file was created
  expect_true(file.exists("sim_log.txt"))

  # Read and check log file content
  log_content <- readLines("sim_log.txt")
  expect_true(length(log_content) > 0)

  # Check for header line with "cycle" and "FST" columns
  expect_match(log_content[1], "cycle")
  expect_match(log_content[1], "FST")

  # Check that we have data rows (should be ~2000 rows for 20000 gens at interval 10)
  expect_true(length(log_content) > 100)

  # Clean up log file
  unlink("sim_log.txt")
})
