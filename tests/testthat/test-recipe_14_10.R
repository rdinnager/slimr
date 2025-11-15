test_that("Recipe 14.10: Modeling transposable elements works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_10.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_10_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output about active TEs
  expect_true(any(grepl("Active TEs:", output)))

  # Should have TE position and frequency information
  expect_true(any(grepl("TE at.*frequency", output)))

  # Should show percentage active
  expect_true(any(grepl("% active", output)))

  # May also have completely disabled TEs section
  # (this depends on simulation dynamics, so we don't strictly require it)
})
