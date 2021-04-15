test_that("slim_run can run a SLiM script", {

  test_script <- as_slimr_script(slim_get_recipe(1))
  test_script <- slim_script_duration(test_script, 500)
  res <- slim_run(test_script, throw_error = TRUE)

  expect_s3_class(res, "slimr_results")
  expect_identical(res$exit_status, 0L)
  expect_length(res$error, 0L)
  expect_length(res$output, 0L)

})

test_that("slim_run works with output", {

  expect_snapshot({
    slim_script(
      slim_block(initialize(), {
        setSeed(12345)
        initializeMutationRate(1e-7);
        initializeMutationType("m1", 0.5, "f", 0.0);
        initializeGenomicElementType("g1", m1, 1.0);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-8);
      }),
      slim_block(1, {
        sim.addSubpop("p1", 100);
      }),
      slim_block(1, 100, {
        slimr_output(p1.outputMSSample(sampleSize = 10), name = "VCF", do_every = 10);
      }),
      slim_block(100, {
        sim.simulationFinished();
      })
    ) %>%
      slim_run() -> run_w_out
    cat(run_w_out$output_data$data)
  })

  expect_type(run_w_out$output_data$data, "character")
  expect_identical(run_w_out$exit_status, 0L)

})

test_that("slim_run works on slimr_script_coll objects", {
  slim_script(
    slim_block(initialize(), {
      setSeed(12345)
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 100);
    }),
    slim_block(100, {
      sim.simulationFinished();
    })
  ) %>%
    slimr_script_render(reps = 3) %>%
    slim_run() -> run_3_times

  expect_length(run_3_times, 3L)
  expect_s3_class(run_3_times, "slimr_results_coll")

})

test_that("slim_run works in parallel", {

  skip_on_cran()

  future::plan(future::multisession())

  slim_script(
      slim_block(initialize(), {
        setSeed(12345)
        initializeMutationRate(1e-7);
        initializeMutationType("m1", 0.5, "f", 0.0);
        initializeGenomicElementType("g1", m1, 1.0);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-8);
      }),
      slim_block(1, {
        sim.addSubpop("p1", 100);
      }),
      slim_block(100, {
        sim.simulationFinished();
      })
    ) %>%
      slimr_script_render(reps = 3) %>%
      slim_run(parallel = TRUE) -> run_3_times

  expect_length(run_3_times, 3L)
  expect_s3_class(run_3_times, "slimr_results_coll")

})
