set.seed(456)

# ==============================================================================
# Basic r_output() Functionality
# ==============================================================================

test_that("r_output creates placeholder with correct structure", {
  # Clear resources before test
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Create an output
  result <- r_output(sim$outputFull(), "test_output", do_every = 10)

  # Check placeholder symbol is created
  expect_type(result, "symbol")
  expect_match(as.character(result), "^.__slmr_output_object_")

  # Check resources are populated
  expect_length(.resources$temp_slimr_output$code_for_slim, 1)
  expect_length(.resources$temp_slimr_output$code_for_display, 1)
  expect_length(.resources$temp_slimr_output$output_name, 1)
  expect_length(.resources$temp_slimr_output$message, 1)

  # Check output name stored correctly
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "test_output")
  expect_false(.resources$temp_slimr_output$message[[1]])
})

test_that("r_output detects slim_output type correctly", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Should detect output functions
  result1 <- r_output(sim$outputFull(), "full", do_every = 1)
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "slim_output")

  # Should detect cat functions
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )
  result2 <- r_output(cat("test"), "cat_out", do_every = 1)
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "slim_output")
})

test_that("r_output handles non-output expressions", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Regular expression (not an output function)
  result <- r_output(p1$individuals$x, "coords", do_every = 5)

  # Should use str() and paste() for non-output expressions
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "str\\(")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "paste\\(")
})

test_that("r_output handles do_every frequency control", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Test different frequencies
  result1 <- r_output(sim$outputFull(), "out1", do_every = 1)
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "community\\.tick%%1")

  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result10 <- r_output(sim$outputFull(), "out10", do_every = 10)
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "community\\.tick%%10")

  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result100 <- r_output(sim$outputFull(), "out100", do_every = 100)
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "community\\.tick%%100")
})

test_that("r_output supports custom time_counter", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Use sim.generation for old SLiM compatibility
  result <- r_output(sim$outputFull(), "out", do_every = 5,
                     time_counter = sim.generation)

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "sim\\.generation%%5")
})

test_that("r_output creates correct display code", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output(p1$outputHaplosomes(), "genomes", do_every = 10)

  # Display code should show expression -> name
  expect_match(.resources$temp_slimr_output$code_for_display[[1]], "->")
  expect_match(.resources$temp_slimr_output$code_for_display[[1]], "genomes")
})

# ==============================================================================
# Utility Output Functions
# ==============================================================================

test_that("r_output_full creates correct output", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_full("full_data", do_every = 20)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "full_data")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "sim\\.outputFull")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "community\\.tick%%20")
})

test_that("r_output_full uses default name", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_full()

  expect_identical(.resources$temp_slimr_output$output_name[[1]], "full_output")
})

test_that("r_output_nucleotides with both_genomes=FALSE", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_nucleotides("seqs", both_genomes = FALSE, do_every = 5)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "seqs")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "haploidGenome1\\.nucleotides")
})

test_that("r_output_nucleotides with both_genomes=TRUE", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_nucleotides("seqs", both_genomes = TRUE, do_every = 5)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "seqs")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "haplosomes\\.nucleotides")
})

test_that("r_output_nucleotides with subpops=TRUE returns list", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_nucleotides("seqs", subpops = TRUE, both_genomes = FALSE)

  # Should return list with two outputs
  expect_type(result, "list")
  expect_length(result, 2)
  expect_length(.resources$temp_slimr_output$output_name, 2)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "seqs")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "seqs_subpops")
})

test_that("r_output_nucleotides with custom inds expression", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_nucleotides("seqs", both_genomes = FALSE,
                                  inds = p1.individuals)

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "p1.individuals")
})

test_that("r_output_coords outputs x coordinate", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_coords("x", do_every = 10)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "x")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]],
               "sim\\.subpopulations\\.individuals\\.x")
})

test_that("r_output_coords outputs xy coordinates", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_coords("xy", do_every = 10)

  # Should return list with x and y
  expect_type(result, "list")
  expect_length(result, 2)
  expect_length(.resources$temp_slimr_output$output_name, 2)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "x")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "y")
  expect_match(.resources$temp_slimr_output$code_for_slim[[2]],
               "sim\\.subpopulations\\.individuals\\.y")
})

test_that("r_output_coords outputs xyz coordinates", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_coords("xyz", do_every = 5)

  # Should return list with x, y, and z
  expect_type(result, "list")
  expect_length(result, 3)
  expect_length(.resources$temp_slimr_output$output_name, 3)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "x")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "y")
  expect_identical(.resources$temp_slimr_output$output_name[[3]], "z")
  expect_match(.resources$temp_slimr_output$code_for_slim[[3]],
               "sim\\.subpopulations\\.individuals\\.z")
})

