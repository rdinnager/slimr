#' Attempt to install and / or setup SLiM for use with slimr
#'
#' `slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
#' Note that on Windows, you must have Windows subsystem for linux installed, which requires at least Windows 10.
#'
#' @param install_dir Directory to install SLiM to. If "default" `slim_setup()` will install in the default
#' directory. Be carefult to make sure you have write and execution permissions for the installation folder
#' you specify. We recommend using the default directory "~/slim", in which case you will not have to set an
#' environmental variable to tell slimr where to find your slim installation.
#' @param test_slim Should SLiM be tested once installation is complete?
#' @param verbose Whether to print out progress of the installation.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' slim_setup()
#' }
slim_setup <- function(install_dir = "~/slim", test_slim = TRUE, verbose = TRUE) {

  suppress_out <- !verbose

  if(!is_slim_available()){
    platform <- get_os()
    if(!platform %in% c("windows", "linux", "osx")) {
      stop("Sorry, we don't recognize that platform. Valid options are \"windows\", \"unix\", or \"osx\"")
    }

    if(platform == "windows") {
      if(Sys.which("wsl.exe") == "") {
        stop("It appears your Windows system does not have a working Windows subsystem for linux (WSL). Please make
             sure you setup and install WSL before proceeding. Note WSL is only available for Windows 10 and above.
             See https://docs.microsoft.com/en-us/windows/wsl/install-win10 for installation instructions")
      }

      ## check if slim is already installed

      if(!.slim_settings$slim_avail) {

        message("Attempting to install slim using Window subsystem for linux (WSL)")

        system('bash -c "wget http://benhaller.com/slim/SLiM.zip"',
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        unzip <- system('bash -c "unzip -o SLiM.zip"',
                        ignore.stdout = suppress_out,
                        ignore.stderr = suppress_out)
        if(unzip != 0) {
          stop("Unzipping of SLiM archive failed. Make sure you have unzip installed on your WSL distro. e.g.
               for Ubuntu run `sudo apt-get install unzip`.")
        }

        system('bash -c "mkdir SLiM_build"',
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        if(install_dir == "default") {
          compile <- system('bash -c "cd SLiM_build \
                            cmake -DCMAKE_BUILD_TYPE=Release ../SLiM \
                            make \
                            make install"',
                            ignore.stdout = suppress_out,
                            ignore.stderr = suppress_out)
        } else {

          system(paste0('bash -c "mkdir -p ', install_dir, '"'),
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)

          compile <- system(stringr::str_replace('bash -c "cd SLiM_build \
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/path/to/install ../SLiM \
  make \
                            make install"',
                                                 "/path/to/install",
                                                 install_dir),
                            ignore.stdout = suppress_out,
                            ignore.stderr = suppress_out)
        }

        if(compile != 0) {

          system('bash -c "rm SLiM.zip"',
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)
          system('bash -c "rm -r SLiM"',
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)
          system('bash -c "rm -r SLiM_build"',
                 ignore.stdout = suppress_out,
                 ignore.stderr = suppress_out)

          stop("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
               installed in your WSL distro and that they are accessible (e.g. in the PATH)")
        }

        system('bash -c "rm SLiM.zip"',
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)
        system('bash -c "rm -r SLiM"',
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)
        system('bash -c "rm -r SLiM_build"',
               ignore.stdout = suppress_out,
               ignore.stderr = suppress_out)

        message("SLiM installed! Running a test now...")

        # test <- system('bash -c "slim -testSLiM"', intern = TRUE)
        #
        # if(any(grepl("SUCCESS", test))) {
        #   message("SLiM test successful. You should now be able to use `slimr`")
        # }

      } else {
        message("Looks like SLiM is already installed. Running a test now...")

        # test <- system('bash -c "slim -testSLiM"', intern = TRUE)
        #
        # if(any(grepl("SUCCESS", test))) {
        #   message("SLiM test successful. You should now be able to use `slimr`")
        # }
      }

      #slim_settings$slim_call <- 'bash -c "slim {slim_options}"'

    } else {

      ## check if slim is already installed



      if(!is_slim_available()) {

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


        # test <- system("slim -testSLiM", intern = TRUE)
        #
        # if(any(grepl("SUCCESS", test))) {
        #   message("SLiM test successful. You should now be able to use `slimr`")
        # }

        } else {
          message("Looks like SLiM is already installed. Running a test now...")

          # test <- system('bash -c "slim -testSLiM"', intern = TRUE)
          #
          # if(any(grepl("SUCCESS", test))) {
          #   message("SLiM test successful. You should now be able to use `slimr`")
          # }
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

    slim_dir <- get_slim_dir()

    slim_path <- slimr_which(file.path(slim_dir, "bin", "slim"), platform)
    if(slim_path == "") {
      slim_path <- slimr_which("slim", platform)
    }
    if(slim_path == "") {
      slim_call <- NULL
    } else {
      if(platform == "windows") {
        slim_call <- list(call = "bash",
                          args = c("-c", paste0('"', slim_path,
                                                ' {script_file}"')))
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
      return("~/slim")
    }
  }
}

is_slim_available <- function() {
  .slim_settings$slim_avail
}

slim_test <- function() {

  test <- slim_run_script(script_file = "--test")

}
