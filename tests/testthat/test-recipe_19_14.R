test_that("Recipe 19.14: IBS modeling with mutation callback works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version
  recipe_19_14_test <- slim_script(
    slim_block(initialize(), {
      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(50))  # Shorter for testing

      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(1e-4 / 3))
      initializeGenomicElement(g1, 0, 49)
      initializeRecombinationRate(1e-3)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),

    # Mutation callback: enforce uniqueness (IBS)
    slim_block(mutation(), {
      m <- sim$subsetMutations(position = mut$position, nucleotide = mut$nucleotide)

      if (m$length())
        return(m)

      return(T)
    }),

    # Shorter runtime: 500 instead of 1000
    slim_block(500, late(), {
      for (pos in 0:49) {
        muts <- sim$subsetMutations(position = pos)
        nucs <- muts$nucleotide

        cat(pos + " : " + paste(nucs))

        if (size(nucs) != size(unique(nucs)))
          cat("     DUPLICATES!")

        catn()
      }
    })
  )

  # Run the test
  result <- slim_run(recipe_19_14_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify no duplicates were found (key test of IBS uniquing)
  expect_false(grepl("DUPLICATES!", output))

  # Verify position output is present
  expect_true(grepl("0 :|1 :|2 :", output))
})
