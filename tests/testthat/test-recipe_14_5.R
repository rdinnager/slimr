test_that("Recipe 14.5: Estimating model parameters with ABC works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Since the recipe expects 'mu' to be defined externally (for ABC),
  # we need to define it before running. We'll use a typical mutation rate.
  # Create a complete script with mu defined
  recipe_14_5_with_mu <- slim_script(
    slim_block(initialize(), {
      defineConstant("mu", 1e-7)
      initializeMutationRate(mu)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 999999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", 100)
    }),
    slim_block(1000, late(), {
      cat(sim$mutations$size() + "\n")
    })
  )

  # Run the recipe
  result <- slim_run(recipe_14_5_with_mu)

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # The script outputs the number of segregating mutations
  # Should have at least one line of output with a number
  expect_true(length(output) > 0)

  # Check that output contains a numeric value (mutation count)
  # Filter out empty lines
  output_clean <- output[nzchar(output)]
  expect_true(length(output_clean) > 0)

  # Check that the last non-empty line is a number
  last_line <- tail(output_clean, 1)
  mutation_count <- suppressWarnings(as.integer(last_line))
  expect_true(!is.na(mutation_count))
  expect_true(mutation_count >= 0)
})
