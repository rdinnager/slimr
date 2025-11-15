test_that("Recipe 9.6.2: A sweep from standing variation at a predetermined locus works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Source the recipe
  source(system.file("extdata/slim_recipes/converted/recipe_9_6_2.R", package = "slimr"))

  # Run the recipe
  result <- slim_run(recipe_9_6_2_script)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from file
  output <- readLines(result$output_file)
  output_text <- paste(output, collapse = "\n")

  # The recipe should report establishment and either FIXED or LOST
  # Due to save/restore, it should always establish (may show restarts)
  expect_true(grepl("ESTABLISHED|FIXED|LOST", output_text),
              info = "Should report establishment and/or outcome")
})
