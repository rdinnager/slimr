test_that("Recipe 16.2: Following a pedigree works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # First run Recipe 15.10 to generate pedigree files
  source(system.file("extdata/slim_recipes/converted/recipe_15_10.R", package = "slimr"))
  result_15_10 <- slim_run(recipe_15_10_script)
  expect_equal(result_15_10$exit_status, 0)

  # Verify pedigree files were created
  expect_true(file.exists("mating.txt"))
  expect_true(file.exists("death.txt"))

  # Now run Recipe 16.2 to replay the pedigree
  source(system.file("extdata/slim_recipes/converted/recipe_16_2.R", package = "slimr"))
  result <- slim_run(recipe_16_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Clean up pedigree files
  if (file.exists("mating.txt")) unlink("mating.txt")
  if (file.exists("death.txt")) unlink("death.txt")
})
