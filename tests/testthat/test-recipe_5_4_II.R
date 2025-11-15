test_that("Recipe 5.4 Part II: Gravel et al. model with annotations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_4_II.R", package = "slimr"))

  # Run the recipe (note: this is a long simulation - 79,024 generations)
  result <- slim_run(recipe_5_4_II_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  # Check that output contains samples from all three populations
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("p1", output_content)))
  expect_true(any(grepl("p2", output_content)))
  expect_true(any(grepl("p3", output_content)))
})
