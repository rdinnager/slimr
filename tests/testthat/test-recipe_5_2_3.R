test_that("Recipe 5.2.3: Splitting subpopulations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_2_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_5_2_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify output file exists
  expect_true(file.exists(result$output_file))

  # Verify output contains mutations
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mutations", output_content)))
})
