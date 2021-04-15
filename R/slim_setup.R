#' Attempt to install and / or setup SLiM for use with slimr
#'
#' `slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
#' Note that on Windows, you must have Windows subsystem for linux installed, which requires at least Windows 10.
#'
#' @param install_dir Directory to install SLiM to. If "default" `slim_setup()` will install in the default
#' directory. Be careful to make sure you have write and execution permissions for the installation folder
#' you specify. We recommend using the default directory "~/slim", in which case you will not have to set an
#' environmental variable to tell slimr where to find your slim installation. Note that for Windows, this
#' refers to a linux path from the perspective of your Windows Subsystem for Linux (WSL) distribution, not a
#' Windows path.
#' @param test_slim Should SLiM be tested once installation is complete?
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
slim_setup <- function(install_dir = "~/slim", test_slim = TRUE, verbose = TRUE, force = FALSE) {

  on.exit({
    rlang::inform("Deleting installation files...")
    rm_zip <- processx::run("rm", c("-f", "SLiM.zip"), wd = install_dir)
    rm_install_dir <- processx::run("rm", c("-f", "-r", "SLiM"), wd = install_dir)
    rm_build_dir <- processx::run("rm", c("-f", "-r", "SLiM_build"), wd = install_dir)
  }, add = TRUE)

  if(!slim_is_avail()){

    mk_install_dir <- processx::run("mkdir", "-p", install_dir)

    platform <- get_os()
    if(!platform %in% c("windows", "linux", "osx")) {
      rlang::abort("Sorry, we don't recognize that platform. Valid options are \"windows\", \"unix\", or \"osx\"")
    }

    if(platform == "windows") {
      if(Sys.which("wsl.exe") == "") {
        rlang::abort("It appears your Windows system does not have a working Windows subsystem for linux (WSL). Please make
             sure you setup and install WSL before proceeding. Note WSL is only available for Windows 10 and above.
             See https://docs.microsoft.com/en-us/windows/wsl/install-win10 for installation instructions")
      }

      ## check if slim is already installed

      if((!.slim_settings$slim_avail) | force) {

        rlang::inform("Attempting to install slim using Window subsystem for linux (WSL)")

        wget_it <- processx::run("wsl", c("--cd", "~", "wget", "http://benhaller.com/slim/SLiM.zip"),
                echo = verbose,
                wd = install_dir)

        if(wget_it$status != 0) {
          rlang::abort("Downloading the SLiM package failed. Are you connected to the internet?")
        }

        unzip <- processx::run("wsl", c("--cd", "~", "unzip", "-o", "SLiM.zip"),
                               echo = verbose)
        if(unzip$status != 0) {
          rlang::abort("Unzipping of SLiM archive failed. Make sure you have unzip installed on your WSL distro. e.g.
               for Ubuntu run `sudo apt-get install unzip`.")
        }

        mk_slim_build <- processx::run("wsl", c("mkdir", "-p", "SLiM_build"),
                                       echo = verbose,
                                       wd = install_dir)

        build_dir <- file.path(install_dir, "SLiM_build")

        if(install_dir == "default") {

          compile <- processx::run("wsl", c("cmake", "-DCMAKE_BUILD_TYPE=Release", "../SLiM"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("wsl", c("make"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("wsl", c("make", "install"),
                                   echo = verbose,
                                   wd = build_dir)

        } else {

          compile <- processx::run("wsl", c("cmake",
                                            "-DCMAKE_BUILD_TYPE=Release",
                                            paste0("-DCMAKE_INSTALL_PREFIX=",
                                                   install_dir),
                                            "../SLiM"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("wsl", c("make"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("wsl", c("make", "install"),
                                   echo = verbose,
                                   wd = build_dir)

        }

        if(compile$status != 0) {

          rlang::abort("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
               installed in your WSL distro and that they are accessible (e.g. in the PATH)")

        }



        rlang::inform("SLiM installed!")


      } else {

        rlang::inform("Looks like SLiM is already installed. If you want to reinstall use force=TRUE.")

      }


    } else {

      ## check if slim is already installed

      if((!.slim_settings$slim_avail) | force) {

        rlang::inform("Attempting to install slim on linux...")

        wget_it <- processx::run("wget", c("http://benhaller.com/slim/SLiM.zip"),
                                 echo = verbose,
                                 wd = install_dir)

        if(wget_it$status != 0) {
          rlang::abort("Downloading the SLiM package failed. Are you connected to the internet?")
        }

        unzip <- processx::run("unzip", c("-o", "SLiM.zip"),
                               echo = verbose,
                               wd = install_dir)

        if(unzip$status != 0) {
          rlang::abort("Unzipping of SLiM archive failed. Make sure you have unzip installed on your platform. e.g.
               for Ubuntu run `sudo apt-get install unzip`.")
        }

        mk_slim_build <- processx::run("mkdir", c("-p", "SLiM_build"),
                                       echo = verbose,
                                       wd = install_dir)

        build_dir <- file.path(install_dir, "SLiM_build")

        if(install_dir == "default") {

          compile <- processx::run("cmake", c("-DCMAKE_BUILD_TYPE=Release", "../SLiM"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("make",
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("make", c("install"),
                                   echo = verbose,
                                   wd = build_dir)

        } else {

          compile <- processx::run("cmake",
                                   c("-DCMAKE_BUILD_TYPE=Release",
                                     paste0("-DCMAKE_INSTALL_PREFIX=",
                                            install_dir),
                                     "../SLiM"),
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("make",
                                   echo = verbose,
                                   wd = build_dir)

          compile <- processx::run("make", c("install"),
                                   echo = verbose,
                                   wd = build_dir)

        }

        if(compile != 0) {

          rlang::abort("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
               installed in your linux distro and that they are accessible (e.g. in the PATH)")

        }


        rlang::inform("\nSLiM installed!\n")

      } else {

        rlang::inform("Looks like SLiM is already installed. If you want to reinstall use force=TRUE.")

      }



    }

    .slim_settings$slim_dir <- install_dir

    .slim_settings$slim_call <- get_slim_call()
    .slim_settings$slim_avail <- TRUE

    Sys.setenv(SLIMR_SLIM_DIR = install_dir)

    if(install_dir != "~/slim") {

      if (requireNamespace("crayon", quietly = TRUE)) {
        rlang::inform(stringr::str_wrap(glue::glue("It looks like you didn't use the default installation directory for SLiM. If you want slimr to find your SLiM installation in subsequent R sessions, please either make sure the slim executable is on the path, or set the SLIMR_SLIM_DIR evironmental variable to '{install_dir}'. We recommend adding this to your .RProfile file. This is most easily done by using {crayon::green('usethis::edit_r_environ()')}, and copying in the following line:\n{crayon::blue('SLIMR_SLIM_DIR=')}'{crayon::green(install_dir)}'\n"),
                exdent = 2))
      } else {
        rlang::inform(stringr::str_wrap(glue::glue("It looks like you didn't use the default installation directory for SLiM. If you want slimr to find your SLiM installation in subsequent R sessions, please either make sure the slim executable is on the path, or set the SLIMR_SLIM_DIR evironmental variable to '{install_dir}'. We recommend adding this to your .RProfile file. This is most easily done by using {crayon::green('usethis::edit_r_environ()')}, and copying in the following line:\nSLIMR_SLIM_DIR=install_dir\n"),
                                  exdent = 2))
      }

      if (requireNamespace("clipr", quietly = TRUE)) {
        clipr::write_clip(glue::glue("SLIMR_SLIM_DIR='{install_dir}'"))
        rlang::inform("\nThis snippet has been copied to the clipboard.")
      }
    }

    return(invisible(NULL))
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

    platform <- get_os()

    test <- slimr_which("slim", platform)

    if(test != "") {
      slim_path <- test
    } else {
      slim_dir <- get_slim_dir()
      slim_path <- slimr_which(file.path(slim_dir, "slim"), platform)
    }

    if(slim_path == "") {
      slim_call <- NULL
    } else {
      if(platform == "windows") {
        slim_call <- list(call = "wsl",
                          args = c(slim_path, "{script_file}"))
      } else {
        slim_call <- list(call = slim_path,
                          args = "{script_file}")
      }
    }

    return(slim_call)
  }
}

get_slim_dir <- function() {

  if(!is.null(.slim_settings$install_dir)) {
    return(.slim_settings$slim_dir)
  } else {
    if(Sys.getenv("SLIMR_SLIM_DIR") != "") {
      return(Sys.getenv("SLIMR_SLIM_DIR"))
    } else {
      return("~/slim/bin")
    }
  }
}

slim_is_avail <- function() {
  os <- get_os()
  test <- slimr_which("slim", os)
  if(test == "") {
    slim_dir <- get_slim_dir()
    test <- slimr_which(file.path(slim_dir, "slim"), os)
    if(test != "") {
      avail <- TRUE
    } else {
      avail <- FALSE
    }
  } else {
    avail <- TRUE
  }

  avail

}

slim_test <- function() {

  test <- slim_run_script(script_file = "--test")

}
