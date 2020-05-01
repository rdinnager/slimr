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
  tolower(os)
}

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
    here_it_is <- Sys.which(slim_path)
  }
}


convert_to_wsl_path <- function(windows_path) {
  windows_path <- normalizePath(windows_path)
  drive_letter <- stringr::str_match(windows_path, "^([A-Za-z]):")
  stringr::str_replace(windows_path, drive_letter[1], paste0("\\\\mnt\\\\", tolower(drive_letter[2]))) %>%
    stringr::str_replace_all("\\\\", "/")

}


#' Title
#'
#' @param a
#' @param b
#'
#' @return
#' @export
#'
#' @examples
`%+%` <- function(a, b) {
  stringr::str_c(a, b, sep = " ")
}

#' Title
#'
#' @param a
#' @param b
#'
#' @return
#' @export
#'
#' @examples
`%+n%` <- function(a, b) {
  stringr::str_c(a, b, sep = "\n")
}

