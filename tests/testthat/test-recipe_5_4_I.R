test_that("Recipe 5.4 Part I: Gravel et al. human evolution model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_5_4_I.R", package = "slimr"))

  # Run the recipe (note: this is a long simulation - 79,024 generations)
  result <- slim_run(recipe_5_4_I_script)

  # Verify success
  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  # Check that output contains samples from all three populations
  output_content <- readLines(result$output_file)
  # Should have output from YRI (p1), CEU (p2), and CHB (p3)
  expect_true(any(grepl("p1", output_content)))
  expect_true(any(grepl("p2", output_content)))
  expect_true(any(grepl("p3", output_content)))
})
