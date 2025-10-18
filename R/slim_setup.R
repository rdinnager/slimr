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
  get_slim_path()
}

find_slim_path <- function() {
  ## look in SLIM_PATH env variable
  path <- Sys.getenv("SLIM_PATH")
  if (nzchar(path)) {
    return(normalizePath(path, mustWork = FALSE))
  }
  ## look for slim executable in conda if reticulate and conda is installed
  if(rlang::is_installed("reticulate") && reticulate::condaenv_exists()) {
    path <- find_slim_conda()
    if (nzchar(path)) {
      return(normalizePath(path, mustWork = FALSE))
    }
  }
  ## look in default install location
  path <- slimr_which(file.path(default_install_path(), "slim"))
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

# Configuration for SLiM binary sources
.slim_binary_sources <- list(
  windows = list(
    primary = "https://github.com/rdinnager/slimr/releases/download/slim-windows-executable/slim.exe"
  )
)

# Helper function to accept conda Terms of Service
accept_conda_tos <- function() {
  tryCatch({
    conda_exe <- reticulate::conda_binary()

    channels <- c(
      "https://repo.anaconda.com/pkgs/main",
      "https://repo.anaconda.com/pkgs/r",
      "https://repo.anaconda.com/pkgs/msys2"
    )

    for (channel in channels) {
      system2(conda_exe, c("tos", "accept", "--override-channels", "--channel", channel),
              stdout = FALSE, stderr = FALSE)
    }
    TRUE
  }, error = function(e) {
    FALSE
  })
}

# Helper function to get conda package specification for SLiM version
get_slim_conda_spec <- function(slim_version) {
  slim_version <- match.arg(slim_version, c("stable", "latest"))

  if (slim_version == "stable") {
    # Pin to 4.x for stability and compatibility
    return("slim<5")
  } else {
    # Install latest version
    return("slim")
  }
}

# Helper function to download file with retry logic
download_with_retry <- function(url, destfile, mode = "wb", max_retries = 3, verbose = TRUE) {
  for (attempt in 1:max_retries) {
    result <- tryCatch({
      if(verbose && attempt > 1) {
        rlang::inform(paste0("Retry attempt ", attempt, " of ", max_retries, "..."))
      }
      download.file(url, destfile, mode = mode, quiet = !verbose)
      TRUE
    }, error = function(e) {
      if (attempt == max_retries) {
        return(e)
      }
      Sys.sleep(2^(attempt - 1)) # Exponential backoff
      FALSE
    })

    if (isTRUE(result)) {
      return(TRUE)
    } else if (inherits(result, "error")) {
      stop(result)
    }
  }
  FALSE
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
#' SLiM into. If you do not use the default name, then it may take longer for slimr to find SLiM (which may
#' increase loading times for the library).
#' @param slim_version The version of SLiM to install. Can be "stable" (SLiM 4.x, recommended for compatibility),
#' "latest" (newest available version, may have compatibility issues), or a specific version string like "4.1" or "5.1".
#' Only applies to conda installation method. Binary method installs a fixed version.
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
                       conda_env = "slimr-conda",
                       slim_version = c("stable", "latest")) {

  if(slim_is_avail() && !force) {
    rlang::inform("Looks like SLiM is already installed. If you want to reinstall use force=TRUE")
    return(invisible(NULL))
  }

  method <- match.arg(method)
  slim_version <- match.arg(slim_version)

  if(method == "binary") {
    os <- get_os()
    if(os != "windows") {
      # Provide helpful guidance for other platforms
      if(os == "mac") {
        rlang::abort(c(
          "Binary installation is currently only available for Windows.",
          "i" = "For macOS, try: brew install messerlab/slim/slim",
          "i" = "Or use: slim_setup(method = 'conda')",
          "i" = "Manual installation: https://messerlab.org/slim/"
        ))
      } else {
        rlang::abort(c(
          "Binary installation is currently only available for Windows.",
          "i" = "For Linux, install via your package manager or use: slim_setup(method = 'conda')",
          "i" = "Manual installation: https://messerlab.org/slim/"
        ))
      }
    }

    if(verbose) {
      rlang::inform("Attempting to download SLiM binary (version 4.1)...")
    }

    # Use download with retry logic
    binary_url <- .slim_binary_sources$windows$primary
    dest_file <- file.path(install_path, "slim.exe")

    tryCatch({
      download_with_retry(binary_url, dest_file, mode = "wb", verbose = verbose)
    }, error = function(e) {
      rlang::abort(c(
        "Failed to download SLiM binary.",
        "x" = as.character(e$message),
        "i" = "Check your internet connection",
        "i" = "Try method = 'conda' as an alternative",
        "i" = "Manual installation: https://messerlab.org/slim/",
        "i" = "Report issues: https://github.com/rdinnager/slimr/issues"
      ))
    })

    .slim_settings$slim_path <- dest_file
    .slim_settings$slim_call <- get_slim_call()

  }

  if(method == "conda") {

    assert_package("reticulate")

    # Check if conda exists and handle TOS issues
    conda_exists <- tryCatch({
      reticulate::condaenv_exists()
      TRUE
    }, error = function(e) {
      # Check if error is about miniconda already existing
      if(stringr::str_detect(as.character(e$message), "already installed")) {
        return(TRUE)
      }
      FALSE
    })

    if(!conda_exists) {
      if(verbose) {
        rlang::inform("Attempting to install miniconda (this may take a few minutes)...")
      }
      tryCatch({
        reticulate::install_miniconda()

        # Accept conda Terms of Service after fresh install
        if(verbose) {
          rlang::inform("Accepting conda Terms of Service...")
        }
        accept_conda_tos()
      }, error = function(e) {
        # Check if it's just that miniconda is already there
        if(!stringr::str_detect(as.character(e$message), "already installed")) {
          rlang::abort(c(
            "Failed to install miniconda.",
            "x" = as.character(e$message),
            "i" = "Try manual installation: https://docs.conda.io/en/latest/miniconda.html",
            "i" = "Then use slim_setup(method = 'conda') again"
          ))
        }
      })
    }

    # Handle conda TOS issues for existing installations
    tryCatch({
      reticulate::conda_list()
    }, error = function(e) {
      if(stringr::str_detect(as.character(e$message), "Terms of Service")) {
        if(verbose) {
          rlang::inform("Accepting conda Terms of Service...")
        }
        if(!accept_conda_tos()) {
          rlang::warn("Could not automatically accept conda Terms of Service. Installation may fail.")
        }
      }
    })

    if(verbose) {
      version_msg <- if(slim_version == "stable") {
        "Installing SLiM 4.x (stable, recommended for compatibility)..."
      } else {
        "Installing latest SLiM version (may have compatibility issues with slimr)..."
      }
      rlang::inform(version_msg)
      rlang::inform("This may take 2-3 minutes...")
    }

    slim_package <- get_slim_conda_spec(slim_version)

    tryCatch({
      l <- reticulate::conda_list()
      if(conda_env %in% l$name) {
        # Environment exists, install/update SLiM in it
        reticulate::conda_install(conda_env, packages = slim_package,
                                   channel = "conda-forge", python_version = NULL)
        # Get path from conda list after installation
        l_updated <- reticulate::conda_list()
        slimr_path <- l_updated |>
          dplyr::filter(.data$name == conda_env) |>
          dplyr::pull(.data$python)
        conda_path <- slim_conda_path(slimr_path)
      } else {
        # Create new environment with SLiM
        slimr_path <- reticulate::conda_create(conda_env, packages = slim_package,
                                                channel = "conda-forge", python_version = NULL)
        conda_path <- slim_conda_path(slimr_path)
      }
    }, error = function(e) {
      rlang::abort(c(
        "Failed to install SLiM via conda.",
        "x" = as.character(e$message),
        "i" = "Try method = 'binary' if on Windows",
        "i" = "Check conda installation: reticulate::conda_list()",
        "i" = "Manual installation: https://messerlab.org/slim/"
      ))
    })

    .slim_settings$slim_path <- conda_path
    .slim_settings$slim_call <- get_slim_call()

    if(verbose) {
      rlang::inform(glue::glue("SLiM installed successfully to: {conda_path}"))
    }
  }

  # Verify installation
  if(!slim_is_avail()) {
    rlang::abort(c(
      "Installation completed but SLiM cannot be found.",
      "i" = "Check installation path permissions",
      "i" = "Set SLIM_PATH environment variable manually if needed",
      "i" = "Visit: https://rdinnager.github.io/slimr/",
      "i" = "Report issues: https://github.com/rdinnager/slimr/issues"
    ))
  }

  # Run post-installation checks
  installed_version <- NULL
  tryCatch({
    installed_version <- slim_version()
    if(verbose) {
      rlang::inform(paste0("SLiM version ", installed_version, " installed successfully!"))
    }

    # Check compatibility and warn if needed
    if(!is.null(installed_version) && package_version(installed_version) >= "5.0") {
      rlang::warn(c(
        paste0("SLiM version ", installed_version, " was installed, but slimr is currently only fully compatible with SLiM 4.x."),
        "!" = "Some functions may not work correctly with SLiM 5.x",
        "i" = "For full compatibility, use: slim_setup(method = 'binary') or slim_setup(slim_version = 'stable')",
        "i" = "Track SLiM 5.x support: https://github.com/rdinnager/slimr/issues"
      ))
    }

    # Run verification test
    if(verbose) {
      rlang::inform("Running verification test...")
    }
    test_result <- tryCatch({
      slim_test()
      TRUE
    }, error = function(e) {
      FALSE
    })

    if(!test_result) {
      rlang::warn(c(
        "SLiM installed but failed verification test.",
        "i" = "Check file permissions",
        "i" = "Try running a simple SLiM script manually"
      ))
    } else if(verbose) {
      rlang::inform("Verification test passed!")
    }

  }, error = function(e) {
    rlang::warn(c(
      "Could not verify SLiM installation.",
      "i" = "SLiM may still work - try running a script to confirm"
    ))
  })


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
      slim_call <- list(call = slimr_which(slim_path),
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
      return("")
    }

  }
}

# slim_get_executable <- function() {
#   slim_dir <- get_slim_dir()
#   slim_path <- slimr_which(file.path(slim_dir, "slim"))
#   if(slim_path == "" | !file.exists(slim_path)) {
#     slim_path <- slimr_which("slim")
#   }
#   slim_path
# }

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

#' Find out what version of SLiM is being used by \code{slimr}
#'
#' @return A character string with the version number
#' @export
#'
#' @examples
#' if(slim_is_avail()) {
#'   slim_version()
#' }
slim_version <- function() {
  assert_slim_installed()
  path <- get_slim_path()
  system2(path, "--version", stdout = TRUE)[[1]] |>
    stringr::str_extract("SLiM version [0-9.]+") |>
    stringr::str_remove("SLiM version ") |>
    stringr::str_trim()
}
