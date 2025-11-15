test_that("Recipe 5.3.5: Reading a migration matrix from a file works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_3_5.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_5_3_5_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  # Check that output contains expected content
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mutations", output_content)))
})
