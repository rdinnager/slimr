test_that("Recipe 14.9: Modeling microsatellites works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_14_9.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_14_9_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output showing microsatellite positions and frequencies
  expect_true(any(grepl("Microsatellite at", output)))

  # Should show variant information with repeat counts
  expect_true(any(grepl("variant with .* repeats:", output)))

  # Should have multiple microsatellite loci (10 defined in script)
  microsat_lines <- grep("Microsatellite at", output)
  expect_true(length(microsat_lines) > 0)
})
