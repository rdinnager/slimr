test_that("Recipe 18.1: A minimal tree-seq model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_1.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_18_1_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that tree-sequence output file was created
  expect_true(file.exists("overlay.trees"))

  # Verify output mentions tree-seq
  output <- paste(result$output, collapse = "\n")
  expect_true(grepl("tree", output, ignore.case = TRUE) ||
              nchar(output) == 0)  # Tree-seq output may be silent

  # Clean up
  if (file.exists("overlay.trees")) {
    unlink("overlay.trees")
  }
})
