test_that("Recipe 19.7: Standard SLiM fitness with nucleotides works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 1 million generations!)
  recipe_19_7_test <- slim_script(
    slim_block(initialize(), {
      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(3e4))  # Reduced from 3e5

      mm <- mmJukesCantor(2.5e-8)
      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeMutationTypeNuc("m2", 0.1, "g", -0.03, 0.2)

      initializeGenomicElementType("g1", c(m1, m2), c(3, 3), mm)
      initializeGenomicElementType("g2", c(m1, m2), c(5, 1), mm)
      initializeRecombinationRate(1e-8)

      # 10,000 codons instead of 100,000
      types <- rep(c(g1, g2), 1e4)
      starts <- repEach(seqLen(1e4) * 3, 2) + rep(c(0, 2), 1e4)
      ends <- starts + rep(c(1, 0), 1e4)

      initializeGenomicElement(types, starts, ends)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),

    # Shortened runtime: 10,000 instead of 1,000,000
    slim_block(1e4, late(), {
      sub <- sim$substitutions
      pos3 <- (sub$position %% 3 == 2)
      pos12 <- !pos3

      catn(size(sub) + " substitutions occurred.")
      catn(mean(sub$mutationType == m1) * 100 + "% are neutral.")
      catn()
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_19_7_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify substitution analysis is present
  expect_true(grepl("substitutions occurred|neutral", output))
})
