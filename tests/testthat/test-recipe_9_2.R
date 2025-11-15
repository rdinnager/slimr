test_that("Recipe 9.2: Making sweeps conditional on fixation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that output contains "FIXED" (should always be true due to restart mechanism)
  expect_true(file.exists(result$output_file))
  output_content <- paste(readLines(result$output_file), collapse = "\n")
  expect_true(grepl("FIXED", output_content))

  # Note: Output may also contain "LOST - RESTARTING" if mutation was lost on first attempt
  # This is expected behavior and shows the restart mechanism working
})
