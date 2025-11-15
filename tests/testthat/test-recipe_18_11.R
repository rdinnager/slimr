test_that("Recipe 18.11: Optimizing tree-sequence simplification works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 50,001 generations, too slow for testing)
  recipe_18_11_test <- slim_script(
    slim_block(initialize(), {
      setSeed(0)

      # Test with smaller simplification interval for shorter runtime
      initializeTreeSeq(simplificationInterval = 10)

      initializeMutationRate(0)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 1e8 - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)  # Reduced from 10,000
    }),

    # Much shorter runtime: 100 generations instead of 50,001
    slim_block(100, late(), {
      NULL
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_18_11_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # This recipe just tests that tree-sequence simplification works correctly
  # No specific output to check, just that it completes without error
})
