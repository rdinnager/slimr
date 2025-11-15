test_that("Recipe 13.4: Quantitative genetics with heritability works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_13_4.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_13_4_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from result$output_file
  output <- readLines(result$output_file)

  # Recipe outputs mean phenotypes and QTL details
  expect_true(length(output) > 0)
  # Should contain "Mean phenotype" header
  expect_true(any(grepl("Mean phenotype", output)))
  # Should contain QTL details
  expect_true(any(grepl("QTLs at cycle", output)))
  # Should contain numeric values (frequencies, selection coefficients)
  expect_true(any(grepl("[0-9]", output)))
})
