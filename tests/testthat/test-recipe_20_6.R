test_that("Recipe 20.6: A coevolutionary host-parasitoid trait-matching model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (500 generations instead of 10,000)
  recipe_20_6_test <- slim_script(
    slim_block(all = initialize(), {
      defineConstant("K", 100)
      defineConstant("R", log(20))
      defineConstant("A", 0.015)
      defineConstant("S", 10^2)
      defineConstant("N0_host", asInteger((135.6217 + 0.01) * S))
      defineConstant("N0_parasitoid", asInteger((109.3010 + 0.01) * S))
      defineConstant("S_M", 1.0)
      defineConstant("S_S", 2.0)
      initializeSLiMModelType("nonWF")
    }),

    slim_block(host = initialize(), {
      initializeSpecies(avatar = "🐛", color = "cornflowerblue")
      initializeMutationType("m1", 0.5, "n", 0.0, 0.1)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 9999)
      initializeMutationRate(1e-7)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(parasitoid = initialize(), {
      initializeSpecies(avatar = "🦟", color = "red")
      initializeMutationType("m2", 0.5, "n", 0.0, 0.1)
      initializeGenomicElementType("g2", m2, 1.0)
      initializeGenomicElement(g2, 0, 9999)
      initializeMutationRate(1e-7)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(host = mutationEffect(m1), {
      return(asFloat(1.0))
    }),

    slim_block(parasitoid = mutationEffect(m2), {
      return(asFloat(1.0))
    }),

    slim_block(all = 2, .., first(), {
      hosts <- host$subpopulations$individuals
      parasitoids  <- parasitoid$subpopulations$individuals
      x1 <- hosts$size() / S
      x2 <- parasitoids$size() / S
      host_values <- hosts$tagF
      parasitoid_values <- parasitoids$tagF
      mean_parasitoid <- mean(parasitoid_values)
      scale <- dnorm(asFloat(0.0), asFloat(0.0), S_M)
      host_match <- dnorm(host_values, mean_parasitoid, S_M) / scale
      parasitoids$tag <- 0
      P_parasitized_byhost <- 1 - exp(-A * x2 * host_match)
      killed <- rbinom(hosts$size(), 1, P_parasitized_byhost)
      hosts$tag <- killed
      hunters <- sapply(hosts[killed == 1], "sample(parasitoids, 1, " +
        "weights=dnorm(applyValue.tagF - parasitoid_values, 0.0, S_M));")
      for (hunter in hunters)
        hunter$tag <- hunter$tag + 1
      survivors <- hosts[killed == 0]
      P_survives <- exp(-x1 / K)
      survived <- rbinom(survivors$size(), 1, P_survives)
      dead <- survivors[survived == 0]
      dead$tag <- 1
    }),

    slim_block(host = reproduction(), {
      if (individual$tag == 0) {
        litterSize <- rpois(1, exp(R))
        if (litterSize > 0) {
          mate <- subpop$sampleIndividuals(1, exclude = individual)
          for (i in seqLen(litterSize))
            subpop$addCrossed(individual, mate)
        }
      }
    }),

    slim_block(parasitoid = reproduction(), {
      litterSize <- individual$tag
      if (litterSize > 0) {
        mate <- subpop$sampleIndividuals(1, exclude = individual)
        for (i in seqLen(litterSize))
          subpop$addCrossed(individual, mate)
      }
    }),

    slim_block(all = 1, early(), {
      host$addSubpop("p1", N0_host)
      parasitoid$addSubpop("p2", N0_parasitoid)
    }),

    slim_block(all = 1, .., early(), {
      scale <- dnorm(asFloat(0.0), asFloat(0.0), S_S)
      hosts <- host$subpopulations$individuals
      phenotypes <- hosts$sumOfMutationsOfType(m1)
      hosts$fitnessScaling <- asFloat(dnorm(phenotypes, asFloat(0.0), S_S) / scale)
      hosts$tagF <- phenotypes
      parasitoids  <- parasitoid$subpopulations$individuals
      phenotypes <- parasitoids$sumOfMutationsOfType(m2)
      parasitoids$fitnessScaling <- asFloat(dnorm(phenotypes, asFloat(0.0), S_S) / scale)
      parasitoids$tagF <- phenotypes
      hosts[hosts$age > 0]$fitnessScaling <- asFloat(0.0)
      parasitoids[parasitoids$age > 0]$fitnessScaling <- asFloat(0.0)
    }),

    slim_block(all = 500, late(), {
      NULL  # Shortened to 500 generations for testing
    })
  )

  # Run the shortened test version
  result <- slim_run(recipe_20_6_test, capture_output = TRUE)

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

  # Coevolutionary model should complete successfully
  expect_true(result$exit_status == 0)
})
