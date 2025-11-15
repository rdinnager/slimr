test_that("Recipe 18.6 I: Measuring coalescence time works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_18_6_I.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_18_6_I_script, throw_error = FALSE, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- paste(result$output, collapse = "\n")
  expect_true(nchar(output) > 0)

  # Should see either COALESCED or NO COALESCENCE message
  has_coalesced <- grepl("COALESCED", output)
  has_no_coalescence <- grepl("NO COALESCENCE", output)

  # At least one should be true
  expect_true(has_coalesced || has_no_coalescence)
})
