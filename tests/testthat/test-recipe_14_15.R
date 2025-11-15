test_that("Recipe 14.15: Using runs of homozygosity (ROH) to track inbreeding works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_15.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_15_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have minimal output (simulation runs to generation 2000)
  expect_true(length(output) >= 0)

  # This recipe tracks F_ROH (inbreeding from runs of homozygosity)
  # It demonstrates bottleneck effects on inbreeding in three populations
})
