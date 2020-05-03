#' Function to return the OS
#'
#' This function shamelessly stolen from: https://www.r-bloggers.com/identifying-the-os-from-r/
#'
#' @return Lowercase character stating the OS: linux, windows, or osx
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
slimr_which <- function(slim_path, os = c("linux", "osx", "windows")) {
  if(missing(os)) {
    os <- get_os()
  }
  if(os == "windows") {
    exe <- processx::run("bash", c("-c", glue::glue('"which -a {slim_path}"')),
                         windows_verbatim_args = TRUE, error_on_status = FALSE)
    if(exe$status == 0) {
      here_it_is <- stringr::str_remove_all(exe$stdout, "\n")
    } else {
      here_it_is <- ""
    }
  } else {
    here_it_is <- Sys.which(path.expand(slim_path))
  }
  here_it_is
}


#' Convert a path into a path that works inside Windows Subsystem for Linux
#'
#' WSL can access windows files through a directory mounted in the /mnt directory. This function converts a windows path from outside WSL to point to the correct directory inside WSL
#'
#' @param windows_path The windows path to convert.
#'
#' @return The modified path.
convert_to_wsl_path <- function(windows_path) {
  windows_path <- normalizePath(windows_path)
  drive_letter <- stringr::str_match(windows_path, "^([A-Za-z]):")
  stringr::str_replace(windows_path, drive_letter[1], paste0("\\\\mnt\\\\", tolower(drive_letter[2]))) %>%
    stringr::str_replace_all("\\\\", "/")

}


#' Glue two strings together.
#'
#' @param a First string
#' @param b Second sring
#'
#' @return New string with a and b pasted together with a space in between.
`%+%` <- function(a, b) {
  stringr::str_c(a, b, sep = " ")
}

#' Glue two string together with a newline separator
#'
#' @param a First string
#' @param b Second sring
#'
#' @return New string with a and b pasted together with a newline in between.
`%+n%` <- function(a, b) {
  stringr::str_c(a, b, sep = "\n")
}

