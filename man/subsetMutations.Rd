% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{subsetMutations}
\alias{subsetMutations}
\alias{SLiMSim$subsetMutations}
\alias{.SS$subsetMutations}
\title{SLiM method subsetMutations}
\usage{
subsetMutations(exclude, mutType, position, nucleotide, tag, id)
}
\arguments{
\item{exclude}{An object of type null or Mutation object. Must be of length 1 (a
singleton). The default value is \code{NULL}. See details for description.}

\item{mutType}{An object of type null or integer or MutationType object. Must
be of length 1 (a singleton). The default value is \code{NULL}. See details for
description.}

\item{position}{An object of type null or integer. Must be of length 1 (a
singleton). The default value is \code{NULL}. See details for description.}

\item{nucleotide}{An object of type null or integer or string. Must be of length
1 (a singleton). The default value is \code{NULL}. See details for description.}

\item{tag}{An object of type null or integer. Must be of length 1 (a singleton).
The default value is \code{NULL}. See details for description.}

\item{id}{An object of type null or integer. Must be of length 1 (a singleton).
The default value is \code{NULL}. See details for description.}
}
\value{
An object of type Mutation object.
}
\description{
Documentation for SLiM function \code{subsetMutations}, which is a method of the
SLiM class \code{\link{SLiMSim}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.
}
\details{
Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=574}{SLiM manual: page 574}.

Returns a vector of mutations subset from the list of all active
mutations in the simulation (as would be provided by the mutations property).
The parameters specify constraints upon the subset of mutations that will
be returned. Parameter exclude, if non-NULL, may specify a specific mutation
that should not be included (typically the focal mutation in some operation).
Parameter mutType, if non- NULL, may specify a mutation type for the mutations
to be returned (as either a MutationType object or an integer identifier).
Parameter position, if non-NULL, may specify a base position for the mutations
to be returned. Parameter nucleotide, if non-NULL, may specify a nucleotide
for the mutations to be returned (either as a string, "A" / "C" / "G" / "T",
or as an integer, 0 / 1 / 2 / 3 respectively). Parameter tag, if non-NULL, may
specify a tag value for the mutations to be returned. Parameter id, if non-
NULL, may specify a required value for the id property of the mutations to be
returned. This method is shorthand for getting the mutations property of the
subpopulation, and then using operator [] to select only mutations with the
desired properties; besides being much simpler than the equivalent Eidos code,
it is also much faster. Note that if you only need to select on mutation type,
the mutationsOfType() method will be even faster.
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
Other SLiMSim: 
\code{\link{SLiMSim}},
\code{\link{addSubpopSplit}()},
\code{\link{addSubpop}()},
\code{\link{countOfMutationsOfType}()},
\code{\link{createLogFile}()},
\code{\link{deregisterScriptBlock}()},
\code{\link{mutationCounts}()},
\code{\link{mutationFrequencies}()},
\code{\link{mutationsOfType}()},
\code{\link{outputFixedMutations}()},
\code{\link{outputFull}()},
\code{\link{outputMutations}()},
\code{\link{outputUsage}()},
\code{\link{readFromPopulationFile}()},
\code{\link{recalculateFitness}()},
\code{\link{registerEarlyEvent}()},
\code{\link{registerFitnessCallback}()},
\code{\link{registerInteractionCallback}()},
\code{\link{registerLateEvent}()},
\code{\link{registerMateChoiceCallback}()},
\code{\link{registerModifyChildCallback}()},
\code{\link{registerMutationCallback}()},
\code{\link{registerRecombinationCallback}()},
\code{\link{registerReproductionCallback}()},
\code{\link{rescheduleScriptBlock}()},
\code{\link{simulationFinished}()},
\code{\link{treeSeqCoalesced}()},
\code{\link{treeSeqOutput}()},
\code{\link{treeSeqRememberIndividuals}()},
\code{\link{treeSeqSimplify}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{SLiMSim}