test_that("r_output_sex creates correct output", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_sex("sex_data", do_every = 5)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "sex_data")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]],
               "sim\\.subpopulations\\.individuals\\.sex")
})

test_that("r_output_sex uses default name", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_sex()

  expect_identical(.resources$temp_slimr_output$output_name[[1]], "sex")
})

test_that("r_output_snp without subpops returns two outputs", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_snp("snp_data", subpops = FALSE, do_every = 10)

  # Should return list with snp and position data
  expect_type(result, "list")
  expect_length(result, 2)
  expect_length(.resources$temp_slimr_output$output_name, 2)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "snp_data")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "snp_data_pos")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "containsMutations")
  expect_match(.resources$temp_slimr_output$code_for_slim[[2]], "mutations\\.position")
})

test_that("r_output_snp with subpops returns three outputs", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output_snp("snp_data", subpops = TRUE, do_every = 10)

  # Should return list with snp, position, and subpop data
  expect_type(result, "list")
  expect_length(result, 3)
  expect_length(.resources$temp_slimr_output$output_name, 3)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "snp_data")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "snp_data_pos")
  expect_identical(.resources$temp_slimr_output$output_name[[3]], "snp_data_subpops")
})

# ==============================================================================
# r_message() Functionality
# ==============================================================================

test_that("r_message creates message output", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_message(c("Generation", community.tick), do_every = 10)

  expect_type(result, "symbol")
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "r_message")
  expect_true(.resources$temp_slimr_output$message[[1]])
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "writeFile")
  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "\\.\\.message_file\\.\\.")
})

test_that("r_message respects do_every parameter", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_message("Status update", do_every = 50)

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "community\\.tick%%50")
})

test_that("r_message supports custom time_counter", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_message("Old SLiM message", do_every = 5,
                      time_counter = sim.generation)

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "sim\\.generation%%5")
})

# ==============================================================================
# Edge Cases
# ==============================================================================

test_that("r_output handles empty or unusual names gracefully", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  # Empty name - should work but not be useful
  result <- r_output(sim$outputFull(), "", do_every = 1)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "")

  # Name with special characters
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )
  result2 <- r_output(sim$outputFull(), "test_name_123", do_every = 1)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "test_name_123")
})

test_that("multiple r_output calls accumulate in resources", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result1 <- r_output(sim$outputFull(), "out1", do_every = 1)
  result2 <- r_output(p1$outputHaplosomes(), "out2", do_every = 10)
  result3 <- r_output(p1$individuals$x, "out3", do_every = 5)

  expect_length(.resources$temp_slimr_output$code_for_slim, 3)
  expect_length(.resources$temp_slimr_output$output_name, 3)
  expect_identical(.resources$temp_slimr_output$output_name[[1]], "out1")
  expect_identical(.resources$temp_slimr_output$output_name[[2]], "out2")
  expect_identical(.resources$temp_slimr_output$output_name[[3]], "out3")
})

test_that("r_output with custom type parameter", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output(sim$outputFull(), "custom", do_every = 1,
                     type = "custom_type")

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "custom_type")
})

test_that("r_output with custom expression parameter", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result <- r_output(sim$outputFull(), "custom", do_every = 1,
                     expression = "custom_expression()")

  expect_match(.resources$temp_slimr_output$code_for_slim[[1]], "custom_expression")
})

# ==============================================================================
# Integration with slim_script
# ==============================================================================

test_that("r_output integrates with slim_script", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 100),
    slim_block(1, 100, late(), {
      r_output(sim$outputFull(), "data", do_every = 10)
    })
  )

  # Check script has output attribute
  output_attr <- attr(script, "slimr_output")
  expect_s3_class(output_attr, "tbl_df")
  expect_true("output_name" %in% names(output_attr))
  expect_true(any(output_attr$output_name == "data", na.rm = TRUE))
})

test_that("multiple outputs in same block are tracked", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 100),
    slim_block(1, 100, late(), {
      r_output(sim$outputFull(), "full", do_every = 10)
      r_output(p1$individuals$x, "coords", do_every = 5)
      r_message("Progress update", do_every = 20)
    })
  )

  output_attr <- attr(script, "slimr_output")
  expect_s3_class(output_attr, "tbl_df")

  # Should have multiple outputs captured
  # Filter for non-NA output names to count actual outputs
  actual_outputs <- output_attr[!is.na(output_attr$output_name), ]
  expect_gte(nrow(actual_outputs), 1)
})

test_that("r_output works with r_template", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block_add_subpops(1, 100),
    slim_block(1, 100, late(), {
      r_output(sim$outputFull(), "data", do_every = 10)
    })
  )

  # Should have both template and output attributes
  expect_s3_class(attr(script, "slimr_template"), "tbl_df")
  expect_s3_class(attr(script, "slimr_output"), "tbl_df")

  # Render with template
  rendered <- slim_script_render(script, template = list(mut_rate = 1e-6))

  # Output attribute should be preserved
  expect_s3_class(attr(rendered, "slimr_output"), "tbl_df")
})

