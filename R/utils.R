slim_settings <- new.env(parent = emptyenv())

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


convert_to_wsl_path <- function(windows_path) {
  stringr::str_replace(windows_path, "C:", "\\\\mnt\\\\c") %>%
    stringr::str_replace_all("\\\\", "/")

}
