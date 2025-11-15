test_that("Recipe 14.4: Modeling chromosomal inversions works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Check that output was generated
  expect_true(length(output) > 0)

  # Should have output about substitutions inside vs outside the inversion
  expect_true(any(grepl("inside", output)))
  expect_true(any(grepl("outside", output)))

  # Should have substitution output
  substitution_lines <- grep("^#OUT:", output, value = TRUE)
  expect_true(length(substitution_lines) > 0)
})
