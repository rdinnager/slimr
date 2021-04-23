test_that("slim_extract_output_data works", {
  test_sim <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 100),
    slim_block(1, 100, late(), {
      slimr_output(p1$outputMSSample(10), "MS", do_every = 10)
    })
  ) %>%
    slim_run(simple_run = TRUE)

  dat <- slim_extract_output_data(test_sim$output)

  expect_s3_class(dat$data, "tbl_df")
  expect_length(dat$data, 5)
  expect_identical(nrow(dat$data), 10L)
  expect_identical(max(dat$data$generation), 100L)
})
