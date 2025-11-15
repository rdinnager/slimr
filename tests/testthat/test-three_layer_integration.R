test_that("all three layers work together in a single script", {
  # Create script using all three layers
  migration_matrix <- matrix(c(0, 0.1, 0.1, 0), nrow = 2)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 100))
      sim.addSubpop("p2", r_template("pop_size", 100))
      rates <- r_inline(migration_matrix)
      p1.setMigrationRates(p2, rates[0, 1])
      p2.setMigrationRates(p1, rates[1, 0])
    }),
    slim_block(1, 100, late(), {
      r_output(sim.mutations.size(), "mut_count", do_every = 10)
    }),
    slim_block(100, {
      sim.simulationFinished()
    })
  )

  # Verify all three attributes exist
  expect_true(!is.null(attr(script, "slimr_inline")))
  expect_true(!is.null(attr(script, "slimr_template")))
  expect_true(!is.null(attr(script, "slimr_output")))

  # Verify inline attribute has data
  inline_attr <- attr(script, "slimr_inline")
  expect_true(any(!is.na(inline_attr$code_for_slim)))

  # Verify template attribute has data
  template_attr <- attr(script, "slimr_template")
  expect_true(any(!is.na(template_attr$var_names)))
  expect_true("mut_rate" %in% template_attr$var_names)
  expect_true("pop_size" %in% template_attr$var_names)

  # Verify output attribute has data
  output_attr <- attr(script, "slimr_output")
  expect_true(any(!is.na(output_attr$output_name)))
  expect_true("mut_count" %in% output_attr$output_name)
})

test_that("three layers render correctly together", {
  migration_matrix <- matrix(c(0, 0.1, 0.1, 0), nrow = 2)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 100))
      rates <- r_inline(migration_matrix)
      p1.setMigrationRates(p2, rates[0, 1])
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "mut_count", do_every = 10)
    })
  )

  # Render with template values
  rendered <- slim_script_render(script, template = list(mut_rate = 1e-6, pop_size = 200))

  # Verify attributes survive rendering
  expect_true(!is.null(attr(rendered, "slimr_inline")))
  expect_true(!is.null(attr(rendered, "slimr_template")))
  expect_true(!is.null(attr(rendered, "slimr_output")))

  # Verify template values were substituted
  slim_text <- as_slim_text(rendered)
  expect_true(grepl("1e-06", slim_text, fixed = TRUE))
  expect_true(grepl("200", slim_text, fixed = TRUE))

  # Verify inline matrix is present
  expect_true(grepl("matrix", slim_text, fixed = TRUE))

  # Verify output code is present
  expect_true(grepl("slimr_out:start", slim_text, fixed = TRUE))
})

test_that("processing order: inline -> template -> output", {
  # Test that inline processes first (during slim_script creation)
  # Template processes during render
  # Output generates code during script creation (never renders)

  vec <- c(1, 2, 3)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    }),
    slim_block(1, 10, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Inline should be processed (placeholder replaced with actual code)
  code_text <- as.character(code(script), as_list = TRUE)
  init_code <- paste(code_text[[1]], collapse = " ")

  # Should not have inline placeholder anymore
  expect_false(grepl(".__slmr_inline_object_", init_code, fixed = TRUE))

  # Template should still have placeholders
  expect_true(grepl("..mu..", init_code, fixed = TRUE))

  # Output should have placeholder
  code_text_block2 <- paste(code_text[[2]], collapse = " ")
  expect_true(grepl(".__slmr_output_object_", code_text_block2, fixed = TRUE))

  # After rendering, template placeholders should be gone
  rendered <- slim_script_render(script, template = list(mu = 1e-6))
  rendered_text <- as_slim_text(rendered)
  expect_false(grepl("..mu..", rendered_text, fixed = TRUE))
  expect_true(grepl("1e-06", rendered_text, fixed = TRUE))
})

