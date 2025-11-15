test_that("Recipe 9.1: Introducing adaptive mutations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that output contains either "FIXED" or "LOST"
  expect_true(file.exists(result$output_file))
  output_content <- paste(readLines(result$output_file), collapse = "\n")
  expect_true(grepl("FIXED|LOST", output_content))
})
