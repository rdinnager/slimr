test_that("Recipe 17.10: Biogeographic landscape model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Skip this test - requires external image file
  skip("Recipe 17.10 requires world_map_540x217.png file not included in package")

  source(system.file("extdata/slim_recipes/converted/recipe_17_10.R", package = "slimr"))
  result <- slim_run(recipe_17_10_script)
  expect_equal(result$exit_status, 0)

  output <- readLines(result$output_file)
  expect_true(length(output) > 0)
})