test_that("delayed inline renders during slim_script_render", {
  # Create a script with delayed inline
  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      # Use delayed inline with r_template
      vals <- r_inline(c(r_template("val1", 100), r_template("val2", 200)), delay = TRUE)
    })
  )

  # Check that delayed inline creates expression
  code_text <- as.character(code(script), as_list = TRUE)
  init_code <- paste(code_text[[1]], collapse = " ")
  expect_true(grepl("r_inline", init_code, fixed = TRUE))

  # Render should process both template and delayed inline
  rendered <- slim_script_render(script, template = list(val1 = 50, val2 = 150))

  rendered_text <- as_slim_text(rendered)
  expect_true(grepl("50", rendered_text, fixed = TRUE))
  expect_true(grepl("150", rendered_text, fixed = TRUE))
})

test_that("placeholder collision avoidance between layers", {
  # Each layer uses different placeholder format
  # Inline: .__slmr_inline_object_N___
  # Template: ..var_name..
  # Output: .__slmr_output_object_N___

  vec <- c(1, 2, 3)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    }),
    slim_block(1, 100, late(), {
      r_output(sim.mutations.size(), "count", do_every = 10)
    })
  )

  # Get raw code to check placeholders
  inline_attr <- attr(script, "slimr_inline")
  template_attr <- attr(script, "slimr_template")
  output_attr <- attr(script, "slimr_output")

  # Verify different placeholder patterns
  code_text <- as.character(code(script), as_list = TRUE)
  all_code <- paste(unlist(code_text), collapse = " ")

  # Template placeholders should exist
  expect_true(grepl("\\.\\.", all_code))

  # Output placeholders should exist
  expect_true(any(grepl(".__slmr_output_object_", output_attr$code_for_slim, fixed = TRUE)))

  # No conflicts - each placeholder is unique
  expect_true(all(!grepl(".__slmr_inline_object_", template_attr$var_names, fixed = TRUE)))
  expect_true(all(!grepl("\\.\\.", inline_attr$code_for_slim, fixed = TRUE)))
})

test_that("attributes preserved through concatenation", {
  vec1 <- c(1, 2)
  vec2 <- c(3, 4)

  script1 <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec1)
    })
  )

  script2 <- slim_script(
    slim_block(1, {
      sim.addSubpop("p1", r_template("N", 100))
      vals2 <- r_inline(vec2)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Concatenate scripts
  combined <- c(script1, script2)

  # Verify all attributes are present
  expect_true(!is.null(attr(combined, "slimr_inline")))
  expect_true(!is.null(attr(combined, "slimr_template")))
  expect_true(!is.null(attr(combined, "slimr_output")))

  # Verify both templates are present
  template_attr <- attr(combined, "slimr_template")
  expect_true("mu" %in% template_attr$var_names)
  expect_true("N" %in% template_attr$var_names)

  # Verify both inlines are present
  inline_attr <- attr(combined, "slimr_inline")
  expect_equal(sum(!is.na(inline_attr$code_for_slim)), 2)

  # Verify output is present
  output_attr <- attr(combined, "slimr_output")
  expect_true("count" %in% output_attr$output_name)
})

test_that("resource cleanup between script calls", {
  # Resources should be cleared between different slim_script() calls

  vec1 <- c(1, 2, 3)
  script1 <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec1)
    })
  )

  # Check first script has inline
  inline_attr1 <- attr(script1, "slimr_inline")
  expect_equal(sum(!is.na(inline_attr1$code_for_slim)), 1)

  # Create second script without inline
  script2 <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    })
  )

  # Second script should not inherit inline from first
  inline_attr2 <- attr(script2, "slimr_inline")
  expect_equal(sum(!is.na(inline_attr2$code_for_slim)), 0)

  # But should have template
  template_attr2 <- attr(script2, "slimr_template")
  expect_true("mu" %in% template_attr2$var_names)
})

test_that("complex real-world scenario: migration + template + output", {
  skip_if_not(slim_is_avail())

  # Migration matrix (inline) + population sizes (template) + tracking (output)
  migration_matrix <- matrix(c(0, 0.01, 0.01, 0), nrow = 2)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop1_size", 100))
      sim.addSubpop("p2", r_template("pop2_size", 100))
      mig_rates <- r_inline(migration_matrix)
      p1.setMigrationRates(p2, mig_rates[0, 1])
      p2.setMigrationRates(p1, mig_rates[1, 0])
    }),
    slim_block(1, 100, late(), {
      r_output(p1.individualCount, "p1_count", do_every = 50)
      r_output(p2.individualCount, "p2_count", do_every = 50)
    }),
    slim_block(100, {
      sim.simulationFinished()
    })
  )

  # Render with different population sizes
  rendered <- slim_script_render(script,
                                  template = list(pop1_size = 200, pop2_size = 150))

  # Run the simulation
  result <- slim_run(rendered, throw_error = TRUE)

  # Verify execution succeeded
  expect_equal(result$exit_status, 0L)

  # Verify output was captured
  expect_true(!is.null(result$output_data))
  expect_true("p1_count" %in% result$output_data$name)
  expect_true("p2_count" %in% result$output_data$name)
})

