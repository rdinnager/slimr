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
  drive_letter <- stringr::str_match(windows_path, "^([a-z]):")
  stringr::str_replace(windows_path, drive_letter[1], paste0("\\\\mnt\\\\", drive_letter[2])) %>%
    stringr::str_replace_all("\\\\", "/")

}

get_generation_lines <- function(slim_script) {
  gen_lines <- stringr::str_match(strsplit(slim_script, "\n")[[1]], "^([0-9]+) ")
}
