#'SLiM method initializeAncestralNucleotides
#'
#'Documentation for SLiM function \code{initializeAncestralNucleotides}, which is
#'a method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases
#'Initialize$initializeAncestralNucleotides .Init$initializeAncestralNucleotides
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details This function, which may be called only in nucleotide-based models
#'(see section 1.8), supplies an ancestral nucleotide sequence for the model.
#'The sequence parameter may be an integer vector providing nucleotide values
#'(A=0, C=1, G=2, T=3), or a string vector providing single-character nucleotides
#'("A", "C", "G", "T"), or a singleton string providing the sequence as one
#'string ("ACGT..."), or a singleton string providing the filesystem path of a
#'FASTA file which will be read in to provide the sequence (if the file contains
#'than one sequence, the first sequence will be used). Only A/C/G/T nucleotide
#'values may be provided; other symbols, such as those for amino acids, gaps, or
#'nucleotides of uncertain identity, are not allowed. The two semantic meanings of
#'sequence that involve a singleton string value are distinguished heuristically;
#'a singleton string that contains only the letters ACGT will be assumed to be a
#'nucleotide sequence rather than a filename. The length of the ancestral sequence
#'is returned. A utility function, randomNucleotides(), is provided by SLiM to
#'assist in generating simple random nucleotide sequences; see section 23.15.1.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeAncestralNucleotides <- function(sequence) {
 .Init$initializeAncestralNucleotides(sequence)
}

#'SLiM method initializeGeneConversion
#'
#'Documentation for SLiM function \code{initializeGeneConversion}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param nonCrossoverFraction An object of type numeric or numeric or numeric or
#'numeric. Must be of length 1 (a singleton). See details for description.
#'@param meanLength An object of type numeric or numeric or numeric or numeric.
#'Must be of length 1 (a singleton). See details for description.
#'@param simpleConversionFraction An object of type numeric or numeric or numeric
#'or numeric. Must be of length 1 (a singleton). See details for description.
#'@param bias An object of type numeric or numeric or numeric or numeric. Must
#'be of length 1 (a singleton). The default value is \code{0}. See details for
#'description.
#'
#'@aliases Initialize$initializeGeneConversion .Init$initializeGeneConversion
#'@return An object of type void.
#'@details Calling this function switches the recombination model from a "simple
#'crossover” model to a "double-stranded break (DSB)” model, and configures
#'the details of the gene conversion tracts that will therefore be modeled (see
#'section 1.5.6 for discussion of these models). The fraction of DSBs that will
#'be modeled as non-crossover events is given by nonCrossoverFraction. The mean
#'length of gene conversion tracts (whether associated with crossover or non-
#'crossover events) is given by meanLength; the actual extent of a gene conversion
#'tract will be the sum of two independent draws from a geometric distribution
#'with mean meanLength/2. The fraction of gene conversion tracts that are modeled
#'as "simple” is given by simpleConversionFraction; the remainder will be modeled
#'as "complex”, involving repair of heteroduplex mismatches. Finally, the GC bias
#'during heteroduplex mismatch repair is given by bias, with the default of 0.0
#'indicating no bias, 1.0 indicating an absolute preference for G/C mutations
#'over A/T mutations, and -1.0 indicating an absolute preference for A/T mutations
#'over G/C mutations. A non-zero bias may only be set in nucleotide-based models
#'(see section 1.8). This function, and the way that gene conversion is modeled,
#'fundamentally changed in SLiM 3.3; see section 1.5.6 for discussion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeGeneConversion <- function(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias) {
 .Init$initializeGeneConversion(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias)
}

#'SLiM method initializeGenomicElement
#'
#'Documentation for SLiM function \code{initializeGenomicElement}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param genomicElementType An object of type integer or GenomicElementType
#'object. See details for description.
#'@param start An object of type integer. See details for description.
#'@param end An object of type integer. See details for description.
#'
#'@aliases Initialize$initializeGenomicElement .Init$initializeGenomicElement
#'@return An object of type GenomicElement object.
#'@details Add a genomic element to the chromosome at initialization time.
#'The start and end parameters give the first and last base positions to be
#'spanned by the new genomic element. The new element will be based upon the
#'genomic element type identified by genomicElementType, which can be either an
#'integer, representing the ID of the desired element type, or an object of type
#'GenomicElementType specified directly. Beginning in SLiM 3.3, this function is
#'vectorized: the genomicElementType, start, and end parameters do not have to be
#'singletons. In particular, start and end may be of any length, but must be equal
#'in length; each start/end element pair will generate one new genomic element
#'spanning the given base positions. In this case, genomicElementType may still
#'be a singleton, providing the genomic element type to be used for all of the
#'new genomic elements, or it may be equal in length to start and end, providing
#'an independent genomic element type for each new element. When adding a large
#'number of genomic elements, it will be much faster to add them in order of
#'ascending position with a vectorized call. The return value provides the genomic
#'element(s) created by the call, in the order in which they were specified in the
#'parameters to initializeGenomicElement().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeGenomicElement <- function(genomicElementType, start, end) {
 .Init$initializeGenomicElement(genomicElementType, start, end)
}

#'SLiM method initializeGenomicElementType
#'
#'Documentation for SLiM function \code{initializeGenomicElementType}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param mutationTypes An object of type integer or MutationType object. See
#'details for description.
#'@param proportions An object of type numeric. See details for description.
#'@param mutationMatrix An object of type null or float. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases
#'Initialize$initializeGenomicElementType .Init$initializeGenomicElementType
#'@return An object of type GenomicElementType object. Return will be of length 1
#'(a singleton)
#'@details Add a genomic element type at initialization time. The id must
#'not already be used for any genomic element type in the simulation. The
#'mutationTypes vector identifies the mutation types used by the genomic element,
#'and the proportions vector should be of equal length, specifying the relative
#'proportion of mutations that will be drawn from the corresponding mutation type
#'(proportions do not need to add up to one; they are interpreted relatively).
#'The id parameter may be either an integer giving the ID of the new genomic
#'element type, or a string giving the name of the new genomic element type (such
#'as "g5" to specify an ID of 5). The mutationTypes parameter may be either an
#'integer vector representing the IDs of the desired mutation types, or an object
#'vector of MutationType elements specified directly. The global symbol for
#'the new genomic element type is immediately available; the return value also
#'provides the new object. The mutationMatrix parameter is NULL by default, and
#'in non-nucleotide-based models it must be NULL. In nucleotide-based models, on
#'the other hand, it must be non-NULL, and therefore must be supplied. In that
#'case, mutationMatrix should take one of two standard forms. For sequence-based
#'mutation rates that depend upon only the single nucleotide at a mutation site,
#'mutationMatrix should be a 4×4 float matrix, specifying mutation rates for an
#'existing nucleotide state (rows from 0– 3 representing A/C/G/T) to each of the
#'four possible derived nucleotide states (columns, with the same meaning): The
#'mutation rates in this matrix are absolute rates, per nucleotide per generation;
#'they will be used by SLiM directly unless they are multiplied by a factor from
#'the hotspot map (see initializeHotspotMap()). Rates in mutationMatrix that
#'involve the mutation of a nucleotide to itself (A to A, C to C, etc.) are not
#'used by SLiM and must be 0.0 by convention (shown above with asterisks). It
#'is important to note that the order of the rows and columns used in SLiM, A/
#'C/G/T, is not a universal convention; other sources will present substitution-
#'rate/transition-rate matrices using different conventions, and so care must be
#'taken when importing such matrices into SLiM. For sequence-based mutation rates
#'that depend upon the trinucleotide sequence centered upon a mutation site (the
#'adjacent bases to the left and right, in other words, as well as the mutating
#'nucleotide itself), mutationMatrix should be a 64×4 float matrix, specifying
#'mutation rates for the central nucleotide of an existing trinucleotide sequence
#'(rows from 0–63, representing codons as described in the documentation for
#'the ancestralNucleotides() method of Chromosome) to each of the four possible
#'derived nucleotide states (columns from 0–3 for A/C/G/T as before): Note that
#'in every case it is the central nucleotide of the trinucleotide sequence that
#'is mutating, but rates can be specified independently based upon the nucleotides
#'in the first and third positions as well, with this type of mutation matrix.
#'Several helper functions are defined to construct common types of mutation
#'matrices, such as mmJukesCantor() to create a mutation matrix for a Jukes–
#'Cantor model; see section 23.15.1. See chapter 18 for practical examples of
#'mutation matrices, and section 21.2.3 for further discussion of the mutational
#'paradigm in nucleotide-based models. * PA→C PA→G PA→T PC→A * PC→G PC→T
#'PG→A PG→C * PG→T PT→A PT→C PT→G * * PAAA→ACA PAAA→AGA PAAA→ATA * PAAC→ACC
#'PAAC→AGC PAAC→ATC * PAAG→ACG PAAG→AGG PAAG→ATG * PAAT→ACT PAAT→AGT PAAT→ATT
#'PACA→AAA * PACA→AGA PACA→ATA PACC→AAC * PACC→AGC PACC→ATC PACG→AAG * PACG→AGG
#'PACG→ATG . . . . . . . . . . . . PTTC→TAC PTTC→TCC PTTC→TGC * PTTG→TAG PTTG→TCG
#'PTTG→TGG * PTTT→TAT PTTT→TCT PTTT→TGT *
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeGenomicElementType <- function(id, mutationTypes, proportions,
mutationMatrix) {
 .Init$initializeGenomicElementType(id, mutationTypes, proportions,
mutationMatrix)
}

#'SLiM method initializeHotspotMap
#'
#'Documentation for SLiM function \code{initializeHotspotMap}, which is a method
#'of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param multipliers An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Initialize$initializeHotspotMap .Init$initializeHotspotMap
#'@return An object of type void.
#'@details In nucleotide-based models, set the mutation rate multiplier along the
#'chromosome. Nucleotidebased models define sequence-based mutation rates that
#'are set up with the mutationMatrix parameter to initializeGenomicElementType().
#'If no hotspot map is specified by calling initializeHotspotMap(), a hotspot
#'map with a multiplier of 1.0 across the whole chromosome is assumed (and so the
#'sequence-based rates are the absolute mutation rates used by SLiM). A hotspot
#'map modifies the sequence-based rates by scaling them up in some regions,
#'with multipliers greater than 1.0 (representing mutational hot spots), and/or
#'scaling them down in some regions, with multipliers less than 1.0 (representing
#'mutational cold spots). There are two ways to call this function. If the
#'optional ends parameter is NULL (the default), then multipliers must be a
#'singleton value that specifies a single multiplier to be used along the entire
#'chromosome (typically 1.0, but not required to be). If, on the other hand, ends
#'is supplied, then multipliers and ends must be the same length, and the values
#'in ends must be specified in ascending order. In that case, multipliers and ends
#'taken together specify the multipliers to be used along successive contiguous
#'stretches of the chromosome, from beginning to end; the last position specified
#'in ends should extend to the end of the chromosome (i.e. at least to the end of
#'the last genomic element, if not further). For example, if the following call is
#'made: initializeHotspotMap(c(1.0, 1.2), c(5000, 9999)); then the result is that
#'the mutation rate multiplier for bases 0...5000 (inclusive) will be 1.0 (and
#'so the specified sequence-based mutation rates will be used verbatim), and the
#'multiplier for bases 5001...9999 (inclusive) will be 1.2 (and so the sequence-
#'based mutation rates will be multiplied by 1.2 within the region). Note that
#'mutations are generated by SLiM only within genomic elements, regardless of the
#'hotspot map. In effect, the hotspot map given is intersected with the coverage
#'area of the genomic elements defined; areas outside of any genomic element are
#'given a multiplier of zero. There is no harm in supplying a hotspot map that
#'specifies multipliers for areas outside of the genomic elements defined; the
#'excess information is simply not used. If the optional sex parameter is "*" (the
#'default), then the supplied hotspot map will be used for both sexes (which is
#'the only option for hermaphroditic simulations). In sexual simulations sex may
#'be "M" or "F" instead, in which case the supplied hotspot map is used only for
#'that sex (i.e., when generating a gamete from a parent of that sex). In this
#'case, two calls must be made to initializeHotspotMap(), one for each sex, even
#'if a multiplier of 1.0 is desired for the other sex; no default hotspot map is
#'supplied.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeHotspotMap <- function(multipliers, ends, sex) {
 .Init$initializeHotspotMap(multipliers, ends, sex)
}

#'SLiM method initializeInteractionType
#'
#'Documentation for SLiM function \code{initializeInteractionType}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param spatiality An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param reciprocal An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param maxDistance An object of type numeric. Must be of length 1 (a singleton).
#'The default value is \code{INF}. See details for description.
#'@param sexSegregation An object of type string. Must be of length 1 (a
#'singleton). The default value is \code{"**"}. See details for description.
#'
#'@aliases Initialize$initializeInteractionType .Init$initializeInteractionType
#'@return An object of type InteractionType object. Return will be of length 1 (a
#'singleton)
#'@details Add an interaction type at initialization time. The id must not
#'already be used for any interaction type in the simulation. The id parameter
#'may be either an integer giving the ID of the new interaction type, or a string
#'giving the name of the new interaction type (such as "i5" to specify an ID of
#'5). The spatiality may be "", for non-spatial interactions (i.e., interactions
#'that do not depend upon the distance between individuals); "x", "y", or "z"
#'for one-dimensional interactions; "xy", "xz", or "yz" for two-dimensional
#'interactions; or "xyz" for three-dimensional interactions. The dimensions
#'referenced by spatiality must have been previously defined as spatial dimensions
#'with initializeSLiMOptions(); if the simulation has dimensionality "xy", for
#'example, then interactions in the simulation may have spatiality "", "x",
#'"y", or "xy", but may not reference spatial dimension z and thus may not have
#'spatiality "xz", "yz", or "xyz". If no spatial dimensions have been configured,
#'only non-spatial interactions may be defined. The reciprocal flag may be T, in
#'which case the interaction is guaranteed by the user to be reciprocal: whatever
#'the interaction strength is for individual B upon individual A, it will be
#'equal (in magnitude and sign) for A upon B. This allows the InteractionType
#'to reduce the amount of computation necessary by up to a factor of two. If
#'reciprocal is F, the interaction is not guaranteed to be reciprocal and each
#'interaction will be computed independently. The built-in interaction formulas
#'are all reciprocal, but if you implement an interaction() callback (see section
#'24.6), you must consider whether the callback you have implemented preserves
#'reciprocality or not. For this reason, the default is reciprocal=F, so that
#'bugs are not inadvertently introduced by an invalid assumption of reciprocality.
#'See below for a note regarding reciprocality in sexual simulations when using
#'the sexSegregation flag. Note that even if an interaction is reciprocal,
#'it may occasionally be slightly faster for reciprocal to be set to F. This
#'is most likely when the amount of computation per interaction is very small
#'(particularly if no interaction() callbacks are involved), and when it is
#'unlikely that the reciprocal of a queried interaction will also be queried.
#'Even in such cases, however, the slowdown for reciprocal=T should be fairly
#'small. In most usage cases, setting reciprocal to T (when the interaction is
#'in fact reciprocal) will result in at least equal performance, if not better;
#'with a very slow interaction() callback, the performance can be as much as
#'double, making it generally worthwhile to use reciprocal=T when possible.
#'However, for maximal performance one might wish to time and compare runs with
#'reciprocality enabled and disabled (using the same random number seed). The
#'maxDistance parameter supplies the maximum distance over which interactions of
#'this type will be evaluated; at greater distances, the interaction strength is
#'considered to be zero (for efficiency). The default value of maxDistance, INF
#'(positive infinity), indicates that there is no maximum interaction distance;
#'note that this can make some interaction queries much less efficient, and is
#'therefore not recommended. In SLiM 3.1 and later, a warning will be issued if
#'a spatial interaction type is defined with no maximum distance to encourage
#'a maximum distance to be defined. The sexSegregation parameter governs the
#'applicability of the interaction to each sex, in sexual simulations. It does
#'not affect distance calculations in any way; it only modifies the way in which
#'interaction strengths are calculated. The default, "**", implies that the
#'interaction is felt by both sexes (the first character of the string value) and
#'is exerted by both sexes (the second character of the string value). Either or
#'both characters may be M or F instead; for example, "MM" would indicate a male-
#'male interaction, such as male-male competition, whereas "FM" would indicate an
#'interaction influencing only females that is influenced only by males, such as
#'male mating displays that influence female attraction. This parameter may be set
#'only to "**" unless sex has been enabled with initializeSex(). Note that a value
#'of sexSegregation other than "**" may imply some degree of non-reciprocality,
#'but it is not necessary to specify reciprocal to be F for this reason; SLiM will
#'take the sex-segregation of the interaction into account for you. The value of
#'reciprocal may therefore be interpreted as meaning: in those cases, if any, in
#'which A interacts with B and B interacts with A, is the interaction strength
#'guaranteed to be the same in both directions? By default, the interaction
#'strength is 1.0 for all interactions within maxDistance. Often it is desirable
#'to change the interaction function using setInteractionFunction(); modifying
#'interaction strengths can also be achieved with interaction() callbacks if
#'necessary (see section 24.6). In any case, interactions beyond maxDistance
#'always have a strength of 0.0, and the interaction strength of an individual
#'with itself is always 0.0, regardless of the interaction function or callbacks.
#'The global symbol for the new interaction type is immediately available; the
#'return value also provides the new object.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeInteractionType <- function(id, spatiality, reciprocal,
maxDistance, sexSegregation) {
 .Init$initializeInteractionType(id, spatiality, reciprocal, maxDistance,
sexSegregation)
}

#'SLiM method initializeMutationRate
#'
#'Documentation for SLiM function \code{initializeMutationRate}, which is a method
#'of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Initialize$initializeMutationRate .Init$initializeMutationRate
#'@return An object of type void.
#'@details Set the mutation rate per base position per generation along the
#'chromosome. To be precise, this mutation rate is the expected mean number of
#'mutations that will occur per base position per generation (per new offspring
#'genome being generated); note that this is different from how the recombination
#'rate is defined (see initializeRecombinationRate()). The number of mutations
#'that actually occurs at a given base position when generating an offspring
#'genome is, in effect, drawn from a Poisson distribution with that expected
#'mean (but under the hood SLiM uses a mathematically equivalent but much more
#'efficient strategy). It is possible for this Poisson draw to indicate that two
#'or more new mutations have arisen at the same base position, particularly when
#'the mutation rate is very high; in this case, the new mutations will be added to
#'the site one at a time, and as always the mutation stacking policy (see section
#'1.5.3) will be followed. There are two ways to call this function. If the
#'optional ends parameter is NULL (the default), then rates must be a singleton
#'value that specifies a single mutation rate to be used along the entire
#'chromosome. If, on the other hand, ends is supplied, then rates and ends must be
#'the same length, and the values in ends must be specified in ascending order. In
#'that case, rates and ends taken together specify the mutation rates to be used
#'along successive contiguous stretches of the chromosome, from beginning to end;
#'the last position specified in ends should extend to the end of the chromosome
#'(i.e. at least to the end of the last genomic element, if not further). For
#'example, if the following call is made: initializeMutationRate(c(1e-7, 2.5e-8),
#'c(5000, 9999)); then the result is that the mutation rate for bases 0...5000
#'(inclusive) will be 1e-7, and the rate for bases 5001...9999 (inclusive) will be
#'2.5e-8. Note that mutations are generated by SLiM only within genomic elements,
#'regardless of the mutation rate map. In effect, the mutation rate map given
#'is intersected with the coverage area of the genomic elements defined; areas
#'outside of any genomic element are given a mutation rate of zero. There is no
#'harm in supplying a mutation rate map that specifies rates for areas outside
#'of the genomic elements defined; that rate information is simply not used.
#'The overallMutationRate family of properties on Chromosome provide the overall
#'mutation rate after genomic element coverage has been taken into account, so it
#'will reflect the rate at which new mutations will actually be generated in the
#'simulation as configured. If the optional sex parameter is "*" (the default),
#'then the supplied mutation rate map will be used for both sexes (which is the
#'only option for hermaphroditic simulations). In sexual simulations sex may be
#'"M" or "F" instead, in which case the supplied mutation rate map is used only
#'for that sex (i.e., when generating a gamete from a parent of that sex). In this
#'case, two calls must be made to initializeMutationRate(), one for each sex, even
#'if a rate of zero is desired for the other sex; no default mutation rate map
#'is supplied. In nucleotide-based models, initializeMutationRate() may not be
#'called. Instead, the desired sequence-based mutation rate(s) should be expressed
#'in the mutationMatrix parameter to initializeGenomicElementType(). If variation
#'in the mutation rate along the chromosome is desired, initializeHotspotMap()
#'should be used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeMutationRate <- function(rates, ends, sex) {
 .Init$initializeMutationRate(rates, ends, sex)
}

#'SLiM method initializeMutationType
#'
#'Documentation for SLiM function \code{initializeMutationType}, which is a method
#'of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param dominanceCoeff An object of type numeric. Must be of length 1 (a
#'singleton). See details for description.
#'@param distributionType An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases Initialize$initializeMutationType .Init$initializeMutationType
#'@return An object of type MutationType object. Return will be of length 1 (a
#'singleton)
#'@details Add a mutation type at initialization time. The id must not already
#'be used for any mutation type in the simulation. The id parameter may be
#'either an integer giving the ID of the new mutation type, or a string giving
#'the name of the new mutation type (such as "m5" to specify an ID of 5). The
#'dominanceCoeff parameter supplies the dominance coefficient for the mutation
#'type; 0.0 produces no dominance, 1.0 complete dominance, and values greater
#'than 1.0, overdominance. The distributionType may be "f", in which case the
#'ellipsis ... should supply a numeric$ fixed selection coefficient; "e", in
#'which case the ellipsis should supply a numeric$ mean selection coefficient
#'for an exponential distribution; "g", in which case the ellipsis should supply
#'a numeric$ mean selection coefficient and a numeric$ alpha shape parameter for
#'a gamma distribution; "n", in which case the ellipsis should supply a numeric$
#'mean selection coefficient and a numeric$ sigma (standard deviation) parameter
#'for a normal distribution; "w", in which case the ellipsis should supply a
#'numeric$ λ scale parameter and a numeric$ k shape parameter for a Weibull
#'distribution; or "s", in which case the ellipsis should supply a string$ Eidos
#'script parameter. See section 23.9 for discussion of the various DFEs and their
#'uses. The global symbol for the new mutation type is immediately available; the
#'return value also provides the new object. Note that by default in WF models,
#'all mutations of a given mutation type will be converted into Substitution
#'objects when they reach fixation, for efficiency reasons. If you need to disable
#'this conversion, to keep mutations of a given type active in the simulation
#'even after they have fixed, you can do so by setting the convertToSubstitution
#'property of MutationType to T. In contrast, by default in nonWF models mutations
#'will not be converted into Substitution objects when they reach fixation;
#'convertToSubstitution is F by default in nonWF models. To enable conversion in
#'nonWF models for neutral mutation types with no indirect fitness effects, you
#'should therefore set convertToSubstitution to T. See sections 21.3, 22.5, and
#'23.9.1 for further discussion regarding the convertToSubstitution property.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeMutationType <- function(id, dominanceCoeff, distributionType, ...)
{
 .Init$initializeMutationType(id, dominanceCoeff, distributionType, ...)
}

#'SLiM method initializeMutationTypeNuc
#'
#'Documentation for SLiM function \code{initializeMutationTypeNuc}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param dominanceCoeff An object of type numeric. Must be of length 1 (a
#'singleton). See details for description.
#'@param distributionType An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases Initialize$initializeMutationTypeNuc .Init$initializeMutationTypeNuc
#'@return An object of type MutationType object. Return will be of length 1 (a
#'singleton)
#'@details Add a nucleotide-based mutation type at initialization time. This
#'function is identical to initializeMutationType() except that the new mutation
#'type will be nucleotide-based – in other words, mutations belonging to the
#'new mutation type will have an associated nucleotide. This function may be
#'called only in nucleotide-based models (as enabled by the nucleotideBased
#'parameter to initializeSLiMOptions()). Nucleotide-based mutations always use
#'a mutationStackGroup of -1 and a mutationStackPolicy of "l". This ensures that
#'a new nucleotide mutation always replaces any previously existing nucleotide
#'mutation at a given position, regardless of the mutation types of the nucleotide
#'mutations. These values are set automatically by initializeMutationTypeNuc(),
#'and may not be changed. See the documentation for initializeMutationType() for
#'all other discussion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeMutationTypeNuc <- function(id, dominanceCoeff,
distributionType, ...) {
 .Init$initializeMutationTypeNuc(id, dominanceCoeff, distributionType, ...)
}

#'SLiM method initializeRecombinationRate
#'
#'Documentation for SLiM function \code{initializeRecombinationRate}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases
#'Initialize$initializeRecombinationRate .Init$initializeRecombinationRate
#'@return An object of type void.
#'@details Set the recombination rate per base position per generation along the
#'chromosome. To be precise, this recombination rate is the probability that a
#'breakpoint will occur between one base and the next base; note that this is
#'different from how the mutation rate is defined (see initializeMutationRate()).
#'All rates must be in the interval [0.0, 0.5]. A rate of 0.5 implies complete
#'independence between the adjacent bases, which might be used to implement
#'independent assortment of loci located on different chromosomes (see the
#'example below). Whether a breakpoint occurs between two bases is then, in
#'effect, determined by a binomial draw with a single trial and the given rate
#'as probability (but under the hood SLiM uses a mathematically equivalent but
#'much more efficient strategy). Unlike the mutational process in SLiM, then,
#'which can generate more than one mutation at a given site (in one generation/
#'genome), the recombinational process in SLiM will never generate more then
#'one crossover between one base and the next (in one generation/genome), and
#'a supplied rate of 0.5 will therefore result in an actual probability of 0.5
#'for a crossover at the relevant position. (Note that this was not true in SLiM
#'2.x and earlier, however; their implementation of recombination resulted in a
#'crossover probability of about 39.3% for a rate of 0.5, due to the use of an
#'inaccurate approximation method. Recombination rates lower than about 0.01 would
#'have been essentially exact, since the approximation error became large only
#'as the rate approached 0.5.) There are two ways to call this function. If the
#'optional ends parameter is NULL (the default), then rates must be a singleton
#'value that specifies a single recombination rate to be used along the entire
#'chromosome. If, on the other hand, ends is supplied, then rates and ends must
#'be the same length, and the values in ends must be specified in ascending
#'order. In that case, rates and ends taken together specify the recombination
#'rates to be used along successive contiguous stretches of the chromosome, from
#'beginning to end; the last position specified in ends should extend to the end
#'of the chromosome (i.e. at least to the end of the last genomic element, if
#'not further). Note that a recombination rate of 1 centimorgan/Mbp corresponds
#'to a recombination rate of 1e-8 in the units used by SLiM. For example, if the
#'following call is made: initializeRecombinationRate(c(0, 0.5, 0), c(5000, 5001,
#'9999)); then the result is that the recombination rates between bases 0 / 1,
#'1 / 2, ..., 4999 / 5000 will be 0, the rate between bases 5000 / 5001 will be
#'0.5, and the rate between bases 5001 / 5002 onward (up to 9998 / 9999) will
#'again be 0. Setting the recombination rate between one specific pair of bases
#'to 0.5 forces recombination to occur with a probability of 0.5 between those
#'bases, which effectively breaks the simulated locus into separate chromosomes
#'at that point; this example effectively has one simulated chromosome from base
#'position 0 to 5000, and another from 5001 to 9999. If the optional sex parameter
#'is "*" (the default), then the supplied recombination rate map will be used
#'for both sexes (which is the only option for hermaphroditic simulations). In
#'sexual simulations sex may be "M" or "F" instead, in which case the supplied
#'recombination map is used only for that sex. In this case, two calls must be
#'made to initializeRecombinationRate(), one for each sex, even if a rate of zero
#'is desired for the other sex; no default recombination map is supplied.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeRecombinationRate <- function(rates, ends, sex) {
 .Init$initializeRecombinationRate(rates, ends, sex)
}

#'SLiM method initializeSex
#'
#'Documentation for SLiM function \code{initializeSex}, which is a method of the
#'SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param chromosomeType An object of type string or numeric. Must be of length 1
#'(a singleton). See details for description.
#'@param xDominanceCoeff An object of type string or numeric. Must be of length 1
#'(a singleton). The default value is \code{1}. See details for description.
#'
#'@aliases Initialize$initializeSex .Init$initializeSex
#'@return An object of type void.
#'@details Enable and configure sex in the simulation. The argument chromosomeType
#'gives the type of chromosome to be simulated; this should be "A", "X", or "Y".
#'If the chromosomeType is "X", the optional xDominanceCoeff parameter can supply
#'the dominance coefficient used when a mutation is present in an XY male, and is
#'thus "heterozygous” (but in a different sense than the heterozygosity of an XX
#'female with one copy of the mutation). Calling this function has the side effect
#'of enabling sex in the simulation; individuals will be male and female (rather
#'than hermaphroditic) regardless of the chromosomeType chosen for simulation.
#'There is no way to disable sex once it has been enabled; if you don’t want to
#'have sex, don’t call this function.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSex <- function(chromosomeType, xDominanceCoeff) {
 .Init$initializeSex(chromosomeType, xDominanceCoeff)
}

#'SLiM method initializeSLiMModelType
#'
#'Documentation for SLiM function \code{initializeSLiMModelType}, which is a
#'method of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param modelType An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'
#'@aliases Initialize$initializeSLiMModelType .Init$initializeSLiMModelType
#'@return An object of type void.
#'@details Configure the type of SLiM model used for the simulation. At present,
#'one of two model types may be selected. If modelType is "WF", SLiM will use a
#'Wright–Fisher (WF) model; this is the model type that has always been supported
#'by SLiM, and is the model type used if initializeSLiMModelType() is not called.
#'If modelType is "nonWF", SLiM will use a non-Wright–Fisher (nonWF) model
#'instead; this is a new model type supported by SLiM 3.0 and above (see section
#'1.6). If initializeSLiMModelType() is called at all then it must be called
#'before any other initialization function, so that SLiM knows from the outset
#'which features are enabled and which are not.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSLiMModelType <- function(modelType) {
 .Init$initializeSLiMModelType(modelType)
}

