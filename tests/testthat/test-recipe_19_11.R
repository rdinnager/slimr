test_that("Recipe 19.11: GC-biased gene conversion works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (original runs 500,001 generations!)
  recipe_19_11_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("L", 1e5)
      defineConstant("alpha", 2.5e-6)

      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(L))

      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(alpha))
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-5)

      # GC-biased gene conversion
      initializeGeneConversion(0.7, 1500, 0.80, 0.10)
    }),

    slim_block(1, early(), {
      sim$addSubpop("p1", 500)
    }),

    # Shortened runtime: 5000 instead of 500,001
    slim_block(1, 5000, early(), {
      if (sim$cycle %% 1000 == 1) {
        cat(sim$cycle + ": ")
        print(nucleotideFrequencies(sim$chromosomes$ancestralNucleotides()))
      }
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_19_11_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify nucleotide frequency output is present
  expect_true(grepl("A|C|G|T", output))
})
