.onLoad <- function(libname, pkgname) {
  slim_avail <- is_slim_available()
  if(slim_avail) {
    slim_settings$slim_call <- get_slim_call()
  } else {
    packageStartupMessage("Welcome to the slimr package. slimr requires SLiM population genetics forward simulation software. Run slim_setup() for slimr to attempt to download and install the package automatically. If that doesn't work, try installing manually by going to https://messerlab.org/slim/ and following the instructions.")
  }

  recipes <- list.files(system.file('Recipes', package = 'existing_package'))

}
