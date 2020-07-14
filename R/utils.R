# modified from drake::assert_pkg
assert_package <- function (pkg, version = NULL, install = "install.packages") {

  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop("This function requires the ", pkg, " package, which is not installed. Install with ",
         install, "(\"", pkg, "\").", call. = FALSE)
  }
  if (!is.null(version)) {

    installed_version <- as.character(utils::packageVersion(pkg))
    is_too_old <- utils::compareVersion(installed_version, version) < 0
    if (is_too_old) {
      stop("This function package requires the ", pkg, " package to be version ",
           version, " or heigher. ", "Found version ",
           version, " installed.", "Update it with ",
           install, "(\"", pkg, "\").",
           call. = FALSE)
    }
  }

  invisible()

}

#' Function to return the OS
#'
#' This function shamelessly stolen from: https://www.r-bloggers.com/identifying-the-os-from-r/
#'
#' @return Lowercase character stating the OS: linux, windows, or osx
#' @noRd
get_os <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  os <- tolower(os)

  if(!os %in% c("windows", "linux", "osx")) {
    stop("Couldn't detect OS.")
  }

  os
}

#' Get the proper path for the SLiM executable. Returns "" if it cannot be found
#'
#' @param slim_path Path to SLiM executable
#' @param os What operating system are we working in? Must be "windows", "osx", or "linux#', if left blank slimr will try and detrmine it automatically
#' @return The full path to the executable as a character, or "" if not found.
#' @noRd
slimr_which <- function(slim_path, os = c("linux", "osx", "windows")) {
  if(missing(os)) {
    os <- get_os()
  }
  if(os == "windows") {
    # exe <- processx::run("bash", c("-c", glue::glue('"which -a {slim_path}"')),
    #                      windows_verbatim_args = TRUE, error_on_status = FALSE)

    exe <- system(glue::glue('bash -c "which -a {slim_path}"'),
                  intern = TRUE,
                  show.output.on.console = FALSE)
    if(is.null(attr(exe, "status"))) {
      here_it_is <- stringr::str_remove_all(exe, "\n")
    } else {
      here_it_is <- ""
    }
  } else {
    here_it_is <- Sys.which(path.expand(slim_path))
  }
  here_it_is
}

#' Compares two sets and returns TRUE if they are the same.
#'
#' This code modified from code (by fangly) found here: https://github.com/r-lib/testthat/issues/473. Should be equivalent to the test performed in testthat::expect_setequal
#'
#' @param actual The actual set.
#' @param expected The expected set.
#'
#' @return A logical scalar, TRUE if the sets are equal, FALSE if they are not equal
#' @noRd
sets_equal <- function(actual, expected) {
  differences <- setdiff(actual, expected)
  sets_equal  <- length(differences) == 0
  sets_equal
}


#' Convert a path into a path that works inside Windows Subsystem for Linux
#'
#' WSL can access windows files through a directory mounted in the /mnt directory. This function converts a windows path from outside WSL to point to the correct directory inside WSL
#'
#' @param windows_path The windows path to convert.
#'
#' @return The modified path.
#' @noRd
convert_to_wsl_path <- function(windows_path) {
  windows_path <- normalizePath(windows_path, winslash = "/")
  drive_letter <- stringr::str_match(windows_path, "^([A-Za-z]):")
  stringr::str_replace(windows_path, drive_letter[ , 1], paste0("/mnt/", tolower(drive_letter[ , 2])))
}


#' Glue two strings together.
#'
#' @param a First string
#' @param b Second sring
#'
#' @return New string with a and b pasted together with a space in between.
#' @noRd
`%+%` <- function(a, b) {
  stringr::str_c(a, b, sep = " ")
}

#' Glue two string together with a newline separator
#'
#' @param a First string
#' @param b Second sring
#'
#' @return New string with a and b pasted together with a newline in between.
#' @noRd
`%+n%` <- function(a, b) {
  stringr::str_c(a, b, sep = "\n")
}

##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param code
fix_integers <- function(code) {

  purrr::map(code,
             ~stringr::str_replace_all(.x,
             "([:digit:]+)L",
             "\\1"))

}


