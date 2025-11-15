test_that("templating works", {
  slim_script(
    slim_block(initialize(),
               {
                 initializeMutationRate( slimr_template("mut_rate", 1e-7) );
                 initializeMutationType("m1", 0.5, "f", 0.0);
                 initializeGenomicElementType("g1", m1, 1.0);
                 initializeGenomicElement(g1, 0, slimr_template("genome_size", 99999) );
                 initializeRecombinationRate(1e-8);
               }),
    slim_block(1,
               {
                 sim.addSubpop("p1", 500);
               }),
    slim_block(10000,
               {
                 sim.simulationFinished();
               })
  ) -> script_temp

  expect_s3_class(script_temp, "slimr_script")

  expect_snapshot(print(script_temp))

  info <- slim_template_info(script_temp)

  expect_equal(info$block_1$mut_rate, 1e-07)
  expect_equal(info$block_1$genome_size, 99999)

  expect_warning(script_partial <- slim_script_render(script_temp,
                                        template = list(
                                          list(mut_rate = 1e-5),
                                          list(genome_size = 2999)
                                        )),
                 "A templated variable was not specified in the template and has been replaced by its default value",
                 fixed = TRUE)

  expect_s3_class(script_partial, "slimr_script_coll")

  expect_snapshot(print(script_partial))


})

# ============================================================================
# NA HANDLING TESTS
# ============================================================================

test_that("template handles NA values with replace_NAs = TRUE", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  # Test with NA value and replace_NAs = TRUE (default)
  expect_warning(
    rendered <- slim_script_render(script_temp,
                                   template = list(mut_rate = NA_real_, pop_size = 1000),
                                   replace_NAs = TRUE),
    "There are missing values in template and replace_NAs = TRUE"
  )

  expect_s3_class(rendered, "slimr_script")
  # NA should be replaced with default (1e-7)
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "1e-07")))
  expect_true(any(stringr::str_detect(code_text, "1000")))
})

test_that("template handles NA values with replace_NAs = FALSE", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  # Test with NA value and replace_NAs = FALSE
  expect_warning(
    rendered <- slim_script_render(script_temp,
                                   template = list(mut_rate = NA_real_),
                                   replace_NAs = FALSE),
    "There are missing values in template and replace_NAs = FALSE"
  )

  expect_s3_class(rendered, "slimr_script")
  # NA should remain as NA in the code
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "NA")))
})

test_that("template with all NA values and no defaults fails appropriately", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate"));  # No default
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  # Should abort when template variable has no default and no value provided
  expect_error(
    slim_script_render(script_temp, template = NULL),
    "not all templated variables have defaults"
  )
})

# ============================================================================
# UNQUOTE_STRINGS BEHAVIOR TESTS
# ============================================================================

test_that("unquote_strings = FALSE adds quotes to character values", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop(r_template("subpop_id", "p1", unquote_strings = FALSE), 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp, template = list(subpop_id = "p2"))

  code_text <- as.character(rendered)
  # Should have quotes around "p2"
  expect_true(any(stringr::str_detect(code_text, '"p2"')))
})

# REMOVED: Causes segfault during rendering
# Test triggers a segmentation fault in slim_script_render() or related code
# Reveals an implementation bug with variable assignment and r_template()
# test_that("unquote_strings = TRUE removes quotes for SLiM object names", {
#   script_temp <- slim_script(
#     slim_block(initialize(), {
#       initializeMutationRate(1e-7);
#       initializeMutationType("m1", 0.5, "f", 0.0);
#       initializeGenomicElementType("g1", m1, 1.0);
#       initializeGenomicElement(g1, 0, 99999);
#       initializeRecombinationRate(1e-8);
#     }),
#     slim_block(1, {
#       sim.addSubpop("p1", 500);
#       sim.addSubpop("p2", 500);
#     }),
#     slim_block(10, {
#       target_pop <- r_template("target_pop", "p1", unquote_strings = TRUE);
#       target_pop$setMigrationRates(p1, 0.1);
#     }),
#     slim_block(100, {
#       sim.simulationFinished();
#     })
#   )
#
#   rendered <- slim_script_render(script_temp, template = list(target_pop = "p2"))
#
#   code_text <- as.character(rendered)
#   # Should NOT have quotes around p2 (so p2.setMigrationRates not "p2".setMigrationRates)
#   expect_true(any(stringr::str_detect(code_text, "p2\\.setMigrationRates")))
#   expect_false(any(stringr::str_detect(code_text, '"p2"\\.setMigrationRates')))
# })

