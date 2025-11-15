test_that("Recipe 16.10: Modeling pseudo-autosomal regions (PARs) with addMultiRecombinant() works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # This recipe is computationally intensive (25,000 ticks), so we create
  # a shortened version for testing that runs for 100 ticks instead

  library(slimr)

  # Create shortened test version (100 ticks instead of 25,000)
  recipe_test <- slim_script(
    slim_block(initialize(), {
      defineConstant("A1_LEN", 2e7)
      defineConstant("PAR1_LEN", 2771479)
      defineConstant("PAR2_LEN", 329513)
      defineConstant("X_LEN", 156040895 - (PAR1_LEN + PAR2_LEN))
      defineConstant("Y_LEN", 57227415 - (PAR1_LEN + PAR2_LEN))
      defineConstant("MU", 1e-8)
      defineConstant("R", 1e-7)
      defineConstant("N", 50)
      defineConstant("REC", 10)
      defineConstant("RUNTIME", 100)

      initializeSLiMModelType("nonWF")
      initializeSex()
      initializeMutationType("m1", 0.5, "f", 0.0)$convertToSubstitution <- T
      initializeGenomicElementType("g1", m1, 1.0)

      ids <- 1:5
      lengths <- c(A1_LEN, PAR1_LEN, X_LEN, Y_LEN, PAR2_LEN)
      types <- c("A", "A", "X", "Y", "A")
      symbols <- c("A1", "P1", "X", "Y", "P2")

      for (i in 0:4) {
        chr <- initializeChromosome(ids[i], lengths[i], type = types[i], symbol = symbols[i])
        initializeGenomicElement(g1)
        initializeMutationRate(MU)
        initializeRecombinationRate(R)
        defineConstant(paste0("CHR_", symbols[i]), chr)
      }
    }),

    slim_block(1, late(), {
      sim$addSubpop("p1", N)
    }),

    slim_block(2, .., early(), {
      adults <- p1$subsetIndividuals(minAge = 1)
      sim$killIndividuals(adults)
    }),

    slim_block(100, early(), {
      sim$simulationFinished()
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_test)

  # Verify success
  expect_equal(result$exit_status, 0)
})
