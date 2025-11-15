test_that("Recipe 9.5.2: A soft sweep with a fixed de novo mutation schedule works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_5_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_5_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that output contains sweep information
  expect_true(file.exists(result$output_file))
  output_content <- paste(readLines(result$output_file), collapse = "\n")

  # Should show either "Hard sweep", "Soft sweep", or "Sweep failed"
  expect_true(grepl("Hard sweep|Soft sweep|Sweep failed", output_content))

  # Should track lineages with "lineage(s)" messages
  expect_true(grepl("lineage", output_content))
})
