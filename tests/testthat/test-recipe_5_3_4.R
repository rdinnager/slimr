test_that("Recipe 5.3.4: A random, sparse spatial metapopulation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  source(system.file("extdata/slim_recipes/converted/recipe_5_3_4.R", package = "slimr"))
  result <- slim_run(recipe_5_3_4_script)

  expect_equal(result$exit_status, 0)
  expect_true(file.exists(result$output_file))

  output_content <- readLines(result$output_file)
  # Should have mutations (both neutral and beneficial)
  expect_true(any(grepl("Mutations", output_content)))
})
