test_that("Recipe 9.9: Keeping a reference to a sweep mutation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_9.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_9_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from file
  output <- readLines(result$output_file)
  output_text <- paste(output, collapse = "\n")

  # Should report either FIXED or LOST
  expect_true(grepl("FIXED|LOST", output_text),
              info = "Should report fixation or loss of tracked mutation")
})
