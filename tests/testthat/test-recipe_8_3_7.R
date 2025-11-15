test_that("Recipe 8.3.7: Output from multiple-chromosome models works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_8_3_7.R", package = "slimr"))
  result <- slim_run(recipe_8_3_7_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  # Check that output contains expected sections
  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Populations", output_content)))  # From outputFull()
  expect_true(any(grepl("Individuals", output_content)))  # From outputIndividuals()
})
