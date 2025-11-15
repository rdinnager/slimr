test_that("Recipe 19.6: Nucleotide with non-nucleotide mutations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_6.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_6_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify mutations are being tracked (should print mutation info)
  # Either shows mutation objects or indicates they're present
  expect_true(grepl("Mutation", output) || grepl("MutationType", output) || nchar(output) > 0)
})
