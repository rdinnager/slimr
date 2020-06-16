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
  verify_output(test_path("slimr_template_output_test_unrendered.txt"),
                script_temp)

  info <- slimr_template_info(script_temp)

  expect_equal(info$block_init$mut_rate, 1e-07)
  expect_equal(info$block_init$genome_size, 99999)

  expect_warning(script_partial <- slimr_script_render(script_temp,
                                        template = list(
                                          list(mut_rate = 1e-5),
                                          list(genome_size = 2999)
                                        )),
                 "A templated variable was not specified in the template and has been replaced by its default value",
                 fixed = TRUE)

  expect_s3_class(script_partial, "slimr_script_coll")

  verify_output(test_path("slimr_template_output_test_list_w_missing.txt"),
                script_partial)

  skip_if_not_installed("crayon")

  verify_output(test_path("slimr_template_output_test_unrendered_ansi.txt"),
                script_temp,
                crayon = TRUE)

  verify_output(test_path("slimr_template_output_test_list_w_missing_ansi.txt"),
                script_partial,
                crayon = TRUE)

})
