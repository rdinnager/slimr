test_that("Recipe 15.10: Recording a pedigree works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_10.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_10_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check that pedigree files were created
  expect_true(file.exists("mating.txt"))
  expect_true(file.exists("death.txt"))

  # Read pedigree files
  mating_log <- readLines("mating.txt")
  death_log <- readLines("death.txt")

  # Should have mating events recorded
  expect_true(length(mating_log) > 0)

  # Should have death events recorded
  expect_true(length(death_log) > 0)

  # Clean up pedigree files
  if (file.exists("mating.txt")) unlink("mating.txt")
  if (file.exists("death.txt")) unlink("death.txt")
})
