test_that("Recipe 4.2.6: MS-format output works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_4_2_6.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_4_2_6_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Verify output file was created (MS output goes to file)
  expect_true(file.exists(result$output_file))

  # Read and check output content
  output_content <- readLines(result$output_file)
  expect_true(length(output_content) > 0)

  # Check for MS-format markers
  output_text <- paste(output_content, collapse = "\n")
  expect_match(output_text, "segsites:")
  expect_match(output_text, "positions:")
})
