test_that("Recipe 5.5 Part II: Rescaling (rescaled version) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_5_II.R", package = "slimr"))

  # Run the recipe (note: rescaled version - only 6,000 generations, ~10x faster)
  result <- slim_run(recipe_5_5_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  # Check that output contains sample data
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("p1", output_content)))
})
