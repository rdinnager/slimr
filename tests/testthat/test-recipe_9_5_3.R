test_that("Recipe 9.5.3: A soft sweep with a random de novo mutation schedule works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_5_3.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_5_3_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that output contains sweep outcome
  expect_true(file.exists(result$output_file))
  output_content <- paste(readLines(result$output_file), collapse = "\n")

  # Should show either "Sweep completed" or "Soft sweep failed"
  expect_true(grepl("Sweep completed|Soft sweep failed", output_content))

  # Note: This uses random Poisson-distributed mutation times
  # Mutations introduced at stochastic intervals starting around generation 1000
})
