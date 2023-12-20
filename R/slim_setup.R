default_install_path <- function() {
  path <- Sys.getenv("SLIM_PATH")
  if (nzchar(path)) {
    path <- normalizePath(dirname(path), mustWork = FALSE)
  } else {
    path <- normalizePath(file.path(system.file("", package = "slimr")), mustWork = FALSE)
  }
  path
}


#' Find the SLiM executable path `slimr` is using
#'
#' Returns the SLiM installation path used by `slimr` to run simulations.
#'
#' @export
#' @examples
#' slim_install_path()
#'
slim_install_path <- function() {
  find_slim_path()
}

find_slim_path <- function() {
  ## look in SLIM_PATH env variable
  path <- Sys.getenv("SLIM_PATH")
  if (nzchar(path)) {
    return(normalizePath(path, mustWork = FALSE))
  }
  ## look for slim executable in conda if reticulate is installed
  if(rlang::is_installed("reticulate")) {
    path <- find_slim_conda()
    if (nzchar(path)) {
      return(normalizePath(path, mustWork = FALSE))
    }
  }
  ## look in default install location
  path <- default_install_path()
  if (nzchar(path)) {
    return(normalizePath(path, mustWork = FALSE))
  }
  ## see if Sys.which can find it
  path <- slimr_which("slim")
  if (nzchar(path)) {
    return(normalizePath(path, mustWork = FALSE))
  }
  path
}

find_slim_conda <- function() {
  assert_package("reticulate")
  envs <- reticulate::conda_list()
  if ("slimr-conda" %in% envs$name) {
    return(slim_conda_path(envs$python[envs$name == "slimr-conda"]))
  }
  conda_path <- ""
  n_envs <- nrow(envs)
  i <- 0
  while(!slim_exists(conda_path) && i < n_envs) {
    i <- i + 1
    conda_path <- slim_conda_path(envs$python[i])
  }
  conda_path
}

slim_exists <- function(path) {
  slimr_which(path) != ""
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
#' @param install_path If \code{method="binary"}, then this is the path to install the SLiM executable.
#' If you do not use the default path, then you will need to set the \code{SLIM_PATH} environment variable
#' so that slimr can find it.
#' @param conda_env If \code{method="conda"}, then this is the name of the conda environment to install
#' SLiM into. If you do not use the default name, then it may take lomger for slimr to find SLiM (which may
#' increase loading times for the library).
#'
#' @export
#'
#' @examples
#' if(interactive()) {
#'   slim_setup()
#' }
slim_setup <- function(method = c("conda", "binary"),
                       verbose = TRUE,
                       force = FALSE,
                       install_path = default_install_path(),
                       conda_env = "slimr-conda") {

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
                  file.path(install_path, "slim.exe"),
                  mode = "wb")

    .slim_settings$slim_path <- file.path(install_path, "slim.exe")

    .slim_settings$slim_call <- get_slim_call()

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
    if(conda_env %in% l$name) {
      reticulate::conda_install(conda_env, packages = "slim", python_version = NULL)
      slimr_path <- l |>
        dplyr::filter(name == conda_env) |>
        dplyr::pull(path)
      conda_path <- slim_conda_path(slimr_path)
    } else {
      slimr_path <- reticulate::conda_create(conda_env, packages = "slim", python_version = NULL)
      conda_path <- slim_conda_path(slimr_path)
    }

    .slim_settings$slim_path <- conda_path

    .slim_settings$slim_call <- get_slim_call()

    if(verbose) {
      rlang::inform(glue::glue("SLiM installed successfully. SLiM executable can be found in {conda_path}. `slimr` should be able to find it automatically if you used default settings. Otherwise, you can add this path to the SLIM_PATH environmental variable."))
    }
  }

  if(!slim_is_avail()) {
    message("We are sorry, but it appears the installation failed. Please visit https://rdinnager.github.io/slimr/ and follow the manual installation instructions instead. Then you can help slimr find the SLiM executable by adding its path to the SLIM_PATH environment variable.")
  }


}

slim_conda_path <- function(conda_python) {
  # assert_package("reticulate")
  # l <- reticulate::conda_list() |>
  #   dplyr::filter(name == "slimr-conda")
  # if(nrow(l) == 0) {
  #   return(NULL)
  # }
  os <- get_os()
  if(os == "windows") {
    return(file.path(dirname(conda_python), "Library", "bin", "slim.exe"))
  } else {
    return(file.path(dirname(conda_python), "slim"))
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

    slim_path <- get_slim_path()

    if(is.null(slim_path)) {
      slim_call <- NULL
    } else {
      slim_call <- list(call = slim_path,
                        args = "{script_file}")
    }

    return(slim_call)
  }
}

get_slim_path <- function() {

  if(!is.null(.slim_settings$slim_path)) {
    return(.slim_settings$slim_path)
  } else {

    if(Sys.getenv("SLIM_PATH") != "") {
      return(Sys.getenv("SLIM_PATH"))
    } else {
      return(NULL)
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

  slim_path <- get_slim_path()
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
    rlang::abort("SLiM is not installed or can't be found. Please install using slim_setup() or manually by following the instruction at https://messerlab.org/slim/ . If you are sure SLiM is already installed, you can let slimr know where it is by setting the environmental variable SLIM_PATH, e.g. Sys.setenv(SLIM_PATH = 'slim_path'), where slim_path is the path to your SLiM executable (usually slim or slim.exe)")
  }
}