#'SLiM method initializeSLiMOptions
#'
#'Documentation for SLiM function \code{initializeSLiMOptions}, which is a method
#'of the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param keepPedigrees An object of type logical or string or string or integer
#'or logical or logical. Must be of length 1 (a singleton). The default value is
#'\code{F}. See details for description.
#'@param dimensionality An object of type logical or string or string or integer
#'or logical or logical. Must be of length 1 (a singleton). The default value is
#'\code{""}. See details for description.
#'@param periodicity An object of type logical or string or string or integer
#'or logical or logical. Must be of length 1 (a singleton). The default value is
#'\code{""}. See details for description.
#'@param mutationRuns An object of type logical or string or string or integer
#'or logical or logical. Must be of length 1 (a singleton). The default value is
#'\code{0}. See details for description.
#'@param preventIncidentalSelfing An object of type logical or string or string
#'or integer or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{F}. See details for description.
#'@param nucleotideBased An object of type logical or string or string or integer
#'or logical or logical. Must be of length 1 (a singleton). The default value is
#'\code{F}. See details for description.
#'
#'@aliases Initialize$initializeSLiMOptions .Init$initializeSLiMOptions
#'@return An object of type void.
#'@details Configure options for the simulation. If initializeSLiMOptions()
#'is called at all then it must be called before any other initialization
#'function (except initializeSLiMModelType()), so that SLiM knows from the
#'outset which optional features are enabled and which are not. If keepPedigrees
#'is T, SLiM will keep pedigree information for every individual in the
#'simulation, tracking the identity of its parents and grandparents. This
#'allows individuals to assess their degree of pedigree-based relatedness to
#'other individuals (see Individual’s relatedness() method, section 23.6.2), as
#'well as allowing a model to find "trios” (two parents and an offspring they
#'generated) using the pedigree properties of Individual (section 23.6.1). As
#'a side effect of keepPedigrees being T, the pedigreeID, pedigreeParentIDs,
#'and pedigreeGrandparentIDs properties of Individual will have defined values
#'(see section 23.6.1), as will the genomePedigreeID property of Genome (see
#'section 23.3.1). Note that pedigree-based relatedness doesn’t necessarily
#'correspond to genetic relatedness, due to effects such as assortment and
#'recombination. For an overview of other ways of tracking genetic ancestry,
#'including true local ancestry at each position on the chromosome, see sections
#'1.7 and 14.7. If dimensionality is not "", SLiM will enable its optional
#'"continuous space” facility. Three values for dimensionality are presently
#'supported: "x", "xy", and "xyz", specifying that continuous space should be
#'enabled for one, two, or three dimensions, respectively, using (x), (x, y),
#'and (x, y, z) coordinates respectively. This has a number of side effects.
#'First of all, it means that the specified properties of Individual (x, y,
#'and/or z) will be interpreted by SLiM as spatial positions; in particular,
#'SLiMgui will use those properties to display subpopulations spatially. Second,
#'it allows spatial interactions to be defined, evaluated, and queried using
#'initializeInteractionType() and interaction() callbacks. And third, it enables
#'the use of any other properties and methods related to continuous space, such
#'as setting the spatial boundaries of subpopulations, which would otherwise
#'raise an error. If periodicity is not "", SLiM will designate the specified
#'spatial dimensions as being periodic – wrapping around at the edges of the
#'spatial boundaries of that dimension. This option may only be used if the
#'dimensionality parameter to initializeSLiMOptions() has been used to enable
#'spatiality in the model, and only spatial dimensions that were specified in the
#'dimensionality of the model may be declared to be periodic (but if desired, it
#'is permissible to make just a subset of those dimensions periodic; it is not
#'an all-or-none proposition). For example, if the specified dimensionality is
#'"xy", the model’s periodicity may be "x", "y", or "xy" (or "", the default,
#'to specify that there are no periodic dimensions). A one-dimensional periodic
#'model would model a space like the perimeter of a circle. A two-dimensional
#'model periodic in one of those dimensions would model a space like a cylinder
#'without its end caps; if periodic in both dimensions, the modeled space is a
#'torus. The shapes of three-dimensional periodic models are harder to visualize,
#'but are essentially higherdimensional analogues of these concepts. Periodic
#'boundary conditions are commonly used to model spatial scenarios without "edge
#'effects”, since there are no edges in the periodic spatial dimensions. The
#'pointPeriodic() method of Subpopulation is typically used in conjunction with
#'this option, to actually implement the periodic boundary condition for the
#'specified dimensions. If mutationRuns is not 0, SLiM will use the value given
#'as the number of mutation runs inside Genome objects; if it is 0 (the default),
#'SLiM will calculate a number of mutation runs that it estimates will work
#'well. Internally, SLiM divides genomes into a sequence of consecutive mutation
#'runs, allowing more efficient internal computations. The optimal mutation
#'run length is short enough that each mutation run is relatively unlikely to
#'be modified by mutation/recombination events when inherited, but long enough
#'that each mutation run is likely to contain a relatively large number of
#'mutations; these priorities are in tension, so an intermediate balance between
#'them is generally desirable. The optimal number of mutation runs will depend
#'upon the machine and even the compiler used to build SLiM, so SLiM’s default
#'value may not be optimal; for maximal performance it can thus be beneficial to
#'experiment with different values and find the optimal value for the simulation
#'– a process which SLiM can assist with (see section 20.4). Specifying the
#'number of mutation runs is an advanced technique, but in certain cases it can
#'improve performance significantly. If preventIncidentalSelfing is T, incidental
#'selfing in hermaphroditic models will be prevented by SLiM. By default (i.e.,
#'if preventIncidentalSelfing is F), SLiM chooses the first and second parents
#'in a biparental mating event independently. It is therefore possible for the
#'same individual to be chosen as both the first and second parent, resulting
#'in selfing events even when the selfing rate is zero. In many models this
#'is unimportant, since it happens fairly infrequently and does not have large
#'consequences. This behavior is SLiM’s default because it is the simplest option,
#'and produces results that most closely align with simple analytical population
#'genetics models. However, in some models this selfing can be undesirable and
#'problematic. In particular, models that involve very high variance in fitness
#'or very small effective population sizes may see elevated rates of selfing that
#'substantially influence model results. If preventIncidentalSelfing is set to T,
#'all such incidental selfing will be prevented (by choosing a new second parent
#'if the first parent was chosen again). Non-incidental selfing, as requested by
#'the selfing rate, will still be permitted. Note that if incidental selfing is
#'prevented, SLiM will hang if it is unable to find a different second parent;
#'there must always be at least two individuals in the population with non-
#'zero fitness, and mateChoice() and modifyChild() callbacks must not absolutely
#'prevent those two individuals from producing viable offspring. Enforcement
#'of the prohibition on incidental selfing will occur after mateChoice()
#'callbacks have been called (and thus the default mating weights provided to
#'mateChoice() callbacks will not exclude the first parent!), but will occur
#'before modifyChild() callbacks are called (so those callbacks may assume that
#'the first and second parents are distinct). If nucleotideBased is T, the model
#'will be nucleotide-based. In this case, auto-generated mutations (i.e., mutation
#'types used by genomic element types) must be nucleotide-based, and an ancestral
#'nucleotide sequence must be supplied with initializeAncestralNucleotides().
#'Nonnucleotide- based mutations may still be used, but may not be referenced by
#'genomic element types. A mutation rate (or rate map) may not be supplied with
#'initializeMutationRate(); instead, a hotspot map may (optionally) be supplied
#'with initializeHotspotMap(). This choice has many consequences across SLiM; see
#'section 1.8 for further discussion. This function will likely be extended with
#'further options in the future, added on to the end of the argument list. Using
#'named arguments with this call is recommended for readability. Note that turning
#'on optional features may increase the runtime and memory footprint of SLiM.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSLiMOptions <- function(keepPedigrees, dimensionality, periodicity,
mutationRuns, preventIncidentalSelfing, nucleotideBased) {
 .Init$initializeSLiMOptions(keepPedigrees, dimensionality, periodicity,
mutationRuns, preventIncidentalSelfing, nucleotideBased)
}

#'SLiM method initializeTreeSeq
#'
#'Documentation for SLiM function \code{initializeTreeSeq}, which is a method of
#'the SLiM class \code{Initialize}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param recordMutations An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param simplificationRatio An object of type null or integer or float. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param simplificationInterval An object of type null or integer. Must be of
#'length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param checkCoalescence An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'@param runCrosschecks An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Initialize$initializeTreeSeq .Init$initializeTreeSeq
#'@return An object of type void.
#'@details Configure options for tree sequence recording. Calling this
#'function turns on tree sequence recording, as a side effect, for later
#'reconstruction of the simulation’s evolutionary dynamics; if you do not
#'want tree sequence recording to be enabled, do not call this function.
#'The recordMutations flag controls whether information about individual
#'mutations is recorded or not. Such recording takes time and memory, and
#'so can be turned off if only the tree sequence itself is needed, but it
#'is turned on by default since mutation recording is generally useful. The
#'simplificationRatio and simplificationInterval parameters control how often
#'automatic simplification of the recorded tree sequence occurs. This is a speed–
#'memory tradeoff: more frequent simplification (lower simplificationRatio
#'or smaller simplificationInterval) means the stored tree sequences will use
#'less memory, but at a cost of somewhat longer run times. Conversely, a larger
#'simplificationRatio or simplificationInterval means that SLiM will wait longer
#'between simplifications. There are three ways these parameters can be used.
#'With the first option, with a non- NULL simplificationRatio and a NULL value
#'for simplificationInterval, SLiM will try to find an optimal generation interval
#'for simplification such that the ratio of the memory used by the tree sequence
#'tables, (before:after) simplification, is close to the requested ratio. The
#'default of 10 (used if both simplificationRatio and simplificationInterval
#'are NULL) thus requests that SLiM try to find a generation interval such that
#'the maximum size of the stored tree sequences is ten times the size after
#'simplification. INF may be supplied to indicate that automatic simplification
#'should never occur; 0 may be supplied to indicate that automatic simplification
#'should be performed at the end of every generation. Alternatively – the second
#'option – simplificationRatio may be NULL and simplificationInterval may be
#'set to the interval, in generations, between simplifications. This may provide
#'more reliable performance, but the interval must be chosen carefully to avoid
#'exceeding the available memory. The simplificationInterval value may be a
#'very large number to specify that simplification should never occur (not INF,
#'though, since it is an integer value), or 1 to simplify every generation.
#'Finally – the third option – both parameters may be non-NULL, in which case
#'simplificationRatio is used as described above, while simplificationInterval
#'provides the initial interval first used by SLiM (and then subsequently
#'increased or decreased to try to match the requested simplification ratio). The
#'default initial interval, used when simplificationInterval is NULL, is usually
#'20; this is chosen to be relatively frequent, and thus unlikely to lead to a
#'memory overflow, but it can result in rather slow spool-up for models where
#'the equilibrium simplification interval, as determined by the simplification
#'ratio, is much longer. It can therefore be helpful to set a larger initial
#'interval so that the early part of the model run is not excessively bogged
#'down in simplification. The checkCoalescence parameter controls whether a
#'check for full coalescence is conducted after each simplification. If a model
#'will call treeSeqCoalesced() to check for coalescence during its execution,
#'checkCoalescence should be set to T. Since the coalescence checks entail
#'a performance penalty, the default of F is preferable otherwise. See the
#'documentation for treeSeqCoalesced() for further discussion. The runCrosschecks
#'parameter controls whether cross-checks between SLiM’s internal data structures
#'and the tree-sequence recording data structures will be conducted. These two
#'sets of data structures record much the same thing (mutations in genomes), but
#'using completely different representations, so such cross-checks can be useful
#'to confirm that the two data structures do indeed represent the same conceptual
#'state. This slows down the model considerably, however, and would normally be
#'turned on only for debugging purposes, so it is turned off by default.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeTreeSeq <- function(recordMutations, simplificationRatio,
simplificationInterval, checkCoalescence, runCrosschecks) {
 .Init$initializeTreeSeq(recordMutations, simplificationRatio,
simplificationInterval, checkCoalescence, runCrosschecks)
}



#'SLiM method ancestralNucleotides
#'
#'Documentation for SLiM function \code{ancestralNucleotides}, which is a method
#'of the SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param format = "string" An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Chromosome$ancestralNucleotides .c$ancestralNucleotides
#'@return An object of type integer or string.
#'@details Returns the ancestral nucleotide sequence originally supplied
#'to initializeAncestralNucleotides(), including any sequence changes due
#'to nucleotide mutations that have fixed and substituted. This nucleotide
#'sequence is the reference sequence for positions in a genome that do not
#'contain a nucleotide-based mutation. The range of the returned sequence may
#'be constrained by a start position given in start and/or an end position
#'given in end; nucleotides will be returned from start to end, inclusive. The
#'default value of NULL for start and end represent the first and last base
#'positions of the chromosome, respectively. The format of the returned sequence
#'is controlled by the format parameter. A format of "string" will return the
#'sequence as a singleton string (e.g., "TATA"). A format of "char" will return
#'a string vector with one element per nucleotide (e.g., "T", "A", "T", "A"). A
#'format of "integer" will return an integer vector with values A=0, C=1, G=2,
#'T=3 (e.g., 3, 0, 3, 0). If the sequence returned is likely to be long, the
#'"string" format will be the most memory-efficient, and may also be the fastest
#'(but may be harder to work with). For purposes related to interpreting the
#'nucleotide sequence as a coding sequence, a format of "codon" is also supported.
#'This format will return an integer vector with values from 0 to 63, based
#'upon successive nucleotide triplets in the sequence (which, for this format,
#'must have a length that is a multiple of three). The codon value for a given
#'nucleotide triplet XYZ is 16X + 4Y + Z, where X, Y, and Z have the usual values
#'A=0, C=1, G=2, T=3. For example, the triplet AAA has a codon value of 0, AAC
#'is 1, AAG is 2, AAT is 3, ACA is 4, and on upward to TTT which is 63. If the
#'nucleotide sequence AACACATTT is requested in codon format, the codon vector 1
#'4 63 will therefore be returned. These codon values can be useful in themselves;
#'they can also be passed to codonsToAminoAcids() to translate them into the
#'corresponding amino acid sequence if desired (see section 23.15.1).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
ancestralNucleotides <- function(start, end, format = "string") {
 .c$ancestralNucleotides(start, end, format = "string")
}

#'SLiM method drawBreakpoints
#'
#'Documentation for SLiM function \code{drawBreakpoints}, which is a method of the
#'SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param parent An object of type null or Individual object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'@param n An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases Chromosome$drawBreakpoints .c$drawBreakpoints
#'@return An object of type integer.
#'@details Draw recombination breakpoints, using the chromosome’s recombination
#'rate map, the current gene conversion parameters, and (in some cases – see
#'below) any active and applicable recombination() callbacks. The number of
#'breakpoints to generate, n, may be supplied; if it is NULL (the default), the
#'number of breakpoints will be drawn based upon the overall recombination rate
#'and the chromosome length (following the standard procedure in SLiM). Note that
#'if the double-stranded breaks model has been chosen, the number of breakpoints
#'generated will probably not be equal to the number requested, because most
#'breakpoints will entail gene conversion tracts, which entail additional
#'crossover breakpoints. It is generally recommended that the parent individual be
#'supplied to this method, but parent is NULL by default. The individual supplied
#'in parent is used for two purposes. First, in sexual models that define separate
#'recombination rate maps for males versus females, the sex of parent will be used
#'to determine which map is used; in this case, a non-NULL value must be supplied
#'for parent, since the choice of recombination rate map must be determined.
#'Second, in models that define recombination() callbacks, parent is used to
#'determine the various pseudo-parameters that are passed to recombination()
#'callbacks (individual, genome1, genome2, subpop), and the subpopulation to
#'which parent belongs is used to select which recombination() callbacks are
#'applicable; given the necessity of this information, recombination() callbacks
#'will not be called as a side effect of this method if parent is NULL. Apart from
#'these two uses, parent is not used, and the caller does not guarantee that the
#'generated breakpoints will actually be used to recombine the genomes of parent
#'in particular.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawBreakpoints <- function(parent, n) {
 .c$drawBreakpoints(parent, n)
}

#'SLiM method setAncestralNucleotides
#'
#'Documentation for SLiM function \code{setAncestralNucleotides}, which is a
#'method of the SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases Chromosome$setAncestralNucleotides .c$setAncestralNucleotides
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details This method, which may be called only in nucleotide-based models
#'(see section 1.8), replaces the ancestral nucleotide sequence for the
#'model. The sequence parameter is interpreted exactly as it is in the
#'initializeAncestralSequence() function; see that documentation for details
#'(section 23.1). The length of the ancestral sequence is returned. It is unusual
#'to replace the ancestral sequence in a running simulation, since the nucleotide
#'states of segregating and fixed mutations will depend upon the original
#'ancestral sequence. It can be useful when loading a new population state with
#'readFromMS() or readFromVCF(), such as when resetting the simulation state to an
#'earlier state in a conditional simulation; however, that is more commonly done
#'using readFromPopulationFile() with a SLiM or .trees file.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setAncestralNucleotides <- function(sequence) {
 .c$setAncestralNucleotides(sequence)
}

#'SLiM method setGeneConversion
#'
#'Documentation for SLiM function \code{setGeneConversion}, which is a method of
#'the SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param nonCrossoverFraction An object of type numeric or numeric or numeric or
#'numeric. Must be of length 1 (a singleton). See details for description.
#'@param meanLength An object of type numeric or numeric or numeric or numeric.
#'Must be of length 1 (a singleton). See details for description.
#'@param simpleConversionFraction An object of type numeric or numeric or numeric
#'or numeric. Must be of length 1 (a singleton). See details for description.
#'@param bias An object of type numeric or numeric or numeric or numeric. Must
#'be of length 1 (a singleton). The default value is \code{0}. See details for
#'description.
#'
#'@aliases Chromosome$setGeneConversion .c$setGeneConversion
#'@return An object of type void.
#'@details This method switches the recombination model to the "double-stranded
#'break (DSB)” model (if it is not already set to that), and configures the
#'details of the gene conversion tracts that will therefore be modeled (see
#'section 1.5.6 for discussion of the "DSB” recombination model). The meanings
#'and effects of the parameters exactly mirror the initializeGeneConversion()
#'function; see section 23.1 for details.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setGeneConversion <- function(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias) {
 .c$setGeneConversion(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias)
}

#'SLiM method setHotspotMap
#'
#'Documentation for SLiM function \code{setHotspotMap}, which is a method of the
#'SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param multipliers An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setHotspotMap .c$setHotspotMap
#'@return An object of type void.
#'@details In nucleotide-based models, set the mutation rate multiplier along
#'the chromosome. There are two ways to call this method. If the optional ends
#'parameter is NULL (the default), then multipliers must be a singleton value
#'that specifies a single multiplier to be used along the entire chromosome.
#'If, on the other hand, ends is supplied, then multipliers and ends must be the
#'same length, and the values in ends must be specified in ascending order. In
#'that case, multipliers and ends taken together specify the multipliers to be
#'used along successive contiguous stretches of the chromosome, from beginning
#'to end; the last position specified in ends should extend to the end of the
#'chromosome (as previously determined, during simulation initialization). See
#'the initializeHotspotMap() function for further discussion of precisely how
#'these multipliers and positions are interpreted. If the optional sex parameter
#'is "*" (the default), then the supplied hotspot map will be used for both
#'sexes (which is the only option for hermaphroditic simulations). In sexual
#'simulations sex may be "M" or "F" instead, in which case the supplied hotspot
#'map is used only for that sex. Note that whether sex-specific hotspot maps
#'will be used is set by the way that the simulation is initially configured
#'with initializeHotspot(), and cannot be changed with this method; so if the
#'simulation was set up to use sex-specific hotspot maps then sex must be "M" or
#'"F" here, whereas if it was set up not to, then sex must be "*" or unsupplied
#'here. If a simulation needs sex-specific hotspot maps only some of the time, the
#'male and female maps can simply be set to be identical the rest of the time. The
#'hotspot map is normally constant in simulations, so be sure you know what you
#'are doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setHotspotMap <- function(multipliers, ends, sex) {
 .c$setHotspotMap(multipliers, ends, sex)
}

#'SLiM method setMutationRate
#'
#'Documentation for SLiM function \code{setMutationRate}, which is a method of the
#'SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setMutationRate .c$setMutationRate
#'@return An object of type void.
#'@details Set the mutation rate per base position per generation along the
#'chromosome. There are two ways to call this method. If the optional ends
#'parameter is NULL (the default), then rates must be a singleton value that
#'specifies a single mutation rate to be used along the entire chromosome. If, on
#'the other hand, ends is supplied, then rates and ends must be the same length,
#'and the values in ends must be specified in ascending order. In that case, rates
#'and ends taken together specify the mutation rates to be used along successive
#'contiguous stretches of the chromosome, from beginning to end; the last position
#'specified in ends should extend to the end of the chromosome (as previously
#'determined, during simulation initialization). See the initializeMutationRate()
#'function for further discussion of precisely how these rates and positions
#'are interpreted. If the optional sex parameter is "*" (the default), then the
#'supplied mutation rate map will be used for both sexes (which is the only option
#'for hermaphroditic simulations). In sexual simulations sex may be "M" or "F"
#'instead, in which case the supplied mutation rate map is used only for that sex.
#'Note that whether sex-specific mutation rate maps will be used is set by the
#'way that the simulation is initially configured with initializeMutationRate(),
#'and cannot be changed with this method; so if the simulation was set up to use
#'sex-specific mutation rate maps then sex must be "M" or "F" here, whereas if
#'it was set up not to, then sex must be "*" or unsupplied here. If a simulation
#'needs sexspecific mutation rate maps only some of the time, the male and female
#'maps can simply be set to be identical the rest of the time. The mutation rate
#'intervals are normally a constant in simulations, so be sure you know what you
#'are doing. In nucleotide-based models, setMutationRate() may not be called. If
#'variation in the mutation rate along the chromosome is desired, setHotspotMap()
#'should be used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationRate <- function(rates, ends, sex) {
 .c$setMutationRate(rates, ends, sex)
}

#'SLiM method setRecombinationRate
#'
#'Documentation for SLiM function \code{setRecombinationRate}, which is a method
#'of the SLiM class \code{Chromosome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setRecombinationRate .c$setRecombinationRate
#'@return An object of type void.
#'@details Set the recombination rate per base position per generation along the
#'chromosome. All rates must be in the interval [0.0, 0.5]. There are two ways
#'to call this method. If the optional ends parameter is NULL (the default), then
#'rates must be a singleton value that specifies a single recombination rate to
#'be used along the entire chromosome. If, on the other hand, ends is supplied,
#'then rates and ends must be the same length, and the values in ends must be
#'specified in ascending order. In that case, rates and ends taken together
#'specify the recombination rates to be used along successive contiguous stretches
#'of the chromosome, from beginning to end; the last position specified in ends
#'should extend to the end of the chromosome (as previously determined, during
#'simulation initialization). See the initializeRecombinationRate() function for
#'further discussion of precisely how these rates and positions are interpreted.
#'If the optional sex parameter is "*" (the default), then the supplied
#'recombination rate map will be used for both sexes (which is the only option
#'for hermaphroditic simulations). In sexual simulations sex may be "M" or "F"
#'instead, in which case the supplied recombination map is used only for that sex.
#'Note that whether sex-specific recombination maps will be used is set by the way
#'that the simulation is initially configured with initializeRecombinationRate(),
#'and cannot be changed with this method; so if the simulation was set up to use
#'sex-specific recombination maps then sex must be "M" or "F" here, whereas if
#'it was set up not to, then sex must be "*" or unsupplied here. If a simulation
#'needs sex-specific recombination maps only some of the time, the male and female
#'maps can simply be set to be identical the rest of the time. The recombination
#'intervals are normally a constant in simulations, so be sure you know what you
#'are doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setRecombinationRate <- function(rates, ends, sex) {
 .c$setRecombinationRate(rates, ends, sex)
}



#'SLiM method addMutations
#'
#'Documentation for SLiM function \code{addMutations}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Genome$addMutations .G$addMutations
#'@return An object of type void.
#'@details Add the existing mutations in mutations to the genome, if they are
#'not already present (if they are already present, they will be ignored), and
#'if the addition is not prevented by the mutation stacking policy (see the
#'mutationStackPolicy property of MutationType, section 23.9.1). Calling this
#'will normally affect the fitness values calculated at the end of the current
#'generation; if you want current fitness values to be affected, you can call
#'SLiMSim’s method recalculateFitness() – but see the documentation of that method
#'for caveats.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addMutations <- function(mutations) {
 .G$addMutations(mutations)
}

#'SLiM method addNewDrawnMutation
#'
#'Documentation for SLiM function \code{addNewDrawnMutation}, which is a method of
#'the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutationType An object of type integer or MutationType object. See
#'details for description.
#'@param position An object of type integer. See details for description.
#'@param originGeneration An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'@param originSubpop An object of type null or integer or Subpopulation object.
#'The default value is \code{NULL}. See details for description.
#'@param nucleotide An object of type null or integer or string. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases Genome$addNewDrawnMutation .G$addNewDrawnMutation
#'@return An object of type Mutation object.
#'@details Add new mutations to the target genome(s) with the specified
#'mutationType (specified by the MutationType object or by integer identifier),
#'position, originGeneration (which may be NULL, the default, to specify the
#'current generation), and originSubpop (specified by the Subpopulation object
#'or by integer identifier, or by NULL, the default, to specify the subpopulation
#'to which the first target genome belongs). If originSubpop is supplied as an
#'integer, it is intentionally not checked for validity; you may use arbitrary
#'values of originSubpop to "tag” the mutations that you create (see section
#'23.8.1). The selection coefficients of the mutations are drawn from their
#'mutation types; addNewMutation() may be used instead if you wish to specify
#'selection coefficients. In non-nucleotide-based models, mutationType will
#'always be a non-nucleotide-based mutation type, and so nucleotide must be NULL
#'(the default). In a nucleotide-based model, mutationType might still be non-
#'nucleotide-based (in which case nucleotide must still be NULL), or mutationType
#'might be nucleotide-based, in which case a non-NULL value must be supplied
#'for nucleotide, specifying the nucleotide(s) to be associated with the new
#'mutation(s). Nucleotides may be specified with string values ("A", "C", "G",
#'or "T"), or with integer values (A=0, C=1, G=2, T=3). If a nucleotide mutation
#'already exists at the mutating position, it is replaced automatically in
#'accordance with the stacking policy for nucleotidebased mutation types. No
#'check is performed that a new mutation’s nucleotide differs from the ancestral
#'sequence, or that its selection coefficient is consistent with other mutations
#'that may already exist at the given position with the same nucleotide; model
#'consistency is the responsibility of the model. Beginning in SLiM 2.5 this
#'method is vectorized, so all of these parameters may be singletons (in which
#'case that single value is used for all mutations created by the call) or non-
#'singleton vectors (in which case one element is used for each corresponding
#'mutation created). Nonsingleton parameters must match in length, since their
#'elements need to be matched up oneto- one. The new mutations created by this
#'method are returned, even if their actual addition is prevented by the mutation
#'stacking policy (see the mutationStackPolicy property of MutationType, section
#'23.9.1). However, the order of the mutations in the returned vector is not
#'guaranteed to be the same as the order in which the values are specified in
#'parameter vectors, unless the position parameter is specified in ascending
#'order. In other words, presorting the parameters to this method into ascending
#'order by position, using order() and subsetting, will guarantee that the order
#'of the returned vector of mutations corresponds to the order of elements in the
#'parameters to this method; otherwise, no such guarantee exists. Beginning in
#'SLiM 2.1, this is a class method, not an instance method. This means that it
#'does not get multiplexed out to all of the elements of the receiver (which would
#'add a different new mutation to each element); instead, it is performed as a
#'single operation, adding the same new mutation objects to all of the elements of
#'the receiver. Before SLiM 2.1, to add the same mutations to multiple genomes, it
#'was necessary to call addNewDrawnMutation() on one of the genomes, and then add
#'the returned Mutation object to all of the other genomes using addMutations().
#'That is not necessary in SLiM 2.1 and later, because of this change (although
#'doing it the old way does no harm and produces identical behavior). Pre-2.1
#'code that actually relied upon the old multiplexing behavior will no longer
#'work correctly (but this is expected to be an extremely rare pattern of usage).
#'Calling this will normally affect the fitness values calculated at the end of
#'the current generation (but not sooner); if you want current fitness values to
#'be affected, you can call SLiMSim’s method recalculateFitness() – but see the
#'documentation of that method for caveats.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addNewDrawnMutation <- function(mutationType, position, originGeneration,
originSubpop, nucleotide) {
 .G$addNewDrawnMutation(mutationType, position, originGeneration,
originSubpop, nucleotide)
}

#'SLiM method addNewMutation
#'
#'Documentation for SLiM function \code{addNewMutation}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutationType An object of type integer or MutationType object. See
#'details for description.
#'@param selectionCoeff An object of type numeric. See details for description.
#'@param position An object of type integer. See details for description.
#'@param originGeneration An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'@param originSubpop An object of type null or integer or Subpopulation object.
#'The default value is \code{NULL}. See details for description.
#'@param nucleotide An object of type null or integer or string. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases Genome$addNewMutation .G$addNewMutation
#'@return An object of type Mutation object.
#'@details Add new mutations to the target genome(s) with the specified
#'mutationType (specified by the MutationType object or by integer identifier),
#'selectionCoeff, position, originGeneration (which may be NULL, the default,
#'to specify the current generation), and originSubpop (specified by the
#'Subpopulation object or by integer identifier, or by NULL, the default,
#'to specify the subpopulation to which the first target genome belongs). If
#'originSubpop is supplied as an integer, it is intentionally not checked for
#'validity; you may use arbitrary values of originSubpop to "tag” the mutations
#'that you create (see section 23.8.1). The addNewDrawnMutation() method may be
#'used instead if you wish selection coefficients to be drawn from the mutation
#'types of the mutations. In non-nucleotide-based models, mutationType will
#'always be a non-nucleotide-based mutation type, and so nucleotide must be NULL
#'(the default). In a nucleotide-based model, mutationType might still be non-
#'nucleotide-based (in which case nucleotide must still be NULL), or mutationType
#'might be nucleotide-based, in which case a non-NULL value must be supplied
#'for nucleotide, specifying the nucleotide(s) to be associated with the new
#'mutation(s). Nucleotides may be specified with string values ("A", "C", "G",
#'or "T"), or with integer values (A=0, C=1, G=2, T=3). If a nucleotide mutation
#'already exists at the mutating position, it is replaced automatically in
#'accordance with the stacking policy for nucleotidebased mutation types. No
#'check is performed that a new mutation’s nucleotide differs from the ancestral
#'sequence, or that its selection coefficient is consistent with other mutations
#'that may already exist at the given position with the same nucleotide; model
#'consistency is the responsibility of the model. The new mutations created by
#'this method are returned, even if their actual addition is prevented by the
#'mutation stacking policy (see the mutationStackPolicy property of MutationType,
#'section 23.9.1). However, the order of the mutations in the returned vector is
#'not guaranteed to be the same as the order in which the values are specified
#'in parameter vectors, unless the position parameter is specified in ascending
#'order. In other words, presorting the parameters to this method into ascending
#'order by position, using order() and subsetting, will guarantee that the order
#'of the returned vector of mutations corresponds to the order of elements in the
#'parameters to this method; otherwise, no such guarantee exists. Beginning in
#'SLiM 2.1, this is a class method, not an instance method. This means that it
#'does not get multiplexed out to all of the elements of the receiver (which would
#'add a different new mutation to each element); instead, it is performed as a
#'single operation, adding the same new mutation object to all of the elements of
#'the receiver. Before SLiM 2.1, to add the same mutation to multiple genomes, it
#'was necessary to call addNewMutation() on one of the genomes, and then add the
#'returned Mutation object to all of the other genomes using addMutations(). That
#'is not necessary in SLiM 2.1 and later, because of this change (although doing
#'it the old way does no harm and produces identical behavior). Pre-2.1 code that
#'actually relied upon the old multiplexing behavior will no longer work correctly
#'(but this is expected to be an extremely rare pattern of usage). Calling this
#'will normally affect the fitness values calculated at the end of the current
#'generation (but not sooner); if you want current fitness values to be affected,
#'you can call SLiMSim’s method recalculateFitness() – but see the documentation
#'of that method for caveats.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addNewMutation <- function(mutationType, selectionCoeff, position,
originGeneration, originSubpop, nucleotide) {
 .G$addNewMutation(mutationType, selectionCoeff, position, originGeneration,
originSubpop, nucleotide)
}

#'SLiM method containsMarkerMutation
#'
#'Documentation for SLiM function \code{containsMarkerMutation}, which is a method
#'of the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'@param position An object of type integer. Must be of length 1 (a singleton).
#'See details for description.
#'@param returnMutation An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Genome$containsMarkerMutation .G$containsMarkerMutation
#'@return An object of type null or logical or Mutation object. Return will be of
#'length 1 (a singleton)
#'@details Returns T if the genome contains a mutation of type mutType at
#'position, F otherwise (if returnMutation has its default value of F; see
#'below). This method is, as its name suggests, intended for checking for
#'"marker mutations”: mutations of a special mutation type that are not literally
#'mutations in the usual sense, but instead are added in to particular genomes
#'to mark them as possessing some property. Marker mutations are not typically
#'added by SLiM’s mutation-generating machinery; instead they are added explicitly
#'with addNewMutation() or addNewDrawnMutation() at a known, constant position
#'in the genome. This method provides a check for whether a marker mutation of a
#'given type exists in a particular genome; because the position to check is known
#'in advance, that check can be done much faster than the equivalent check with
#'containsMutations() or countOfMutationsOfType(), using a binary search of the
#'genome. See section 14.4 for one example of a model that uses marker mutations
#'– in that case, to mark chromosomes that possess an inversion. If returnMutation
#'is T (an option added in SLiM 3), this method returns the actual mutation found,
#'rather than just T or F. More specifically, the first mutation found of mutType
#'at position will be returned; if more than one such mutation exists in the
#'target genome, which one is returned is not defined. If returnMutation is T and
#'no mutation of mutType is found at position, NULL will be returned.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
containsMarkerMutation <- function(mutType, position, returnMutation) {
 .G$containsMarkerMutation(mutType, position, returnMutation)
}

#'SLiM method containsMutations
#'
#'Documentation for SLiM function \code{containsMutations}, which is a method of
#'the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Genome$containsMutations .G$containsMutations
#'@return An object of type logical.
#'@details Returns a logical vector indicating whether each of the mutations
#'in mutations is present in the genome; each element in the returned vector
#'indicates whether the corresponding mutation is present (T) or absent (F). This
#'method is provided for speed; it is much faster than the corresponding Eidos
#'code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
containsMutations <- function(mutations) {
 .G$containsMutations(mutations)
}

