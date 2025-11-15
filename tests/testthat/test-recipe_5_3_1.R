test_that("Recipe 5.3.1: Stepping-stone migration model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_3_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_5_3_1_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify output file was created
  expect_true(file.exists(result$output_file))

  # Check that output contains fixed mutations
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mutations", output_content)))
})
