% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{relatedness}
\alias{relatedness}
\alias{Individual$relatedness}
\alias{.I$relatedness}
\title{SLiM method relatedness}
\usage{
relatedness(individuals)
}
\arguments{
\item{individuals}{An object of type Individual object. See details for
description.}
}
\value{
An object of type float.
}
\description{
Documentation for SLiM function \code{relatedness}, which is a method of the
SLiM class \code{\link{Individual}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.
}
\details{
Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=545}{SLiM manual: page 545}.

Returns a vector containing the degrees of relatedness between the
receiver and each of the individuals in individuals. The relatedness between A
and B is always 1.0 if A and B are actually the same individual; this facility
works even if SLiM's optional pedigree tracking is turned off (in which case
all other relatedness values will be 0.0. Otherwise, if pedigree tracking is
turned on with initializeSLiMOptions(keepPedigrees=T), this method will use
the pedigree information described in section 24.6.1 to construct a relatedness
estimate. More specifically, if information about the grandparental generation
is available, then each grandparent shared by A and B contributes 0.125 towards
the total relatedness, for a maximum value of 0.5 with four shared grandparents.
If grandparental information is unavailable, then if parental information is
available it is used, with each parent shared by A and B contributing 0.25,
again for a maximum of 0.5. If even parental information is unavailable, then
the relatedness is assumed to be 0.0. Again, however, if A and B are the same
individual, the relatedness will be 1.0 in all cases. Note that this relatedness
is simply pedigree-based relatedness. This does not necessarily correspond
to genetic relatedness, because of the effects of factors like assortment and
recombination.
}
\section{Copyright}{

This is documentation for a function in the SLiM software, and has been
reproduced from the official manual,
which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
documentation is
Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
about SLiM can be found
on the official website: \url{https://messerlab.org/slim/}
}

\seealso{
Other Individual: 
\code{\link{Individual}},
\code{\link{containsMutations}()},
\code{\link{countOfMutationsOfType}()},
\code{\link{setSpatialPosition}()},
\code{\link{sumOfMutationsOfType}()},
\code{\link{uniqueMutationsOfType}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{Individual}
