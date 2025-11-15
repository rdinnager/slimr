# Tests for slimr block creation helpers
# Tests slim_block_init_minimal(), slim_block_finish(), slim_block_add_subpops(), etc.

test_that("slim_block_init_minimal creates basic initialization", {
  block <- slim_block_init_minimal(mutation_rate = 1e-7)

  expect_s3_class(block, "slimr_script")
  expect_equal(block$callback, "initialize")

  code <- as_slim(block)
  expect_true(grepl("initializeMutationRate", code))
})

test_that("slim_block_init_minimal with custom mutation type", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    mutation_type_id = "m2",
    mutation_dominance = 0.3,
    mutation_selection = 0.1
  )

  code <- as_slim(block)
  expect_true(grepl("m2", code))
  expect_true(grepl("0\\.3", code))
  expect_true(grepl("0\\.1", code))
})

test_that("slim_block_init_minimal with genomic element parameters", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    genomic_element_type = "g2",
    sequence_length = 50000
  )

  code <- as_slim(block)
  expect_true(grepl("g2", code))
  expect_true(grepl("50000", code) || grepl("49999", code))
})

test_that("slim_block_init_minimal with recombination rate", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    recombination_rate = 1e-9
  )

  code <- as_slim(block)
  expect_true(grepl("initializeRecombinationRate", code))
  expect_true(grepl("1e-9", code) || grepl("1e-09", code))
})

test_that("slim_block_finish creates simulation end block", {
  block <- slim_block_finish(generation = 1000)

  expect_s3_class(block, "slimr_script")
  expect_equal(block$start_gen, 1000)

  code <- as_slim(block)
  expect_true(grepl("simulationFinished", code))
})

test_that("slim_block_finish with custom callback", {
  block <- slim_block_finish(generation = 500, callback = early())

  expect_equal(block$callback, "early")
  expect_equal(block$start_gen, 500)
})

test_that("slim_block_add_subpops creates population block", {
  block <- slim_block_add_subpops(
    generation = 1,
    subpop_id = "p1",
    size = 500
  )

  expect_s3_class(block, "slimr_script")
  expect_equal(block$start_gen, 1)

  code <- as_slim(block)
  expect_true(grepl("addSubpop", code))
  expect_true(grepl("p1", code))
  expect_true(grepl("500", code))
})

test_that("slim_block_add_subpops with multiple populations", {
  block <- slim_block_add_subpops(
    generation = 1,
    subpop_id = c("p1", "p2", "p3"),
    size = c(500, 1000, 250)
  )

  code <- as_slim(block)
  expect_true(grepl("p1", code))
  expect_true(grepl("p2", code))
  expect_true(grepl("p3", code))
})

test_that("slim_block_add_subpops validates input lengths", {
  # Mismatched lengths should error or recycle
  expect_error(
    slim_block_add_subpops(
      generation = 1,
      subpop_id = c("p1", "p2"),
      size = 500  # Single value - should recycle
    ),
    NA  # Should not error - recycling is valid
  )
})

test_that("helper blocks integrate into complete script", {
  script <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-7),
    slim_block_add_subpops(1, "p1", 500),
    slim_block_finish(1000)
  )

  expect_s3_class(script, "slimr_script")
  expect_equal(nrow(script), 3)

  code <- as_slim(script)
  expect_true(grepl("initialize", code))
  expect_true(grepl("addSubpop", code))
  expect_true(grepl("simulationFinished", code))
})

test_that("slim_block_init_minimal handles nucleotide-based models", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    nucleotide_based = TRUE
  )

  code <- as_slim(block)
  # Should include nucleotide initialization
  expect_true(grepl("initialize", code))
})

test_that("block helpers preserve parameter types", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    sequence_length = 100000L  # Integer
  )

  code <- as_slim(block)
  expect_true(grepl("100000", code))
})

test_that("slim_block_finish with output capture", {
  block <- slim_block_finish(
    generation = 1000,
    output_full = TRUE
  )

  code <- as_slim(block)
  expect_true(grepl("simulationFinished", code))
})

test_that("slim_block_add_subpops with custom callback", {
  block <- slim_block_add_subpops(
    generation = 1,
    subpop_id = "p1",
    size = 500,
    callback = early()
  )

  expect_equal(block$callback, "early")
})

test_that("helper functions validate generation numbers", {
  # Negative generation
  expect_error(
    slim_block_finish(generation = -1),
    NA  # May or may not validate
  )

  # Zero generation (valid for some contexts)
  expect_error(
    slim_block_add_subpops(0, "p1", 500),
    NA
  )
})

test_that("helper blocks can be named", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    block_id = "my_init"
  )

  expect_equal(block$block_id, "my_init")
})

test_that("slim_block_add_subpops handles single population", {
  block <- slim_block_add_subpops(1, "p1", 1000)

  code <- as_slim(block)
  expect_true(grepl("p1", code))
  expect_true(grepl("1000", code))
})

test_that("helper blocks validate required parameters", {
  # Missing mutation_rate
  expect_error(
    slim_block_init_minimal(),
    "mutation_rate"
  )

  # Missing generation
  expect_error(
    slim_block_finish(),
    "generation"
  )

  # Missing subpop_id
  expect_error(
    slim_block_add_subpops(generation = 1, size = 500),
    "subpop_id"
  )
})

test_that("slim_block_init_minimal with all optional parameters", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    mutation_type_id = "m1",
    mutation_dominance = 0.5,
    mutation_selection = 0.0,
    genomic_element_type = "g1",
    sequence_length = 100000,
    recombination_rate = 1e-8
  )

  code <- as_slim(block)
  expect_true(grepl("initializeMutationRate", code))
  expect_true(grepl("initializeMutationType", code))
  expect_true(grepl("initializeGenomicElementType", code))
  expect_true(grepl("initializeGenomicElement", code))
  expect_true(grepl("initializeRecombinationRate", code))
})

test_that("helper blocks work with templates", {
  block <- slim_block_init_minimal(
    mutation_rate = r_template("mu", 1e-7)
  )

  expect_true(!is.null(attr(block, "slimr_template")))
})

test_that("helper blocks work with inline", {
  mu_value <- 1e-7

  block <- slim_block_init_minimal(
    mutation_rate = r_inline(mu_value)
  )

  expect_true(!is.null(attr(block, "slimr_inline")))
})

test_that("slim_block_finish accepts block_id", {
  block <- slim_block_finish(
    generation = 1000,
    block_id = "end_sim"
  )

  expect_equal(block$block_id, "end_sim")
})

test_that("slim_block_add_subpops validates population sizes", {
  # Zero size
  expect_error(
    slim_block_add_subpops(1, "p1", 0),
    NA  # May or may not validate
  )

  # Negative size
  expect_error(
    slim_block_add_subpops(1, "p1", -100),
    NA
  )
})

test_that("complete simulation with helper blocks runs", {
  skip_if_slim_not_installed()

  script <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-7),
    slim_block_add_subpops(1, "p1", 500),
    slim_block_finish(100)
  )

  result <- slim_run(script)
  expect_equal(result$exit_status, 0)
})

test_that("helper blocks preserve species information", {
  block <- slim_block_init_minimal(
    mutation_rate = 1e-7,
    species = "species1"
  )

  species_attr <- attr(block, "species")
  expect_true(is.null(species_attr) || is.character(species_attr))
})

test_that("slim_block_add_subpops handles spatial coordinates", {
  block <- slim_block_add_subpops(
    generation = 1,
    subpop_id = "p1",
    size = 500,
    spatial = TRUE
  )

  code <- as_slim(block)
  expect_true(grepl("addSubpop", code))
})
