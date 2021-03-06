% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{treeSeqSimplify}
\alias{treeSeqSimplify}
\alias{SLiMSim$treeSeqSimplify}
\alias{.SS$treeSeqSimplify}
\title{SLiM method treeSeqSimplify}
\usage{
treeSeqSimplify(void)
}
\arguments{
\item{void}{An object of type . See details for description.}
}
\value{
An object of type void.
}
\description{
Documentation for SLiM function \code{treeSeqSimplify}, which is a method of the
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
benhaller.com/slim/SLiM_Manual.pdf#page=576}{SLiM manual: page 576}.

Triggers an immediate simplification of the tree sequence recording
tables. This method may only be called if tree sequence recording has been
turned on with initializeTreeSeq(). A call to this method will free up memory
being used by entries that are no longer in the ancestral path of any individual
within the current sample (currently living individuals, in other words, plus
those explicitly added to the sample with treeSeqRememberIndividuals()), but it
can also take a significant amount of time. Typically calling this method is not
necessary; the automatic simplification performed occasionally by SLiM should be
sufficient for most models.
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
\code{\link{subsetMutations}()},
\code{\link{treeSeqCoalesced}()},
\code{\link{treeSeqOutput}()},
\code{\link{treeSeqRememberIndividuals}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{SLiMSim}