#'SLiM method countOfMutationsOfType
#'
#'Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
#'of the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$countOfMutationsOfType .G$countOfMutationsOfType
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Returns the number of mutations that are of the type specified by
#'mutType, out of all of the mutations in the genome. If you need a vector of the
#'matching Mutation objects, rather than just a count, use -mutationsOfType().
#'This method is provided for speed; it is much faster than the corresponding
#'Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .G$countOfMutationsOfType(mutType)
}

#'SLiM method mutationsOfType
#'
#'Documentation for SLiM function \code{mutationsOfType}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$mutationsOfType .G$mutationsOfType
#'@return An object of type Mutation object.
#'@details Returns an object vector of all the mutations that are of the type
#'specified by mutType, out of all of the mutations in the genome. If you just
#'need a count of the matching Mutation objects, rather than a vector of the
#'matches, use -countOfMutationsOfType(); if you need just the positions of
#'matching Mutation objects, use -positionsOfMutationsOfType(); and if you are
#'aiming for a sum of the selection coefficients of matching Mutation objects, use
#'-sumOfMutationsOfType(). This method is provided for speed; it is much faster
#'than the corresponding Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationsOfType <- function(mutType) {
 .G$mutationsOfType(mutType)
}

#'SLiM method nucleotides
#'
#'Documentation for SLiM function \code{nucleotides}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param format An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"string"}. See details for description.
#'
#'@aliases Genome$nucleotides .G$nucleotides
#'@return An object of type integer or string.
#'@details Returns the nucleotide sequence for the genome. This is the
#'current ancestral sequence, as would be returned by the Chromosome method
#'ancestralNucleotides(), with the nucleotides for any nucleotide-based mutations
#'in the genome overlaid. The range of the returned sequence may be constrained by
#'a start position given in start and/or an end position given in end; nucleotides
#'will be returned from start to end, inclusive. The default value of NULL for
#'start and end represent the first and last base positions of the chromosome,
#'respectively. The format of the returned sequence is controlled by the format
#'parameter. A format of "string" will return the sequence as a singleton string
#'(e.g., "TATA"). A format of "char" will return a string vector with one element
#'per nucleotide (e.g., "T", "A", "T", "A"). A format of "integer" will return
#'an integer vector with values A=0, C=1, G=2, T=3 (e.g., 3, 0, 3, 0). A format
#'of "codon" will return an integer vector with values from 0 to 63, based upon
#'successive nucleotide triplets in the sequence (which, for this format, must
#'have a length that is a multiple of three); see the ancestralNucleotides()
#'documentation for details. If the sequence returned is likely to be long, the
#'"string" format will be the most memory-efficient, and may also be the fastest
#'(but may be harder to work with). Several helper functions are provided for
#'working with sequences, such as nucleotideCounts() to get the counts of A/C/G/
#'T nucleotides in a sequence, nucleotideFrequencies() to get the same information
#'as frequencies, and codonsToAminoAcids() to convert a codon sequence (such as
#'provided by the codon format described above) to an amino acid sequence; see
#'section 23.15.1.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nucleotides <- function(start, end, format) {
 .G$nucleotides(start, end, format)
}

#'SLiM method output
#'
#'Documentation for SLiM function \code{output}, which is a method of the SLiM
#'class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Genome$output .G$output
#'@return An object of type void.
#'@details Output the target genomes in SLiM’s native format (see section 25.3.1
#'for output format details). This low-level output method may be used to output
#'any sample of Genome objects (the Eidos function sample() may be useful for
#'constructing custom samples, as may the SLiM class Individual). For output of
#'a sample from a single Subpopulation, the outputSample() of Subpopulation may
#'be more straightforward to use. If the optional parameter filePath is NULL (the
#'default), output is directed to SLiM’s standard output. Otherwise, the output
#'is sent to the file specified by filePath, overwriting that file if append if F,
#'or appending to the end of it if append is T. See outputMS() and outputVCF() for
#'other output formats. Output is generally done in a late() event, so that the
#'output reflects the state of the simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
output <- function(filePath, append) {
 .G$output(filePath, append)
}

#'SLiM method outputMS
#'
#'Documentation for SLiM function \code{outputMS}, which is a method of the SLiM
#'class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param filterMonomorphic An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Genome$outputMS .G$outputMS
#'@return An object of type void.
#'@details Output the target genomes in MS format (see section 25.3.2 for output
#'format details). This low-level output method may be used to output any sample
#'of Genome objects (the Eidos function sample() may be useful for constructing
#'custom samples, as may the SLiM class Individual). For output of a sample
#'from a single Subpopulation, the outputMSSample() of Subpopulation may be
#'more straightforward to use. If the optional parameter filePath is NULL (the
#'default), output is directed to SLiM’s standard output. Otherwise, the output
#'is sent to the file specified by filePath, overwriting that file if append if F,
#'or appending to the end of it if append is T. Positions in the output will span
#'the interval [0,1]. If filterMonomorphic is F (the default), all mutations that
#'are present in the sample will be included in the output. This means that some
#'mutations may be included that are actually monomorphic within the sample (i.e.,
#'that exist in every sampled genome, and are thus apparently fixed). These may be
#'filtered out with filterMonomorphic = T if desired; note that this option means
#'that some mutations that do exist in the sampled genomes might not be included
#'in the output, simply because they exist in every sampled genome. See output()
#'and outputVCF() for other output formats. Output is generally done in a late()
#'event, so that the output reflects the state of the simulation at the end of a
#'generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputMS <- function(filePath, append, filterMonomorphic) {
 .G$outputMS(filePath, append, filterMonomorphic)
}

#'SLiM method outputVCF
#'
#'Documentation for SLiM function \code{outputVCF}, which is a method of the SLiM
#'class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param outputMultiallelics An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param simplifyNucleotides An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'@param outputNonnucleotides An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases Genome$outputVCF .G$outputVCF
#'@return An object of type void.
#'@details Output the target genomes in VCF format (see sections 25.2.3, 25.2.4,
#'and 25.3.3 for output format details). The target genomes are treated as pairs
#'comprising individuals for purposes of structuring the VCF output, so an even
#'number of genomes is required. This low-level output method may be used to
#'output any sample of Genome objects (the Eidos function sample() may be useful
#'for constructing custom samples, as may the SLiM class Individual). For output
#'of a sample from a single Subpopulation, the outputVCFSample() of Subpopulation
#'may be more straightforward to use. If the optional parameter filePath is
#'NULL (the default), output is directed to SLiM’s standard output. Otherwise,
#'the output is sent to the file specified by filePath, overwriting that file
#'if append if F, or appending to the end of it if append is T. The parameters
#'outputMultiallelics, simplifyNucleotides, and outputNonnucleotides affect
#'the format of the output produced; see sections 25.2.3 and 25.2.4 for further
#'discussion. See outputMS() and output() for other output formats. Output is
#'generally done in a late() event, so that the output reflects the state of the
#'simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputVCF <- function(filePath, outputMultiallelics, append,
simplifyNucleotides, outputNonnucleotides) {
 .G$outputVCF(filePath, outputMultiallelics, append, simplifyNucleotides,
outputNonnucleotides)
}

#'SLiM method positionsOfMutationsOfType
#'
#'Documentation for SLiM function \code{positionsOfMutationsOfType}, which is a
#'method of the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$positionsOfMutationsOfType .G$positionsOfMutationsOfType
#'@return An object of type integer.
#'@details Returns the positions of mutations that are of the type specified by
#'mutType, out of all of the mutations in the genome. If you need a vector of the
#'matching Mutation objects, rather than just positions, use -mutationsOfType().
#'This method is provided for speed; it is much faster than the corresponding
#'Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
positionsOfMutationsOfType <- function(mutType) {
 .G$positionsOfMutationsOfType(mutType)
}

#'SLiM method readFromMS
#'
#'Documentation for SLiM function \code{readFromMS}, which is a method of the SLiM
#'class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutationType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$readFromMS .G$readFromMS
#'@return An object of type Mutation object.
#'@details Read new mutations from the MS format file at filePath and add them
#'to the target genomes. The number of target genomes must match the number
#'of genomes represented in the MS file. To read into all of the genomes in
#'a given subpopulation pN, simply call pN.genomes.readFromMS(), assuming the
#'subpopulation’s size matches that of the MS file. A vector containing all of the
#'mutations created by readFromMS() is returned. Each mutation is created at the
#'position specified in the file, using the mutation type given by mutationType.
#'Positions are expected to be in [0,1], and are scaled to the length of the
#'chromosome by multiplying by the last valid base position of the chromosome
#'(i.e., one less than the chromosome length). Selection coefficients are drawn
#'from the mutation type. The population of origin for each mutation is set
#'to -1, and the generation of origin is set to the current generation. In a
#'nucleotidebased model, if mutationType is nucleotide-based, a random nucleotide
#'different from the ancestral nucleotide at the position will be chosen with
#'equal probability. The target genomes correspond, in order, to the call lines
#'in the MS file. In sex-based models that simulate the X or Y chromosome, null
#'genomes in the target vector will be skipped, and will not be used to correspond
#'to any call line; however, care should be taken in this case that the lines in
#'the MS file correspond to the target genomes in the manner desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
readFromMS <- function(filePath, mutationType) {
 .G$readFromMS(filePath, mutationType)
}

#'SLiM method readFromVCF
#'
#'Documentation for SLiM function \code{readFromVCF}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutationType An object of type null or integer or MutationType object.
#'Must be of length 1 (a singleton). The default value is \code{NULL}. See details
#'for description.
#'
#'@aliases Genome$readFromVCF .G$readFromVCF
#'@return An object of type Mutation object.
#'@details Read new mutations from the VCF format file at filePath and add
#'them to the target genomes. The number of target genomes must match the
#'number of genomes represented in the VCF file (i.e., two times the number
#'of samples, if each sample is diploid). To read into all of the genomes in
#'a given subpopulation pN, simply call pN.genomes.readFromVCF(), assuming the
#'subpopulation’s size matches that of the VCF file taking ploidy into account.
#'A vector containing all of the mutations created by readFromVCF() is returned.
#'SLiM’s VCF parsing is quite primitive. The header is parsed only inasmuch as
#'SLiM looks to see whether SLiM-specific VCF fields (see sections 25.2.3 and
#'25.2.4) are defined or not; the rest of the header information is ignored.
#'Call lines are assumed to follow the format: #CHROM POS ID REF ALT QUAL FILTER
#'INFO FORMAT i0...iN The CHROM, ID, QUAL, FILTER, and FORMAT fields are ignored,
#'and information in the genotype fields beyond the GT genotype subfield are
#'also ignored. SLiM’s own VCF annotations (see section 25.2.3) are honored; in
#'particular, mutations will be created using the given values of MID, S, PO, GO,
#'and MT if those subfields are present, and DOM, if it is present, must match
#'the dominance coefficient of the mutation type. The parameter mutationType (a
#'MutationType object or id) will be used for any mutations that have no supplied
#'mutation type id in the MT subfield; if mutationType would be used but is NULL
#'an error will result. Mutation IDs supplied in MID will be used if no mutation
#'IDs have been used in the simulation so far; if any have been used, it is
#'difficult for SLiM to guarantee that there are no conflicts, so a warning will
#'be emitted and the MID values will be ignored. If selection coefficients are not
#'supplied with the S subfield, they will be drawn from the mutation type used for
#'the mutation. If a population of origin is not supplied with the PO subfield,
#'-1 will be used. If a generation of origin is not supplied with the GO subfield,
#'the current generation will be used. REF and ALT must always be comprised of
#'simple nucleotides (A/C/G/T) rather than values representing indels or other
#'complex states. Beyond this, the handling of the REF and ALT fields depends
#'upon several factors. First of all, these fields are ignored in non-nucleotide-
#'based models, although they are still checked for conformance. In nucleotide-
#'based models, when a header definition for SLiM’s NONNUC tag is present (as
#'when nucleotide-based output is generated by SLiM): Second, if a NONNUC field is
#'present in the INFO field the call line is taken to represent a non-nucleotide-
#'based mutation, and REF and ALT are again ignored. In this case the mutation
#'type used must be non-nucleotidebased. Third, if NONNUC is not present the
#'call line is taken to represent a nucleotide-based mutation. In this case, the
#'mutation type used must be nucleotide-based. Also, in this case, the specified
#'reference nucleotide must match the existing ancestral nucleotide at the
#'given position. In nucleotidebased models, when a header definition for SLiM’s
#'NONNUC tag is not present (as when loading a non- SLiM-generated VCF file):
#'The mutation type will govern the way nucleotides are handled. If the mutation
#'type used for a mutation is nucleotide-based, the nucleotide provided in the
#'VCF file for that allele will be used. If the mutation type is non-nucleotide-
#'based, the nucleotide provided will be ignored. If multiple alleles using the
#'same nucleotide at the same position are specified in the VCF file, a separate
#'mutation will be created for each, mirroring SLiM’s behavior with independent
#'mutational lineages when writing VCF (see section 25.2.4). The MULTIALLELIC flag
#'is ignored by readFromVCF(); call lines for mutations at the same base position
#'in the same genome will result in stacked mutations whether or not MULTIALLELIC
#'is present. The target genomes correspond, in order, to the haploid or diploid
#'calls provided for i0…iN (the sample IDs) in the VCF file. In sex-based models
#'that simulate the X or Y chromosome, null genomes in the target vector will
#'be skipped, and will not be used to correspond to any of i0…iN; however, care
#'should be taken in this case that the genomes in the VCF file correspond to the
#'target genomes in the manner desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
readFromVCF <- function(filePath, mutationType) {
 .G$readFromVCF(filePath, mutationType)
}

#'SLiM method removeMutations
#'
#'Documentation for SLiM function \code{removeMutations}, which is a method of the
#'SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'@param substitute An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'
#'@aliases Genome$removeMutations .G$removeMutations
#'@return An object of type void.
#'@details Remove the mutations in mutations from the target genome(s), if they
#'are present (if they are not present, they will be ignored). If NULL is passed
#'for mutations (which is the default), then all mutations will be removed from
#'the target genomes; in this case, substitute must be F (a specific vector of
#'mutations to be substituted is required). Note that the Mutation objects removed
#'remain valid, and will still be in the simulation’s mutation registry (i.e.
#'will be returned by SLiMSim’s mutations property), until the next generation.
#'Changing this will normally affect the fitness values calculated at the end
#'of the current generation; if you want current fitness values to be affected,
#'you can call SLiMSim’s method recalculateFitness() – but see the documentation
#'of that method for caveats. The optional parameter substitute was added in
#'SLiM 2.2, with a default of F for backward compatibility. If substitute is
#'T, Substitution objects will be created for all of the removed mutations so
#'that they are recorded in the simulation as having fixed, just as if they
#'had reached fixation and been removed by SLiM’s own internal machinery. This
#'will occur regardless of whether the mutations have in fact fixed, regardless
#'of the convertToSubstitution property of the relevant mutation types, and
#'regardless of whether all copies of the mutations have even been removed
#'from the simulation (making it possible to create Substitution objects for
#'mutations that are still segregating). It is up to the caller to perform
#'whatever checks are necessary to preserve the integrity of the simulation’s
#'records. Typically substitute will only be set to T in the context of calls like
#'sim.subpopulations.genomes.removeMutations(muts, T), such that the substituted
#'mutations are guaranteed to be entirely removed from circulation. As mentioned
#'above, substitute may not be T if mutations is NULL.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
removeMutations <- function(mutations, substitute) {
 .G$removeMutations(mutations, substitute)
}

#'SLiM method sumOfMutationsOfType
#'
#'Documentation for SLiM function \code{sumOfMutationsOfType}, which is a method
#'of the SLiM class \code{Genome}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$sumOfMutationsOfType .G$sumOfMutationsOfType
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Returns the sum of the selection coefficients of all mutations that
#'are of the type specified by mutType, out of all of the mutations in the genome.
#'This is often useful in models that use a particular mutation type to represent
#'QTLs with additive effects; in that context, sumOfMutationsOfType() will provide
#'the sum of the additive effects of the QTLs for the given mutation type. This
#'method is provided for speed; it is much faster than the corresponding Eidos
#'code. Note that this method also exists on Individual, for cases in which the
#'sum across both genomes of an individual is desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
sumOfMutationsOfType <- function(mutType) {
 .G$sumOfMutationsOfType(mutType)
}



#'SLiM method setGenomicElementType
#'
#'Documentation for SLiM function \code{setGenomicElementType}, which is a method
#'of the SLiM class \code{GenomicElement}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param genomicElementType An object of type integer or GenomicElementType
#'object. Must be of length 1 (a singleton). See details for description.
#'
#'@aliases GenomicElement$setGenomicElementType .GE$setGenomicElementType
#'@return An object of type void.
#'@details Set the genomic element type used for a genomic element (see section
#'1.5.4). The genomicElementType parameter should supply the new genomic element
#'type for the element, either as a GenomicElementType object or as an integer
#'identifier. The genomic element type for a genomic element is normally a
#'constant in simulations, so be sure you know what you are doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setGenomicElementType <- function(genomicElementType) {
 .GE$setGenomicElementType(genomicElementType)
}



#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{GenomicElementType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases GenomicElementType$getValue .GET$getValue
#'@return An object of type any but object or void or void or void.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-style
#'functionality is actually provided by the superclass of GenomicElementType,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .GET$getValue(key)
}

#'SLiM method setMutationFractions
#'
#'Documentation for SLiM function \code{setMutationFractions}, which is a method
#'of the SLiM class \code{GenomicElementType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutationTypes An object of type integer or MutationType object. See
#'details for description.
#'@param proportions An object of type numeric. See details for description.
#'
#'@aliases GenomicElementType$setMutationFractions .GET$setMutationFractions
#'@return An object of type any but object or void or void or void.
#'@details Set the mutation type fractions contributing to a genomic element type.
#'The mutationTypes vector should supply the mutation types used by the genomic
#'element (either as MutationType objects or as integer identifiers), and the
#'proportions vector should be of equal length, specifying the relative proportion
#'of mutations that will be drawn from each corresponding type (see section
#'1.5.4). This is normally a constant in simulations, so be sure you know what you
#'are doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationFractions <- function(mutationTypes, proportions) {
 .GET$setMutationFractions(mutationTypes, proportions)
}

#'SLiM method setMutationMatrix
#'
#'Documentation for SLiM function \code{setMutationMatrix}, which is a method of
#'the SLiM class \code{GenomicElementType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutationMatrix An object of type float. See details for description.
#'
#'@aliases GenomicElementType$setMutationMatrix .GET$setMutationMatrix
#'@return An object of type any but object or void or void or void.
#'@details Sets a new nucleotide mutation matrix for the genomic
#'element type. This replaces the mutation matrix originally set by
#'initializeGenomicElementType(). This method may only be called in nucleotide-
#'based models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationMatrix <- function(mutationMatrix) {
 .GET$setMutationMatrix(mutationMatrix)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{GenomicElementType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases GenomicElementType$setValue .GET$setValue
#'@return An object of type any but object or void or void or void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'GenomicElementType, SLiMEidosDictionary, although that fact is not presently
#'visible in Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .GET$setValue(key, value)
}



#'SLiM method containsMutations
#'
#'Documentation for SLiM function \code{containsMutations}, which is a method of
#'the SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Individual$containsMutations .I$containsMutations
#'@return An object of type logical.
#'@details Returns a logical vector indicating whether each of the mutations in
#'mutations is present in the individual (in either of its genomes); each element
#'in the returned vector indicates whether the corresponding mutation is present
#'(T) or absent (F). This method is provided for speed; it is much faster than the
#'corresponding Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
containsMutations <- function(mutations) {
 .I$containsMutations(mutations)
}

#'SLiM method countOfMutationsOfType
#'
#'Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
#'of the SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$countOfMutationsOfType .I$countOfMutationsOfType
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Returns the number of mutations that are of the type specified by
#'mutType, out of all of the mutations in the individual (in both of its genomes;
#'a mutation that is present in both genomes counts twice). If you need a vector
#'of the matching Mutation objects, rather than just a count, you should probably
#'use uniqueMutationsOfType(). This method is provided for speed; it is much
#'faster than the corresponding Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .I$countOfMutationsOfType(mutType)
}

#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Individual$getValue .I$getValue
#'@return An object of type any but object.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of Individual,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .I$getValue(key)
}

#'SLiM method relatedness
#'
#'Documentation for SLiM function \code{relatedness}, which is a method of the
#'SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases Individual$relatedness .I$relatedness
#'@return An object of type float.
#'@details Returns a vector containing the degrees of relatedness between the
#'receiver and each of the individuals in individuals. The relatedness between A
#'and B is always 1.0 if A and B are actually the same individual; this facility
#'works even if SLiM’s optional pedigree tracking is turned off (in which case
#'all other relatedness values will be 0.0). Otherwise, if pedigree tracking is
#'turned on with initializeSLiMOptions(keepPedigrees=T), this method will use
#'the pedigree information described in section 23.6.1 to construct a relatedness
#'estimate. More specifically, if information about the grandparental generation
#'is available, then each grandparent shared by A and B contributes 0.125 towards
#'the total relatedness, for a maximum value of 0.5 with four shared grandparents.
#'If grandparental information in unavailable, then if parental information is
#'available it is used, with each parent shared by A and B contributing 0.25,
#'again for a maximum of 0.5. If even parental information is unavailable, then
#'the relatedness is assumed to be 0.0. Again, however, if A and B are the same
#'individual, the relatedness will be 1.0 in all cases. Note that this relatedness
#'is simply pedigree-based relatedness. This does not necessarily correspond
#'to genetic relatedness, because of the effects of factors like assortment and
#'recombination.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
relatedness <- function(individuals) {
 .I$relatedness(individuals)
}

#'SLiM method setSpatialPosition
#'
#'Documentation for SLiM function \code{setSpatialPosition}, which is a method of
#'the SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param position An object of type float. See details for description.
#'
#'@aliases Individual$setSpatialPosition .I$setSpatialPosition
#'@return An object of type void.
#'@details Sets the spatial position of the individual (as accessed through
#'the spatialPosition property). The length of position (the number of
#'coordinates in the spatial position of an individual) depends upon the
#'spatial dimensionality declared with initializeSLiMOptions(). If the spatial
#'dimensionality is zero (as it is by default), it is an error to call this
#'method. The elements of position are set into the values of the x, y, and z
#'properties (if those properties are encompassed by the spatial dimensionality
#'of the simulation). In other words, if the declared dimensionality is "xy",
#'calling individual.setSpatialPosition(c(1.0, 0.5)) property is equivalent to
#'individual.x = 1.0; individual.y = 0.5; individual.z is not set (even if a third
#'value is supplied in position) since it is not encompassed by the simulation’s
#'dimensionality in this example. Note that this is an Eidos class method,
#'somewhat unusually, which allows it to work in a special way when called on a
#'vector of individuals. When the target vector of individuals is non-singleton,
#'this method can do one of two things. If position contains just a single point
#'(i.e., is equal in length to the spatial dimensionality of the model), the
#'spatial position of all of the target individuals will be set to the given
#'point. Alternatively, if position contains one point per target individual
#'(i.e., is equal in length to the number of individuals multiplied by the spatial
#'dimensionality of the model), the spatial position of each target individual
#'will be set to the corresponding point from position (where the point data is
#'concatenated, not interleaved, just as it would be returned by accessing the
#'spatialPosition property on the vector of target individuals). Calling this
#'method with a position vector of any other length is an error.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSpatialPosition <- function(position) {
 .I$setSpatialPosition(position)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases Individual$setValue .I$setValue
#'@return An object of type void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'Individual, SLiMEidosDictionary, although that fact is not presently visible in
#'Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .I$setValue(key, value)
}

#'SLiM method sumOfMutationsOfType
#'
#'Documentation for SLiM function \code{sumOfMutationsOfType}, which is a method
#'of the SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$sumOfMutationsOfType .I$sumOfMutationsOfType
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Returns the sum of the selection coefficients of all mutations that
#'are of the type specified by mutType, out of all of the mutations in the
#'genomes of the individual. This is often useful in models that use a particular
#'mutation type to represent QTLs with additive effects; in that context,
#'sumOfMutationsOfType() will provide the sum of the additive effects of the
#'QTLs for the given mutation type. This method is provided for speed; it is much
#'faster than the corresponding Eidos code. Note that this method also exists on
#'Genome, for cases in which the sum for just one genome is desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
sumOfMutationsOfType <- function(mutType) {
 .I$sumOfMutationsOfType(mutType)
}

#'SLiM method uniqueMutationsOfType
#'
#'Documentation for SLiM function \code{uniqueMutationsOfType}, which is a method
#'of the SLiM class \code{Individual}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$uniqueMutationsOfType .I$uniqueMutationsOfType
#'@return An object of type Mutation object.
#'@details Returns an object vector of all the mutations that are of the type
#'specified by mutType, out of all of the mutations in the individual. Mutations
#'present in both genomes will occur only once in the result of this method,
#'and the mutations will be given in sorted order by position, so this method
#'is similar to sortBy(unique(individual.genomes.mutationsOfType(mutType)),
#'"position"). It is not identical to that call, only because if multiple
#'mutations exist at the exact same position, they may be sorted differently
#'by this method than they would be by sortBy(). If you just need a count of
#'the matching Mutation objects, rather than a vector of the matches, use -
#'countOfMutationsOfType(). This method is provided for speed; it is much
#'faster than the corresponding Eidos code. Indeed, it is faster than just
#'individual.genomes.mutationsOfType(mutType), and gives uniquing and sorting
#'on top of that, so it is advantageous unless duplicate entries for homozygous
#'mutations are actually needed.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
uniqueMutationsOfType <- function(mutType) {
 .I$uniqueMutationsOfType(mutType)
}



#'SLiM method distance
#'
#'Documentation for SLiM function \code{distance}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals1 An object of type Individual object. See details for
#'description.
#'@param individuals2 An object of type null or Individual object. The default
#'value is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$distance .IT$distance
#'@return An object of type float.
#'@details Returns a vector containing distances between individuals in
#'individuals1 and individuals2. At least one of individuals1 or individuals2
#'must be singleton, so that the distances evaluated are either from one
#'individual to many, or from many to one (which are equivalent, in fact);
#'evaluating distances for many to many individuals cannot be done in a single
#'call. (There is one exception: if both individuals1 and individuals2 are zero-
#'length or NULL, a zero-length float vector will be returned.) If individuals2
#'is NULL (the default), then individuals1 must be singleton, and a vector of
#'the distances from that individual to all individuals in its subpopulation
#'(including itself) is returned; this case may be handled differently internally,
#'for greater speed, so supplying NULL is preferable to supplying the vector of
#'all individuals in the subpopulation explicitly even though that should produce
#'identical results. If the InteractionType is non-spatial, this method may not
#'be called. Importantly, distances are calculated according to the spatiality
#'of the InteractionType (as declared in initializeInteractionType()), not the
#'dimensionality of the model as a whole (as declared in initializeSLiMOptions()).
#'The distances returned are therefore the distances that would be used to
#'calculate interaction strengths. However, distance() will return finite
#'distances for all pairs of individuals, even if the individuals are non-
#'interacting; the distance() between an individual and itself will thus be 0. See
#'interactionDistance() for an alternative distance definition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
distance <- function(individuals1, individuals2) {
 .IT$distance(individuals1, individuals2)
}

#'SLiM method distanceToPoint
#'
#'Documentation for SLiM function \code{distanceToPoint}, which is a method of the
#'SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals1 An object of type Individual object. See details for
#'description.
#'@param point An object of type float. See details for description.
#'
#'@aliases InteractionType$distanceToPoint .IT$distanceToPoint
#'@return An object of type float.
#'@details Returns a vector containing distances between individuals in
#'individuals1 and the point given by the spatial coordinates in point. The
#'point vector is interpreted as providing coordinates precisely as specified by
#'the spatiality of the interaction type; if the interaction type’s spatiality
#'is "xz", for example, then point[0] is assumed to be an x value, and point[1]
#'is assumed to be a z value. Be careful; this means that in general it is
#'not safe to pass an individual’s spatialPosition property for point, for
#'example (although it is safe if the spatiality of the interaction matches the
#'dimensionality of the simulation). A coordinate for a periodic spatial dimension
#'must be within the spatial bounds for that dimension, since coordinates outside
#'of periodic bounds are meaningless (pointPeriodic() may be used to ensure this);
#'coordinates for non-periodic spatial dimensions are not restricted. Importantly,
#'distances are calculated according to the spatiality of the InteractionType
#'(as declared in initializeInteractionType()) not the dimensionality of the
#'model as a whole (as declared in initializeSLiMOptions()). The distances are
#'therefore interaction distances: the distances that are used to calculate
#'interaction strengths. If the InteractionType is non-spatial, this method may
#'not be called. The vector point must be exactly as long as the spatiality of the
#'InteractionType.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
distanceToPoint <- function(individuals1, point) {
 .IT$distanceToPoint(individuals1, point)
}

#'SLiM method drawByStrength
#'
#'Documentation for SLiM function \code{drawByStrength}, which is a method of the
#'SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individual An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases InteractionType$drawByStrength .IT$drawByStrength
#'@return An object of type Individual object.
#'@details Returns up to count individuals drawn from the subpopulation of
#'individual. The probability of drawing particular individuals is proportional
#'to the strength of interaction they exert upon individual. This method may be
#'used with either spatial or non-spatial interactions, but will be more efficient
#'with spatial interactions that set a short maximum interaction distance. Draws
#'are done with replacement, so the same individual may be drawn more than once;
#'sometimes using unique() on the result of this call is therefore desirable. If
#'more than one draw will be needed, it is much more efficient to use a single
#'call to drawByStrength(), rather than drawing individuals one at a time. Note
#'that if no individuals exert a non-zero interaction upon individual, the vector
#'returned will be zero-length; it is important to consider this possibility.
#'If the needed interaction strengths have already been calculated, those cached
#'values are simply used. Otherwise, calling this method triggers evaluation
#'of the needed interactions, including calls to any applicable interaction()
#'callbacks.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawByStrength <- function(individual, count) {
 .IT$drawByStrength(individual, count)
}

#'SLiM method evaluate
#'
#'Documentation for SLiM function \code{evaluate}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpops An object of type null or Subpopulation object. The default value
#'is \code{NULL}. See details for description.
#'@param immediate An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'
#'@aliases InteractionType$evaluate .IT$evaluate
#'@return An object of type void.
#'@details Triggers evaluation of the interaction for the subpopulations specified
#'by subpops (or for all subpopulations, if subpops is NULL). By default, the
#'effects of this may be limited, however, since the underlying implementation may
#'choose to postpone some computations lazily. At a minimum, is it guaranteed that
#'this method will discard all previously cached data for the subpopulation(s),
#'and will cache the current spatial positions of all individuals (so that
#'individuals may then move without disturbing the state of the interaction at
#'the moment of evaluation). Notably, interaction() callbacks may not be called
#'in response to this method; instead, their evaluation may be deferred until
#'required to satisfy queries (at which point the generation counter may have
#'advanced by one, so be careful with the generation ranges used in defining
#'such callbacks). If T is passed for immediate, the interaction will immediately
#'and synchronously evaluate all interactions between all individuals in the
#'subpopulation(s), calling any applicable interaction() callbacks as necessary
#'– if the interaction is spatial (see below). However, depending upon what
#'queries are later executed, this may represent considerable wasted computation.
#'Immediate evaluation usually generates only a slight performance improvement
#'even if the interactions between all pairs of individuals are eventually
#'accessed; the main reason to choose immediate evaluation, then, is that deferred
#'calculation of interactions would lead to incorrect results due to changes in
#'model state. For non-spatial interactions, distances and interaction strengths
#'are never cached since such caching would require O(N2) memory and time, which
#'is deemed unacceptable in general; for non-spatial interactions, the immediate
#'parameter is therefore ignored. You must explicitly call evaluate() at an
#'appropriate time in the life cycle before the interaction is used, but after
#'any relevant changes have been made to the population. SLiM will invalidate any
#'existing interactions after any portion of the generation cycle in which new
#'individuals have been born or existing individuals have died. In a WF model,
#'these events occur just before late() events execute (see the WF generation
#'cycle diagram in chapter 21), so late() events are often the appropriate place
#'to put evaluate() calls, but early() events can work too if the interaction is
#'not needed until that point in the generation cycle anyway. In nonWF models,
#'on the other hand, new offspring are produced just before early() events
#'and then individuals die just before late() events (see the nonWF generation
#'cycle diagram in chapter 22), so interactions will be invalidated twice during
#'each generation cycle. This means that in a nonWF model, an interaction that
#'influences reproduction should usually be evaluated in a late() event, while an
#'interaction that influences fitness or mortality should usually be evaluated in
#'an early() event (and an interaction that affects both may need to be evaluated
#'at both times). If an interaction is never evaluated for a given subpopulation,
#'it is guaranteed that there will be essentially no memory or computational
#'overhead associated with the interaction for that subpopulation. Furthermore,
#'attempting to query an interaction for an individual in a subpopulation that has
#'not been evaluated is guaranteed to raise an error.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
evaluate <- function(subpops, immediate) {
 .IT$evaluate(subpops, immediate)
}

