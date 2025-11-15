test_that("Recipe 19.4: Back-mutations and VCF output works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_19_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_19_4_script, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify VCF output is present
  expect_true(grepl("#CHROM|##fileformat=VCF", output))
})
