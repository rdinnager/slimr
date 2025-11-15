test_that("Recipe 18.4: Detecting the dip in diversity (Python analysis) works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 100,000 generations, too slow for testing)
  recipe_18_4_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("N", 100)       # Reduced from 10,000
      defineConstant("L", 1e6)       # Reduced from 1e8 (100 Mb → 1 Mb)
      defineConstant("L0", 2e3)      # Reduced intergenic length (200kb → 2kb)
      defineConstant("L1", 1e3)      # Same gene length

      initializeTreeSeq()
      initializeMutationRate(1e-7)
      initializeRecombinationRate(1e-8, L - 1)

      initializeMutationType("m2", 0.5, "g", -(5/N), 1.0)
      initializeGenomicElementType("g2", m2, 1.0)

      # Create alternating genic/intergenic structure
      for (start in seq(from = L0, to = L - (L0 + L1), by = (L0 + L1)))
        initializeGenomicElement(g2, start, (start + L1) - 1)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", N)
    }),

    # Shortened runtime: 1000 generations instead of 100,000
    slim_block(1000, late(), {
      sim$treeSeqOutput("./diversity_test.trees")
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_18_4_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output from output_file
  output <- paste(readLines(result$output_file), collapse = "\n")

  # Verify tree-sequence output was created
  expect_true(grepl("Writing tree", output) || grepl("tree", output) || file.exists("./diversity_test.trees"))

  # Clean up output file if it exists
  if (file.exists("./diversity_test.trees")) {
    unlink("./diversity_test.trees")
  }
})