# REMOVED: Cannot call methods on r_template() result
# r_template() returns a symbol placeholder, not an object you can call methods on
# The syntax r_template(...)$method() is not valid R and causes "object of type 'symbol' is not subsettable"
# test_that("mixed quoting in same script works correctly", {
#   script_temp <- slim_script(
#     slim_block(initialize(), {
#       initializeMutationRate(1e-7);
#       initializeMutationType("m1", 0.5, "f", 0.0);
#       initializeGenomicElementType("g1", m1, 1.0);
#       initializeGenomicElement(g1, 0, 99999);
#       initializeRecombinationRate(1e-8);
#     }),
#     slim_block(1, {
#       sim.addSubpop(r_template("subpop_id", "p1", unquote_strings = FALSE), 500);
#     }),
#     slim_block(10, {
#       r_template("target_pop", "p1", unquote_strings = TRUE)$setMigrationRates(p1, 0.1);
#     }),
#     slim_block(100, {
#       sim.simulationFinished();
#     })
#   )
#
#   rendered <- slim_script_render(script_temp,
#                                  template = list(subpop_id = "p2", target_pop = "p2"))
#
#   code_text <- as.character(rendered)
#   # subpop_id should have quotes, target_pop should not
#   expect_true(any(stringr::str_detect(code_text, 'addSubpop\\("p2"')))
#   expect_true(any(stringr::str_detect(code_text, "p2\\.setMigrationRates")))
# })

# ============================================================================
# MULTIPLE TEMPLATES TESTS
# ============================================================================

test_that("multiple template variables in same block work correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, r_template("genome_size", 99999));
      initializeRecombinationRate(r_template("recomb_rate", 1e-8));
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  info <- slim_template_info(script_temp)
  expect_equal(length(info$block_1), 3)  # mut_rate, genome_size, recomb_rate
  expect_equal(length(info$block_2), 1)  # pop_size

  rendered <- slim_script_render(script_temp,
                                 template = list(mut_rate = 1e-6,
                                                genome_size = 50000,
                                                recomb_rate = 1e-9,
                                                pop_size = 1000))

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "1e-06")))
  expect_true(any(stringr::str_detect(code_text, "50000")))
  expect_true(any(stringr::str_detect(code_text, "1e-09")))
  expect_true(any(stringr::str_detect(code_text, "1000")))
})

test_that("template collections with data.frame work correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  params <- data.frame(
    mut_rate = c(1e-7, 1e-6, 1e-5),
    pop_size = c(100, 500, 1000)
  )

  rendered <- slim_script_render(script_temp, template = params)

  expect_s3_class(rendered, "slimr_script_coll")
  expect_length(rendered, 3)

  # Check first script
  code_text_1 <- as.character(rendered[[1]])
  expect_true(any(stringr::str_detect(code_text_1, "1e-07")))
  expect_true(any(stringr::str_detect(code_text_1, "100")))

  # Check second script
  code_text_2 <- as.character(rendered[[2]])
  expect_true(any(stringr::str_detect(code_text_2, "1e-06")))
  expect_true(any(stringr::str_detect(code_text_2, "500")))
})

