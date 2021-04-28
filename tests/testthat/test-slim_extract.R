test_that("slim_extract_output_data works", {

  no_dat <- slim_extract_output_data(c("<slimr_out:start>",
                                       "1, '', '', '', ''",
                                       "<slimr_out:end>"))
  expect_length(no_dat, 4)
  expect_length(no_dat$data, 5)
  expect_identical(nrow(no_dat$data), 1L)
  expect_identical(no_dat$last_line, 3L)

  if(!on_covr()) {

    test_sim <- slim_script(
      slim_block_init_minimal(),
      slim_block_add_subpops(1, 100),
      slim_block(1, 100, late(), {
        slimr_output(p1$outputMSSample(10), "MS", do_every = 10)
      })
    ) %>%
      slim_run(simple_run = TRUE)

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_test_1.rds"))
    }

  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_test_1.rds"))
  }

  dat <- slim_extract_output_data(test_sim$output)

  expect_s3_class(dat$data, "tbl_df")
  expect_length(dat$data, 5)
  expect_identical(nrow(dat$data), 10L)
  expect_identical(max(dat$data$generation), 100L)
})

test_that("slim_results_to_data works as expected", {

  if(!on_covr()) {

    test_sim <- slim_script(
      slim_block_init_minimal(seed = 123),
      slim_block_add_subpops(1, 100),
      slim_block(1, 100, late(), {
        slimr_output(sim$outputFull(), "output", do_every = 20)
      })
    ) %>%
      slim_run()

    test_sim_nuc <- slim_script(
      slim_block(initialize(), {
        setSeed(123);
        initializeSLiMOptions(nucleotideBased=T);
        initializeAncestralNucleotides(randomNucleotides(1000));
        initializeMutationTypeNuc("m1", 0.5, "f", 0.0);
        initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(1e-5));
        initializeGenomicElement(g1, 0, 1000 - 1);
        initializeRecombinationRate(1e-8);
      }),
      slim_block(1, {
        for(i in 1:10) {
          sim.addSubpop(i, 100)
        }

      }),
      slim_block(1, 1000, late(), {
        slimr_output_nucleotides(subpops = TRUE, do_every = 250)
      }),
      slim_block(1000, late(), {
        sim.simulationFinished()
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_test_2.rds"))
      readr::write_rds(test_sim_nuc, file.path(covr_test_folder, "slim_extract_test_nuc_2.rds"))
    }

  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_test_2.rds"))
    test_sim_nuc <- readr::read_rds(file.path(covr_test_folder, "slim_extract_test_nuc_2.rds"))
  }

  dat <- suppressWarnings(slim_results_to_data(test_sim))
  expect_s3_class(dat, "tbl_df")
  expect_identical(nrow(dat), 5L)
  expect_type(dat$data, "list")

  expect_snapshot(print(dat))

  dat_nuc <- suppressWarnings(slim_results_to_data(test_sim_nuc))
  expect_s3_class(dat_nuc, "tbl_df")
  expect_identical(nrow(dat_nuc), 4L)
  expect_type(dat_nuc$data, "list")
  expect_type(dat_nuc$subpops, "list")
  expect_s4_class(dat_nuc$data[[1]], "DNAStringSet")

  expect_snapshot(print(dat_nuc))

})