test_that("r_output works with r_inline", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(),
    slim_block(1, {
      sim$addSubpop("p1", r_inline(500))
    }),
    slim_block(1, 100, late(), {
      r_output(sim$outputFull(), "data", do_every = 10)
    })
  )

  # Should have both inline and output attributes
  expect_s3_class(attr(script, "slimr_inline"), "tbl_df")
  expect_s3_class(attr(script, "slimr_output"), "tbl_df")
})

# ==============================================================================
# Output Processing Functions
# ==============================================================================

test_that("gather_out_one processes single code block", {
  code <- "r_output(sim$outputFull(), 'test', do_every = 10)"

  result <- gather_out_one(code)

  expect_type(result, "list")
  expect_named(result, c("new_code", "output_info"))
  expect_type(result$output_info, "list")
  expect_named(result$output_info, c("code_for_slim", "code_for_display",
                                      "output_name", "message"))
})

test_that("process_output handles multiple blocks", {
  code <- c(
    "r_output(sim$outputFull(), 'out1', do_every = 1)",
    "x <- 10",
    "r_output(p1$outputHaplosomes(), 'out2', do_every = 5)"
  )
  block_names <- c("block1", "block2", "block3")

  result <- process_output(code, block_names)

  expect_type(result, "list")
  expect_length(result, 2)

  # Second element should be output attribute tibble
  output_attr <- result[[2]]
  expect_s3_class(output_attr, "tbl_df")
  expect_true("block_name" %in% names(output_attr))
  expect_true("output_name" %in% names(output_attr))
})

# ==============================================================================
# Execution and Output Extraction
# ==============================================================================

test_that("r_output captured in execution", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-7),
    slim_block_add_subpops(1, 100),
    slim_block(1, 50, late(), {
      r_output(sim$outputFull(), "full_data", do_every = 10)
    })
  )

  result <- slim_run(script, show_output = FALSE)

  expect_s3_class(result, "slimr_results")
  expect_true("output_data" %in% names(result))
  expect_s3_class(result$output_data, "tbl_df")

  # Should have captured output
  if (nrow(result$output_data) > 0) {
    expect_true(any(result$output_data$name == "full_data", na.rm = TRUE))
  }
})

test_that("r_output_full captured and extractable", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 50),
    slim_block(1, 30, late(), {
      r_output_full("output", do_every = 10)
    })
  )

  result <- slim_run(script, show_output = FALSE)

  expect_identical(result$exit_status, 0L)
  expect_s3_class(result$output_data, "tbl_df")

  # Try to convert to data
  if (nrow(result$output_data) > 0) {
    data <- suppressWarnings(slim_results_to_data(result))
    expect_s3_class(data, "tbl_df")
  }
})

test_that("r_message produces output", {
  skip_if_not(slim_is_avail())

  script <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 50),
    slim_block(1, 30, late(), {
      r_message(c("Generation", community.tick), do_every = 10)
    })
  )

  result <- slim_run(script, show_output = FALSE)

  expect_identical(result$exit_status, 0L)

  # Messages should be captured via file
  output_attr <- attr(script, "slimr_output")
  expect_true(any(output_attr$message, na.rm = TRUE))
})

# ==============================================================================
# Alias Functions
# ==============================================================================

test_that("slimr_output is alias for r_output", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result1 <- slimr_output(sim$outputFull(), "test", do_every = 5)
  n1 <- length(.resources$temp_slimr_output$output_name)

  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result2 <- r_output(sim$outputFull(), "test", do_every = 5)
  n2 <- length(.resources$temp_slimr_output$output_name)

  # Both should create same number of outputs
  expect_identical(n1, n2)
})

test_that("slimr_message is alias for r_message", {
  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result1 <- slimr_message("test", do_every = 5)
  expect_true(.resources$temp_slimr_output$message[[1]])

  .resources$temp_slimr_output <- list(
    code_for_slim = list(),
    code_for_display = list(),
    output_name = list(),
    message = list()
  )

  result2 <- r_message("test", do_every = 5)
  expect_true(.resources$temp_slimr_output$message[[1]])
})

test_that("utility function aliases work", {
  expect_identical(slimr_output_full, r_output_full)
  expect_identical(slimr_output_nucleotides, r_output_nucleotides)
  expect_identical(slimr_output_coords, r_output_coords)
  expect_identical(slimr_output_sex, r_output_sex)
  expect_identical(slimr_output_snp, r_output_snp)
})
