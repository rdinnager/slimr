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

  expect_warning(test_script <- slim_script(test_block_1, test_block_2),
                 "The arguments do not include an initialize block",
                 fixed = TRUE)
  expect_s3_class(test_script, "slimr_script")
  expect_length(test_script, 2L)

})

