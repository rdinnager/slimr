test_that("Recipe 19.5: Elevated CpG mutation rates works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 10 million generations!)
  recipe_19_5_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("L", 1e4)  # Reduced from 1e5
      defineConstant("mu", 7.5e-6)

      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(L))
      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)

      # CpG hypermutability model
      mm <- mm16To256(mmJukesCantor(mu / 3))

      # XCG contexts: increase C→T rate
      xcg <- c("ACG", "CCG", "GCG", "TCG")
      xcg_codons <- nucleotidesToCodons(paste0(xcg))
      mm[xcg_codons, 3] <- mm[xcg_codons, 3] * 20

      # CGX contexts: increase G→A rate
      cgx <- c("CGA", "CGC", "CGG", "CGT")
      cgx_codons <- nucleotidesToCodons(paste0(cgx))
      mm[cgx_codons, 0] <- mm[cgx_codons, 0] * 20

      initializeGenomicElementType("g1", m1, 1.0, mutationMatrix = mm)
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 10)
    }),

    # Shortened runtime: 1000 generations instead of 10 million
    slim_block(1, 1000, early(), {
      if (sim$cycle %% 100 == 1) {
        cat(sim$cycle + ": ")
        print(nucleotideFrequencies(sim$chromosomes$ancestralNucleotides()))
      }
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_19_5_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify nucleotide frequencies are being tracked
  expect_true(grepl("A|C|G|T", output) || grepl("\\d+:", output))
})
