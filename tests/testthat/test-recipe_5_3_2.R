test_that("Recipe 5.3.2: A non-spatial metapopulation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_5_3_2.R", package = "slimr"))
  result <- slim_run(recipe_5_3_2_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  output_content <- readLines(result$output_file)
  expect_true(any(grepl("Mutations", output_content)))
})
