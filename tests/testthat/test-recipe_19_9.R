test_that("Recipe 19.9: Sequence-based fitness at amino acid level works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 100,000 generations!)
  recipe_19_9_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("L", 1e4)

      defineConstant("TAA", nucleotidesToCodons("TAA"))
      defineConstant("TAG", nucleotidesToCodons("TAG"))
      defineConstant("TGA", nucleotidesToCodons("TGA"))
      defineConstant("STOP", c(TAA, TAG, TGA))
      defineConstant("NONSTOP", (0:63)[match(0:63, STOP) < 0])

      codons <- sample(NONSTOP, 194, replace = T)
      seq1 <- randomNucleotides(253)
      seq2 <- paste0(codonsToNucleotides(codons, format = "char")[0:417])
      seq3 <- randomNucleotides(200)
      seq4 <- paste0(codonsToNucleotides(codons, format = "char")[418:581])
      seq5 <- randomNucleotides(L - 1035)
      seq <- seq1 + seq2 + seq3 + seq4 + seq5

      catn("Initial AA sequence: " + codonsToAminoAcids(codons))

      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(seq)
      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(2.5e-6))
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),

    slim_block(fitnessEffect(), {
      for (g in individual$haplosomes) {
        seq <- g$nucleotides(253, 670) + g$nucleotides(871, 1034)
        codons <- nucleotidesToCodons(seq)
        if (sum(match(codons, STOP) >= 0))
          return(asFloat(0.0))
      }
      return(asFloat(1.0))
    }),

    # Shortened runtime: 1000 instead of 100,000
    slim_block(1000, late(), {
      catn(sim$substitutions$size() + " fixed mutations.")
      as1 <- sim$chromosomes$ancestralNucleotides(253, 670, "integer")
      as2 <- sim$chromosomes$ancestralNucleotides(871, 1034, "integer")
      as <- c(as1, as2)
      codons <- nucleotidesToCodons(as)
      catn("Final AA sequence: " + codonsToAminoAcids(codons))
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_19_9_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify amino acid sequence output is present
  expect_true(grepl("Initial AA sequence|Final AA sequence|fixed mutations", output))
})
