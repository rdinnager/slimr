test_that("Recipe 20.7: A coevolutionary host-parasite matching-allele model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (500 generations instead of 2000)
  recipe_20_7_test <- slim_script(
    slim_block(all = initialize(), {
      defineConstant("L", 1)
    }),

    slim_block(host = initialize(), {
      initializeSpecies(avatar = "🦌")
      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(L))
      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(asFloat(1e-3)))
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(parasite = initialize(), {
      initializeSpecies(avatar = "🐛")
      initializeSLiMOptions(nucleotideBased = T)
      initializeAncestralNucleotides(randomNucleotides(L))
      initializeMutationTypeNuc("m2", 0.5, "f", 0.0)
      initializeGenomicElementType("g2", m2, 1.0, mmJukesCantor(asFloat(1e-3)))
      initializeGenomicElement(g2, 0, L - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_function("o<Species>$ species", "s$ nuc",
                  name = "nucleotideFreq",
                  return_type = "float$",
                  body = function(species, nuc) {
                    nucs <- species$subpopulations$individuals$haplosomes$nucleotides()
                    return(mean(nucs == nuc))
                  }),

    slim_block(all = 1, early(), {
      host$addSubpop("p0", 1000)
      parasite$addSubpop("p1", 1000)
    }),

    slim_block(all = 1, .., late(), {
      parasites <- p1$individuals
      chosen_hosts <- sample(p0$individuals, size(parasites), replace = T)

      for (i in 0:(size(parasites) - 1)) {
        p <- parasites[i]
        h <- chosen_hosts[i]
        all_nucleotides <- c(p, h)$haplosomes$nucleotides()

        if (size(unique(all_nucleotides, preserveOrder = F)) == 1) {
          p$fitnessScaling <- asFloat(1.5 * p$fitnessScaling)
          h$fitnessScaling <- asFloat(0.5 * h$fitnessScaling)
        }
      }
    }),

    slim_block(all = 500, late(), {
      NULL  # Shortened to 500 generations for testing
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_20_7_test, capture_output = TRUE)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Check output
  output <- if (length(result$output) > 0) {
    paste(result$output, collapse = "\n")
  } else if (file.exists(result$output_file)) {
    paste(readLines(result$output_file), collapse = "\n")
  } else {
    ""
  }

  # Matching-allele coevolutionary model should complete successfully
  expect_true(result$exit_status == 0)
})
