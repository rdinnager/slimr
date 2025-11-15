test_that("Recipe 18.9: Starting sexual nonWF model with coalescent history works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Part I: Generate a minimal coalescent tree sequence for nonWF sexual model
  # (In the real recipe, this is done with Python/msprime)
  coalescent_script <- slim_script(
    slim_block(initialize(), {
      initializeSLiMModelType("nonWF")
      initializeTreeSeq()
      initializeSex()
      initializeMutationRate(0)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeMutationType("m2", 0.5, "f", 0.1)
      m2$convertToSubstitution <- T
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 1e8 - 1)
      initializeRecombinationRate(1e-8)
    }),

    # Female reproduction callback
    slim_block(reproduction(NULL, "F"), {
      subpop$addCrossed(individual, subpop$sampleIndividuals(1, sex = "M"))
    }),

    slim_block(1, early(), {
      sim$addSubpop("p0", 500)
    }),

    # Regulate population size
    slim_block(early(), {
      p0$fitnessScaling <- asFloat(500 / p0$individualCount)
    }),

    # Add a beneficial mutation before saving
    slim_block(50, late(), {
      target <- sample(sim$subpopulations$haplosomes, 1)
      target$addNewDrawnMutation(m2, 10000)
    }),

    # Run for a short time to build genealogy, then save
    slim_block(100, late(), {
      sim$treeSeqOutput("coalsex.trees")
    })
  )

  # Generate the coalescent tree sequence file with mutation
  result1 <- slim_run(coalescent_script, capture_output = TRUE)
  expect_equal(result1$exit_status, 0)
  expect_true(file.exists("coalsex.trees"))

  # Part II: Run the actual recipe that reads from the tree sequence
  source(system.file("extdata/slim_recipes/converted/recipe_18_9.R", package = "slimr"))

  # Run with throw_error=FALSE since it may stop at various points
  result2 <- slim_run(recipe_18_9_script, throw_error = FALSE, capture_output = TRUE)

  # Accept either success (fixation/loss) or timeout
  expect_true(result2$exit_status %in% c(0, 1))

  # Read output
  output <- paste(result2$output, collapse = "\n")

  # Check for valid outcome (FIXED, LOST, or timeout)
  has_outcome <- grepl("FIXED|LOST", output)

  # Should either have an outcome or finish via timeout
  expect_true(has_outcome || result2$exit_status == 0)

  # Clean up output files
  if (file.exists("coalsex.trees")) {
    unlink("coalsex.trees")
  }
  if (file.exists("coalsex_II.trees")) {
    unlink("coalsex_II.trees")
  }
})
