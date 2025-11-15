test_that("Recipe 8.1.3: Selfing in hermaphroditic populations works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_8_1_3.R", package = "slimr"))
  result <- slim_run(recipe_8_1_3_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))
})
