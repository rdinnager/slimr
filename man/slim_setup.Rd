% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_setup.R
\name{slim_setup}
\alias{slim_setup}
\title{Attempt to install and / or setup SLiM for use with slimr}
\usage{
slim_setup(
  install_dir = "~/slim",
  test_slim = TRUE,
  verbose = TRUE,
  force = FALSE
)
}
\arguments{
\item{install_dir}{Directory to install SLiM to. If "default" `slim_setup()` will install in the default
directory. Be careful to make sure you have write and execution permissions for the installation folder
you specify. We recommend using the default directory "~/slim", in which case you will not have to set an
environmental variable to tell slimr where to find your slim installation. Note that for Windows, this
refers to a linux path from the perspective of your Windows Subsystem for Linux (WSL) distribution, not a
Windows path.}

\item{test_slim}{Should SLiM be tested once installation is complete?}

\item{verbose}{Whether to print out progress of the installation.}

\item{force}{If \code{FALSE} (the default) \code{slim_setup} will not install SLiM if it is already
installed and can be found. If you want to force an installation, even if SLiM is already installed
(perhaps to install a newer version), then use \code{force=TRUE}.}
}
\description{
`slim_setup()` will attempt to determine the user's OS and install SLiM automatically.
Note that on Windows, you must have Windows subsystem for linux installed, which requires at least Windows 10.
}
\examples{
\dontrun{
slim_setup()
}
}
