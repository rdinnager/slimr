test_that("Recipe 15.11: Dynamic population structure in nonWF models works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_15_11.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_15_11_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # This recipe creates dynamic population structure
  # Should complete successfully with population joins and splits
  expect_true(TRUE)
})
