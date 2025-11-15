test_that("Recipe 19.15: IBS with back-mutation removal works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version
  recipe_19_15_test <- slim_script(
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

    # Mutation callback: enforce uniqueness
    slim_block(mutation(), {
      m <- sim$subsetMutations(position = mut$position, nucleotide = mut$nucleotide)

      if (m$length())
        return(m)

      return(T)
    }),

    # Late callback: remove back-mutations
    slim_block(late(), {
      muts <- sim$mutations
      new_muts <- muts[muts$originTick == community$tick]

      back_muts <- NULL
      for (mut in new_muts) {
        pos <- mut$position
        if (mut$nucleotide == sim$chromosomes$ancestralNucleotides(pos, pos))
          back_muts <- c(back_muts, mut)
      }

      if (size(back_muts))
        sim$subpopulations$haplosomes$removeMutations(back_muts)
    }),

    # Shorter runtime: 500 instead of 1000
    slim_block(500, late(), {
      for (pos in 0:49) {
        muts <- sim$subsetMutations(position = pos)
        nucs <- muts$nucleotide
        ancestral <- sim$chromosomes$ancestralNucleotides(pos, pos)

        cat(pos + " : " + paste(nucs))

        if (size(nucs) != size(unique(nucs)))
          cat("     DUPLICATES!")

        if (any(nucs == ancestral))
          cat("     BACK-MUTATION (" + ancestral + ")!")

        catn()
      }
    })
  )

  # Run the test
  result <- slim_run(recipe_19_15_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify no duplicates or back-mutations (key tests of IBS)
  expect_false(grepl("DUPLICATES!", output))
  expect_false(grepl("BACK-MUTATION", output))

  # Verify position output is present
  expect_true(grepl("0 :|1 :|2 :", output))
})
