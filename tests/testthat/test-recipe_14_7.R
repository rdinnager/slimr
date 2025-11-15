test_that("Recipe 14.7: Live plotting with R using system() works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # This recipe depends on finding Rscript at specific Unix paths
  # On Windows or other systems, it will fail to find Rscript and stop()
  # We'll modify the script to handle this for testing

  # Create a modified version that works on any system
  recipe_14_7_modified <- slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7)
      initializeMutationType("m1", 0.5, "f", 0.0)
      initializeGenomicElementType("g1", m1, 1.0)
      initializeGenomicElement(g1, 0, 99999)
      initializeRecombinationRate(1e-8)

      # For testing, we'll skip the Rscript check and just define a dummy path
      # In real use on Unix systems, it would find the actual Rscript
      defineConstant("RSCRIPT", "Rscript")  # Will work if Rscript is in PATH
    }),
    slim_block(1, early(), {
      sim$addSubpop("p1", 5000)
      sim$setValue("fixed", NULL)

      defineConstant("pngPath", writeTempFile("plot_", ".png", ""))

      # If we're running in SLiMgui, open a plot window
      if (exists("slimgui"))
        slimgui$openDocument(pngPath)
    }),
    slim_block(1, .., early(), {
      if (sim$cycle %% 10 == 0)
      {
        count <- sim$substitutions$size()
        sim$setValue("fixed", c(sim$getValue("fixed"), count))
      }

      # Use if-else instead of early return (return() doesn't work in slimr)
      if (sim$cycle %% 1000 == 0)
      {
        y <- sim$getValue("fixed")

        rstr <- paste('{',
                      'x <- (1:' + size(y) + ') * 10',
                      'y <- c(' + paste(y, sep = ", ") + ')',
                      'png(width=4, height=4, units="in", res=72, file="' + pngPath + '")',
                      'par(mar=c(4.0, 4.0, 1.5, 1.5))',
                      'plot(x=x, y=y, xlim=c(0, 50000), ylim=c(0, 500), type="l",',
                        'xlab="Generation", ylab="Fixed mutations", cex.axis=0.95,',
                        'cex.lab=1.2, mgp=c(2.5, 0.7, 0), col="red", lwd=2,',
                        'xaxp=c(0, 50000, 2))',
                      'box()',
                      'dev.off()',
                      '}', sep = "\n")

        scriptPath <- writeTempFile("plot_", ".R", rstr)
        system(RSCRIPT, args = scriptPath)
        deleteFile(scriptPath)
      }
    }),
    slim_block(50000, late(), {
      sim$outputFixedMutations()
    })
  )

  # Run the recipe
  # Note: This will fail if Rscript is not in PATH, but that's expected
  # We'll catch errors and skip if Rscript isn't available
  result <- tryCatch({
    slim_run(recipe_14_7_modified)
  }, error = function(e) {
    if (grepl("system.*failed", as.character(e), ignore.case = TRUE)) {
      skip("Rscript not available in PATH")
    }
    stop(e)
  })

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- readLines(result$output_file)

  # Should have output of fixed mutations at the end
  expect_true(length(output) > 0)

  # The script outputs fixed mutations in the final generation
  # Look for "Mutations:" header or mutation output format
  expect_true(any(grepl("Mutations", output)) || any(grepl("^#OUT:", output)))
})
