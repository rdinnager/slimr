test_that("Recipe 11.3: Gametophytic self-incompatibility works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_11_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_11_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that mutation count output was produced
  expect_true(file.exists(result$output_file))
  output_content <- readLines(result$output_file, warn = FALSE)
  expect_true(any(grepl("m1 mutation count", output_content)))
  expect_true(any(grepl("m2 mutation count", output_content)))
})