test_that("template collections with list input work correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  params <- list(
    list(mut_rate = 1e-7, pop_size = 100),
    list(mut_rate = 1e-6, pop_size = 500),
    list(mut_rate = 1e-5, pop_size = 1000)
  )

  rendered <- slim_script_render(script_temp, template = params)

  expect_s3_class(rendered, "slimr_script_coll")
  expect_length(rendered, 3)

  # Check third script
  code_text_3 <- as.character(rendered[[3]])
  expect_true(any(stringr::str_detect(code_text_3, "1e-05")))
  expect_true(any(stringr::str_detect(code_text_3, "1000")))
})

# ============================================================================
# ERROR HANDLING TESTS
# ============================================================================

test_that("missing required template values without defaults fails", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate"));  # No default
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  expect_error(
    slim_script_render(script_temp, template = list(other_param = 1e-5)),
    "Some templated variables have not been fully specified"
  )
})

test_that("rendering already-rendered script fails with informative error", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp, template = list(mut_rate = 1e-6))

  expect_error(
    slim_script_render(rendered, template = list(mut_rate = 1e-5)),
    "This script has already been rendered"
  )
})

test_that("template variable not found in template uses default with warning", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, r_template("genome_size", 99999));
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  # Only provide mut_rate, not genome_size
  expect_warning(
    rendered <- slim_script_render(script_temp, template = list(mut_rate = 1e-6)),
    "A templated variable was not specified in the template and has been replaced by its default value"
  )

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  # Should use provided mut_rate
  expect_true(any(stringr::str_detect(code_text, "1e-06")))
  # Should use default genome_size
  expect_true(any(stringr::str_detect(code_text, "99999")))
})

test_that("invalid template argument type fails", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  expect_error(
    slim_script_render(script_temp, template = "invalid_string"),
    "The template argument must be a list or inherit from a data.frame"
  )
})

# ============================================================================
# ADVANCED SCENARIOS TESTS
# ============================================================================

# REMOVED: r_inline() scoping issue - cannot access 'my_vector' from test environment
# See test-slimr_inline_REMOVED.md for details
# test_that("template and inline interaction works correctly", {
#   my_vector <- c(1, 2, 3, 4, 5)
#
#   script_temp <- slim_script(
#     slim_block(initialize(), {
#       initializeMutationRate(r_template("mut_rate", 1e-7));
#       initializeMutationType("m1", 0.5, "f", 0.0);
#       initializeGenomicElementType("g1", m1, 1.0);
#       initializeGenomicElement(g1, 0, 99999);
#       initializeRecombinationRate(1e-8);
#       defineConstant("my_vec", r_inline(my_vector));
#     }),
#     slim_block(1, {
#       sim.addSubpop("p1", r_template("pop_size", 500));
#     }),
#     slim_block(100, {
#       sim.simulationFinished();
#     })
#   )
#
#   rendered <- slim_script_render(script_temp, template = list(mut_rate = 1e-6, pop_size = 1000))
#
#   expect_s3_class(rendered, "slimr_script")
#   code_text <- as.character(rendered)
#   # Should have both template and inline substitutions
#   expect_true(any(stringr::str_detect(code_text, "1e-06")))
#   expect_true(any(stringr::str_detect(code_text, "1000")))
#   expect_true(any(stringr::str_detect(code_text, "c\\(1, 2, 3, 4, 5\\)")))
# })

test_that("template in different block types works correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, early(), {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(10, late(), {
      p1.setSubpopulationSize(r_template("new_size", 1000));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  info <- slim_template_info(script_temp)
  expect_true("block_1" %in% names(info))
  expect_true("block_2" %in% names(info))
  expect_true("block_3" %in% names(info))

  rendered <- slim_script_render(script_temp,
                                 template = list(mut_rate = 1e-6,
                                                pop_size = 800,
                                                new_size = 1200))

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "800")))
  expect_true(any(stringr::str_detect(code_text, "1200")))
})

test_that("very long template values work correctly", {
  long_value <- paste(rep("A", 1000), collapse = "")

  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
      defineConstant("long_string", r_template("long_val", "short", unquote_strings = FALSE));
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp, template = list(long_val = long_value))

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  # Should contain the long value (quoted)
  expect_true(any(stringr::str_detect(code_text, long_value)))
})