test_that("parameter sweep with inline objects varying by template", {
  # Use inline with template to create parameter sweep where inline values change

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("N", 100))
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "mut_count", do_every = 25)
    })
  )

  # Render with multiple parameter sets
  params <- data.frame(
    mu = c(1e-7, 1e-6),
    N = c(100, 200)
  )

  rendered <- slim_script_render(script, template = params)

  # Should return a collection
  expect_s3_class(rendered, "slimr_script_coll")
  expect_length(rendered, 2)

  # Each script should have different values
  text1 <- as_slim_text(rendered[[1]])
  text2 <- as_slim_text(rendered[[2]])

  expect_true(grepl("1e-07", text1, fixed = TRUE))
  expect_true(grepl("100", text1, fixed = TRUE))

  expect_true(grepl("1e-06", text2, fixed = TRUE))
  expect_true(grepl("200", text2, fixed = TRUE))

  # All should have output code
  expect_true(grepl("slimr_out:start", text1, fixed = TRUE))
  expect_true(grepl("slimr_out:start", text2, fixed = TRUE))
})

test_that("multiple outputs with inline and template", {
  vec <- c(10, 20, 30)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    }),
    slim_block(1, {
      sim.addSubpop("p1", 100)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "mut_count", do_every = 10)
      r_output(p1.individualCount, "ind_count", do_every = 10)
      r_output(sim.mutationFrequencies(NULL), "freqs", do_every = 25)
    })
  )

  # Verify multiple outputs in attribute
  output_attr <- attr(script, "slimr_output")
  expect_true("mut_count" %in% output_attr$output_name)
  expect_true("ind_count" %in% output_attr$output_name)
  expect_true("freqs" %in% output_attr$output_name)

  # Render and check all outputs are in code
  rendered <- slim_script_render(script, template = list(mu = 1e-6))
  rendered_text <- as_slim_text(rendered)

  expect_true(grepl("mut_count", rendered_text, fixed = TRUE))
  expect_true(grepl("ind_count", rendered_text, fixed = TRUE))
  expect_true(grepl("freqs", rendered_text, fixed = TRUE))
})

test_that("template info extraction works with all layers", {
  vec <- c(1, 2)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(r_template("recomb", 1e-8))
      vals <- r_inline(vec)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Get template info
  template_info <- slim_template_info(script)

  # Should have template variables
  expect_true(!is.null(template_info))
  init_block_info <- template_info[[1]]

  expect_true("mu" %in% names(init_block_info))
  expect_true("recomb" %in% names(init_block_info))
  expect_equal(init_block_info$mu, 1e-7)
  expect_equal(init_block_info$recomb, 1e-8)
})

test_that("error in template layer doesn't corrupt inline or output", {
  vec <- c(1, 2, 3)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Try to render with missing required template variable (no default)
  script_no_default <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu"))  # No default
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    })
  )

  # Should error when trying to render without providing mu
  expect_error(
    slim_script_render(script_no_default, template = list()),
    "not been fully specified"
  )

  # But inline and output attributes should still be intact
  inline_attr <- attr(script_no_default, "slimr_inline")
  output_attr <- attr(script_no_default, "slimr_output")

  expect_true(any(!is.na(inline_attr$code_for_slim)))
  expect_false(any(!is.na(output_attr$output_name)))  # No output in this script
})

