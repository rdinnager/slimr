% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slimr_blocks.R
\name{slim_block_add_subpops}
\alias{slim_block_add_subpops}
\title{Generate a code block that just adds subpopulations to a SLiM simulation}
\usage{
slim_block_add_subpops(
  n_pop = 1,
  sizes,
  generation = 1,
  when = c("early", "late")
)
}
\arguments{
\item{n_pop}{Number of subpopulations to add}

\item{sizes}{Population sizes of subpopulations. Should have a length equal to \code{n_pop}, or
else a length of 1 (in which case it will be recycled to \code{n_pop})}

\item{generation}{The generation to add the subpopulations (default: 1)}

\item{when}{When to add the subpopulations ("early" or "late"). Default: "early"}
}
\value{
A \code{slimr_block} object
}
\description{
Generate a code block that just adds subpopulations to a SLiM simulation
}
\examples{
slim_block_add_subpops(2, 100)
}