#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases InteractionType$getValue .IT$getValue
#'@return An object of type any but object.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of InteractionType,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .IT$getValue(key)
}

#'SLiM method interactingNeighborCount
#'
#'Documentation for SLiM function \code{interactingNeighborCount}, which is a
#'method of the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases InteractionType$interactingNeighborCount .IT$interactingNeighborCount
#'@return An object of type integer.
#'@details Returns the number of interacting individuals for each individual
#'in individuals, within the maximum interaction distance according to the
#'distance metric of the InteractionType. More specifically, this method counts
#'the number of individuals which can exert an interaction upon each focal
#'individual; it does not count individuals which only feel an interaction from
#'a focal individual. This method is similar to nearestInteractingNeighbors()
#'(when passed a large count so as to guarantee that all interacting individuals
#'are returned), but this method returns only a count of the interacting
#'individuals, not a vector containing the individuals. This method may also be
#'called in a vectorized fashion, with a non-singleton vector of individuals,
#'unlike nearestInteractingNeighbors(). Note that this method uses interaction
#'eligibility as a criterion; it will not count neighbors that cannot exert an
#'interaction upon a focal individual (due to sex-segregation, e.g.). (It also
#'does not count a focal individual as a neighbor of itself.)
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
interactingNeighborCount <- function(individuals) {
 .IT$interactingNeighborCount(individuals)
}

#'SLiM method interactionDistance
#'
#'Documentation for SLiM function \code{interactionDistance}, which is a method of
#'the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param exerters An object of type null or Individual object. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$interactionDistance .IT$interactionDistance
#'@return An object of type float.
#'@details Returns a vector containing interaction-dependent distances between
#'receiver and individuals in exerters that exert an interaction strength upon
#'receiver. If exerters is NULL (the default), then a vector of the interaction-
#'dependent distances from receiver to all individuals in its subpopulation
#'(including receiver itself) is returned; this case may be handled much more
#'efficiently than if a vector of all individuals in the subpopulation is
#'explicitly provided. If the InteractionType is nonspatial, this method may not
#'be called. Importantly, distances are calculated according to the spatiality
#'of the InteractionType (as declared in initializeInteractionType()), not the
#'dimensionality of the model as a whole (as declared in initializeSLiMOptions()).
#'The distances returned are therefore the distances that would be used to
#'calculate interaction strengths. In addition, interactionDistance() will return
#'INF as the distance between receiver and any individual which does not exert an
#'interaction upon receiver; the interactionDistance() between an individual and
#'itself will thus be INF, and likewise for pairs excluded from interacting by the
#'sex segregation or max distance of the interaction type. See distance() for an
#'alternative distance definition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
interactionDistance <- function(receiver, exerters) {
 .IT$interactionDistance(receiver, exerters)
}

#'SLiM method nearestInteractingNeighbors
#'
#'Documentation for SLiM function \code{nearestInteractingNeighbors}, which is a
#'method of the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individual An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases
#'InteractionType$nearestInteractingNeighbors .IT$nearestInteractingNeighbors
#'@return An object of type Individual object.
#'@details Returns up to count interacting individuals that are spatially
#'closest to individual, according to the distance metric of the InteractionType.
#'More specifically, this method returns only individuals which can exert an
#'interaction upon the focal individual; it does not include individuals that only
#'feel an interaction from the focal individual. To obtain all of the interacting
#'individuals within the maximum interaction distance of individual, simply pass
#'a value for count that is greater than or equal to the size of individual’s
#'subpopulation. Note that if fewer than count interacting individuals are within
#'the maximum interaction distance, the vector returned may be shorter than count,
#'or even zero-length; it is important to check for this possibility even when
#'requesting a single neighbor. If only the number of interacting individuals
#'is needed, use interactingNeighborCount() instead. Note that this method uses
#'interaction eligibility as a criterion; it will not return neighbors that cannot
#'exert an interaction upon the focal individual (due to sex-segregation, e.g.).
#'(It will also never return the focal individual as a neighbor of itself.) To
#'find all neighbors of the focal individual, whether they can interact with it or
#'not, use nearestNeighbors().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestInteractingNeighbors <- function(individual, count) {
 .IT$nearestInteractingNeighbors(individual, count)
}

#'SLiM method nearestNeighbors
#'
#'Documentation for SLiM function \code{nearestNeighbors}, which is a method of
#'the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individual An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases InteractionType$nearestNeighbors .IT$nearestNeighbors
#'@return An object of type Individual object.
#'@details Returns up to count individuals that are spatially closest to
#'individual, according to the distance metric of the InteractionType. To obtain
#'all of the individuals within the maximum interaction distance of individual,
#'simply pass a value for count that is greater than or equal to the size of
#'individual’s subpopulation. Note that if fewer than count individuals are within
#'the maximum interaction distance, the vector returned may be shorter than count,
#'or even zero-length; it is important to check for this possibility even when
#'requesting a single neighbor. Note that this method does not use interaction
#'eligibility as a criterion; it will return neighbors that could not interact
#'with the focal individual due to sex-segregation. (It will never return the
#'focal individual as a neighbor of itself, however.) To find only neighbors
#'that are eligible to exert an interaction upon the focal individual, use
#'nearestInteractingNeighbors().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestNeighbors <- function(individual, count) {
 .IT$nearestNeighbors(individual, count)
}

#'SLiM method nearestNeighborsOfPoint
#'
#'Documentation for SLiM function \code{nearestNeighborsOfPoint}, which is a
#'method of the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpop An object of type Subpopulation object. Must be of length 1 (a
#'singleton). See details for description.
#'@param point An object of type float. See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases InteractionType$nearestNeighborsOfPoint .IT$nearestNeighborsOfPoint
#'@return An object of type Individual object.
#'@details Returns up to count individuals in subpop that are spatially closest to
#'point, according to the distance metric of the InteractionType. To obtain all of
#'the individuals within the maximum interaction distance of point, simply pass a
#'value for count that is greater than or equal to the size of subpop. Note that
#'if fewer than count individuals are within the maximum interaction distance, the
#'vector returned may be shorter than count, or even zero-length; it is important
#'to check for this possibility even when requesting a single neighbor.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestNeighborsOfPoint <- function(subpop, point, count) {
 .IT$nearestNeighborsOfPoint(subpop, point, count)
}

#'SLiM method setInteractionFunction
#'
#'Documentation for SLiM function \code{setInteractionFunction}, which is a method
#'of the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param functionType An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases InteractionType$setInteractionFunction .IT$setInteractionFunction
#'@return An object of type void.
#'@details Set the function used to translate spatial distances into interaction
#'strengths for an interaction type. The functionType may be "f", in which case
#'the ellipsis ... should supply a numeric$ fixed interaction strength; "l", in
#'which case the ellipsis should supply a numeric$ maximum strength for a linear
#'function; "e", in which case the ellipsis should supply a numeric$ maximum
#'strength and a numeric$ lambda (shape) parameter for a negative exponential
#'function; "n", in which case the ellipsis should supply a numeric$ maximum
#'strength and a numeric$ sigma (standard deviation) parameter for a Gaussian
#'function; or "c", in which case the ellipsis should supply a numeric$ maximum
#'strength and a numeric$ scale parameter for a Cauchy distribution function. See
#'section 23.7 above for discussions of these interaction functions. Non-spatial
#'interactions must use function type "f", since no distance values are available
#'in that case. The interaction function for an interaction type is normally a
#'constant in simulations; in any case, it cannot be changed when an interaction
#'has already been evaluated for a given generation of individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setInteractionFunction <- function(functionType, ...) {
 .IT$setInteractionFunction(functionType, ...)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases InteractionType$setValue .IT$setValue
#'@return An object of type void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass
#'of InteractionType, SLiMEidosDictionary, although that fact is not presently
#'visible in Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .IT$setValue(key, value)
}

#'SLiM method strength
#'
#'Documentation for SLiM function \code{strength}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param exerters An object of type null or Individual object. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$strength .IT$strength
#'@return An object of type float.
#'@details Returns a vector containing the interaction strengths exerted upon
#'receiver by the individuals in exerters. If exerters is NULL (the default),
#'then a vector of the interaction strengths exerted by all individuals in the
#'subpopulation of receiver (including receiver itself) is returned; this case
#'may be handled much more efficiently than if a vector of all individuals in
#'the subpopulation is explicitly provided. If the strengths of interactions
#'exerted by a single individual upon multiple individuals is needed instead
#'(the inverse of what this method provides), multiple calls to this method will
#'be necessary, one per pairwise interaction queried; the interaction engine
#'is not optimized for the inverse case, and so it will likely be quite slow
#'to compute. If the interaction is reciprocal and sex-symmetric, the opposite
#'query should provide identical results in a single efficient call (because then
#'the interactions exerted are equal to the interactions received); otherwise,
#'the best approach might be to define a second interaction type representing
#'the inverse interaction that you wish to be able to query efficiently. If the
#'needed interaction strengths have already been calculated, those cached values
#'are simply returned. Otherwise, calling this method triggers evaluation of the
#'needed interactions, including calls to any applicable interaction() callbacks.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
strength <- function(receiver, exerters) {
 .IT$strength(receiver, exerters)
}

#'SLiM method totalOfNeighborStrengths
#'
#'Documentation for SLiM function \code{totalOfNeighborStrengths}, which is a
#'method of the SLiM class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases InteractionType$totalOfNeighborStrengths .IT$totalOfNeighborStrengths
#'@return An object of type float.
#'@details Returns a vector of the total interaction strength felt by each
#'individual in individuals, which does not need to be a singleton; indeed, it
#'can be a vector of all of the individuals in a given subpopulation. However,
#'all of the individuals in individuals must be in the same subpopulation. For
#'one individual, this is essentially the same as calling nearestNeighbors() with
#'a large count so as to obtain the complete vector of all neighbors, calling
#'strength() for each of those interactions to get each interaction strength,
#'and adding those interaction strengths together with sum(). This method is
#'much faster than that implementation, however, since all of that work is
#'done as a single operation. Also, totalOfNeighborStrengths() can total up
#'interactions for more than one focal individual in a single call. Similarly,
#'for one individual this is essentially the same as calling strength() to get the
#'interaction strengths between the focal individual and all other individuals,
#'and then calling sum(). Again, this method should be much faster, since this
#'algorithm looks only at neighbors, whereas calling strength() directly assesses
#'interaction strengths with all other individuals. This will make a particularly
#'large difference when the subpopulation size is large and the maximum distance
#'of the InteractionType is small. If the needed interaction strengths have
#'already been calculated, those cached values are simply used. Otherwise, calling
#'this method triggers evaluation of the needed interactions, including calls to
#'any applicable interaction() callbacks.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
totalOfNeighborStrengths <- function(individuals) {
 .IT$totalOfNeighborStrengths(individuals)
}

#'SLiM method unevaluate
#'
#'Documentation for SLiM function \code{unevaluate}, which is a method of the SLiM
#'class \code{InteractionType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases InteractionType$unevaluate .IT$unevaluate
#'@return An object of type void.
#'@details Discards all evaluation of this interaction, for all subpopulations.
#'The state of the InteractionType is reset to a state prior to evaluation. This
#'can be useful if the model state has changed in such a way that the evaluation
#'already conducted is no longer valid. For example, if the maximum distance
#'or the interaction function of the InteractionType need to be changed with
#'immediate effect, or if the data used by an interaction() callback has changed
#'in such a way that previously calculated interaction strengths are no longer
#'correct, unevaluate() allows the interaction to begin again from scratch. In
#'WF models, all interactions are automatically reset to an unevaluated state at
#'the moment when the new offspring generation becomes the parental generation
#'(at step 4 in the generation cycle; see section 21.4). In nonWF models,
#'all interactions are automatically reset to an unevaluated state twice per
#'generation: immediately after reproduction() callbacks have completed (after
#'step 1 in the generation cycle; see section 22.1), and immediately before
#'viability/survival selection (before step 4 in the generation cycle; see section
#'22.4). Given this automatic invalidation, most simulations have no reason to
#'call unevaluate().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
unevaluate <- function(void) {
 .IT$unevaluate(void)
}



#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{Mutation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Mutation$getValue .M$getValue
#'@return An object of type any but object or void or void or void.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of Mutation,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .M$getValue(key)
}

#'SLiM method setMutationType
#'
#'Documentation for SLiM function \code{setMutationType}, which is a method of the
#'SLiM class \code{Mutation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Mutation$setMutationType .M$setMutationType
#'@return An object of type any but object or void or void or void.
#'@details Set the mutation type of the mutation to mutType (which may be
#'specified as either an integer identifier or a MutationType object). This
#'implicitly changes the dominance coefficient of the mutation to that of the new
#'mutation type, since the dominance coefficient is a property of the mutation
#'type. On the other hand, the selection coefficient of the mutation is not
#'changed, since it is a property of the mutation object itself; it can be changed
#'explicitly using the setSelectionCoeff() method if so desired. The mutation
#'type of a mutation is normally a constant in simulations, so be sure you know
#'what you are doing. Changing this will normally affect the fitness values
#'calculated at the end of the current generation; if you want current fitness
#'values to be affected, you can call SLiMSim’s method recalculateFitness() – but
#'see the documentation of that method for caveats. In nucleotide-based models,
#'a restriction applies: nucleotide-based mutations may not be changed to a non-
#'nucleotide-based mutation type, and non-nucleotide-based mutations may not be
#'changed to a nucleotide-based mutation type.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationType <- function(mutType) {
 .M$setMutationType(mutType)
}

#'SLiM method setSelectionCoeff
#'
#'Documentation for SLiM function \code{setSelectionCoeff}, which is a method of
#'the SLiM class \code{Mutation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param selectionCoeff An object of type float. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Mutation$setSelectionCoeff .M$setSelectionCoeff
#'@return An object of type any but object or void or void or void.
#'@details Set the selection coefficient of the mutation to selectionCoeff. The
#'selection coefficient will be changed for all individuals that possess the
#'mutation, since they all share a single Mutation object (note that the dominance
#'coefficient will remain unchanged, as it is determined by the mutation type).
#'This is normally a constant in simulations, so be sure you know what you are
#'doing; often setting up a fitness() callback (see section 24.2) is preferable,
#'in order to modify the selection coefficient in a more limited and controlled
#'fashion (see section 10.5 for further discussion of this point). Changing this
#'will normally affect the fitness values calculated at the end of the current
#'generation; if you want current fitness values to be affected, you can call
#'SLiMSim’s method recalculateFitness() – but see the documentation of that method
#'for caveats.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSelectionCoeff <- function(selectionCoeff) {
 .M$setSelectionCoeff(selectionCoeff)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{Mutation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases Mutation$setValue .M$setValue
#'@return An object of type any but object or void or void or void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'Mutation, SLiMEidosDictionary, although that fact is not presently visible in
#'Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .M$setValue(key, value)
}



#'SLiM method drawSelectionCoefficient
#'
#'Documentation for SLiM function \code{drawSelectionCoefficient}, which is a
#'method of the SLiM class \code{MutationType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param n An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases MutationType$drawSelectionCoefficient .MT$drawSelectionCoefficient
#'@return An object of type float or any but object or void or void.
#'@details Draws and returns a vector of n selection coefficients using the
#'currently defined distribution of fitness effects (DFE) for the target mutation
#'type. See section 23.9 above for discussion of the supported distributions
#'and their uses. If the DFE is type "s", this method will result in synchronous
#'execution of the DFE’s script.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawSelectionCoefficient <- function(n) {
 .MT$drawSelectionCoefficient(n)
}

#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{MutationType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases MutationType$getValue .MT$getValue
#'@return An object of type float or any but object or void or void.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of MutationType,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .MT$getValue(key)
}

#'SLiM method setDistribution
#'
#'Documentation for SLiM function \code{setDistribution}, which is a method of the
#'SLiM class \code{MutationType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param distributionType An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases MutationType$setDistribution .MT$setDistribution
#'@return An object of type float or any but object or void or void.
#'@details Set the distribution of fitness effects for a mutation type. The
#'distributionType may be "f", in which case the ellipsis ... should supply a
#'numeric$ fixed selection coefficient; "e", in which case the ellipsis should
#'supply a numeric$ mean selection coefficient for the exponential distribution;
#'"g", in which case the ellipsis should supply a numeric$ mean selection
#'coefficient and a numeric$ alpha shape parameter for a gamma distribution; "n",
#'in which case the ellipsis should supply a numeric$ mean selection coefficient
#'and a numeric$ sigma (standard deviation) parameter for a normal distribution;
#'"w", in which case the ellipsis should supply a numeric$ λ scale parameter and a
#'numeric$ k shape parameter for a Weibull distribution; or "s", in which case the
#'ellipsis should supply a string$ Eidos script parameter. See section 23.9 above
#'for discussions of these distributions and their uses. The DFE for a mutation
#'type is normally a constant in simulations, so be sure you know what you are
#'doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setDistribution <- function(distributionType, ...) {
 .MT$setDistribution(distributionType, ...)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{MutationType}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases MutationType$setValue .MT$setValue
#'@return An object of type float or any but object or void or void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'MutationType, SLiMEidosDictionary, although that fact is not presently visible
#'in Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .MT$setValue(key, value)
}



#'SLiM method addSubpop
#'
#'Documentation for SLiM function \code{addSubpop}, which is a method of the SLiM
#'class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpopID An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). The
#'default value is \code{0.5}. See details for description.
#'
#'@aliases SLiMSim$addSubpop .SS$addSubpop
#'@return An object of type Subpopulation object. Return will be of length 1 (a
#'singleton)
#'@details Add a new subpopulation with id subpopID and size individuals.
#'The subpopID parameter may be either an integer giving the ID of the new
#'subpopulation, or a string giving the name of the new subpopulation (such as
#'"p5" to specify an ID of 5). Only if sex is enabled in the simulation, the
#'initial sex ratio may optionally be specified as sexRatio (as the male fraction,
#'M:M+F); if it is not specified, a default of 0.5 is used. The new subpopulation
#'will be defined as a global variable immediately by this method (see section
#'23.13), and will also be returned by this method. Subpopulations added by this
#'method will initially consist of individuals with empty genomes. In order to
#'model subpopulations that split from an already existing subpopulation, use
#'addSubpopSplit().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSubpop <- function(subpopID, size, sexRatio) {
 .SS$addSubpop(subpopID, size, sexRatio)
}

#'SLiM method addSubpopSplit
#'
#'Documentation for SLiM function \code{addSubpopSplit}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpopID An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param sourceSubpop An object of type integer or Subpopulation object. Must be
#'of length 1 (a singleton). See details for description.
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). The
#'default value is \code{0.5}. See details for description.
#'
#'@aliases SLiMSim$addSubpopSplit .SS$addSubpopSplit
#'@return An object of type Subpopulation object. Return will be of length 1 (a
#'singleton)
#'@details Split off a new subpopulation with id subpopID and size individuals
#'derived from subpopulation sourceSubpop. The subpopID parameter may be either
#'an integer giving the ID of the new subpopulation, or a string giving the name
#'of the new subpopulation (such as "p5" to specify an ID of 5). The sourceSubpop
#'parameter may specify the source subpopulation either as a Subpopulation object
#'or by integer identifier. Only if sex is enabled in the simulation, the initial
#'sex ratio may optionally be specified as sexRatio (as the male fraction, M:M+F);
#'if it is not specified, a default of 0.5 is used. The new subpopulation will be
#'defined as a global variable immediately by this method (see section 23.13), and
#'will also be returned by this method. Subpopulations added by this method will
#'consist of individuals that are clonal copies of individuals from the source
#'subpopulation, randomly chosen with probabilities proportional to fitness. The
#'fitness of all of these initial individuals is considered to be 1.0, to avoid a
#'doubled round of selection in the initial generation, given that fitness values
#'were already used to choose the individuals to clone. Once this initial set of
#'individuals has mated to produce offspring, the model is effectively of parental
#'individuals in the source subpopulation mating randomly according to fitness,
#'as usual in SLiM, with juveniles migrating to the newly added subpopulation.
#'Effectively, then, then new subpopulation is created empty, and is filled by
#'migrating juveniles from the source subpopulation, in accordance with SLiM’s
#'usual model of juvenile migration.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSubpopSplit <- function(subpopID, size, sourceSubpop, sexRatio) {
 .SS$addSubpopSplit(subpopID, size, sourceSubpop, sexRatio)
}

#'SLiM method countOfMutationsOfType
#'
#'Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
#'of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases SLiMSim$countOfMutationsOfType .SS$countOfMutationsOfType
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Returns the number of mutations that are of the type specified
#'by mutType, out of all of the mutations that are currently active in the
#'simulation. If you need a vector of the matching Mutation objects, rather than
#'just a count, use -mutationsOfType(). This method is often used to determine
#'whether an introduced mutation is still active (as opposed to being either
#'lost or fixed). This method is provided for speed; it is much faster than the
#'corresponding Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .SS$countOfMutationsOfType(mutType)
}

#'SLiM method deregisterScriptBlock
#'
#'Documentation for SLiM function \code{deregisterScriptBlock}, which is a method
#'of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param scriptBlocks An object of type integer or SLiMEidosBlock object. See
#'details for description.
#'
#'@aliases SLiMSim$deregisterScriptBlock .SS$deregisterScriptBlock
#'@return An object of type void.
#'@details All SLiMEidosBlock objects specified by scriptBlocks (either with
#'SLiMEidosBlock objects or with integer identifiers) will be scheduled for
#'deregistration. The deregistered blocks remain valid, and may even still be
#'executed in the current stage of the current generation (see section 24.9); the
#'blocks are not actually deregistered and deallocated until sometime after the
#'currently executing script block has completed. To immediately prevent a script
#'block from executing, even when it is scheduled to execute in the current stage
#'of the current generation, use the active property of the script block (see
#'sections 23.10.1 and 24.9).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
deregisterScriptBlock <- function(scriptBlocks) {
 .SS$deregisterScriptBlock(scriptBlocks)
}

#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases SLiMSim$getValue .SS$getValue
#'@return An object of type any but object.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of SLiMSim,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .SS$getValue(key)
}

#'SLiM method mutationCounts
#'
#'Documentation for SLiM function \code{mutationCounts}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpops An object of type null or Subpopulation object. See details for
#'description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$mutationCounts .SS$mutationCounts
#'@return An object of type integer.
#'@details Return an integer vector with the frequency counts of all of the
#'Mutation objects passed in mutations, within the Subpopulation objects in
#'subpops. The subpops argument is required, but you may pass NULL to get
#'population-wide frequency counts. If the optional mutations argument is NULL
#'(the default), frequency counts will be returned for all of the active Mutation
#'objects in the simulation – the same Mutation objects, and in the same order,
#'as would be returned by the mutations property of sim, in other words. See the
#'-mutationFrequencies() method to obtain float frequencies instead of integer
#'counts.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationCounts <- function(subpops, mutations) {
 .SS$mutationCounts(subpops, mutations)
}

#'SLiM method mutationFrequencies
#'
#'Documentation for SLiM function \code{mutationFrequencies}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param subpops An object of type null or Subpopulation object. See details for
#'description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$mutationFrequencies .SS$mutationFrequencies
#'@return An object of type float.
#'@details Return a float vector with the frequencies of all of the Mutation
#'objects passed in mutations, within the Subpopulation objects in subpops.
#'The subpops argument is required, but you may pass NULL to get population-
#'wide frequencies. If the optional mutations argument is NULL (the default),
#'frequencies will be returned for all of the active Mutation objects in the
#'simulation – the same Mutation objects, and in the same order, as would
#'be returned by the mutations property of sim, in other words. See the -
#'mutationCounts() method to obtain integer counts instead of float frequencies.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationFrequencies <- function(subpops, mutations) {
 .SS$mutationFrequencies(subpops, mutations)
}

#'SLiM method mutationsOfType
#'
#'Documentation for SLiM function \code{mutationsOfType}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases SLiMSim$mutationsOfType .SS$mutationsOfType
#'@return An object of type Mutation object.
#'@details Returns an object vector of all the mutations that are of the type
#'specified by mutType, out of all of the mutations that are currently active
#'in the simulation. If you just need a count of the matching Mutation objects,
#'rather than a vector of the matches, use -countOfMutationsOfType(). This
#'method is often used to look up an introduced mutation at a later point
#'in the simulation, since there is no way to keep persistent references to
#'objects in SLiM. This method is provided for speed; it is much faster than the
#'corresponding Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationsOfType <- function(mutType) {
 .SS$mutationsOfType(mutType)
}

#'SLiM method outputFixedMutations
#'
#'Documentation for SLiM function \code{outputFixedMutations}, which is a method
#'of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases SLiMSim$outputFixedMutations .SS$outputFixedMutations
#'@return An object of type void.
#'@details Output all fixed mutations – all Substitution objects, in other words
#'(see section 1.5.2) – in a SLiM native format (see section 25.1.2 for output
#'format details). If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos’s output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T.
#'Mutations which have fixed but have not been turned into Substitution objects
#'– typically because convertToSubstitution has been set to F for their mutation
#'type (see section 23.9.1) – are not output; they are still considered to be
#'segregating mutations by SLiM. In SLiM 3.3 and later, the output format includes
#'the nucleotides associated with any nucleotide-based mutations; see section
#'25.1.2. Output is generally done in a late() event, so that the output reflects
#'the state of the simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputFixedMutations <- function(filePath, append) {
 .SS$outputFixedMutations(filePath, append)
}

#'SLiM method outputFull
#'
#'Documentation for SLiM function \code{outputFull}, which is a method of the SLiM
#'class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param binary An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param spatialPositions An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param ages An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'@param ancestralNucleotides An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases SLiMSim$outputFull .SS$outputFull
#'@return An object of type void.
#'@details Output the state of the entire population (see section 25.1.1 for
#'output format details). If the optional parameter filePath is NULL (the
#'default), output will be sent to Eidos’s output stream (see section 4.2.1).
#'Otherwise, output will be sent to the filesystem path specified by filePath,
#'overwriting that file if append if F, or appending to the end of it if append
#'is T. When writing to a file, a logical flag, binary, may be supplied as well.
#'If binary is T, the population state will be written as a binary file instead
#'of a text file (binary data cannot be written to the standard output stream).
#'The binary file is usually smaller, and in any case will be read much faster
#'than the corresponding text file would be read. Binary files are not guaranteed
#'to be portable between platforms; in other words, a binary file written on
#'one machine may not be readable on a different machine (but in practice it
#'usually will be, unless the platforms being used are fairly unusual). If
#'binary is F (the default), a text file will be written. Beginning with SLiM
#'2.3, the spatialPositions parameter may be used to control the output of the
#'spatial positions of individuals in simulations for which continuous space
#'has been enabled using the dimensionality option of initializeSLiMOptions().
#'If spatialPositions is F, the output will not contain spatial positions,
#'and will be identical to the output generated by SLiM 2.1 and later. If
#'spatialPositions is T, spatial position information will be output if it is
#'available (see section 25.1.1 for format details). If the simulation does not
#'have continuous space enabled, the spatialPositions parameter will be ignored.
#'Positional information may be output for all output destinations – the Eidos
#'output stream, a text file, or a binary file. Beginning with SLiM 3.0, the
#'ages parameter may be used to control the output of the ages of individuals in
#'nonWF simulations. If ages is F, the output will not contain ages, preserving
#'backward compatibility with the output format of SLiM 2.1 and later. If ages
#'is T, ages will be output for nonWF models (see section 25.1.1 for format
#'details). In WF simulations, the ages parameter will be ignored. Beginning with
#'SLiM 3.3, the ancestralNucleotides parameter may be used to control the output
#'of the ancestral nucleotide sequence in nucleotide-based models (see section
#'25.1.1 for format details). If ancestralNucleotides is F, the output will not
#'contain ancestral nucleotide information, and so the ancestral sequence will
#'not be restored correctly if the saved file is loaded with readPopulationFile().
#'This option is provided because the ancestral sequence may be quite large,
#'for models with a long chromosome (e.g., 1 GB if the chromosome is 109 bases
#'long, when saved in text format, or 0.25 GB when saved in binary format).
#'If the model is not nucleotide-based (as enabled with the nucleotideBased
#'parameter to initializeSLiMOptions()), the ancestralNucleotides parameter
#'will be ignored. Note that in nucleotide-based models the output format will
#'always include the nucleotides associated with any nucleotide-based mutations;
#'the ancestralNucleotides flag governs only the ancestral sequence. Output is
#'generally done in a late() event, so that the output reflects the state of the
#'simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputFull <- function(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides) {
 .SS$outputFull(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides)
}

#'SLiM method outputMutations
#'
#'Documentation for SLiM function \code{outputMutations}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases SLiMSim$outputMutations .SS$outputMutations
#'@return An object of type void.
#'@details Output all of the given mutations (see section 25.1.3 for output
#'format details). This can be used to output all mutations of a given mutation
#'type, for example. If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos’s output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T. In SLiM
#'3.3 and later, the output format includes the nucleotides associated with any
#'nucleotide-based mutations; see section 25.1.3. Output is generally done in a
#'late() event, so that the output reflects the state of the simulation at the end
#'of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputMutations <- function(mutations, filePath, append) {
 .SS$outputMutations(mutations, filePath, append)
}

#'SLiM method outputUsage
#'
#'Documentation for SLiM function \code{outputUsage}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$outputUsage .SS$outputUsage
#'@return An object of type void.
#'@details Output the current memory usage of the simulation to Eidos’s output
#'stream. The specifics of what is printed, and in what format, should not be
#'relied upon as they may change from version to version of SLiM. This method
#'is primarily useful for understanding where the memory usage of a simulation
#'predominantly resides, for debugging or optimization. Note that it does not
#'capture all memory usage by the process; rather, it summarizes the memory usage
#'by SLiM and Eidos in directly allocated objects and buffers. To get the total
#'memory usage of the running process (either current or peak), use the Eidos
#'function usage().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputUsage <- function(void) {
 .SS$outputUsage(void)
}

#'SLiM method readFromPopulationFile
#'
#'Documentation for SLiM function \code{readFromPopulationFile}, which is a method
#'of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases SLiMSim$readFromPopulationFile .SS$readFromPopulationFile
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Read from a population initialization file, whether in text or binary
#'format as previously specified to outputFull(), and return the generation
#'counter value represented by the file’s contents (i.e., the generation at which
#'the file was generated). Although this is most commonly used to set up initial
#'populations (often in an Eidos event set to run in generation 1, immediately
#'after simulation initialization), it may be called in any Eidos event; the
#'current state of all populations will be wiped and replaced by the state in
#'the file at filePath. All Eidos variables that are of type object and have
#'element type Subpopulation, Genome, Mutation, Individual, or Substitution will
#'be removed as a side effect of this method, since all such variables would
#'refer to objects that no longer exist in the SLiM simulation; if you want to
#'preserve any of that state, you should output it or save it to a file prior
#'to this call. New symbols will be defined to refer to the new Subpopulation
#'objects loaded from the file. If the file being read was written by a version
#'of SLiM prior to 2.3, then for backward compatibility fitness values will be
#'calculated immediately for any new subpopulations created by this call, which
#'will trigger the calling of any activated and applicable fitness() callbacks.
#'When reading files written by SLiM 2.3 or later, fitness values are not
#'calculated as a side effect of this call (because the simulation will often
#'need to evaluate interactions or modify other state prior to doing so). In SLiM
#'2.3 and later when using the WF model, calling readFromPopulationFile() from
#'any context other than a late() event causes a warning; calling from a late()
#'event is almost always correct in WF models, so that fitness values can be
#'automatically recalculated by SLiM at the usual time in the generation cycle
#'without the need to force their recalculation (see chapter 21, and comments on
#'recalculateFitness() below). In SLiM 3.0 when using the nonWF model, calling
#'readFromPopulationFile() from any context other than an early() event causes a
#'warning; calling from an early() event is almost always correct in nonWF models,
#'so that fitness values can be automatically recalculated by SLiM at the usual
#'time in the generation cycle without the need to force their recalculation (see
#'chapter 22, and comments on recalculateFitness() below). As of SLiM 2.1, this
#'method changes the generation counter to the generation read from the file.
#'If you do not want the generation counter to be changed, you can change it
#'back after reading, by setting sim.generation to whatever value you wish. Note
#'that restoring a saved past state and running forward again will not yield the
#'same simulation results, because the random number generator’s state will not
#'be the same; to ensure reproducibility from a given time point, setSeed() can
#'be used to establish a new seed value. Any changes made to the simulation’s
#'structure (mutation types, genomic element types, etc.) will not be wiped
#'and re-established by readFromPopulationFile(); this method loads only the
#'population’s state, not the simulation configuration, so care should be taken
#'to ensure that the simulation structure meshes coherently with the loaded data.
#'Indeed, state such as the selfing and cloning rates of subpopulations, values
#'set into tag properties, and values set onto objects with setValue() will also
#'be lost, since it is not saved out by outputFull(). Only information saved by
#'outputFull() will be restored; all other state associated with the simulation’s
#'subpopulations, individuals, genomes, mutations, and substitutions will be lost,
#'and should be re-established by the model if it is still needed. As of SLiM
#'2.3, this method will read and restore the spatial positions of individuals if
#'that information is present in the output file and the simulation has enabled
#'continuous space (see outputFull() for details). If spatial positions are
#'present in the output file but the simulation has not enabled continuous space
#'(or the number of spatial dimensions does not match), an error will result.
#'If the simulation has enabled continuous space but spatial positions are not
#'present in the output file, the spatial positions of the individuals read will
#'be undefined, but an error is not raised. As of SLiM 3.0, this method will read
#'and restore the ages of individuals if that information is present in the output
#'file and the simulation is based upon the nonWF model. If ages are present but
#'the simulation uses a WF model, an error will result; the WF model does not use
#'age information. If ages are not present but the simulation uses a nonWF model,
#'an error will also result; the nonWF model requires age information. As of SLiM
#'3.3, this method will restore the nucleotides of nucleotide-based mutations, and
#'will restore the ancestral nucleotide sequence, if that information is present
#'in the output file. Loading an output file that contains nucleotide information
#'in a non-nucleotide-based model, and vice versa, will produce an error.
#'This method can also be used to read tree-sequence (.trees) files saved by
#'treeSeqOutput() or generated by the Python pyslim package. When loading a tree
#'sequence, a crosscheck of the loaded data will be performed to ensure that the
#'tree sequence was well-formed and was loaded correctly. When running a Release
#'build of SLiM, however, this crosscheck will only occur the first time that
#'readFromPopulationFile() is called to load a tree sequence; subsequent calls
#'will not perform this crosscheck, for greater speed when running models that
#'load saved population state many times (such as models that are conditional on
#'fixation). If you suspect that a tree sequence file might be corrupted or read
#'incorrectly, running a Debug build of SLiM enables crosschecks after every load.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
readFromPopulationFile <- function(filePath) {
 .SS$readFromPopulationFile(filePath)
}

