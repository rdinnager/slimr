test_that("Recipe 19.3: Sequence output from nucleotide-based models works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_3_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify ancestral sequence output is present
  expect_true(grepl("Ancestral:", output))

  # Verify positions are shown
  expect_true(grepl("positions:", output))

  # Verify at least one of the sequence output methods appears
  expect_true(grepl("Derived:", output) || grepl("SNPs:", output) || grepl("Fixed:", output))
})
