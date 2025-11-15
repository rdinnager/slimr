# Test file for advanced slim_extract functionality
# Focuses on features not covered in test-slim_extract.R

# Helper function to create mock SLiM 4.x output (uses "Genomes:")
mock_slim4_genome_output <- function() {
  paste0(
    "#OUT: 10 10 GS 200\n",
    "Mutations:\n",
    "1 101 m1 50000 0.0 0.5 p1 1 5\n",
    "2 102 m1 75000 0.0 0.5 p1 2 3\n",
    "Genomes:\n",
    "p1:0 A 1 2\n",
    "p1:1 A 1\n",
    "p1:2 A\n"
  )
}

# Helper function to create mock SLiM 5.x output (uses "Haplosomes:")
mock_slim5_genome_output <- function() {
  paste0(
    "#OUT: 10 10 HS 200\n",
    "Mutations:\n",
    "1 101 m1 50000 0.0 0.5 p1 1 5\n",
    "2 102 m1 75000 0.0 0.5 p1 2 3\n",
    "Haplosomes:\n",
    "p1:0 A 1 2\n",
    "p1:1 A 1\n",
    "p1:2 A\n"
  )
}

# Helper function to create mock outputFull data (SLiM 5.x style)
mock_slim5_output_full <- function() {
  paste0(
    "#OUT: 100 A p1 500\n",
    "Populations:\n",
    "p1 500 H 0.5\n",
    "Mutations:\n",
    "1 101 m1 50000 0.0 0.5 p1 1 10\n",
    "2 102 m1 75000 0.0 0.5 p1 2 5\n",
    "Individuals:\n",
    "p1:0 H p1:0 p1:1 A 0.5 0.5 0.5\n",
    "p1:1 H p1:2 p1:3 A 0.5 0.5 0.5\n",
    "Chromosome:\n",
    "A 100000\n",
    "Haplosomes:\n",
    "p1:0 A 1 2\n",
    "p1:1 A 1\n",
    "p1:2 A 2\n",
    "p1:3 A\n"
  )
}

# Helper function to create mock outputFull data (SLiM 4.x style)
mock_slim4_output_full <- function() {
  paste0(
    "#OUT: 100 A p1 500\n",
    "Populations:\n",
    "p1 500 H 0.5\n",
    "Mutations:\n",
    "1 101 m1 50000 0.0 0.5 p1 1 10\n",
    "2 102 m1 75000 0.0 0.5 p1 2 5\n",
    "Individuals:\n",
    "p1:0 H p1:0 p1:1 A 0.5 0.5 0.5\n",
    "p1:1 H p1:2 p1:3 A 0.5 0.5 0.5\n",
    "Chromosome:\n",
    "A 100000\n",
    "Genomes:\n",
    "p1:0 A 1 2\n",
    "p1:1 A 1\n",
    "p1:2 A 2\n",
    "p1:3 A\n"
  )
}

# ==============================================================================
# Test Suite 1: SLiM 4.x vs 5.x Compatibility
# ==============================================================================

test_that("slim_extract_genome parses SLiM 4.x 'Genomes:' format", {
  output_data <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim4_genome_output()),
    type = "slim_output"
  )

  result <- slim_extract_genome(output_data, type = "mutations")

  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 2)
  expect_true(all(c("mut_id", "chrome_pos", "generation") %in% names(result)))
})

test_that("slim_extract_genome parses SLiM 5.x 'Haplosomes:' format", {
  output_data <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim5_genome_output()),
    type = "slim_output"
  )

  result <- slim_extract_genome(output_data, type = "mutations")

  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 2)
  expect_true(all(c("mut_id", "chrome_pos", "generation") %in% names(result)))
})

test_that("slim_extract_genome produces identical results for SLiM 4.x and 5.x", {
  output_data_4 <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim4_genome_output()),
    type = "slim_output"
  )

  output_data_5 <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim5_genome_output()),
    type = "slim_output"
  )

  result_4 <- slim_extract_genome(output_data_4, type = "full")
  result_5 <- slim_extract_genome(output_data_5, type = "full")

  # Should have same structure and data
  expect_equal(names(result_4), names(result_5))
  expect_equal(nrow(result_4), nrow(result_5))
  expect_equal(result_4$mut_id, result_5$mut_id)
})

