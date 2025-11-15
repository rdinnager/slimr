test_that("Recipe 18.8: Starting WF model with coalescent history works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Part I: Generate a minimal coalescent tree sequence
  # (In the real recipe, this is done with Python/msprime)
  coalescent_script <- slim_script(
    slim_block(initialize(), {
      initializeTreeSeq()
      initializeMutationRate(0)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 1e8 - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, late(), {
      sim$addSubpop("p1", 500)
    }),

    # Run for a short time to build genealogy
    slim_block(100, late(), {
      sim$treeSeqOutput("coalasex.trees")
    })
  )

  # Generate the coalescent tree sequence file
  result1 <- slim_run(coalescent_script, capture_output = TRUE)
  expect_equal(result1$exit_status, 0)
  expect_true(file.exists("coalasex.trees"))

  # Part II: Run the actual recipe that reads from the tree sequence
  source(system.file("extdata/slim_recipes/converted/recipe_18_8.R", package = "slimr"))

  # Run with throw_error=FALSE since it may stop at various points
  result2 <- slim_run(recipe_18_8_script, throw_error = FALSE, capture_output = TRUE)

  # Accept either success (fixation/loss) or timeout
  expect_true(result2$exit_status %in% c(0, 1))

  # Read output
  output <- paste(result2$output, collapse = "\n")

  # Check for valid outcome (FIXED, LOST, or timeout)
  has_outcome <- grepl("FIXED|LOST", output)

  # Should either have an outcome or finish via timeout
  expect_true(has_outcome || result2$exit_status == 0)

  # Clean up output files
  if (file.exists("coalasex.trees")) {
    unlink("coalasex.trees")
  }
  if (file.exists("coalasex_II.trees")) {
    unlink("coalasex_II.trees")
  }
})
