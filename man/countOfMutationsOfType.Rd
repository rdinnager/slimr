% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\name{countOfMutationsOfType}
\alias{countOfMutationsOfType}
\alias{Genome$countOfMutationsOfType}
\alias{.G$countOfMutationsOfType}
\alias{Individual$countOfMutationsOfType}
\alias{.I$countOfMutationsOfType}
\alias{SLiMSim$countOfMutationsOfType}
\alias{.SS$countOfMutationsOfType}
\title{SLiM method countOfMutationsOfType}
\usage{
countOfMutationsOfType(mutType)

countOfMutationsOfType(mutType)

countOfMutationsOfType(mutType)
}
\arguments{
\item{mutType}{An object of type integer or MutationType object. Must be of
length 1 (a singleton). See details for description.}
}
\value{
An object of type integer. Return will be of length 1 (a singleton)

An object of type integer. Return will be of length 1 (a singleton)

An object of type integer. Return will be of length 1 (a singleton)
}
\description{
Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
of the SLiM class \code{\link{Genome}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.

Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
of the SLiM class \code{\link{Individual}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.

Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
of the SLiM class \code{\link{SLiMSim}}.
Note that the R function is a stub, it does not do anything in R (except bring
up this documentation). It will only do
anything useful when used inside a \code{\link{slim_block}} function further
nested in a \code{\link{slim_script}}
function call, where it will be translated into valid SLiM code as part of a
full SLiM script.
}
\details{
Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=536}{SLiM manual: page 536}.

Returns the number of mutations that are of the type specified by
mutType, out of all of the mutations in the genome. If you need a vector of the
matching Mutation objects, rather than just a count, use -mutationsOfType().
This method is provided for speed; it is much faster than the corresponding
Eidos code.

Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=545}{SLiM manual: page 545}.

Returns the number of mutations that are of the type specified by
mutType, out of all of the mutations in the individual (in both of its genomes;
a mutation that is present in both genomes counts twice). If you need a vector
of the matching Mutation objects, rather than just a count, you should probably
use uniqueMutationsOfType(). This method is provided for speed; it is much
faster than the corresponding Eidos code.

Documentation for this function can be found in the official \href{http://
benhaller.com/slim/SLiM_Manual.pdf#page=566}{SLiM manual: page 566}.

Returns the number of mutations that are of the type specified
by mutType, out of all of the mutations that are currently active in the
simulation. If you need a vector of the matching Mutation objects, rather than
just a count, use -mutationsOfType(). This method is often used to determine
whether an introduced mutation is still active (as opposed to being either
lost or fixed). This method is provided for speed; it is much faster than the
corresponding Eidos code.
}
\section{Copyright}{

This is documentation for a function in the SLiM software, and has been
reproduced from the official manual,
which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
documentation is
Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
about SLiM can be found
on the official website: \url{https://messerlab.org/slim/}


This is documentation for a function in the SLiM software, and has been
reproduced from the official manual,
which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
documentation is
Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
about SLiM can be found
on the official website: \url{https://messerlab.org/slim/}


This is documentation for a function in the SLiM software, and has been
reproduced from the official manual,
which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
documentation is
Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
about SLiM can be found
on the official website: \url{https://messerlab.org/slim/}
}

\seealso{
Other Genome: 
\code{\link{Genome}},
\code{\link{addMutations}()},
\code{\link{addNewDrawnMutation}()},
\code{\link{addNewMutation}()},
\code{\link{containsMarkerMutation}()},
\code{\link{containsMutations}()},
\code{\link{mutationCountsInGenomes}()},
\code{\link{mutationFrequenciesInGenomes}()},
\code{\link{mutationsOfType}()},
\code{\link{nucleotides}()},
\code{\link{outputMS}()},
\code{\link{outputVCF}()},
\code{\link{output}()},
\code{\link{positionsOfMutationsOfType}()},
\code{\link{readFromMS}()},
\code{\link{readFromVCF}()},
\code{\link{removeMutations}()},
\code{\link{sumOfMutationsOfType}()}

Other Individual: 
\code{\link{Individual}},
\code{\link{containsMutations}()},
\code{\link{relatedness}()},
\code{\link{setSpatialPosition}()},
\code{\link{sumOfMutationsOfType}()},
\code{\link{uniqueMutationsOfType}()}

Other SLiMSim: 
\code{\link{SLiMSim}},
\code{\link{addSubpopSplit}()},
\code{\link{addSubpop}()},
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
\code{\link{treeSeqRememberIndividuals}()},
\code{\link{treeSeqSimplify}()}
}
\author{
Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})

Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})

Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
(\email{messer@cornell.edu})
}
\concept{Genome}
\concept{Individual}
\concept{SLiMSim}