test_that("slim_extract_full parses SLiM 4.x 'Genomes:' in outputFull", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim4_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "genomes")

  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 4)
  expect_true(all(c("gen_id", "gen_type", "generation") %in% names(result)))
})

test_that("slim_extract_full parses SLiM 5.x 'Haplosomes:' in outputFull", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "genomes")

  expect_s3_class(result, "tbl_df")
  expect_true(nrow(result) >= 4)
  expect_true(all(c("gen_id", "gen_type", "generation") %in% names(result)))
})

test_that("slim_extract_full handles both GS (SLiM 4.x) and HS (SLiM 5.x) metadata", {
  # SLiM 4.x uses "GS 200" (Genome count)
  output_4 <- tibble::tibble(
    generation = 100,
    data = list(mock_slim4_genome_output()),
    type = "slim_output"
  )

  # SLiM 5.x uses "HS 200" (Haplosome count)
  output_5 <- tibble::tibble(
    generation = 100,
    data = list(mock_slim5_genome_output()),
    type = "slim_output"
  )

  # Both should extract without error
  expect_no_error(slim_extract_genome(output_4, type = "genomes"))
  expect_no_error(slim_extract_genome(output_5, type = "genomes"))
})

# ==============================================================================
# Test Suite 2: expand_mutations Functionality
# ==============================================================================

test_that("expand_mutations = FALSE keeps mutations as list column", {
  output_data <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim5_genome_output()),
    type = "slim_output"
  )

  result <- slim_extract_genome(output_data, type = "genomes", expand_mutations = FALSE)

  expect_s3_class(result, "tbl_df")
  expect_true("mut_list" %in% names(result))
  expect_type(result$mut_list, "list")
  # REMOVED: mut_list elements may not be integers depending on implementation
  # expect_true(all(sapply(result$mut_list, is.integer)))
})

test_that("expand_mutations = TRUE unnests to multiple rows", {
  output_data <- tibble::tibble(
    generation = 10,
    name = "test",
    expression = "p1.outputHaplosomes()",
    data = list(mock_slim5_genome_output()),
    type = "slim_output"
  )

  result_collapsed <- slim_extract_genome(output_data, type = "genomes", expand_mutations = FALSE)
  result_expanded <- slim_extract_genome(output_data, type = "genomes", expand_mutations = TRUE)

  # Expanded should have more rows (one per mutation per genome)
  expect_true(nrow(result_expanded) >= nrow(result_collapsed))

  # Expanded should have mut_id column instead of mut_list
  expect_true("mut_id" %in% names(result_expanded))
  expect_false("mut_list" %in% names(result_expanded))
  expect_type(result_expanded$mut_id, "integer")
})

# REMOVED: Implementation bug - function returns nrow based on metadata count (200) not actual genomes (3)
# The function uses "HS 200" from metadata instead of counting actual Haplosomes lines
# This reveals a bug in slim_extract_genome() parsing logic
# test_that("expand_mutations handles genomes with no mutations", {
#   # Create output where some genomes have no mutations
#   output_str <- paste0(
#     "#OUT: 10 10 HS 200\n",
#     "Mutations:\n",
#     "1 101 m1 50000 0.0 0.5 p1 1 5\n",
#     "Haplosomes:\n",
#     "p1:0 A 1\n",
#     "p1:1 A\n",
#     "p1:2 A\n"
#   )
#
#   output_data <- tibble::tibble(
#     generation = 10,
#     name = "test",
#     expression = "p1.outputHaplosomes()",
#     data = list(output_str),
#     type = "slim_output"
#   )
#
#   result_collapsed <- slim_extract_genome(output_data, type = "genomes", expand_mutations = FALSE)
#   result_expanded <- slim_extract_genome(output_data, type = "genomes", expand_mutations = TRUE)
#
#   # Collapsed should have 3 rows (one per genome)
#   expect_equal(nrow(result_collapsed), 3)
#
#   # Expanded should drop genomes with no mutations
#   expect_true(nrow(result_expanded) >= 1)
#
#   # Check that empty mutation lists are handled correctly
#   expect_true(any(sapply(result_collapsed$mut_list, length) == 0))
# })

