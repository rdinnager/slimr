% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{uniqueMutationsOfType}
\alias{uniqueMutationsOfType}
\alias{Individual$uniqueMutationsOfType}
\alias{.I$uniqueMutationsOfType}
\title{SLiM method uniqueMutationsOfType}
\usage{
uniqueMutationsOfType(mutType)
}
\arguments{
\item{mutType}{An object of type integer or MutationType object. Must be of
length 1 (a singleton). See details for description.}
}
\value{
An object of type Mutation object.
}
\description{
Documentation for SLiM function \code{uniqueMutationsOfType}, which is a method
of the SLiM class \code{\link{Individual}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.
}
\details{
Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=546}{SLiM manual: page 546}.

Returns an object vector of all the mutations that are of the type
specified by mutType, out of all of the mutations in the individual. Mutations
present in both genomes will occur only once in the result of this method,
and the mutations will be given in sorted order by position, so this method
is similar to sortBy(unique(individual.genomes.mutationsOfType(mutType)),
"position"). It is not identical to that call, only because if multiple
mutations exist at the exact same position, they may be sorted differently
by this method than they would be by sortBy(). If you just need a count of
the matching Mutation objects, rather than a vector of the matches, use -
countOfMutationsOfType(). This method is provided for speed; it is much
faster than the corresponding Eidos code. Indeed, it is faster than just
individual.genomes.mutationsOfType(mutType), and gives uniquing and sorting
on top of that, so it is advantageous unless duplicate entries for homozygous
mutations are actually needed.
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
\code{\link{relatedness}()},
\code{\link{setSpatialPosition}()},
\code{\link{sumOfMutationsOfType}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{Individual}
