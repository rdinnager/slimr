% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{slim_file}
\alias{slim_file}
\title{Make sure a file name is compatible with using in a SLiM script.}
\usage{
slim_file(file_name)
}
\arguments{
\item{file_name}{The name of the file to convert}
}
\value{
The converted filename that will ensure SLiM can access the file.
}
\description{
This generally only need to be used if you are using Windows, where
this function will convert the file name into a path that can be accessed
inside Windows Subsystem for Linux (WSL).
}
