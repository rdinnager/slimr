% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_lang.R
\docType{data}
\name{Chromosome}
\alias{Chromosome}
\alias{.c}
\title{Chromosome}
\format{
An object of class \code{list} of length 40.
}
\usage{
Chromosome
}
\description{
Documentation for Chromosome class from SLiM
}
\details{
This class represents the layout and properties of the chromosome being
simulated. The
chromosome currently being simulated is available through the sim.chromosome
global. Section
1.5.4 presents an overview of the conceptual role of this class.
This class has the following methods (functions):
\itemize{
\item{\code{\link{ancestralNucleotides}}}
\item{\code{\link{drawBreakpoints}}}
\item{\code{\link{setAncestralNucleotides}}}
\item{\code{\link{setGeneConversion}}}
\item{\code{\link{setHotspotMap}}}
\item{\code{\link{setMutationRate}}}
\item{\code{\link{setRecombinationRate}}}
}
This class has the following properties:
\describe{
\item{colorSubstitution}{A property of type string. It is of length one (a
singleton). This property is a variable, so it is modifiable. \strong{Property
Description:} The color used to display substitutions in SLiMgui when both
mutations and substitutions are being displayed in the chromosome view.
Outside of SLiMgui, this property still exists, but is not used by SLiM.
Colors may be specified by name, or with hexadecimal RGB values of the form
"#RRGGBB" (see the Eidos manual). If colorSubstitution is the empty string,
"", SLiMgui will defer to the color scheme of each MutationType, just as
it does when only substitutions are being displayed. The default, "3333FF",
causes all substitutions to be shown as dark blue when displayed in conjunction
with mutations, to prevent the view from becoming too noisy. Note that when
substitutions are displayed without mutations also being displayed, this
value is ignored by SLiMgui and the substitutions use the color scheme of each
MutationType. }
\item{geneConversionEnabled}{A property of type logical. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} When gene conversion has been enabled by calling
initializeGeneConversion(), switching to the DSB recombination model, this
property is T; otherwise, when using the crossover breakpoints model, it is F. }
\item{geneConversionGCBias}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The gene conversion bias coefficient, which
expresses a bias in the resolution of heteroduplex mismatches in complex
gene conversion tracts. When gene conversion has not been enabled by calling
initializeGeneConversion(), this property will be unavailable. }
\item{geneConversionNonCrossoverFraction}{A property of type float. It is of
length one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The fraction of double-stranded breaks that
result in non-crossover events. When gene conversion has not been enabled by
calling initializeGeneConversion(), this property will be unavailable. }
\item{geneConversionMeanLength}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The mean length of a gene conversion tract
(in base positions). When gene conversion has not been enabled by calling
initializeGeneConversion(), this property will be unavailable. }
\item{geneConversionSimpleConversionFraction}{A property of type float. It is of
length one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The fraction of gene conversion tracts that
are "simple" (i.e., not involving resolution of heteroduplex mismatches);
the remainder will be "complex". When gene conversion has not been enabled by
calling initializeGeneConversion(), this property will be unavailable. }
\item{genomicElements}{A property of type GenomicElement object. This property
is a constant, so it is not modifiable. \strong{Property Description:} All of
the GenomicElement objects that comprise the chromosome. }
\item{hotspotEndPositions}{A property of type integer. This property is a
constant, so it is not modifiable. \strong{Property Description:} The end
positions for hotspot map regions along the chromosome. Each hotspot map
region is assumed to start at the position following the end of the previous
hotspot map region; in other words, the regions are assumed to be contiguous.
When using sex-specific hotspot maps, this property will unavailable; see
hotspotEndPositionsF and hotspotEndPositionsM. }
\item{hotspotEndPositionsF}{A property of type integer. This property is a
constant, so it is not modifiable. \strong{Property Description:} The end
positions for hotspot map regions for females, when using sex-specific hotspot
maps; unavailable otherwise. See hotspotEndPositions for further explanation. }
\item{hotspotEndPositionsM}{A property of type integer. This property is a
constant, so it is not modifiable. \strong{Property Description:} The end
positions for hotspot map regions for males, when using sex-specific hotspot
maps; unavailable otherwise. See hotspotEndPositions for further explanation. }
\item{hotspotMultipliers}{A property of type float. This property is a constant,
so it is not modifiable. \strong{Property Description:} The hotspot multiplier
for each of the hotspot map regions specified by hotspotEndPositions. When
using sex-specific hotspot maps, this property will be unavailable; see
hotspotMultipliersF and hotspotMultipliersM. }
\item{hotspotMultipliersF}{A property of type float. This property is
a constant, so it is not modifiable. \strong{Property Description:}
The hotspot multiplier for each of the hotspot map regions specified by
hotspotEndPositionsF, when using sex-specific hotspot maps; unavailable
otherwise. }
\item{hotspotMultipliersM}{A property of type float. This property is
a constant, so it is not modifiable. \strong{Property Description:}
The hotspot multiplier for each of the hotspot map regions specified by
hotspotEndPositionsM, when using sex-specific hotspot maps; unavailable
otherwise. }
\item{lastPosition}{A property of type integer. It is of length one
(a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The last valid position in the chromosome;
its length, essentially. Note that the chromosome length is determined by
the maximum of the end of the last genomic element, the end of the last
recombination region, and the end of the last mutation map region (or hotspot
map region). }
\item{mutationEndPositions}{A property of type integer. This property is a
constant, so it is not modifiable. \strong{Property Description:} The end
positions for mutation rate regions along the chromosome. Each mutation rate
region is assumed to start at the position following the end of the previous
mutation rate region; in other words, the regions are assumed to be contiguous.
When using sex-specific mutation rate maps, this property will unavailable; see
mutationEndPositionsF and mutationEndPositionsM. This property is unavailable in
nucleotide-based models. }
\item{mutationEndPositionsF}{A property of type integer. This property is
a constant, so it is not modifiable. \strong{Property Description:} The end
positions for mutation rate regions for females, when using sex-specific
mutation rate maps; unavailable otherwise. See mutationEndPositions for further
explanation. This property is unavailable in nucleotide-based models. }
\item{mutationEndPositionsM}{A property of type integer. This property is
a constant, so it is not modifiable. \strong{Property Description:} The
end positions for mutation rate regions for males, when using sex-specific
mutation rate maps; unavailable otherwise. See mutationEndPositions for further
explanation. This property is unavailable in nucleotide-based models. }
\item{mutationRates}{A property of type float. This property is a constant,
so it is not modifiable. \strong{Property Description:} The mutation rate
for each of the mutation rate regions specified by mutationEndPositions. When
using sex-specific mutation rate maps, this property will be unavailable; see
mutationRatesF and mutationRatesM. This property is unavailable in nucleotide-
based models. }
\item{mutationRatesF}{A property of type float. This property is a constant, so
it is not modifiable. \strong{Property Description:} The mutation rate for each
of the mutation rate regions specified by mutationEndPositionsF, when using sex-
specific mutation rate maps; unavailable otherwise. This property is unavailable
in nucleotide-based models. }
\item{mutationRatesM}{A property of type float. This property is a constant, so
it is not modifiable. \strong{Property Description:} The mutation rate for each
of the mutation rate regions specified by mutationEndPositionsM, when using sex-
specific mutation rate maps; unavailable otherwise. This property is unavailable
in nucleotide-based models. }
\item{overallMutationRate}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall mutation rate across the whole
chromosome determining the overall number of mutation events that will occur
anywhere in the chromosome, as calculated from the individual mutation ranges
and rates as well as the coverage of the chromosome by genomic elements (since
mutations are only generated within genomic elements, regardless of the mutation
rate map). When using sexspecific mutation rate maps, this property will
unavailable; see overallMutationRateF and overallMutationRateM. This property is
unavailable in nucleotide-based models. }
\item{overallMutationRateF}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall mutation rate for females, when using
sex-specific mutation rate maps; unavailable otherwise. See overallMutationRate
for further explanation. This property is unavailable in nucleotide-based
models. }
\item{overallMutationRateM}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall mutation rate for males, when using
sex-specific mutation rate maps; unavailable otherwise. See overallMutationRate
for further explanation. This property is unavailable in nucleotide-based
models. }
\item{overallRecombinationRate}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall recombination rate across the
whole chromosome determining the overall number of recombination events that
will occur anywhere in the chromosome, as calculated from the individual
recombination ranges and rates. When using sex-specific recombination
maps, this property will unavailable; see overallRecombinationRateF and
overallRecombinationRateM. }
\item{overallRecombinationRateF}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall recombination rate for females,
when using sex-specific recombination maps; unavailable otherwise. See
overallRecombinationRate for further explanation. }
\item{overallRecombinationRateM}{A property of type float. It is of length
one (a singleton). This property is a constant, so it is not modifiable.
\strong{Property Description:} The overall recombination rate for males,
when using sex-specific recombination maps; unavailable otherwise. See
overallRecombinationRate for further explanation. }
\item{recombinationEndPositions}{A property of type integer. This property is
a constant, so it is not modifiable. \strong{Property Description:} The end
positions for recombination regions along the chromosome. Each recombination
region is assumed to start at the position following the end of the previous
recombination region; in other words, the regions are assumed to be contiguous.
When using sex-specific recombination maps, this property will unavailable; see
recombinationEndPositionsF and recombinationEndPositionsM. }
\item{recombinationEndPositionsF}{A property of type integer. This property
is a constant, so it is not modifiable. \strong{Property Description:} The
end positions for recombination regions for females, when using sex-specific
recombination maps; unavailable otherwise. See recombinationEndPositions for
further explanation. }
\item{recombinationEndPositionsM}{A property of type integer. This property
is a constant, so it is not modifiable. \strong{Property Description:} The
end positions for recombination regions for males, when using sex-specific
recombination maps; unavailable otherwise. See recombinationEndPositions for
further explanation. }
\item{recombinationRates}{A property of type float. This property is a constant,
so it is not modifiable. \strong{Property Description:} The recombination rate
for each of the recombination regions specified by recombinationEndPositions.
When using sex-specific recombination maps, this property will unavailable; see
recombinationRatesF and recombinationRatesM. }
\item{recombinationRatesF}{A property of type float. This property is
a constant, so it is not modifiable. \strong{Property Description:} The
recombination rate for each of the recombination regions specified by
recombinationEndPositionsF, when using sex-specific recombination maps;
unavailable otherwise. }
\item{recombinationRatesM}{A property of type float. This property is
a constant, so it is not modifiable. \strong{Property Description:} The
recombination rate for each of the recombination regions specified by
recombinationEndPositionsM, when using sex-specific recombination maps;
unavailable otherwise. }
\item{tag}{A property of type integer. It is of length one (a singleton). This
property is a variable, so it is modifiable. \strong{Property Description:}
A user-defined integer value. The value of tag is initially undefined, and
it is an error to try to read it; if you wish it to have a defined value, you
must arrange that yourself by explicitly setting its value prior to using it
elsewhere in your code. The value of tag is not used by SLiM; it is free for you
to use.}

}
}
\seealso{
Other Chromosome: 
\code{\link{ancestralNucleotides}()},
\code{\link{drawBreakpoints}()},
\code{\link{setAncestralNucleotides}()},
\code{\link{setGeneConversion}()},
\code{\link{setHotspotMap}()},
\code{\link{setMutationRate}()},
\code{\link{setRecombinationRate}()}
}
\concept{Chromosome}
\keyword{datasets}