#'SLiM method recalculateFitness
#'
#'Documentation for SLiM function \code{recalculateFitness}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param generation An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$recalculateFitness .SS$recalculateFitness
#'@return An object of type void.
#'@details Force an immediate recalculation of fitness values for all individuals
#'in all subpopulations. Normally fitness values are calculated at a fixed
#'point in each generation, and those values are cached and used throughout the
#'following generation. If simulation parameters are changed in script in a way
#'that affects fitness calculations, and if you wish those changes to take effect
#'immediately rather than taking effect at the end of the current generation,
#'you may call recalculateFitness() to force an immediate recalculation and
#'recache. The optional parameter generation provides the generation for which
#'fitness() callbacks should be selected; if it is NULL (the default), the
#'simulation’s current generation value, sim.generation, is used. If you call
#'recalculateFitness() in an early() event in a WF model, you may wish this
#'to be sim.generation - 1 in order to utilize the fitness() callbacks for the
#'previous generation, as if the changes that you have made to fitness-influencing
#'parameters were already in effect at the end of the previous generation when
#'the new generation was first created and evaluated (usually it is simpler
#'to just make such changes in a late() event instead, however, in which case
#'calling recalculateFitness() is probably not necessary at all since fitness
#'values will be recalculated immediately afterwards). Regardless of the value
#'supplied for generation here, sim.generation inside fitness() callbacks will
#'report the true generation number, so if your callbacks consult that parameter
#'in order to create generation-specific fitness effects you will need to handle
#'the discrepancy somehow. (Similar considerations apply for nonWF models that
#'call recalculateFitness() in a late() event, which is also not advisable in
#'general.) After this call, the fitness values used for all purposes in SLiM will
#'be the newly calculated values. Calling this method will trigger the calling of
#'any enabled and applicable fitness() callbacks, so this is quite a heavyweight
#'operation; you should think carefully about what side effects might result
#'(which is why fitness recalculation does not just occur automatically after
#'changes that might affect fitness values).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
recalculateFitness <- function(generation) {
 .SS$recalculateFitness(generation)
}

#'SLiM method registerEarlyEvent
#'
#'Documentation for SLiM function \code{registerEarlyEvent}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerEarlyEvent .SS$registerEarlyEvent
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos early() event in the current simulation, with
#'optional start and end generations limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered event is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 24.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerEarlyEvent <- function(id, source, start, end) {
 .SS$registerEarlyEvent(id, source, start, end)
}

#'SLiM method registerFitnessCallback
#'
#'Documentation for SLiM function \code{registerFitnessCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutType An object of type null or integer or MutationType object. Must be
#'of length 1 (a singleton). See details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerFitnessCallback .SS$registerFitnessCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos fitness() callback in the current simulation,
#'with a required mutation type mutType (which may be an integer mutation type
#'identifier, or NULL to indicate a global fitness() callback – see section
#'24.2), optional subpopulation subpop (which may also be an integer identifier,
#'or NULL, the default, to indicate all subpopulations), and optional start and
#'end generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current generation (see section 24.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerFitnessCallback <- function(id, source, mutType, subpop, start, end)
{
 .SS$registerFitnessCallback(id, source, mutType, subpop, start, end)
}

#'SLiM method registerInteractionCallback
#'
#'Documentation for SLiM function \code{registerInteractionCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param intType An object of type integer or InteractionType object. Must be of
#'length 1 (a singleton). See details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerInteractionCallback .SS$registerInteractionCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos interaction() callback in the current simulation,
#'with a required interaction type intType (which may be an integer identifier),
#'optional subpopulation subpop (which may also be an integer identifier, or
#'NULL, the default, to indicate all subpopulations), and optional start and
#'end generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it will be eligible to
#'execute the next time an InteractionType is evaluated. The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerInteractionCallback <- function(id, source, intType, subpop, start,
end) {
 .SS$registerInteractionCallback(id, source, intType, subpop, start, end)
}

#'SLiM method registerLateEvent
#'
#'Documentation for SLiM function \code{registerLateEvent}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerLateEvent .SS$registerLateEvent
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos late() event in the current simulation, with
#'optional start and end generations limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered event is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 24.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerLateEvent <- function(id, source, start, end) {
 .SS$registerLateEvent(id, source, start, end)
}

#'SLiM method registerMateChoiceCallback
#'
#'Documentation for SLiM function \code{registerMateChoiceCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerMateChoiceCallback .SS$registerMateChoiceCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mateChoice() callback in the current simulation,
#'with optional subpopulation subpop (which may be an integer identifier, or
#'NULL, the default, to indicate all subpopulations) and optional start and end
#'generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current generation (see section 24.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMateChoiceCallback <- function(id, source, subpop, start, end) {
 .SS$registerMateChoiceCallback(id, source, subpop, start, end)
}

#'SLiM method registerModifyChildCallback
#'
#'Documentation for SLiM function \code{registerModifyChildCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerModifyChildCallback .SS$registerModifyChildCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos modifyChild() callback in the current simulation,
#'with optional subpopulation subpop (which may be an integer identifier, or
#'NULL, the default, to indicate all subpopulations) and optional start and end
#'generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current generation (see section 24.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerModifyChildCallback <- function(id, source, subpop, start, end) {
 .SS$registerModifyChildCallback(id, source, subpop, start, end)
}

#'SLiM method registerRecombinationCallback
#'
#'Documentation for SLiM function \code{registerRecombinationCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerRecombinationCallback .SS$registerRecombinationCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos recombination() callback in the current
#'simulation, with optional subpopulation subpop (which may be an integer
#'identifier, or NULL, the default, to indicate all subpopulations) and optional
#'start and end generations all limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered callback is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 24.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerRecombinationCallback <- function(id, source, subpop, start, end) {
 .SS$registerRecombinationCallback(id, source, subpop, start, end)
}

#'SLiM method registerMutationCallback
#'
#'Documentation for SLiM function \code{registerMutationCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutType An object of type null or integer or MutationType object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerMutationCallback .SS$registerMutationCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mutation() callback in the current simulation,
#'with an optional mutation type mutType (which may be an integer mutation type
#'identifier, or NULL, the default, to indicate all mutation types – see section
#'24.8), optional subpopulation subpop (which may also be an integer identifier,
#'or NULL, the default, to indicate all subpopulations), and optional start and
#'end generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current generation (see section 24.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMutationCallback <- function(id, source, mutType, subpop, start, end)
{
 .SS$registerMutationCallback(id, source, mutType, subpop, start, end)
}

#'SLiM method registerReproductionCallback
#'
#'Documentation for SLiM function \code{registerReproductionCallback}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param sex An object of type null or string. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$registerReproductionCallback .SS$registerReproductionCallback
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos reproduction() callback in the current simulation,
#'with optional subpopulation subpop (which may be an integer identifier, or
#'NULL, the default, to indicate all subpopulations), optional sex-specificity
#'sex (which may be "M" or "F" in sexual simulations to make the callback specific
#'to males or females respectively, or NULL for no sex-specificity), and optional
#'start and end generations all limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered callback is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 24.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 23.10), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerReproductionCallback <- function(id, source, subpop, sex, start, end)
{
 .SS$registerReproductionCallback(id, source, subpop, sex, start, end)
}

#'SLiM method rescheduleScriptBlock
#'
#'Documentation for SLiM function \code{rescheduleScriptBlock}, which is a method
#'of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param block An object of type SLiMEidosBlock object. Must be of length 1 (a
#'singleton). See details for description.
#'@param start An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param generations An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$rescheduleScriptBlock .SS$rescheduleScriptBlock
#'@return An object of type SLiMEidosBlock object.
#'@details Reschedule the target script block given by block to execute in a
#'specified set of generations. The first way to specify the generation set is
#'with start and end parameter values; block will then execute from start to
#'end, inclusive. In this case, block is returned. The second way to specify
#'the generation set is using the generations parameter; this is more flexible
#'but more complicated. Since script blocks execute across a contiguous span of
#'generations defined by their start and end properties, this may result in the
#'duplication of block; one script block will be used for each contiguous span
#'of generations in generations. The block object itself will be rescheduled
#'to cover the first such span, whereas duplicates of block will be created to
#'cover subsequent contiguous spans. A vector containing all of the script blocks
#'scheduled by this method, including block, will be returned; this vector is
#'guaranteed to be sorted by the (ascending) scheduled execution order of the
#'blocks. Any duplicates of block created will be given values for the active,
#'source, tag, and type properties equal to the current values for block, but will
#'be given an id of -1 since script block identifiers must be unique; if it is
#'necessary to find the duplicated blocks again later, their tag property should
#'be used. The vector supplied for generations does not need to be in sorted
#'order, but it must not contain any duplicates. Because this method can create
#'a large number of duplicate script blocks, it can sometimes be better to handle
#'script block scheduling in other ways. If an early() event needs to execute
#'every tenth generation over the whole duration of a long model run, for example,
#'it would not be advisable to use a call like sim.rescheduleScriptBlock(s1,
#'generations=seq(10, 100000, 10)) for that purpose, since that would result in
#'thousands of duplicate script blocks. Instead, it would be preferable to add
#'a test such as if (sim.generation % 10 != 0) return; at the beginning of the
#'event. It is legal to reschedule a script block while the block is executing; a
#'call like sim.rescheduleScriptBlock(self, sim.generation + 10, sim.generation +
#'10); made inside a given block would therefore also cause the block to execute
#'every tenth generation, although this sort of self-rescheduling code is probably
#'harder to read, maintain, and debug. Whichever way of specifying the generation
#'set is used, the discussion in section 24.9 applies: block may continue to be
#'executed during the current life cycle stage even after it has been rescheduled,
#'unless it is made inactive using its active property, and similarly, the block
#'may not execute during the current life cycle stage if it was not already
#'scheduled to do so. Rescheduling script blocks during the generation and life
#'cycle stage in which they are executing, or in which they are intended to
#'execute, should be avoided. Note that new script blocks can also be created and
#'scheduled using the register...() methods of SLiMSim; by using the same source
#'as a template script block, the template can be duplicated and scheduled for
#'different generations. In fact, rescheduleScriptBlock() does essentially that
#'internally.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
rescheduleScriptBlock <- function(block, start, end, generations) {
 .SS$rescheduleScriptBlock(block, start, end, generations)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases SLiMSim$setValue .SS$setValue
#'@return An object of type void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'SLiMSim, SLiMEidosDictionary, although that fact is not presently visible in
#'Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .SS$setValue(key, value)
}

#'SLiM method simulationFinished
#'
#'Documentation for SLiM function \code{simulationFinished}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$simulationFinished .SS$simulationFinished
#'@return An object of type void.
#'@details Declare the current simulation finished. Normally SLiM ends a
#'simulation when, at the end of a generation, there are no script events or
#'callbacks registered for any future generation (excluding scripts with no
#'declared end generation). If you wish to end a simulation before this condition
#'is met, a call to simulationFinished() will cause the current simulation to
#'end at the end of the current generation. For example, a simulation might self-
#'terminate if a test for a dynamic equilibrium condition is satisfied. Note that
#'the current generation will finish executing; if you want the simulation to
#'stop immediately, you can use the Eidos method stop(), which raises an error
#'condition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
simulationFinished <- function(void) {
 .SS$simulationFinished(void)
}

#'SLiM method treeSeqCoalesced
#'
#'Documentation for SLiM function \code{treeSeqCoalesced}, which is a method of
#'the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$treeSeqCoalesced .SS$treeSeqCoalesced
#'@return An object of type logical. Return will be of length 1 (a singleton)
#'@details Returns the coalescence state for the recorded tree sequence at
#'the last simplification. The returned value is a logical singleton flag,
#'T to indicate that full coalescence was observed at the last treesequence
#'simplification (meaning that there is a single ancestral individual that roots
#'all ancestry trees at all sites along the chromosome – although not necessarily
#'the same ancestor at all sites), or F if full coalescence was not observed. For
#'simple models, reaching coalescence may indicate that the model has reached an
#'equilibrium state, but this may not be true in models that modify the dynamics
#'of the model during execution by changing migration rates, introducing new
#'mutations programmatically, dictating non-random mating, etc., so be careful
#'not to attach more meaning to coalescence than it is due; some models may
#'require burn-in beyond coalescence to reach equilibrium, or may not have an
#'equilibrium state at all. Also note that some actions by a model, such as adding
#'a new subpopulation, may cause the coalescence state to revert from T back
#'to F (at the next simplification), so a return value of T may not necessarily
#'mean that the model is coalesced at the present moment – only that it was
#'coalesced at the last simplification. This method may only be called if tree
#'sequence recording has been turned on with initializeTreeSeq(); in addition,
#'checkCoalescence=T must have been supplied to initializeTreeSeq(), so that the
#'necessary work is done during each tree-sequence simplification. Since this
#'method does not perform coalescence checking itself, but instead simply returns
#'the coalescence state observed at the last simplification, it may be desirable
#'to call treeSeqSimplify() immediately before treeSeqCoalesced() to obtain up-to-
#'date information. However, the speed penalty of doing this in every generation
#'would be large, and most models do not need this level of precision; usually it
#'is sufficient to know that the model has coalesced, without knowing whether that
#'happened in the current generation or in a recent preceding generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqCoalesced <- function(void) {
 .SS$treeSeqCoalesced(void)
}

#'SLiM method treeSeqOutput
#'
#'Documentation for SLiM function \code{treeSeqOutput}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param path An object of type string or logical. Must be of length 1 (a
#'singleton). See details for description.
#'@param simplify An object of type string or logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases SLiMSim$treeSeqOutput .SS$treeSeqOutput
#'@return An object of type void.
#'@details Outputs the current tree sequence recording tables to the path
#'specified by path. This method may only be called if tree sequence recording
#'has been turned on with initializeTreeSeq(). If simplify is T (the default),
#'simplification will be done immediately prior to output; this is almost always
#'desirable, unless a model wishes to avoid simplification entirely. A binary
#'tree sequence file will be written to the specified path; a filename extension
#'of .trees is suggested for this type of file.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqOutput <- function(path, simplify) {
 .SS$treeSeqOutput(path, simplify)
}

#'SLiM method treeSeqRememberIndividuals
#'
#'Documentation for SLiM function \code{treeSeqRememberIndividuals}, which is a
#'method of the SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases SLiMSim$treeSeqRememberIndividuals .SS$treeSeqRememberIndividuals
#'@return An object of type void.
#'@details Permanently adds the individuals specified by individuals to the sample
#'retained across tree sequence table simplification. This method may only be
#'called if tree sequence recording has been turned on with initializeTreeSeq().
#'All currently living individuals are always retained across simplification;
#'this method does not need to be called, and indeed should not be called, for
#'that purpose. Instead, treeSeqRememberIndividuals() is for permanently adding
#'particular individuals to the retained sample. Typically this would be used,
#'for example, to retain particular individuals that you wanted to be able to
#'trace ancestry back to in later analysis. However, this is not the typical usage
#'pattern for tree sequence recording; most models will not need to call this
#'method. The metadata (age, location, etc) that are stored in the resulting tree
#'sequence are those values present at either (a) the final generation, if the
#'individual is alive at the end of the simulation, or (b) the last time that the
#'individual was remembered, if not. Calling treeSeqRememberIndividuals() on an
#'individual that is already remembered will cause the archived information about
#'the remembered individual to be updated to reflect the individual’s current
#'state. A case where this is particularly important is for the spatial location
#'of individuals in continuous-space models. SLiM automatically remembers the
#'individuals that comprise the first generation of any new subpopulation created
#'with addSubpop(), for easy recapitation and other analysis (see sections 17.2
#'and 17.10). However, since these first-generation individuals are remembered
#'at the moment they are created, their spatial locations have not yet been
#'set up, and will contain garbage – and those garbage values will be archived
#'in their remembered state. If you need correct spatial locations of first-
#'generation individuals for your post-simulation analysis, you should call
#'treeSeqRememberIndividuals() explicitly on the first generation, after setting
#'spatial locations, to update the archived information with the correct spatial
#'positions.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqRememberIndividuals <- function(individuals) {
 .SS$treeSeqRememberIndividuals(individuals)
}

#'SLiM method treeSeqSimplify
#'
#'Documentation for SLiM function \code{treeSeqSimplify}, which is a method of the
#'SLiM class \code{SLiMSim}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$treeSeqSimplify .SS$treeSeqSimplify
#'@return An object of type void.
#'@details Triggers an immediate simplification of the tree sequence recording
#'tables. This method may only be called if tree sequence recording has been
#'turned on with initializeTreeSeq(). A call to this method will free up memory
#'being used by entries that are no longer in the ancestral path of any individual
#'within the current sample (currently living individuals, in other words, plus
#'those explicitly added to the sample with treeSeqRememberIndividuals()), but it
#'can also take a significant amount of time. Typically calling this method is not
#'necessary; the automatic simplification performed occasionally by SLiM should be
#'sufficient for most models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqSimplify <- function(void) {
 .SS$treeSeqSimplify(void)
}



#'SLiM method addCloned
#'
#'Documentation for SLiM function \code{addCloned}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param parent An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Subpopulation$addCloned .P$addCloned
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parent by
#'clonal reproduction, queues it for addition to the target subpopulation, and
#'returns it. The new offspring will not be visible as a member of the target
#'subpopulation until the end of the offspring generation life cycle stage.
#'The subpopulation of parent will be used to locate applicable mutation() and
#'modifyChild() callbacks governing the generation of the offspring individual.
#'Note that this method is only for use in nonWF models. See addCrossed() for
#'further general notes on the addition of new offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addCloned <- function(parent) {
 .P$addCloned(parent)
}

#'SLiM method addCrossed
#'
#'Documentation for SLiM function \code{addCrossed}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param parent1 An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param parent2 An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param sex An object of type null or float or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$addCrossed .P$addCrossed
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parents
#'by biparental sexual reproduction, queues it for addition to the target
#'subpopulation, and returns it. The new offspring will not be visible as a
#'member of the target subpopulation until the end of the offspring generation
#'life cycle stage. Attempting to use a newly generated offspring individual
#'as a mate, or to reference it as a member of the target subpopulation in any
#'other way, will result in an error. In most models the returned individual is
#'not used, but it is provided for maximal generality and flexibility. The new
#'offspring individual is generated from parent1 and parent2 by crossing them. In
#'sexual models parent1 must be female and parent2 must be male; in hermaphroditic
#'models, parent1 and parent2 are unrestricted. If parent1 and parent2 are the
#'same individual in a hermaphroditic model, that parent self-fertilizes, or
#'"selfs”, to generate the offspring sexually (note this is not the same as
#'clonal reproduction). Such selfing is considered "incidental” by addCrossed(),
#'however; if the preventIncidentalSelfing flag of initializeSLiMOptions() is
#'T, supplying the same individual for parent1 and parent2 is an error (you must
#'check for and prevent incidental selfing if you set that flag in a nonWF model).
#'If non-incidental selfing is desired, addSelfed() should be used instead.
#'The sex parameter specifies the sex of the offspring. A value of NULL means
#'"make the default choice”; in non-sexual models it is the only legal value
#'for sex, and does nothing, whereas in sexual models it causes male or female
#'to be chosen with equal probability. A value of "M" or "F" for sex specifies
#'that the offspring should be male or female, respectively. Finally, a float
#'value from 0.0 to 1.0 for sex provides the probability that the offspring will
#'be male; a value of 0.0 will produce a female, a value of 1.0 will produce
#'a male, and for intermediate values SLiM will draw the sex of the offspring
#'randomly according to the specified probability. Unless you wish the bias the
#'sex ratio of offspring, the default value of NULL should generally be used.
#'Note that any defined, active, and applicable recombination(), mutation(), and
#'modifyChild() callbacks will be called as a side effect of calling this method,
#'before this method even returns. For recombination() and mutation() callbacks,
#'the subpopulation of the parent that is generating a given gamete is used;
#'for modifyChild() callbacks the situation is more complex. In most biparental
#'mating events, parent1 and parent2 will belong to the same subpopulation,
#'and modifyChild() callbacks for that subpopulation will be used, just as in
#'WF models. In certain models (such as models of pollen flow and broadcast
#'spawning), however, biparental mating may occur between parents that are not
#'from the same subpopulation; that is legal in nonWF models, and in that case,
#'modifyChild() callbacks for the subpopulation of parent1 are used (since that
#'is the maternal parent). If the modifyChild() callback process results in
#'rejection of the proposed child (see section 24.4), a new offspring individual
#'will not be generated, and this method will return NULL. To force the generation
#'of an offspring individual from a given pair of parents, you could loop until
#'addCrossed() succeeds, but note that if your modifyChild() callback rejects
#'all proposed children from those particular parents, your model will then hang,
#'so care must be taken with this approach. Usually, nonWF models do not force
#'generation of offspring in this manner; rejection of a proposed offspring by
#'a modifyChild() callback typically represents a phenomenon such as post-mating
#'reproductive isolation or lethal genetic incompatibilities that would reduce
#'the expected litter size, so the default behavior is typically desirable. Note
#'that this method is only for use in nonWF models, in which offspring generation
#'is managed manually by the model script; in such models, addCrossed() must be
#'called only from reproduction() callbacks, and may not be called at any other
#'time. In WF models, offspring generation is managed automatically by the SLiM
#'core.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addCrossed <- function(parent1, parent2, sex) {
 .P$addCrossed(parent1, parent2, sex)
}

#'SLiM method addEmpty
#'
#'Documentation for SLiM function \code{addEmpty}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sex An object of type null or float or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$addEmpty .P$addEmpty
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual with empty genomes (i.e.,
#'containing no mutations), queues it for addition to the target subpopulation,
#'and returns it. The new offspring will not be visible as a member of the target
#'subpopulation until the end of the offspring generation life cycle stage. No
#'recombination() or mutation() callbacks will be called. The target subpopulation
#'will be used to locate applicable modifyChild() callbacks governing the
#'generation of the offspring individual (unlike the other addX() methods, because
#'there is no parental individual to reference). The offspring is considered
#'to have no parents for the purposes of pedigree tracking. The sex parameter
#'is treated as in addCrossed(). Note that this method is only for use in nonWF
#'models. See addCrossed() for further general notes on the addition of new
#'offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addEmpty <- function(sex) {
 .P$addEmpty(sex)
}

#'SLiM method addRecombinant
#'
#'Documentation for SLiM function \code{addRecombinant}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param strand1 An object of type null or Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param strand2 An object of type null or Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param breaks1 An object of type null or integer. See details for description.
#'@param strand3 An object of type null or Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param strand4 An object of type null or Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param breaks2 An object of type null or integer. See details for description.
#'@param sex An object of type null or float or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$addRecombinant .P$addRecombinant
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parental genomes
#'with the specified crossover breakpoints, queues it for addition to the target
#'subpopulation, and returns it. The new offspring will not be visible as a
#'member of the target subpopulation until the end of the offspring generation
#'life cycle stage. The target subpopulation will be used to locate applicable
#'mutation() and modifyChild() callbacks governing the generation of the offspring
#'individual (unlike the other addX() methods, because there are potentially up
#'to four parental individuals to reference); recombination() callbacks will not
#'be called by this method. This method is an advanced feature; most models will
#'use addCrossed(), addSelfed(), or addCloned() instead. This method supports
#'several possible configurations for strand1, strand2, and breaks1 (and the same
#'applies for strand3, strand4, and breaks2). If strand1 and strand2 are both
#'NULL, the corresponding genome in the generated offspring will be empty, as
#'from addEmpty(), with no parental genomes and no added mutations; in this case,
#'breaks1 must be NULL or zero-length. If strand1 is non-NULL but strand2 is NULL,
#'the corresponding genome in the generated offspring will be a clonal copy of
#'strand1 with mutations added, as from addCloned(); in this case, breaks1 must
#'similarly be NULL or zero-length. If strand1 and strand2 are both non-NULL, the
#'corresponding genome in the generated offspring will result from recombination
#'between strand1 and strand2 with mutations added, as from addCrossed(), with
#'strand1 being the initial copy strand; copying will switch between strands at
#'each breakpoint in breaks1, which must be non-NULL but need not be sorted or
#'uniqued (SLiM will sort and unique the supplied breakpoints internally). (It is
#'not currently legal for strand1 to be NULL and strand2 non-NULL; that variant
#'may be assigned some meaning in future.) Again, this discussion applies equally
#'to strand3, strand4, and breaks2, mutatis mutandis. Note that when new mutations
#'are generated by addRecombinant(), their subpopID property will be the id of
#'the offspring’s subpopulation, since the parental subpopulation is ambiguous
#'in the general case; this behavior differs from the other add...() methods.
#'The sex parameter is interpreted exactly as in addCrossed(); see that method
#'for discussion. If the offspring sex is specified in any way (i.e., if sex is
#'non-NULL), the strands provided must be compatible with the sex chosen. If the
#'offspring sex is not specified (i.e., if sex is NULL), the sex will be inferred
#'from the strands provided where possible (when modeling an X or Y chromosome),
#'or will be chosen randomly otherwise (when modeling autosomes); it will not be
#'inferred from the sex of the individuals possessing the parental strands, even
#'when the reproductive mode is essentially clonal from a single parent, since
#'such inference would be ambiguous in the general case. Similarly, the offspring
#'is considered to have no parents for the purposes of pedigree tracking, since
#'there may be more than two "parents” in the general case. When modeling the X or
#'Y, strand1 and strand2 must be X genomes (or NULL), and strand3 and strand4 must
#'both be X genomes or both be Y genomes (or NULL). These semantics allow several
#'uses for addRecombinant(). When all strands are non-NULL, it is similar to
#'addCrossed() except that the recombination breakpoints are specified explicitly,
#'allowing very precise offspring generation without having to override SLiM’s
#'breakpoint generation with a recombination() callback. When only strand1 and
#'strand3 are supplied, it is very similar to addCloned(), creating a clonal
#'offspring, except that the two parental genomes need not belong to the same
#'individual (whatever that might mean biologically). Supplying only strand1 is
#'useful for modeling clonally reproducing haploids; the second genome of every
#'offspring will be kept empty and will not receive new mutations. For a model
#'of clonally reproducing haploids that undergo horizontal gene transfer (HGT),
#'supplying only strand1 and strand2 will allow HGT from strand2 to replace
#'segments of an otherwise clonal copy of strand1, while the second genome of the
#'generated offspring will again be kept empty; this could be useful for modeling
#'bacterial conjugation, for example. Other variations are also possible. Note
#'that gene conversion tracts are not explicitly supported by this method; the
#'breaks vectors provide crossover breakpoints, which may be used to implement
#'crossovers or simple gene conversion tracts. There is no way to specify complex
#'gene conversion tracts with heteroduplex mismatch repair. Note that this method
#'is only for use in nonWF models. See addCrossed() for further general notes on
#'the addition of new offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addRecombinant <- function(strand1, strand2, breaks1, strand3, strand4,
breaks2, sex) {
 .P$addRecombinant(strand1, strand2, breaks1, strand3, strand4, breaks2, sex)
}

#'SLiM method addSelfed
#'
#'Documentation for SLiM function \code{addSelfed}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param parent An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Subpopulation$addSelfed .P$addSelfed
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parent by selfing,
#'queues it for addition to the target subpopulation, and returns it. The new
#'offspring will not be visible as a member of the target subpopulation until
#'the end of the offspring generation life cycle stage. The subpopulation of
#'parent will be used to locate applicable mutation(), recombination(), and
#'modifyChild() callbacks governing the generation of the offspring individual.
#'Since selfing requires that parent act as a source of both a male and a female
#'gamete, this method may be called only in hermaphroditic models; calling it in
#'sexual models will result in an error. This method represents a non-incidental
#'selfing event, so the preventIncidentalSelfing flag of initializeSLiMOptions()
#'has no effect on this method (in contrast to the behavior of addCrossed(), where
#'selfing is assumed to be incidental). Note that this method is only for use in
#'nonWF models. See addCrossed() for further general notes on the addition of new
#'offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSelfed <- function(parent) {
 .P$addSelfed(parent)
}

#'SLiM method cachedFitness
#'
#'Documentation for SLiM function \code{cachedFitness}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param indices An object of type null or integer. See details for description.
#'
#'@aliases Subpopulation$cachedFitness .P$cachedFitness
#'@return An object of type float.
#'@details The fitness values calculated for the individuals at the indices
#'given are returned. If NULL is passed, fitness values for all individuals in
#'the subpopulation are returned. The fitness values returned are cached values;
#'fitness() callbacks are therefore not called as a side effect of this method.
#'It is always an error to call cachedFitness() from inside a fitness() callback,
#'since fitness values are in the middle of being set up. In WF models, it is also
#'an error to call cachedFitness() from a late() event, because fitness values
#'for the new offspring generation have not yet been calculated and are undefined.
#'In nonWF models, the population may be a mixture of new and old individuals,
#'so instead, NAN will be returned as the fitness of any new individuals whose
#'fitness has not yet been calculated. When new subpopulations are first created
#'with addSubpop() or addSubpopSplit(), the fitness of all of the newly created
#'individuals is considered to be 1.0 until fitness values are recalculated.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
cachedFitness <- function(indices) {
 .P$cachedFitness(indices)
}

#'SLiM method configureDisplay
#'
#'Documentation for SLiM function \code{configureDisplay}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param center An object of type null or float. The default value is \code{NULL}.
#'See details for description.
#'@param scale An object of type null or float. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param color An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$configureDisplay .P$configureDisplay
#'@return An object of type void.
#'@details This method customizes the display of the subpopulation in SLiMgui’s
#'Population Visualization graph. When this method is called by a model running
#'outside SLiMgui, it will do nothing except typechecking and bounds-checking
#'its arguments. When called by a model running in SLiMgui, the position,
#'size, and color of the subpopulation’s displayed circle can be controlled as
#'specified below. The center parameter sets the coordinates of the center of
#'the subpopulation’s displayed circle; it must be a float vector of length two,
#'such that center[0] provides the x-coordinate and center[1] provides the y-
#'coordinate. The square central area of the Population Visualization occupies
#'scaled coordinates in [0,1] for both x and y, so the values in center must
#'be within those bounds. If a value of NULL is provided, SLiMgui’s default
#'center will be used (which currently arranges subpopulations in a circle).
#'The scale parameter sets a scaling factor to be applied to the radius of the
#'subpopulation’s displayed circle. The default radius used by SLiMgui is a
#'function of the subpopulation’s number of individuals; this default radius is
#'then multiplied by scale. If a value of NULL is provided, the default radius
#'will be used; this is equivalent to supplying a scale of 1.0. Typically the
#'same scale value should be used by all subpopulations, to scale all of their
#'circles up or down uniformly, but that is not required. The color parameter
#'sets the color to be used for the displayed subpopulation’s circle. Colors may
#'be specified by name, or with hexadecimal RGB values of the form "#RRGGBB" (see
#'the Eidos manual). If color is NULL or the empty string, "", SLiMgui’s default
#'(fitness-based) color will be used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
configureDisplay <- function(center, scale, color) {
 .P$configureDisplay(center, scale, color)
}

