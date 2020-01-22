#' Attempt to install and / or setup SLiM for use with slimr
#'
#' `slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
#' Note that on Windows, you must have Windows subsystem for linux installed, which requires at least Windows 10.
#'
#' @param install_dir Directory to install SLiM to. If "default" `slim_setup()` will install in the default
#' directory. For simplicity we recommend sticking with "default" unless you have a good reason not to.
#' @param test_slim Should SLiM be tested once installation is complete?
#'
#' @export
#'
#' @examples
#' \donttest{
#' setup_slim()
#' }
slim_setup <- function(install_dir = "default", test_slim = TRUE) {

  platform <- get_os()
  if(!platform %in% c("windows", "linux", "osx")) {
    stop("Sorry, we don't recognize that platform. Valid options are \"windows\", \"unix\", or \"osx\"")
  }

  if(platform == "windows") {
    if(system('wsl.exe "echo"') != 0) {
      stop("It appears your Windows system does not have a working Windows subsystem for linux (WSL). Please make
           sure you setup and install WSL before proceeding. Note WSL is only available for Windows 10 and above.
           See https://docs.microsoft.com/en-us/windows/wsl/install-win10 for installation instructions")
    }

    ## check if slim is already installed

    if(system('bash -c "slim -v"') != 0) {

      message("Attempting to install slim using Window subsystem for linux (WSL)")

      system('bash -c "wget http://benhaller.com/slim/SLiM.zip"')

      unzip <- system('bash -c "unzip -o SLiM.zip"')
      if(unzip != 0) {
        stop("Unzipping of SLiM archive failed. Make sure you have unzip installed on your WSL distro. e.g.
             for Ubuntu run `sudo apt-get install unzip`.")
      }

      system('bash -c "mkdir SLiM_build"')

      if(install_dir == "default") {
        compile <- system('bash -c "cd SLiM_build \
                          cmake -DCMAKE_BUILD_TYPE=Release ../SLiM \
                          make \
                          make install"')
      } else {

        system(paste0('bash -c "mkdir -p ', install_dir, '"'))

        compile <- system(stringr::str_replace('bash -c "cd SLiM_build \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/path/to/install ../SLiM \
make \
                          make install"',
                                               "/path/to/install",
                                               install_dir))
      }

      if(compile != 0) {

        system('bash -c "rm SLiM.zip"')
        system('bash -c "rm -r SLiM"')
        system('bash -c "rm -r SLiM_build"')

        stop("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
             installed in your WSL distro and that they are accessible (e.g. in the PATH)")
      }

      system('bash -c "rm SLiM.zip"')
      system('bash -c "rm -r SLiM"')
      system('bash -c "rm -r SLiM_build"')

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

  }

  if(platform == "linux") {

    ## check if slim is already installed



    if(!is_slim_available()) {

      message("Attempting to install slim on linux...")

      system("wget http://benhaller.com/slim/SLiM.zip")

      unzip <- system("unzip -o SLiM.zip")
      if(unzip != 0) {
        stop("Unzipping of SLiM archive failed. Make sure you have unzip installed on your WSL distro. e.g.
             for Ubuntu run `sudo apt-get install unzip`.")
      }

      system("mkdir SLiM_build")

      if(install_dir == "default") {
        compile <- system('bash -c "cd SLiM_build \
                          cmake -DCMAKE_BUILD_TYPE=Release ../SLiM \
                          make \
                          make install"')
      } else {
        if(!dir.exists(install_dir)) {
          dir.create(install_dir)
        }

        compile <- system(stringr::str_replace("cd SLiM_build \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/path/to/install ../SLiM \
make \
                          make install",
                                               "/path/to/install",
                                               install_dir))
      }

      if(compile != 0) {

        system("rm SLiM.zip")
        system("rm -r SLiM")
        system("rm -r SLiM_build")

        stop("It looks like installation failed at compiling time. Make sure you have cmake and gcc (or build-essential)
             installed in your linux distro and that they are accessible (e.g. in the PATH)")
      }

      system("rm SLiM.zip")
      system("rm -r SLiM")
      system("rm -r SLiM_build")

      message("SLiM installed! Running a test now...")


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

  if(install_dir == "default") {
    install_dir <- ""
  }
  slim_settings$install_dir <- install_dir
  invisible(NULL)
}

#' Get SLiM call
#'
#' @return Character with call to run SLiM
get_slim_call <- function() {
  platform <- get_os()

  if(!platform %in% c("windows", "linux", "osx")) {
    stop("Couldn't detect OS.")
  }

  install_dir <- get_slim_install_dir()

  if(platform == "windows") {
    slim_call <- 'bash -c "{install_dir}slim {slim_options}"'
  }
  if(platform == "linux") {
    slim_call <- '{install_dir}slim {slim_options}'
  }
  if(platform == "osx") {
    slim_call <- '{install_dir}slim {slim_options}'
  }

  if(install_dir == "default" | install_dir == "") {
    slim_call <- stringr::str_replace(slim_call,
                                      stringr::fixed("{install_dir}"),
                                      stringr::fixed(""))
  } else {
    slim_call <- stringr::str_replace(slim_call,
                                      stringr::fixed("{install_dir}"),
                                      stringr::fixed(paste0(install_dir, "/bin/")))
  }
  return(slim_call)
}

#' Is SLiM Available?
#'
#' Function to test if SLiM is available on user's system.
#'
#' @return
is_slim_available <- function() {
  slim_call <- get_slim_call()

  if(is.null(slim_call)) {
    return(FALSE)
  }

  slim_call_version <- stringr::str_replace(slim_call, stringr::fixed("{slim_options}"), stringr::fixed("-v"))

  test <- system(slim_call_version, ignore.stdout = TRUE)

  return(test == 0)
}

get_slim_install_dir <- function() {

  if(!is.null(slim_settings$install_dir)) {
    return(slim_settings$install_dir)
  } else {
    if(!is.null(Sys.getenv("slim_install_dir"))) {
      return(Sys.getenv("slim_install_dir"))
    } else {
      return(NULL)
    }
  }
}
