install_path <- function() {
  path <- Sys.getenv("SLIM_HOME")
  if (nzchar(path)) {
    path <- normalizePath(path, mustWork = FALSE)
  } else {
    path <- normalizePath(file.path(system.file("", package = "slimr")), mustWork = FALSE)
  }
  path
}

#' A simple exported version of install_path
#' Returns the SLiM installation path.
#' @export
#' @examples
#' slim_install_path()
#'
slim_install_path <- function() {
  install_path()
}

#' Attempt to install and / or setup SLiM for use with slimr
#'
#' `slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
#' Note that on Windows, this will attempt to download a precompiled executable.
#'
#' @importFrom utils download.file
#'
#' @param method The method to use to install SLiM. Currently, only "conda" and "binary" are supported.
#' If "conda", then SLiM will be installed via conda using the \code{reticulate} package. If "binary",
#' then SLiM will be downloaded as a precompiled executable, which is currently only available on Windows.
#' @param verbose Whether to print out progress of the installation.
#' @param force If \code{FALSE} (the default) \code{slim_setup} will not install SLiM if it is already
#' installed and can be found. If you want to force an installation, even if SLiM is already installed
#' (perhaps to install a newer version), then use \code{force=TRUE}.
#'
#' @export
#'
#' @examples
#' if(interactive()) {
#'   slim_setup()
#' }
slim_setup <- function(method = c("conda", "binary"),
                       verbose = TRUE,
                       force = FALSE) {

  if(slim_is_avail() && !force) {
    rlang::inform("Looks like SLiM is already installed. If you want to reinstall use force=TRUE")
    return(invisible(NULL))
  }

  method <- match.arg(method)

  if(method == "binary") {
    if(get_os() != "windows") {
      rlang::abort("Sorry, the binary installation method is currently only available for Windows.")
    }
    if(verbose) {
      rlang::inform("Attempting to download SLiM binary...")
    }
    download.file("https://github.com/rdinnager/slimr/releases/download/slim-windows-executable/slim.exe",
                  file.path(install_path(), "slim.exe"),
                  mode = "wb")

    .slim_settings$slim_dir <- install_path()

    .slim_settings$slim_call <- get_slim_call()
    .slim_settings$slim_avail <- TRUE

    Sys.setenv(SLIM_HOME = install_path())
  }

  if(method == "conda") {

    assert_package("reticulate")

    if(is.null(reticulate::conda_binary())) {
      if(verbose) {
        rlang::inform("Attempting to install miniconda...")
      }
      reticulate::install_miniconda()
    }

    if(verbose) {
      rlang::inform("Attempting to install SLiM via conda...")
    }

    l <- reticulate::conda_list()
    if("slimr-conda" %in% l$name) {
      slimr_path <- reticulate::conda_install("slimr-conda", packages = "slim", python_version = NULL)
    } else {

      slimr_path <- reticulate::conda_create("slimr-conda", packages = "slim", python_version = NULL)

    }


    conda_path <- slim_conda_path()

    .slim_settings$slim_dir <- conda_path

    .slim_settings$slim_call <- get_slim_call()
    .slim_settings$slim_avail <- TRUE

    Sys.setenv(SLIM_HOME = conda_path)

    if(verbose) {
      rlang::inform(glue::glue("SLiM installed successfully. SLiM executable can be found in {conda_path}. `slimr` should be able to find it automatically."))
    }
  }

  if(!slim_is_avail()) {
    message("We are sorry, but it appears the installation failed. Please visit https://rdinnager.github.io/slimr/ and follow the manual installation instructions instead.")
  }


}

slim_conda_path <- function() {
  assert_package("reticulate")
  l <- reticulate::conda_list() |>
    dplyr::filter(name == "slimr-conda")
  if(nrow(l) == 0) {
    return(NULL)
  }
  os <- get_os()
  if(os == "windows") {
    return(file.path(dirname(l$python[1]), "Library", "bin"))
  } else {
    return(dirname(l$python[1]))
  }
}


#' Get the call information for running SLiM. Doubles as a check for SLiM availability.
#'
#' Function to test if SLiM is available on user's system and return the correct system call
#' to execute it.
get_slim_call <- function() {

  if(!is.null(.slim_settings$slim_call)) {

    return(.slim_settings$slim_call)

  } else {

    slim_path <- slim_get_executable()

    if(slim_path == "") {
      slim_call <- NULL
    } else {
      slim_call <- list(call = slim_path,
                        args = "{script_file}")
    }

    return(slim_call)
  }
}

get_slim_dir <- function() {

  if(!is.null(.slim_settings$slim_dir)) {
    return(.slim_settings$slim_dir)
  } else {

    if(Sys.getenv("SLIM_HOME") != "") {
      return(Sys.getenv("SLIM_HOME"))
    } else {
      return(install_path())
    }

  }
}

slim_get_executable <- function() {
  slim_dir <- get_slim_dir()
  slim_path <- slimr_which(file.path(slim_dir, "slim"))
  if(slim_path == "" | !file.exists(slim_path)) {
    slim_path <- slimr_which("slim")
  }
  slim_path
}

#' Check if SLiM is installed and \code{slimr} can find it
#'
#' @return \code{TRUE} if SLiM is found and \code{FALSE} otherwise
#' @export
#'
#' @examples
#' slim_is_avail()
slim_is_avail <- function() {

  slim_path <- slim_get_executable()
  if(slim_path != "" & file.exists(slim_path)) {
    return(TRUE)
  } else {
    return(FALSE)
  }

}

slim_test <- function() {

  test <- slim_run_script(script_file = "--test")

}

assert_slim_installed <- function() {
  if(!slim_is_avail()) {
    rlang::abort("SLiM is not installed or can't be found. Please install using slim_setup() or manually by following the instruction at https://messerlab.org/slim/ . If you are sure SLiM is already installed, you can let slimr know where it is by setting the environmental variable SLIM_HOME, e.g. Sys.setenv(SLIM_HOME = 'install_dir'), where install_dir is the directory that contains your SLiM executable (usually slim or slim.exe)")
  }
}
