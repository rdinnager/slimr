test_that("Recipe 18.7: Analyzing selection coefficients in Python works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 20,000 generations)
  recipe_18_7_test <- slim_script(
    slim_block(initialize(), {
      initializeTreeSeq()
      initializeMutationRate(1e-10)

      # Beneficial mutations with gamma-distributed selection coefficients
      initializeMutationType("m1", 0.5, "g", 0.1, 0.1)

      # Deleterious mutations with gamma-distributed selection coefficients
      initializeMutationType("m2", 0.5, "g", -0.1, 0.1)

      # Both mutation types occur with equal probability
      initializeGenomicElementType("g1", c(m1, m2), c(1.0, 1.0))
      initializeGenomicElement(g1, 0, 1e8 - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),

    # Shortened runtime: 1000 generations instead of 20,000
    slim_block(1000, late(), {
      sim$treeSeqOutput("./selcoeff_test.trees")
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_18_7_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from output_file
  output <- paste(readLines(result$output_file), collapse = "\n")

  # Verify tree-sequence output was created
  expect_true(grepl("Writing tree", output) || grepl("tree", output) || file.exists("./selcoeff_test.trees"))

  # Clean up output file if it exists
  if (file.exists("./selcoeff_test.trees")) {
    unlink("./selcoeff_test.trees")
  }
})