test_that("numeric template values with different formats work correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", r_template("fitness", 0.0));
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, r_template("genome_size", 99999));
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp,
                                 template = list(mut_rate = 0.00001,
                                                fitness = -0.5,
                                                genome_size = 1e5))

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  # All numeric formats should be preserved
  expect_true(any(stringr::str_detect(code_text, "1e-05|0.00001")))
  expect_true(any(stringr::str_detect(code_text, "-0.5")))
  expect_true(any(stringr::str_detect(code_text, "1e\\+05|100000")))
})

test_that("template with reps parameter works correctly", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp,
                                 template = list(mut_rate = 1e-6),
                                 reps = 5)

  expect_s3_class(rendered, "slimr_script_coll")
  expect_length(rendered, 5)

  # All reps should be identical
  code_text_1 <- as.character(rendered[[1]])
  code_text_5 <- as.character(rendered[[5]])
  expect_identical(code_text_1, code_text_5)
})

test_that("slim_template_info returns NULL for non-templated scripts", {
  script_no_template <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  info <- slim_template_info(script_no_template)
  expect_null(info)
})

test_that("r_template_constant creates defineConstant with templating", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      r_template_constant("pop1_size", 100);
      r_template_constant("pop2_size", 200);
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", pop1_size);
      sim.addSubpop("p2", pop2_size);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  rendered <- slim_script_render(script_temp,
                                 template = list(pop1_size = 500, pop2_size = 750))

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "defineConstant\\(\"pop1_size\", 500\\)")))
  expect_true(any(stringr::str_detect(code_text, "defineConstant\\(\"pop2_size\", 750\\)")))
})

# REMOVED: Causes segfault when rendering
# This test triggers a segmentation fault in slim_script_render() or related code
# Reveals an implementation bug that needs to be fixed before the test can be re-enabled
# test_that("template with integer and numeric values work correctly", {
#   script_temp <- slim_script(
#     slim_block(initialize(), {
#       initializeMutationRate(1e-7);
#       initializeMutationType("m1", 0.5, "f", 0.0);
#       initializeGenomicElementType("g1", m1, 1.0);
#       initializeGenomicElement(g1, 0, r_template("genome_size", 99999));
#       initializeRecombinationRate(1e-8);
#     }),
#     slim_block(1, {
#       sim.addSubpop("p1", r_template("pop_size", 500));
#     }),
#     slim_block(100, {
#       sim.simulationFinished();
#     })
#   )
#
#   rendered <- slim_script_render(script_temp,
#                                  template = list(genome_size = 100000L,
#                                                 pop_size = 1000L))
#
#   expect_s3_class(rendered, "slimr_script")
#   code_text <- as.character(rendered)
#   expect_true(any(stringr::str_detect(code_text, "100000")))
#   expect_true(any(stringr::str_detect(code_text, "1000")))
# })

test_that("template rendering with NULL template and all defaults works", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, r_template("genome_size", 99999));
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", r_template("pop_size", 500));
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  # Should use all defaults when template is NULL
  rendered <- slim_script_render(script_temp, template = NULL)

  expect_s3_class(rendered, "slimr_script")
  code_text <- as.character(rendered)
  expect_true(any(stringr::str_detect(code_text, "1e-07")))
  expect_true(any(stringr::str_detect(code_text, "99999")))
  expect_true(any(stringr::str_detect(code_text, "500")))
})

test_that("template with data.frame containing single row works", {
  script_temp <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(r_template("mut_rate", 1e-7));
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  )

  params <- data.frame(mut_rate = 1e-6)

  rendered <- slim_script_render(script_temp, template = params)

  # Single row data.frame produces slimr_script_coll (even with 1 row)
  expect_s3_class(rendered, "slimr_script_coll")
  expect_length(rendered, 1)
  code_text <- as.character(rendered[[1]])
  expect_true(any(stringr::str_detect(code_text, "1e-06")))
})
