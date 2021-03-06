% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{outputSample}
\alias{outputSample}
\alias{Subpopulation$outputSample}
\alias{.P$outputSample}
\title{SLiM method outputSample}
\usage{
outputSample(sampleSize, replace, requestedSex, filePath, append)
}
\arguments{
\item{sampleSize}{An object of type integer. Must be of length 1 (a singleton).
See details for description.}

\item{replace}{An object of type logical. Must be of length 1 (a singleton). The
default value is \code{T}. See details for description.}

\item{requestedSex}{An object of type string. Must be of length 1 (a singleton).
The default value is \code{"*"}. See details for description.}

\item{filePath}{An object of type null or string. Must be of length 1 (a
singleton). The default value is \code{NULL}. See details for description.}

\item{append}{An object of type logical. Must be of length 1 (a singleton). The
default value is \code{F}. See details for description.}
}
\value{
An object of type void.
}
\description{
Documentation for SLiM function \code{outputSample}, which is a method of the
SLiM class \code{\link{Subpopulation}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.
}
\details{
Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=583}{SLiM manual: page 583}.

Output a random sample from the subpopulation in SLiM's native format
(see section 26.2.1 for output format details). A sample of genomes (not entire
individuals, note) of size sampleSize from the subpopulation will be output. The
sample may be done either with or without replacement, as specified by replace;
the default is to sample with replacement. A particular sex of individuals may
be requested for the sample, for simulations in which sex is enabled, by passing
"M" or "F" for requestedSex; passing "*", the default, indicates that genomes
from individuals should be selected randomly, without respect to sex. If the
sampling options provided by this method are not adequate, see the output()
method of Genome for a more flexible low-level option. If the optional parameter
filePath is NULL (the default), output will be sent to Eidos's output stream
(see section 4.2.1). Otherwise, output will be sent to the filesystem path
specified by filePath, overwriting that file if append if F, or appending to the
end of it if append is T. See outputMSSample() and outputVCFSample() for other
output formats. Output is generally done in a late() event, so that the output
reflects the state of the simulation at the end of a generation.
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
Other Subpopulation: 
\code{\link{Subpopulation}},
\code{\link{addCloned}()},
\code{\link{addCrossed}()},
\code{\link{addEmpty}()},
\code{\link{addRecombinant}()},
\code{\link{addSelfed}()},
\code{\link{cachedFitness}()},
\code{\link{configureDisplay}()},
\code{\link{defineSpatialMap}()},
\code{\link{outputMSSample}()},
\code{\link{outputVCFSample}()},
\code{\link{pointInBounds}()},
\code{\link{pointPeriodic}()},
\code{\link{pointReflected}()},
\code{\link{pointStopped}()},
\code{\link{pointUniform}()},
\code{\link{removeSubpopulation}()},
\code{\link{sampleIndividuals}()},
\code{\link{setCloningRate}()},
\code{\link{setMigrationRates}()},
\code{\link{setSelfingRate}()},
\code{\link{setSexRatio}()},
\code{\link{setSpatialBounds}()},
\code{\link{setSubpopulationSize}()},
\code{\link{spatialMapColor}()},
\code{\link{spatialMapValue}()},
\code{\link{subsetIndividuals}()},
\code{\link{takeMigrants}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{Subpopulation}