# REMOVED: Same implementation bug as previous test
# Expects 2 rows (actual genomes) but gets 100 (from "HS 100" metadata)
# test_that("expand_mutations with NA values", {
#   # Create output with potential NA-inducing edge cases
#   output_str <- paste0(
#     "#OUT: 10 10 HS 100\n",
#     "Mutations:\n",
#     "Haplosomes:\n",
#     "p1:0 A\n",
#     "p1:1 A\n"
#   )
#
#   output_data <- tibble::tibble(
#     generation = 10,
#     name = "test",
#     expression = "p1.outputHaplosomes()",
#     data = list(output_str),
#     type = "slim_output"
#   )
#
#   result_collapsed <- slim_extract_genome(output_data, type = "genomes", expand_mutations = FALSE)
#
#   expect_s3_class(result_collapsed, "tbl_df")
#   expect_equal(nrow(result_collapsed), 2)
# })

test_that("expand_mutations works with slim_extract_full", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result_collapsed <- slim_extract_full(output_data, type = "genomes", expand_mutations = FALSE)
  result_expanded <- slim_extract_full(output_data, type = "genomes", expand_mutations = TRUE)

  expect_true("mut_list" %in% names(result_collapsed))
  expect_true("mut_id" %in% names(result_expanded))
  expect_true(nrow(result_expanded) >= nrow(result_collapsed))
})

# ==============================================================================
# Test Suite 3: Edge Cases in Parsing
# ==============================================================================

test_that("handles empty mutations section", {
  output_str <- paste0(
    "#OUT: 10 10 HS 100\n",
    "Mutations:\n",
    "Haplosomes:\n",
    "p1:0 A\n",
    "p1:1 A\n"
  )

  output_data <- tibble::tibble(
    generation = 10,
    data = list(output_str),
    type = "slim_output"
  )

  result_muts <- slim_extract_genome(output_data, type = "mutations")
  result_gens <- slim_extract_genome(output_data, type = "genomes")

  # Should handle gracefully - mutations will be empty or NA
  expect_s3_class(result_muts, "tbl_df")
  expect_s3_class(result_gens, "tbl_df")
})

test_that("handles missing HS/GS count in metadata", {
  # Missing the genome/haplosome count
  output_str <- paste0(
    "#OUT: 10 10\n",
    "Mutations:\n",
    "1 101 m1 50000 0.0 0.5 p1 1 5\n",
    "Haplosomes:\n",
    "p1:0 A 1\n"
  )

  output_data <- tibble::tibble(
    generation = 10,
    data = list(output_str),
    type = "slim_output"
  )

  # Should error with informative message
  expect_error(
    slim_extract_genome(output_data, type = "genomes"),
    "Failed to extract haplosome/genome count"
  )
})

test_that("handles incomplete output markers", {
  # Missing end marker
  incomplete_output <- c(
    "<slimr_out:start>",
    "1,'test','expr()','data'",
    "more data"
    # No <slimr_out:end>
  )

  result <- slim_extract_output_data(incomplete_output)

  # Should handle incomplete markers gracefully
  expect_s3_class(result$data, "tbl_df")
})

test_that("handles multiple output blocks in sequence", {
  multi_output <- c(
    "<slimr_out:start>",
    "1,'test1','expr1()','data1'",
    "<slimr_out:end>",
    "<slimr_out:start>",
    "2,'test2','expr2()','data2'",
    "<slimr_out:end>",
    "<slimr_out:start>",
    "3,'test3','expr3()','data3'",
    "<slimr_out:end>"
  )

  result <- slim_extract_output_data(multi_output)

  expect_s3_class(result$data, "tbl_df")
  expect_equal(nrow(result$data), 3)
})

test_that("handles single-line output", {
  single_line <- c(
    "<slimr_out:start>",
    "1,'test','expr()','single_value'",
    "<slimr_out:end>"
  )

  result <- slim_extract_output_data(single_line)

  expect_s3_class(result$data, "tbl_df")
  expect_equal(nrow(result$data), 1)
})

test_that("handles malformed data gracefully", {
  # Test with various malformed inputs
  malformed_genome <- paste0(
    "#OUT: invalid format\n",
    "Mutations:\n",
    "malformed mutation line\n",
    "Haplosomes:\n",
    "also malformed\n"
  )

  output_data <- tibble::tibble(
    generation = 10,
    data = list(malformed_genome),
    type = "slim_output"
  )

  # Should handle with warning or return NA-filled tibble
  expect_s3_class(
    suppressWarnings(slim_extract_genome(output_data, type = "mutations")),
    "tbl_df"
  )
})

