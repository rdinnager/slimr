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
