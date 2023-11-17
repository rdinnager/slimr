set.seed(123)

test_that("slim_extract_output_data works", {

  no_dat <- slim_extract_output_data(c("<slimr_out:start>",
                                       "1, '', '', '', ''",
                                       "<slimr_out:end>"))
  expect_length(no_dat, 4)
  expect_length(no_dat$data, 5)
  expect_identical(nrow(no_dat$data), 1L)
  expect_identical(no_dat$last_line, 3L)

  skip_on_os("windows")

  if(!on_covr()) {

    set.seed(39299)

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

  #expect_snapshot(print(dat))

  dat_nuc <- suppressWarnings(slim_results_to_data(test_sim_nuc))
  expect_s3_class(dat_nuc, "tbl_df")
  expect_identical(nrow(dat_nuc), 4L)
  expect_type(dat_nuc$data, "list")
  expect_type(dat_nuc$subpops, "list")
  expect_s4_class(dat_nuc$data[[1]], "DNAStringSet")

  #expect_snapshot(print(dat_nuc))

})

test_that("slim_extract_genome works as expected", {

  if(!on_covr()) {

    test_sim <- slim_script(
      slim_block_init_minimal(seed = 123),
      slim_block_add_subpops(1, 100),
      slim_block(1, 100, late(), {
        gens = sample(sim%.%SLiMSim$subpopulations%.%Subpopulation$individuals, 10)%.%Individual$genomes
        slimr_output(gens%.%Genome$output(), "genomes", do_every = 20)
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_test_3.rds"))
    }

  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_test_3.rds"))
  }

  dat <- slim_extract_genome(test_sim$output_data, "mutations")
  dat2 <- slim_extract_genome(test_sim$output_data, "genomes")

  dat3 <- slim_extract_genome(test_sim$output_data, "full", expand_mutations = TRUE)

  expect_s3_class(dat, "slimr_genome_output_joined")
  expect_s3_class(dat2, "slimr_genome_output_joined")
  expect_s3_class(dat3, "slimr_genome_output_joined")
  expect_s3_class(dat, "tbl_df")
  expect_s3_class(dat2, "tbl_df")
  expect_s3_class(dat3, "tbl_df")

  expect_identical(nrow(dat), 30L)
  #expect_identical(nrow(dat2), 100L)
  #expect_identical(nrow(dat3), 105L)

  expect_type(dat2$mut_list, "list")

  #expect_snapshot(print(dat))
  #expect_snapshot(print(dat2))
  #expect_snapshot(print(dat3))

})

test_that("slim_extract_genlight works as expected", {

  if(!on_covr()) {

    test_sim <- slim_script(
      slim_block_init_minimal(seed = 123,
                              mutation_rate = 1e-6),
      slim_block_add_subpops(1, 100),
      slim_block(1, 100, late(), {
        slimr_output(sim$outputFull(), "output", do_every = 20)
      })
    ) %>%
      slim_run()

    if(on_ci()) {
      readr::write_rds(test_sim, file.path(covr_test_folder, "slim_extract_test_4.rds"))
    }

  } else {
    test_sim <- readr::read_rds(file.path(covr_test_folder, "slim_extract_test_4.rds"))

  }

  skip_if_not_installed("adegenet")

  gl <- slim_extract_genlight(test_sim, "output")

  expect_s4_class(gl, "genlight")
  expect_identical(dim(gl), c(500L, 497L))

  #expect_snapshot(print(gl))

  # skip_on_os(c("mac", "linux"))
  # png_file <- file.path(tempdir(), "gl_test.png")
  # withr::with_png(png_file, width = 800, height = 600,
  #                 adegenet::plot(gl)
  # )
  # expect_snapshot_file(png_file)

})