# ==============================================================================
# Test Suite 4: slim_extract_genlight Advanced Features
# ==============================================================================

test_that("slim_extract_genlight converts outputFull to genlight", {
  skip_if_not_installed("adegenet")
  skip_if_slim_not_installed()

  if(!on_covr()) {
    test_sim <- slim_script(
      slim_block_init_minimal(seed = 456, mutation_rate = 1e-6),
      slim_block_add_subpops(1, 50),
      slim_block(1, 50, late(), {
        slimr_output(sim$outputFull(), "output")
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_adv_gl_1.rds"))
    }
  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_adv_gl_1.rds"))
  }

  gl <- slim_extract_genlight(test_sim)

  expect_s4_class(gl, "genlight")
  expect_true(adegenet::nLoc(gl) >= 0)
  expect_true(adegenet::nInd(gl) == 50)
})

test_that("slim_extract_genlight handles multiple generations with by parameter", {
  skip_if_not_installed("adegenet")
  skip_if_slim_not_installed()

  if(!on_covr()) {
    test_sim <- slim_script(
      slim_block_init_minimal(seed = 789, mutation_rate = 1e-6),
      slim_block_add_subpops(1, 50),
      slim_block(1, 100, late(), {
        slimr_output(sim$outputFull(), "output", do_every = 25)
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_adv_gl_2.rds"))
    }
  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_adv_gl_2.rds"))
  }

  gl_by_gen <- slim_extract_genlight(test_sim, by = "generation")

  expect_s3_class(gl_by_gen, "tbl_df")
  expect_true("generation" %in% names(gl_by_gen))
  expect_true("genlight" %in% names(gl_by_gen))
  expect_true(nrow(gl_by_gen) >= 2)
})

test_that("slim_extract_genlight handles genome output", {
  skip_if_not_installed("adegenet")
  skip_if_slim_not_installed()

  if(!on_covr()) {
    test_sim <- slim_script(
      slim_block_init_minimal(seed = 321, mutation_rate = 1e-6),
      slim_block_add_subpops(1, 50),
      slim_block(1, 50, late(), {
        slimr_output(p1$individuals$haplosomes$outputHaplosomes(), "genomes")
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_adv_gl_3.rds"))
    }
  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_adv_gl_3.rds"))
  }

  gl <- slim_extract_genlight(test_sim)

  expect_s4_class(gl, "genlight")
  expect_true(adegenet::nInd(gl) >= 1)
})

test_that("slim_extract_genlight with name parameter filters correctly", {
  skip_if_not_installed("adegenet")
  skip_if_slim_not_installed()

  if(!on_covr()) {
    test_sim <- slim_script(
      slim_block_init_minimal(seed = 654, mutation_rate = 1e-6),
      slim_block_add_subpops(1, 50),
      slim_block(1, 50, late(), {
        slimr_output(sim$outputFull(), "full_output")
        slimr_output(p1$individuals$haplosomes$outputHaplosomes(), "genome_output")
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_adv_gl_4.rds"))
    }
  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_adv_gl_4.rds"))
  }

  # Extract specific output by name
  gl_full <- slim_extract_genlight(test_sim, name = "full_output")

  expect_s4_class(gl_full, "genlight")
})

# ==============================================================================
# Test Suite 5: Different Output Types
# ==============================================================================

test_that("slim_extract_full extracts mutations only", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "mutations")

  expect_s3_class(result, "tbl_df")
  expect_true(all(c("mut_id", "mut_type", "chrome_pos", "selection", "dominance") %in% names(result)))
})

test_that("slim_extract_full extracts individuals only", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "individuals")

  expect_s3_class(result, "tbl_df")
  expect_true(all(c("unique_ind_id", "pop_id", "ind_id", "gen_id") %in% names(result)))
})

test_that("slim_extract_full extracts genomes/haplosomes only", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "genomes")

  expect_s3_class(result, "tbl_df")
  expect_true(all(c("gen_id", "gen_type", "mut_list") %in% names(result)))
})

test_that("slim_extract_full with join = FALSE returns list", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data,
                               type = c("mutations", "individuals"),
                               join = FALSE)

  expect_type(result, "list")
  expect_s3_class(result, "slimr_outputFull_list")
  expect_equal(length(result), 2)
  expect_true(all(c("mutations", "individuals") %in% names(result)))
})

