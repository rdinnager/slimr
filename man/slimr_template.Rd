% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slimr_template.R
\name{slimr_template}
\alias{slimr_template}
\title{Create a templated variable}
\usage{
slimr_template(var_name, default = NULL, unquote_strings = FALSE)
}
\arguments{
\item{var_name}{Name to use as a placemarker for the variable. This name will be used for replacing values later.}

\item{default}{A default value to be inserted during script rendering if a value is not otherwise provided.}

\item{unquote_strings}{If the value being inserted is of class character, should it be 'unquoted', that is,
should double quotes around the value be removed? This is useful when you want to refer to a SLiM object, e.g.
to insert \code{p1.setMigrationRate(...)} instead of \code{"p1".setMigrationRate(...)}, the latter of which is not
valid SLiM code.}
}
\value{
Returns the placemarker if used outside
}
\description{
Create a templated variable inside a SLiM script. This function can be used directly inside a \code{slim_block} function call,
to generate a placemarker that can be replaced with different values dynamically using \code{\link{slim_script_render}}.
}
\details{
Note that this function is only designed to be used inside a \code{\link{slim_block}} function call. If run in any other
situation, it won't really do anything, just returning a reference to the placemarker that would have been inserted if run in
its correct context.
}
