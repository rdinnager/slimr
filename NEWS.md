# slimr 0.4.0

* Updated `slimr` to be fully compatible with SLiM v4.1 updates
* Changed `SLIM_HOME` environmental variable to `SLIMR_PATH`, which now should be
set with the full path to the SLiM executable, not just the directory containing it
* Updated `slim_setup()` function which now provides cross-platform automatic installation using conda via the `reticulate` package. Now it should not be necessary for users to manually install SLiM anymore

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