#'SLiM method defineSpatialMap
#'
#'Documentation for SLiM function \code{defineSpatialMap}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param name An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param spatiality An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param gridSize An object of type null or integer. See details for description.
#'@param values An object of type numeric. See details for description.
#'@param interpolate An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param valueRange An object of type null or integer or float. The default value
#'is \code{NULL}. See details for description.
#'@param colors An object of type null or string. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Subpopulation$defineSpatialMap .P$defineSpatialMap
#'@return An object of type void.
#'@details Defines a spatial map for the subpopulation. The map will henceforth
#'be identified by name. The map uses the spatial dimensions referenced by
#'spatiality, which must be a subset of the dimensions defined for the simulation
#'in initializeSLiMOptions(). Spatiality "x" is permitted for dimensionality "x";
#'spatiality "x", "y", or "xy" for dimensionality "xy"; and spatiality "x", "y",
#'"z", "xy", "yz", "xz", or "xyz" for dimensionality "xyz". The spatial map is
#'defined by a grid of values of a size specified by gridSize, which must have
#'one value per spatial dimension (or gridSize may be NULL; see below); for a
#'spatiality of "xz", for example, gridSize must be of length 2, specifying the
#'size of the values grid in the x and z dimensions. The parameter values then
#'gives the values of the grid; it must be of length equal to the product of the
#'gridSize elements, and specifies values varying first (i.e., fastest) in the
#'x dimension, then in y, then in z. Beginning in SLiM 2.6, the values parameter
#'may be a matrix/array with the number of dimensions appropriate for the declared
#'spatiality of the map; for example, a map with spatiality "xy" would require a
#'(two-dimensional) matrix, whereas a map with spatiality of "xyz" would require
#'a threedimensional array. (See the Eidos manual for discussion of matrices and
#'arrays.) If a matrix/array argument is supplied for values, gridSize must either
#'be NULL, or (for backward compatibility) may match the dimensions of values as
#'they would be given by dim(values). The data in values is interpreted just as
#'is described above for the vector case: varying first in x, then in y, then in
#'z. BEWARE: since the values in Eidos matrices and arrays are stored in column-
#'first order (following the convention established by R), this means that for
#'a map with spatiality "xy" each column of the values matrix will provide map
#'data as x varies and y remains constant. This will be confusing if you think
#'of matrix columns as being "x” and matrix rows as being "y”, so try not to
#'think that way; the opposite is true. This behavior is actually simple, self-
#'consistent, and backward-compatible; if you before created a spatial map with
#'a vector values before and a gridSize of c(x, y) specifying the dimensions of
#'that vector, you can now supply matrix(values, nrow=x) for values to get exactly
#'the same spatial map, and you can still supply the same value of c(x, y) for
#'gridSize if you wish (or you may supply NULL). If, however, you are looking at
#'a matrix as printed in the Eidos console, and want that matrix to be used as a
#'spatial map in SLiM in the same orientation, you should use the transpose of the
#'matrix, as supplied by the t() function. Actually, since matrices are printed in
#'the console with each successive row having a larger index, whereas in Cartesian
#'(x, y) coordinates yvalues increase as you go upward, you may also wish to
#'reverse the order of rows in your matrix prior to transposing (or the order
#'of columns after transposing), with an expression such as t(map[(nrow(map)-1):
#'0,]), in order to make the spatial map display in SLiMgui as you expect (since
#'SLiMgui displays everything in Cartesian coordinates). Apologies if this is
#'confusing; it would be nice if matrix notation, programming languages, and
#'Descartes all agreed on such things, but they do not, so be very careful that
#'your spatial maps are oriented as you wish them to be! Moving on to the other
#'parameters of defineSpatialMap(): if interpolate is F, values across the
#'spatial map are not interpolated; the value at a given point is equal to the
#'nearest value defined by the grid of values specified. If interpolate is T,
#'values across the spatial map will be interpolated (using linear, bilinear,
#'or trilinear interpolation as appropriate) to produce spatially continuous
#'variation in values. In either case, the corners of the value grid are exactly
#'aligned with the corners of the spatial boundaries of the subpopulation as
#'specified by setSpatialBoundary(), and the value grid is then stretched across
#'the spatial extent of the subpopulation in such a manner as to produce equal
#'spacing between the values along each dimension. The setting of interpolation
#'only affects how values between these grid points are calculated: by nearest-
#'neighbor, or by linear interpolation. Interpolation of spatial maps with
#'periodic boundaries is not handled specially; to ensure that the edges of a
#'periodic spatial map join smoothly, simply ensure that the grid values at the
#'edges of the map are identical, since they will be coincident after periodic
#'wrapping. The valueRange and colors parameters travel together; either both
#'are unspecified, or both are specified. They control how map values will be
#'transformed into colors, by SLiMgui and by the spatialMapColor() method. The
#'valueRange parameter establishes the color-mapped range of spatial map values,
#'as a vector of length two specifying a minimum and maximum; this does not
#'need to match the actual range of values in the map. The colors parameter then
#'establishes the corresponding colors for values within the interval defined by
#'valueRange: values less than or equal to valueRange[0] will map to colors[0],
#'values greater than or equal to valueRange[1] will map to the last colors value,
#'and intermediate values will shade continuously through the specified vector
#'of colors, with interpolation between adjacent colors to produce a continuous
#'spectrum. This is much simpler than it sounds in this description; see the
#'recipes in chapter 15 for an illustration of its use. Note that at present,
#'SLiMgui will only display spatial maps of spatiality "x", "y", or "xy"; the
#'colormapping parameters will simply be ignored by SLiMgui for other spatiality
#'values (even if the spatiality is a superset of these values; SLiMgui will
#'not attempt to display an "xyz" spatial map, for example, since it has no
#'way to choose which 2D slice through the xyz space it ought to display). The
#'spatialMapColor() method will return translated color strings for any spatial
#'map, however, even if SLiMgui is unable to display the spatial map. If there are
#'multiple spatial maps with color-mapping parameters defined, SLiMgui will choose
#'just one for display; it will prefer an "xy" map if one is available, but beyond
#'that heuristic its choice will be arbitrary.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
defineSpatialMap <- function(name, spatiality, gridSize, values, interpolate,
valueRange, colors) {
 .P$defineSpatialMap(name, spatiality, gridSize, values, interpolate,
valueRange, colors)
}

#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$getValue .P$getValue
#'@return An object of type any but object.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of Subpopulation,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .P$getValue(key)
}

#'SLiM method outputMSSample
#'
#'Documentation for SLiM function \code{outputMSSample}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sampleSize An object of type integer. Must be of length 1 (a singleton).
#'See details for description.
#'@param replace An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'@param requestedSex An object of type string. Must be of length 1 (a singleton).
#'The default value is \code{"*"}. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param filterMonomorphic An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Subpopulation$outputMSSample .P$outputMSSample
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in MS format (see
#'section 25.2.2 for output format details). Positions in the output will span
#'the interval [0,1]. A sample of genomes (not entire individuals, note) of
#'size sampleSize from the subpopulation will be output. The sample may be done
#'either with or without replacement, as specified by replace; the default is to
#'sample with replacement. A particular sex of individuals may be requested for
#'the sample, for simulations in which sex is enabled, by passing "M" or "F" for
#'requestedSex; passing "*", the default, indicates that genomes from individuals
#'should be selected randomly, without respect to sex. If the sampling options
#'provided by this method are not adequate, see the outputMS() method of Genome
#'for a more flexible low-level option. If the optional parameter filePath is NULL
#'(the default), output will be sent to Eidos’s output stream (see section 4.2.1).
#'Otherwise, output will be sent to the filesystem path specified by filePath,
#'overwriting that file if append if F, or appending to the end of it if append
#'is T. If filterMonomorphic is F (the default), all mutations that are present
#'in the sample will be included in the output. This means that some mutations may
#'be included that are actually monomorphic within the sample (i.e., that exist
#'in every sampled genome, and are thus apparently fixed). These may be filtered
#'out with filterMonomorphic = T if desired; note that this option means that
#'some mutations that do exist in the sampled genomes might not be included in the
#'output, simply because they exist in every sampled genome. See outputSample()
#'and outputVCFSample() for other output formats. Output is generally done in a
#'late() event, so that the output reflects the state of the simulation at the end
#'of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputMSSample <- function(sampleSize, replace, requestedSex, filePath,
append, filterMonomorphic) {
 .P$outputMSSample(sampleSize, replace, requestedSex, filePath, append,
filterMonomorphic)
}

#'SLiM method outputSample
#'
#'Documentation for SLiM function \code{outputSample}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sampleSize An object of type integer. Must be of length 1 (a singleton).
#'See details for description.
#'@param replace An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'@param requestedSex An object of type string. Must be of length 1 (a singleton).
#'The default value is \code{"*"}. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Subpopulation$outputSample .P$outputSample
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in SLiM’s native format
#'(see section 25.2.1 for output format details). A sample of genomes (not entire
#'individuals, note) of size sampleSize from the subpopulation will be output. The
#'sample may be done either with or without replacement, as specified by replace;
#'the default is to sample with replacement. A particular sex of individuals may
#'be requested for the sample, for simulations in which sex is enabled, by passing
#'"M" or "F" for requestedSex; passing "*", the default, indicates that genomes
#'from individuals should be selected randomly, without respect to sex. If the
#'sampling options provided by this method are not adequate, see the output()
#'method of Genome for a more flexible low-level option. If the optional parameter
#'filePath is NULL (the default), output will be sent to Eidos’s output stream
#'(see section 4.2.1). Otherwise, output will be sent to the filesystem path
#'specified by filePath, overwriting that file if append if F, or appending to the
#'end of it if append is T. See outputMSSample() and outputVCFSample() for other
#'output formats. Output is generally done in a late() event, so that the output
#'reflects the state of the simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputSample <- function(sampleSize, replace, requestedSex, filePath, append)
{
 .P$outputSample(sampleSize, replace, requestedSex, filePath, append)
}

#'SLiM method outputVCFSample
#'
#'Documentation for SLiM function \code{outputVCFSample}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sampleSize An object of type integer. Must be of length 1 (a singleton).
#'See details for description.
#'@param replace An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'@param requestedSex An object of type string. Must be of length 1 (a singleton).
#'The default value is \code{"*"}. See details for description.
#'@param outputMultiallelics An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param simplifyNucleotides An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'@param outputNonnucleotides An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases Subpopulation$outputVCFSample .P$outputVCFSample
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in VCF format (see
#'sections 25.2.3 and 25.2.4 for output format details). A sample of individuals
#'(not genomes, note – unlike the outputSample() and outputMSSample() methods) of
#'size sampleSize from the subpopulation will be output. The sample may be done
#'either with or without replacement, as specified by replace; the default is to
#'sample with replacement. A particular sex of individuals may be requested for
#'the sample, for simulations in which sex is enabled, by passing "M" or "F" for
#'requestedSex; passing "*", the default, indicates that genomes from individuals
#'should be selected randomly, without respect to sex. If the sampling options
#'provided by this method are not adequate, see the outputVCF() method of Genome
#'for a more flexible low-level option. If the optional parameter filePath is
#'NULL (the default), output will be sent to Eidos’s output stream (see section
#'4.2.1). Otherwise, output will be sent to the filesystem path specified by
#'filePath, overwriting that file if append if F, or appending to the end of
#'it if append is T. The parameters outputMultiallelics, simplifyNucleotides,
#'and outputNonnucleotides affect the format of the output produced; see
#'sections 25.2.3 and 25.2.4 for further discussion. See outputMSSample() and
#'outputSample() for other output formats. Output is generally done in a late()
#'event, so that the output reflects the state of the simulation at the end of a
#'generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputVCFSample <- function(sampleSize, replace, requestedSex,
outputMultiallelics, filePath, append, simplifyNucleotides,
outputNonnucleotides) {
 .P$outputVCFSample(sampleSize, replace, requestedSex, outputMultiallelics,
filePath, append, simplifyNucleotides, outputNonnucleotides)
}

#'SLiM method pointInBounds
#'
#'Documentation for SLiM function \code{pointInBounds}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointInBounds .P$pointInBounds
#'@return An object of type logical.
#'@details Returns T if point is inside the spatial boundaries of the
#'subpopulation, F otherwise. For example, for a simulation with "xy"
#'dimensionality, if point contains exactly two values constituting an (x,y)
#'point, the result will be T if and only if ((point[0]>=x0) & (point[0]<=x1) &
#'(point[1]>=y0) & (point[1]<=y1)) given spatial bounds (x0, y0, x1, y1). This
#'method is useful for implementing absorbing or reprising boundary conditions.
#'This may only be called in simulations for which continuous space has been
#'enabled with initializeSLiMOptions(). The length of point must be an exact
#'multiple of the dimensionality of the simulation; in other words, point may
#'contain values comprising more than one point. In this case, a logical vector
#'will be returned in which each element is T if the corresponding point in point
#'is inside the spatial boundaries of the subpopulation, F otherwise.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
pointInBounds <- function(point) {
 .P$pointInBounds(point)
}

#'SLiM method pointPeriodic
#'
#'Documentation for SLiM function \code{pointPeriodic}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointPeriodic .P$pointPeriodic
#'@return An object of type float.
#'@details Returns a revised version of point that has been brought inside
#'the periodic spatial boundaries of the subpopulation (as specified by the
#'periodicity parameter of initializeSLiMOptions()) by wrapping around periodic
#'spatial boundaries. In brief, if a coordinate of point lies beyond a periodic
#'spatial boundary, that coordinate is wrapped around the boundary, so that it
#'lies inside the spatial extent by the same magnitude that it previously lay
#'outside, but on the opposite side of the space; in effect, the two edges of
#'the periodic spatial boundary are seamlessly joined. This is done iteratively
#'until all coordinates lie inside the subpopulation’s periodic boundaries. Note
#'that non-periodic spatial boundaries are not enforced by this method; they
#'should be enforced using pointReflected(), pointStopped(), or some other means
#'of enforcing boundary constraints (which can be used after pointPeriodic() to
#'bring the remaining coordinates into bounds; coordinates already brought into
#'bounds by pointPeriodic() will be unaffected by those calls). This method is
#'useful for implementing periodic boundary conditions. This may only be called
#'in simulations for which continuous space and at least one periodic spatial
#'dimension have been enabled with initializeSLiMOptions(). The length of point
#'must be an exact multiple of the dimensionality of the simulation; in other
#'words, point may contain values comprising more than one point. In this case,
#'each point will be processed as described above and a new vector containing all
#'of the processed points will be returned.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
pointPeriodic <- function(point) {
 .P$pointPeriodic(point)
}

#'SLiM method pointReflected
#'
#'Documentation for SLiM function \code{pointReflected}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointReflected .P$pointReflected
#'@return An object of type float.
#'@details Returns a revised version of point that has been brought inside
#'the spatial boundaries of the subpopulation by reflection. In brief, if
#'a coordinate of point lies beyond a spatial boundary, that coordinate is
#'reflected across the boundary, so that it lies inside the boundary by the
#'same magnitude that it previously lay outside the boundary. This is done
#'iteratively until all coordinates lie inside the subpopulation’s boundaries.
#'This method is useful for implementing reflecting boundary conditions. This
#'may only be called in simulations for which continuous space has been enabled
#'with initializeSLiMOptions(). The length of point must be an exact multiple of
#'the dimensionality of the simulation; in other words, point may contain values
#'comprising more than one point. In this case, each point will be processed as
#'described above and a new vector containing all of the processed points will be
#'returned.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
pointReflected <- function(point) {
 .P$pointReflected(point)
}

#'SLiM method pointStopped
#'
#'Documentation for SLiM function \code{pointStopped}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointStopped .P$pointStopped
#'@return An object of type float.
#'@details Returns a revised version of point that has been brought inside the
#'spatial boundaries of the subpopulation by clamping. In brief, if a coordinate
#'of point lies beyond a spatial boundary, that coordinate is set to exactly the
#'position of the boundary, so that it lies on the edge of the spatial boundary.
#'This method is useful for implementing stopping boundary conditions. This may
#'only be called in simulations for which continuous space has been enabled with
#'initializeSLiMOptions(). The length of point must be an exact multiple of the
#'dimensionality of the simulation; in other words, point may contain values
#'comprising more than one point. In this case, each point will be processed as
#'described above and a new vector containing all of the processed points will be
#'returned.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
pointStopped <- function(point) {
 .P$pointStopped(point)
}

#'SLiM method pointUniform
#'
#'Documentation for SLiM function \code{pointUniform}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param n An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases Subpopulation$pointUniform .P$pointUniform
#'@return An object of type float.
#'@details Returns a new point (or points, for n > 1) generated from uniform draws
#'for each coordinate, within the spatial boundaries of the subpopulation. The
#'returned vector will contain n points, each comprised of a number of coordinates
#'equal to the dimensionality of the simulation, so it will be of total length
#'n*dimensionality. This may only be called in simulations for which continuous
#'space has been enabled with initializeSLiMOptions().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
pointUniform <- function(n) {
 .P$pointUniform(n)
}

#'SLiM method removeSubpopulation
#'
#'Documentation for SLiM function \code{removeSubpopulation}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases Subpopulation$removeSubpopulation .P$removeSubpopulation
#'@return An object of type void.
#'@details Removes this subpopulation from the model. The subpopulation is
#'immediately removed from the list of active subpopulations, and the symbol
#'representing the subpopulation is undefined. The subpopulation object itself
#'remains unchanged until children are next generated (at which point it is
#'deallocated), but it is no longer part of the simulation and should not be
#'used. Note that this method is only for use in nonWF models, in which there
#'is a distinction between a subpopulation being empty and a subpopulation being
#'removed from the simulation; an empty subpopulation may be re-colonized by
#'migrants, whereas as a removed subpopulation no longer exists at all. WF models
#'do not make this distinction; when a subpopulation is empty it is automatically
#'removed. WF models should therefore call setSubpopulationSize(0) instead of this
#'method; setSubpopulationSize() is the standard way for WF models to change the
#'subpopulation size, including to a size of 0.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
removeSubpopulation <- function(void) {
 .P$removeSubpopulation(void)
}

#'SLiM method sampleIndividuals
#'
#'Documentation for SLiM function \code{sampleIndividuals}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param replace An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param exclude An object of type null or Individual object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'@param sex An object of type null or string. Must be of length 1 (a singleton).
#'The default value is \code{NULL],[Ni$ tag = NULL}. See details for description.
#'@param minAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param maxAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param migrant An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$sampleIndividuals .P$sampleIndividuals
#'@return An object of type Individual object.
#'@details Returns a vector of individuals, of size less than or equal to
#'parameter size, sampled from the individuals in the target subpopulation.
#'Sampling is done without replacement if replace is F (the default), or with
#'replacement if replace is T. The remaining parameters specify constraints upon
#'the pool of individuals that will be considered candidates for the sampling.
#'Parameter exclude, if non- NULL, may specify a specific individual that
#'should not be considered a candidate (typically the focal individual in some
#'operation). Parameter sex, if non-NULL, may specify a sex ("M" or "F") for
#'the individuals to be drawn, in sexual models. Parameter tag, if non-NULL, may
#'specify a tag value for the individuals to be drawn; only individuals whose tag
#'property matches this value will be candidates. Parameters minAge and maxAge, if
#'non-NULL, may specify a minimum or maximum age for the individuals to be drawn,
#'in nonWF models. Parameter migrant, if non-NULL, may specify a required value
#'for the migrant property of the individuals to be drawn (so T will require that
#'individuals be migrants, F will require that they not be). If the candidate
#'pool is smaller than the requested sample size, all eligible candidates will be
#'returned (in randomized order); the result will be a zero-length vector if no
#'eligible candidates exist (unlike sample()). This method is similar to getting
#'the individuals property of the subpopulation, using operator [] to select only
#'individuals with the desired properties, and then using sample() to sample from
#'that candidate pool. However, besides being much simpler than the equivalent
#'Eidos code, it is also much faster, and it does not fail if less than the full
#'sample size is available. See subsetIndividuals() for a similar method that
#'returns a full subset, rather than a sample.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
sampleIndividuals <- function(size, replace, exclude, sex, minAge, maxAge,
migrant) {
 .P$sampleIndividuals(size, replace, exclude, sex, minAge, maxAge, migrant)
}

#'SLiM method setCloningRate
#'
#'Documentation for SLiM function \code{setCloningRate}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rate An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setCloningRate .P$setCloningRate
#'@return An object of type void.
#'@details Set the cloning rate of this subpopulation. The rate is changed to
#'rate, which should be between 0.0 and 1.0, inclusive. Clonal reproduction can
#'be enabled in both non-sexual (i.e. hermaphroditic) and sexual simulations. In
#'non-sexual simulations, rate must be a singleton value representing the overall
#'clonal reproduction rate for the subpopulation. In sexual simulations, rate
#'may be either a singleton (specifying the clonal reproduction rate for both
#'sexes) or a vector containing two numeric values (the female and male cloning
#'rates specified separately, at indices 0 and 1 respectively). During mating and
#'offspring generation, the probability that any given offspring individual will
#'be generated by cloning – by asexual reproduction without gametes or meiosis –
#'will be equal to the cloning rate (for its sex, in sexual simulations) set in
#'the parental (not the offspring!) subpopulation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setCloningRate <- function(rate) {
 .P$setCloningRate(rate)
}

#'SLiM method setMigrationRates
#'
#'Documentation for SLiM function \code{setMigrationRates}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sourceSubpops An object of type integer or Subpopulation object. See
#'details for description.
#'@param rates An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setMigrationRates .P$setMigrationRates
#'@return An object of type void.
#'@details Set the migration rates to this subpopulation from the subpopulations
#'in sourceSubpops to the corresponding rates specified in rates; in other words,
#'rates gives the expected fractions of the children in this subpopulation that
#'will subsequently be generated from parents in the subpopulations sourceSubpops
#'(see section 21.2.1). This method will only set the migration fractions from
#'the subpopulations given; migration rates from other subpopulations will be
#'left unchanged (explicitly set a zero rate to turn off migration from a given
#'subpopulation). The type of sourceSubpops may be either integer, specifying
#'subpopulations by identifier, or object, specifying subpopulations directly.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMigrationRates <- function(sourceSubpops, rates) {
 .P$setMigrationRates(sourceSubpops, rates)
}

#'SLiM method setSelfingRate
#'
#'Documentation for SLiM function \code{setSelfingRate}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param rate An object of type numeric. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSelfingRate .P$setSelfingRate
#'@return An object of type void.
#'@details Set the selfing rate of this subpopulation. The rate is changed to
#'rate, which should be between 0.0 and 1.0, inclusive. Selfing can only be
#'enabled in non-sexual (i.e. hermaphroditic) simulations. During mating and
#'offspring generation, the probability that any given offspring individual will
#'be generated by selfing – by self-fertilization via gametes produced by meiosis
#'by a single parent – will be equal to the selfing rate set in the parental (not
#'the offspring!) subpopulation (see section 21.2.1).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSelfingRate <- function(rate) {
 .P$setSelfingRate(rate)
}

#'SLiM method setSexRatio
#'
#'Documentation for SLiM function \code{setSexRatio}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSexRatio .P$setSexRatio
#'@return An object of type void.
#'@details Set the sex ratio of this subpopulation to sexRatio. As defined
#'in SLiM, this is actually the fraction of the subpopulation that is male;
#'in other words, the M:(M+F) ratio. This will take effect when children are
#'next generated; it does not change the current subpopulation state. Unlike
#'the selfing rate, the cloning rate, and migration rates, the sex ratio is
#'deterministic: SLiM will generate offspring that exactly satisfy the requested
#'sex ratio (within integer roundoff limits). See section 21.2.1 for further
#'details.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSexRatio <- function(sexRatio) {
 .P$setSexRatio(sexRatio)
}

#'SLiM method setSpatialBounds
#'
#'Documentation for SLiM function \code{setSpatialBounds}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param bounds An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setSpatialBounds .P$setSpatialBounds
#'@return An object of type void.
#'@details Set the spatial boundaries of the subpopulation to bounds. This
#'method may be called only for simulations in which continuous space has been
#'enabled with initializeSLiMOptions(). The length of bounds must be double the
#'spatial dimensionality, so that it supplies both minimum and maximum values
#'for each coordinate. More specifically, for a dimensionality of "x", bounds
#'should supply (x0, x1) values; for dimensionality "xy" it should supply (x0,
#'y0, x1, y1) values; and for dimensionality "xyz" it should supply (x0, y0,
#'z0, x1, y1, z1) (in that order). These boundaries will be used by SLiMgui to
#'calibrate the display of the subpopulation, and will be used by methods such
#'as pointInBounds(), pointReflected(), pointStopped(), and pointUniform(). The
#'default spatial boundaries for all subpopulations span the interval [0,1] in
#'each dimension. Spatial dimensions that are periodic (as established with the
#'periodicity parameter to initializeSLiMOptions()) must have a minimum coordinate
#'value of 0.0 (a restriction that allows the handling of periodicity to be
#'somewhat more efficient). The current spatial bounds for the subpopulation may
#'be obtained through the spatialBounds property.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSpatialBounds <- function(bounds) {
 .P$setSpatialBounds(bounds)
}

#'SLiM method setSubpopulationSize
#'
#'Documentation for SLiM function \code{setSubpopulationSize}, which is a method
#'of the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSubpopulationSize .P$setSubpopulationSize
#'@return An object of type void.
#'@details Set the size of this subpopulation to size individuals. This
#'will take effect when children are next generated; it does not change the
#'current subpopulation state. Setting a subpopulation to a size of 0 does
#'have some immediate effects that serve to disconnect it from the simulation:
#'the subpopulation is removed from the list of active subpopulations, the
#'subpopulation is removed as a source of migration for all other subpopulations,
#'and the symbol representing the subpopulation is undefined. In this case, the
#'subpopulation itself remains unchanged until children are next generated (at
#'which point it is deallocated), but it is no longer part of the simulation and
#'should not be used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSubpopulationSize <- function(size) {
 .P$setSubpopulationSize(size)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases Subpopulation$setValue .P$setValue
#'@return An object of type void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'Subpopulation, SLiMEidosDictionary, although that fact is not presently visible
#'in Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .P$setValue(key, value)
}

#'SLiM method spatialMapColor
#'
#'Documentation for SLiM function \code{spatialMapColor}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param name An object of type string or numeric. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or numeric. See details for description.
#'
#'@aliases Subpopulation$spatialMapColor .P$spatialMapColor
#'@return An object of type string.
#'@details Looks up the spatial map indicated by name, and uses its color-
#'translation machinery (as defined by the valueRange and colors parameters to
#'defineSpatialMap()) to translate each element of value into a corresponding
#'color string. If the spatial map does not have color-translation capabilities,
#'an error will result. See the documentation for defineSpatialMap() for
#'information regarding the details of color translation. See the Eidos manual for
#'further information on color strings.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
spatialMapColor <- function(name, value) {
 .P$spatialMapColor(name, value)
}

#'SLiM method spatialMapValue
#'
#'Documentation for SLiM function \code{spatialMapValue}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param name An object of type string or float. Must be of length 1 (a
#'singleton). See details for description.
#'@param point An object of type string or float. See details for description.
#'
#'@aliases Subpopulation$spatialMapValue .P$spatialMapValue
#'@return An object of type float.
#'@details Looks up the spatial map indicated by name, and uses its mapping
#'machinery (as defined by the gridSize, values, and interpolate parameters to
#'defineSpatialMap()) to translate the coordinates of point into a corresponding
#'map value. The length of point must be equal to the spatiality of the spatial
#'map; in other words, for a spatial map with spatiality "xz", point must be
#'of length 2, specifying the x and z coordinates of the point to be evaluated.
#'Interpolation will automatically be used if it was enabled for the spatial map.
#'Point coordinates are clamped into the range defined by the spatial boundaries,
#'even if the spatial boundaries are periodic; use pointPeriodic() to wrap the
#'point coordinates first if desired. See the documentation for defineSpatialMap()
#'for information regarding the details of value mapping. Beginning in SLiM 3.3,
#'point may contain more than one point to be looked up. In this case, the length
#'of point must be an exact multiple of the spatiality of the spatial map; for a
#'spatial map with spatiality "xz", for example, the length of point must be an
#'exact multiple of 2, and successive pairs of elements from point (elements 0 and
#'1, then elements 2 and 3, etc.) will be taken as the x and z coordinates of the
#'points to be evaluated. This allows spatialMapValue() to be used in a vectorized
#'fashion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
spatialMapValue <- function(name, point) {
 .P$spatialMapValue(name, point)
}

#'SLiM method subsetIndividuals
#'
#'Documentation for SLiM function \code{subsetIndividuals}, which is a method of
#'the SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param exclude An object of type null or Individual object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'@param sex An object of type null or string. Must be of length 1 (a singleton).
#'The default value is \code{NULL],[Ni$ tag = NULL}. See details for description.
#'@param minAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param maxAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param migrant An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$subsetIndividuals .P$subsetIndividuals
#'@return An object of type Individual object.
#'@details Returns a vector of individuals subset from the individuals in the
#'target subpopulation. The parameters specify constraints upon the subset
#'of individuals that will be returned. Parameter exclude, if non- NULL, may
#'specify a specific individual that should not be included (typically the focal
#'individual in some operation). Parameter sex, if non-NULL, may specify a sex
#'("M" or "F") for the individuals to be returned, in sexual models. Parameter
#'tag, if non-NULL, may specify a tag value for the individuals to be returned;
#'only individuals whose tag property matches this value will be returned.
#'Parameters minAge and maxAge, if non-NULL, may specify a minimum or maximum age
#'for the individuals to be returned, in nonWF models. Parameter migrant, if non-
#'NULL, may specify a required value for the migrant property of the individuals
#'to be returned (so T will require that individuals be migrants, F will require
#'that they not be). This method is shorthand for getting the individuals property
#'of the subpopulation, and then using operator [] to select only individuals with
#'the desired properties; besides being much simpler than the equivalent Eidos
#'code, it is also much faster. See sampleIndividuals() for a similar method that
#'returns a sample taken from a chosen subset of individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
subsetIndividuals <- function(exclude, sex, minAge, maxAge, migrant) {
 .P$subsetIndividuals(exclude, sex, minAge, maxAge, migrant)
}

#'SLiM method takeMigrants
#'
#'Documentation for SLiM function \code{takeMigrants}, which is a method of the
#'SLiM class \code{Subpopulation}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param migrants An object of type Individual object. See details for
#'description.
#'
#'@aliases Subpopulation$takeMigrants .P$takeMigrants
#'@return An object of type void.
#'@details Immediately moves the individuals in migrants to the target
#'subpopulation (removing them from their previous subpopulation). Individuals in
#'migrants that are already in the target subpopulation are unaffected. Note that
#'the indices and order of individuals and genomes in both the target and source
#'subpopulations will change unpredictably as a side effect of this method. Note
#'that this method is only for use in nonWF models, in which migration is managed
#'manually by the model script. In WF models, migration is managed automatically
#'by the SLiM core based upon the migration rates set for each subpopulation with
#'setMigrationRates().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
takeMigrants <- function(migrants) {
 .P$takeMigrants(migrants)
}



#'SLiM method getValue
#'
#'Documentation for SLiM function \code{getValue}, which is a method of the SLiM
#'class \code{Substitution}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Substitution$getValue .S$getValue
#'@return An object of type any but object or void.
#'@details Returns the value previously set for the dictionary entry identifier
#'key using setValue(), or NULL if no value has been set. This dictionary-
#'style functionality is actually provided by the superclass of Substitution,
#'SLiMEidosDictionary, although that fact is not presently visible in Eidos since
#'superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
getValue <- function(key) {
 .S$getValue(key)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{Substitution}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param key An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or any but object. See details for
#'description.
#'
#'@aliases Substitution$setValue .S$setValue
#'@return An object of type any but object or void.
#'@details Sets a value for the dictionary entry identifier key. The value, which
#'may be of any type other than object, can be fetched later using getValue().
#'This dictionary-style functionality is actually provided by the superclass of
#'Substitution, SLiMEidosDictionary, although that fact is not presently visible
#'in Eidos since superclasses are not introspectable.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .S$setValue(key, value)
}



