.slim_settings <- new.env(parent = emptyenv())
.slim_assets <- new.env(parent = emptyenv())
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

.onLoad <- function(libname, pkgname) {

  .slim_settings$slim_dir <- get_slim_dir()

  slim_avail <- get_slim_call()
  if(!is.null(slim_avail)) {
    packageStartupMessage("Welcome to the slimr package for forward population genetics simulation in SLiM. For more information on SLiM please visit https://messerlab.org/slim/ .")
    .slim_settings$slim_call <- slim_avail
    .slim_settings$slim_avail <- TRUE
  } else {
    packageStartupMessage("Welcome to the slimr package. slimr requires SLiM population genetics forward simulation software. Run slim_setup() for slimr to attempt to download and install the package automatically. If that doesn't work, try installing manually by going to https://messerlab.org/slim/ and following the instructions.")
    .slim_settings$slim_avail <- FALSE
  }

  .slim_assets$keywords <- list()

}
