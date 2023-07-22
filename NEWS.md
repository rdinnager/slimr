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