#'SLiM method codonsToAminoAcids
#'
#'Documentation for SLiM function \code{codonsToAminoAcids}, which is a method of
#'the SLiM class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param codons An object of type integer or logical or logical. See details for
#'description.
#'@param long An object of type integer or logical or logical. Must be of length 1
#'(a singleton). The default value is \code{F}. See details for description.
#'@param paste An object of type integer or logical or logical. Must be of length
#'1 (a singleton). The default value is \code{T}. See details for description.
#'
#'@aliases SLiMBuiltin$codonsToAminoAcids .SB$codonsToAminoAcids
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details Returns the amino acid sequence corresponding to the codon sequence
#'in codons. Codons should be represented with values in [0, 63] where AAA is 0,
#'AAC is 1, AAG is 2, and TTT is 63; see ancestralNucleotides() for discussion
#'of this encoding. If long is F (the default), the standard single-letter
#'codes for amino acids will be used (where Serine is "S", etc.); if long is T,
#'the standard three-letter codes will be used instead (where Serine is "Ser",
#'etc.). When paste is T (the default), the amino acid sequence returned will
#'be a singleton string, such as "LYATI" (when long is F) or "Leu-Tyr-Ala-Thr-
#'Ile" (when long is T). When paste is F, the amino acid sequence will instead
#'be returned as a string vector, with one element per amino acid, such as "L"
#'"Y" "A" "T" "I" (when long is F) or "Leu" "Tyr" "Ala" "Thr" "Ile" (when long
#'is T). Using the paste=T option is considerably faster than using paste()
#'in script. This function interprets the supplied codon sequence as the sense
#'strand (i.e., the strand that is not transcribed, and which mirrors the mRNA’s
#'sequence). This uses the standard DNA codon table directly. For example,
#'if the nucleotide sequence is CAA TTC, that will correspond to a codon
#'vector of 16 61, and will result in the amino acid sequence Gln-Phe ("QF").
#'(is)codonsToNucleotides(integer codons, [string$ format = "string"]) Returns
#'the nucleotide sequence corresponding to the codon sequence supplied in codons.
#'Codons should be represented with values in [0, 63] where AAA is 0, AAC is
#'1, AAG is 2, and TTT is 63; see ancestralNucleotides() for discussion of this
#'encoding. The format parameter controls the format of the returned sequence. It
#'may be "string" to obtain the sequence as a singleton string (e.g., "TATACG"),
#'"char" to obtain it as a string vector of single characters (e.g., "T", "A",
#'"T", "A", "C", "G"), or "integer" to obtain it as an integer vector (e.g., 3, 0,
#'3, 0, 1, 2), using SLiM’s standard code of A=0, C=1, G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
codonsToAminoAcids <- function(codons, long, paste) {
 .SB$codonsToAminoAcids(codons, long, paste)
}

#'SLiM method mm16To256
#'
#'Documentation for SLiM function \code{mm16To256}, which is a method of the SLiM
#'class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param mutationMatrix16 An object of type float. See details for description.
#'
#'@aliases SLiMBuiltin$mm16To256 .SB$mm16To256
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details Returns a 64×4 mutation matrix that is functionally identical to
#'the supplied 4×4 mutation matrix in mutationMatrix16. The mutation rate for
#'each of the 64 trinucleotides will depend only upon the central nucleotide
#'of the trinucleotide, and will be taken from the corresponding entry for
#'the same nucleotide in mutationMatrix16. This function can be used to easily
#'construct a simple trinucleotide-based mutation matrix which can then be
#'modified so that specific trinucleotides sustain a mutation rate that does
#'not depend only upon their central nucleotide. See the documentation for
#'initializeGenomicElementType() in section 23.1 for further discussion of how
#'these 64×4 mutation matrices are interpreted and used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
mm16To256 <- function(mutationMatrix16) {
 .SB$mm16To256(mutationMatrix16)
}

#'SLiM method mmJukesCantor
#'
#'Documentation for SLiM function \code{mmJukesCantor}, which is a method of the
#'SLiM class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param alpha An object of type float. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases SLiMBuiltin$mmJukesCantor .SB$mmJukesCantor
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details Returns a mutation matrix representing a Jukes–Cantor (1969) model with
#'mutation rate alpha to each possible alternative nucleotide at a site: This 2×2
#'matrix is suitable for use with initializeGenomicElementType(). Note that the
#'actual mutation rate produced by this matrix is 3*alpha. 0 α α α α 0 α α α α 0 α
#'α α α 0
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
mmJukesCantor <- function(alpha) {
 .SB$mmJukesCantor(alpha)
}

#'SLiM method mmKimura
#'
#'Documentation for SLiM function \code{mmKimura}, which is a method of the SLiM
#'class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param alpha An object of type float or float. Must be of length 1 (a
#'singleton). See details for description.
#'@param beta An object of type float or float. Must be of length 1 (a singleton).
#'See details for description.
#'
#'@aliases SLiMBuiltin$mmKimura .SB$mmKimura
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details Returns a mutation matrix representing a Kimura (1980) model with
#'transition rate alpha and transversion rate beta: This 2×2 matrix is suitable
#'for use with initializeGenomicElementType(). Note that the actual mutation rate
#'produced by this model is alpha+2*beta.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
mmKimura <- function(alpha, beta) {
 .SB$mmKimura(alpha, beta)
}

#'SLiM method nucleotideCounts
#'
#'Documentation for SLiM function \code{nucleotideCounts}, which is a method of
#'the SLiM class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotideCounts .SB$nucleotideCounts
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details A convenience function that returns an integer vector of length four,
#'providing the number of occurrences of A / C / G / T nucleotides, respectively,
#'in the supplied nucleotide sequence. The parameter sequence may be a singleton
#'string (e.g., "TATA"), a string vector of single characters (e.g., "T", "A",
#'"T", "A"), or an integer vector (e.g., 3, 0, 3, 0), using SLiM’s standard code
#'of A=0, C=1, G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
nucleotideCounts <- function(sequence) {
 .SB$nucleotideCounts(sequence)
}

#'SLiM method nucleotideFrequencies
#'
#'Documentation for SLiM function \code{nucleotideFrequencies}, which is a method
#'of the SLiM class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotideFrequencies .SB$nucleotideFrequencies
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details A convenience function that returns a float vector of length four,
#'providing the frequencies of occurrences of A / C / G / T nucleotides,
#'respectively, in the supplied nucleotide sequence. The parameter sequence may be
#'a singleton string (e.g., "TATA"), a string vector of single characters (e.g.,
#'"T", "A", "T", "A"), or an integer vector (e.g., 3, 0, 3, 0), using SLiM’s
#'standard code of A=0, C=1, G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
nucleotideFrequencies <- function(sequence) {
 .SB$nucleotideFrequencies(sequence)
}

#'SLiM method nucleotidesToCodons
#'
#'Documentation for SLiM function \code{nucleotidesToCodons}, which is a method of
#'the SLiM class \code{SLiMBuiltin}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotidesToCodons .SB$nucleotidesToCodons
#'@return An object of type string or float or float or float or integer or float
#'or integer.
#'@details Returns the codon sequence corresponding to the nucleotide sequence
#'in sequence. The codon sequence is an integer vector with values from 0 to 63,
#'based upon successive nucleotide triplets in the nucleotide sequence. The codon
#'value for a given nucleotide triplet XYZ is 16X + 4Y + Z, where X, Y, and Z have
#'the usual values A=0, C=1, G=2, T=3. For example, the triplet AAA has a codon
#'value of 0, AAC is 1, AAG is 2, AAT is 3, ACA is 4, and on upward to TTT which
#'is 63. If the nucleotide sequence AACACATTT is passed in, the codon vector 1 4
#'63 will therefore be returned. These codon values can be useful in themselves;
#'they can also be passed to codonsToAminoAcids() to translate them into the
#'corresponding amino acid sequence if desired. The nucleotide sequence in
#'sequence may be supplied in any of three formats: a string vector with single-
#'letter nucleotides (e.g., "T", "A", "T", "A"), a singleton string of nucleotide
#'letters (e.g., "TATA"), or an integer vector of nucleotide values (e.g., 3,
#'0, 3, 0) using SLiM’s standard code of A=0, C=1, G=2, T=3. If the choice of
#'format is not driven by other considerations, such as ease of manipulation,
#'then the singleton string format will certainly be the most memory-efficient for
#'long sequences, and will probably also be the fastest. The nucleotide sequence
#'provided must be a multiple of three in length, so that it translates to an
#'integral number of codons. (is)randomNucleotides(integer$ length, [Nif basis =
#'NULL], [string$ format = "string"]) Generates a new random nucleotide sequence
#'with length bases. The four nucleotides ACGT are equally probable if basis
#'is NULL (the default); otherwise, basis may be a 4-element integer or float
#'vector providing relative fractions for A, C, G, and T respectively (these need
#'not sum to 1.0, as they will be normalized). More complex generative models
#'such as Markov processes are not supported intrinsically in SLiM at this time,
#'but arbitrary generated sequences may always be loaded from files on disk.
#'The format parameter controls the format of the returned sequence. It may be
#'"string" to obtain the generated sequence as a singleton string (e.g., "TATA"),
#'"char" to obtain it as a string vector of single characters (e.g., "T", "A",
#'"T", "A"), or "integer" to obtain it as an integer vector (e.g., 3, 0 β α β β 0
#'β α α β 0 β β α β 0 0, 3, 0), using SLiM’s standard code of A=0, C=1, G=2, T=3.
#'For passing directly to initializeAncestralNucleotides(), format "string" (a
#'singleton string) will certainly be the most memory-efficient, and probably
#'also the fastest. Memory efficiency can be a significant consideration; the
#'nucleotide sequence for a chromosome of length 109 will occupy approximately 1
#'GB of memory when stored as a singleton string (with one byte per nucleotide),
#'and much more if stored in the other formats. However, the other formats can
#'be easier to work with in Eidos, and so may be preferable for relatively short
#'chromosomes if you are manipulating the generated sequence.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016–2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
nucleotidesToCodons <- function(sequence) {
 .SB$nucleotidesToCodons(sequence)
}







