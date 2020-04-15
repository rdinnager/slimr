.slim_settings <- new.env(parent = emptyenv())
.slim_assets <- new.env(parent = emptyenv())

.onAttach <- function(libname, pkgname) {
  set.seed(Sys.time())
  slim_avail <- is_slim_available()
  if(slim_avail) {
    .slim_settings$slim_call <- get_slim_call()
  } else {
    packageStartupMessage("Welcome to the slimr package. slimr requires SLiM population genetics forward simulation software. Run slim_setup() for slimr to attempt to download and install the package automatically. If that doesn't work, try installing manually by going to https://messerlab.org/slim/ and following the instructions.")
  }


}

.onLoad <- function(libname, pkgname) {
  if(Sys.getenv("slim_install_dir") != "") {
    .slim_settings$install_dir <- Sys.getenv("slim_install_dir")
  } else {
    .slim_settings$install_dir <- "~/slim"
  }

  .slim_assets$keywords <- list()

}
