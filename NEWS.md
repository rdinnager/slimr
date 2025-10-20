# slimr (development version)

# slimr 0.4.1

* Enhanced `slim_setup()` function with improved reliability and user experience:
  - Added automatic conda Terms of Service acceptance to prevent installation failures
  - Implemented download retry logic with exponential backoff for more reliable binary downloads
  - Added structured error messages with platform-specific guidance and troubleshooting steps
  - Added post-installation verification that automatically tests the SLiM installation
  - Added informative progress messages throughout the installation process
  - `slim_version` parameter now accepts specific version numbers (e.g., "4.2.2", "5.1") in addition to "stable" (default: SLiM 4.2.2)
  - Warns users about potential compatibility issues when installing SLiM 5.x

# slimr 0.4.0

* Updated `slimr` to be fully compatible with SLiM v4.1 updates
* Changed `SLIM_HOME` environmental variable to `SLIMR_PATH`, which now should be
set with the full path to the SLiM executable, not just the directory containing it
* Updated `slim_setup()` function which now provides cross-platform automatic installation using conda via the `reticulate` package. Now it should not be necessary for users to manually install SLiM any more
* Simplified `slim_run()` API and temporarily removed ability to use R callbacks (the plan is to eventually replace this functionality with a new '`slimr` verb' function)
* Added new '`slimr` verb' `r_message()`. `r_message()` can be called in a `slim_block()` to print a message to the R console while the SLiM simulation is running. This is useful for debugging and monitoring progress of a simulation.
* `slim_run()` with `progress = TRUE` now produces a progress bar for any simulation (previously it only worked if you created output with `r_output()`) and is much more efficient (produces less overhead)
* `slim_script_render_dots()` function added. It works just like `slim_script_render()`, but accepts values to be filled in a templated `slimr_script` as named arguments. For example `slim_script_render_dots(x, mut_rate = c(1e-6, 1e-7))` will render the `slimr_script` called `x` with `mut_rate` set to `1e-6` and `1e-7`. This can sometimes be less verbose than using a list or data frame to fill in a templated `slimr_script`, especially useful when you simply want to test different values quickly.


# slimr 0.3.0

* Added `slim_auto()` function to automatically insert `r_template()` and `r_inline()` statement in useful places in a `slimr_script`, based on computational graph analysis
* Added `as_slimr_code()` function, which is similar to `as_slimr_script()`, which converts SLiM code as a character vector into a `slimr_script` object, but `as_slimr_code()` returns the code necessary to create the `slimr_script` instead. this allows copy and pasting the text into the R console or IDE so that it can be subsequently edited and modified.
* Added vignette showing how to create a multispecies model in `slimr`, and documented the multispecies feature in the documentation for `slim_block()`

# slimr 0.2.1

* allow user to manually set SLiM executable directory with `SLIM_HOME` environmental variable

# slimr 0.2.0

* all SLiM callbacks now supported
* slimr now fully supports SLiM versions 4.0 and greater, including support for 
multispecies models (though these have been extensively tested yet) and are currently undocumented
* slimr verbs are now prefixed with `r_` (e.g. `r_output`, `r_inline`, `r_template`). 
The old version `slimr_` prefixed version are still available for backwards 
compatibility, but should be considered soft-deprecated

# slimr 0.1.0

* SLiM Classes available for help with autocomplete now have nested class objects 
(e.g. `sim$subpopulations` references a `Subpopulation` object, so you can then 
autocomplete `sim$subpopulations$individuals`, for example)
* `$` accessor can now be used in place of SLiM's `.` operator. (previously
user's always had to use `%.%` to represent `.`)
* `slimr` now replaces any `<-` assignment operators in SLiM code with `=`.

# slimr 0.0.0.9001

* `slim_run()` function runs a `slimr_script` in SLiM and collects results
* `slimr` 'verbs' implemented (`slimr_template()`, `slimr_inline()`, and 
`slimr_output()`). These can be used inside SLiM coding block to powerful effect!
* `slim_block()` creates blocks of SLiM code, and `slim_script()` puts them 
together into scripts.
* Package functional


# slimr 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