#'Initialize
#'
#'Documentation for Initialize class from SLiM
#'
#'@aliases .Init
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{initializeAncestralNucleotides}}}
#'\item{\code{\link{initializeGeneConversion}}}
#'\item{\code{\link{initializeGenomicElement}}}
#'\item{\code{\link{initializeGenomicElementType}}}
#'\item{\code{\link{initializeHotspotMap}}}
#'\item{\code{\link{initializeInteractionType}}}
#'\item{\code{\link{initializeMutationRate}}}
#'\item{\code{\link{initializeMutationType}}}
#'\item{\code{\link{initializeMutationTypeNuc}}}
#'\item{\code{\link{initializeRecombinationRate}}}
#'\item{\code{\link{initializeSex}}}
#'\item{\code{\link{initializeSLiMModelType}}}
#'\item{\code{\link{initializeSLiMOptions}}}
#'\item{\code{\link{initializeTreeSeq}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{None.}{This class has no properties.}
#'}
'Initialize'
#'Chromosome
#'
#'Documentation for Chromosome class from SLiM
#'
#'@aliases .c
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{ancestralNucleotides}}}
#'\item{\code{\link{drawBreakpoints}}}
#'\item{\code{\link{setAncestralNucleotides}}}
#'\item{\code{\link{setGeneConversion}}}
#'\item{\code{\link{setHotspotMap}}}
#'\item{\code{\link{setMutationRate}}}
#'\item{\code{\link{setRecombinationRate}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{colorSubstitution}{A property of type string. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} The color used to display substitutions in SLiMgui when both
#'mutations and substitutions are being displayed in the chromosome view.
#'Outside of SLiMgui, this property still exists, but is not used by SLiM.
#'Colors may be specified by name, or with hexadecimal RGB values of the form
#'"#RRGGBB" (see the Eidos manual). If colorSubstitution is the empty string,
#'"", SLiMgui will defer to the color scheme of each MutationType, just as
#'it does when only substitutions are being displayed. The default, "3333FF",
#'causes all substitutions to be shown as dark blue when displayed in conjunction
#'with mutations, to prevent the view from becoming too noisy. Note that when
#'substitutions are displayed without mutations also being displayed, this
#'value is ignored by SLiMgui and the substitutions use the color scheme of each
#'MutationType. }
#'\item{geneConversionEnabled}{A property of type logical. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} When gene conversion has been enabled by calling
#'initializeGeneConversion(), switching to the DSB recombination model, this
#'property is T; otherwise, when using the crossover breakpoints model, it is F. }
#'\item{geneConversionGCBias}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The gene conversion bias coefficient, which
#'expresses a bias in the resolution of heteroduplex mismatches in complex
#'gene conversion tracts. When gene conversion has not been enabled by calling
#'initializeGeneConversion(), this property will be unavailable. }
#'\item{geneConversionNonCrossoverFraction}{A property of type float. It is of
#'length one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The fraction of double-stranded breaks that
#'result in non-crossover events. When gene conversion has not been enabled by
#'calling initializeGeneConversion(), this property will be unavailable. }
#'\item{geneConversionMeanLength}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The mean length of a gene conversion tract
#'(in base positions). When gene conversion has not been enabled by calling
#'initializeGeneConversion(), this property will be unavailable. }
#'\item{geneConversionSimpleConversionFraction}{A property of type float. It is of
#'length one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The fraction of gene conversion tracts that
#'are "simple” (i.e., not involving resolution of heteroduplex mismatches);
#'the remainder will be "complex”. When gene conversion has not been enabled by
#'calling initializeGeneConversion(), this property will be unavailable. }
#'\item{genomicElements}{A property of type GenomicElement object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} All of
#'the GenomicElement objects that comprise the chromosome. }
#'\item{hotspotEndPositions}{A property of type integer. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for hotspot map regions along the chromosome. Each hotspot map
#'region is assumed to start at the position following the end of the previous
#'hotspot map region; in other words, the regions are assumed to be contiguous.
#'When using sex-specific hotspot maps, this property will unavailable; see
#'hotspotEndPositionsF and hotspotEndPositionsM. }
#'\item{hotspotEndPositionsF}{A property of type integer. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for hotspot map regions for females, when using sex-specific hotspot
#'maps; unavailable otherwise. See hotspotEndPositions for further explanation. }
#'\item{hotspotEndPositionsM}{A property of type integer. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for hotspot map regions for males, when using sex-specific hotspot
#'maps; unavailable otherwise. See hotspotEndPositions for further explanation. }
#'\item{hotspotMultipliers}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The hotspot multiplier
#'for each of the hotspot map regions specified by hotspotEndPositions. When
#'using sex-specific hotspot maps, this property will be unavailable; see
#'hotspotMultipliersF and hotspotMultipliersM. }
#'\item{hotspotMultipliersF}{A property of type float. This property is
#'a constant, so it is not modifiable. \strong{Property Description:}
#'The hotspot multiplier for each of the hotspot map regions specified by
#'hotspotEndPositionsF, when using sex-specific hotspot maps; unavailable
#'otherwise. }
#'\item{hotspotMultipliersM}{A property of type float. This property is
#'a constant, so it is not modifiable. \strong{Property Description:}
#'The hotspot multiplier for each of the hotspot map regions specified by
#'hotspotEndPositionsM, when using sex-specific hotspot maps; unavailable
#'otherwise. }
#'\item{lastPosition}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The last valid position in the chromosome; its
#'length, essentially. }
#'\item{mutationEndPositions}{A property of type integer. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for mutation rate regions along the chromosome. Each mutation rate
#'region is assumed to start at the position following the end of the previous
#'mutation rate region; in other words, the regions are assumed to be contiguous.
#'When using sex-specific mutation rate maps, this property will unavailable; see
#'mutationEndPositionsF and mutationEndPositionsM. This property is unavailable in
#'nucleotide-based models. }
#'\item{mutationEndPositionsF}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for mutation rate regions for females, when using sex-specific
#'mutation rate maps; unavailable otherwise. See mutationEndPositions for further
#'explanation. This property is unavailable in nucleotide-based models. }
#'\item{mutationEndPositionsM}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'end positions for mutation rate regions for males, when using sex-specific
#'mutation rate maps; unavailable otherwise. See mutationEndPositions for further
#'explanation. This property is unavailable in nucleotide-based models. }
#'\item{mutationRates}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The mutation rate
#'for each of the mutation rate regions specified by mutationEndPositions. When
#'using sex-specific mutation rate maps, this property will be unavailable; see
#'mutationRatesF and mutationRatesM. This property is unavailable in nucleotide-
#'based models. }
#'\item{mutationRatesF}{A property of type float. This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The mutation rate for each
#'of the mutation rate regions specified by mutationEndPositionsF, when using sex-
#'specific mutation rate maps; unavailable otherwise. This property is unavailable
#'in nucleotide-based models. }
#'\item{mutationRatesM}{A property of type float. This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The mutation rate for each
#'of the mutation rate regions specified by mutationEndPositionsM, when using sex-
#'specific mutation rate maps; unavailable otherwise. This property is unavailable
#'in nucleotide-based models. }
#'\item{overallMutationRate}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall mutation rate across the whole
#'chromosome determining the overall number of mutation events that will occur
#'anywhere in the chromosome, as calculated from the individual mutation ranges
#'and rates as well as the coverage of the chromosome by genomic elements (since
#'mutations are only generated within genomic elements, regardless of the mutation
#'rate map). When using sexspecific mutation rate maps, this property will
#'unavailable; see overallMutationRateF and overallMutationRateM. This property is
#'unavailable in nucleotide-based models. }
#'\item{overallMutationRateF}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall mutation rate for females, when using
#'sex-specific mutation rate maps; unavailable otherwise. See overallMutationRate
#'for further explanation. This property is unavailable in nucleotide-based
#'models. }
#'\item{overallMutationRateM}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall mutation rate for males, when using
#'sex-specific mutation rate maps; unavailable otherwise. See overallMutationRate
#'for further explanation. This property is unavailable in nucleotide-based
#'models. }
#'\item{overallRecombinationRate}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall recombination rate across the
#'whole chromosome determining the overall number of recombination events that
#'will occur anywhere in the chromosome, as calculated from the individual
#'recombination ranges and rates. When using sex-specific recombination
#'maps, this property will unavailable; see overallRecombinationRateF and
#'overallRecombinationRateM. }
#'\item{overallRecombinationRateF}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall recombination rate for females,
#'when using sex-specific recombination maps; unavailable otherwise. See
#'overallRecombinationRate for further explanation. }
#'\item{overallRecombinationRateM}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall recombination rate for males,
#'when using sex-specific recombination maps; unavailable otherwise. See
#'overallRecombinationRate for further explanation. }
#'\item{recombinationEndPositions}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The end
#'positions for recombination regions along the chromosome. Each recombination
#'region is assumed to start at the position following the end of the previous
#'recombination region; in other words, the regions are assumed to be contiguous.
#'When using sex-specific recombination maps, this property will unavailable; see
#'recombinationEndPositionsF and recombinationEndPositionsM. }
#'\item{recombinationEndPositionsF}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'end positions for recombination regions for females, when using sex-specific
#'recombination maps; unavailable otherwise. See recombinationEndPositions for
#'further explanation. }
#'\item{recombinationEndPositionsM}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'end positions for recombination regions for males, when using sex-specific
#'recombination maps; unavailable otherwise. See recombinationEndPositions for
#'further explanation. }
#'\item{recombinationRates}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The recombination rate
#'for each of the recombination regions specified by recombinationEndPositions.
#'When using sex-specific recombination maps, this property will unavailable; see
#'recombinationRatesF and recombinationRatesM. }
#'\item{recombinationRatesF}{A property of type float. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'recombination rate for each of the recombination regions specified by
#'recombinationEndPositionsF, when using sex-specific recombination maps;
#'unavailable otherwise. }
#'\item{recombinationRatesM}{A property of type float. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'recombination rate for each of the recombination regions specified by
#'recombinationEndPositionsM, when using sex-specific recombination maps;
#'unavailable otherwise. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use.}
#'
#'}
'Chromosome'
#'Genome
#'
#'Documentation for Genome class from SLiM
#'
#'@aliases .G
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addMutations}}}
#'\item{\code{\link{addNewDrawnMutation}}}
#'\item{\code{\link{addNewMutation}}}
#'\item{\code{\link{containsMarkerMutation}}}
#'\item{\code{\link{containsMutations}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{mutationsOfType}}}
#'\item{\code{\link{nucleotides}}}
#'\item{\code{\link{output}}}
#'\item{\code{\link{outputMS}}}
#'\item{\code{\link{outputVCF}}}
#'\item{\code{\link{positionsOfMutationsOfType}}}
#'\item{\code{\link{readFromMS}}}
#'\item{\code{\link{readFromVCF}}}
#'\item{\code{\link{removeMutations}}}
#'\item{\code{\link{sumOfMutationsOfType}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{genomePedigreeID}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If pedigree tracking is turned on with
#'initializeSLiMOptions(keepPedigrees=T), genomePedigreeID is a unique non-
#'negative identifier for each genome in a simulation, never reused throughout
#'the duration of the simulation run. Furthermore, the genomePedigreeID of a
#'given genome will be equal to either (2*pedigreeID) or (2*pedigreeID + 1) of the
#'individual that the genome belongs to (the former for the first genome of the
#'individual, the latter for the second genome of the individual); this invariant
#'relationship is guaranteed. This property is also available when treesequence
#'recording is enabled. If neither pedigree tracking nor tree-sequence recording
#'is enabled, this property is unavailable. }
#'\item{genomeType}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The type of chromosome represented by this genome; one of "A",
#'"X", or "Y". }
#'\item{individual}{A property of type Individual object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The Individual object to which this genome
#'belongs. }
#'\item{isNullGenome}{A property of type logical. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} T if the genome is a "null” genome, F if it is
#'an ordinary genome object. When a sex chromosome (X or Y) is simulated, the
#'other sex chromosome also exists in the simulation, but it is a "null” genome
#'that does not carry any mutations. Instead, it is a placeholder, present to
#'allow SLiM’s code to operate in much the same way as it does when an autosome is
#'simulated. Null genomes should not be accessed or manipulated. }
#'\item{mutations}{A property of type Mutation object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All of the
#'Mutation objects present in this genome. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use. Note that the Genome objects used by SLiM are new with every generation,
#'so the tag value of each new offspring generated in each generation will be
#'initially undefined. If you set a tag value for an offspring genome inside
#'a modifyChild() callback, that tag value will be preserved as the offspring
#'individual becomes a parent (across the generation boundary, in other words).
#'If you take advantage of this, however, you should be careful to set up initial
#'values for the tag values of all offspring, otherwise undefined initial values
#'might happen to match the values that you are trying to use to tag particular
#'individuals. A rule of thumb in programming: undefined values should always be
#'assumed to take on the most inconvenient value possible.}
#'
#'}
'Genome'
#'GenomicElement
#'
#'Documentation for GenomicElement class from SLiM
#'
#'@aliases .GE
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{setGenomicElementType}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{endPosition}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The last position in the chromosome contained by
#'this genomic element. }
#'\item{genomicElementType}{A property of type GenomicElementType object. It is of
#'length one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The GenomicElementType object that defines the
#'behavior of this genomic element. }
#'\item{startPosition}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The first position in the chromosome contained by
#'this genomic element. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use.}
#'
#'}
'GenomicElement'
#'GenomicElementType
#'
#'Documentation for GenomicElementType class from SLiM
#'
#'@aliases .GET
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{setMutationFractions}}}
#'\item{\code{\link{setMutationMatrix}}}
#'\item{\code{\link{setValue}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The color used to display genomic elements of this type in SLiMgui. Outside
#'of SLiMgui, this property still exists, but is not used by SLiM. Colors may be
#'specified by name, or with hexadecimal RGB values of the form "#RRGGBB" (see the
#'Eidos manual). If color is the empty string, "", SLiMgui’s default color scheme
#'is used; this is the default for new GenomicElementType objects. }
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this genomic element type; for genomic element type g3, for
#'example, this is 3. }
#'\item{mutationFractions}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} For each MutationType
#'represented in this genomic element type, this property has the corresponding
#'fraction of all mutations that will be drawn from that MutationType. }
#'\item{mutationMatrix}{A property of type float. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The
#'nucleotide mutation matrix used for this genomic element type, set up by
#'initializeGenomicElementType() and setMutationMatrix(). This property is only
#'defined in nucleotide-based models; it is unavailable otherwise. }
#'\item{mutationTypes}{A property of type MutationType object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'MutationType instances used by this genomic element type. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods, for another way of
#'attaching state to genomic element types.}
#'
#'}
'GenomicElementType'
#'Individual
#'
#'Documentation for Individual class from SLiM
#'
#'@aliases .I
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{containsMutations}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{relatedness}}}
#'\item{\code{\link{setSpatialPosition}}}
#'\item{\code{\link{setValue}}}
#'\item{\code{\link{sumOfMutationsOfType}}}
#'\item{\code{\link{uniqueMutationsOfType}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{age}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The age of the individual, measured in generation "ticks”. A newly generated
#'offspring individual will have an age of 0 in the same generation in which
#'is was created. The age of every individual is incremented by one at the same
#'point that the generation counter is incremented. The age of individuals may be
#'changed; usually this only makes sense when setting up the initial state of a
#'model, however. }
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The color used to display the individual in SLiMgui. Outside of SLiMgui, this
#'property still exists, but is not used by SLiM. Colors may be specified by name,
#'or with hexadecimal RGB values of the form "#RRGGBB" (see the Eidos manual). If
#'color is the empty string, "", SLiMgui’s default (fitness-based) color scheme is
#'used; this is the default for new Individual objects. }
#'\item{fitnessScaling}{A property of type float. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} A float scaling factor applied to the individual’s fitness
#'(i.e., the fitness value computed for the individual will be multiplied by this
#'value). This provides a simple, fast way to modify the fitness of an individual;
#'conceptually it is similar to returning a fitness effect for the individual from
#'a fitness(NULL) callback, but without the complexity and performance overhead
#'of implementing such a callback. To scale the fitness of all individuals
#'in a subpopulation by the same factor, see the fitnessScaling property of
#'Subpopulation. The value of fitnessScaling is reset to 1.0 every generation,
#'so that any scaling factor set lasts for only a single generation. This reset
#'occurs immediately after fitness values are calculated, in both WF and nonWF
#'models. }
#'\item{genomes}{A property of type Genome object. This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The pair of Genome objects
#'associated with this individual. If only one of the two genomes is desired, the
#'genome1 or genome2 property may be used. }
#'\item{genome1}{A property of type Genome object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The first Genome object associated with this
#'individual. This property is particularly useful when you want the first genome
#'from each of a vector of individuals, as often arises in haploid models. }
#'\item{genome2}{A property of type Genome object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The second Genome object associated with this
#'individual. This property is particularly useful when you want the second genome
#'from each of a vector of individuals, as often arises in haploid models. }
#'\item{index}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The index of the individual in the individuals vector of its Subpopulation. }
#'\item{migrant}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} Set to T if the individual migrated during the current generation,
#'F otherwise. In WF models, this flag is set at the point when a new child is
#'generated if it is a migrant (i.e., if its source subpopulation is not the
#'same as its subpopulation), and remains valid, with the same value, for the
#'rest of the individual’s lifetime. In nonWF models, this flag is F for all
#'new individuals, is set to F in all individuals at the end of the reproduction
#'generation cycle stage, and is set to T on all individuals moved to a new
#'subpopulation by takeMigrants(); the T value set by takeMigrants() will remain
#'until it is reset at the end of the next reproduction generation cycle stage. }
#'\item{pedigreeID}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If pedigree tracking is turned on with
#'initializeSLiMOptions(keepPedigrees=T), pedigreeID is a unique non-negative
#'identifier for each individual in a simulation, never re-used throughout the
#'duration of the simulation run. This property is also available when tree-
#'sequence recording is enabled. If neither pedigree tracking nor tree-sequence
#'recording is enabled, this property is unavailable. }
#'\item{pedigreeParentIDs}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'pedigreeParentIDs contains the values of pedigreeID that were possessed by
#'the parents of an individual; it is thus a vector of two values. If pedigree
#'tracking is not on, this property is unavailable. Parental values may be -1
#'if insufficient generations have elapsed for that information to be available
#'(because the simulation just started, or because a subpopulation is new). }
#'\item{pedigreeGrandparentIDs}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'pedigreeGrandparentIDs contains the values of pedigreeID that were possessed
#'by the grandparents of an individual; it is thus a vector of four values. If
#'pedigree tracking is not on, this property is unavailable. Grandparental values
#'may be -1 if insufficient generations have elapsed for that information to be
#'available (because the simulation just started, or because a subpopulation is
#'new). }
#'\item{sex}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The sex of the individual. This will be "H" if sex is not enabled in the
#'simulation (i.e., for hermaphrodites), otherwise "F" or "M" as appropriate. }
#'\item{spatialPosition}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The spatial position
#'of the individual. The length of the spatialPosition property (the number
#'of coordinates in the spatial position of an individual) depends upon the
#'spatial dimensionality declared with initializeSLiMOptions(). If the spatial
#'dimensionality is zero (as it is by default), it is an error to access
#'this property. The elements of this property are identical to the values
#'of the x, y, and z properties (if those properties are encompassed by the
#'spatial dimensionality of the simulation). In other words, if the declared
#'dimensionality is "xy", the individual.spatialPosition property is equivalent
#'to c(individual.x, individual.y); individual.z is not used since it is not
#'encompassed by the simulation’s dimensionality. This property cannot be set, but
#'the setSpatialPosition() method may be used to achieve the same thing. }
#'\item{subpopulation}{A property of type Subpopulation object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The Subpopulation object to which the individual
#'belongs. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value (as opposed to tagF, which is of type float).
#'The value of tag is initially undefined, and it is an error to try to read
#'it; if you wish it to have a defined value, you must arrange that yourself by
#'explicitly setting its value prior to using it elsewhere in your code. The value
#'of tag is not used by SLiM; it is free for you to use. See also the getValue()
#'and setValue() methods, for another way of attaching state to individuals.
#'Note that the Individual objects used by SLiM are (conceptually) new with every
#'generation, so the tag value of each new offspring generated in each generation
#'will be initially undefined. If you set a tag value for an offspring individual
#'inside a modifyChild() callback, that tag value will be preserved as the
#'offspring individual becomes a parent (across the generation boundary, in other
#'words). If you take advantage of this, however, you should be careful to set up
#'initial values for the tag values of all offspring, otherwise undefined initial
#'values might happen to match the values that you are trying to use to tag
#'particular individuals. A rule of thumb in programming: undefined values should
#'always be assumed to take on the most inconvenient value possible. }
#'\item{tagF}{A property of type float. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined float value (as opposed to tag, which is of type integer).
#'The value of tagF is initially undefined, and it is an error to try to read
#'it; if you wish it to have a defined value, you must arrange that yourself by
#'explicitly setting its value prior to using it elsewhere in your code. The value
#'of tagF is not used by SLiM; it is free for you to use. See also the getValue()
#'and setValue() methods, for another way of attaching state to individuals.
#'Note that at present, although many classes in SLiM have an integer-type tag
#'property, only Individual has a float-type tagF property, because attaching
#'model state to individuals seems to be particularly common and useful. If a tagF
#'property would be helpful on another class, it would be easy to add. See the
#'description of the tag property above for additional comments. }
#'\item{uniqueMutations}{A property of type Mutation object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:}
#'All of the Mutation objects present in this individual. Mutations present
#'in both genomes will occur only once in this property, and the mutations
#'will be given in sorted order by position, so this property is similar to
#'sortBy(unique(individual.genomes.mutations), "position"). It is not identical
#'to that call, only because if multiple mutations exist at the exact same
#'position, they may be sorted differently by this method than they would
#'be by sortBy(). This method is provided primarily for speed; it executes
#'much faster than the Eidos equivalent above. Indeed, it is faster than just
#'individual.genomes.mutations, and gives uniquing and sorting on top of that,
#'so it is advantageous unless duplicate entries for homozygous mutations are
#'actually needed. }
#'\item{x}{A property of type float. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined float value. The value of x is initially undefined (i.e., has
#'an effectively random value that could be different every time you run your
#'model); if you wish it to have a defined value, you must arrange that yourself
#'by explicitly setting its value prior to using it elsewhere in your code,
#'typically in a modifyChild() callback. The value of x is not used by SLiM unless
#'the optional "continuous space” facility is enabled with the dimensionality
#'parameter to initializeSLiMOptions(), in which case x will be understood to
#'represent the x coordinate of the individual in space. If continuous space is
#'not enabled, you may use x as an additional tag value of type float. }
#'\item{y}{A property of type float. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined float value. The value of y is initially undefined (i.e., has
#'an effectively random value that could be different every time you run your
#'model); if you wish it to have a defined value, you must arrange that yourself
#'by explicitly setting its value prior to using it elsewhere in your code,
#'typically in a modifyChild() callback. The value of y is not used by SLiM unless
#'the optional "continuous space” facility is enabled with the dimensionality
#'parameter to initializeSLiMOptions(), in which case y will be understood to
#'represent the y coordinate of the individual in space (if the dimensionality is
#'"xy" or "xyz"). If continuous space is not enabled, or the dimensionality is not
#'"xy" or "xyz", you may use y as an additional tag value of type float. }
#'\item{z}{A property of type float. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined float value. The value of z is initially undefined (i.e., has
#'an effectively random value that could be different every time you run your
#'model); if you wish it to have a defined value, you must arrange that yourself
#'by explicitly setting its value prior to using it elsewhere in your code,
#'typically in a modifyChild() callback. The value of z is not used by SLiM unless
#'the optional "continuous space” facility is enabled with the dimensionality
#'parameter to initializeSLiMOptions(), in which case z will be understood to
#'represent the z coordinate of the individual in space (if the dimensionality is
#'"xyz"). If continuous space is not enabled, or the dimensionality is not "xyz",
#'you may use z as an additional tag value of type float.}
#'
#'}
'Individual'
#'InteractionType
#'
#'Documentation for InteractionType class from SLiM
#'
#'@aliases .IT
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{distance}}}
#'\item{\code{\link{distanceToPoint}}}
#'\item{\code{\link{drawByStrength}}}
#'\item{\code{\link{evaluate}}}
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{interactingNeighborCount}}}
#'\item{\code{\link{interactionDistance}}}
#'\item{\code{\link{nearestInteractingNeighbors}}}
#'\item{\code{\link{nearestNeighbors}}}
#'\item{\code{\link{nearestNeighborsOfPoint}}}
#'\item{\code{\link{setInteractionFunction}}}
#'\item{\code{\link{setValue}}}
#'\item{\code{\link{strength}}}
#'\item{\code{\link{totalOfNeighborStrengths}}}
#'\item{\code{\link{unevaluate}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{id}{A property of type integer or float or logical or string or string
#'or integer. It is of length one (a singleton). This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The identifier for this
#'interaction type; for interaction type i3, for example, this is 3. }
#'\item{maxDistance}{A property of type integer or float or logical or string
#'or string or integer. It is of length one (a singleton). This property is
#'a variable, so it is modifiable. \strong{Property Description:} The maximum
#'distance over which this interaction will be evaluated. For inter-individual
#'distances greater than maxDistance, the interaction strength will be zero. }
#'\item{reciprocal}{A property of type integer or float or logical or string
#'or string or integer. It is of length one (a singleton). This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'reciprocality of the interaction, as specified in initializeInteractionType().
#'This will be T for reciprocal interactions (those for which the interaction
#'strength of B upon A is equal to the interaction strength of A upon B), and F
#'otherwise. }
#'\item{sexSegregation}{A property of type integer or float or logical or string
#'or string or integer. It is of length one (a singleton). This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The sex-
#'segregation of the interaction, as specified in initializeInteractionType(). For
#'nonsexual simulations, this will be "**". For sexual simulations, this string
#'value indicates the sex of individuals feeling the interaction, and the sex
#'of individuals exerting the interaction; see initializeInteractionType() for
#'details. }
#'\item{spatiality}{A property of type integer or float or logical or string
#'or string or integer. It is of length one (a singleton). This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The spatial
#'dimensions used by the interaction, as specified in initializeInteractionType().
#'This will be "" (the empty string) for non-spatial interactions, or "x", "y",
#'"z", "xy", "xz", "yz", or "xyz", for interactions using those spatial dimensions
#'respectively. The specified dimensions are used to calculate the distances
#'between individuals for this interaction. The value of this property is always
#'the same as the value given to initializeInteractionType(). }
#'\item{tag}{A property of type integer or float or logical or string or string
#'or integer. It is of length one (a singleton). This property is a variable, so
#'it is modifiable. \strong{Property Description:} A user-defined integer value.
#'The value of tag is initially undefined, and it is an error to try to read
#'it; if you wish it to have a defined value, you must arrange that yourself by
#'explicitly setting its value prior to using it elsewhere in your code. The value
#'of tag is not used by SLiM; it is free for you to use. See also the getValue()
#'and setValue() methods, for another way of attaching state to interaction
#'types.}
#'
#'}
'InteractionType'
#'Mutation
#'
#'Documentation for Mutation class from SLiM
#'
#'@aliases .M
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{setMutationType}}}
#'\item{\code{\link{setSelectionCoeff}}}
#'\item{\code{\link{setValue}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this mutation. Each mutation created during a run receives an
#'immutable identifier that will be unique across the duration of the run. These
#'identifiers are not re-used during a run, except that if a population file is
#'loaded from disk, the loaded mutations will receive their original identifier
#'values as saved in the population file. }
#'\item{mutationType}{A property of type MutationType object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The MutationType from which this mutation was
#'drawn. }
#'\item{nucleotide}{A property of type string. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'A string representing the nucleotide associated with this mutation; this will be
#'"A", "C", "G", or "T". If the mutation is not nucleotide-based, this property is
#'unavailable. }
#'\item{nucleotideValue}{A property of type integer. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} An integer representing the nucleotide associated with this
#'mutation; this will be 0 (A), 1 (C), 2 (G), or 3 (T). If the mutation is not
#'nucleotide-based, this property is unavailable. }
#'\item{originGeneration}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The generation in which this mutation arose. }
#'\item{position}{A property of type integer. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The position in the chromosome of this mutation. }
#'\item{selectionCoeff}{A property of type float. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The selection coefficient of the mutation, drawn
#'from the distribution of fitness effects of its MutationType. If a mutation
#'has a selectionCoeff of s, the multiplicative fitness effect of the mutation
#'in a homozygote is 1+s; in a heterozygote it is 1+hs, where h is the dominance
#'coefficient kept by the mutation type (see section 23.9.1). Note that this
#'property has a quirk: it is stored internally in SLiM using a single-precision
#'float, not the double-precision float type normally used by Eidos. This means
#'that if you set a mutation mut’s selection coefficient to some number x,
#'mut.selectionCoeff==x may be F due to floating-point rounding error. Comparisons
#'of floating-point numbers for exact equality is often a bad idea, but this is
#'one case where it may fail unexpectedly. Instead, it is recommended to use the
#'id or tag properties to identify particular mutations. }
#'\item{subpopID}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The identifier of the subpopulation in which this mutation arose. This property
#'can be used to track the ancestry of mutations through their subpopulation of
#'origin. For an overview of other ways of tracking genetic ancestry, including
#'true local ancestry at each position on the chromosome, see sections 1.7 and
#'14.7. If you don’t care which subpopulation a mutation originated in, the
#'subpopID may be used as an arbitrary integer "tag” value for any purpose you
#'wish; SLiM does not do anything with the value of subpopID except propagate
#'it to Substitution objects and report it in output. (It must still be >= 0,
#'however, since SLiM object identifiers are limited to nonnegative integers). }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use.}
#'
#'}
'Mutation'
#'MutationType
#'
#'Documentation for MutationType class from SLiM
#'
#'@aliases .MT
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{drawSelectionCoefficient}}}
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{setDistribution}}}
#'\item{\code{\link{setValue}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{color}{A property of type string or string or logical or float or string
#'or float or integer or integer or string or logical or integer. It is of
#'length one (a singleton). This property is a variable, so it is modifiable.
#'\strong{Property Description:} The color used to display mutations of this type
#'in SLiMgui. Outside of SLiMgui, this property still exists, but is not used
#'by SLiM. Colors may be specified by name, or with hexadecimal RGB values of
#'the form "#RRGGBB" (see the Eidos manual). If color is the empty string, "",
#'SLiMgui’s default (selection-coefficient–based) color scheme is used; this is
#'the default for new MutationType objects. }
#'\item{colorSubstitution}{A property of type string or string or logical or float
#'or string or float or integer or integer or string or logical or integer. It is
#'of length one (a singleton). This property is a variable, so it is modifiable.
#'\strong{Property Description:} The color used to display substitutions of this
#'type in SLiMgui (see the discussion for the colorSubstitution property of the
#'Chromosome class for details). Outside of SLiMgui, this property still exists,
#'but is not used by SLiM. Colors may be specified by name, or with hexadecimal
#'RGB values of the form "#RRGGBB" (see the Eidos manual). If colorSubstitution
#'is the empty string, "", SLiMgui’s default (selection-coefficient–based) color
#'scheme is used; this is the default for new MutationType objects. }
#'\item{convertToSubstitution}{A property of type string or string or logical
#'or float or string or float or integer or integer or string or logical or
#'integer. It is of length one (a singleton). This property is a variable, so
#'it is modifiable. \strong{Property Description:} This property governs whether
#'mutations of this mutation type will be converted to Substitution objects
#'when they reach fixation. In WF models this property is T by default, since
#'conversion to Substitution objects provides large speed benefits; it should
#'be set to F only if necessary, and only on the mutation types for which it
#'is necessary. This might be needed, for example, if you are using a fitness()
#'callback to implement an epistatic relationship between mutations; a mutation
#'epistatically influencing the fitness of other mutations through a fitness()
#'callback would need to continue having that influence even after reaching
#'fixation, but if the simulation were to replace the fixed mutation with a
#'Substitution object the mutation would no longer be considered in fitness
#'calculations (unless the callback explicitly consulted the list of Substitution
#'objects kept by the simulation). Other script-defined behaviors in fitness(),
#'interaction(), mateChoice(), modifyChild(), and recombination() callbacks might
#'also necessitate the disabling of substitution for a given mutation type; this
#'is an important consideration to keep in mind. See section 21.3 for further
#'discussion of convertToSubstitution in WF models. In contrast, for nonWF models
#'this property is F by default, because even mutations with no epistatis or other
#'indirect fitness effects will continue to influence the survival probabilities
#'of individuals. For nonWF models, only neutral mutation types with no epistasis
#'or other side effects can safely be converted to substitutions upon fixation.
#'When such a pure-neutral mutation type is defined in a nonWF model, this
#'property should be set to T to tell SLiM that substitution is allowed; this may
#'have very large positive effects on performance, so it is important to remember
#'when modeling background neutral mutations. See section 22.5 for further
#'discussion of convertToSubstitution in nonWF models. SLiM consults this flag
#'at the end of each generation when deciding whether to substitute each fixed
#'mutation. If this flag is T, all eligible fixed mutations will be converted at
#'the end of the current generation, even if they were previously left unconverted
#'because of the previous value of the flag. Setting this flag to F will prevent
#'future substitutions, but will not cause any existing Substitution objects to be
#'converted back into Mutation objects. }
#'\item{distributionParams}{A property of type string or string or logical
#'or float or string or float or integer or integer or string or logical or
#'integer. This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The parameters that configure the chosen distribution of fitness
#'effects. This will be of type string for DFE type "s", and type float for all
#'other DFE types. }
#'\item{distributionType}{A property of type string or string or logical or
#'float or string or float or integer or integer or string or logical or integer.
#'It is of length one (a singleton). This property is a constant, so it is not
#'modifiable. \strong{Property Description:} The type of distribution of fitness
#'effects; one of "f", "g", "e", "n", "w", or "s" (see section 23.9, above). }
#'\item{dominanceCoeff}{A property of type string or string or logical or float
#'or string or float or integer or integer or string or logical or integer.
#'It is of length one (a singleton). This property is a variable, so it is
#'modifiable. \strong{Property Description:} The dominance coefficient used for
#'mutations of this type when heterozygous. Changing this will normally affect
#'the fitness values calculated at the end of the current generation; if you
#'want current fitness values to be affected, you can call SLiMSim’s method
#'recalculateFitness() – but see the documentation of that method for caveats.
#'Note that the dominance coefficient is not bounded. A dominance coefficient
#'greater than 1.0 may be used to achieve an overdominance effect. By making
#'the selection coefficient very small and the dominance coefficient very large,
#'an overdominance scenario in which both homozygotes have the same fitness may
#'be approximated, to a nearly arbitrary degree of precision. Note that this
#'property has a quirk: it is stored internally in SLiM using a single-precision
#'float, not the double-precision float type normally used by Eidos. This means
#'that if you set a mutation type muttype’s dominance coefficient to some number
#'x, muttype.dominanceCoeff==x may be F due to floating-point rounding error.
#'Comparisons of floating-point numbers for exact equality is often a bad idea,
#'but this is one case where it may fail unexpectedly. Instead, it is recommended
#'to use the id or tag properties to identify particular mutation types. }
#'\item{id}{A property of type string or string or logical or float or string or
#'float or integer or integer or string or logical or integer. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The identifier for this mutation type; for
#'mutation type m3, for example, this is 3. }
#'\item{mutationStackGroup}{A property of type string or string or logical or
#'float or string or float or integer or integer or string or logical or integer.
#'It is of length one (a singleton). This property is a variable, so it is
#'modifiable. \strong{Property Description:} The group into which this mutation
#'type belongs for purposes of mutation stacking policy. This is equal to the
#'mutation type’s id by default. See mutationStackPolicy, below, for discussion.
#'In nucleotide-based models, the stacking group for nucleotide-based mutation
#'types is always -1, and cannot be changed. Non-nucleotide-based mutation types
#'may also be set to share the -1 stacking group, if they should participate in
#'the same stacking policy as nucleotide-based mutations, but that would be quite
#'unusual. }
#'\item{mutationStackPolicy}{A property of type string or string or logical
#'or float or string or float or integer or integer or string or logical or
#'integer. It is of length one (a singleton). This property is a variable,
#'so it is modifiable. \strong{Property Description:} This property and the
#'mutationStackGroup property together govern whether mutations of this mutation
#'type’s stacking group can "stack” – can occupy the same position in a single
#'individual. A set of mutation types with the same value for mutationStackGroup
#'is called a "stacking group”, and all mutation types in a given stacking
#'group must have the same mutationStackPolicy value, which defines the stacking
#'behavior of all mutations of the mutation types in the stacking group. In other
#'words, one stacking group might allow its mutations to stack, while another
#'stacking group might not, but the policy within each stacking group must be
#'unambiguous. This property is "s" by default, indicating that mutations in this
#'stacking group should be allowed to stack without restriction. If the policy is
#'set to "f", the first mutation of stacking group at a given site is retained;
#'further mutations of this stacking group at the same site are discarded with
#'no effect. This can be useful for modeling one-way changes; once a gene is
#'disabled by a premature stop codon, for example, you might wish to assume, for
#'simplicity, that further mutations cannot alter that fact. If the policy is set
#'to "l", the last mutation of this stacking group at a given site is retained;
#'earlier mutation of this stacking group at the same site are discarded. This
#'can be useful for modeling an "infinitealleles” scenario in which every new
#'mutation at a site generates a completely new allele, rather than retaining the
#'previous mutations at the site. The mutation stacking policy applies only within
#'the given mutation type’s stacking group; mutations of different stacking groups
#'are always allowed to stack in SLiM. The policy applies to all mutations added
#'to the model after the policy is set, whether those mutations are introduced
#'by calls such as addMutation(), addNewMutation(), or addNewDrawnMutation(), or
#'are added by SLiM’s own mutation-generation machinery. However, no attempt is
#'made to enforce the policy for mutations already existing at the time the policy
#'is set; typically, therefore, the policy is set in an initialize() callback so
#'that it applies throughout the simulation. The policy is also not enforced upon
#'the mutations loaded from a file with readFromPopulationFile(); such mutations
#'were governed by whatever stacking policy was in effect when the population file
#'was generated. In nucleotide-based models, the stacking policy for nucleotide-
#'based mutation types is always "l", and cannot be changed. This ensures that new
#'nucleotide mutations always replace the previous nucleotide at a site, and that
#'more than one nucleotide mutation is never present at the same position in a
#'single genome. }
#'\item{nucleotideBased}{A property of type string or string or logical or float
#'or string or float or integer or integer or string or logical or integer.
#'It is of length one (a singleton). This property is a constant, so it is not
#'modifiable. \strong{Property Description:} If the mutation type was created with
#'initializeMutationType(), it is not nucleotide-based, and this property is F.
#'If it was created with initializeMutationTypeNuc(), it is nucleotide-based, and
#'this property is T. See those methods for further discussion. }
#'\item{tag}{A property of type string or string or logical or float or string
#'or float or integer or integer or string or logical or integer. It is of
#'length one (a singleton). This property is a variable, so it is modifiable.
#'\strong{Property Description:} A user-defined integer value. The value of tag
#'is initially undefined, and it is an error to try to read it; if you wish it to
#'have a defined value, you must arrange that yourself by explicitly setting its
#'value prior to using it elsewhere in your code. The value of tag is not used by
#'SLiM; it is free for you to use. See also the getValue() and setValue() methods,
#'for another way of attaching state to mutation types.}
#'
#'}
'MutationType'
#'SLiMBuiltin
#'
#'Documentation for SLiMBuiltin class from SLiM
#'
#'@aliases .SB
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{codonsToAminoAcids}}}
#'\item{\code{\link{mm16To256}}}
#'\item{\code{\link{mmJukesCantor}}}
#'\item{\code{\link{mmKimura}}}
#'\item{\code{\link{nucleotideCounts}}}
#'\item{\code{\link{nucleotideFrequencies}}}
#'\item{\code{\link{nucleotidesToCodons}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{None.}{This class has no properties.}
#'}
'SLiMBuiltin'
#'SLiMEidosBlock
#'
#'Documentation for SLiMEidosBlock class from SLiM
#'
#'@aliases .SEB
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{None. This class has no methods.}
#'}
#'This class has the following properties:
#'\describe{
#'\item{active}{A property of type integer or integer or integer or string or
#'integer or integer or string. It is of length one (a singleton). This property
#'is a variable, so it is modifiable. \strong{Property Description:} If this
#'evaluates to logical F (i.e., is equal to 0), the script block is inactive and
#'will not be called. The value of active for all registered script blocks is
#'reset to -1 at the beginning of each generation, prior to script events being
#'called, thus activating all blocks. Any integer value other than -1 may be
#'used instead of -1 to represent that a block is active; for example, active
#'may be used as a counter to make a block execute a fixed number of times in
#'each generation. This value is not cached by SLiM; if it is changed, the new
#'value takes effect immediately. For example, a callback might be activated and
#'inactivated repeatedly during a single generation. }
#'\item{end}{A property of type integer or integer or integer or string or integer
#'or integer or string. It is of length one (a singleton). This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The last
#'generation in which the script block is active. }
#'\item{id}{A property of type integer or integer or integer or string or integer
#'or integer or string. It is of length one (a singleton). This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The identifier
#'for this script block; for script s3, for example, this is 3. A script block for
#'which no id was given will have an id of -1. }
#'\item{source}{A property of type integer or integer or integer or string or
#'integer or integer or string. It is of length one (a singleton). This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'source code string of the script block. }
#'\item{start}{A property of type integer or integer or integer or string or
#'integer or integer or string. It is of length one (a singleton). This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The first
#'generation in which the script block is active. }
#'\item{tag}{A property of type integer or integer or integer or string or integer
#'or integer or string. It is of length one (a singleton). This property is a
#'variable, so it is modifiable. \strong{Property Description:} A user-defined
#'integer value. The value of tag is initially undefined, and it is an error to
#'try to read it; if you wish it to have a defined value, you must arrange that
#'yourself by explicitly setting its value prior to using it elsewhere in your
#'code. The value of tag is not used by SLiM; it is free for you to use. }
#'\item{type}{A property of type integer or integer or integer or string or
#'integer or integer or string. It is of length one (a singleton). This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'type of the script block; this will be "early" or "late" for the two types
#'of Eidos events, or "initialize", "fitness", "mateChoice", "modifyChild", or
#'"recombination" for the respective types of Eidos callbacks (see section 23.1
#'and chapter 24).}
#'
#'}
'SLiMEidosBlock'
#'SLiMSim
#'
#'Documentation for SLiMSim class from SLiM
#'
#'@aliases .SS
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addSubpop}}}
#'\item{\code{\link{addSubpopSplit}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{deregisterScriptBlock}}}
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{mutationCounts}}}
#'\item{\code{\link{mutationFrequencies}}}
#'\item{\code{\link{mutationsOfType}}}
#'\item{\code{\link{outputFixedMutations}}}
#'\item{\code{\link{outputFull}}}
#'\item{\code{\link{outputMutations}}}
#'\item{\code{\link{outputUsage}}}
#'\item{\code{\link{readFromPopulationFile}}}
#'\item{\code{\link{recalculateFitness}}}
#'\item{\code{\link{registerEarlyEvent}}}
#'\item{\code{\link{registerFitnessCallback}}}
#'\item{\code{\link{registerInteractionCallback}}}
#'\item{\code{\link{registerLateEvent}}}
#'\item{\code{\link{registerMateChoiceCallback}}}
#'\item{\code{\link{registerModifyChildCallback}}}
#'\item{\code{\link{registerRecombinationCallback}}}
#'\item{\code{\link{registerMutationCallback}}}
#'\item{\code{\link{registerReproductionCallback}}}
#'\item{\code{\link{rescheduleScriptBlock}}}
#'\item{\code{\link{setValue}}}
#'\item{\code{\link{simulationFinished}}}
#'\item{\code{\link{treeSeqCoalesced}}}
#'\item{\code{\link{treeSeqOutput}}}
#'\item{\code{\link{treeSeqRememberIndividuals}}}
#'\item{\code{\link{treeSeqSimplify}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{chromosome}{A property of type Chromosome object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The Chromosome object used by the simulation. }
#'\item{chromosomeType}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The type of chromosome being simulated; this will
#'be one of "A", "X", or "Y". }
#'\item{dimensionality}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The spatial dimensionality of the simulation,
#'as specified in initializeSLiMOptions(). This will be "" (the empty string) for
#'non-spatial simulations (the default), or "x", "xy", or "xyz", for simulations
#'using those spatial dimensions respectively. }
#'\item{dominanceCoeffX}{A property of type float. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} The dominance coefficient value used to modify the selection
#'coefficients of mutations present on the single X chromosome of an XY male (see
#'the SLiM documentation for details). Used only when simulating an X chromosome;
#'setting a value for this property in other circumstances is an error. Changing
#'this will normally affect the fitness values calculated at the end of the
#'current generation; if you want current fitness values to be affected, you can
#'call SLiMSim’s method recalculateFitness() – but see the documentation of that
#'method for caveats. }
#'\item{generation}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The current generation number. }
#'\item{genomicElementTypes}{A property of type GenomicElementType object. This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The GenomicElementType objects being used in the simulation. }
#'\item{inSLiMgui}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} This property has been deprecated, and may be removed in a future
#'release of SLiM. In SLiM 3.2.1 and later, use exists("slimgui") instead. If T,
#'the simulation is presently running inside SLiMgui; if F, it is running at the
#'command line. In general simulations should not care where they are running,
#'but in special circumstances such as opening plot windows it may be necessary to
#'know the runtime environment. }
#'\item{interactionTypes}{A property of type InteractionType object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'InteractionType objects being used in the simulation. }
#'\item{modelType}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The type of model being simulated, as specified in
#'initializeSLiMModelType(). This will be "WF" for WF models (Wright–Fisher
#'models, the default), or "nonWF" for nonWF models (non-Wright–Fisher models; see
#'section 1.6 for discussion). }
#'\item{mutationTypes}{A property of type MutationType object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'MutationType objects being used in the simulation. }
#'\item{mutations}{A property of type Mutation object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The Mutation
#'objects that are currently active in the simulation. }
#'\item{nucleotideBased}{A property of type logical. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If T, the model is nucleotide-based; if
#'F, it is not. See the discussion of the nucleotideBased parameter to
#'initializeSLiMOptions() for discussion. }
#'\item{periodicity}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The spatial periodicity of the simulation, as specified
#'in initializeSLiMOptions(). This will be "" (the empty string) for non-
#'spatial simulations and simulations with no periodic spatial dimensions
#'(the default). Otherwise, it will be a string representing the subset of
#'spatial dimensions that have been declared to be periodic, as specified to
#'initializeSLiMOptions(). }
#'\item{scriptBlocks}{A property of type SLiMEidosBlock object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All registered
#'SLiMEidosBlock objects in the simulation. }
#'\item{sexEnabled}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} If T, sex is enabled in the simulation; if F, individuals are
#'hermaphroditic. }
#'\item{subpopulations}{A property of type Subpopulation object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'Subpopulation instances currently defined in the simulation. }
#'\item{substitutions}{A property of type Substitution object. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} A vector of
#'Substitution objects, representing all mutations that have been fixed. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods, for another way of
#'attaching state to the simulation.}
#'
#'}
'SLiMSim'
#'Subpopulation
#'
#'Documentation for Subpopulation class from SLiM
#'
#'@aliases .P
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addCloned}}}
#'\item{\code{\link{addCrossed}}}
#'\item{\code{\link{addEmpty}}}
#'\item{\code{\link{addRecombinant}}}
#'\item{\code{\link{addSelfed}}}
#'\item{\code{\link{cachedFitness}}}
#'\item{\code{\link{configureDisplay}}}
#'\item{\code{\link{defineSpatialMap}}}
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{outputMSSample}}}
#'\item{\code{\link{outputSample}}}
#'\item{\code{\link{outputVCFSample}}}
#'\item{\code{\link{pointInBounds}}}
#'\item{\code{\link{pointPeriodic}}}
#'\item{\code{\link{pointReflected}}}
#'\item{\code{\link{pointStopped}}}
#'\item{\code{\link{pointUniform}}}
#'\item{\code{\link{removeSubpopulation}}}
#'\item{\code{\link{sampleIndividuals}}}
#'\item{\code{\link{setCloningRate}}}
#'\item{\code{\link{setMigrationRates}}}
#'\item{\code{\link{setSelfingRate}}}
#'\item{\code{\link{setSexRatio}}}
#'\item{\code{\link{setSpatialBounds}}}
#'\item{\code{\link{setSubpopulationSize}}}
#'\item{\code{\link{setValue}}}
#'\item{\code{\link{spatialMapColor}}}
#'\item{\code{\link{spatialMapValue}}}
#'\item{\code{\link{subsetIndividuals}}}
#'\item{\code{\link{takeMigrants}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{cloningRate}{A property of type float. This property is a constant, so it
#'is not modifiable. \strong{Property Description:} The fraction of children in
#'the next generation that will be produced by cloning (as opposed to biparental
#'mating). In non-sexual (i.e. hermaphroditic) simulations, this property is a
#'singleton float representing the overall subpopulation cloning rate. In sexual
#'simulations, this property is a float vector with two values: the cloning rate
#'for females (at index 0) and for males (at index 1). }
#'\item{firstMaleIndex}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The index of the first male individual in
#'the subpopulation. The genomes vector is sorted into females first and males
#'second; firstMaleIndex gives the position of the boundary between those
#'sections. Note, however, that there are two genomes per diploid individual,
#'and the firstMaleIndex is not premultiplied by 2; you must multiply it by 2
#'before using it to decide whether a given index into genomes is a genome for
#'a male or a female. The firstMaleIndex property is also the number of females
#'in the subpopulation, given this design. For non-sexual (i.e. hermaphroditic)
#'simulations, this property has an undefined value and should not be used. }
#'\item{fitnessScaling}{A property of type float. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} A float scaling factor applied to the fitness of all individuals
#'in this subpopulation (i.e., the fitness value computed for each individual will
#'be multiplied by this value). This is primarily of use in nonWF models, where
#'fitness is absolute, rather than in WF models, where fitness is relative (and
#'thus a constant factor multiplied into the fitness of every individual will make
#'no difference); however, it may be used in either type of model. This provides
#'a simple, fast way to modify the fitness of all individuals in a subpopulation;
#'conceptually it is similar to returning the same fitness effect for all
#'individuals in the subpopulation from a fitness(NULL) callback, but without the
#'complexity and performance overhead of implementing such a callback. To scale
#'the fitness of individuals by different (individual-specific) factors, see the
#'fitnessScaling property of Individual. The value of fitnessScaling is reset to
#'1.0 every generation, so that any scaling factor set lasts for only a single
#'generation. This reset occurs immediately after fitness values are calculated,
#'in both WF and nonWF models. }
#'\item{genomes}{A property of type Genome object. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} All of the genomes
#'contained by the subpopulation; there are two genomes per diploid individual. }
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this subpopulation; for subpopulation p3, for example, this
#'is 3. }
#'\item{immigrantSubpopFractions}{A property of type float. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The expected
#'value of the fraction of children in the next generation that are immigrants
#'arriving from particular subpopulations. }
#'\item{immigrantSubpopIDs}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'identifiers of the particular subpopulations from which immigrants will arrive
#'in the next generation. }
#'\item{individualCount}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The number of individuals in the subpopulation;
#'one-half of the number of genomes. }
#'\item{individuals}{A property of type Individual object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All of the
#'individuals contained by the subpopulation. Each individual is diploid and thus
#'contains two Genome objects. See the sampleIndividuals() and subsetIndividuals()
#'for fast ways to get a subset of the individuals in a subpopulation. }
#'\item{selfingRate}{A property of type float. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The expected value of the fraction of children in the next
#'generation that will be produced by selfing (as opposed to biparental mating).
#'Selfing is only possible in non-sexual (i.e. hermaphroditic) simulations; for
#'sexual simulations this property always has a value of 0.0. }
#'\item{sexRatio}{A property of type float. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} For sexual simulations, the sex ratio for the subpopulation. This
#'is defined, in SLiM, as the fraction of the subpopulation that is male; in other
#'words, it is actually the M:(M+F) ratio. For non-sexual (i.e. hermaphroditic)
#'simulations, this property has an undefined value and should not be used. }
#'\item{spatialBounds}{A property of type float. This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The spatial boundaries of
#'the subpopulation. The length of the spatialBounds property depends upon the
#'spatial dimensionality declared with initializeSLiMOptions(). If the spatial
#'dimensionality is zero (as it is by default), the value of this property is
#'float(0) (a zero-length float vector). Otherwise, minimums are supplied for
#'each coordinate used by the dimensionality of the simulation, followed by
#'maximums for each. In other words, if the declared dimensionality is "xy", the
#'spatialBounds property will contain values (x0, y0, x1, y1); bounds for the
#'z coordinate will not be included in that case, since that coordinate is not
#'used in the simulation’s dimensionality. This property cannot be set, but the
#'setSpatialBounds() method may be used to achieve the same thing. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods, for another way of
#'attaching state to subpopulations.}
#'
#'}
'Subpopulation'
#'Substitution
#'
#'Documentation for Substitution class from SLiM
#'
#'@aliases .S
#'@details This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{getValue}}}
#'\item{\code{\link{setValue}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this mutation. Each mutation created during a run receives
#'an immutable identifier that will be unique across the duration of the run, and
#'that identifier is carried over to the Substitution object when the mutation
#'fixes. }
#'\item{fixationGeneration}{A property of type integer. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The generation in which this mutation fixed. }
#'\item{mutationType}{A property of type MutationType object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The MutationType from which this mutation was
#'drawn. }
#'\item{nucleotide}{A property of type string. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'A string representing the nucleotide associated with this mutation; this will be
#'"A", "C", "G", or "T". If the mutation is not nucleotide-based, this property is
#'unavailable. }
#'\item{nucleotideValue}{A property of type integer. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} An integer representing the nucleotide associated with this
#'mutation; this will be 0 (A), 1 (C), 2 (G), or 3 (T). If the mutation is not
#'nucleotide-based, this property is unavailable. }
#'\item{originGeneration}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The generation in which this mutation arose. }
#'\item{position}{A property of type integer. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The position in the chromosome of this mutation. }
#'\item{selectionCoeff}{A property of type float. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The selection coefficient of the mutation, drawn
#'from the distribution of fitness effects of its MutationType. }
#'\item{subpopID}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The identifier of the subpopulation in which this mutation arose. This value
#'is carried over from the Mutation object directly; if a "tag” value was used
#'in the Mutation object (see section 23.8.1), that value will carry over to
#'the corresponding Substitution object. The subpopID in Substitution is a read-
#'write property to allow it to be used as a "tag” in the same way, if the origin
#'subpopulation identifier is not needed. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:} A
#'user-defined integer value. The value of tag is carried over automatically from
#'the original Mutation object. Apart from that, the value of tag is not used by
#'SLiM; it is free for you to use.}
#'
#'}
'Substitution'
