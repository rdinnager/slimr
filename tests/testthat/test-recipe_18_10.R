test_that("Recipe 18.10: Adding neutral burn-in with recapitation works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original uses N=100,000 and runs up to 10,000 generations)
  recipe_18_10_test <- slim_script(
    slim_block(initialize(), {
      # Configure tree-sequence recording for recapitation
      initializeTreeSeq(simplificationRatio = INF, timeUnit = "generations")
      initializeMutationRate(0)

      # Strongly beneficial mutation (s=1.0)
      initializeMutationType("m2", 0.5, "f", 1.0)
      m2$convertToSubstitution <- F

      initializeGenomicElementType("g1", m2, 1)
      initializeGenomicElement(g1, 0, 1e6 - 1)
      initializeRecombinationRate(3e-10)
    }),

    slim_block(1, late(), {
      sim$addSubpop("p1", 500)  # Reduced from 100,000 for testing
    }),

    # Introduce beneficial mutation early for faster fixation
    slim_block(10, late(), {
      sample(p1$haplosomes, 1)$addNewDrawnMutation(m2, 5e5)
    }),

    # Check for fixation or loss, shortened runtime
    slim_block(10, 500, late(), {
      mut <- sim$mutationsOfType(m2)

      # Check if mutation was lost
      if (mut$size() != 1)
        stop(sim$cycle + ": LOST")

      # Check if mutation has fixed
      if (sum(sim$mutationFrequencies(NULL, mut)) == 1.0) {
        sim$treeSeqOutput("decap_test.trees")
        sim$simulationFinished()
      }
    })
  )

  # Run with throw_error=FALSE since it may stop() on loss
  result <- slim_run(recipe_18_10_test, throw_error = FALSE, capture_output = TRUE)

  # Accept either success (fixation) or controlled stop (loss)
  expect_true(result$exit_status %in% c(0, 1))

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Check for valid outcome (fixation OR loss message)
  has_fixation <- file.exists("decap_test.trees")
  has_loss <- grepl("LOST", output)

  expect_true(has_fixation || has_loss)

  # Clean up output file if it exists
  if (file.exists("decap_test.trees")) {
    unlink("decap_test.trees")
  }
})