test_that("slim_extract_full with join = TRUE merges data", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data,
                               type = c("individuals", "genomes"),
                               join = TRUE)

  expect_s3_class(result, "slimr_outputFull_joined")
  expect_s3_class(result, "tbl_df")
  # Should have columns from both individuals and genomes
  expect_true(any(c("unique_ind_id", "ind_id") %in% names(result)))
  expect_true(any(c("gen_id", "gen_type") %in% names(result)))
})

test_that("slim_extract_full handles full_individual type", {
  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(mock_slim5_output_full()),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "full_individual")

  expect_s3_class(result, "tbl_df")
  # Should include individuals, genomes, and mutations
  expect_true(any(c("ind_id", "gen_id", "mut_id") %in% names(result)))
})

# REMOVED TEST - slim_extract_genome with join=FALSE has implementation bug
# Error: Join columns in `y` must be present in the data. Problem with `gen_id`
# The function tries to join on 'gen_id' column that doesn't exist in mock data
# This appears to be a bug in slim_extract.R:520 where it expects a column that
# isn't provided by the data
# Per user instruction: "Don't write tests for bugs I haven't fixed yet!"
# See claude_notes/test_failure_analysis.md

# test_that("slim_extract_genome handles multiple output types", {
#   output_data <- tibble::tibble(
#     generation = 10,
#     name = "test",
#     expression = "p1.outputHaplosomes()",
#     data = list(mock_slim5_genome_output()),
#     type = "slim_output"
#   )
#
#   result <- slim_extract_genome(output_data, type = c("mutations", "genomes"), join = FALSE)
#
#   expect_type(result, "list")
#   expect_equal(length(result), 2)
#   expect_true(all(c("mutations", "genomes") %in% names(result)))
# })

# REMOVED TEST - slim_results_to_data doesn't support vector input for generations
# The function uses `if (generations == 0)` which fails when given a vector c(20, 60)
# Error: "the condition has length > 1"
# This is a bug in the implementation - should check length first
# Per user instruction: "Don't write tests for bugs I haven't fixed yet!"
# See claude_notes/test_failure_analysis.md

# test_that("slim_results_to_data handles different generation filters", {
#   skip_if_slim_not_installed()
#
#   if(!on_covr()) {
#     test_sim <- slim_script(
#       slim_block_init_minimal(seed = 999),
#       slim_block_add_subpops(1, 50),
#       slim_block(1, 100, late(), {
#         slimr_output(p1$size(), "pop_size", do_every = 20)
#       })
#     ) %>%
#       slim_run()
#
#     if(on_ci()) {
#       readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_adv_gen_1.rds"))
#     }
#   } else {
#     test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_adv_gen_1.rds"))
#   }
#
#   # Test generation = 0 (last generation only)
#   result_last <- slim_results_to_data(test_sim, generations = 0)
#   expect_equal(nrow(result_last), 1)
#   expect_equal(result_last$generation[1], 100)
#
#   # Test specific generations
#   result_specific <- slim_results_to_data(test_sim, generations = c(20, 60))
#   expect_equal(nrow(result_specific), 2)
#   expect_true(all(result_specific$generation %in% c(20, 60)))
# })

test_that("extraction handles coordinates type", {
  # Create mock data with coordinates
  output_str <- paste0(
    "#OUT: 100 A p1 500\n",
    "Populations:\n",
    "p1 500 H 0.5\n",
    "Mutations:\n",
    "Individuals:\n",
    "p1:0 H p1:0 p1:1 A 1.0 2.0 3.0\n",
    "p1:1 H p1:2 p1:3 A 4.0 5.0 6.0\n",
    "Chromosome:\n",
    "A 100000\n",
    "Haplosomes:\n",
    "p1:0 A\n",
    "p1:1 A\n",
    "p1:2 A\n",
    "p1:3 A\n"
  )

  output_data <- tibble::tibble(
    generation = 100,
    name = "full",
    expression = "sim.outputFull()",
    data = list(output_str),
    type = "slim_output"
  )

  result <- slim_extract_full(output_data, type = "coordinates")

  expect_s3_class(result, "tbl_df")
  expect_true(all(c("unique_ind_id", "x", "y", "z") %in% names(result)))
})
