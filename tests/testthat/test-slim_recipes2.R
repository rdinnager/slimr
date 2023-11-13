test_that("All slim recipes work", {
  slim_scripts <- list()
  slim_recipes <- slim_get_recipes()

  skip_on_ci()
  skip_on_cran()
  skip_on_covr()

  skip_if_not(identical(Sys.getenv("test_recipes"), "true"))

  for(i in seq_along(slim_recipes)) {
    slim_scripts[[i]] <- as_slimr_script(slim_recipes[[i]])
  }
  # slim_scripts <- purrr::map(slim_scripts,
  #                            ~slim_script_remove_output(.x))

  ## document reasons for skipping
  ## 56: contains a call to stop() in the SLiM code, which throws an error when it gets calls, which is expected behaviour
  ## 97: uses a symbolic constant mu which is supposed to be passed in at the command line with SLiM executable
  ## 99: SLiM script calls Rscript.exe to run some custom R code on SLiM output
  ## 155: The SLiM Manual says this recipe takes 'several hours' to run, so let's not test it
  ## 159: Requires a pregenerated tree sequence file (generated in Python)
  ## 160: Same deal as 159
  ## 170: Just appears to be a very slow simulation (but seems to run)
  ## 172: Also very slow (but also seems to run)
  ## 173: Requires downloading and opening external files (fasta and vcf)
  ## 183: Quite slow but I confirmed it runs and produces output

  test_scripts <- list()
  for(i in seq_along(slim_scripts)[183:length(slim_scripts)]) {
    print(i)
    print(names(slim_recipes)[i])
    #if(i %in% c(56)) next
    if(i %in% c(56, 97, 99, 155, 159, 160, 170, 172, 173, 183)) next
    expect_identical(suppressMessages(slim_run(slim_scripts[[!!i]], progress = FALSE,
                                               throw_error = TRUE))$exit_status, 0L)
  }
})
