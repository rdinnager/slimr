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
slim_install_path <- function() {
  install_path()
}

#' Attempt to install and / or setup SLiM for use with slimr
#'
#' `slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
#' Note that on Windows, this will attempt to download a precompiled executable.
#'
#' @param install_dir Directory to install SLiM to. If "default" `slim_setup()` will install in the default
#' directory. Be careful to make sure you have write and execution permissions for the installation folder
#' you specify. We recommend using the default directory "~/slim", in which case you will not have to set an
#' environmental variable to tell slimr where to find your slim installation. Note that for Windows, this
#' refers to a linux path from the perspective of your Windows Subsystem for Linux (WSL) distribution, not a
#' Windows path.
#' @param verbose Whether to print out progress of the installation.
#' @param force If \code{FALSE} (the default) \code{slim_setup} will not install SLiM if it is already
#' installed and can be found. If you want to force an installation, even if SLiM is already installed
#' (perhaps to install a newer version), then use \code{force=TRUE}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' slim_setup()
#' }
slim_setup <- function(verbose = TRUE,
                       force = FALSE) {

  install_dir <- install_path()

  suppress_out <- !verbose

  if((!slim_is_avail()) | force){
    platform <- get_os()
    if(!platform %in% c("windows", "linux", "osx")) {
      stop("Sorry, we don't recognize that platform. Valid options are \"windows\", \"unix\", or \"osx\"")
    }

    if(platform == "windows") {

      ## check if slim is already installed


      message("Attempting to download SLiM")
      download.file("https://github.com/rdinnager/slimr/releases/download/slim-windows-executable/slim.exe",
                      file.path(install_path(), "slim.exe"))


      #slim_settings$slim_call <- 'bash -c "slim {slim_options}"'

    } else {

      ## check if slim is already installed



      if(!slim_is_avail()) {

        message("Attempting to install slim on linux...")

        system("wget http://benhaller.com/slim/SLiM.zip",
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        unzip <- system("unzip -o SLiM.zip",
                        ignore.stdout = suppress_out,
                        ignore.stderr = suppress_out)
        if(unzip != 0) {
          stop("Unzipping of SLiM archive failed. Make sure you have unzip installed on your WSL distro. e.g.
               for Ubuntu run `sudo apt-get install unzip`.")
        }

        system("mkdir SLiM_build",
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        if(install_dir == "default") {
          compile <- system("cd SLiM_build \
                            cmake -DCMAKE_BUILD_TYPE=Release ../SLiM \
                            make \
                            make install",
                            ignore.stdout = suppress_out,
                            ignore.stderr = suppress_out)
        } else {
          if(!dir.exists(install_dir)) {
            dir.create(install_dir)
          }

          compile <- system(stringr::str_replace("cd SLiM_build \
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/path/to/install ../SLiM \
  make \
                            make install",
                                                 "/path/to/install",
                                                 install_dir),
                            ignore.stdout = suppress_out,
                            ignore.stderr = suppress_out)
        }

        if(compile != 0) {

          system("rm SLiM.zip",
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)
          system("rm -r SLiM",
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)
          system("rm -r SLiM_build",
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)

          stop("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
               installed in your linux distro and that they are accessible (e.g. in the PATH)")
        }

        system("rm SLiM.zip",
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)
        system("rm -r SLiM",
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)
        system("rm -r SLiM_build",
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        message("\n")
        message("SLiM installed! Running a test now...")
        message("\n")

      } else {
        message("Looks like SLiM is already installed. If you want to reinstall use force=TRUE")
      }



    }

    .slim_settings$slim_dir <- install_dir

    .slim_settings$slim_call <- get_slim_call()
    .slim_settings$slim_avail <- TRUE

    Sys.setenv(SLIMR_SLIM_DIR = install_dir)

    if(install_dir != "~/slim") {
      message("\n")
      if (requireNamespace("crayon", quietly = TRUE)) {
        message(stringr::str_wrap(glue::glue("It looks like you didn't use the default installation directory for SLiM. If you want slimr to find your SLiM installation in subsequent R sessions, please either make sure the slim executable is on the path, or set the SLIMR_SLIM_DIR evironmental variable to '{install_dir}'. We recommend adding this to your .RProfile file. This is most easily done by using {crayon::green('usethis::edit_r_environ()')}, and copying in the following line:\n{crayon::blue('SLIMR_SLIM_DIR=')}'{crayon::green(install_dir)}'\n"),
                                  exdent = 2))
      } else {
        message(stringr::str_wrap(glue::glue("It looks like you didn't use the default installation directory for SLiM. If you want slimr to find your SLiM installation in subsequent R sessions, please either make sure the slim executable is on the path, or set the SLIMR_SLIM_DIR evironmental variable to '{install_dir}'. We recommend adding this to your .RProfile file. This is most easily done by using {crayon::green('usethis::edit_r_environ()')}, and copying in the following line:\nSLIMR_SLIM_DIR=install_dir\n"),
                                  exdent = 2))
      }
      message("\n")
      if (requireNamespace("clipr", quietly = TRUE)) {
        clipr::write_clip(glue::glue("SLIMR_SLIM_DIR='{install_dir}'"))
        message("This snippet has been copied to the clipboard.")
      }
    }

    return(invisible(NULL))
  } else {
    message("Looks like SLiM is already installed. If you want to reinstall use force=TRUE")
  }
}


#' Get the call information for running SLiM. Doubles as a check for SLiM availability.
#'
#' Function to test if SLiM is available on user's system.
#'
#' @return
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
