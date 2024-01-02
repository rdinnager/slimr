test_that("slim_script and slim_block produce correct objects", {
  test_block_1 <- slim_block(1,
                             {
                               sim.addSubpop("p1", 500);
                             })

  test_block_2 <-  slim_block(10000,
                              {
                                sim.simulationFinished();
                              })

  expect_s3_class(test_block_1, "slimr_block")
  expect_s3_class(test_block_2, "slimr_block")

  test_script <- slim_script(test_block_1, test_block_2)

  # expect_warning(test_script <- slim_script(test_block_1, test_block_2),
  #                "The arguments do not include an initialize block",
  #                fixed = TRUE)
  expect_s3_class(test_script, "slimr_script")
  expect_length(test_script, 2L)

})

test_that("`<-` and `$` are handled directly in slim_block and slim_script", {

  test_script <- slim_script(
    slim_block_init_minimal(),
    slim_block(1, 100, {
      y <- sim$generation
      print(y)
    }),
    slim_block(100, {
      sim$simulationFinished()
    })
  )

  expect_false(any(stringr::str_detect(as.character(test_script),
                                       stringr::fixed("<-"))))

  expect_false(any(stringr::str_detect(as.character(test_script),
                                       stringr::fixed("$"))))

  skip_on_covr()

  expect_snapshot(print(test_script))

})
