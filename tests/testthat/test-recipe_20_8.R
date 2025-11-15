test_that("Recipe 20.8: Within-host reproduction in a host-pathogen model works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create shortened test version (500 generations instead of 2000)
  # Also reduce complexity for faster testing
  recipe_20_8_test <- slim_script(
    slim_block(all = initialize(), {
      initializeSLiMModelType("nonWF")
      defineConstant("K_MONKEY", 50)              # Reduced from 100
      defineConstant("F_MONKEY", 3.0)
      defineConstant("G_MONKEY", 20)
      defineConstant("P_TRANSMISSION", 0.0001)
      defineConstant("SUPPRESSION_μ", 30000)
      defineConstant("SUPPRESSION_σ", 10000)
      defineConstant("SUPPRESSION_STRENGTH", 0.4)
      defineConstant("DEATH", 100000)
    }),

    slim_block(monkey = initialize(), {
      initializeSpecies(tickModulo = G_MONKEY, avatar = "🐵", color = "tan3")
      initializeSLiMOptions(keepPedigrees = T)
      initializeSex()
    }),

    slim_block(pathogen = initialize(), {
      initializeSpecies(avatar = "🦠", color = "chartreuse3")
    }),

    slim_block(all = 2, .., first(), {
      if (p1$individualCount == 0)
        stop(monkey$avatar + " extinct")
      if (pathogen$subpopulations$size() == 0)
        stop(pathogen$avatar + " extinct")
    }),

    slim_block(monkey = reproduction(p1, "F"), {
      litterSize <- rpois(1, F_MONKEY)
      for (i in seqLen(litterSize)) {
        mate <- subpop$sampleIndividuals(1, sex = "M")
        subpop$addCrossed(individual, mate)
      }
    }),

    slim_block(pathogen = reproduction(), {
      subpop$addCloned(individual)
    }),

    slim_block(all = 1, early(), {
      monkey$addSubpop("p1", K_MONKEY)
      initial_hosts <- p1$sampleIndividuals(3, replace = F)  # Reduced from 5
      pathogen$tag <- 3

      for (initial_host in initial_hosts) {
        pathogen_subpop <- pathogen$addSubpop(pathogen$tag, 1)
        pathogen_subpop$tag <- initial_host$pedigreeID
        pathogen$tag <- pathogen$tag + 1
      }
    }),

    slim_block(monkey = 1, .., early(), {
      p1$fitnessScaling <- asFloat(K_MONKEY / p1$individualCount)
    }),

    slim_block(all = 1, .., early(), {
      if (p1$individualCount > 1) {
        pathogenSubpops <- pathogen$subpopulations
        allPathogens <- pathogenSubpops$individuals
        isTransmitted <- (rbinom(allPathogens$size(), 1, P_TRANSMISSION) == 1)
        moving <- allPathogens[isTransmitted]

        for (ind in moving) {
          hostID <- ind$subpopulation$tag
          currentHost <- monkey$individualsWithPedigreeIDs(hostID)
          newHost <- p1$sampleIndividuals(1, exclude = currentHost)
          newHostID <- newHost$pedigreeID
          newSubpop <- pathogenSubpops[pathogenSubpops$tag == newHostID]

          if (newSubpop$size() == 0) {
            newSubpop <- pathogen$addSubpop(pathogen$tag, 0)
            pathogen$tag <- pathogen$tag + 1
            newSubpop$tag <- newHostID
            pathogenSubpops <- c(pathogenSubpops, newSubpop)
          }
          newSubpop$takeMigrants(ind)
        }
      }
    }),

    slim_block(all = 1, .., early(), {
      suppress_scale <- SUPPRESSION_STRENGTH / dnorm(asFloat(0.0), asFloat(0.0), SUPPRESSION_σ)

      for (pathogenSubpop in pathogen$subpopulations) {
        popsize <- asFloat(pathogenSubpop$individualCount)
        P_supp <- (dnorm(popsize, SUPPRESSION_μ, SUPPRESSION_σ) * suppress_scale)
        P_death <- popsize / DEATH

        if (runif(1) < P_supp) {
          pathogenSubpop$removeSubpopulation()
        } else if (runif(1) < P_death) {
          host <- monkey$individualsWithPedigreeIDs(pathogenSubpop$tag)
          monkey$killIndividuals(host)
          pathogenSubpop$removeSubpopulation()
        }
      }
    }),

    slim_block(monkey = survival(p1), {
      if (!surviving) {
        hostID <- individual$pedigreeID
        pathogenSubpops <- pathogen$subpopulations
        pathogenSubpop <- pathogenSubpops[pathogenSubpops$tag == hostID]
        pathogenSubpop$removeSubpopulation()
      }
      return(NULL)
    }),

    slim_block(all = 500, late(), {
      NULL  # Shortened to 500 generations for testing
    })
  )

  # Run the shortened test version
  # Use throw_error = FALSE to handle potential extinctions gracefully
  result <- slim_run(recipe_20_8_test, throw_error = FALSE, capture_output = TRUE)

  # Verify success or controlled stop (extinction is a valid outcome)
  expect_true(result$exit_status %in% c(0, 1))

  # Check output
  output <- if (length(result$output) > 0) {
    paste(result$output, collapse = "\n")
  } else if (file.exists(result$output_file)) {
    paste(readLines(result$output_file), collapse = "\n")
  } else {
    ""
  }

  # Should either complete successfully or have valid extinction message
  has_success <- result$exit_status == 0
  has_extinction <- grepl("extinct", output)
  expect_true(has_success || has_extinction)
})