test_that("inline with output in same block", {
  vec <- c(1, 2, 3)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      sim.addSubpop("p1", 100)
      vals <- r_inline(vec)
    }),
    slim_block(1, 50, late(), {
      vals2 <- r_inline(c(4, 5, 6))
      r_output(sim.mutations.size(), "count", do_every = 10)
    })
  )

  # Both blocks should have inline
  inline_attr <- attr(script, "slimr_inline")
  expect_equal(sum(!is.na(inline_attr$code_for_slim)), 2)

  # One block should have output
  output_attr <- attr(script, "slimr_output")
  expect_equal(sum(!is.na(output_attr$output_name)), 1)
})

test_that("all layers work with default template values", {
  vec <- c(1, 2)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Render without providing template (should use defaults)
  rendered <- slim_script_render(script)

  # Should use default value
  rendered_text <- as_slim_text(rendered)
  expect_true(grepl("1e-07", rendered_text, fixed = TRUE))

  # Inline should be present
  expect_true(grepl("c(1, 2)", rendered_text, fixed = TRUE))

  # Output should be present
  expect_true(grepl("slimr_out:start", rendered_text, fixed = TRUE))
})

test_that("output with inline data capture", {
  skip_if_not(slim_is_avail())

  # Use inline to provide sample sizes for output
  sample_sizes <- c(5, 5)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      sizes <- r_inline(sample_sizes)
    }),
    slim_block(1, {
      sim.addSubpop("p1", 100)
      sim.addSubpop("p2", 100)
    }),
    slim_block(50, late(), {
      r_output(p1.individualCount, "p1_count")
      r_output(p2.individualCount, "p2_count")
    }),
    slim_block(50, {
      sim.simulationFinished()
    })
  )

  result <- slim_run(script, throw_error = TRUE)

  expect_equal(result$exit_status, 0L)
  expect_true(!is.null(result$output_data))
  expect_true("p1_count" %in% result$output_data$name)
  expect_true("p2_count" %in% result$output_data$name)
})

test_that("script with only inline (no template or output)", {
  vec <- c(1, 2, 3)

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
      vals <- r_inline(vec)
    })
  )

  # Should have inline
  inline_attr <- attr(script, "slimr_inline")
  expect_true(any(!is.na(inline_attr$code_for_slim)))

  # Should have empty/NA template and output
  template_attr <- attr(script, "slimr_template")
  expect_true(all(is.na(template_attr$var_names)))

  output_attr <- attr(script, "slimr_output")
  expect_true(all(is.na(output_attr$output_name)))
})

test_that("script with only template (no inline or output)", {
  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    })
  )

  # Should have template
  template_attr <- attr(script, "slimr_template")
  expect_true(any(!is.na(template_attr$var_names)))

  # Should have empty/NA inline and output
  inline_attr <- attr(script, "slimr_inline")
  expect_true(all(is.na(inline_attr$code_for_slim)))

  output_attr <- attr(script, "slimr_output")
  expect_true(all(is.na(output_attr$output_name)))
})

test_that("script with only output (no inline or template)", {
  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, 50, late(), {
      r_output(sim.mutations.size(), "count")
    })
  )

  # Should have output
  output_attr <- attr(script, "slimr_output")
  expect_true(any(!is.na(output_attr$output_name)))

  # Should have empty/NA inline and template
  inline_attr <- attr(script, "slimr_inline")
  expect_true(all(is.na(inline_attr$code_for_slim)))

  template_attr <- attr(script, "slimr_template")
  expect_true(all(is.na(template_attr$var_names)))
})

test_that("complex nesting: template containing inline containing output", {
  # This tests a complex interaction where template values affect inline objects
  # which are then used in output

  script <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mu", 1e-7))
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)
    }),
    slim_block(1, {
      N <- r_template("N", 100)
      sizes <- r_inline(c(r_template("N", 100), r_template("N", 100) * 2), delay = TRUE)
      sim.addSubpop("p1", N)
    }),
    slim_block(1, 50, late(), {
      r_output(p1.individualCount, "count", do_every = 25)
    })
  )

  # Render with specific N
  rendered <- slim_script_render(script, template = list(mu = 1e-6, N = 200))

  rendered_text <- as_slim_text(rendered)

  # Check template was substituted
  expect_true(grepl("1e-06", rendered_text, fixed = TRUE))
  expect_true(grepl("200", rendered_text, fixed = TRUE))

  # Check output is present
  expect_true(grepl("slimr_out:start", rendered_text, fixed = TRUE))
})
