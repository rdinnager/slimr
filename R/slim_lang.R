#'SLiM method initializeAncestralNucleotides
#'
#'Documentation for SLiM function \code{initializeAncestralNucleotides}, which is
#'a method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=618}{SLiM manual: page
#'618}.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases
#'Initialize$initializeAncestralNucleotides .Init$initializeAncestralNucleotides
#'@family Initialize
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
#'assist in generating simple random nucleotide sequences; see section 24.17.1.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=618}{SLiM manual: page
#'618}.
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
#'@family Initialize
#'@return An object of type void.
#'@details Calling this function switches the recombination model from a "simple
#'crossover" model to a "double-stranded break (DSB)" model, and configures
#'the details of the gene conversion tracts that will therefore be modeled
#'(see section 1.5.6 for discussion of these models). The fraction of DSBs that
#'will be modeled as non-crossover events is given by nonCrossoverFraction.
#'The mean length of gene conversion tracts (whether associated with crossover
#'or non-crossover events) is given by meanLength; the actual extent of a gene
#'conversion tract will be the sum of two independent draws from a geometric
#'distribution with mean meanLength/2. The fraction of gene conversion tracts that
#'are modeled as "simple" is given by simpleConversionFraction; the remainder will
#'be modeled as "complex", involving repair of heteroduplex mismatches. Finally,
#'the GC bias during heteroduplex mismatch repair is given by bias, with the
#'default of 0.0 indicating no bias, 1.0 indicating an absolute preference for
#'G/C mutations over A/T mutations, and -1.0 indicating an absolute preference
#'for A/T mutations over G/C mutations. A non-zero bias may only be set in
#'nucleotide-based models (see section 1.8). This function, and the way that gene
#'conversion is modeled, fundamentally changed in SLiM 3.3; see section 1.5.6 for
#'discussion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=619}{SLiM manual: page
#'619}.
#'
#'@param genomicElementType An object of type integer or GenomicElementType
#'object. See details for description.
#'@param start An object of type integer. See details for description.
#'@param end An object of type integer. See details for description.
#'
#'@aliases Initialize$initializeGenomicElement .Init$initializeGenomicElement
#'@family Initialize
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=619}{SLiM manual: page
#'619}.
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
#'@family Initialize
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
#'mutation rates that depend upon only the single nucleotide at a mutation
#'site, mutationMatrix should be a 4×4 float matrix, specifying mutation rates
#'for an existing nucleotide state (rows from 0- 3 representing A/C/G/T) to
#'each of the four possible derived nucleotide states (columns, with the same
#'meaning): The mutation rates in this matrix are absolute rates, per nucleotide
#'per gamete; they will be used by SLiM directly unless they are multiplied
#'by a factor from the hotspot map (see initializeHotspotMap()). Rates in
#'mutationMatrix that involve the mutation of a nucleotide to * PA→C PA→G PA→T
#'PC→A * PC→G PC→T PG→A PG→C * PG→T PT→A PT→C PT→G * itself (A to A, C to C,
#'etc.) are not used by SLiM and must be 0.0 by convention (shown above with
#'asterisks). It is important to note that the order of the rows and columns used
#'in SLiM, A/C/G/T, is not a universal convention; other sources will present
#'substitution-rate/transition-rate matrices using different conventions, and so
#'care must be taken when importing such matrices into SLiM. For sequence-based
#'mutation rates that depend upon the trinucleotide sequence centered upon a
#'mutation site (the adjacent bases to the left and right, in other words, as
#'well as the mutating nucleotide itself), mutationMatrix should be a 64×4 float
#'matrix, specifying mutation rates for the central nucleotide of an existing
#'trinucleotide sequence (rows from 0-63, representing trinucleotides as described
#'in the documentation for the ancestralNucleotides() method of Chromosome)
#'to each of the four possible derived nucleotide states (columns from 0-3
#'for A/C/G/T as before): Note that in every case it is the central nucleotide
#'of the trinucleotide sequence that is mutating, but rates can be specified
#'independently based upon the nucleotides in the first and third positions as
#'well, with this type of mutation matrix. Several helper functions are defined to
#'construct common types of mutation matrices, such as mmJukesCantor() to create
#'a mutation matrix for a Jukes-Cantor model; see section 24.17.1. See chapter
#'18 for practical examples of mutation matrices, and section 22.2.3 for further
#'discussion of the mutational paradigm in nucleotide-based models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=620}{SLiM manual: page
#'620}.
#'
#'@param multipliers An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Initialize$initializeHotspotMap .Init$initializeHotspotMap
#'@family Initialize
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
#'in ends should extend to the end of the chromosome (i.e. at least to the end
#'of the last genomic element, if not further). For example, if the following
#'call is made: initializeHotspotMap(c(1.0, 1.2), c(5000, 9999)); * PAAA→ACA
#'PAAA→AGA PAAA→ATA * PAAC→ACC PAAC→AGC PAAC→ATC * PAAG→ACG PAAG→AGG PAAG→ATG
#'* PAAT→ACT PAAT→AGT PAAT→ATT PACA→AAA * PACA→AGA PACA→ATA PACC→AAC * PACC→AGC
#'PACC→ATC PACG→AAG * PACG→AGG PACG→ATG . . . . . . . . . . . . PTTC→TAC PTTC→TCC
#'PTTC→TGC * PTTG→TAG PTTG→TCG PTTG→TGG * PTTT→TAT PTTT→TCT PTTT→TGT * then the
#'result is that the mutation rate multiplier for bases 0...5000 (inclusive)
#'will be 1.0 (and so the specified sequence-based mutation rates will be used
#'verbatim), and the multiplier for bases 5001...9999 (inclusive) will be 1.2
#'(and so the sequence-based mutation rates will be multiplied by 1.2 within the
#'region). Note that mutations are generated by SLiM only within genomic elements,
#'regardless of the hotspot map. In effect, the hotspot map given is intersected
#'with the coverage area of the genomic elements defined; areas outside of any
#'genomic element are given a multiplier of zero. There is no harm in supplying
#'a hotspot map that specifies multipliers for areas outside of the genomic
#'elements defined; the excess information is simply not used. If the optional sex
#'parameter is "*" (the default), then the supplied hotspot map will be used for
#'both sexes (which is the only option for hermaphroditic simulations). In sexual
#'simulations sex may be "M" or "F" instead, in which case the supplied hotspot
#'map is used only for that sex (i.e., when generating a gamete from a parent
#'of that sex). In this case, two calls must be made to initializeHotspotMap(),
#'one for each sex, even if a multiplier of 1.0 is desired for the other sex; no
#'default hotspot map is supplied.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=621}{SLiM manual: page
#'621}.
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
#'@family Initialize
#'@return An object of type InteractionType object. Return will be of length 1 (a
#'singleton)
#'@details Add an interaction type at initialization time. The id must not
#'already be used for any interaction type in the simulation. The id parameter
#'may be either an integer giving the ID of the new interaction type, or a
#'string giving the name of the new interaction type (such as "i5" to specify
#'an ID of 5). The spatiality may be "", for non-spatial interactions (i.e.,
#'interactions that do not depend upon the distance between individuals);
#'"x", "y", or "z" for one-dimensional interactions; "xy", "xz", or "yz" for
#'two-dimensional interactions; or "xyz" for three-dimensional interactions.
#'The dimensions referenced by spatiality must be defined as spatial dimensions
#'with initializeSLiMOptions(); if the simulation has dimensionality "xy", for
#'example, then interactions in the simulation may have spatiality "", "x",
#'"y", or "xy", but may not reference spatial dimension z and thus may not have
#'spatiality "xz", "yz", or "xyz". If no spatial dimensions have been configured,
#'only non-spatial interactions may be defined. The reciprocal flag may be T, in
#'which case the interaction is guaranteed by the user to be reciprocal: whatever
#'the interaction strength is for exerter B upon receiver A, it will be equal (in
#'magnitude and sign) for exerter A upon receiver B. In principle, this allows
#'the InteractionType to reduce the amount of computation necessary by up to a
#'factor of two (although it may or may not be used). If reciprocal is F, the
#'interaction is not guaranteed to be reciprocal and each interaction will be
#'computed independently. The built-in interaction formulas are all reciprocal,
#'but if you implement an interaction() callback (see section 25.7), you must
#'consider whether the callback you have implemented preserves reciprocality
#'or not. For this reason, the default is reciprocal=F, so that bugs are not
#'inadvertently introduced by an invalid assumption of reciprocality. See
#'below for a note regarding reciprocality in sexual simulations when using the
#'sexSegregation flag. The maxDistance parameter supplies the maximum distance
#'over which interactions of this type will be evaluated; at greater distances,
#'the interaction strength is considered to be zero (for efficiency). The default
#'value of maxDistance, INF (positive infinity), indicates that there is no
#'maximum interaction distance; note that this can make some interaction queries
#'much less efficient, and is therefore not recommended. In SLiM 3.1 and later, a
#'warning will be issued if a spatial interaction type is defined with no maximum
#'distance to encourage a maximum distance to be defined. The sexSegregation
#'parameter governs the applicability of the interaction to each sex, in sexual
#'simulations. It does not affect distance calculations in any way; it only
#'modifies the way in which interaction strengths are calculated. The default,
#'"**", implies that the interaction is felt by both sexes (the first character
#'of the string value) and is exerted by both sexes (the second character of the
#'string value). Either or both characters may be M or F instead; for example,
#'"MM" would indicate a male-male interaction, such as male-male competition,
#'whereas "FM" would indicate an interaction influencing only female receivers
#'that is influenced only by male exerters, such as male mating displays that
#'influence female attraction. This parameter may be set only to "**" unless sex
#'has been enabled with initializeSex(). Note that a value of sexSegregation other
#'than "**" may imply some degree of non-reciprocality, but it is not necessary to
#'specify reciprocal to be F for this reason; SLiM will take the sex-segregation
#'of the interaction into account for you. The value of reciprocal may therefore
#'be interpreted as meaning: in those cases, if any, in which A interacts with
#'B and B interacts with A, is the interaction strength guaranteed to be the
#'same in both directions? By default, the interaction strength is 1.0 for all
#'interactions within maxDistance. Often it is desirable to change the interaction
#'function using setInteractionFunction(); modifying interaction strengths
#'can also be achieved with interaction() callbacks if necessary (see section
#'25.7). In any case, interactions beyond maxDistance always have a strength of
#'0.0, and the interaction strength of an individual with itself is always 0.0,
#'regardless of the interaction function or callbacks. The global symbol for the
#'new interaction type is immediately available; the return value also provides
#'the new object. Note that in multispecies models, initializeInteractionType()
#'must be called from a non-species-specific interaction() callback (declared
#'as species all initialize()), since interactions are managed at the community
#'level.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=622}{SLiM manual: page
#'622}.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Initialize$initializeMutationRate .Init$initializeMutationRate
#'@family Initialize
#'@return An object of type void.
#'@details Set the mutation rate per base position per gamete. To be precise, this
#'mutation rate is the expected mean number of mutations that will occur per base
#'position per gamete; note that this is different from how the recombination rate
#'is defined (see initializeRecombinationRate()). The number of mutations that
#'actually occurs at a given base position when generating an offspring genome
#'is, in effect, drawn from a Poisson distribution with that expected mean (but
#'under the hood SLiM uses a mathematically equivalent but much more efficient
#'strategy). It is possible for this Poisson draw to indicate that two or more new
#'mutations have arisen at the same base position, particularly when the mutation
#'rate is very high; in this case, the new mutations will be added to the site
#'one at a time, and as always the mutation stacking policy (see section 1.5.3)
#'will be followed. There are two ways to call this function. If the optional
#'ends parameter is NULL (the default), then rates must be a singleton value
#'that specifies a single mutation rate to be used along the entire chromosome.
#'If, on the other hand, ends is supplied, then rates and ends must be the same
#'length, and the values in ends must be specified in ascending order. In that
#'case, rates and ends taken together specify the mutation rates to be used along
#'successive contiguous stretches of the chromosome, from beginning to end; the
#'last position specified in ends should extend to the end of the chromosome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=623}{SLiM manual: page
#'623}.
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
#'@family Initialize
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
#'script parameter. See section 24.11 for discussion of the various DFEs and their
#'uses. The global symbol for the new mutation type is immediately available; the
#'return value also provides the new object. Note that by default in WF models,
#'all mutations of a given mutation type will be converted into Substitution
#'objects when they reach fixation, for efficiency reasons. If you need to disable
#'this conversion, to keep mutations of a given type active in the simulation
#'even after they have fixed, you can do so by setting the convertToSubstitution
#'property of MutationType to F. In contrast, by default in nonWF models mutations
#'will not be converted into Substitution objects when they reach fixation;
#'convertToSubstitution is F by default in nonWF models. To enable conversion in
#'nonWF models for neutral mutation types with no indirect fitness effects, you
#'should therefore set convertToSubstitution to T. See sections 22.3, 23.5, and
#'24.11.1 for further discussion regarding the convertToSubstitution property.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=623}{SLiM manual: page
#'623}.
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
#'@family Initialize
#'@return An object of type MutationType object. Return will be of length 1 (a
#'singleton)
#'@details Add a nucleotide-based mutation type at initialization time. This
#'function is identical to initializeMutationType() except that the new mutation
#'type will be nucleotide-based - in other words, mutations belonging to the
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=623}{SLiM manual: page
#'623}.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases
#'Initialize$initializeRecombinationRate .Init$initializeRecombinationRate
#'@family Initialize
#'@return An object of type void.
#'@details Set the recombination rate per base position per gamete. To be
#'precise, this recombination rate is the probability that a breakpoint will
#'occur between one base and the next base; note that this is different from how
#'the mutation rate is defined (see initializeMutationRate()). All rates must
#'be in the interval [0.0, 0.5]. A rate of 0.5 implies complete independence
#'between the adjacent bases, which might be used to implement independent
#'assortment of loci located on different chromosomes (see the example below).
#'Whether a breakpoint occurs between two bases is then, in effect, determined
#'by a binomial draw with a single trial and the given rate as probability (but
#'under the hood SLiM uses a mathematically equivalent but much more efficient
#'strategy). The recombinational process in SLiM will never generate more then
#'one crossover between one base and the next (in one generation/ genome), and
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=624}{SLiM manual: page
#'624}.
#'
#'@param chromosomeType An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Initialize$initializeSex .Init$initializeSex
#'@family Initialize
#'@return An object of type void.
#'@details Enable and configure sex in the simulation. The argument chromosomeType
#'gives the type of chromosome to be simulated; this should be "A", "X", or "Y".
#'Calling this function has the side effect of enabling sex in the simulation;
#'individuals will be male and female (rather than hermaphroditic) regardless of
#'the chromosomeType chosen for simulation. There is no way to disable sex once
#'it has been enabled; if you don't want to have sex, don't call this function.
#'The xDominanceCoeff parameter has been deprecated and removed. In SLiM 3.7 and
#'later, use the haploidDominanceCoeff property of MutationType instead. If the
#'chromosomeType is "X", the optional xDominanceCoeff parameter can supply the
#'dominance coefficient used when a mutation is present in an XY male, and is thus
#'"heterozygous" (but in a different sense than the heterozygosity of an XX female
#'with one copy of the mutation).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSex <- function(chromosomeType) {
 .Init$initializeSex(chromosomeType)
}

#'SLiM method initializeSLiMModelType
#'
#'Documentation for SLiM function \code{initializeSLiMModelType}, which is a
#'method of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=624}{SLiM manual: page
#'624}.
#'
#'@param modelType An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'
#'@aliases Initialize$initializeSLiMModelType .Init$initializeSLiMModelType
#'@family Initialize
#'@return An object of type void.
#'@details Configure the type of SLiM model used for the simulation. At present,
#'one of two model types may be selected. If modelType is "WF", SLiM will use a
#'Wright-Fisher (WF) model; this is the model type that has always been supported
#'by SLiM, and is the model type used if initializeSLiMModelType() is not called.
#'If modelType is "nonWF", SLiM will use a non-Wright-Fisher (nonWF) model
#'instead; this is a new model type supported by SLiM 3.0 and above (see section
#'1.6). If initializeSLiMModelType() is called at all then it must be called
#'before any other initialization function, so that SLiM knows from the outset
#'which features are enabled and which are not.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=625}{SLiM manual: page
#'625}.
#'
#'@param keepPedigrees An object of type logical or string or string or integer
#'or logical or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{F}. See details for description.
#'@param dimensionality An object of type logical or string or string or integer
#'or logical or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{""}. See details for description.
#'@param periodicity An object of type logical or string or string or integer or
#'logical or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{""}. See details for description.
#'@param mutationRuns An object of type logical or string or string or integer or
#'logical or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{0}. See details for description.
#'@param preventIncidentalSelfing An object of type logical or string or string or
#'integer or logical or logical or logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param nucleotideBased An object of type logical or string or string or integer
#'or logical or logical or logical. Must be of length 1 (a singleton). The default
#'value is \code{F}. See details for description.
#'@param randomizeCallbacks An object of type logical or string or string or
#'integer or logical or logical or logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Initialize$initializeSLiMOptions .Init$initializeSLiMOptions
#'@family Initialize
#'@return An object of type void.
#'@details Configure options for the simulation. If initializeSLiMOptions()
#'is called at all then it must be called before any other initialization
#'function (except initializeSLiMModelType()), so that SLiM knows from the
#'outset which optional features are enabled and which are not. If keepPedigrees
#'is T, SLiM will keep pedigree information for every individual in the
#'simulation, tracking the identity of its parents and grandparents. This
#'allows individuals to assess their degree of pedigree-based relatedness to
#'other individuals (see Individual's relatedness() method, section 24.7.2), as
#'well as allowing a model to find "trios" (two parents and an offspring they
#'generated) using the pedigree properties of Individual (section 24.7.1). As a
#'side effect of keepPedigrees being T, the pedigreeID, pedigreeParentIDs, and
#'pedigreeGrandparentIDs properties of Individual will have defined values (see
#'section 24.7.1), as will the genomePedigreeID property of Genome (see section
#'24.4.1). Note that pedigree-based relatedness doesn't necessarily correspond
#'to genetic relatedness, due to effects such as assortment and recombination.
#'For an overview of other ways of tracking genetic ancestry, including true
#'local ancestry at each position on the chromosome, see sections 1.7 and 14.7.
#'Beginning in SLiM 3.5, keepPedigrees=T also enables tracking of individual
#'reproductive output, available through the reproductiveOutput property of
#'Individual (see section 24.7.1) and the lifetimeReproductiveOutput property
#'of Subpopulation (see section 24.15.1). If dimensionality is not "", SLiM will
#'enable its optional "continuous space" facility. Three values for dimensionality
#'are presently supported: "x", "xy", and "xyz", specifying that continuous
#'space should be enabled for one, two, or three dimensions, respectively, using
#'(x), (x, y), and (x, y, z) coordinates respectively. This has a number of side
#'effects. First of all, it means that the specified properties of Individual (x,
#'y, and/or z) will be interpreted by SLiM as spatial positions; in particular,
#'SLiMgui will use those properties to display subpopulations spatially. Second,
#'it allows spatial interactions to be defined, evaluated, and queried using
#'initializeInteractionType() and interaction() callbacks. And third, it enables
#'the use of any other properties and methods related to continuous space, such
#'as setting the spatial boundaries of subpopulations, which would otherwise
#'raise an error. If periodicity is not "", SLiM will designate the specified
#'spatial dimensions as being periodic - wrapping around at the edges of the
#'spatial boundaries of that dimension. This option may only be used if the
#'dimensionality parameter to initializeSLiMOptions() has been used to enable
#'spatiality in the model, and only spatial dimensions that were specified in the
#'dimensionality of the model may be declared to be periodic (but if desired, it
#'is permissible to make just a subset of those dimensions periodic; it is not
#'an all-or-none proposition). For example, if the specified dimensionality is
#'"xy", the model's periodicity may be "x", "y", or "xy" (or "", the default,
#'to specify that there are no periodic dimensions). A one-dimensional periodic
#'model would model a space like the perimeter of a circle. A two-dimensional
#'model periodic in one of those dimensions would model a space like a cylinder
#'without its end caps; if periodic in both dimensions, the modeled space is a
#'torus. The shapes of three-dimensional periodic models are harder to visualize,
#'but are essentially higherdimensional analogues of these concepts. Periodic
#'boundary conditions are commonly used to model spatial scenarios without "edge
#'effects", since there are no edges in the periodic spatial dimensions. The
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
#'upon the machine and even the compiler used to build SLiM, so SLiM's default
#'value may not be optimal; for maximal performance it can thus be beneficial to
#'experiment with different values and find the optimal value for the simulation
#'- a process which SLiM can assist with (see section 21.4). Specifying the
#'number of mutation runs is an advanced technique, but in certain cases it can
#'improve performance significantly. If preventIncidentalSelfing is T, incidental
#'selfing in hermaphroditic models will be prevented by SLiM. By default (i.e.,
#'if preventIncidentalSelfing is F), SLiM chooses the first and second parents
#'in a biparental mating event independently. It is therefore possible for the
#'same individual to be chosen as both the first and second parent, resulting
#'in selfing events even when the selfing rate is zero. In many models this
#'is unimportant, since it happens fairly infrequently and does not have large
#'consequences. This behavior is SLiM's default because it is the simplest option,
#'and produces results that most closely align with simple analytical population
#'genetics models. However, in some models this selfing can be undesirable and
#'problematic. In particular, models that involve very high variance in fitness
#'or very small effective population sizes may see elevated rates of selfing that
#'substantially influence model results. If preventIncidentalSelfing is set to T,
#'all such incidental selfing will be prevented (by choosing a new second parent
#'if the first parent was chosen again). Non-incidental selfing, as requested by
#'the selfing rate, will still be permitted. Note that if incidental selfing is
#'prevented, SLiM will hang if it is unable to find a different second parent;
#'there must always be at least two individuals in the population with non-zero
#'fitness, and mateChoice() and modifyChild() callbacks must not absolutely
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
#'section 1.8 for further discussion. If randomizeCallbacks is T (the default),
#'the order in which individuals are processed in callbacks will be randomized
#'to make it easier to avoid order-dependency bugs. This flag exists because the
#'order of individuals in each subpopulation is non-random; most notably, females
#'always come before males in the individuals vector, but non-random ordering may
#'also occur with respect to things like migrant versus non-migrant status, origin
#'by selfing versus cloning versus biparental mating, and other factors. When this
#'option is F, individuals in a subpopulation are processed in the order of the
#'individuals vector in each tick cycle stage, which may lead to order-dependency
#'issues if there is an enabled callback whose behavior is not fully independent
#'between calls. Setting this option to T will cause individuals within each
#'subpopulation to be processed in a randomized order in each tick cycle stage;
#'specifically, this randomizes the order of calls to mutationEffect() callbacks
#'in both WF and nonWF models, and calls to reproduction() and survival()
#'callbacks in nonWF models. Each subpopulation is still processed separately,
#'in sequential order, so order-dependency issues between subpopulations are
#'still possible if callbacks have effects that are not fully independent. This
#'feature was added in SLiM 4, breaking backward compatibility; to recover the
#'behavior of previous versions of SLiM, pass F for this option (but then be very
#'careful about order-dependency issues in your script). The default of T is the
#'safe option, but a small speed penalty is incurred by the randomization of the
#'processing order - for most models the difference will be less than 1%, but in
#'the worst case it may approach 10%. Models that do not have any order-dependency
#'issue may therefore run somewhat faster if this is set to F. Note that anywhere
#'that your script uses the individuals property of Subpopulation, the order
#'of individuals returned will be non-random (regardless of the setting of this
#'option); you should use sample() to shuffle the order of the individuals vector
#'if necessary to avoid order-dependency issues in your script. This function
#'will likely be extended with further options in the future, added on to the end
#'of the argument list. Using named arguments with this call is recommended for
#'readability. Note that turning on optional features may increase the runtime and
#'memory footprint of SLiM.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSLiMOptions <- function(keepPedigrees, dimensionality, periodicity,
mutationRuns, preventIncidentalSelfing, nucleotideBased, randomizeCallbacks) {
 .Init$initializeSLiMOptions(keepPedigrees, dimensionality, periodicity,
mutationRuns, preventIncidentalSelfing, nucleotideBased, randomizeCallbacks)
}

#'SLiM method initializeSpecies
#'
#'Documentation for SLiM function \code{initializeSpecies}, which is a method of
#'the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=627}{SLiM manual: page
#'627}.
#'
#'@param tickModulo An object of type integer or integer or string or string. Must
#'be of length 1 (a singleton). The default value is \code{1}. See details for
#'description.
#'@param tickPhase An object of type integer or integer or string or string. Must
#'be of length 1 (a singleton). The default value is \code{1}. See details for
#'description.
#'@param avatar An object of type integer or integer or string or string. Must
#'be of length 1 (a singleton). The default value is \code{""}. See details for
#'description.
#'@param color An object of type integer or integer or string or string. Must
#'be of length 1 (a singleton). The default value is \code{""}. See details for
#'description.
#'
#'@aliases Initialize$initializeSpecies .Init$initializeSpecies
#'@family Initialize
#'@return An object of type void.
#'@details Configure options for the species being initialized. This
#'initialization function may only be called in multispecies models (i.e.,
#'models with explicit species declarations); in single-species models, the
#'default values are assumed and cannot be changed. The tickModulo and tickPhase
#'parameters determine the activation schedule for the species. The active
#'property of the species will be set to T (thus activating the species) every
#'tickModulo ticks, beginning in tick tickPhase. (However, when the species
#'is activated in a given tick, the skipTick() method may still be called in a
#'first() event to deactivate it.) See the active property of Species (section
#'24.14.1) for more details. The avatar parameter, if not "", sets a string value
#'used to represent the species graphically, particularly in SLiMgui but perhaps
#'in other contexts also. The avatar should generally be a single character -
#'usually an emoji corresponding to the species, such as "🦊 " for foxes or "🐭
#'" for mice. If avatar is the empty string, "", SLiMgui will choose a default
#'avatar. The color parameter, if not "", sets a string color value used to
#'represent the species in SLiMgui. Colors may be specified by name, or with
#'hexadecimal RGB values of the form "#RRGGBB" (see the Eidos manual for details).
#'If color is the empty string, "", SLiMgui will choose a default color.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeSpecies <- function(tickModulo, tickPhase, avatar, color) {
 .Init$initializeSpecies(tickModulo, tickPhase, avatar, color)
}

#'SLiM method initializeTreeSeq
#'
#'Documentation for SLiM function \code{initializeTreeSeq}, which is a method of
#'the SLiM class \code{\link{Initialize}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=627}{SLiM manual: page
#'627}.
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
#'@param retainCoalescentOnly An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param timeUnit An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Initialize$initializeTreeSeq .Init$initializeTreeSeq
#'@family Initialize
#'@return An object of type void.
#'@details Configure options for tree sequence recording. Calling this
#'function turns on tree sequence recording, as a side effect, for later
#'reconstruction of the simulation's evolutionary dynamics; if you do not
#'want tree sequence recording to be enabled, do not call this function. Note
#'that tree-sequence recording internally uses SLiM's "pedigree tracking"
#'feature to uniquely identify individuals and genomes; however, if you
#'want to use pedigree tracking in your script you must still enable it
#'yourself with initializeSLiMOptions(keepPedigrees=T). The recordMutations
#'flag controls whether information about individual mutations is recorded
#'or not. Such recording takes time and memory, and so can be turned off if
#'only the tree sequence itself is needed, but it is turned on by default
#'since mutation recording is generally useful. The simplificationRatio and
#'simplificationInterval parameters control how often automatic simplification
#'of the recorded tree sequence occurs. This is a speed-memory tradeoff:
#'more frequent simplification (lower simplificationRatio or smaller
#'simplificationInterval) means the stored tree sequences will use less
#'memory, but at a cost of somewhat longer run times. Conversely, a larger
#'simplificationRatio or simplificationInterval means that SLiM will wait longer
#'between simplifications. There are three ways these parameters can be used.
#'With the first option, with a non- NULL simplificationRatio and a NULL value
#'for simplificationInterval, SLiM will try to find an optimal tick interval
#'for simplification such that the ratio of the memory used by the tree sequence
#'tables, (before:after) simplification, is close to the requested ratio. The
#'default of 10 (used if both simplificationRatio and simplificationInterval are
#'NULL) thus requests that SLiM try to find a tick interval such that the maximum
#'size of the stored tree sequences is ten times the size after simplification.
#'INF may be supplied to indicate that automatic simplification should never
#'occur; 0 may be supplied to indicate that automatic simplification should
#'be performed at the end of every tick. Alternatively - the second option -
#'simplificationRatio may be NULL and simplificationInterval may be set to the
#'interval, in ticks, between simplifications. This may provide more reliable
#'performance, but the interval must be chosen carefully to avoid exceeding the
#'available memory. The simplificationInterval value may be a very large number
#'to specify that simplification should never occur (not INF, though, since it
#'is an integer value), or 1 to simplify every tick. Finally - the third option
#'- both parameters may be non-NULL, in which case simplificationRatio is used
#'as described above, while simplificationInterval provides the initial interval
#'first used by SLiM (and then subsequently increased or decreased to try to match
#'the requested simplification ratio). The default initial interval, used when
#'simplificationInterval is NULL, is usually 20; this is chosen to be relatively
#'frequent, and thus unlikely to lead to a memory overflow, but it can result in
#'rather slow spool-up for models where the equilibrium simplification interval,
#'as determined by the simplification ratio, is much longer. It can therefore be
#'helpful to set a larger initial interval so that the early part of the model
#'run is not excessively bogged down in simplification. The checkCoalescence
#'parameter controls whether a check for full coalescence is conducted after
#'each simplification. If a model will call treeSeqCoalesced() to check for
#'coalescence during its execution, checkCoalescence should be set to T. Since
#'the coalescence checks entail a performance penalty, the default of F is
#'preferable otherwise. See the documentation for treeSeqCoalesced() for further
#'discussion. The runCrosschecks parameter controls whether cross-checks between
#'SLiM's internal data structures and the tree-sequence recording data structures
#'will be conducted. These two sets of data structures record much the same thing
#'(mutations in genomes), but using completely different representations, so such
#'cross-checks can be useful to confirm that the two data structures do indeed
#'represent the same conceptual state. This slows down the model considerably,
#'however, and would normally be turned on only for debugging purposes, so it
#'is turned off by default. The retainCoalescentOnly parameter controls how,
#'exactly, simplification of the tree-sequence data is performed in SLiM (both
#'for auto-simplification and for calls to treeSeqSimplify()). More specifically,
#'this parameter controls the behavior of simplification for individuals and
#'genomes that have been "retained" by calling treeSeqRememberIndividuals()
#'with the parameter permanent=F. The default of retainCoalescentOnly=T helps
#'to keep the number of retained individuals relatively small, which is helpful
#'if your simulation regularly flags many individuals for retaining. In this
#'case, changing retainCoalescentOnly to F may dramatically increase memory usage
#'and runtime, in a similar way to permanently remembering all the individuals.
#'See the documentation of treeSeqRememberIndividuals() for further discussion
#'(section 24.14.2). The timeUnit parameter controls the time unit stated in the
#'tree sequence when it is saved (which can be accessed through tskit APIs); it
#'has no effect on the running simulation whatsoever. The default value, NULL,
#'means that a time unit of "ticks" will be used for all model types. (In SLiM
#'3.7 / 3.7.1, NULL implied a time unit of "generations" for WF models, but
#'"ticks" for nonWF models; given the new multispecies timescale parameters in
#'SLiM 4, a default of "ticks" makes sense in all cases since now even in WF
#'models one tick might not equal one biological generation.) It may be helpful
#'to set timeUnit to "generations" explicitly when modeling non-overlapping
#'generations in which one tick equals one generation, to tell tskit that the time
#'unit does in fact represent biological generations; doing so may avoid warnings
#'from tskit or msprime regarding the time unit, in cases such as recapitation
#'where the simulation timescale is important.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
initializeTreeSeq <- function(recordMutations, simplificationRatio,
simplificationInterval, checkCoalescence, runCrosschecks, retainCoalescentOnly,
timeUnit) {
 .Init$initializeTreeSeq(recordMutations, simplificationRatio,
simplificationInterval, checkCoalescence, runCrosschecks, retainCoalescentOnly,
timeUnit)
}



#'SLiM method ancestralNucleotides
#'
#'Documentation for SLiM function \code{ancestralNucleotides}, which is a method
#'of the SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=632}{SLiM manual: page
#'632}.
#'
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param format = "string" An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Chromosome$ancestralNucleotides .Ch$ancestralNucleotides
#'@family Chromosome
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
#'corresponding amino acid sequence if desired (see section 24.17.1).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
ancestralNucleotides <- function(start, end, format = "string") {
 .Ch$ancestralNucleotides(start, end, format = "string")
}

#'SLiM method drawBreakpoints
#'
#'Documentation for SLiM function \code{drawBreakpoints}, which is a method of the
#'SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=632}{SLiM manual: page
#'632}.
#'
#'@param parent An object of type null or Individual object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'@param n An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases Chromosome$drawBreakpoints .Ch$drawBreakpoints
#'@family Chromosome
#'@return An object of type integer.
#'@details Draw recombination breakpoints, using the chromosome's recombination
#'rate map, the current gene conversion parameters, and (in some cases - see
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
#'will not be called as a side effect of this method if parent is NULL. Apart
#'from these two uses, parent is not used, and the caller does not guarantee that
#'the generated breakpoints will actually be used to recombine the genomes of
#'parent in particular. If a recombination() callback is called, genome1 for that
#'callback will always be parent.genome1; in other words, drawBreakpoints() will
#'always treat parent.genome1 as the initial copy strand. If the caller wishes to
#'randomly choose an initial copy strand (which is usually desirable), they should
#'do that themselves.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawBreakpoints <- function(parent, n) {
 .Ch$drawBreakpoints(parent, n)
}

#'SLiM method setAncestralNucleotides
#'
#'Documentation for SLiM function \code{setAncestralNucleotides}, which is a
#'method of the SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=633}{SLiM manual: page
#'633}.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases Chromosome$setAncestralNucleotides .Ch$setAncestralNucleotides
#'@family Chromosome
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details This method, which may be called only in nucleotide-based models
#'(see section 1.8), replaces the ancestral nucleotide sequence for the
#'model. The sequence parameter is interpreted exactly as it is in the
#'initializeAncestralSequence() function; see that documentation for details
#'(section 24.1). The length of the ancestral sequence is returned. It is unusual
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setAncestralNucleotides <- function(sequence) {
 .Ch$setAncestralNucleotides(sequence)
}

#'SLiM method setGeneConversion
#'
#'Documentation for SLiM function \code{setGeneConversion}, which is a method of
#'the SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=633}{SLiM manual: page
#'633}.
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
#'@aliases Chromosome$setGeneConversion .Ch$setGeneConversion
#'@family Chromosome
#'@return An object of type void.
#'@details This method switches the recombination model to the "double-stranded
#'break (DSB)" model (if it is not already set to that), and configures the
#'details of the gene conversion tracts that will therefore be modeled (see
#'section 1.5.6 for discussion of the "DSB" recombination model). The meanings
#'and effects of the parameters exactly mirror the initializeGeneConversion()
#'function; see section 24.1 for details.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setGeneConversion <- function(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias) {
 .Ch$setGeneConversion(nonCrossoverFraction, meanLength,
simpleConversionFraction, bias)
}

#'SLiM method setHotspotMap
#'
#'Documentation for SLiM function \code{setHotspotMap}, which is a method of the
#'SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=633}{SLiM manual: page
#'633}.
#'
#'@param multipliers An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setHotspotMap .Ch$setHotspotMap
#'@family Chromosome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setHotspotMap <- function(multipliers, ends, sex) {
 .Ch$setHotspotMap(multipliers, ends, sex)
}

#'SLiM method setMutationRate
#'
#'Documentation for SLiM function \code{setMutationRate}, which is a method of the
#'SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=634}{SLiM manual: page
#'634}.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setMutationRate .Ch$setMutationRate
#'@family Chromosome
#'@return An object of type void.
#'@details Set the mutation rate per base position per gamete. There are two ways
#'to call this method. If the optional ends parameter is NULL (the default), then
#'rates must be a singleton value that specifies a single mutation rate to be
#'used along the entire chromosome. If, on the other hand, ends is supplied, then
#'rates and ends must be the same length, and the values in ends must be specified
#'in ascending order. In that case, rates and ends taken together specify
#'the mutation rates to be used along successive contiguous stretches of the
#'chromosome, from beginning to end; the last position specified in ends should
#'extend to the end of the chromosome (as previously determined, during simulation
#'initialization). See the initializeMutationRate() function for further
#'discussion of precisely how these rates and positions are interpreted. If the
#'optional sex parameter is "*" (the default), then the supplied mutation rate
#'map will be used for both sexes (which is the only option for hermaphroditic
#'simulations). In sexual simulations sex may be "M" or "F" instead, in which
#'case the supplied mutation rate map is used only for that sex. Note that
#'whether sex-specific mutation rate maps will be used is set by the way that the
#'simulation is initially configured with initializeMutationRate(), and cannot be
#'changed with this method; so if the simulation was set up to use sex-specific
#'mutation rate maps then sex must be "M" or "F" here, whereas if it was set up
#'not to, then sex must be "*" or unsupplied here. If a simulation needs sex-
#'specific mutation rate maps only some of the time, the male and female maps can
#'simply be set to be identical the rest of the time. The mutation rate intervals
#'are normally a constant in simulations, so be sure you know what you are doing.
#'In nucleotide-based models, setMutationRate() may not be called. If variation
#'in the mutation rate along the chromosome is desired, setHotspotMap() should be
#'used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationRate <- function(rates, ends, sex) {
 .Ch$setMutationRate(rates, ends, sex)
}

#'SLiM method setRecombinationRate
#'
#'Documentation for SLiM function \code{setRecombinationRate}, which is a method
#'of the SLiM class \code{\link{Chromosome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=634}{SLiM manual: page
#'634}.
#'
#'@param rates An object of type numeric. See details for description.
#'@param ends An object of type null or integer. The default value is \code{NULL}.
#'See details for description.
#'@param sex An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"*"}. See details for description.
#'
#'@aliases Chromosome$setRecombinationRate .Ch$setRecombinationRate
#'@family Chromosome
#'@return An object of type void.
#'@details Set the recombination rate per base position per gamete. All rates must
#'be in the interval [0.0, 0.5]. There are two ways to call this method. If the
#'optional ends parameter is NULL (the default), then rates must be a singleton
#'value that specifies a single recombination rate to be used along the entire
#'chromosome. If, on the other hand, ends is supplied, then rates and ends must
#'be the same length, and the values in ends must be specified in ascending order.
#'In that case, rates and ends taken together specify the recombination rates to
#'be used along successive contiguous stretches of the chromosome, from beginning
#'to end; the last position specified in ends should extend to the end of the
#'chromosome (as previously determined, during simulation initialization). See
#'the initializeRecombinationRate() function for further discussion of precisely
#'how these rates and positions are interpreted. If the optional sex parameter
#'is "*" (the default), then the supplied recombination rate map will be used
#'for both sexes (which is the only option for hermaphroditic simulations). In
#'sexual simulations sex may be "M" or "F" instead, in which case the supplied
#'recombination map is used only for that sex. Note that whether sex-specific
#'recombination maps will be used is set by the way that the simulation is
#'initially configured with initializeRecombinationRate(), and cannot be
#'changed with this method; so if the simulation was set up to use sex-specific
#'recombination maps then sex must be "M" or "F" here, whereas if it was set
#'up not to, then sex must be "*" or unsupplied here. If a simulation needs
#'sex-specific recombination maps only some of the time, the male and female
#'maps can simply be set to be identical the rest of the time. The recombination
#'intervals are normally a constant in simulations, so be sure you know what you
#'are doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setRecombinationRate <- function(rates, ends, sex) {
 .Ch$setRecombinationRate(rates, ends, sex)
}



#'SLiM method createLogFile
#'
#'Documentation for SLiM function \code{createLogFile}, which is a method of the
#'SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=636}{SLiM manual: page
#'636}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param initialContents An object of type null or string. The default value is
#'\code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param compress An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param sep An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{","}. See details for description.
#'@param logInterval An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param flushInterval An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Community$createLogFile .Co$createLogFile
#'@family Community
#'@return An object of type LogFile object. Return will be of length 1 (a
#'singleton)
#'@details Creates and returns a new LogFile object that logs data from the
#'simulation (see the documentation for the LogFile class for details). Logged
#'data will be written to the file at filePath, overwriting any existing file
#'at that path by default, or appending to it instead if append is T (successive
#'rows of the log table will always be appended to the previously written content,
#'of course). Before the header line for the log is written out, any string
#'elements in initialContents will be written first, separated by newlines,
#'allowing for a user-defined file header. If compress is T, the contents will
#'be compressed with zlib as they are written, and the standard .gz extension for
#'gzip-compressed files will be appended to the filename in filePath if it is not
#'already present. The sep parameter specifies the separator between data values
#'within a row. The default of "," will generate a "comma-separated value" (CSV)
#'file, while passing sep="\\t" will use a tab separator instead to generate a
#'"tab-separated value" (TSV) file. Other values for sep may also be used, but are
#'less standard. LogFile supports periodic automatic logging of a new row of data,
#'enabled by supplying a non-NULL value for logInterval. In this case, a new row
#'will be logged (as if logRow() were called on the LogFile) at the end of every
#'logInterval ticks (just before the tick counter increments, in both WF and nonWF
#'models), starting at the end of the tick in which the LogFile was created. A
#'logInterval of 1 will cause automatic logging at the end of every tick, whereas
#'a logInterval of NULL disables automatic logging. Automatic logging can always
#'be disabled or reconfigured later with the LogFile method setLogInterval(),
#'or logging can be triggered manually by calling logRow(). When compression is
#'enabled, LogFile flushes new data lazily by default, for performance reasons,
#'buffering data for multiple rows before writing to disk. Passing a non-NULL
#'value for flushInterval requests a flush every flushInterval rows (with a value
#'of 1 providing unbuffered operation). Note that flushing very frequently will
#'likely result in both lower performance and a larger final file size (in one
#'simple test, 48943 bytes instead of 4280 bytes, or more than a 10× increase
#'in size). Alternatively, passing a very large value for flushInterval will
#'effectively disable automatic flushing, except at the end of the simulation (but
#'be aware that this may use a large amount of memory for large log files). In
#'any case, the log file will be created immediately, with its requested initial
#'contents; the initial write is not buffered. When compression is not enabled,
#'the flushInterval setting is ignored. The LogFile documentation discusses how to
#'configure and use LogFile to write out the data you are interested in from your
#'simulation; see section 24.10.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
createLogFile <- function(filePath, initialContents, append, compress, sep,
logInterval, flushInterval) {
 .Co$createLogFile(filePath, initialContents, append, compress, sep,
logInterval, flushInterval)
}

#'SLiM method deregisterScriptBlock
#'
#'Documentation for SLiM function \code{deregisterScriptBlock}, which is a method
#'of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param scriptBlocks An object of type integer or SLiMEidosBlock object. See
#'details for description.
#'
#'@aliases Community$deregisterScriptBlock .Co$deregisterScriptBlock
#'@family Community
#'@return An object of type void.
#'@details All SLiMEidosBlock objects specified by scriptBlocks (either with
#'SLiMEidosBlock objects or with integer identifiers) will be scheduled for
#'deregistration. The deregistered blocks remain valid, and may even still be
#'executed in the current stage of the current tick (see section 25.11); the
#'blocks are not actually deregistered and deallocated until sometime after the
#'currently executing script block has completed. To immediately prevent a script
#'block from executing, even when it is scheduled to execute in the current stage
#'of the current tick, use the active property of the script block (see sections
#'24.12.1 and 25.11).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
deregisterScriptBlock <- function(scriptBlocks) {
 .Co$deregisterScriptBlock(scriptBlocks)
}

#'SLiM method genomicElementTypesWithIDs
#'
#'Documentation for SLiM function \code{genomicElementTypesWithIDs}, which is a
#'method of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$genomicElementTypesWithIDs .Co$genomicElementTypesWithIDs
#'@family Community
#'@return An object of type GenomicElementType object.
#'@details Find and return the GenomicElementType objects with id values matching
#'the values in ids. If no matching GenomicElementType object can be found with a
#'given id, an error results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
genomicElementTypesWithIDs <- function(ids) {
 .Co$genomicElementTypesWithIDs(ids)
}

#'SLiM method interactionTypesWithIDs
#'
#'Documentation for SLiM function \code{interactionTypesWithIDs}, which is a
#'method of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$interactionTypesWithIDs .Co$interactionTypesWithIDs
#'@family Community
#'@return An object of type InteractionType object.
#'@details Find and return the InteractionType objects with id values matching the
#'values in ids. If no matching InteractionType object can be found with a given
#'id, an error results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
interactionTypesWithIDs <- function(ids) {
 .Co$interactionTypesWithIDs(ids)
}

#'SLiM method mutationTypesWithIDs
#'
#'Documentation for SLiM function \code{mutationTypesWithIDs}, which is a method
#'of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$mutationTypesWithIDs .Co$mutationTypesWithIDs
#'@family Community
#'@return An object of type MutationType object.
#'@details Find and return the MutationType objects with id values matching the
#'values in ids. If no matching MutationType object can be found with a given id,
#'an error results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationTypesWithIDs <- function(ids) {
 .Co$mutationTypesWithIDs(ids)
}

#'SLiM method outputUsage
#'
#'Documentation for SLiM function \code{outputUsage}, which is a method of the
#'SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases Community$outputUsage .Co$outputUsage
#'@family Community
#'@return An object of type void.
#'@details Output the current memory usage of the simulation to Eidos's output
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputUsage <- function(void) {
 .Co$outputUsage(void)
}

#'SLiM method registerEarlyEvent
#'
#'Documentation for SLiM function \code{registerEarlyEvent}, which is a method of
#'the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param ticksSpec An object of type null or Species object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Community$registerEarlyEvent .Co$registerEarlyEvent
#'@family Community
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos early() event in the current simulation, with
#'optional start and end ticks (and, for multispecies models, optional ticks
#'specifier ticksSpec) limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered event is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current tick (see section 25.11 for details). The new SLiMEidosBlock will
#'be defined as a global variable immediately by this method (see section 24.12),
#'and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerEarlyEvent <- function(id, source, start, end, ticksSpec) {
 .Co$registerEarlyEvent(id, source, start, end, ticksSpec)
}

#'SLiM method registerFirstEvent
#'
#'Documentation for SLiM function \code{registerFirstEvent}, which is a method of
#'the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=637}{SLiM manual: page
#'637}.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param ticksSpec An object of type null or Species object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Community$registerFirstEvent .Co$registerFirstEvent
#'@family Community
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos first() event in the current simulation, with
#'optional start and end ticks (and, for multispecies models, optional ticks
#'specifier ticksSpec) limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered event is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current tick (see section 25.11 for details). The new SLiMEidosBlock will
#'be defined as a global variable immediately by this method (see section 24.12),
#'and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerFirstEvent <- function(id, source, start, end, ticksSpec) {
 .Co$registerFirstEvent(id, source, start, end, ticksSpec)
}

#'SLiM method registerInteractionCallback
#'
#'Documentation for SLiM function \code{registerInteractionCallback}, which is a
#'method of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=638}{SLiM manual: page
#'638}.
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
#'@aliases Community$registerInteractionCallback .Co$registerInteractionCallback
#'@family Community
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos interaction() callback in the current simulation
#'(global to the community), with a required interaction type intType (which may
#'be an integer identifier), optional exerter subpopulation subpop (which may also
#'be an integer identifier, or NULL, the default, to indicate all subpopulations),
#'and optional start and end ticks all limiting its applicability. The script
#'block will be given identifier id (specified as an integer, or as a string
#'symbolic name such as "s5"); this may be NULL if there is no need to be able
#'to refer to the block later. The registered callback is added to the end of the
#'list of registered SLiMEidosBlock objects, and is active immediately; it will
#'be eligible to execute the next time an InteractionType is evaluated. The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.12), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerInteractionCallback <- function(id, source, intType, subpop, start,
end) {
 .Co$registerInteractionCallback(id, source, intType, subpop, start, end)
}

#'SLiM method registerLateEvent
#'
#'Documentation for SLiM function \code{registerLateEvent}, which is a method of
#'the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=638}{SLiM manual: page
#'638}.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param ticksSpec An object of type null or Species object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Community$registerLateEvent .Co$registerLateEvent
#'@family Community
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos late() event in the current simulation, with
#'optional start and end ticks (and, for multispecies models, optional ticks
#'specifier ticksSpec) limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered event is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current tick (see section 25.11 for details). The new SLiMEidosBlock will
#'be defined as a global variable immediately by this method (see section 24.12),
#'and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerLateEvent <- function(id, source, start, end, ticksSpec) {
 .Co$registerLateEvent(id, source, start, end, ticksSpec)
}

#'SLiM method rescheduleScriptBlock
#'
#'Documentation for SLiM function \code{rescheduleScriptBlock}, which is a method
#'of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=638}{SLiM manual: page
#'638}.
#'
#'@param block An object of type integer or SLiMEidosBlock object. Must be of
#'length 1 (a singleton). See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param ticks An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Community$rescheduleScriptBlock .Co$rescheduleScriptBlock
#'@family Community
#'@return An object of type SLiMEidosBlock object.
#'@details Reschedule the target script block given by block to execute in
#'a specified set of ticks. The block parameter may be either an integer
#'representing the ID of the desired script block, or a SLiMScriptBlock specified
#'directly. The first way to specify the tick set is with start and end parameter
#'values; block will then execute from start to end, inclusive. In this case,
#'block is returned. The second way to specify the tick set is using the ticks
#'parameter; this is more flexible but more complicated. Since script blocks
#'execute across a contiguous span of ticks defined by their start and end
#'properties, this may result in the duplication of block; one script block will
#'be used for each contiguous span of ticks in ticks. The block object itself will
#'be rescheduled to cover the first such span, whereas duplicates of block will
#'be created to cover subsequent contiguous spans. A vector containing all of the
#'script blocks scheduled by this method, including block, will be returned; this
#'vector is guaranteed to be sorted by the (ascending) scheduled execution order
#'of the blocks. Any duplicates of block created will be given values for the
#'active, source, tag, and type properties equal to the current values for block,
#'but will be given an id of -1 since script block identifiers must be unique; if
#'it is necessary to find the duplicated blocks again later, their tag property
#'should be used. The vector supplied for ticks does not need to be in sorted
#'order, but it must not contain any duplicates. Because this method can create
#'a large number of duplicate script blocks, it can sometimes be better to handle
#'script block scheduling in other ways. If an early() event needs to execute
#'every tenth tick over the whole duration of a long model run, for example, it
#'would not be advisable to use a call like community.rescheduleScriptBlock(s1,
#'ticks=seq(10, 100000, 10)) for that purpose, since that would result in
#'thousands of duplicate script blocks. Instead, it would be preferable to add
#'a test such as if (community.tick % 10 != 0) return; at the beginning of the
#'event. It is legal to reschedule a script block while the block is executing;
#'a call like community.rescheduleScriptBlock(self, community.tick + 10,
#'community.tick + 10); made inside a given block would therefore also cause the
#'block to execute every tenth tick, although this sort of self-rescheduling code
#'is probably harder to read, maintain, and debug. Whichever way of specifying
#'the tick set is used, the discussion in section 25.11 applies: block may
#'continue to be executed during the current tick cycle stage even after it has
#'been rescheduled, unless it is made inactive using its active property, and
#'similarly, the block may not execute during the current tick cycle stage if it
#'was not already scheduled to do so. Rescheduling script blocks during the tick
#'and tick cycle stage in which they are executing, or in which they are intended
#'to execute, should be avoided. Also, as mentioned in section 22.7, script
#'blocks which are open-ended (i.e., with no specified end tick), are not used
#'in determining whether the end of the simulation has been reached (because then
#'the simulation would run forever); if you reschedule a block to be open-ended,
#'and to start after the end of the last closed-ended block, the rescheduled block
#'will therefore not run at all (just as such a block would not run at all in
#'other circumstances, too). Note that new script blocks can also be created and
#'scheduled using the register...() methods of Community and Species; by using
#'the same source as a template script block, the template can be duplicated and
#'scheduled for different ticks. In fact, rescheduleScriptBlock() does essentially
#'that internally. In multispecies models, note that all new script blocks created
#'as a side effect of rescheduleScriptBlock() will have the same species and ticks
#'specifier as block; use the register...() methods to create a new block with a
#'different species or ticks specifier.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
rescheduleScriptBlock <- function(block, start, end, ticks) {
 .Co$rescheduleScriptBlock(block, start, end, ticks)
}

#'SLiM method scriptBlocksWithIDs
#'
#'Documentation for SLiM function \code{scriptBlocksWithIDs}, which is a method of
#'the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=639}{SLiM manual: page
#'639}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$scriptBlocksWithIDs .Co$scriptBlocksWithIDs
#'@family Community
#'@return An object of type SLiMEidosBlock object.
#'@details Find and return the SLiMEidosBlock objects with id values matching the
#'values in ids. If no matching SLiMEidosBlock object can be found with a given
#'id, an error results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
scriptBlocksWithIDs <- function(ids) {
 .Co$scriptBlocksWithIDs(ids)
}

#'SLiM method simulationFinished
#'
#'Documentation for SLiM function \code{simulationFinished}, which is a method of
#'the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=639}{SLiM manual: page
#'639}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases Community$simulationFinished .Co$simulationFinished
#'@family Community
#'@return An object of type void.
#'@details Declare the current simulation finished. Normally SLiM ends a
#'simulation when, at the end of a tick, there are no script events or callbacks
#'registered for any future tick (excluding scripts with no declared end tick).
#'If you wish to end a simulation before this condition is met, a call to
#'simulationFinished() will cause the current simulation to end at the end of
#'the current tick. For example, a simulation might self-terminate if a test for
#'a dynamic equilibrium condition is satisfied. Note that the current tick will
#'finish executing; if you want the simulation to stop immediately, you can use
#'the Eidos method stop(), which raises an error condition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
simulationFinished <- function(void) {
 .Co$simulationFinished(void)
}

#'SLiM method speciesWithIDs
#'
#'Documentation for SLiM function \code{speciesWithIDs}, which is a method of the
#'SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=639}{SLiM manual: page
#'639}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$speciesWithIDs .Co$speciesWithIDs
#'@family Community
#'@return An object of type Species object.
#'@details Find and return the Species objects with id values matching the values
#'in ids. If no matching Species object can be found with a given id, an error
#'results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
speciesWithIDs <- function(ids) {
 .Co$speciesWithIDs(ids)
}

#'SLiM method subpopulationsWithIDs
#'
#'Documentation for SLiM function \code{subpopulationsWithIDs}, which is a method
#'of the SLiM class \code{\link{Community}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=639}{SLiM manual: page
#'639}.
#'
#'@param ids An object of type integer. See details for description.
#'
#'@aliases Community$subpopulationsWithIDs .Co$subpopulationsWithIDs
#'@family Community
#'@return An object of type Subpopulation object.
#'@details Find and return the Subpopulation objects with id values matching the
#'values in ids. If no matching Subpopulation object can be found with a given id,
#'an error results.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
subpopulationsWithIDs <- function(ids) {
 .Co$subpopulationsWithIDs(ids)
}



#'SLiM method addMutations
#'
#'Documentation for SLiM function \code{addMutations}, which is a method of the
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=640}{SLiM manual: page
#'640}.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Genome$addMutations .G$addMutations
#'@family Genome
#'@return An object of type void.
#'@details Add the existing mutations in mutations to the genome, if they are
#'not already present (if they are already present, they will be ignored), and
#'if the addition is not prevented by the mutation stacking policy (see the
#'mutationStackPolicy property of MutationType, section 24.11.1). Calling this
#'will normally affect the fitness values calculated toward the end of the
#'current tick; if you want current fitness values to be affected, you can call
#'the Species method recalculateFitness() - but see the documentation of that
#'method for caveats. Note that in nonWF models that use tree-sequence recording,
#'mutations cannot be added to an individual after the tick in which the
#'individual is created (i.e., when the age of the individual is greater than 0),
#'to prevent the possibility of inconsistencies in the recorded tree sequence.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=640}{SLiM manual: page
#'640}.
#'
#'@param mutationType An object of type integer or MutationType object. See
#'details for description.
#'@param position An object of type integer. See details for description.
#'@param originTick An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'@param originSubpop An object of type null or integer or Subpopulation object.
#'The default value is \code{NULL}. See details for description.
#'@param nucleotide An object of type null or integer or string. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases Genome$addNewDrawnMutation .G$addNewDrawnMutation
#'@family Genome
#'@return An object of type Mutation object.
#'@details Add new mutations to the target genome(s) with the specified
#'mutationType (specified by the MutationType object or by integer identifier),
#'position, originTick (which may be NULL, the default, to specify the current
#'tick; otherwise, beginning in SLiM 3.5, it must be equal to the current tick
#'anyway, as other uses of this property have been deprecated), and originSubpop
#'(specified by the Subpopulation object or by integer identifier, or by NULL,
#'the default, to specify the subpopulation to which the first target genome
#'belongs). If originSubpop is supplied as an integer, it is intentionally not
#'checked for validity; you may use arbitrary values of originSubpop to "tag" the
#'mutations that you create (see section 24.10.1). The selection coefficients of
#'the mutations are drawn from their mutation types; addNewMutation() may be used
#'instead if you wish to specify selection coefficients. In non-nucleotide-based
#'models, mutationType will always be a non-nucleotide-based mutation type, and so
#'nucleotide must be NULL (the default). In a nucleotide-based model, mutationType
#'might still be non-nucleotide-based (in which case nucleotide must still be
#'NULL), or mutationType might be nucleotide-based, in which case a non-NULL value
#'must be supplied for nucleotide, specifying the nucleotide(s) to be associated
#'with the new mutation(s). Nucleotides may be specified with string values ("A",
#'"C", "G", or "T"), or with integer values (A=0, C=1, G=2, T=3). If a nucleotide
#'mutation already exists at the mutating position, it is replaced automatically
#'in accordance with the stacking policy for nucleotide- based mutation types. No
#'check is performed that a new mutation's nucleotide differs from the ancestral
#'sequence, or that its selection coefficient is consistent with other mutations
#'that may already exist at the given position with the same nucleotide; model
#'consistency is the responsibility of the model. Beginning in SLiM 2.5 this
#'method is vectorized, so all of these parameters may be singletons (in which
#'case that single value is used for all mutations created by the call) or
#'non-singleton vectors (in which case one element is used for each corresponding
#'mutation created). Non- singleton parameters must match in length, since their
#'elements need to be matched up one- to-one. The new mutations created by this
#'method are returned, even if their actual addition is prevented by the mutation
#'stacking policy (see the mutationStackPolicy property of MutationType, section
#'24.11.1). However, the order of the mutations in the returned vector is not
#'guaranteed to be the same as the order in which the values are specified in
#'parameter vectors, unless the position parameter is specified in ascending
#'order. In other words, pre- sorting the parameters to this method into ascending
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
#'Before SLiM 4, this method also took an originGeneration parameter. This was
#'deprecated (the origin generation was then required to be equal to the current
#'generation, for internal consistency), and was removed in SLiM 4. Calling this
#'will normally affect the fitness values calculated at the end of the current
#'tick (but not sooner); if you want current fitness values to be affected, you
#'can call the Species method recalculateFitness() - but see the documentation
#'of that method for caveats. Note that in nonWF models that use tree-sequence
#'recording, mutations cannot be added to an individual after the tick in which
#'the individual is created (i.e., when the age of the individual is greater than
#'0), to prevent the possibility of inconsistencies in the recorded tree sequence.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addNewDrawnMutation <- function(mutationType, position, originTick,
originSubpop, nucleotide) {
 .G$addNewDrawnMutation(mutationType, position, originTick, originSubpop,
nucleotide)
}

#'SLiM method addNewMutation
#'
#'Documentation for SLiM function \code{addNewMutation}, which is a method of the
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=641}{SLiM manual: page
#'641}.
#'
#'@param mutationType An object of type integer or MutationType object. See
#'details for description.
#'@param selectionCoeff An object of type numeric. See details for description.
#'@param position An object of type integer. See details for description.
#'@param originTick An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'@param originSubpop An object of type null or integer or Subpopulation object.
#'The default value is \code{NULL}. See details for description.
#'@param nucleotide An object of type null or integer or string. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases Genome$addNewMutation .G$addNewMutation
#'@family Genome
#'@return An object of type Mutation object.
#'@details Add new mutations to the target genome(s) with the specified
#'mutationType (specified by the MutationType object or by integer identifier),
#'selectionCoeff, position, originTick (which may be NULL, the default, to specify
#'the current tick; otherwise, beginning in SLiM 3.5, it must be equal to the
#'current tick anyway, as other uses of this property have been deprecated), and
#'originSubpop (specified by the Subpopulation object or by integer identifier,
#'or by NULL, the default, to specify the subpopulation to which the first target
#'genome belongs). If originSubpop is supplied as an integer, it is intentionally
#'not checked for validity; you may use arbitrary values of originSubpop to "tag"
#'the mutations that you create (see section 24.10.1). The addNewDrawnMutation()
#'method may be used instead if you wish selection coefficients to be drawn
#'from the mutation types of the mutations. In non-nucleotide-based models,
#'mutationType will always be a non-nucleotide-based mutation type, and so
#'nucleotide must be NULL (the default). In a nucleotide-based model, mutationType
#'might still be non-nucleotide-based (in which case nucleotide must still be
#'NULL), or mutationType might be nucleotide-based, in which case a non-NULL value
#'must be supplied for nucleotide, specifying the nucleotide(s) to be associated
#'with the new mutation(s). Nucleotides may be specified with string values ("A",
#'"C", "G", or "T"), or with integer values (A=0, C=1, G=2, T=3). If a nucleotide
#'mutation already exists at the mutating position, it is replaced automatically
#'in accordance with the stacking policy for nucleotide- based mutation types. No
#'check is performed that a new mutation's nucleotide differs from the ancestral
#'sequence, or that its selection coefficient is consistent with other mutations
#'that may already exist at the given position with the same nucleotide; model
#'consistency is the responsibility of the model. The new mutations created by
#'this method are returned, even if their actual addition is prevented by the
#'mutation stacking policy (see the mutationStackPolicy property of MutationType,
#'section 24.11.1). However, the order of the mutations in the returned vector
#'is not guaranteed to be the same as the order in which the values are specified
#'in parameter vectors, unless the position parameter is specified in ascending
#'order. In other words, pre- sorting the parameters to this method into ascending
#'order by position, using order() and subsetting, will guarantee that the order
#'of the returned vector of mutations corresponds to the order of elements in
#'the parameters to this method; otherwise, no such guarantee exists. Beginning
#'in SLiM 2.1, this is a class method, not an instance method. This means that
#'it does not get multiplexed out to all of the elements of the receiver (which
#'would add a different new mutation to each element); instead, it is performed as
#'a single operation, adding the same new mutation object to all of the elements
#'of the receiver. Before SLiM 2.1, to add the same mutation to multiple genomes,
#'it was necessary to call addNewMutation() on one of the genomes, and then add
#'the returned Mutation object to all of the other genomes using addMutations().
#'That is not necessary in SLiM 2.1 and later, because of this change (although
#'doing it the old way does no harm and produces identical behavior). Pre-2.1
#'code that actually relied upon the old multiplexing behavior will no longer
#'work correctly (but this is expected to be an extremely rare pattern of usage).
#'Before SLiM 4, this method also took a originGeneration parameter. This was
#'deprecated (the origin generation was then required to be equal to the current
#'generation, for internal consistency), and was removed in SLiM 4. Calling this
#'will normally affect the fitness values calculated at the end of the current
#'tick (but not sooner); if you want current fitness values to be affected, you
#'can call the Species method recalculateFitness() - but see the documentation
#'of that method for caveats. Note that in nonWF models that use tree-sequence
#'recording, mutations cannot be added to an individual after the tick in which
#'the individual is created (i.e., when the age of the individual is greater than
#'0), to prevent the possibility of inconsistencies in the recorded tree sequence.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addNewMutation <- function(mutationType, selectionCoeff, position,
originTick, originSubpop, nucleotide) {
 .G$addNewMutation(mutationType, selectionCoeff, position, originTick,
originSubpop, nucleotide)
}

#'SLiM method containsMarkerMutation
#'
#'Documentation for SLiM function \code{containsMarkerMutation}, which is a method
#'of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=642}{SLiM manual: page
#'642}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'@param position An object of type integer. Must be of length 1 (a singleton).
#'See details for description.
#'@param returnMutation An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Genome$containsMarkerMutation .G$containsMarkerMutation
#'@family Genome
#'@return An object of type null or logical or Mutation object. Return will be of
#'length 1 (a singleton)
#'@details Returns T if the genome contains a mutation of type mutType at
#'position, F otherwise (if returnMutation has its default value of F; see
#'below). This method is, as its name suggests, intended for checking for
#'"marker mutations": mutations of a special mutation type that are not literally
#'mutations in the usual sense, but instead are added in to particular genomes
#'to mark them as possessing some property. Marker mutations are not typically
#'added by SLiM's mutation-generating machinery; instead they are added explicitly
#'with addNewMutation() or addNewDrawnMutation() at a known, constant position
#'in the genome. This method provides a check for whether a marker mutation of a
#'given type exists in a particular genome; because the position to check is known
#'in advance, that check can be done much faster than the equivalent check with
#'containsMutations() or countOfMutationsOfType(), using a binary search of the
#'genome. See section 14.4 for one example of a model that uses marker mutations
#'- in that case, to mark chromosomes that possess an inversion. If returnMutation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=643}{SLiM manual: page
#'643}.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Genome$containsMutations .G$containsMutations
#'@family Genome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=643}{SLiM manual: page
#'643}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$countOfMutationsOfType .G$countOfMutationsOfType
#'@family Genome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .G$countOfMutationsOfType(mutType)
}

#'SLiM method mutationCountsInGenomes
#'
#'Documentation for SLiM function \code{mutationCountsInGenomes}, which is a
#'method of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=643}{SLiM manual: page
#'643}.
#'
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Genome$mutationCountsInGenomes .G$mutationCountsInGenomes
#'@family Genome
#'@return An object of type integer.
#'@details Return an integer vector with the frequency counts of all of the
#'Mutation objects passed in mutations, within the target Genome vector. If the
#'optional mutations argument is NULL (the default), frequency counts will be
#'returned for all of the active Mutation objects in the simulation - the same
#'Mutation objects, and in the same order, as would be returned by the mutations
#'property of sim, in other words. See the +mutationFrequenciesInGenomes() method
#'to obtain float frequencies instead of integer counts. See also the Species
#'methods mutationCounts() and mutationFrequencies(), which may be more efficient
#'for getting counts/frequencies for whole subpopulations or for the whole
#'simulation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationCountsInGenomes <- function(mutations) {
 .G$mutationCountsInGenomes(mutations)
}

#'SLiM method mutationFrequenciesInGenomes
#'
#'Documentation for SLiM function \code{mutationFrequenciesInGenomes}, which is a
#'method of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=643}{SLiM manual: page
#'643}.
#'
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Genome$mutationFrequenciesInGenomes .G$mutationFrequenciesInGenomes
#'@family Genome
#'@return An object of type float.
#'@details Return a float vector with the frequencies of all of the Mutation
#'objects passed in mutations, within the target Genome vector. If the optional
#'mutations argument is NULL (the default), frequencies will be returned for
#'all of the active Mutation objects in the simulation - the same Mutation
#'objects, and in the same order, as would be returned by the mutations property
#'of sim, in other words. See the +mutationCountsInGenomes() method to obtain
#'integer counts instead of float frequencies. See also the Species methods
#'mutationCounts() and mutationFrequencies(), which may be more efficient for
#'getting counts/frequencies for whole subpopulations or for the whole simulation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationFrequenciesInGenomes <- function(mutations) {
 .G$mutationFrequenciesInGenomes(mutations)
}

#'SLiM method mutationsOfType
#'
#'Documentation for SLiM function \code{mutationsOfType}, which is a method of the
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=643}{SLiM manual: page
#'643}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$mutationsOfType .G$mutationsOfType
#'@family Genome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=644}{SLiM manual: page
#'644}.
#'
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param format An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{"string"}. See details for description.
#'
#'@aliases Genome$nucleotides .G$nucleotides
#'@family Genome
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
#'working with sequences, such as nucleotideCounts() to get the counts of A/C/G/T
#'nucleotides in a sequence, nucleotideFrequencies() to get the same information
#'as frequencies, and codonsToAminoAcids() to convert a codon sequence (such as
#'provided by the codon format described above) to an amino acid sequence; see
#'section 24.17.1.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=644}{SLiM manual: page
#'644}.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Genome$output .G$output
#'@family Genome
#'@return An object of type void.
#'@details Output the target genomes in SLiM's native format (see section 26.3.1
#'for output format details). This low-level output method may be used to output
#'any sample of Genome objects (the Eidos function sample() may be useful for
#'constructing custom samples, as may the SLiM class Individual). For output of
#'a sample from a single Subpopulation, the outputSample() of Subpopulation may
#'be more straightforward to use. If the optional parameter filePath is NULL (the
#'default), output is directed to SLiM's standard output. Otherwise, the output
#'is sent to the file specified by filePath, overwriting that file if append if F,
#'or appending to the end of it if append is T. See outputMS() and outputVCF() for
#'other output formats. Output is generally done in a late() event, so that the
#'output reflects the state of the simulation at the end of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=644}{SLiM manual: page
#'644}.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param filterMonomorphic An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'
#'@aliases Genome$outputMS .G$outputMS
#'@family Genome
#'@return An object of type void.
#'@details Output the target genomes in MS format (see section 26.3.2 for output
#'format details). This low-level output method may be used to output any sample
#'of Genome objects (the Eidos function sample() may be useful for constructing
#'custom samples, as may the SLiM class Individual). For output of a sample
#'from a single Subpopulation, the outputMSSample() of Subpopulation may be
#'more straightforward to use. If the optional parameter filePath is NULL (the
#'default), output is directed to SLiM's standard output. Otherwise, the output
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
#'tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=645}{SLiM manual: page
#'645}.
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
#'@family Genome
#'@return An object of type void.
#'@details Output the target genomes in VCF format (see sections 26.2.3, 26.2.4,
#'and 26.3.3 for output format details). The target genomes are treated as pairs
#'comprising individuals for purposes of structuring the VCF output, so an even
#'number of genomes is required. This low-level output method may be used to
#'output any sample of Genome objects (the Eidos function sample() may be useful
#'for constructing custom samples, as may the SLiM class Individual). For output
#'of a sample from a single Subpopulation, the outputVCFSample() of Subpopulation
#'may be more straightforward to use. If the optional parameter filePath is
#'NULL (the default), output is directed to SLiM's standard output. Otherwise,
#'the output is sent to the file specified by filePath, overwriting that file
#'if append if F, or appending to the end of it if append is T. The parameters
#'outputMultiallelics, simplifyNucleotides, and outputNonnucleotides affect
#'the format of the output produced; see sections 26.2.3 and 26.2.4 for further
#'discussion. See outputMS() and output() for other output formats. Output is
#'generally done in a late() event, so that the output reflects the state of the
#'simulation at the end of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=645}{SLiM manual: page
#'645}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$positionsOfMutationsOfType .G$positionsOfMutationsOfType
#'@family Genome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=645}{SLiM manual: page
#'645}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutationType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$readFromMS .G$readFromMS
#'@family Genome
#'@return An object of type Mutation object.
#'@details Read new mutations from the MS format file at filePath and add them
#'to the target genomes. The number of target genomes must match the number
#'of genomes represented in the MS file. To read into all of the genomes in
#'a given subpopulation pN, simply call pN.genomes.readFromMS(), assuming the
#'subpopulation's size matches that of the MS file. A vector containing all of the
#'mutations created by readFromMS() is returned. Each mutation is created at the
#'position specified in the file, using the mutation type given by mutationType.
#'Positions are expected to be in [0,1], and are scaled to the length of the
#'chromosome by multiplying by the last valid base position of the chromosome
#'(i.e., one less than the chromosome length). Selection coefficients are drawn
#'from the mutation type. The population of origin for each mutation is set to
#'-1, and the tick of origin is set to the current tick. In a nucleotide-based
#'model, if mutationType is nucleotide-based, a random nucleotide different from
#'the ancestral nucleotide at the position will be chosen with equal probability.
#'The target genomes correspond, in order, to the call lines in the MS file.
#'In sex-based models that simulate the X or Y chromosome, null genomes in the
#'target vector will be skipped, and will not be used to correspond to any call
#'line; however, care should be taken in this case that the lines in the MS file
#'correspond to the target genomes in the manner desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=645}{SLiM manual: page
#'645}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutationType An object of type null or integer or MutationType object.
#'Must be of length 1 (a singleton). The default value is \code{NULL}. See details
#'for description.
#'
#'@aliases Genome$readFromVCF .G$readFromVCF
#'@family Genome
#'@return An object of type Mutation object.
#'@details Read new mutations from the VCF format file at filePath and add
#'them to the target genomes. The number of target genomes must match the
#'number of genomes represented in the VCF file (i.e., two times the number
#'of samples, if each sample is diploid). To read into all of the genomes in
#'a given subpopulation pN, simply call pN.genomes.readFromVCF(), assuming the
#'subpopulation's size matches that of the VCF file taking ploidy into account.
#'A vector containing all of the mutations created by readFromVCF() is returned.
#'SLiM's VCF parsing is quite primitive. The header is parsed only inasmuch as
#'SLiM looks to see whether SLiM-specific VCF fields (see sections 26.2.3 and
#'26.2.4) are defined or not; the rest of the header information is ignored.
#'Call lines are assumed to follow the format: #CHROM POS ID REF ALT QUAL FILTER
#'INFO FORMAT i0...iN The CHROM, ID, QUAL, FILTER, and FORMAT fields are ignored,
#'and information in the genotype fields beyond the GT genotype subfield are
#'also ignored. SLiM's own VCF annotations (see section 26.2.3) are honored; in
#'particular, mutations will be created using the given values of MID, S, PO, TO,
#'and MT if those subfields are present, and DOM, if it is present, must match
#'the dominance coefficient of the mutation type. The parameter mutationType (a
#'MutationType object or id) will be used for any mutations that have no supplied
#'mutation type id in the MT subfield; if mutationType would be used but is NULL
#'an error will result. Mutation IDs supplied in MID will be used if no mutation
#'IDs have been used in the simulation so far; if any have been used, it is
#'difficult for SLiM to guarantee that there are no conflicts, so a warning will
#'be emitted and the MID values will be ignored. If selection coefficients are
#'not supplied with the S subfield, they will be drawn from the mutation type
#'used for the mutation. If a population of origin is not supplied with the PO
#'subfield, -1 will be used. If a tick of origin is not supplied with the TO
#'subfield (or a generation of origin GO field, which was the SLiM convention
#'before SLiM 4), the current tick will be used. REF and ALT must always be
#'comprised of simple nucleotides (A/C/G/T) rather than values representing
#'indels or other complex states. Beyond this, the handling of the REF and ALT
#'fields depends upon several factors. First of all, these fields are ignored in
#'non-nucleotide-based models, although they are still checked for conformance.
#'In nucleotide-based models, when a header definition for SLiM's NONNUC tag is
#'present (as when nucleotide-based output is generated by SLiM): Second, if a
#'NONNUC field is present in the INFO field the call line is taken to represent
#'a non-nucleotide-based mutation, and REF and ALT are again ignored. In this
#'case the mutation type used must be non-nucleotide- based. Third, if NONNUC is
#'not present the call line is taken to represent a nucleotide-based mutation. In
#'this case, the mutation type used must be nucleotide-based. Also, in this case,
#'the specified reference nucleotide must match the existing ancestral nucleotide
#'at the given position. In nucleotide- based models, when a header definition
#'for SLiM's NONNUC tag is not present (as when loading a non- SLiM-generated
#'VCF file): The mutation type will govern the way nucleotides are handled.
#'If the mutation type used for a mutation is nucleotide-based, the nucleotide
#'provided in the VCF file for that allele will be used. If the mutation type
#'is non-nucleotide-based, the nucleotide provided will be ignored. If multiple
#'alleles using the same nucleotide at the same position are specified in the VCF
#'file, a separate mutation will be created for each, mirroring SLiM's behavior
#'with independent mutational lineages when writing VCF (see section 26.2.4). The
#'MULTIALLELIC flag is ignored by readFromVCF(); call lines for mutations at the
#'same base position in the same genome will result in stacked mutations whether
#'or not MULTIALLELIC is present. The target genomes correspond, in order, to the
#'haploid or diploid calls provided for i0…iN (the sample IDs) in the VCF file. In
#'sex-based models that simulate the X or Y chromosome, null genomes in the target
#'vector will be skipped, and will not be used to correspond to any of i0…iN;
#'however, care should be taken in this case that the genomes in the VCF file
#'correspond to the target genomes in the manner desired.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=646}{SLiM manual: page
#'646}.
#'
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'@param substitute An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'
#'@aliases Genome$removeMutations .G$removeMutations
#'@family Genome
#'@return An object of type void.
#'@details Remove the mutations in mutations from the target genome(s), if they
#'are present (if they are not present, they will be ignored). If NULL is passed
#'for mutations (which is the default), then all mutations will be removed from
#'the target genomes; in this case, substitute must be F (a specific vector
#'of mutations to be substituted is required). Note that the Mutation objects
#'removed remain valid, and will still be in the simulation's mutation registry
#'(i.e., will be returned by the Species property mutations), until the next
#'tick. Removing mutations will normally affect the fitness values calculated
#'at the end of the current tick; if you want current fitness values to be
#'affected, you can call the Species method recalculateFitness() - but see the
#'documentation of that method for caveats. The optional parameter substitute
#'was added in SLiM 2.2, with a default of F for backward compatibility. If
#'substitute is T, Substitution objects will be created for all of the removed
#'mutations so that they are recorded in the simulation as having fixed, just
#'as if they had reached fixation and been removed by SLiM's own internal
#'machinery. This will occur regardless of whether the mutations have in fact
#'fixed, regardless of the convertToSubstitution property of the relevant mutation
#'types, and regardless of whether all copies of the mutations have even been
#'removed from the simulation (making it possible to create Substitution objects
#'for mutations that are still segregating). It is up to the caller to perform
#'whatever checks are necessary to preserve the integrity of the simulation's
#'records. Typically substitute will only be set to T in the context of calls like
#'sim.subpopulations.genomes.removeMutations(muts, T), such that the substituted
#'mutations are guaranteed to be entirely removed from circulation. As mentioned
#'above, substitute may not be T if mutations is NULL.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Genome}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=647}{SLiM manual: page
#'647}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Genome$sumOfMutationsOfType .G$sumOfMutationsOfType
#'@family Genome
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{GenomicElement}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=647}{SLiM manual: page
#'647}.
#'
#'@param genomicElementType An object of type integer or GenomicElementType
#'object. Must be of length 1 (a singleton). See details for description.
#'
#'@aliases GenomicElement$setGenomicElementType .GE$setGenomicElementType
#'@family GenomicElement
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setGenomicElementType <- function(genomicElementType) {
 .GE$setGenomicElementType(genomicElementType)
}



#'SLiM method setMutationFractions
#'
#'Documentation for SLiM function \code{setMutationFractions}, which is a method
#'of the SLiM class \code{\link{GenomicElementType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=648}{SLiM manual: page
#'648}.
#'
#'@param mutationTypes An object of type integer or MutationType object. See
#'details for description.
#'@param proportions An object of type numeric. See details for description.
#'
#'@aliases GenomicElementType$setMutationFractions .GET$setMutationFractions
#'@family GenomicElementType
#'@return An object of type void or void.
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{GenomicElementType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=648}{SLiM manual: page
#'648}.
#'
#'@param mutationMatrix An object of type float. See details for description.
#'
#'@aliases GenomicElementType$setMutationMatrix .GET$setMutationMatrix
#'@family GenomicElementType
#'@return An object of type void or void.
#'@details Sets a new nucleotide mutation matrix for the genomic
#'element type. This replaces the mutation matrix originally set by
#'initializeGenomicElementType(). This method may only be called in
#'nucleotide-based models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setMutationMatrix <- function(mutationMatrix) {
 .GET$setMutationMatrix(mutationMatrix)
}



#'SLiM method containsMutations
#'
#'Documentation for SLiM function \code{containsMutations}, which is a method of
#'the SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=652}{SLiM manual: page
#'652}.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'
#'@aliases Individual$containsMutations .I$containsMutations
#'@family Individual
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=652}{SLiM manual: page
#'652}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$countOfMutationsOfType .I$countOfMutationsOfType
#'@family Individual
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .I$countOfMutationsOfType(mutType)
}

#'SLiM method relatedness
#'
#'Documentation for SLiM function \code{relatedness}, which is a method of the
#'SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=652}{SLiM manual: page
#'652}.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases Individual$relatedness .I$relatedness
#'@family Individual
#'@return An object of type float.
#'@details Returns a vector containing the degrees of relatedness between the
#'receiver and each of the individuals in individuals. The relatedness between A
#'and B is always 1.0 if A and B are actually the same individual; this facility
#'works even if SLiM's optional pedigree tracking is not enabled (in which case
#'all other relatedness values will be 0.0). Otherwise, if pedigree tracking is
#'turned on with initializeSLiMOptions(keepPedigrees=T), this method will use
#'the pedigree information described in section 24.7.1 to construct a relatedness
#'estimate. More specifically, this method uses all available pedigree information
#'from the grandparental and parental pedigree records of A and B to compute
#'an estimate of the degree of consanguinity between A and B. Siblings have a
#'relatedness of 0.5, as do parents to their children and vice versa; cousins have
#'a relatedness of 0.125; and so forth. If, according to the pedigree information
#'available, A and B have no blood relationship, the value returned is 0.0. Note
#'that the value returned by relatedness() is what is called the "coefficient
#'of relationship" between the two individuals (Wright, 1922; https://
#'doi.org/10.1086/279872), and ranges from 0.0 to 1.0. There is another commonly
#'used metric of relatedness, called the "kinship coefficient", that reflects the
#'probability of identity by descent between two individuals A and B. In general,
#'it is approximately equal to one-half of the coefficient of relationship; if
#'an approximate estimate of the kinship coefficient is acceptable, especially in
#'models in which individuals are expected to be outbred, you can simply divide
#'relatedness() by two. However, it should be noted that Wright's coefficient
#'of relationship is not a measure of the probability of identity by descent,
#'and so it is not exactly double the kinship coefficient; they actually
#'measure different things. More precisely, the relationship between them is
#'r = 2φ/sqrt((1+fA)(1+fB)), where r is Wright's coefficient of relatedness,
#'φ is the kinship coefficient, and fA and fB are the inbreeding coefficients
#'of A and B respectively. Note that this relatedness is simply pedigree-based
#'relatedness, and does not necessarily correspond to genetic relatedness, because
#'of the effects of factors like assortment and recombination. If a metric of
#'actual genetic relatedness is desired, tree-sequence recording can be used
#'after simulation is complete, to compute the exact genetic relatedness between
#'individuals based upon the complete ancestry tree (a topic which is beyond the
#'scope of this manual). Actual genetic relatedness cannot presently be calculated
#'during a simulation run; the information is implicitly contained in the recorded
#'tree-sequence tables, but calculating it is too computationally expensive to be
#'reasonable. This method makes a couple of assumptions. One assumption is that
#'the grandparents (or the parents, if grandparental information is not available)
#'are themselves unrelated and that they are not inbred; this assumption is
#'necessary because we have no information about their parentage, since SLiM's
#'pedigree tracking information only goes back two generations. Be aware that
#'in a model where inbreeding or selfing occurs at all (including "incidental
#'selfing", where a hermaphroditic individual happens to choose itself as a mate),
#'some level of "background relatedness" will be present and this assumption
#'will be violated. In such circumstances, relatedness() will therefore tend to
#'underestimate the degree of relatedness between individuals, and the greater
#'the degree of inbreeding, the greater the underestimation will be. If inbreeding
#'is allowed in a model - and particularly if it is common - the results
#'of relatedness() should therefore not be taken as an estimate of absolute
#'relatedness, but can still be useful as an estimate of relative relatedness
#'(indicating that, say, A appears from the information available to be more
#'closely related to B than it is to C). A second assumption is that, in nonWF
#'models, addRecombinant() is not being used, since the pedigree relationships
#'involved are then too complex to trace. Indeed, addRecombinant() does not
#'record pedigree information at all, for this reason, and so the relatedness of
#'individuals produced by addRecombinant() will be 0.0.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=653}{SLiM manual: page
#'653}.
#'
#'@param position An object of type float. See details for description.
#'
#'@aliases Individual$setSpatialPosition .I$setSpatialPosition
#'@family Individual
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
#'value is supplied in position) since it is not encompassed by the simulation's
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSpatialPosition <- function(position) {
 .I$setSpatialPosition(position)
}

#'SLiM method sumOfMutationsOfType
#'
#'Documentation for SLiM function \code{sumOfMutationsOfType}, which is a method
#'of the SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=653}{SLiM manual: page
#'653}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$sumOfMutationsOfType .I$sumOfMutationsOfType
#'@family Individual
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Individual}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=654}{SLiM manual: page
#'654}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Individual$uniqueMutationsOfType .I$uniqueMutationsOfType
#'@family Individual
#'@return An object of type Mutation object.
#'@details Returns an object vector of all the mutations that are of the type
#'specified by mutType, out of all of the mutations in the individual. Mutations
#'present in both genomes will occur only once in the result of this method,
#'and the mutations will be given in sorted order by position, so this method
#'is similar to sortBy(unique(individual.genomes.mutationsOfType(mutType)),
#'"position"). It is not identical to that call, only because if multiple
#'mutations exist at the exact same position, they may be sorted differently
#'by this method than they would be by sortBy(). If you just need a count
#'of the matching Mutation objects, rather than a vector of the matches, use
#'-countOfMutationsOfType(). This method is provided for speed; it is much
#'faster than the corresponding Eidos code. Indeed, it is faster than just
#'individual.genomes.mutationsOfType(mutType), and gives uniquing and sorting
#'on top of that, so it is advantageous unless duplicate entries for homozygous
#'mutations are actually needed.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
uniqueMutationsOfType <- function(mutType) {
 .I$uniqueMutationsOfType(mutType)
}



#'SLiM method clippedIntegral
#'
#'Documentation for SLiM function \code{clippedIntegral}, which is a method of the
#'SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=658}{SLiM manual: page
#'658}.
#'
#'@param receivers An object of type null or Individual object. See details for
#'description.
#'
#'@aliases InteractionType$clippedIntegral .IT$clippedIntegral
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector containing the integral of the interaction function as
#'experienced by each of the individuals in receivers. For each given individual,
#'the interaction function is clipped to the edges of the spatial bounds of the
#'subpopulation that individual inhabits; the individual's spatial position must
#'be within bounds or an error is raised. A periodic boundary will, correctly,
#'not clip the interaction function. The interaction function is also clipped to
#'the interaction's maximum distance; that distance must be less than half of the
#'extent of the spatial bounds in each dimension (so that, for a given dimension,
#'the interaction function is clipped by the spatial bounds on only one side),
#'otherwise an error is raised. Note that for sex-specific interaction types, the
#'sex of the receiver does not matter; an individual might not actually receive
#'any interactions because of its sex, but it is still considered to have the
#'same interaction function integral. If receivers is NULL, the maximal integral
#'is returned, as would be experienced by an individual farther than the maximum
#'distance from any edge. The evaluate() method must have been previously called
#'for the receiver subpopulation, and positions saved at evaluation time will be
#'used. If the InteractionType is non-spatial, this method may not be called. The
#'computed value of the integral is not exact; it is calculated by an approximate
#'numerical method designed to be fast, but the error should be fairly small
#'(typically less than 1% from the true value). A large amount of computation will
#'occur the first time this method is called (perhaps taking more than a second,
#'depending upon hardware), but subsequent calls should be very fast. This method
#'does not invoke interaction() callbacks; the calculated integrals are only for
#'the interaction function itself, and so will not be accurate if interaction()
#'callbacks modify the relationship between distance and interaction strength. For
#'this reason, the overhead of the first call will not reoccur when individuals
#'move or when the interaction is re-evaluated; for typical models, the initial
#'overhead will be incurred only once. The initial overhead will reoccur, however,
#'if the interaction function itself, or the maximum interaction distance, are
#'changed; frequent change of those parameters may render the performance of
#'this method unacceptable. The integral values returned by clippedIntegral() can
#'be useful for computing interaction metrics that are scaled by the amount of
#'"interaction field" (to coin a term) that is present for a given individual,
#'producing metrics of interaction density. Notably, the localPopulationDensity()
#'method automatically incorporates the mechanics of clippedIntegral() into
#'the calculations it performs; see that method's documentation for further
#'discussion of this concept. This approach can also be useful with the
#'interactingNeighborCount() method, provided that the interaction function is of
#'type "f" (since the neighbor count does not depend upon interaction strength).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
clippedIntegral <- function(receivers) {
 .IT$clippedIntegral(receivers)
}

#'SLiM method distance
#'
#'Documentation for SLiM function \code{distance}, which is a method of the SLiM
#'class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=659}{SLiM manual: page
#'659}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param exerters An object of type null or Individual object. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$distance .IT$distance
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector containing distances between receiver and the
#'individuals in exerters. If exerters is NULL (the default), then a vector of
#'the distances from receiver to all individuals in its subpopulation (including
#'itself) is returned; this case may be handled differently internally, for
#'greater speed, so supplying NULL is preferable to supplying the vector of all
#'individuals in the subpopulation explicitly. Otherwise, all individuals in
#'exerters must belong to a single subpopulation (but not necessarily the same
#'subpopulation as receiver). The evaluate() method must have been previously
#'called for the receiver and exerter subpopulations, and positions saved at
#'evaluation time will be used. If the InteractionType is non-spatial, this
#'method may not be called. Importantly, distances are calculated according to the
#'spatiality of the InteractionType (as declared in initializeInteractionType()),
#'not the dimensionality of the model as a whole (as declared in
#'initializeSLiMOptions()). The distances returned are therefore the distances
#'that would be used to calculate interaction strengths. However, distance() will
#'return finite distances for all pairs of individuals, even if the individuals
#'are non-interacting; the distance() between an individual and itself will thus
#'be 0. See interactionDistance() for an alternative distance definition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
distance <- function(receiver, exerters) {
 .IT$distance(receiver, exerters)
}

#'SLiM method distanceFromPoint
#'
#'Documentation for SLiM function \code{distanceFromPoint}, which is a method of
#'the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=659}{SLiM manual: page
#'659}.
#'
#'@param point An object of type float. See details for description.
#'@param exerters An object of type Individual object. See details for
#'description.
#'
#'@aliases InteractionType$distanceFromPoint .IT$distanceFromPoint
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector containing distances between the point given by
#'the spatial coordinates in point, which may be thought of as the "receiver",
#'and individuals in exerters. The point vector is interpreted as providing
#'coordinates precisely as specified by the spatiality of the interaction type; if
#'the interaction type's spatiality is "xz", for example, then point[0] is assumed
#'to be an x value, and point[1] is assumed to be a z value. Be careful; this
#'means that in general it is not safe to pass an individual's spatialPosition
#'property for point, for example (although it is safe if the spatiality of the
#'interaction matches the dimensionality of the simulation). A coordinate for a
#'periodic spatial dimension must be within the spatial bounds for that dimension,
#'since coordinates outside of periodic bounds are meaningless (pointPeriodic()
#'may be used to ensure this); coordinates for non-periodic spatial dimensions
#'are not restricted. All individuals in exerters must belong to a single
#'subpopulation; the evaluate() method must have been previously called for that
#'subpopulation, and positions saved at evaluation time will be used. If the
#'InteractionType is non-spatial, this method may not be called. The vector point
#'must be exactly as long as the spatiality of the InteractionType. Importantly,
#'distances are calculated according to the spatiality of the InteractionType (as
#'declared in initializeInteractionType()) not the dimensionality of the model as
#'a whole (as declared in initializeSLiMOptions()). The distances are therefore
#'interaction distances: the distances that are used to calculate interaction
#'strengths. This method replaces the distanceToPoint() method that existed prior
#'to SLiM 4.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
distanceFromPoint <- function(point, exerters) {
 .IT$distanceFromPoint(point, exerters)
}

#'SLiM method drawByStrength
#'
#'Documentation for SLiM function \code{drawByStrength}, which is a method of the
#'SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=660}{SLiM manual: page
#'660}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$drawByStrength .IT$drawByStrength
#'@family InteractionType
#'@return An object of type Individual object.
#'@details Returns up to count individuals drawn from exerterSubpop, or if that
#'is NULL (the default), then from the subpopulation of receiver. The probability
#'of drawing particular individuals is proportional to the strength of interaction
#'they exert upon receiver. All exerters must belong to a single subpopulation
#'(but not necessarily the same subpopulation as receiver). The evaluate() method
#'must have been previously called for the receiver and exerter subpopulations,
#'and positions saved at evaluation time will be used. This method may be used
#'with either spatial or non-spatial interactions, but will be more efficient
#'with spatial interactions that set a short maximum interaction distance. Draws
#'are done with replacement, so the same individual may be drawn more than once;
#'sometimes using unique() on the result of this call is therefore desirable. If
#'more than one draw will be needed, it is much more efficient to use a single
#'call to drawByStrength(), rather than drawing individuals one at a time. Note
#'that if no individuals exert a non-zero interaction strength upon receiver,
#'the vector returned will be zero- length; it is important to consider this
#'possibility.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawByStrength <- function(receiver, count, exerterSubpop) {
 .IT$drawByStrength(receiver, count, exerterSubpop)
}

#'SLiM method evaluate
#'
#'Documentation for SLiM function \code{evaluate}, which is a method of the SLiM
#'class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=660}{SLiM manual: page
#'660}.
#'
#'@param subpops An object of type integer or Subpopulation object. See details
#'for description.
#'
#'@aliases InteractionType$evaluate .IT$evaluate
#'@family InteractionType
#'@return An object of type void.
#'@details Snapshots model state in preparation for the use of the interaction,
#'for the receiver and exerter subpopulations specified by subpops. The
#'subpopulations may be supplied either as integer IDs, or as Subpopulation
#'objects. This method will discard all previously cached data for the
#'subpopulation(s), and will cache the current spatial positions of all
#'individuals they contain (so that the spatial positions of those individuals
#'may then change without disturbing the state of the interaction at the moment
#'of evaluation). Particular interaction distances and strengths are not computed
#'by evaluate(), and interaction() callbacks will not be called in response to
#'this method; that work is deferred until required to satisfy a query (at which
#'point the tick and cycle counters may have advanced, so be careful with the
#'tick ranges used in defining interaction() callbacks). You must explicitly call
#'evaluate() at an appropriate time in the tick cycle before the interaction is
#'used, but after any relevant changes have been made to the population. SLiM
#'will invalidate any existing interactions after any portion of the tick cycle
#'in which new individuals have been born or existing individuals have died. In a
#'WF model, this occurs just before late() events execute (see the WF tick cycle
#'diagram in chapter 22), so late() events are often the appropriate place to put
#'evaluate() calls, but first() or early() events can work too if the interaction
#'is not needed until that point in the tick cycle anyway. In nonWF models, on
#'the other hand, new offspring are produced just before early() events and then
#'individuals die just before late() events (see the nonWF tick cycle diagram in
#'chapter 23), so interactions will be invalidated twice during each tick cycle.
#'This means that in a nonWF model, an interaction that influences reproduction
#'should usually be evaluated in a first() event, while an interaction that
#'influences fitness or mortality should usually be evaluated in an early() event
#'(and an interaction that affects both may need to be evaluated at both times).
#'If an interaction is never evaluated for a given subpopulation, it is guaranteed
#'that there will be essentially no memory or computational overhead associated
#'with the interaction for that subpopulation. Furthermore, attempting to query
#'an interaction for a receiver or exerter in a subpopulation that has not been
#'evaluated is guaranteed to raise an error.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
evaluate <- function(subpops) {
 .IT$evaluate(subpops)
}

#'SLiM method interactingNeighborCount
#'
#'Documentation for SLiM function \code{interactingNeighborCount}, which is a
#'method of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=661}{SLiM manual: page
#'661}.
#'
#'@param receivers An object of type Individual object. See details for
#'description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$interactingNeighborCount .IT$interactingNeighborCount
#'@family InteractionType
#'@return An object of type integer.
#'@details Returns the number of interacting individuals for each individual in
#'receivers, within the maximum interaction distance according to the distance
#'metric of the InteractionType, from among the exerters in exerterSubpop (or, if
#'that is NULL, then from among all individuals in the receiver's subpopulation).
#'More specifically, this method counts the number of individuals which can exert
#'an interaction upon each receiver. All of the receivers must belong to a single
#'subpopulation, and all of the exerters must belong to a single subpopulation,
#'but those two subpopulations do not need to be the same. The evaluate() method
#'must have been previously called for the receiver and exerter subpopulations,
#'and positions saved at evaluation time will be used. This method is similar to
#'nearestInteractingNeighbors() (when passed a large count so as to guarantee that
#'all interacting individuals are returned), but this method returns only a count
#'of the interacting individuals, not a vector containing the individuals. This
#'method may also be called in a vectorized fashion, with a non-singleton vector
#'of individuals, unlike nearestInteractingNeighbors(). Note that this method uses
#'interaction eligibility as a criterion; it will not count neighbors that cannot
#'exert an interaction upon a receiver (due to sex-segregation, e.g.). (It also
#'does not count a receiver as a neighbor of itself.) If a count of all neighbors
#'is desired, rather than just interacting neighbors, use neighborCount(). If the
#'InteractionType is non-spatial, this method may not be called.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
interactingNeighborCount <- function(receivers, exerterSubpop) {
 .IT$interactingNeighborCount(receivers, exerterSubpop)
}

#'SLiM method interactionDistance
#'
#'Documentation for SLiM function \code{interactionDistance}, which is a method of
#'the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=661}{SLiM manual: page
#'661}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param exerters An object of type null or Individual object. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$interactionDistance .IT$interactionDistance
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector containing interaction-dependent distances between
#'receiver and individuals in exerters that exert an interaction strength
#'upon receiver. If exerters is NULL (the default), then a vector of the
#'interaction-dependent distances from receiver to all individuals in its
#'subpopulation (including receiver itself) is returned; this case may be handled
#'much more efficiently than if a vector of all individuals in the subpopulation
#'is explicitly provided. Otherwise, all individuals in exerters must belong to a
#'single subpopulation (but not necessarily the same subpopulation as receiver).
#'The evaluate() method must have been previously called for the receiver and
#'exerter subpopulations, and positions saved at evaluation time will be used. If
#'the InteractionType is non- spatial, this method may not be called. Importantly,
#'distances are calculated according to the spatiality of the InteractionType (as
#'declared in initializeInteractionType()), not the dimensionality of the model
#'as a whole (as declared in initializeSLiMOptions()). The distances returned are
#'therefore the distances that would be used to calculate interaction strengths.
#'In addition, interactionDistance() will return INF as the distance between
#'receiver and any individual which does not exert an interaction upon receiver;
#'the interactionDistance() between an individual and itself will thus be INF,
#'and likewise for pairs excluded from interacting by the sex segregation or max
#'distance of the interaction type. See distance() for an alternative distance
#'definition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
interactionDistance <- function(receiver, exerters) {
 .IT$interactionDistance(receiver, exerters)
}

#'SLiM method localPopulationDensity
#'
#'Documentation for SLiM function \code{localPopulationDensity}, which is a method
#'of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=661}{SLiM manual: page
#'661}.
#'
#'@param receivers An object of type Individual object. See details for
#'description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$localPopulationDensity .IT$localPopulationDensity
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector of the local population density present at the
#'location of each individual in receivers, which does not need to be a singleton;
#'indeed, it can be a vector of all of the individuals in a given subpopulation.
#'However, all receivers must be in the same subpopulation. The local population
#'density is computed from exerters in exerterSubpop, or if that is NULL (the
#'default), then from the receiver's subpopulation. The evaluate() method must
#'have been previously called for the receiver and exerter subpopulations, and
#'positions saved at evaluation time will be used. Population density is estimated
#'using interaction strengths, effectively doing a kernel density estimate using
#'the interaction function as the kernel. What is returned is computed as the
#'total interaction strength present at a given point, divided by the integral
#'of the interaction function around that point after clipping by the spatial
#'bounds of the exerter subpopulation (what one might think of as the amount
#'of "interaction field" around the point). This provides an estimate of local
#'population density, in units of individuals per unit area, as a weighted
#'average over the area covered by the interaction function, where the weight of
#'each exerter in the average is the value of the interaction function at that
#'exerter's position. This can also be thought of as a measure of the amount of
#'interaction happening per unit of interaction field in the space surrounding
#'the point. To calculate the clipped integral of the interaction function,
#'this method uses the same numerical estimator used by the clippedIntegral()
#'method of InteractionType, and all of the caveats described for that method
#'apply here also; notably, all individuals must be within spatial bounds,
#'the maximum interaction distance must be less than half the spatial extent
#'of the subpopulation, and interaction() callbacks are not used (and so,
#'for this method, are not allowed to be active). See the documentation for
#'clippedIntegral() for further discussion of the details of these calculations.
#'To calculate the total interaction strength around the position of a receiver,
#'this method uses the same machinery as the totalOfNeighborStrengths() method
#'of InteractionType, except that - in contrast to other InteractionType methods
#'- the interaction strength exerted by the receiver itself is included in the
#'total (if the exerter subpopulation is the receiver's own subpopulation). This
#'is because population density at the location of an individual includes the
#'individual itself. If this is not desirable, the totalOfNeighborStrengths()
#'method should probably be used. To see the point of this method, consider a
#'receiver located near the edge of the spatial bounds of its subpopulation.
#'Some portion of the interaction function that surrounds that receiver falls
#'outside the spatial bounds of its subpopulation, and will therefore never
#'contain an interacting exerter. If, for example, interaction strengths are used
#'as a measure of competition, this receiver will therefore have an advantage,
#'because it will never feel any competition from the portion of its range that
#'falls outside spatial bounds. However, that portion of its range is presumably
#'also not available to the receiver itself, for foraging or hunting, in which
#'case this advantage is not biologically realistic, but is instead just an
#'undesirable "edge effect" artifact. Dividing by the integral of the interaction
#'function, clipped to the spatial bounds, provides a way to compensate for this
#'edge effect. A nice side effect of using local population densities instead
#'of total interaction strengths is that the maximum interaction strength passed
#'to setInteractionFunction() no longer matters; it cancels out when the total
#'interaction strength is divided by the receiver's clipped integral. However, the
#'shape of the interaction function does still matter; it determines the relative
#'weights used for exerters at different distances from the position of the
#'receiver.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
localPopulationDensity <- function(receivers, exerterSubpop) {
 .IT$localPopulationDensity(receivers, exerterSubpop)
}

#'SLiM method nearestInteractingNeighbors
#'
#'Documentation for SLiM function \code{nearestInteractingNeighbors}, which is a
#'method of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=662}{SLiM manual: page
#'662}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases
#'InteractionType$nearestInteractingNeighbors .IT$nearestInteractingNeighbors
#'@family InteractionType
#'@return An object of type Individual object.
#'@details Returns up to count interacting individuals that are spatially closest
#'to receiver, according to the distance metric of the InteractionType, from
#'among the exerters in exerterSubpop (or, if that is NULL, then from among all
#'individuals in the receiver's subpopulation). More specifically, this method
#'returns only individuals which can exert an interaction upon the receiver.
#'To obtain all of the interacting individuals within the maximum interaction
#'distance of individual, simply pass a value for count that is greater than or
#'equal to the size of the exerter subpopulation. Note that if fewer than count
#'interacting individuals are within the maximum interaction distance, the vector
#'returned may be shorter than count, or even zero-length; it is important to
#'check for this possibility even when requesting a single neighbor. If only the
#'number of interacting individuals is needed, use interactingNeighborCount()
#'instead. The evaluate() method must have been previously called for the receiver
#'and exerter subpopulations, and positions saved at evaluation time will be
#'used. If the InteractionType is non-spatial, this method may not be called.
#'Note that this method uses interaction eligibility as a criterion; it will not
#'return neighbors that cannot exert an interaction upon the receiver (due to
#'sex-segregation, e.g.). (It will also never return the receiver as a neighbor of
#'itself.) To find all neighbors of the receiver, whether they can interact with
#'it or not, use nearestNeighbors().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestInteractingNeighbors <- function(receiver, count, exerterSubpop) {
 .IT$nearestInteractingNeighbors(receiver, count, exerterSubpop)
}

#'SLiM method nearestNeighbors
#'
#'Documentation for SLiM function \code{nearestNeighbors}, which is a method of
#'the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=663}{SLiM manual: page
#'663}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$nearestNeighbors .IT$nearestNeighbors
#'@family InteractionType
#'@return An object of type Individual object.
#'@details Returns up to count individuals that are spatially closest to
#'individual, according to the distance metric of the InteractionType, from
#'among the exerters in exerterSubpop (or, if that is NULL, then from among all
#'individuals in the receiver's subpopulation). To obtain all of the individuals
#'within the maximum interaction distance of individual, simply pass a value for
#'count that is greater than or equal to the size of individual's subpopulation.
#'Note that if fewer than count individuals are within the maximum interaction
#'distance, the vector returned may be shorter than count, or even zero- length;
#'it is important to check for this possibility even when requesting a single
#'neighbor. The evaluate() method must have been previously called for the
#'receiver and exerter subpopulations, and positions saved at evaluation time will
#'be used. If the InteractionType is non-spatial, this method may not be called.
#'Note that this method does not use interaction eligibility as a criterion;
#'it will return neighbors that could not interact with the receiver due to
#'sex-segregation. (It will never return the receiver as a neighbor of itself,
#'however.) To find only neighbors that are eligible to exert an interaction upon
#'the receiver, use nearestInteractingNeighbors().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestNeighbors <- function(receiver, count, exerterSubpop) {
 .IT$nearestNeighbors(receiver, count, exerterSubpop)
}

#'SLiM method nearestNeighborsOfPoint
#'
#'Documentation for SLiM function \code{nearestNeighborsOfPoint}, which is a
#'method of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=663}{SLiM manual: page
#'663}.
#'
#'@param point An object of type float. See details for description.
#'@param exerterSubpop An object of type integer or Subpopulation object. Must be
#'of length 1 (a singleton). See details for description.
#'@param count An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases InteractionType$nearestNeighborsOfPoint .IT$nearestNeighborsOfPoint
#'@family InteractionType
#'@return An object of type Individual object.
#'@details Returns up to count individuals in exerterSubpop that are spatially
#'closest to point, according to the distance metric of the InteractionType. The
#'subpopulation may be supplied either as an integer ID, or as a Subpopulation
#'object. To obtain all of the individuals within the maximum interaction distance
#'of point, simply pass a value for count that is greater than or equal to the
#'size of exerterSubpop. Note that if fewer than count individuals are within the
#'maximum interaction distance, the vector returned may be shorter than count,
#'or even zero-length; it is important to check for this possibility even when
#'requesting a single neighbor. The evaluate() method must have been previously
#'called for exerterSubpop, and positions saved at evaluation time will be used.
#'If the InteractionType is non-spatial, this method may not be called.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
nearestNeighborsOfPoint <- function(point, exerterSubpop, count) {
 .IT$nearestNeighborsOfPoint(point, exerterSubpop, count)
}

#'SLiM method neighborCount
#'
#'Documentation for SLiM function \code{neighborCount}, which is a method of the
#'SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=663}{SLiM manual: page
#'663}.
#'
#'@param receivers An object of type Individual object. See details for
#'description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$neighborCount .IT$neighborCount
#'@family InteractionType
#'@return An object of type integer.
#'@details Returns the number of neighbors for each individual in receivers,
#'within the maximum interaction distance according to the distance metric of the
#'InteractionType, from among the individuals in exerterSubpop (or, if that is
#'NULL, then from among all individuals in the receiver's subpopulation). All of
#'the receivers must belong to a single subpopulation, and all of the exerters
#'must belong to a single subpopulation, but those two subpopulations do not need
#'to be the same. The evaluate() method must have been previously called for the
#'receiver and exerter subpopulations, and positions saved at evaluation time will
#'be used. This method is similar to nearestNeighbors() (when passed a large count
#'so as to guarantee that all neighbors are returned), but this method returns
#'only a count of the individuals, not a vector containing the individuals. This
#'method may also be called in a vectorized fashion, with a non- singleton vector
#'of individuals, unlike nearestNeighbors(). Note that this method does not use
#'interaction eligibility as a criterion; it will count neighbors that cannot
#'exert an interaction upon a receiver (due to sex-segregation, e.g.). (It still
#'does not count a receiver as a neighbor of itself, however.) If a count of
#'only interacting neighbors is desired, use interactingNeighborCount(). If the
#'InteractionType is non-spatial, this method may not be called.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
neighborCount <- function(receivers, exerterSubpop) {
 .IT$neighborCount(receivers, exerterSubpop)
}

#'SLiM method neighborCountOfPoint
#'
#'Documentation for SLiM function \code{neighborCountOfPoint}, which is a method
#'of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=663}{SLiM manual: page
#'663}.
#'
#'@param point An object of type float. See details for description.
#'@param exerterSubpop An object of type integer or Subpopulation object. Must be
#'of length 1 (a singleton). See details for description.
#'
#'@aliases InteractionType$neighborCountOfPoint .IT$neighborCountOfPoint
#'@family InteractionType
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Returns the number of individuals in exerterSubpop that are within
#'the maximum interaction distance according to the distance metric of the
#'InteractionType. The subpopulation may be supplied either as an integer ID,
#'or as a Subpopulation object. The evaluate() method must have been previously
#'called for exerterSubpop, and positions saved at evaluation time will be used.
#'If the InteractionType is non-spatial, this method may not be called. This
#'method is similar to nearestNeighborsOfPoint() (when passed a large count so as
#'to guarantee that all neighbors are returned), but this method returns only a
#'count of the individuals, not a vector containing the individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
neighborCountOfPoint <- function(point, exerterSubpop) {
 .IT$neighborCountOfPoint(point, exerterSubpop)
}

#'SLiM method setInteractionFunction
#'
#'Documentation for SLiM function \code{setInteractionFunction}, which is a method
#'of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=664}{SLiM manual: page
#'664}.
#'
#'@param functionType An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases InteractionType$setInteractionFunction .IT$setInteractionFunction
#'@family InteractionType
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
#'section 24.8 above for discussions of these interaction functions. Non-spatial
#'interactions must use function type "f", since no distance values are available
#'in that case. The interaction function for an interaction type is normally a
#'constant in simulations; in any case, it cannot be changed when an interaction
#'has already been evaluated, so either it should be set prior to evaluation, or
#'unevaluate() should be called first.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setInteractionFunction <- function(functionType, ...) {
 .IT$setInteractionFunction(functionType, ...)
}

#'SLiM method strength
#'
#'Documentation for SLiM function \code{strength}, which is a method of the SLiM
#'class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=664}{SLiM manual: page
#'664}.
#'
#'@param receiver An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param exerters An object of type null or Individual object. The default value
#'is \code{NULL}. See details for description.
#'
#'@aliases InteractionType$strength .IT$strength
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector containing the interaction strengths exerted upon
#'receiver by the individuals in exerters. If exerters is NULL (the default),
#'then a vector of the interaction strengths exerted by all individuals in the
#'subpopulation of receiver (including receiver itself) is returned; this case
#'may be handled much more efficiently than if a vector of all individuals
#'in the subpopulation is explicitly provided. Otherwise, all individuals in
#'exerters must belong to a single subpopulation (but not necessarily the same
#'subpopulation as receiver). The evaluate() method must have been previously
#'called for the receiver and exerter subpopulations, and positions saved at
#'evaluation time will be used. If the strengths of interactions exerted by a
#'single individual upon multiple individuals are needed instead (the inverse of
#'what this method provides), multiple calls to this method will be necessary,
#'one per pairwise interaction queried; the interaction engine is not optimized
#'for the inverse case, and so it will likely be quite slow to compute. If the
#'interaction is reciprocal and sex-symmetric, the opposite query should provide
#'identical results in a single efficient call (because then the interactions
#'exerted are equal to the interactions received); otherwise, the best approach
#'might be to define a second interaction type representing the inverse
#'interaction that you wish to be able to query efficiently.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=664}{SLiM manual: page
#'664}.
#'
#'@param receivers An object of type Individual object. See details for
#'description.
#'@param exerterSubpop An object of type null or Subpopulation object. Must be
#'of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'
#'@aliases InteractionType$totalOfNeighborStrengths .IT$totalOfNeighborStrengths
#'@family InteractionType
#'@return An object of type float.
#'@details Returns a vector of the total interaction strength felt by each
#'individual in receivers by the exerters in exerterSubpop (or, if that is
#'NULL, then by all individuals in the receiver's subpopulation). The receivers
#'parameter does not need to be a singleton; indeed, it can be a vector of
#'all of the individuals in a given subpopulation. All of the receivers must
#'belong to a single subpopulation, and all of the exerters must belong to
#'a single subpopulation, but those two subpopulations do not need to be
#'the same. The evaluate() method must have been previously called for the
#'receiver and exerter subpopulations, and positions saved at evaluation
#'time will be used. If the InteractionType is non- spatial, this method may
#'not be called. For one individual, this is essentially the same as calling
#'nearestInteractingNeighbors() with a large count so as to obtain the complete
#'vector of all interacting neighbors, calling strength() for each of those
#'interactions to get each interaction strength, and adding those interaction
#'strengths together with sum(). This method is much faster than that
#'implementation, however, since all of that work is done as a single operation.
#'Also, totalOfNeighborStrengths() can total up interactions for more than one
#'receiver in a single call. Similarly, for one individual this is essentially the
#'same as calling strength() to get the interaction strengths between a receiver
#'and all individuals in the exerter subpopulation, and then calling sum().
#'Again, this method should be much faster, since this algorithm looks only at
#'neighbors, whereas calling strength() directly assesses interaction strengths
#'with all other individuals. This will make a particularly large difference when
#'the subpopulation size is large and the maximum distance of the InteractionType
#'is small. See localPopulationDensity() for a related method that calculates the
#'total interaction strength divided by the amount of "interaction field" present
#'for an individual (i.e., the integral of the interaction function clipped to the
#'spatial bounds of the subpopulation) to provide an estimate of the "interaction
#'density" felt by an individual.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
totalOfNeighborStrengths <- function(receivers, exerterSubpop) {
 .IT$totalOfNeighborStrengths(receivers, exerterSubpop)
}

#'SLiM method unevaluate
#'
#'Documentation for SLiM function \code{unevaluate}, which is a method of the SLiM
#'class \code{\link{InteractionType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=665}{SLiM manual: page
#'665}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases InteractionType$unevaluate .IT$unevaluate
#'@family InteractionType
#'@return An object of type void.
#'@details Discards all evaluation of this interaction, for all subpopulations.
#'The state of the InteractionType is reset to a state prior to evaluation. This
#'can be useful if the model state has changed in such a way that the evaluation
#'already conducted is no longer valid. For example, if the maximum distance
#'or the interaction function of the InteractionType need to be changed with
#'immediate effect, or if the data used by an interaction() callback has changed
#'in such a way that previously calculated interaction strengths are no longer
#'correct, unevaluate() allows the interaction to begin again from scratch. In WF
#'models, all interactions are automatically reset to an unevaluated state at the
#'moment when the new offspring generation becomes the parental generation (at
#'step 4 in the tick cycle; see section 22.4). In nonWF models, all interactions
#'are automatically reset to an unevaluated state twice per tick: immediately
#'after reproduction() callbacks have completed (after step 1 in the tick cycle;
#'see section 23.1), and immediately before viability/survival selection (before
#'step 4 in the tick cycle; see section 23.4). Given this automatic invalidation,
#'most simulations have no reason to call unevaluate().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
unevaluate <- function(void) {
 .IT$unevaluate(void)
}



#'SLiM method addCustomColumn
#'
#'Documentation for SLiM function \code{addCustomColumn}, which is a method of the
#'SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=666}{SLiM manual: page
#'666}.
#'
#'@param columnName An object of type string or string or any. Must be of length 1
#'(a singleton). See details for description.
#'@param source An object of type string or string or any. Must be of length 1 (a
#'singleton). See details for description.
#'@param context An object of type string or string or any. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases LogFile$addCustomColumn .LF$addCustomColumn
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column with its name provided by columnName. The value
#'for the column, when a given row is generated, will be produced by the code
#'supplied in source, which is expected to return either NULL (which will write
#'out NA), or a singleton value of any non-object type. The context parameter will
#'be set up as a pseudo-parameter, named context, when source is called, allowing
#'the same source code to be used to generate values for multiple data columns;
#'you might, for example, provide the particular Subpopulation object here that
#'you wish source to use for its calculations. This is optional; if the default
#'value of NULL is used, then context will be NULL when source is called. See
#'addMeanSDColumns() for a useful variant.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addCustomColumn <- function(columnName, source, context) {
 .LF$addCustomColumn(columnName, source, context)
}

#'SLiM method addCycle
#'
#'Documentation for SLiM function \code{addCycle}, which is a method of the SLiM
#'class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param species An object of type null or Species object. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases LogFile$addCycle .LF$addCycle
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the cycle counter for species
#'(the same as the value of the cycle property of that species). In single-species
#'models, species may be NULL to indicate that single species. The column will
#'simply be named cycle in single-species models; an underscore and the name of
#'the species will be appended in multispecies models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addCycle <- function(species) {
 .LF$addCycle(species)
}

#'SLiM method addCycleStage
#'
#'Documentation for SLiM function \code{addCycleStage}, which is a method of the
#'SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$addCycleStage .LF$addCycleStage
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the cycle stage, named
#'cycle_stage. The stage is provided as a string, and will typically be "first",
#'"early", "late", or "end" (the latter used for the point in time at which
#'end-of-tick automatic logging occurs). Other possible values are discussed in
#'the documentation for the cycleStage property of Community, which this column
#'reflects.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addCycleStage <- function(void) {
 .LF$addCycleStage(void)
}

#'SLiM method addKeysAndValuesFrom
#'
#'Documentation for SLiM function \code{addKeysAndValuesFrom}, which is a method
#'of the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param source An object of type . Must be of length 1 (a singleton). See details
#'for description.
#'
#'@aliases LogFile$addKeysAndValuesFrom .LF$addKeysAndValuesFrom
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details This Dictionary method has an override in LogFile to make it illegal to
#'call, since LogFile manages its Dictionary entries.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addKeysAndValuesFrom <- function(source) {
 .LF$addKeysAndValuesFrom(source)
}

#'SLiM method addMeanSDColumns
#'
#'Documentation for SLiM function \code{addMeanSDColumns}, which is a method of
#'the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param columnName An object of type string or string or any. Must be of length 1
#'(a singleton). See details for description.
#'@param source An object of type string or string or any. Must be of length 1 (a
#'singleton). See details for description.
#'@param context An object of type string or string or any. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases LogFile$addMeanSDColumns .LF$addMeanSDColumns
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds two new data columns with names of columnName_mean and
#'columnName_sd. When a given row is generated, the code supplied in source is
#'expected to return either a zero-length vector of any type including NULL (which
#'will write out NA to both columns), or a non-zero-length vector of integer or
#'float values. In the latter case, the result vector will be summarized in the
#'two columns by its mean and standard deviation respectively. If the result
#'vector has exactly one value, the standard deviation will be written as NA.
#'The context parameter is set up as a pseudo-parameter when source is called, as
#'described in addCustomColumn().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addMeanSDColumns <- function(columnName, source, context) {
 .LF$addMeanSDColumns(columnName, source, context)
}

#'SLiM method addPopulationSexRatio
#'
#'Documentation for SLiM function \code{addPopulationSexRatio}, which is a method
#'of the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param species An object of type null or Species object. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases LogFile$addPopulationSexRatio .LF$addPopulationSexRatio
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the population sex ratio M:(M+F)
#'for species. In single- species models, species may be NULL to indicate that
#'single species. The column will simply be named sex_ratio in single-species
#'models; an underscore and the name of the species will be appended in
#'multispecies models. If the species is hermaphroditic, NA will be written.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addPopulationSexRatio <- function(species) {
 .LF$addPopulationSexRatio(species)
}

#'SLiM method addPopulationSize
#'
#'Documentation for SLiM function \code{addPopulationSize}, which is a method of
#'the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param species An object of type null or Species object. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases LogFile$addPopulationSize .LF$addPopulationSize
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the total population size for
#'species. In single-species models, species may be NULL to indicate that single
#'species. The column will simply be named num_individuals in single-species
#'models; an underscore and the name of the species will be appended in
#'multispecies models.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addPopulationSize <- function(species) {
 .LF$addPopulationSize(species)
}

#'SLiM method addSubpopulationSexRatio
#'
#'Documentation for SLiM function \code{addSubpopulationSexRatio}, which is a
#'method of the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param subpop An object of type integer or Subpopulation object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases LogFile$addSubpopulationSexRatio .LF$addSubpopulationSexRatio
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the sex ratio M:(M+F) of the
#'subpopulation subpop, named pX_sex_ratio. If the subpopulation exists but has a
#'size of zero, NA will be written.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSubpopulationSexRatio <- function(subpop) {
 .LF$addSubpopulationSexRatio(subpop)
}

#'SLiM method addSubpopulationSize
#'
#'Documentation for SLiM function \code{addSubpopulationSize}, which is a method
#'of the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param subpop An object of type integer or Subpopulation object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases LogFile$addSubpopulationSize .LF$addSubpopulationSize
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column that provides the size of the subpopulation
#'subpop, named pX_num_individuals. If the subpopulation exists but has a size of
#'zero, 0 will be written.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSubpopulationSize <- function(subpop) {
 .LF$addSubpopulationSize(subpop)
}

#'SLiM method addSuppliedColumn
#'
#'Documentation for SLiM function \code{addSuppliedColumn}, which is a method of
#'the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=667}{SLiM manual: page
#'667}.
#'
#'@param columnName An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'
#'@aliases LogFile$addSuppliedColumn .LF$addSuppliedColumn
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column with its name provided by columnName. The value
#'for the column is initially undefined, and will be written as NA. A different
#'value may (optionally) be provided by calling setSuppliedValue() with a value
#'for columnName. That value will be used for the column the next time a row is
#'generated (whether automatically or by a call to logRow()), and the column's
#'value will subsequently be undefined again. In other words, for any given logged
#'row the default of NA may be kept, or a different value may be supplied. This
#'allows the value for the column to be set at any point during the tick cycle,
#'which can be convenient if the column's value depends upon transient state that
#'is no longer available at the time the row is logged.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSuppliedColumn <- function(columnName) {
 .LF$addSuppliedColumn(columnName)
}

#'SLiM method addTick
#'
#'Documentation for SLiM function \code{addTick}, which is a method of the SLiM
#'class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$addTick .LF$addTick
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Adds a new data column, named tick, that provides the tick number for
#'the simulation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addTick <- function(void) {
 .LF$addTick(void)
}

#'SLiM method clearKeysAndValues
#'
#'Documentation for SLiM function \code{clearKeysAndValues}, which is a method of
#'the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$clearKeysAndValues .LF$clearKeysAndValues
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details This Dictionary method has an override in LogFile to make it illegal to
#'call, since LogFile manages its Dictionary entries.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
clearKeysAndValues <- function(void) {
 .LF$clearKeysAndValues(void)
}

#'SLiM method flush
#'
#'Documentation for SLiM function \code{flush}, which is a method of the SLiM
#'class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$flush .LF$flush
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Flushes all buffered data to the output file, synchronously. This will
#'make the contents of the file on disk be up-to-date with the running simulation.
#'Flushing frequently may entail a small performance penalty. More importantly,
#'if .gz compression has been requested with compress=T the size of the resulting
#'file will be larger - potentially much larger - if flush() is called frequently.
#'Note that automatic periodic flushing can be requested with the flushInterval
#'parameter to createLogFile().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
flush <- function(void) {
 .LF$flush(void)
}

#'SLiM method logRow
#'
#'Documentation for SLiM function \code{logRow}, which is a method of the SLiM
#'class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$logRow .LF$logRow
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details This logs a new row of data, by evaluating all of the generators added
#'to the LogFile with add...() calls. Note that the new row may be buffered, and
#'thus may not be written out to disk immediately; see flush(). This method may
#'be used instead of, or in conjunction with, automatic logging. You can get the
#'LogFile instance, in order to call logRow() on it, from community.logFiles, or
#'you can remember it in a global constant with defineConstant().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
logRow <- function(void) {
 .LF$logRow(void)
}

#'SLiM method setLogInterval
#'
#'Documentation for SLiM function \code{setLogInterval}, which is a method of the
#'SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param logInterval An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases LogFile$setLogInterval .LF$setLogInterval
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Sets the automatic logging interval. A logInterval of NULL stops
#'automatic logging immediately. Other values request that a new row should be
#'logged (as if logRow() were called) at the end of every logInterval ticks (just
#'before the tick count increment, in both WF and nonWF models), starting at the
#'end of the tick in which setLogInterval() was called.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setLogInterval <- function(logInterval) {
 .LF$setLogInterval(logInterval)
}

#'SLiM method setFilePath
#'
#'Documentation for SLiM function \code{setFilePath}, which is a method of the
#'SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param initialContents An object of type null or string. The default value is
#'\code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param compress An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param sep An object of type null or string. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases LogFile$setFilePath .LF$setFilePath
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Redirects the LogFile to write new rows to a new filePath. Any rows
#'that have been buffered but not flushed will be written to the previous file
#'first, as if flush() had been called. With this call, new initialContents may
#'be supplied, which will either replace any existing file or will be appended to
#'it, depending upon the value of append. New values may be supplied for compress
#'and sep; the meaning of these parameters is identical to their meaning in
#'createLogFile(), except that a value of NULL for these means "do not change this
#'setting from its previous value". In effect, then, this method lets you start
#'a completely new log file at a new path, without having to create and configure
#'a new LogFile object. The new file will be created (or appended) synchronously,
#'with the specified initial contents.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setFilePath <- function(filePath, initialContents, append, compress, sep) {
 .LF$setFilePath(filePath, initialContents, append, compress, sep)
}

#'SLiM method setSuppliedValue
#'
#'Documentation for SLiM function \code{setSuppliedValue}, which is a method of
#'the SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param columnName An object of type string or any but object. Must be of length
#'1 (a singleton). See details for description.
#'@param value An object of type string or any but object. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases LogFile$setSuppliedValue .LF$setSuppliedValue
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details Registers a value, passed in value, to be used for the supplied column
#'named columnName when a row is next logged. This column must have been added
#'with addSuppliedColumn(). A value of NULL may be passed to log NA, but logging
#'NA is the default behavior for supplied columns in any case. Otherwise, the
#'value must be a singleton, and its type should match the values previously
#'supplied for the column (otherwise the log file may be difficult to parse,
#'since the values within the column will not be of one consistent type). See
#'addSuppliedColumn() for further details.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSuppliedValue <- function(columnName, value) {
 .LF$setSuppliedValue(columnName, value)
}

#'SLiM method setValue
#'
#'Documentation for SLiM function \code{setValue}, which is a method of the SLiM
#'class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=668}{SLiM manual: page
#'668}.
#'
#'@param key An object of type string or any. Must be of length 1 (a singleton).
#'See details for description.
#'@param value An object of type string or any. See details for description.
#'
#'@aliases LogFile$setValue .LF$setValue
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical.
#'@details This Dictionary method has an override in LogFile to make it illegal to
#'call, since LogFile manages its Dictionary entries.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setValue <- function(key, value) {
 .LF$setValue(key, value)
}

#'SLiM method willAutolog
#'
#'Documentation for SLiM function \code{willAutolog}, which is a method of the
#'SLiM class \code{\link{LogFile}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=669}{SLiM manual: page
#'669}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases LogFile$willAutolog .LF$willAutolog
#'@family LogFile
#'@return An object of type void or void or void or void or void or void or void
#'or void or void or void or void or void or void or void or void or void or void
#'or void or logical. Return will be of length 1 (a singleton)
#'@details Returns T if the log file is configured to log a new row automatically
#'at the end of the current tick; otherwise, returns F. This is useful for
#'calculating a value that will be logged only in ticks when the value is needed.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
willAutolog <- function(void) {
 .LF$willAutolog(void)
}



#'SLiM method setMutationType
#'
#'Documentation for SLiM function \code{setMutationType}, which is a method of the
#'SLiM class \code{\link{Mutation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=670}{SLiM manual: page
#'670}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Mutation$setMutationType .M$setMutationType
#'@family Mutation
#'@return An object of type void or void.
#'@details Set the mutation type of the mutation to mutType (which may be
#'specified as either an integer identifier or a MutationType object). This
#'implicitly changes the dominance coefficient of the mutation to that of the new
#'mutation type, since the dominance coefficient is a property of the mutation
#'type. On the other hand, the selection coefficient of the mutation is not
#'changed, since it is a property of the mutation object itself; it can be changed
#'explicitly using the setSelectionCoeff() method if so desired. The mutation
#'type of a mutation is normally a constant in simulations, so be sure you know
#'what you are doing. Changing this will normally affect the fitness values
#'calculated toward the end of the current tick; if you want current fitness
#'values to be affected, you can call the Species method recalculateFitness()
#'- but see the documentation of that method for caveats. In nucleotide-based
#'models, a restriction applies: nucleotide-based mutations may not be changed to
#'a non-nucleotide-based mutation type, and non-nucleotide-based mutations may not
#'be changed to a nucleotide-based mutation type.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Mutation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=670}{SLiM manual: page
#'670}.
#'
#'@param selectionCoeff An object of type float. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Mutation$setSelectionCoeff .M$setSelectionCoeff
#'@family Mutation
#'@return An object of type void or void.
#'@details Set the selection coefficient of the mutation to selectionCoeff. The
#'selection coefficient will be changed for all individuals that possess the
#'mutation, since they all share a single Mutation object (note that the dominance
#'coefficient will remain unchanged, as it is determined by the mutation type).
#'This is normally a constant in simulations, so be sure you know what you are
#'doing; often setting up a mutationEffect() callback (see section 25.2) is
#'preferable, in order to modify the selection coefficient in a more limited and
#'controlled fashion (see section 10.5 for further discussion of this point).
#'Changing this will normally affect the fitness values calculated toward the end
#'of the current tick; if you want current fitness values to be affected, you can
#'call the Species method recalculateFitness() - but see the documentation of that
#'method for caveats.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSelectionCoeff <- function(selectionCoeff) {
 .M$setSelectionCoeff(selectionCoeff)
}



#'SLiM method drawSelectionCoefficient
#'
#'Documentation for SLiM function \code{drawSelectionCoefficient}, which is a
#'method of the SLiM class \code{\link{MutationType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=674}{SLiM manual: page
#'674}.
#'
#'@param n An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases MutationType$drawSelectionCoefficient .MT$drawSelectionCoefficient
#'@family MutationType
#'@return An object of type float or void.
#'@details Draws and returns a vector of n selection coefficients using the
#'currently defined distribution of fitness effects (DFE) for the target mutation
#'type. See section 24.11 above for discussion of the supported distributions
#'and their uses. If the DFE is type "s", this method will result in synchronous
#'execution of the DFE's script.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
drawSelectionCoefficient <- function(n) {
 .MT$drawSelectionCoefficient(n)
}

#'SLiM method setDistribution
#'
#'Documentation for SLiM function \code{setDistribution}, which is a method of the
#'SLiM class \code{\link{MutationType}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=674}{SLiM manual: page
#'674}.
#'
#'@param distributionType An object of type string. Must be of length 1 (a
#'singleton). See details for description.
#'@param ... An object of type NA. NA See details for description.
#'
#'@aliases MutationType$setDistribution .MT$setDistribution
#'@family MutationType
#'@return An object of type float or void.
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
#'ellipsis should supply a string$ Eidos script parameter. See section 24.11 above
#'for discussions of these distributions and their uses. The DFE for a mutation
#'type is normally a constant in simulations, so be sure you know what you are
#'doing.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setDistribution <- function(distributionType, ...) {
 .MT$setDistribution(distributionType, ...)
}



#'SLiM method addSubpop
#'
#'Documentation for SLiM function \code{addSubpop}, which is a method of the SLiM
#'class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param subpopID An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). The
#'default value is \code{0.5}. See details for description.
#'
#'@aliases SLiMSim$addSubpop .SS$addSubpop
#'@family SLiMSim
#'@return An object of type Subpopulation object. Return will be of length 1 (a
#'singleton)
#'@details Add a new subpopulation with id subpopID and size individuals.
#'The subpopID parameter may be either an integer giving the ID of the new
#'subpopulation, or a string giving the name of the new subpopulation (such as
#'"p5" to specify an ID of 5). Only if sex is enabled in the simulation, the
#'initial sex ratio may optionally be specified as sexRatio (as the male fraction,
#'M:M+F); if it is not specified, a default of 0.5 is used. The new subpopulation
#'will be defined as a global variable immediately by this method (see section
#'24.14), and will also be returned by this method. Subpopulations added by this
#'method will initially consist of individuals with empty genomes. In order to
#'model subpopulations that split from an already existing subpopulation, use
#'addSubpopSplit().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'defined as a global variable immediately by this method (see section 24.14), and
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
#'migrating juveniles from the source subpopulation, in accordance with SLiM's
#'usual model of juvenile migration.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases SLiMSim$countOfMutationsOfType .SS$countOfMutationsOfType
#'@family SLiMSim
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .SS$countOfMutationsOfType(mutType)
}

#'SLiM method createLogFile
#'
#'Documentation for SLiM function \code{createLogFile}, which is a method of the
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param initialContents An object of type null or string. The default value is
#'\code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param compress An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param sep An object of type string. Must be of length 1 (a singleton). The
#'default value is \code{","}. See details for description.
#'@param logInterval An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param flushInterval An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$createLogFile .SS$createLogFile
#'@family SLiMSim
#'@return An object of type LogFile object. Return will be of length 1 (a
#'singleton)
#'@details Creates and returns a new LogFile object that logs data from the
#'simulation (see the documentation for the LogFile class for details). Logged
#'data will be written to the file at filePath, overwriting any existing file at
#'that path by default, or appending to it instead if append is T (successive rows
#'of the log table will always be appended to the previously written content, of
#'course). Before the header line for the log is written out, any string elements
#'in initialContents will be written first, separated by newlines, allowing for a
#'user-defined file header. If compress is T, the contents will be compressed with
#'zlib as they are written, and the standard .gz extension for gzip-compressed
#'files will be appended to the filename in filePath if it is not already present.
#'The sep parameter specifies the separator between data values within a row.
#'The default of "," will generate a "comma-separated value" (CSV) file, while
#'passing sep="\\t" will use a tab separator Eidos events fitness() mateChoice()
#'modifyChild() recombination() interaction() reproduction() 566 instead to
#'generate a "tab-separated value" (TSV) file. Other values for sep may also be
#'used, but are less standard. LogTable supports periodic automatic logging of a
#'new row of data, enabled by supplying a non-NULL value for logInterval. In this
#'case, a new row will be logged (as if logRow() were called on the LogFile) at
#'the end of every logInterval generations (just before the generation counter
#'increments, in both WF and nonWF models), starting at the end of the generation
#'in which the LogFile was created. A logInterval of 1 will cause automatic
#'logging at the end of every generation, whereas a logInterval of NULL disables
#'automatic logging. Automatic logging can always be disabled or reconfigured
#'later with the LogFile method setLogInterval(), or logging can be triggered
#'manually by calling logRow(). When compression is enabled, LogFile flushes new
#'data lazily by default, for performance reasons, buffering data for multiple
#'rows before writing to disk. Passing a non-NULL value for flushInterval requests
#'a flush every flushInterval rows (with a value of 1 providing unbuffered
#'operation). Note that flushing very frequently will likely result in both
#'lower performance and a larger final file size (in one simple test, 48943 bytes
#'instead of 4280 bytes, or more than a 10× increase in size). Alternatively,
#'passing a very large value for flushInterval will effectively disable automatic
#'flushing, except at the end of the simulation (but be aware that this may use
#'a large amount of memory for large log files). In any case, the log file will
#'be created immediately, with its requested initial contents; the initial write
#'is not buffered. When compression is not enabled, the flushInterval setting is
#'ignored. The LogFile documentation discusses how to configure and use LogFile to
#'write out the data you are interested in from your simulation; see section 24.9.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
createLogFile <- function(filePath, initialContents, append, compress, sep,
logInterval, flushInterval) {
 .SS$createLogFile(filePath, initialContents, append, compress, sep,
logInterval, flushInterval)
}

#'SLiM method deregisterScriptBlock
#'
#'Documentation for SLiM function \code{deregisterScriptBlock}, which is a method
#'of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param scriptBlocks An object of type integer or SLiMEidosBlock object. See
#'details for description.
#'
#'@aliases SLiMSim$deregisterScriptBlock .SS$deregisterScriptBlock
#'@family SLiMSim
#'@return An object of type void.
#'@details All SLiMEidosBlock objects specified by scriptBlocks (either with
#'SLiMEidosBlock objects or with integer identifiers) will be scheduled for
#'deregistration. The deregistered blocks remain valid, and may even still be
#'executed in the current stage of the current generation (see section 25.9); the
#'blocks are not actually deregistered and deallocated until sometime after the
#'currently executing script block has completed. To immediately prevent a script
#'block from executing, even when it is scheduled to execute in the current stage
#'of the current generation, use the active property of the script block (see
#'sections 24.11.1 and 25.9).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
deregisterScriptBlock <- function(scriptBlocks) {
 .SS$deregisterScriptBlock(scriptBlocks)
}

#'SLiM method mutationCounts
#'
#'Documentation for SLiM function \code{mutationCounts}, which is a method of the
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param subpops An object of type null or Subpopulation object. See details for
#'description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$mutationCounts .SS$mutationCounts
#'@family SLiMSim
#'@return An object of type integer.
#'@details Return an integer vector with the frequency counts of all of the
#'Mutation objects passed in mutations, within the Subpopulation objects in
#'subpops. The subpops argument is required, but you may pass NULL to get
#'population-wide frequency counts. If the optional mutations argument is NULL
#'(the default), frequency counts will be returned for all of the active Mutation
#'objects in the simulation - the same Mutation objects, and in the same order,
#'as would be returned by the mutations property of sim, in other words. See
#'the -mutationFrequencies() method to obtain float frequencies instead of
#'integer counts. See also the Genome methods mutationCountsInGenomes() and
#'mutationFrequenciesInGenomes().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param subpops An object of type null or Subpopulation object. See details for
#'description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$mutationFrequencies .SS$mutationFrequencies
#'@family SLiMSim
#'@return An object of type float.
#'@details Return a float vector with the frequencies of all of the
#'Mutation objects passed in mutations, within the Subpopulation objects in
#'subpops. The subpops argument is required, but you may pass NULL to get
#'population-wide frequencies. If the optional mutations argument is NULL
#'(the default), frequencies will be returned for all of the active Mutation
#'objects in the simulation - the same Mutation objects, and in the same
#'order, as would be returned by the mutations property of sim, in other
#'words. See the -mutationCounts() method to obtain integer counts instead
#'of float frequencies. See also the Genome methods mutationCountsInGenomes()
#'and mutationFrequenciesInGenomes(). Eidos events fitness() mateChoice()
#'modifyChild() recombination() interaction() reproduction() 567
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases SLiMSim$mutationsOfType .SS$mutationsOfType
#'@family SLiMSim
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases SLiMSim$outputFixedMutations .SS$outputFixedMutations
#'@family SLiMSim
#'@return An object of type void.
#'@details Output all fixed mutations - all Substitution objects, in other words
#'(see section 1.5.2) - in a SLiM native format (see section 26.1.2 for output
#'format details). If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos's output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T.
#'Mutations which have fixed but have not been turned into Substitution objects
#'- typically because convertToSubstitution has been set to F for their mutation
#'type (see section 24.10.1) - are not output; they are still considered to be
#'segregating mutations by SLiM. In SLiM 3.3 and later, the output format includes
#'the nucleotides associated with any nucleotide-based mutations; see section
#'26.1.2. Output is generally done in a late() event, so that the output reflects
#'the state of the simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@param pedigreeIDs An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'
#'@aliases SLiMSim$outputFull .SS$outputFull
#'@family SLiMSim
#'@return An object of type void.
#'@details Output the state of the entire population (see section 26.1.1 for
#'output format details). If the optional parameter filePath is NULL (the
#'default), output will be sent to Eidos's output stream (see section 4.2.1).
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
#'available (see section 26.1.1 for format details). If the simulation does not
#'have continuous space enabled, the spatialPositions parameter will be ignored.
#'Positional information may be output for all output destinations - the Eidos
#'output stream, a text file, or a binary file. Beginning with SLiM 3.0, the ages
#'parameter may be used to control the output of the ages of individuals in nonWF
#'simulations. If ages is F, the output will not contain ages, preserving backward
#'compatibility with the output format of SLiM 2.1 and later. If ages is T, ages
#'will be output for nonWF models (see section 26.1.1 for format details). In
#'WF simulations, the ages parameter will be ignored. Beginning with SLiM 3.3,
#'the ancestralNucleotides parameter may be used to control the output of the
#'ancestral nucleotide sequence in nucleotide-based models (see section 26.1.1
#'for format details). If ancestralNucleotides is F, the output will not contain
#'ancestral nucleotide information, and so the ancestral sequence will not be
#'restored correctly if the saved file is loaded with readPopulationFile(). This
#'option is provided because the ancestral sequence may be quite large, Eidos
#'events fitness() mateChoice() modifyChild() recombination() interaction()
#'reproduction() 568 for models with a long chromosome (e.g., 1 GB if the
#'chromosome is 109 bases long, when saved in text format, or 0.25 GB when saved
#'in binary format). If the model is not nucleotide-based (as enabled with the
#'nucleotideBased parameter to initializeSLiMOptions()), the ancestralNucleotides
#'parameter will be ignored. Note that in nucleotide-based models the output
#'format will always include the nucleotides associated with any nucleotide-based
#'mutations; the ancestralNucleotides flag governs only the ancestral sequence.
#'Beginning with SLiM 3.5, the pedigreeIDs parameter may be used to request
#'that pedigree IDs be written out (and read in by readFromPopulationFile(),
#'subsequently). This option is turned off (F) by default, to preserve backward
#'compatibility; if it is turned on (T), different file version values will be
#'used, and backward compatibility with previous versions of SLiM will be lost
#'(see section 26.1.1). This option may only be used if SLiM's optional pedigree
#'tracking has been turned on with initializeSLiMOptions(keepPedigrees=T). Output
#'is generally done in a late() event, so that the output reflects the state of
#'the simulation at the end of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputFull <- function(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides, pedigreeIDs) {
 .SS$outputFull(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides, pedigreeIDs)
}

#'SLiM method outputMutations
#'
#'Documentation for SLiM function \code{outputMutations}, which is a method of the
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases SLiMSim$outputMutations .SS$outputMutations
#'@family SLiMSim
#'@return An object of type void.
#'@details Output all of the given mutations (see section 26.1.3 for output
#'format details). This can be used to output all mutations of a given mutation
#'type, for example. If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos's output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T. In SLiM
#'3.3 and later, the output format includes the nucleotides associated with any
#'nucleotide-based mutations; see section 26.1.3. Output is generally done in a
#'late() event, so that the output reflects the state of the simulation at the end
#'of a generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$outputUsage .SS$outputUsage
#'@family SLiMSim
#'@return An object of type void.
#'@details Output the current memory usage of the simulation to Eidos's output
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases SLiMSim$readFromPopulationFile .SS$readFromPopulationFile
#'@family SLiMSim
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Read from a population initialization file, whether in text or binary
#'format as previously specified to outputFull(), and return the generation
#'counter value represented by the file's contents (i.e., the generation at which
#'the file was generated). Although this is most commonly used to set up initial
#'populations (often in an Eidos event set to run in generation 1, immediately
#'after simulation initialization), it may be called in any Eidos event; the
#'current state of all populations will be wiped and replaced by the state in
#'the file at filePath. All Eidos variables that are of type object and have
#'element type Subpopulation, Genome, Mutation, Individual, or Substitution will
#'be removed as a side effect of this method, since all such variables would
#'refer to objects that no longer exist in the SLiM simulation; if you want to
#'preserve any of that state, you should output it or save it to a file prior to
#'this call. New symbols will be defined to refer to the new Subpopulation objects
#'loaded from the file. If the file being read was written by a version of SLiM
#'prior to 2.3, then for backward compatibility fitness values will be calculated
#'immediately for any new subpopulations created by this call, which will trigger
#'the calling of any activated and applicable fitness() callbacks. When reading
#'files written by SLiM 2.3 or later, fitness values are not calculated as a
#'side effect of this call (because the simulation will often need to evaluate
#'interactions or modify other state prior to doing so). Eidos events fitness()
#'mateChoice() modifyChild() recombination() interaction() reproduction() 569 In
#'SLiM 2.3 and later when using the WF model, calling readFromPopulationFile()
#'from any context other than a late() event causes a warning; calling from a
#'late() event is almost always correct in WF models, so that fitness values can
#'be automatically recalculated by SLiM at the usual time in the generation cycle
#'without the need to force their recalculation (see chapter 22, and comments on
#'recalculateFitness() below). In SLiM 3.0 when using the nonWF model, calling
#'readFromPopulationFile() from any context other than an early() event causes a
#'warning; calling from an early() event is almost always correct in nonWF models,
#'so that fitness values can be automatically recalculated by SLiM at the usual
#'time in the generation cycle without the need to force their recalculation (see
#'chapter 23, and comments on recalculateFitness() below). As of SLiM 2.1, this
#'method changes the generation counter to the generation read from the file.
#'If you do not want the generation counter to be changed, you can change it
#'back after reading, by setting sim.generation to whatever value you wish. Note
#'that restoring a saved past state and running forward again will not yield the
#'same simulation results, because the random number generator's state will not
#'be the same; to ensure reproducibility from a given time point, setSeed() can
#'be used to establish a new seed value. Any changes made to the simulation's
#'structure (mutation types, genomic element types, etc.) will not be wiped
#'and re-established by readFromPopulationFile(); this method loads only the
#'population's state, not the simulation configuration, so care should be taken
#'to ensure that the simulation structure meshes coherently with the loaded data.
#'Indeed, state such as the selfing and cloning rates of subpopulations, values
#'set into tag properties, and values set onto objects with setValue() will also
#'be lost, since it is not saved out by outputFull(). Only information saved by
#'outputFull() will be restored; all other state associated with the simulation's
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
#'3.3, this method will restore the nucleotides of nucleotide-based mutations,
#'and will restore the ancestral nucleotide sequence, if that information is
#'present in the output file. Loading an output file that contains nucleotide
#'information in a non-nucleotide-based model, and vice versa, will produce
#'an error. As of SLiM 3.5, this method will read and restore the pedigree IDs
#'of individuals and genomes if that information is present in the output file
#'(as requested with outputFull(pedigreeIDs=T)) and if SLiM's optional pedigree
#'tracking has been turned on with initializeSLiMOptions(keepPedigrees=T).
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
#'Eidos events fitness() mateChoice() modifyChild() recombination() interaction()
#'reproduction() 570
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param generation An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$recalculateFitness .SS$recalculateFitness
#'@family SLiMSim
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
#'simulation's current generation value, sim.generation, is used. If you call
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos early() event in the current simulation, with
#'optional start and end generations limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered event is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 25.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos fitness() callback in the current simulation,
#'with a required mutation type mutType (which may be an integer mutation type
#'identifier, or NULL to indicate a global fitness() callback - see section
#'25.2), optional subpopulation subpop (which may also be an integer identifier,
#'or NULL, the default, to indicate all subpopulations), and optional start and
#'end generations all limiting its applicability. The script block will be given
#'identifier id (specified as an integer, or as a string symbolic name such as
#'"s5"); this may be NULL if there is no need to be able to refer to the block
#'later. The registered callback is added to the end of the list of registered
#'SLiMEidosBlock objects, and is active immediately; it may be eligible to execute
#'in the current generation (see section 25.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'24.11), and will also be returned by this method. Eidos events fitness()
#'mateChoice() modifyChild() recombination() interaction() reproduction() 571
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos late() event in the current simulation, with
#'optional start and end generations limiting its applicability. The script block
#'will be given identifier id (specified as an integer, or as a string symbolic
#'name such as "s5"); this may be NULL if there is no need to be able to refer
#'to the block later. The registered event is added to the end of the list of
#'registered SLiMEidosBlock objects, and is active immediately; it may be eligible
#'to execute in the current generation (see section 25.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'in the current generation (see section 25.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'in the current generation (see section 25.9 for details). The new SLiMEidosBlock
#'will be defined as a global variable immediately by this method (see section
#'24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerModifyChildCallback <- function(id, source, subpop, start, end) {
 .SS$registerModifyChildCallback(id, source, subpop, start, end)
}

#'SLiM method registerMutationCallback
#'
#'Documentation for SLiM function \code{registerMutationCallback}, which is a
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mutation() callback in the current simulation,
#'with an optional mutation type mutType (which may be an integer mutation type
#'identifier, or NULL, the default, to indicate all mutation types - see Eidos
#'events fitness() mateChoice() modifyChild() recombination() interaction()
#'reproduction() 572 section 25.8), optional subpopulation subpop (which may also
#'be an integer identifier, or NULL, the default, to indicate all subpopulations),
#'and optional start and end generations all limiting its applicability. The
#'script block will be given identifier id (specified as an integer, or as a
#'string symbolic name such as "s5"); this may be NULL if there is no need to be
#'able to refer to the block later. The registered callback is added to the end of
#'the list of registered SLiMEidosBlock objects, and is active immediately; it may
#'be eligible to execute in the current generation (see section 25.9 for details).
#'The new SLiMEidosBlock will be defined as a global variable immediately by this
#'method (see section 24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMutationCallback <- function(id, source, mutType, subpop, start, end)
{
 .SS$registerMutationCallback(id, source, mutType, subpop, start, end)
}

#'SLiM method registerRecombinationCallback
#'
#'Documentation for SLiM function \code{registerRecombinationCallback}, which is a
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'to execute in the current generation (see section 25.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerRecombinationCallback <- function(id, source, subpop, start, end) {
 .SS$registerRecombinationCallback(id, source, subpop, start, end)
}

#'SLiM method registerReproductionCallback
#'
#'Documentation for SLiM function \code{registerReproductionCallback}, which is a
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
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
#'@family SLiMSim
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
#'to execute in the current generation (see section 25.9 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.11), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param block An object of type SLiMEidosBlock object. Must be of length 1 (a
#'singleton). See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param generations An object of type null or integer. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases SLiMSim$rescheduleScriptBlock .SS$rescheduleScriptBlock
#'@family SLiMSim
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
#'source, tag, and type properties equal to the current values for block, but
#'will be given an id of -1 since script block identifiers must be unique; if
#'it is necessary to find the duplicated blocks again later, their tag property
#'should be used. The vector supplied for generations does not need to be in
#'sorted order, but it must not contain any duplicates. Eidos events fitness()
#'mateChoice() modifyChild() recombination() interaction() reproduction() 573
#'Because this method can create a large number of duplicate script blocks,
#'it can sometimes be better to handle script block scheduling in other ways.
#'If an early() event needs to execute every tenth generation over the whole
#'duration of a long model run, for example, it would not be advisable to use a
#'call like sim.rescheduleScriptBlock(s1, generations=seq(10, 100000, 10)) for
#'that purpose, since that would result in thousands of duplicate script blocks.
#'Instead, it would be preferable to add a test such as if (sim.generation % 10 !=
#'0) return; at the beginning of the event. It is legal to reschedule a script
#'block while the block is executing; a call like sim.rescheduleScriptBlock(self,
#'sim.generation + 10, sim.generation + 10); made inside a given block would
#'therefore also cause the block to execute every tenth generation, although
#'this sort of self-rescheduling code is probably harder to read, maintain, and
#'debug. Whichever way of specifying the generation set is used, the discussion in
#'section 25.9 applies: block may continue to be executed during the current life
#'cycle stage even after it has been rescheduled, unless it is made inactive using
#'its active property, and similarly, the block may not execute during the current
#'life cycle stage if it was not already scheduled to do so. Rescheduling script
#'blocks during the generation and life cycle stage in which they are executing,
#'or in which they are intended to execute, should be avoided. Also, as mentioned
#'in section 22.7, script blocks which are open-ended (i.e., with no specified end
#'generation), are not used in determining whether the end of the simulation has
#'been reached (because then the simulation would run forever); if you reschedule
#'a block to be open-ended, and to start after the end of the last closed-ended
#'block, the rescheduled block will therefore not run at all (just as such a block
#'would not run at all in other circumstances, too). Note that new script blocks
#'can also be created and scheduled using the register...() methods of SLiMSim; by
#'using the same source as a template script block, the template can be duplicated
#'and scheduled for different generations. In fact, rescheduleScriptBlock() does
#'essentially that internally.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
rescheduleScriptBlock <- function(block, start, end, generations) {
 .SS$rescheduleScriptBlock(block, start, end, generations)
}

#'SLiM method simulationFinished
#'
#'Documentation for SLiM function \code{simulationFinished}, which is a method of
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$simulationFinished .SS$simulationFinished
#'@family SLiMSim
#'@return An object of type void.
#'@details Declare the current simulation finished. Normally SLiM ends a
#'simulation when, at the end of a generation, there are no script events or
#'callbacks registered for any future generation (excluding scripts with no
#'declared end generation). If you wish to end a simulation before this condition
#'is met, a call to simulationFinished() will cause the current simulation to
#'end at the end of the current generation. For example, a simulation might
#'self-terminate if a test for a dynamic equilibrium condition is satisfied. Note
#'that the current generation will finish executing; if you want the simulation
#'to stop immediately, you can use the Eidos method stop(), which raises an error
#'condition.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
simulationFinished <- function(void) {
 .SS$simulationFinished(void)
}

#'SLiM method subsetMutations
#'
#'Documentation for SLiM function \code{subsetMutations}, which is a method of the
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param exclude An object of type null or Mutation object. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param mutType An object of type null or integer or MutationType object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param position An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param nucleotide An object of type null or integer or string. Must be of length
#'1 (a singleton). The default value is \code{NULL}. See details for description.
#'@param tag An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param id An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$subsetMutations .SS$subsetMutations
#'@family SLiMSim
#'@return An object of type Mutation object.
#'@details Returns a vector of mutations subset from the list of all active
#'mutations in the simulation (as would be provided by the mutations property).
#'The parameters specify constraints upon the subset of mutations that will
#'be returned. Parameter exclude, if non-NULL, may specify a specific mutation
#'that should not be included (typically the focal mutation in some operation).
#'Parameter mutType, if non- NULL, may specify a mutation type for the mutations
#'to be returned (as either a MutationType object or an integer identifier).
#'Parameter position, if non-NULL, may specify a base position for the mutations
#'to be returned. Parameter nucleotide, if non-NULL, may specify a nucleotide
#'for the mutations to be returned (either as a string, "A" / "C" / "G" / "T",
#'or as an integer, 0 / 1 / 2 / 3 respectively). Parameter tag, if non-NULL,
#'may specify a tag value for the mutations to be returned. Parameter id, if
#'non-NULL, may specify a required value for the id property of the mutations
#'to be returned. This method is shorthand for getting the mutations property
#'of the subpopulation, and then using operator [] to select only mutations with
#'the desired properties; besides being much simpler than the equivalent Eidos
#'code, it is also much faster. Note that if you only need to select on mutation
#'type, the mutationsOfType() method will be even faster. Eidos events fitness()
#'mateChoice() modifyChild() recombination() interaction() reproduction() 574
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
subsetMutations <- function(exclude, mutType, position, nucleotide, tag, id)
{
 .SS$subsetMutations(exclude, mutType, position, nucleotide, tag, id)
}

#'SLiM method treeSeqCoalesced
#'
#'Documentation for SLiM function \code{treeSeqCoalesced}, which is a method of
#'the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$treeSeqCoalesced .SS$treeSeqCoalesced
#'@family SLiMSim
#'@return An object of type logical. Return will be of length 1 (a singleton)
#'@details Returns the coalescence state for the recorded tree sequence at
#'the last simplification. The returned value is a logical singleton flag,
#'T to indicate that full coalescence was observed at the last treesequence
#'simplification (meaning that there is a single ancestral individual that roots
#'all ancestry trees at all sites along the chromosome - although not necessarily
#'the same ancestor at all sites), or F if full coalescence was not observed. For
#'simple models, reaching coalescence may indicate that the model has reached an
#'equilibrium state, but this may not be true in models that modify the dynamics
#'of the model during execution by changing migration rates, introducing new
#'mutations programmatically, dictating non-random mating, etc., so be careful not
#'to attach more meaning to coalescence than it is due; some models may require
#'burn-in beyond coalescence to reach equilibrium, or may not have an equilibrium
#'state at all. Also note that some actions by a model, such as adding a new
#'subpopulation, may cause the coalescence state to revert from T back to F (at
#'the next simplification), so a return value of T may not necessarily mean that
#'the model is coalesced at the present moment - only that it was coalesced at the
#'last simplification. This method may only be called if tree sequence recording
#'has been turned on with initializeTreeSeq(); in addition, checkCoalescence=T
#'must have been supplied to initializeTreeSeq(), so that the necessary work
#'is done during each tree-sequence simplification. Since this method does not
#'perform coalescence checking itself, but instead simply returns the coalescence
#'state observed at the last simplification, it may be desirable to call
#'treeSeqSimplify() immediately before treeSeqCoalesced() to obtain up-to-date
#'information. However, the speed penalty of doing this in every generation would
#'be large, and most models do not need this level of precision; usually it is
#'sufficient to know that the model has coalesced, without knowing whether that
#'happened in the current generation or in a recent preceding generation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param path An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param simplify An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{T}. See details for description.
#'@param includeModel An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'@param metadata An object of type null. Must be of length 1 (a singleton). The
#'default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMSim$treeSeqOutput .SS$treeSeqOutput
#'@family SLiMSim
#'@return An object of type void.
#'@details Outputs the current tree sequence recording tables to the path
#'specified by path. This method may only be called if tree sequence recording
#'has been turned on with initializeTreeSeq(). If simplify is T (the default),
#'simplification will be done immediately prior to output; this is almost always
#'desirable, unless a model wishes to avoid simplification entirely. (Note that if
#'simplification is not done, then all genomes since the last simplification will
#'be marked as samples in the resulting tree sequence.) A binary tree sequence
#'file will be written to the specified path; a filename extension of .trees
#'is suggested for this type of file. Normally, the full SLiM script used to
#'generate the tree sequence is written out to the provenance entry of the tree
#'sequence file, to the model subkey of the parameters top-level key. Supplying
#'F for includeModel suppresses output of the full script; see section 26.4.6
#'for further discussion. A Dictionary object containing user-generated metadata
#'may be supplied with the metadata parameter. If present, this dictionary will
#'be serialized as JSON and attached to the saved tree sequence under a key
#'named user_metadata, within the SLiM key (see section 26.4.5). If pyslim is
#'used to read the tree sequence in Python, this metadata will automatically be
#'deserialized and made available at ts.metadata["SLiM"]["user_metadata"]. This
#'metadata dictionary is not used by SLiM, or by pyslim, tskit, or msprime; you
#'may use it for any purpose you wish. Note that metadata may actually be any
#'subclass of Dictionary, such as the SLiMSim simulation object sim, or a LogFile
#'instance. However, only the keys and values contained by the object's Dictionary
#'superclass state will be serialized into the metadata; properties of the
#'subclass will be ignored.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqOutput <- function(path, simplify, includeModel, metadata) {
 .SS$treeSeqOutput(path, simplify, includeModel, metadata)
}

#'SLiM method treeSeqRememberIndividuals
#'
#'Documentation for SLiM function \code{treeSeqRememberIndividuals}, which is a
#'method of the SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'@param permanent An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{T}. See details for description.
#'
#'@aliases SLiMSim$treeSeqRememberIndividuals .SS$treeSeqRememberIndividuals
#'@family SLiMSim
#'@return An object of type void.
#'@details Mark the individuals specified by individuals to be kept across tree
#'sequence table simplification. This method may only be called if tree sequence
#'recording has been turned on with initializeTreeSeq(). All currently living
#'individuals are always kept across simplification; this method does not need
#'to be called, and indeed should not be called, for that purpose. Instead,
#'treeSeqRememberIndividuals() allows any individual, including dead individuals,
#'to be kept in Eidos events fitness() mateChoice() modifyChild() recombination()
#'interaction() reproduction() 575 the final tree sequence. Typically this would
#'be used, for example, to keep particular individuals that you wanted to be able
#'to trace ancestry back to in later analysis. However, this is not the typical
#'usage pattern for tree sequence recording; most models will not need to call
#'this method. There are two ways to keep individuals across simplification.
#'If permanent is T (the default), then the specified individuals will be
#'permanently remembered: their genomes will be added to the current sample,
#'and they will always be present in the tree sequence. Permanently remembering
#'a large number of individuals will, of course, markedly increase memory usage
#'and runtime. Supplying F for permanent will instead mark the individuals only
#'for (temporary) retention: their genomes will not be added to the sample, and
#'they will appear in the final tree sequence only if one of their genomes is
#'retained across simplification. In other words, the rule of thumb for retained
#'individuals is simple: if a genome is kept by simplification, the genome's
#'corresponding individual is kept also, if it is retained. Note that permanent
#'remembering takes priority; calling this function with permanent=F on an
#'individual that has previously been permanently remembered will not remove it
#'from the sample. The behavior of simplification for individuals retained with
#'permanent=F depends upon the value of the retainCoalescentOnly flag passed
#'to initializeTreeSeq(); here we will discuss the behavior of that flag in
#'detail. First of all, genomes are always removed by simplification unless they
#'are (a) part of the final generation, (b) ancestral to the final generation,
#'(c) a genome of a permanently remembered individual, or (d) ancestral to a
#'permanently remembered individual. If retainCoalescentOnly is T (the default),
#'they are also always removed if they are not a branch point (i.e., a coalescent
#'node or most recent common ancestor) in the tree sequence. In some cases it
#'may be useful to retain a genome and its associated individual when it is
#'simply an intermediate node in the ancestry (i.e., in the middle of a branch).
#'This can be enabled by setting retainCoalescentOnly to F in your call to
#'initializeTreeSeq(). In this case, ancestral genomes that are intermediate
#'("unary nodes", in tskit parlance) and are within an individual that has been
#'retained using the permanent=F flag here are kept, along with the retained
#'individual itself. Since setting retainCoalescentOnly to F will prevent the
#'unary nodes for retained individuals from being pruned, simplification may
#'often be unable to prune very much at all from the tree sequence, and memory
#'usage and runtime may increase rapidly. If you are retaining many individuals,
#'this setting should therefore be used only with caution; it is not necessary if
#'you are purely interested in the most recent common ancestors. See the pyslim
#'documentation for further discussion of retaining and remembering individuals
#'and the effects of the retainCoalescentOnly flag. The metadata (age, location,
#'etc) that are stored in the resulting tree sequence are those values present
#'at either (a) the final generation, if the individual is alive at the end of
#'the simulation, or (b) the last time that the individual was remembered, if
#'not. Calling treeSeqRememberIndividuals() on an individual that is already
#'remembered will cause the archived information about the remembered individual
#'to be updated to reflect the individual's current state; care should be taken
#'to remember individuals at a point in time when their state is valid. A case
#'where this is particularly important is for the spatial location of individuals
#'in continuous-space models. SLiM automatically retains the portions of the
#'genomes that comprise the first generation of any new subpopulation created with
#'addSubpop() that are inherited by extant individuals, for easy recapitation and
#'other analysis (see sections 17.2 and 17.10). However, the individuals of the
#'first generation are not remembered automatically, only their needed genomic
#'information.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqRememberIndividuals <- function(individuals, permanent) {
 .SS$treeSeqRememberIndividuals(individuals, permanent)
}

#'SLiM method treeSeqSimplify
#'
#'Documentation for SLiM function \code{treeSeqSimplify}, which is a method of the
#'SLiM class \code{\link{SLiMSim}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=NA}{SLiM manual: page NA}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases SLiMSim$treeSeqSimplify .SS$treeSeqSimplify
#'@family SLiMSim
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
treeSeqSimplify <- function(void) {
 .SS$treeSeqSimplify(void)
}



#'SLiM method addSubpop
#'
#'Documentation for SLiM function \code{addSubpop}, which is a method of the SLiM
#'class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=678}{SLiM manual: page
#'678}.
#'
#'@param subpopID An object of type integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). The
#'default value is \code{0.5}. See details for description.
#'@param haploid An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Species$addSubpop .Sp$addSubpop
#'@family Species
#'@return An object of type Subpopulation object. Return will be of length 1 (a
#'singleton)
#'@details Add a new subpopulation with id subpopID and size individuals.
#'The subpopID parameter may be either an integer giving the ID of the new
#'subpopulation, or a string giving the name of the new subpopulation (such
#'as "p5" to specify an ID of 5). Only if sex is enabled for the species, the
#'initial sex ratio may optionally be specified as sexRatio (as the male fraction,
#'M:M+F); if it is not specified, a default of 0.5 is used. The new subpopulation
#'will be defined as a global variable immediately by this method (see section
#'24.15), and will also be returned by this method. Subpopulations added by this
#'method will initially consist of individuals with empty genomes. In order to
#'model subpopulations that split from an already existing subpopulation, use
#'addSubpopSplit(). Only in nonWF models, the haploid parameter may be T; in
#'this case, the second genome of each new individual will be a null genome,
#'rather than an empty genome. For even greater control in nonWF models, you can
#'call addSubpop() with an initial size of 0 and then stock the population with
#'new individuals created however you wish in the next tick's reproduction()
#'callback. ject<Subpopulation>$)addSubpopSplit(is$ subpopID, integer$ size,
#'io<Subpopulation>$ sourceSubpop, [float$ sexRatio = 0.5]) Split off a new
#'subpopulation with id subpopID and size individuals derived from subpopulation
#'sourceSubpop. The subpopID parameter may be either an integer giving the ID
#'of the new subpopulation, or a string giving the name of the new subpopulation
#'(such as "p5" to specify an ID of 5). The sourceSubpop parameter may specify the
#'source subpopulation either as a Subpopulation object or by integer identifier.
#'Only if sex is enabled for the species, the initial sex ratio may optionally
#'be specified as sexRatio (as the male fraction, M:M+F); if it is not specified,
#'a default of 0.5 is used. The new subpopulation will be defined as a global
#'variable immediately by this method (see section 24.15), and will also be
#'returned by this method. Subpopulations added by this method will consist of
#'individuals that are clonal copies of individuals from the source subpopulation,
#'randomly chosen with probabilities proportional to fitness. The fitness of all
#'of these initial individuals is considered to be 1.0, to avoid a doubled round
#'of selection in the initial tick, given that fitness values were already used
#'to choose the individuals to clone. Once this initial set of individuals has
#'mated to produce offspring, the model is effectively of parental individuals in
#'the source subpopulation mating randomly according to fitness, as usual in SLiM,
#'with juveniles migrating to the newly added subpopulation. Effectively, then,
#'then new subpopulation is created empty, and is filled by migrating juveniles
#'from the source subpopulation, in accordance with SLiM's usual model of juvenile
#'migration.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addSubpop <- function(subpopID, size, sexRatio, haploid) {
 .Sp$addSubpop(subpopID, size, sexRatio, haploid)
}

#'SLiM method countOfMutationsOfType
#'
#'Documentation for SLiM function \code{countOfMutationsOfType}, which is a method
#'of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=679}{SLiM manual: page
#'679}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Species$countOfMutationsOfType .Sp$countOfMutationsOfType
#'@family Species
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Returns the number of mutations that are of the type specified by
#'mutType, out of all of the mutations that are currently active in the species.
#'If you need a vector of the matching Mutation objects, rather than just a
#'count, use -mutationsOfType(). This method is often used to determine whether an
#'introduced mutation is still active (as opposed to being either lost or fixed).
#'This method is provided for speed; it is much faster than the corresponding
#'Eidos code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
countOfMutationsOfType <- function(mutType) {
 .Sp$countOfMutationsOfType(mutType)
}

#'SLiM method individualsWithPedigreeIDs
#'
#'Documentation for SLiM function \code{individualsWithPedigreeIDs}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=679}{SLiM manual: page
#'679}.
#'
#'@param pedigreeIDs An object of type integer. See details for description.
#'@param subpops An object of type null or integer or Subpopulation object. The
#'default value is \code{NULL}. See details for description.
#'
#'@aliases Species$individualsWithPedigreeIDs .Sp$individualsWithPedigreeIDs
#'@family Species
#'@return An object of type Individual object.
#'@details Looks up individuals by pedigree ID, optionally within
#'specific subpopulations. Pedigree tracking must be turned on with
#'initializeSLiMOptions(keepPedigrees=T) to use this method, otherwise an error
#'will result. This method is vectorized; more than one pedigree id may be
#'passed in pedigreeID, in which case the returned vector will contain all of
#'the individuals for which a match was found (in the same order in which they
#'were supplied). If a given id is not found, the returned vector will contain
#'no entry for that id (so the length of the returned vector may not match the
#'length of pedigreeIDs). If none of the given ids were found, the returned vector
#'will be object<Individual>(0), an empty object vector of class Individual. If
#'you have more than one pedigree ID to look up, calling this method just once,
#'in vectorized fashion, may be much faster than calling it once for each ID,
#'due to internal optimizations. To find individuals within all subpopulations,
#'pass the default of NULL for subpops. If you are interested only in matches
#'within a specific subpopulation, pass that subpopulation for subpops; that will
#'make the search faster. Similarly, if you know that a particular subpopulation
#'is the most likely to contain matches, you should supply that subpopulation
#'first in the subpops vector so that it will be searched first; the supplied
#'subpopulations are searched in order. Subpopulations may be supplied either as
#'integer IDs, or as Subpopulation objects.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
individualsWithPedigreeIDs <- function(pedigreeIDs, subpops) {
 .Sp$individualsWithPedigreeIDs(pedigreeIDs, subpops)
}

#'SLiM method killIndividuals
#'
#'Documentation for SLiM function \code{killIndividuals}, which is a method of the
#'SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=679}{SLiM manual: page
#'679}.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'
#'@aliases Species$killIndividuals .Sp$killIndividuals
#'@family Species
#'@return An object of type void.
#'@details Immediately kills the individuals in individuals. This removes them
#'from their subpopulation and gives them an index value of -1. The Individual
#'objects are not freed immediately, since references to them could still exist
#'in local Eidos variables; instead, the individuals are kept in a temporary
#'"graveyard" until they can be freed safely. It therefore continues to be safe to
#'use them and their genomes, except that accessing their subpopulation property
#'will raise an error since they no longer have a subpopulation. Note that the
#'indices and order of individuals and genomes in all source subpopulations will
#'change unpredictably as a side effect of this method. All evaluated interactions
#'are invalidated as a side effect of calling this method. Note that this method
#'is only for use in nonWF models, in which mortality is managed manually by
#'the model script. In WF models, mortality is managed automatically by the SLiM
#'core when the new offspring generation becomes the parental generation and the
#'previous parental generation dies; mortality does not otherwise occur in WF
#'models. In nonWF models, mortality normally occurs during the survival stage
#'of the tick cycle (see section 23.4), based upon the fitness values calculated
#'by SLiM, and survival() callbacks can influence the outcome of that survival
#'stage. Calls to killIndividuals(), on the other hand, can be made at any time
#'during first(), early(), or late() events, and the result cannot be modified by
#'survival() callbacks; the given individuals are simply immediately killed. This
#'method therefore provides an alternative, and relatively rarely used, mortality
#'mechanism that is disconnected from fitness.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
killIndividuals <- function(individuals) {
 .Sp$killIndividuals(individuals)
}

#'SLiM method mutationCounts
#'
#'Documentation for SLiM function \code{mutationCounts}, which is a method of the
#'SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=680}{SLiM manual: page
#'680}.
#'
#'@param subpops An object of type null or integer or Subpopulation object. See
#'details for description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Species$mutationCounts .Sp$mutationCounts
#'@family Species
#'@return An object of type integer.
#'@details Return an integer vector with the frequency counts of all of the
#'Mutation objects passed in mutations, within the Subpopulation objects in
#'subpops. The subpops argument is required, but you may pass NULL to get
#'population-wide frequency counts. Subpopulations may be supplied either as
#'integer IDs, or as Subpopulation objects. If the optional mutations argument
#'is NULL (the default), frequency counts will be returned for all of the active
#'Mutation objects in the species - the same Mutation objects, and in the same
#'order, as would be returned by the mutations property of sim, in other words.
#'See the -mutationFrequencies() method to obtain float frequencies instead
#'of integer counts. See also the Genome methods mutationCountsInGenomes() and
#'mutationFrequenciesInGenomes().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationCounts <- function(subpops, mutations) {
 .Sp$mutationCounts(subpops, mutations)
}

#'SLiM method mutationFrequencies
#'
#'Documentation for SLiM function \code{mutationFrequencies}, which is a method of
#'the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=680}{SLiM manual: page
#'680}.
#'
#'@param subpops An object of type null or integer or Subpopulation object. See
#'details for description.
#'@param mutations An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Species$mutationFrequencies .Sp$mutationFrequencies
#'@family Species
#'@return An object of type float.
#'@details Return a float vector with the frequencies of all of the Mutation
#'objects passed in mutations, within the Subpopulation objects in subpops. The
#'subpops argument is required, but you may pass NULL to get population-wide
#'frequencies. Subpopulations may be supplied either as integer IDs, or as
#'Subpopulation objects. If the optional mutations argument is NULL (the default),
#'frequencies will be returned for all of the active Mutation objects in the
#'species - the same Mutation objects, and in the same order, as would be returned
#'by the mutations property of sim, in other words. See the -mutationCounts()
#'method to obtain integer counts instead of float frequencies. See also the
#'Genome methods mutationCountsInGenomes() and mutationFrequenciesInGenomes().
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationFrequencies <- function(subpops, mutations) {
 .Sp$mutationFrequencies(subpops, mutations)
}

#'SLiM method mutationsOfType
#'
#'Documentation for SLiM function \code{mutationsOfType}, which is a method of the
#'SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=680}{SLiM manual: page
#'680}.
#'
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases Species$mutationsOfType .Sp$mutationsOfType
#'@family Species
#'@return An object of type Mutation object.
#'@details Returns an object vector of all the mutations that are of the type
#'specified by mutType, out of all of the mutations that are currently active in
#'the species. If you just need a count of the matching Mutation objects, rather
#'than a vector of the matches, use -countOfMutationsOfType(). This method is
#'often used to look up an introduced mutation at a later point in the simulation,
#'since there is no way to keep persistent references to objects in SLiM. This
#'method is provided for speed; it is much faster than the corresponding Eidos
#'code.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
mutationsOfType <- function(mutType) {
 .Sp$mutationsOfType(mutType)
}

#'SLiM method outputFixedMutations
#'
#'Documentation for SLiM function \code{outputFixedMutations}, which is a method
#'of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=680}{SLiM manual: page
#'680}.
#'
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Species$outputFixedMutations .Sp$outputFixedMutations
#'@family Species
#'@return An object of type void.
#'@details Output all fixed mutations - all Substitution objects, in other words
#'(see section 1.5.2) - in a SLiM native format (see section 26.1.2 for output
#'format details). If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos's output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T.
#'Mutations which have fixed but have not been turned into Substitution objects
#'- typically because convertToSubstitution has been set to F for their mutation
#'type (see section 24.11.1) - are not output; they are still considered to be
#'segregating mutations by SLiM. In SLiM 3.3 and later, the output format includes
#'the nucleotides associated with any nucleotide-based mutations; see section
#'26.1.2. Output is generally done in a late() event, so that the output reflects
#'the state of the simulation at the end of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputFixedMutations <- function(filePath, append) {
 .Sp$outputFixedMutations(filePath, append)
}

#'SLiM method outputFull
#'
#'Documentation for SLiM function \code{outputFull}, which is a method of the SLiM
#'class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=681}{SLiM manual: page
#'681}.
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
#'@param pedigreeIDs An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'
#'@aliases Species$outputFull .Sp$outputFull
#'@family Species
#'@return An object of type void.
#'@details Output the state of the entire population (see section 26.1.1 for
#'output format details). If the optional parameter filePath is NULL (the
#'default), output will be sent to Eidos's output stream (see section 4.2.1).
#'Otherwise, output will be sent to the filesystem path specified by filePath,
#'overwriting that file if append if F, or appending to the end of it if append
#'is T. When writing to a file, a logical flag, binary, may be supplied as well.
#'If binary is T, the population state will be written as a binary file instead
#'of a text file (binary data cannot be written to the standard output stream).
#'The binary file is usually smaller, and in any case will be read much faster
#'than the corresponding text file would be read. Binary files are not guaranteed
#'to be portable between platforms; in other words, a binary file written on one
#'machine may not be readable on a different machine (but in practice it usually
#'will be, unless the platforms being used are fairly unusual). If binary is
#'F (the default), a text file will be written. Beginning with SLiM 2.3, the
#'spatialPositions parameter may be used to control the output of the spatial
#'positions of individuals in species for which continuous space has been enabled
#'using the dimensionality option of initializeSLiMOptions(). If spatialPositions
#'is F, the output will not contain spatial positions, and will be identical to
#'the output generated by SLiM 2.1 and later. If spatialPositions is T, spatial
#'position information will be output if it is available (see section 26.1.1
#'for format details). If the species does not have continuous space enabled,
#'the spatialPositions parameter will be ignored. Positional information may
#'be output for all output destinations - the Eidos output stream, a text file,
#'or a binary file. Beginning with SLiM 3.0, the ages parameter may be used to
#'control the output of the ages of individuals in nonWF simulations. If ages is
#'F, the output will not contain ages, preserving backward compatibility with the
#'output format of SLiM 2.1 and later. If ages is T, ages will be output for nonWF
#'models (see section 26.1.1 for format details). In WF simulations, the ages
#'parameter will be ignored. Beginning with SLiM 3.3, the ancestralNucleotides
#'parameter may be used to control the output of the ancestral nucleotide
#'sequence in nucleotide-based models (see section 26.1.1 for format details).
#'If ancestralNucleotides is F, the output will not contain ancestral nucleotide
#'information, and so the ancestral sequence will not be restored correctly if the
#'saved file is loaded with readPopulationFile(). This option is provided because
#'the ancestral sequence may be quite large, for models with a long chromosome
#'(e.g., 1 GB if the chromosome is 109 bases long, when saved in text format, or
#'0.25 GB when saved in binary format). If the model is not nucleotide-based (as
#'enabled with the nucleotideBased parameter to initializeSLiMOptions()), the
#'ancestralNucleotides parameter will be ignored. Note that in nucleotide-based
#'models the output format will always include the nucleotides associated with
#'any nucleotide-based mutations; the ancestralNucleotides flag governs only
#'the ancestral sequence. Beginning with SLiM 3.5, the pedigreeIDs parameter
#'may be used to request that pedigree IDs be written out (and read in by
#'readFromPopulationFile(), subsequently). This option is turned off (F)
#'by default, to preserve backward compatibility; if it is turned on (T),
#'different file version values will be used, and backward compatibility with
#'previous versions of SLiM will be lost (see section 26.1.1). This option
#'may only be used if SLiM's optional pedigree tracking has been enabled with
#'initializeSLiMOptions(keepPedigrees=T). Output is generally done in a late()
#'event, so that the output reflects the state of the simulation at the end of a
#'tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputFull <- function(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides, pedigreeIDs) {
 .Sp$outputFull(filePath, binary, append, spatialPositions, ages,
ancestralNucleotides, pedigreeIDs)
}

#'SLiM method outputMutations
#'
#'Documentation for SLiM function \code{outputMutations}, which is a method of the
#'SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=682}{SLiM manual: page
#'682}.
#'
#'@param mutations An object of type Mutation object. See details for description.
#'@param filePath An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param append An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'
#'@aliases Species$outputMutations .Sp$outputMutations
#'@family Species
#'@return An object of type void.
#'@details Output all of the given mutations (see section 26.1.3 for output
#'format details). This can be used to output all mutations of a given mutation
#'type, for example. If the optional parameter filePath is NULL (the default),
#'output will be sent to Eidos's output stream (see section 4.2.1). Otherwise,
#'output will be sent to the filesystem path specified by filePath, overwriting
#'that file if append if F, or appending to the end of it if append is T. In SLiM
#'3.3 and later, the output format includes the nucleotides associated with any
#'nucleotide-based mutations; see section 26.1.3. Output is generally done in a
#'late() event, so that the output reflects the state of the simulation at the end
#'of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
outputMutations <- function(mutations, filePath, append) {
 .Sp$outputMutations(mutations, filePath, append)
}

#'SLiM method readFromPopulationFile
#'
#'Documentation for SLiM function \code{readFromPopulationFile}, which is a method
#'of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=682}{SLiM manual: page
#'682}.
#'
#'@param filePath An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param subpopMap An object of type null. Must be of length 1 (a singleton). The
#'default value is \code{NULL}. See details for description.
#'
#'@aliases Species$readFromPopulationFile .Sp$readFromPopulationFile
#'@family Species
#'@return An object of type integer. Return will be of length 1 (a singleton)
#'@details Read from a population initialization file, whether in text or binary
#'format as previously specified to outputFull(), and return the tick counter
#'value represented by the file's contents (i.e., the tick at which the file was
#'generated). Although this is most commonly used to set up initial populations
#'(often in an Eidos event set to run in tick 1, immediately after simulation
#'initialization), it may be called in any early() or late() Eidos event; the
#'current state of all populations in the target species will be wiped and
#'replaced by the state in the file at filePath. All Eidos variables that are of
#'type object and have element type Subpopulation, Genome, Mutation, Individual,
#'or Substitution will be removed as a side effect of this method if they contain
#'any element that belongs to the target species, because those objects will no
#'longer exist in the SLiM simulation; if you want to preserve any of that state,
#'you should output it or save it to a file prior to this call. New symbols will
#'be defined to refer to the new Subpopulation objects loaded from the file. If
#'the file being read was written by a version of SLiM prior to 2.3, then for
#'backward compatibility fitness values will be calculated immediately for any
#'new subpopulations created by this call, which will trigger the calling of any
#'activated and applicable mutationEffect() and fitnessEffect() callbacks. When
#'reading files written by SLiM 2.3 or later, fitness values are not calculated as
#'a side effect of this call (because the simulation will often need to evaluate
#'interactions or modify other state prior to doing so). In SLiM 2.3 and later
#'when using the WF model, calling readFromPopulationFile() from any context
#'other than a late() event causes a warning; calling from a late() event is
#'almost always correct in WF models, so that fitness values can be automatically
#'recalculated by SLiM at the usual time in the tick cycle without the need to
#'force their recalculation (see chapter 22, and comments on recalculateFitness()
#'below). In SLiM 3.0 when using the nonWF model, calling readFromPopulationFile()
#'from any context other than an early() event causes a warning; calling from an
#'early() event is almost always correct in nonWF models, so that fitness values
#'can be automatically recalculated by SLiM at the usual time in the tick cycle
#'without the need to force their recalculation (see chapter 23, and comments
#'on recalculateFitness() below). As of SLiM 2.1, this method changes the tick
#'and cycle counters to the tick and cycle read from the file. If you do not
#'want these counters to be changed, you can change them back after reading,
#'by setting community.tick and sim.cycle to whatever values you wish. Note
#'that restoring a saved past state and running forward again will not yield
#'the same simulation results, because the random number generator's state will
#'not be the same; to ensure reproducibility from a given time point, setSeed()
#'can be used to establish a new seed value. Any changes made to structure of
#'the species (mutation types, genomic element types, etc.) will not be wiped
#'and re-established by readFromPopulationFile(); this method loads only the
#'population's state, not the species configuration, so care should be taken
#'to ensure that the species structure meshes coherently with the loaded data.
#'Indeed, state such as the selfing and cloning rates of subpopulations, values
#'set into tag properties, and values set onto objects with setValue() will also
#'be lost, since it is not saved out by outputFull(). Only information saved by
#'outputFull() will be restored; all other state associated with the species -
#'subpopulations, individuals, genomes, mutations, and substitutions - will be
#'lost, and should be re-established by the model if it is still needed. As of
#'SLiM 2.3, this method will read and restore the spatial positions of individuals
#'if that information is present in the output file and the species has enabled
#'continuous space (see outputFull() for details). If spatial positions are
#'present in the output file but the species has not enabled continuous space
#'(or the number of spatial dimensions does not match), an error will result. If
#'the species has enabled continuous space but spatial positions are not present
#'in the output file, the spatial positions of the individuals read will be
#'undefined, but an error is not raised. As of SLiM 3.0, this method will read
#'and restore the ages of individuals if that information is present in the output
#'file and the simulation is based upon the nonWF model. If ages are present but
#'the simulation uses a WF model, an error will result; the WF model does not use
#'age information. If ages are not present but the simulation uses a nonWF model,
#'an error will also result; the nonWF model requires age information. As of SLiM
#'3.3, this method will restore the nucleotides of nucleotide-based mutations, and
#'will restore the ancestral nucleotide sequence, if that information is present
#'in the output file. Loading an output file that contains nucleotide information
#'in a non-nucleotide-based model, and vice versa, will produce an error. As of
#'SLiM 3.5, this method will read and restore the pedigree IDs of individuals and
#'genomes if that information is present in the output file (as requested with
#'outputFull(pedigreeIDs=T)) and if SLiM's optional pedigree tracking has been
#'enabled with initializeSLiMOptions(keepPedigrees=T). This method can also be
#'used to read tree-sequence (.trees) files saved by treeSeqOutput() or generated
#'by the Python pyslim package. Beginning with SLiM 4, the subpopMap parameter may
#'be supplied to re-order the populations of the input tree sequence when it is
#'loaded in to SLiM. This parameter must have a value that is a Dictionary; the
#'keys of this dictionary should be SLiM population identifiers as string values
#'(e.g., "p2"), and the values should be indexes of populations in the input
#'tree sequence; a key/value pair of "p2", 4 would mean that the fifth population
#'in the input (the one at zero-based index 4) should become p2 on loading into
#'SLiM. If subpopMap is non- NULL, all populations in the tree sequence must be
#'explicitly mapped, even if their index will not change and even if they will not
#'be used by SLiM; the only exception is for unused slots in the population table,
#'which can be explicitly remapped but do not have to be. For instance, suppose
#'we have a tree sequence in which population 0 is unused, population 1 is not a
#'SLiM population (for example, an ancestral population produced by msprime), and
#'population 2 is a SLiM population, and we want to load this in with population 2
#'as p0 in SLiM. To do this, we could supply a value of Dictionary("p0", 2, "p1",
#'1, "p2", 0) for subpopMap, or we could leave out slot 0 since it is unused,
#'with Dictionary("p0", 2, "p1", 1). Although this facility cannot be used to
#'remove populations in the tree sequence, note that it may add populations that
#'will be visible when treeSeqOutput() is called (although these will not be SLiM
#'populations); if, in this example, we had used Dictionary("p0", 0, "p1", 1,
#'"p5", 2) and then we wrote the result out with treeSeqOutput(), the resulting
#'tree sequence would have six populations, although three of them would be empty
#'and would not be used by SLiM. The use of subpopMap makes it easier to load
#'simulation data that was generated in Python, since that typically uses an
#'id of 0. The subpopMap parameter may not be used with file formats other than
#'tree-sequence files, at the present time; setting up the correct subpopulation
#'ids is typically easier when working with those other formats. Note the
#'tskit command-line interface can be used, like python3 -m tskit populations
#'file.trees, to find out the number of subpopulations in a tree-sequence file and
#'their IDs. When loading a tree sequence, a crosscheck of the loaded data will
#'be performed to ensure that the tree sequence was well-formed and was loaded
#'correctly. When running a Release build of SLiM, however, this crosscheck will
#'only occur the first time that readFromPopulationFile() is called to load a tree
#'sequence; subsequent calls will not perform this crosscheck, for greater speed
#'when running models that load saved population state many times (such as models
#'that are conditional on fixation). If you suspect that a tree sequence file
#'might be corrupted or read incorrectly, running a Debug build of SLiM enables
#'crosschecks after every load.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
readFromPopulationFile <- function(filePath, subpopMap) {
 .Sp$readFromPopulationFile(filePath, subpopMap)
}

#'SLiM method recalculateFitness
#'
#'Documentation for SLiM function \code{recalculateFitness}, which is a method of
#'the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=684}{SLiM manual: page
#'684}.
#'
#'@param tick An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Species$recalculateFitness .Sp$recalculateFitness
#'@family Species
#'@return An object of type void.
#'@details Force an immediate recalculation of fitness values for all individuals
#'in all subpopulations. Normally fitness values are calculated at a fixed
#'point in each tick, and those values are cached and used until the next
#'recalculation. If simulation parameters are changed in script in a way that
#'affects fitness calculations, and if you wish those changes to take effect
#'immediately rather than taking effect at the next automatic recalculation, you
#'may call recalculateFitness() to force an immediate recalculation and recache.
#'The optional parameter tick provides the tick for which mutationEffect() and
#'fitnessEffect() callbacks should be selected; if it is NULL (the default),
#'the current tick value for the simulation, community.tick, is used. If you
#'call recalculateFitness() in an early() event in a WF model, you may wish
#'this to be community.tick - 1 in order to utilize the mutationEffect() and
#'fitnessEffect() callbacks for the previous tick, as if the changes that you have
#'made to fitness- influencing parameters were already in effect at the end of the
#'previous tick when the new generation was first created and evaluated (usually
#'it is simpler to just make such changes in a late() event instead, however, in
#'which case calling recalculateFitness() is probably not necessary at all since
#'fitness values will be recalculated immediately afterwards). Regardless of the
#'value supplied for tick here, community.tick inside callbacks will report the
#'true tick number, so if your callbacks consult that parameter in order to create
#'tick-specific fitness effects you will need to handle the discrepancy somehow.
#'(Similar considerations apply for nonWF models that call recalculateFitness()
#'in a late() event, which is also not advisable in general.) After this call,
#'the fitness values used for all purposes in SLiM will be the newly calculated
#'values. Calling this method will trigger the calling of any enabled and
#'applicable mutationEffect() and fitnessEffect() callbacks, so this is quite a
#'heavyweight operation; you should think carefully about what side effects might
#'result (which is why fitness recalculation does not just occur automatically
#'after changes that might affect fitness values).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
recalculateFitness <- function(tick) {
 .Sp$recalculateFitness(tick)
}

#'SLiM method registerFitnessEffectCallback
#'
#'Documentation for SLiM function \code{registerFitnessEffectCallback}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=684}{SLiM manual: page
#'684}.
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
#'@aliases Species$registerFitnessEffectCallback .Sp$registerFitnessEffectCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos fitnessEffect() callback in the current
#'simulation (specific to the target species), with an optional subpopulation
#'subpop (which may be an integer identifier, or NULL, the default, to indicate
#'all subpopulations), and optional start and end ticks all limiting its
#'applicability. The script block will be given identifier id (specified as an
#'integer, or as a string symbolic name such as "s5"); this may be NULL if there
#'is no need to be able to refer to the block later. The registered callback is
#'added to the end of the list of registered SLiMEidosBlock objects, and is active
#'immediately; it may be eligible to execute in the current tick (see section
#'25.11 for details). The new SLiMEidosBlock will be defined as a global variable
#'immediately by this method (see section 24.12), and will also be returned by
#'this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerFitnessEffectCallback <- function(id, source, subpop, start, end) {
 .Sp$registerFitnessEffectCallback(id, source, subpop, start, end)
}

#'SLiM method registerMateChoiceCallback
#'
#'Documentation for SLiM function \code{registerMateChoiceCallback}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=684}{SLiM manual: page
#'684}.
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
#'@aliases Species$registerMateChoiceCallback .Sp$registerMateChoiceCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mateChoice() callback in the current simulation
#'(specific to the target species), with optional subpopulation subpop (which may
#'be an integer identifier, or NULL, the default, to indicate all subpopulations)
#'and optional start and end ticks all limiting its applicability. The script
#'block will be given identifier id (specified as an integer, or as a string
#'symbolic name such as "s5"); this may be NULL if there is no need to be able
#'to refer to the block later. The registered callback is added to the end of the
#'list of registered SLiMEidosBlock objects, and is active immediately; it may be
#'eligible to execute in the current tick (see section 25.11 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.12), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMateChoiceCallback <- function(id, source, subpop, start, end) {
 .Sp$registerMateChoiceCallback(id, source, subpop, start, end)
}

#'SLiM method registerModifyChildCallback
#'
#'Documentation for SLiM function \code{registerModifyChildCallback}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=685}{SLiM manual: page
#'685}.
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
#'@aliases Species$registerModifyChildCallback .Sp$registerModifyChildCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos modifyChild() callback in the current simulation
#'(specific to the target species), with optional subpopulation subpop (which may
#'be an integer identifier, or NULL, the default, to indicate all subpopulations)
#'and optional start and end ticks all limiting its applicability. The script
#'block will be given identifier id (specified as an integer, or as a string
#'symbolic name such as "s5"); this may be NULL if there is no need to be able
#'to refer to the block later. The registered callback is added to the end of the
#'list of registered SLiMEidosBlock objects, and is active immediately; it may be
#'eligible to execute in the current tick (see section 25.11 for details). The new
#'SLiMEidosBlock will be defined as a global variable immediately by this method
#'(see section 24.12), and will also be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerModifyChildCallback <- function(id, source, subpop, start, end) {
 .Sp$registerModifyChildCallback(id, source, subpop, start, end)
}

#'SLiM method registerMutationCallback
#'
#'Documentation for SLiM function \code{registerMutationCallback}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=685}{SLiM manual: page
#'685}.
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
#'@aliases Species$registerMutationCallback .Sp$registerMutationCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mutation() callback in the current simulation
#'(specific to the target species), with an optional mutation type mutType
#'(which may be an integer mutation type identifier, or NULL, the default,
#'to indicate all mutation types - see section 25.9), optional subpopulation
#'subpop (which may also be an integer identifier, or NULL, the default, to
#'indicate all subpopulations), and optional start and end ticks all limiting its
#'applicability. The script block will be given identifier id (specified as an
#'integer, or as a string symbolic name such as "s5"); this may be NULL if there
#'is no need to be able to refer to the block later. The registered callback is
#'added to the end of the list of registered SLiMEidosBlock objects, and is active
#'immediately; it may be eligible to execute in the current tick (see section
#'25.11 for details). The new SLiMEidosBlock will be defined as a global variable
#'immediately by this method (see section 24.12), and will also be returned by
#'this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMutationCallback <- function(id, source, mutType, subpop, start, end)
{
 .Sp$registerMutationCallback(id, source, mutType, subpop, start, end)
}

#'SLiM method registerMutationEffectCallback
#'
#'Documentation for SLiM function \code{registerMutationEffectCallback}, which is
#'a method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=685}{SLiM manual: page
#'685}.
#'
#'@param id An object of type null or integer or string. Must be of length 1 (a
#'singleton). See details for description.
#'@param source An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'@param subpop An object of type null or integer or Subpopulation object. Must
#'be of length 1 (a singleton). The default value is \code{NULL}. See details for
#'description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases
#'Species$registerMutationEffectCallback .Sp$registerMutationEffectCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos mutationEffect() callback in the current
#'simulation (specific to the target species), with a required mutation
#'type mutType (which may be an integer mutation type identifier), optional
#'subpopulation subpop (which may also be an integer identifier, or NULL, the
#'default, to indicate all subpopulations), and optional start and end ticks
#'all limiting its applicability. The script block will be given identifier id
#'(specified as an integer, or as a string symbolic name such as "s5"); this
#'may be NULL if there is no need to be able to refer to the block later. The
#'registered callback is added to the end of the list of registered SLiMEidosBlock
#'objects, and is active immediately; it may be eligible to execute in the current
#'tick (see section 25.11 for details). The new SLiMEidosBlock will be defined as
#'a global variable immediately by this method (see section 24.12), and will also
#'be returned by this method.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerMutationEffectCallback <- function(id, source, mutType, subpop,
start, end) {
 .Sp$registerMutationEffectCallback(id, source, mutType, subpop, start, end)
}

#'SLiM method registerRecombinationCallback
#'
#'Documentation for SLiM function \code{registerRecombinationCallback}, which is a
#'method of the SLiM class \code{\link{Species}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=685}{SLiM manual: page
#'685}.
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
#'@aliases Species$registerRecombinationCallback .Sp$registerRecombinationCallback
#'@family Species
#'@return An object of type SLiMEidosBlock object. Return will be of length 1 (a
#'singleton)
#'@details Register a block of Eidos source code, represented as the string
#'singleton source, as an Eidos recombination() callback in the current simulation
#'(specific to the target species), with optional subpopulation subpop (which may
#'be an integer identifier, or NULL, the default, to indicate all subpopulations)
#'and optional start and end ticks all limiting its applicability. The script
#'block will be given identifier id (specified as an integer, or as a string
#'symbolic name such as "s5"); this may be NULL if there is no need to be able
#'to refer to the block later. The registered callback is added to the end of
#'the list of registered SLiMEidosBlock objects, and is active immediately; it
#'may be eligible to execute in the current tick (see section 25.11 for details).
#'The new SLiMEidosBlock will be defined as a global variable immediately by
#'this method (see section 24.12), and will also be returned by this method.
#'events mutationEffect() interaction() mateChoice() modifyChild() mutation()
#'recombination() reproduction() survival() 685
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
registerRecombinationCallback <- function(id, source, subpop, start, end) {
 .Sp$registerRecombinationCallback(id, source, subpop, start, end)
}



#'SLiM method addCloned
#'
#'Documentation for SLiM function \code{addCloned}, which is a method of the SLiM
#'class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=691}{SLiM manual: page
#'691}.
#'
#'@param parent An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Subpopulation$addCloned .P$addCloned
#'@family Subpopulation
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parent by
#'clonal reproduction, queues it for addition to the target subpopulation, and
#'returns it. The new offspring will not be visible as a member of the target
#'subpopulation until the end of the offspring generation tick cycle stage.
#'The subpopulation of parent will be used to locate applicable mutation() and
#'modifyChild() callbacks governing the generation of the offspring individual.
#'Note that this method is only for use in nonWF models. See addCrossed() for
#'further general notes on the addition of new offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=691}{SLiM manual: page
#'691}.
#'
#'@param parent1 An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param parent2 An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'@param sex An object of type null or float or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$addCrossed .P$addCrossed
#'@family Subpopulation
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parents
#'by biparental sexual reproduction, queues it for addition to the target
#'subpopulation, and returns it. The new offspring will not be visible as a
#'member of the target subpopulation until the end of the offspring generation
#'tick cycle stage. Attempting to use a newly generated offspring individual
#'as a mate, or to reference it as a member of the target subpopulation in any
#'other way, will result in an error. In most models the returned individual is
#'not used, but it is provided for maximal generality and flexibility. The new
#'offspring individual is generated from parent1 and parent2 by crossing them. In
#'sexual models parent1 must be female and parent2 must be male; in hermaphroditic
#'models, parent1 and parent2 are unrestricted. If parent1 and parent2 are the
#'same individual in a hermaphroditic model, that parent self-fertilizes, or
#'"selfs", to generate the offspring sexually (note this is not the same as
#'clonal reproduction). Such selfing is considered "incidental" by addCrossed(),
#'however; if the preventIncidentalSelfing flag of initializeSLiMOptions() is
#'T, supplying the same individual for parent1 and parent2 is an error (you must
#'check for and prevent incidental selfing if you set that flag in a nonWF model).
#'If non-incidental selfing is desired, addSelfed() should be used instead.
#'The sex parameter specifies the sex of the offspring. A value of NULL means
#'"make the default choice"; in non-sexual models it is the only legal value
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
#'rejection of the proposed child (see section 25.5), a new offspring individual
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=692}{SLiM manual: page
#'692}.
#'
#'@param sex An object of type null or float or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param genome1Null An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param genome2Null An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$addEmpty .P$addEmpty
#'@family Subpopulation
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual with empty genomes (i.e.,
#'containing no mutations), queues it for addition to the target subpopulation,
#'and returns it. The new offspring will not be visible as a member of the
#'target subpopulation until the end of the offspring generation tick cycle
#'stage. No recombination() or mutation() callbacks will be called. The target
#'subpopulation will be used to locate applicable modifyChild() callbacks
#'governing the generation of the offspring individual (unlike the other addX()
#'methods, because there is no parental individual to reference). The offspring
#'is considered to have no parents for the purposes of pedigree tracking. The
#'sex parameter is treated as in addCrossed(). By default - when genome1Null
#'and genome2Null are both NULL - null genomes will be generated instead of
#'empty genomes only in sex-chromosome simulations, where the sex chromosome
#'that is not being simulated is represented by a null genome; otherwise, empty
#'genomes rather than null genomes will be created. This default behavior can be
#'changed by passing T or F for genome1Null or genome2Null, which will force the
#'corresponding offspring genome to be null (T) or non-null (F). The behavior
#'in sex-chromosome simulations cannot be changed, since the presence of null
#'genomes there is dictated by sex, but T or F may be passed as long as it matches
#'what SLiM would do anyway. In all other simulations there is little point in
#'passing F (since that would be the default behavior anyway), but passing T can
#'be used to make one or both genomes be null genomes, which can be useful for,
#'e.g., modeling haploids (for which, by convention, the second genome is usually
#'a null genome in SLiM). Note that this method is only for use in nonWF models.
#'See addCrossed() for further general notes on the addition of new offspring
#'individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
addEmpty <- function(sex, genome1Null, genome2Null) {
 .P$addEmpty(sex, genome1Null, genome2Null)
}

#'SLiM method addRecombinant
#'
#'Documentation for SLiM function \code{addRecombinant}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=693}{SLiM manual: page
#'693}.
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
#'@family Subpopulation
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parental genomes
#'with the speciﬁed crossover breakpoints, queues it for addition to the target
#'subpopulation, and returns it. The new offspring will not be visible as a
#'member of the target subpopulation until the end of the offspring generation
#'tick cycle stage. The target subpopulation will be used to locate applicable
#'mutation() and modifyChild() callbacks governing the generation of the offspring
#'individual (unlike the other addX() methods, because there are potentially up
#'to four parental individuals to reference); recombination() callbacks will not
#'be called by this method. This method is an advanced feature; most models will
#'use addCrossed(), addSelfed(), or addCloned() instead. This method supports
#'several possible conﬁgurations for strand1, strand2, and breaks1 (and the same
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
#'the offspring's subpopulation, since the parental subpopulation is ambiguous
#'in the general case; this behavior differs from the other add...() methods.
#'The sex parameter is interpreted exactly as in addCrossed(); see that method
#'for discussion. If the offspring sex is speciﬁed in any way (i.e., if sex is
#'non-NULL), the strands provided must be compatible with the sex chosen. If the
#'offspring sex is not speciﬁed (i.e., if sex is NULL), the sex will be inferred
#'from the strands provided where possible (when modeling an X or Y chromosome),
#'or will be chosen randomly otherwise (when modeling autosomes); it will not be
#'inferred from the sex of the individuals possessing the parental strands, even
#'when the reproductive mode is essentially clonal from a single parent, since
#'such inference would be ambiguous in the general case. Similarly, the offspring
#'is considered to have no parents for the purposes of pedigree tracking, since
#'there may be more than two "parents" in the general case. When modeling the X or
#'Y, strand1 and strand2 must be X genomes (or NULL), and strand3 and strand4 must
#'both be X genomes or both be Y genomes (or NULL). These semantics allow several
#'uses for addRecombinant(). When all strands are non-NULL, it is similar to
#'addCrossed() except that the recombination breakpoints are speciﬁed explicitly,
#'allowing very precise offspring generation without having to override SLiM's
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
#'bacterial conjugation, for example. Other variations are also possible. The
#'value of the meanParentAge property of the generated offspring is calculated
#'from the mean parent age of each of its two genomes (whether they turn out
#'to be null genomes or not); that may be an average of two values (if both
#'offspring genomes have at least one parent), a single value (if one offspring
#'genome has no parent), or no values (if both offspring genomes have no parent,
#'in which case 0.0 results). The mean parent age of a given offspring genome
#'is the mean of the ages of the parents of the two strands used to generate
#'that offspring genome; if one strand is NULL then the mean parent age for that
#'offspring genome is the age of the parent of the non-NULL strand, while if both
#'strands are NULL then that offspring genome is parentless and is not used in
#'the ﬁnal calculation. In other words, if one offspring genome has two parents
#'with ages A and B, and the other offspring genome has one parent with age C,
#'the meanParentAge of the offspring will be (A+B+C+C) / 4, not (A+B+C) / 3. Note
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=694}{SLiM manual: page
#'694}.
#'
#'@param parent An object of type Individual object. Must be of length 1 (a
#'singleton). See details for description.
#'
#'@aliases Subpopulation$addSelfed .P$addSelfed
#'@family Subpopulation
#'@return An object of type null or Individual object. Return will be of length 1
#'(a singleton)
#'@details Generates a new offspring individual from the given parent by selﬁng,
#'queues it for addition to the target subpopulation, and returns it. The new
#'offspring will not be visible as a member of the target subpopulation until
#'the end of the offspring generation tick cycle stage. The subpopulation of
#'parent will be used to locate applicable mutation(), recombination(), and
#'modifyChild() callbacks governing the generation of the offspring individual.
#'Since selﬁng requires that parent act as a source of both a male and a female
#'gamete, this method may be called only in hermaphroditic models; calling it in
#'sexual models will result in an error. This method represents a non-incidental
#'selﬁng event, so the preventIncidentalSelfing ﬂag of initializeSLiMOptions()
#'has no effect on this method (in contrast to the behavior of addCrossed(), where
#'selﬁng is assumed to be incidental). Note that this method is only for use in
#'nonWF models. See addCrossed() for further general notes on the addition of new
#'offspring individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=694}{SLiM manual: page
#'694}.
#'
#'@param indices An object of type null or integer. See details for description.
#'
#'@aliases Subpopulation$cachedFitness .P$cachedFitness
#'@family Subpopulation
#'@return An object of type float.
#'@details The ﬁtness values calculated for the individuals at the indices
#'given are returned. If NULL is passed, ﬁtness values for all individuals in
#'the subpopulation are returned. The ﬁtness values returned are cached values;
#'mutationEffect() and fitnessEffect() callbacks are therefore not called as a
#'side effect of this method. It is always an error to call cachedFitness() from
#'inside a mutationEffect() or fitnessEffect() callback, since ﬁtness values
#'are in the middle of being set up. In WF models, it is also an error to call
#'cachedFitness() from a late() event, because ﬁtness values for the new offspring
#'generation have not yet been calculated and are undeﬁned. In nonWF models,
#'the population may be a mixture of new and old individuals, so instead, NAN
#'will be returned as the ﬁtness of any new individuals whose ﬁtness has not
#'yet been calculated. When new subpopulations are ﬁrst created with addSubpop()
#'or addSubpopSplit(), the ﬁtness of all of the newly created individuals is
#'considered to be 1.0 until ﬁtness values are recalculated.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=695}{SLiM manual: page
#'695}.
#'
#'@param center An object of type null or float. The default value is \code{NULL}.
#'See details for description.
#'@param scale An object of type null or float. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param color An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$configureDisplay .P$configureDisplay
#'@family Subpopulation
#'@return An object of type void.
#'@details This method customizes the display of the subpopulation in SLiMgui's
#'Population Visualization graph. When this method is called by a model running
#'outside SLiMgui, it will do nothing except type- checking and bounds-checking
#'its arguments. When called by a model running in SLiMgui, the position,
#'size, and color of the subpopulation's displayed circle can be controlled
#'as speciﬁed below. The center parameter sets the coordinates of the center
#'of the subpopulation's displayed circle; it must be a float vector of length
#'two, such that center[0] provides the x-coordinate and center[1] provides the
#'y-coordinate. The square central area of the Population Visualization occupies
#'scaled coordinates in [0,1] for both x and y, so the values in center must
#'be within those bounds. If a value of NULL is provided, SLiMgui's default
#'center will be used (which currently arranges subpopulations in a circle).
#'The scale parameter sets a scaling factor to be applied to the radius of the
#'subpopulation's displayed circle. The default radius used by SLiMgui is a
#'function of the subpopulation's number of individuals; this default radius is
#'then multiplied by scale. If a value of NULL is provided, the default radius
#'will be used; this is equivalent to supplying a scale of 1.0. Typically the
#'same scale value should be used by all subpopulations, to scale all of their
#'circles up or down uniformly, but that is not required. The color parameter
#'sets the color to be used for the displayed subpopulation's circle. Colors may
#'be speciﬁed by name, or with hexadecimal RGB values of the form "#RRGGBB" (see
#'the Eidos manual). If color is NULL or the empty string, "", SLiMgui's default
#'(ﬁtness-based) color will be used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=695}{SLiM manual: page
#'695}.
#'
#'@param name An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param spatiality An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param values An object of type numeric. See details for description.
#'@param interpolate An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param valueRange An object of type null or integer or float. The default value
#'is \code{NULL}. See details for description.
#'@param colors An object of type null or string. The default value is
#'\code{NULL}. See details for description.
#'
#'@aliases Subpopulation$defineSpatialMap .P$defineSpatialMap
#'@family Subpopulation
#'@return An object of type void.
#'@details Deﬁnes a spatial map for the subpopulation. The map will henceforth
#'be identiﬁed by name. The map uses the spatial dimensions referenced by
#'spatiality, which must be a subset of the dimensions deﬁned for the simulation
#'in initializeSLiMOptions(). Spatiality "x" is permitted for dimensionality
#'"x"; spatiality "x", "y", or "xy" for dimensionality "xy"; and spatiality "x",
#'"y", "z", "xy", "yz", "xz", or "xyz" for dimensionality "xyz". The spatial
#'map is deﬁned by a grid of values supplied in parameter values. The remaining
#'optional parameters are described below. Note that the semantics of this method
#'changed in SLiM 3.5; in particular, the gridSize parameter was removed, and
#'the interpretation of the values parameter changed as described below. Existing
#'code written prior to SLiM 3.5 will produce an error, due to the removed
#'gridSize parameter, and must be revised carefully to obtain the same result,
#'even if NULL had been passed for gridSize previously. Beginning in SLiM 3.5,
#'the values parameter must be a vector/matrix/array with the number of dimensions
#'appropriate for the declared spatiality of the map; for example, a map with
#'spatiality "x" would require a (one-dimensional) vector, spatiality "xy" would
#'require a (two-dimensional) matrix, and a map with spatiality of "xyz" would
#'require a three-dimensional array. (See the Eidos manual for discussion of
#'vectors, matrices, and arrays.) The data in values is interpreted in such a way
#'that a two-dimensional matrix of values, with (0, 0) at upper left and values
#'by column, is transformed into the format expected by SLiM, with (0, 0) at lower
#'left and values by row; in other words, the two- dimensional matrix as it prints
#'in the Eidos console will match the appearance of the two-dimensional spatial
#'map as seen in SLiMgui. This is a change in behavior from versions prior to SLiM
#'3.5; it ensures that images loaded from disk with the Eidos class Image can be
#'used directly as spatial maps, achieving the expected orientation, with no need
#'for transposition or ﬂipping. If the spatial map is a three-dimensional array,
#'it is read as successive z-axis "planes", each of which is a two-dimensional
#'matrix that is treated as described above. Moving on to the other parameters of
#'defineSpatialMap(): if interpolate is F, values across the spatial map are not
#'interpolated; the value at a given point is equal to the nearest value deﬁned
#'by the grid of values speciﬁed. If interpolate is T, values across the spatial
#'map will be interpolated (using linear, bilinear, or trilinear interpolation
#'as appropriate) to produce spatially continuous variation in values. In either
#'case, the corners of the value grid are exactly aligned with the corners of the
#'spatial boundaries of the subpopulation as speciﬁed by setSpatialBoundary(), and
#'the value grid is then stretched across the spatial extent of the subpopulation
#'in such a manner as to produce equal spacing between the values along each
#'dimension. The setting of interpolation only affects how values between these
#'grid points are calculated: by nearest-neighbor, or by linear interpolation.
#'Interpolation of spatial maps with periodic boundaries is not handled specially;
#'to ensure that the edges of a periodic spatial map join smoothly, simply ensure
#'that the grid values at the edges of the map are identical, since they will be
#'coincident after periodic wrapping. The valueRange and colors parameters travel
#'together; either both are unspeciﬁed, or both are speciﬁed. They control how map
#'values will be transformed into colors, by SLiMgui and by the spatialMapColor()
#'method. The valueRange parameter establishes the color-mapped range of spatial
#'map values, as a vector of length two specifying a minimum and maximum; this
#'does not need to match the actual range of values in the map. The colors
#'parameter then establishes the corresponding colors for values within the
#'interval deﬁned by valueRange: values less than or equal to valueRange[0] will
#'map to colors[0], values greater than or equal to valueRange[1] will map to the
#'last colors value, and intermediate values will shade continuously through the
#'speciﬁed vector of colors, with interpolation between adjacent colors to produce
#'a continuous spectrum. This is much simpler than it sounds in this description;
#'see the recipes in chapter 15 for an illustration of its use. Note that at
#'present, SLiMgui will only display spatial maps of spatiality "x", "y", or
#'"xy"; the color- mapping parameters will simply be ignored by SLiMgui for other
#'spatiality values (even if the spatiality is a superset of these values; SLiMgui
#'will not attempt to display an "xyz" spatial map, for example, since it has no
#'way to choose which 2D slice through the xyz space it ought to display). The
#'spatialMapColor() method will return translated color strings for any spatial
#'map, however, even if SLiMgui is unable to display the spatial map. If there are
#'multiple spatial maps that SLiMgui is capable of displaying, it choose one for
#'display by default, but other maps may be selected from the context menu on the
#'individuals view (with a right-click or control-click).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
defineSpatialMap <- function(name, spatiality, values, interpolate,
valueRange, colors) {
 .P$defineSpatialMap(name, spatiality, values, interpolate, valueRange,
colors)
}

#'SLiM method outputMSSample
#'
#'Documentation for SLiM function \code{outputMSSample}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=696}{SLiM manual: page
#'696}.
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
#'@family Subpopulation
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in MS format (see
#'section 26.2.2 for output format details). Positions in the output will span
#'the interval [0,1]. A sample of genomes (not entire individuals, note) of
#'size sampleSize from the subpopulation will be output. The sample may be done
#'either with or without replacement, as speciﬁed by replace; the default is to
#'sample with replacement. A particular sex of individuals may be requested for
#'the sample, for simulations in which sex is enabled, by passing "M" or "F" for
#'requestedSex; passing "*", the default, indicates that genomes from individuals
#'should be selected randomly, without respect to sex. If the sampling options
#'provided by this method are not adequate, see the outputMS() method of Genome
#'for a more ﬂexible low-level option. If the optional parameter filePath is NULL
#'(the default), output will be sent to Eidos's output stream (see section 4.2.1).
#'Otherwise, output will be sent to the ﬁlesystem path speciﬁed by filePath,
#'overwriting that ﬁle if append if F, or appending to the end of it if append is
#'T. If filterMonomorphic is F (the default), all mutations that are present in
#'the sample will be included in the output. This means that some mutations may
#'be included that are actually monomorphic within the sample (i.e., that exist
#'in every sampled genome, and are thus apparently ﬁxed). These may be ﬁltered
#'out with filterMonomorphic = T if desired; note that this option means that
#'some mutations that do exist in the sampled genomes might not be included in the
#'output, simply because they exist in every sampled genome. See outputSample()
#'and outputVCFSample() for other output formats. Output is generally done in a
#'late() event, so that the output reﬂects the state of the simulation at the end
#'of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=697}{SLiM manual: page
#'697}.
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
#'@family Subpopulation
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in SLiM's native format
#'(see section 26.2.1 for output format details). A sample of genomes (not entire
#'individuals, note) of size sampleSize from the subpopulation will be output. The
#'sample may be done either with or without replacement, as speciﬁed by replace;
#'the default is to sample with replacement. A particular sex of individuals may
#'be requested for the sample, for simulations in which sex is enabled, by passing
#'"M" or "F" for requestedSex; passing "*", the default, indicates that genomes
#'from individuals should be selected randomly, without respect to sex. If the
#'sampling options provided by this method are not adequate, see the output()
#'method of Genome for a more ﬂexible low-level option. If the optional parameter
#'filePath is NULL (the default), output will be sent to Eidos's output stream
#'(see section 4.2.1). Otherwise, output will be sent to the ﬁlesystem path
#'speciﬁed by filePath, overwriting that ﬁle if append if F, or appending to the
#'end of it if append is T. See outputMSSample() and outputVCFSample() for other
#'output formats. Output is generally done in a late() event, so that the output
#'reﬂects the state of the simulation at the end of a tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=697}{SLiM manual: page
#'697}.
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
#'@family Subpopulation
#'@return An object of type void.
#'@details Output a random sample from the subpopulation in VCF format (see
#'sections 26.2.3 and 26.2.4 for output format details). A sample of individuals
#'(not genomes, note - unlike the outputSample() and outputMSSample() methods) of
#'size sampleSize from the subpopulation will be output. The sample may be done
#'either with or without replacement, as speciﬁed by replace; the default is to
#'sample with replacement. A particular sex of individuals may be requested for
#'the sample, for simulations in which sex is enabled, by passing "M" or "F" for
#'requestedSex; passing "*", the default, indicates that genomes from individuals
#'should be selected randomly, without respect to sex. If the sampling options
#'provided by this method are not adequate, see the outputVCF() method of Genome
#'for a more ﬂexible low-level option. If the optional parameter filePath is
#'NULL (the default), output will be sent to Eidos's output stream (see section
#'4.2.1). Otherwise, output will be sent to the ﬁlesystem path speciﬁed by
#'filePath, overwriting that ﬁle if append if F, or appending to the end of
#'it if append is T. The parameters outputMultiallelics, simplifyNucleotides,
#'and outputNonnucleotides affect the format of the output produced; see
#'sections 26.2.3 and 26.2.4 for further discussion. See outputMSSample() and
#'outputSample() for other output formats. Output is generally done in a late()
#'event, so that the output reﬂects the state of the simulation at the end of a
#'tick.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=697}{SLiM manual: page
#'697}.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointInBounds .P$pointInBounds
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=697}{SLiM manual: page
#'697}.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointPeriodic .P$pointPeriodic
#'@family Subpopulation
#'@return An object of type float.
#'@details Returns a revised version of point that has been brought inside
#'the periodic spatial boundaries of the subpopulation (as speciﬁed by the
#'periodicity parameter of initializeSLiMOptions()) by wrapping around periodic
#'spatial boundaries. In brief, if a coordinate of point lies beyond a periodic
#'spatial boundary, that coordinate is wrapped around the boundary, so that it
#'lies inside the spatial extent by the same magnitude that it previously lay
#'outside, but on the opposite side of the space; in effect, the two edges of
#'the periodic spatial boundary are seamlessly joined. This is done iteratively
#'until all coordinates lie inside the subpopulation's periodic boundaries. Note
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=698}{SLiM manual: page
#'698}.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointReflected .P$pointReflected
#'@family Subpopulation
#'@return An object of type float.
#'@details Returns a revised version of point that has been brought inside the
#'spatial boundaries of the subpopulation by reﬂection. In brief, if a coordinate
#'of point lies beyond a spatial boundary, that coordinate is reﬂected across
#'the boundary, so that it lies inside the boundary by the same magnitude
#'that it previously lay outside the boundary. This is done iteratively until
#'all coordinates lie inside the subpopulation's boundaries. This method
#'is useful for implementing reﬂecting boundary conditions. This may only
#'be called in simulations for which continuous space has been enabled with
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=698}{SLiM manual: page
#'698}.
#'
#'@param point An object of type float. See details for description.
#'
#'@aliases Subpopulation$pointStopped .P$pointStopped
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=698}{SLiM manual: page
#'698}.
#'
#'@param n An object of type integer. Must be of length 1 (a singleton). The
#'default value is \code{1}. See details for description.
#'
#'@aliases Subpopulation$pointUniform .P$pointUniform
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=698}{SLiM manual: page
#'698}.
#'
#'@param void An object of type . See details for description.
#'
#'@aliases Subpopulation$removeSubpopulation .P$removeSubpopulation
#'@family Subpopulation
#'@return An object of type void.
#'@details Removes this subpopulation from the model. The subpopulation is
#'immediately removed from the list of active subpopulations, and the symbol
#'representing the subpopulation is undeﬁned. The subpopulation object itself
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=699}{SLiM manual: page
#'699}.
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
#'@family Subpopulation
#'@return An object of type Individual object.
#'@details Returns a vector of individuals, of size less than or equal to
#'parameter size, sampled from the individuals in the target subpopulation.
#'Sampling is done without replacement if replace is F (the default), or with
#'replacement if replace is T. The remaining parameters specify constraints
#'upon the pool of individuals that will be considered candidates for the
#'sampling. Parameter exclude, if non- NULL, may specify a speciﬁc individual
#'that should not be considered a candidate (typically the focal individual in
#'some operation). Parameter sex, if non-NULL, may specify a sex ("M" or "F")
#'for the individuals to be drawn, in sexual models. Parameter tag, if non-NULL,
#'may specify a tag value for the individuals to be drawn. Parameters minAge and
#'maxAge, if non-NULL, may specify a minimum or maximum age for the individuals
#'to be drawn, in nonWF models. Parameter migrant, if non-NULL, may specify a
#'required value for the migrant property of the individuals to be drawn (so
#'T will require that individuals be migrants, F will require that they not
#'be). If the candidate pool is smaller than the requested sample size, all
#'eligible candidates will be returned (in randomized order); the result will be
#'a zero-length vector if no eligible candidates exist (unlike sample()). This
#'method is similar to getting the individuals property of the subpopulation,
#'using operator [] to select only individuals with the desired properties, and
#'then using sample() to sample from that candidate pool. However, besides being
#'much simpler than the equivalent Eidos code, it is also much faster, and it does
#'not fail if less than the full sample size is available. See subsetIndividuals()
#'for a similar method that returns a full subset, rather than a sample.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=699}{SLiM manual: page
#'699}.
#'
#'@param rate An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setCloningRate .P$setCloningRate
#'@family Subpopulation
#'@return An object of type void.
#'@details Set the cloning rate of this subpopulation. The rate is changed to
#'rate, which should be between 0.0 and 1.0, inclusive. Clonal reproduction can
#'be enabled in both non-sexual (i.e. hermaphroditic) and sexual simulations. In
#'non-sexual simulations, rate must be a singleton value representing the overall
#'clonal reproduction rate for the subpopulation. In sexual simulations, rate
#'may be either a singleton (specifying the clonal reproduction rate for both
#'sexes) or a vector containing two numeric values (the female and male cloning
#'rates speciﬁed separately, at indices 0 and 1 respectively). During mating and
#'offspring generation, the probability that any given offspring individual will
#'be generated by cloning - by asexual reproduction without gametes or meiosis -
#'will be equal to the cloning rate (for its sex, in sexual simulations) set in
#'the parental (not the offspring!) subpopulation.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=699}{SLiM manual: page
#'699}.
#'
#'@param sourceSubpops An object of type integer or Subpopulation object. See
#'details for description.
#'@param rates An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setMigrationRates .P$setMigrationRates
#'@family Subpopulation
#'@return An object of type void.
#'@details Set the migration rates to this subpopulation from the subpopulations
#'in sourceSubpops to the corresponding rates speciﬁed in rates; in other words,
#'rates gives the expected fractions of the children in this subpopulation that
#'will subsequently be generated from parents in the subpopulations sourceSubpops
#'(see section 22.2.1). This method will only set the migration fractions from
#'the subpopulations given; migration rates from other subpopulations will be
#'left unchanged (explicitly set a zero rate to turn off migration from a given
#'subpopulation). The type of sourceSubpops may be either integer, specifying
#'subpopulations by identiﬁer, or object, specifying subpopulations directly.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=699}{SLiM manual: page
#'699}.
#'
#'@param rate An object of type numeric. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSelfingRate .P$setSelfingRate
#'@family Subpopulation
#'@return An object of type void.
#'@details Set the selﬁng rate of this subpopulation. The rate is changed to
#'rate, which should be between 0.0 and 1.0, inclusive. Selﬁng can only be enabled
#'in non-sexual (i.e. hermaphroditic) simulations. During mating and offspring
#'generation, the probability that any given offspring individual will be
#'generated by selﬁng - by self-fertilization via gametes produced by meiosis by
#'a single parent - will be equal to the selﬁng rate set in the parental (not the
#'offspring!) subpopulation (see section 22.2.1).
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=700}{SLiM manual: page
#'700}.
#'
#'@param sexRatio An object of type float. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSexRatio .P$setSexRatio
#'@family Subpopulation
#'@return An object of type void.
#'@details Set the sex ratio of this subpopulation to sexRatio. As defined
#'in SLiM, this is actually the fraction of the subpopulation that is male;
#'in other words, the M:(M+F) ratio. This will take effect when children are
#'next generated; it does not change the current subpopulation state. Unlike
#'the selfing rate, the cloning rate, and migration rates, the sex ratio is
#'deterministic: SLiM will generate offspring that exactly satisfy the requested
#'sex ratio (within integer roundoff limits). See section 22.2.1 for further
#'details.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=700}{SLiM manual: page
#'700}.
#'
#'@param bounds An object of type numeric. See details for description.
#'
#'@aliases Subpopulation$setSpatialBounds .P$setSpatialBounds
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=700}{SLiM manual: page
#'700}.
#'
#'@param size An object of type integer. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases Subpopulation$setSubpopulationSize .P$setSubpopulationSize
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
setSubpopulationSize <- function(size) {
 .P$setSubpopulationSize(size)
}

#'SLiM method spatialMapColor
#'
#'Documentation for SLiM function \code{spatialMapColor}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=700}{SLiM manual: page
#'700}.
#'
#'@param name An object of type string or numeric. Must be of length 1 (a
#'singleton). See details for description.
#'@param value An object of type string or numeric. See details for description.
#'
#'@aliases Subpopulation$spatialMapColor .P$spatialMapColor
#'@family Subpopulation
#'@return An object of type string.
#'@details Looks up the spatial map indicated by name, and uses its
#'color-translation machinery (as defined by the valueRange and colors parameters
#'to defineSpatialMap()) to translate each element of value into a corresponding
#'color string. If the spatial map does not have color-translation capabilities,
#'an error will result. See the documentation for defineSpatialMap() for
#'information regarding the details of color translation. See the Eidos manual for
#'further information on color strings.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
spatialMapColor <- function(name, value) {
 .P$spatialMapColor(name, value)
}

#'SLiM method spatialMapImage
#'
#'Documentation for SLiM function \code{spatialMapImage}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=700}{SLiM manual: page
#'700}.
#'
#'@param name An object of type string. Must be of length 1 (a singleton). See
#'details for description.
#'@param width An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param height An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param centers An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{F}. See details for description.
#'@param color An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'
#'@aliases Subpopulation$spatialMapImage .P$spatialMapImage
#'@family Subpopulation
#'@return An object of type Image object. Return will be of length 1 (a singleton)
#'@details Looks up the spatial map indicated by name, and returns an Image object
#'sampled from it. The image will be width pixels wide and height pixels tall; the
#'intrinsic size of the spatial map itself will be used if one of these parameters
#'is NULL. The image will be oriented in the same way as it is displayed in
#'SLiMgui (which conceptually entails a transformation from matrix coordinates,
#'which store values by column, to standard image coordinates, which store values
#'by row; see the Eidos manual's documentation of Image for details). This method
#'may only be called for 2D spatial maps at present. The sampling of the spatial
#'map can be done in one of two ways, as controlled by the centers parameter. If
#'centers is T, a (width+1) × (height+1) grid of lines that delineates width ×
#'height rectangular pixels will be overlaid on top of the spatial map, and values
#'will be sampled from the spatial map at the center of each of these pixels.
#'If centers is F (the default), a width × height grid of lines will be overlaid
#'on top of the spatial map, and values will be sampled from the spatial map
#'at the vertices of the grid. If interpolation is not enabled for the spatial
#'map, these two options will both recover the original matrix of values used
#'to define the spatial map (assuming, here and below, that width and height are
#'NULL). If interpolation is enabled for the spatial map, however, centers == F
#'will recover the original values, but will not capture the "typical" value of
#'each pixel in the image; centers == T, on the other hand, will not recover the
#'original values, but will capture the "typical" value of each pixel in the image
#'(i.e., the value at the center of each pixel, as produced by interpolation). The
#'figures in section 15.11 may be helpful for visualizing the difference between
#'these options; the overlaid grids span the full extent of the spatial map,
#'just as shown in that section. If color is T (the default), the valueRange and
#'colors parameters supplied to defineSpatialMap() will be used to translate map
#'values to RGB color values as described in the documentation of that method,
#'providing the same appearance as in SLiMgui; of course those parameters must
#'have been supplied, otherwise an error will result. If color is F, on the other
#'hand, a grayscale image will be produced that directly reflects the map values
#'without color translation. In this case, this method needs to translate map
#'values, which can have any float value, into grayscale pixel values that are
#'integers in [0, 255]. To do so, the map values are multiplied by 255.0, clamped
#'to [0.0, 255.0], and then rounded to the nearest integer. This translation
#'scheme essentially assumes that map values are in [0, 1]; for spatial maps that
#'were defined using the floatK channel of a grayscale PNG image, this should
#'recover the original image's pixel values. (If a different translation scheme is
#'desired, color=T with the desired valueRange and colors should be used.)
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
spatialMapImage <- function(name, width, height, centers, color) {
 .P$spatialMapImage(name, width, height, centers, color)
}

#'SLiM method spatialMapValue
#'
#'Documentation for SLiM function \code{spatialMapValue}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=701}{SLiM manual: page
#'701}.
#'
#'@param name An object of type string or float. Must be of length 1 (a
#'singleton). See details for description.
#'@param point An object of type string or float. See details for description.
#'
#'@aliases Subpopulation$spatialMapValue .P$spatialMapValue
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=701}{SLiM manual: page
#'701}.
#'
#'@param exclude An object of type null or Individual object. Must be of length 1
#'(a singleton). The default value is \code{NULL}. See details for description.
#'@param sex An object of type null or string. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param tag An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param minAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param maxAge An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param migrant An object of type null or logical. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases Subpopulation$subsetIndividuals .P$subsetIndividuals
#'@family Subpopulation
#'@return An object of type Individual object.
#'@details Returns a vector of individuals subset from the individuals in the
#'target subpopulation. The parameters specify constraints upon the subset
#'of individuals that will be returned. Parameter exclude, if non- NULL, may
#'specify a specific individual that should not be included (typically the focal
#'individual in some operation). Parameter sex, if non-NULL, may specify a sex
#'("M" or "F") for the individuals to be returned, in sexual models. Parameter
#'tag, if non-NULL, may specify a tag value for the individuals to be returned.
#'Parameters minAge and maxAge, if non-NULL, may specify a minimum or maximum
#'age for the individuals to be returned, in nonWF models. Parameter migrant,
#'if non-NULL, may specify a required value for the migrant property of the
#'individuals to be returned (so T will require that individuals be migrants,
#'F will require that they not be). This method is shorthand for getting the
#'individuals property of the subpopulation, and then using operator [] to select
#'only individuals with the desired properties; besides being much simpler than
#'the equivalent Eidos code, it is also much faster. See sampleIndividuals() for a
#'similar method that returns a sample taken from a chosen subset of individuals.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
subsetIndividuals <- function(exclude, sex, tag, minAge, maxAge, migrant) {
 .P$subsetIndividuals(exclude, sex, tag, minAge, maxAge, migrant)
}

#'SLiM method takeMigrants
#'
#'Documentation for SLiM function \code{takeMigrants}, which is a method of the
#'SLiM class \code{\link{Subpopulation}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=702}{SLiM manual: page
#'702}.
#'
#'@param migrants An object of type Individual object. See details for
#'description.
#'
#'@aliases Subpopulation$takeMigrants .P$takeMigrants
#'@family Subpopulation
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
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'
takeMigrants <- function(migrants) {
 .P$takeMigrants(migrants)
}



#'SLiM method codonsToAminoAcids
#'
#'Documentation for SLiM function \code{codonsToAminoAcids}, which is a method of
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=703}{SLiM manual: page
#'703}.
#'
#'@param codons An object of type integer. See details for description.
#'@param long An object of type logical or integer. Must be of length 1 (a
#'singleton). The default value is \code{F}. See details for description.
#'@param paste An object of type logical. Must be of length 1 (a singleton). The
#'default value is \code{T}. See details for description.
#'
#'@aliases SLiMBuiltin$codonsToAminoAcids .SB$codonsToAminoAcids
#'@family SLiMBuiltin
#'@return An object of type integer or string.
#'@details Returns the amino acid sequence corresponding to the codon sequence
#'in codons. Codons should be represented with values in [0, 63] where AAA is 0,
#'AAC is 1, AAG is 2, and TTT is 63; see ancestralNucleotides() for discussion
#'of this encoding. If long is F (the default), the standard single-letter codes
#'for amino acids will be used (where Serine is "S", etc.); if long is T, the
#'standard three-letter codes will be used instead (where Serine is "Ser", etc.).
#'Beginning in SLiM 3.5, if long is 0, integer codes will be used as follows (and
#'paste will be ignored): stop (TAA, TAG, TGA) 0 Alanine 1 Arginine 2 Asparagine
#'3 Aspartic acid (Aspartate) 4 Cysteine 5 Glutamine 6 Glutamic acid (Glutamate)
#'7 Glycine 8 Histidine 9 Isoleucine 10 Leucine 11 Lysine 12 Methionine 13
#'Phenylalanine 14 Proline 15 Serine 16 Threonine 17 Tryptophan 18 Tyrosine 19
#'Valine 20 There does not seem to be a widely used standard for integer coding
#'of amino acids, so SLiM just numbers them alphabetically, making stop codons 0.
#'If you want a different coding, you can make your own 64-element vector and use
#'it to convert codons to whatever integer codes you need. Other integer values of
#'long are reserved for future use (to support other codings), and will currently
#'produce an error. When long is T or F and paste is T (the default), the amino
#'acid sequence returned will be a singleton string, such as "LYATI" (when long
#'is F) or "Leu-Tyr-Ala-Thr-Ile" (when long is T). When long is T or F and paste
#'is F, the amino acid sequence will instead be returned as a string vector,
#'with one element per amino acid, such as "L" "Y" "A" "T" "I" (when long is F)
#'or "Leu" "Tyr" "Ala" "Thr" "Ile" (when long is T). Using the paste=T option
#'is considerably faster than using paste() in script. This function interprets
#'the supplied codon sequence as the sense strand (i.e., the strand that is not
#'transcribed, and which mirrors the mRNA's sequence). This uses the standard
#'DNA codon table directly. For example, if the nucleotide sequence is CAA TTC,
#'that will correspond to a codon vector of 16 61, and will result in the amino
#'acid sequence Gln-Phe ("QF"). (is)codonsToNucleotides(integer codons, [string$
#'format = "string"]) Returns the nucleotide sequence corresponding to the codon
#'sequence supplied in codons. Codons should be represented with values in [0, 63]
#'where AAA is 0, AAC is 1, AAG is 2, and TTT is 63; see ancestralNucleotides()
#'for discussion of this encoding. The format parameter controls the format of
#'the returned sequence. It may be "string" to obtain the sequence as a singleton
#'string (e.g., "TATACG"), "char" to obtain it as a string vector of single
#'characters (e.g., "T", "A", "T", "A", "C", "G"), or "integer" to obtain it as an
#'integer vector (e.g., 3, 0, 3, 0, 1, 2), using SLiM's standard code of A=0, C=1,
#'G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=704}{SLiM manual: page
#'704}.
#'
#'@param mutationMatrix16 An object of type float. See details for description.
#'
#'@aliases SLiMBuiltin$mm16To256 .SB$mm16To256
#'@family SLiMBuiltin
#'@return An object of type float.
#'@details Returns a 64×4 mutation matrix that is functionally identical to
#'the supplied 4×4 mutation matrix in mutationMatrix16. The mutation rate for
#'each of the 64 trinucleotides will depend only upon the central nucleotide
#'of the trinucleotide, and will be taken from the corresponding entry for
#'the same nucleotide in mutationMatrix16. This function can be used to easily
#'construct a simple trinucleotide-based mutation matrix which can then be
#'modified so that specific trinucleotides sustain a mutation rate that does
#'not depend only upon their central nucleotide. See the documentation for
#'initializeGenomicElementType() in section 24.1 for further discussion of how
#'these 64×4 mutation matrices are interpreted and used.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=704}{SLiM manual: page
#'704}.
#'
#'@param alpha An object of type float. Must be of length 1 (a singleton). See
#'details for description.
#'
#'@aliases SLiMBuiltin$mmJukesCantor .SB$mmJukesCantor
#'@family SLiMBuiltin
#'@return An object of type float.
#'@details Returns a mutation matrix representing a Jukes-Cantor (1969) model with
#'mutation rate alpha to each possible alternative nucleotide at a site: This 2×2
#'matrix is suitable for use with initializeGenomicElementType(). Note that the
#'actual mutation rate produced by this matrix is 3*alpha.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=704}{SLiM manual: page
#'704}.
#'
#'@param alpha An object of type float or float. Must be of length 1 (a
#'singleton). See details for description.
#'@param beta An object of type float or float. Must be of length 1 (a singleton).
#'See details for description.
#'
#'@aliases SLiMBuiltin$mmKimura .SB$mmKimura
#'@family SLiMBuiltin
#'@return An object of type float.
#'@details Returns a mutation matrix representing a Kimura (1980) model with
#'transition rate alpha and transversion rate beta: This 2×2 matrix is suitable
#'for use with initializeGenomicElementType(). Note that the actual mutation rate
#'produced by this model is alpha+2*beta. 0 α α α α 0 α α α α 0 α α α α 0 0 β α β
#'β 0 β α α β 0 β β α β 0
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=705}{SLiM manual: page
#'705}.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotideCounts .SB$nucleotideCounts
#'@family SLiMBuiltin
#'@return An object of type integer.
#'@details A convenience function that returns an integer vector of length four,
#'providing the number of occurrences of A / C / G / T nucleotides, respectively,
#'in the supplied nucleotide sequence. The parameter sequence may be a singleton
#'string (e.g., "TATA"), a string vector of single characters (e.g., "T", "A",
#'"T", "A"), or an integer vector (e.g., 3, 0, 3, 0), using SLiM's standard code
#'of A=0, C=1, G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'of the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=705}{SLiM manual: page
#'705}.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotideFrequencies .SB$nucleotideFrequencies
#'@family SLiMBuiltin
#'@return An object of type float.
#'@details A convenience function that returns a float vector of length four,
#'providing the frequencies of occurrences of A / C / G / T nucleotides,
#'respectively, in the supplied nucleotide sequence. The parameter sequence may be
#'a singleton string (e.g., "TATA"), a string vector of single characters (e.g.,
#'"T", "A", "T", "A"), or an integer vector (e.g., 3, 0, 3, 0), using SLiM's
#'standard code of A=0, C=1, G=2, T=3.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
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
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=705}{SLiM manual: page
#'705}.
#'
#'@param sequence An object of type integer or string. See details for
#'description.
#'
#'@aliases SLiMBuiltin$nucleotidesToCodons .SB$nucleotidesToCodons
#'@family SLiMBuiltin
#'@return An object of type integer.
#'@details Returns the codon sequence corresponding to the nucleotide sequence
#'in sequence. The codon sequence is an integer vector with values from 0 to
#'63, based upon successive nucleotide triplets in the nucleotide sequence. The
#'codon value for a given nucleotide triplet XYZ is 16X + 4Y + Z, where X, Y, and
#'Z have the usual values A=0, C=1, G=2, T=3. For example, the triplet AAA has
#'a codon value of 0, AAC is 1, AAG is 2, AAT is 3, ACA is 4, and on upward to
#'TTT which is 63. If the nucleotide sequence AACACATTT is passed in, the codon
#'vector 1 4 63 will therefore be returned. These codon values can be useful
#'in themselves; they can also be passed to codonsToAminoAcids() to translate
#'them into the corresponding amino acid sequence if desired. The nucleotide
#'sequence in sequence may be supplied in any of three formats: a string vector
#'with single-letter nucleotides (e.g., "T", "A", "T", "A"), a singleton string
#'of nucleotide letters (e.g., "TATA"), or an integer vector of nucleotide
#'values (e.g., 3, 0, 3, 0) using SLiM's standard code of A=0, C=1, G=2, T=3.
#'If the choice of format is not driven by other considerations, such as ease
#'of manipulation, then the singleton string format will certainly be the most
#'memory-efficient for long sequences, and will probably also be the fastest.
#'The nucleotide sequence provided must be a multiple of three in length, so that
#'it translates to an integral number of codons. (is)randomNucleotides(integer$
#'length, [Nif basis = NULL], [string$ format = "string"]) Generates a new
#'random nucleotide sequence with length bases. The four nucleotides ACGT are
#'equally probable if basis is NULL (the default); otherwise, basis may be a
#'4-element integer or float vector providing relative fractions for A, C, G,
#'and T respectively (these need not sum to 1.0, as they will be normalized).
#'More complex generative models such as Markov processes are not supported
#'intrinsically in SLiM at this time, but arbitrary generated sequences may
#'always be loaded from files on disk. The format parameter controls the format
#'of the returned sequence. It may be "string" to obtain the generated sequence
#'as a singleton string (e.g., "TATA"), "char" to obtain it as a string vector
#'of single characters (e.g., "T", "A", "T", "A"), or "integer" to obtain it as
#'an integer vector (e.g., 3, 0, 3, 0), using SLiM's standard code of A=0, C=1,
#'G=2, T=3. For passing directly to initializeAncestralNucleotides(), format
#'"string" (a singleton string) will certainly be the most memory-efficient, and
#'probably also the fastest. Memory efficiency can be a significant consideration;
#'the nucleotide sequence for a chromosome of length 109 will occupy approximately
#'1 GB of memory when stored as a singleton string (with one byte per nucleotide),
#'and much more if stored in the other formats. However, the other formats can
#'be easier to work with in Eidos, and so may be preferable for relatively short
#'chromosomes if you are manipulating the generated sequence.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
nucleotidesToCodons <- function(sequence) {
 .SB$nucleotidesToCodons(sequence)
}

#'SLiM method calcFST
#'
#'Documentation for SLiM function \code{calcFST}, which is a method of the SLiM
#'class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=706}{SLiM manual: page
#'706}.
#'
#'@param genomes1 An object of type Genome object. See details for description.
#'@param genomes2 An object of type Genome object. See details for description.
#'@param muts An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMBuiltin$calcFST .SB$calcFST
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates the FST between two Genome vectors - typically, but not
#'necessarily, the genomes that constitute two different subpopulations (which
#'we will assume for the purposes of this discussion). In general, higher FST
#'indicates greater genetic divergence between subpopulations. The calculation
#'is done using only the mutations in muts; if muts is NULL, all mutations
#'are used. The muts parameter can therefore be used to calculate the FST only
#'for a particular mutation type (by passing only mutations of that type). The
#'calculation can be narrowed to apply to only a window - a subrange of the
#'full chromosome - by passing the interval bounds [start, end] for the desired
#'window. In this case, the vector of mutations used for the calculation will
#'be subset to include only mutations within the specified window. The default
#'behavior, with start and end of NULL, provides the genome-wide FST, which is
#'often used to assess the overall level of genetic divergence between sister
#'species or allopatric subpopulations. The code for calcFST() is, roughly, an
#'Eidos implementation of Wright's definition of FST (but see below for further
#'discussion and clarification): where HS is the average heterozygosity in the two
#'subpopulations, and HT is the total heterozygosity when both subpopulations are
#'combined. In this implementation, the two genome vectors are weighted equally,
#'not weighted by their size. In SLiM 3, the implementation followed Wright's
#'definition closely, and returned the average of ratios: mean(1.0 - H_s/H_t),
#'in the Eidos code. In SLiM 4, it returns the ratio of averages instead: 1.0
#'- mean(H_s)/mean(H_t). In other words, the FST value reported by SLiM 4 is an
#'average across the specified mutations in the two sets of genomes, where H_s and
#'H_t are first averaged across all specified mutations prior to taking the ratio
#'of the two. This ratio of averages is less biased than the average of ratios,
#'and and is generally considered to be best practice (see, e.g., Bhatia et al.,
#'2013). This means that the behavior of calcFST() differs between SLiM 3 and SLiM
#'4. The implementation of calcFST(), viewable with functionSource(), treats every
#'mutation in muts as independent in the heterozygosity calculations; in other
#'words, if mutations are stacked, the heterozygosity calculated is by mutation,
#'not by site. Similarly, if multiple Mutation objects exist in different genomes
#'at the same site (whether representing different genetic states, or multiple
#'mutational lineages for the same genetic state), each Mutation object is
#'treated separately for purposes of the heterozygosity calculation, just as if
#'they were at different sites. One could regard these choices as embodying an
#'infinite-sites interpretation of the segregating mutations. In most biologically
#'realistic models, such genetic states will be quite rare, and so the impact of
#'these choices will be negligible; however, in some models these distinctions may
#'be important. FST = 1 − HS HT
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcFST <- function(genomes1, genomes2, muts, start, end) {
 .SB$calcFST(genomes1, genomes2, muts, start, end)
}

#'SLiM method calcHeterozygosity
#'
#'Documentation for SLiM function \code{calcHeterozygosity}, which is a method of
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=707}{SLiM manual: page
#'707}.
#'
#'@param genomes An object of type Genome object. See details for description.
#'@param muts An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMBuiltin$calcHeterozygosity .SB$calcHeterozygosity
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates the heterozygosity for a vector of genomes, based upon
#'the frequencies of mutations in the genomes. The result is the expected
#'heterozygosity, for the individuals to which the genomes belong, assuming that
#'they are under Hardy-Weinberg equilibrium; this can be compared to the observed
#'heterozygosity of an individual, as calculated by calcPairHeterozygosity().
#'Often genomes will be all of the genomes in a subpopulation, or in the entire
#'population, but any genome vector may be used. By default, with muts=NULL,
#'the calculation is based upon all mutations in the simulation; the calculation
#'can instead be based upon a subset of mutations, such as mutations of a
#'specific mutation type, by passing the desired vector of mutations for muts.
#'The calculation can be narrowed to apply to only a window - a subrange of the
#'full chromosome - by passing the interval bounds [start, end] for the desired
#'window. In this case, the vector of mutations used for the calculation will
#'be subset to include only mutations within the specified window. The default
#'behavior, with start and end of NULL, provides the genome-wide heterozygosity.
#'The implementation of calcHeterozygosity(), viewable with functionSource(),
#'treats every mutation as independent in the heterozygosity calculations.
#'One could regard this choice as embodying an infinite-sites interpretation
#'of the segregating mutations. In most biologically realistic models, such
#'genetic states will be quite rare, and so the impact of this choice will be
#'negligible; however, in some models this distinction may be important. See
#'calcPairHeterozygosity() for further discussion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcHeterozygosity <- function(genomes, muts, start, end) {
 .SB$calcHeterozygosity(genomes, muts, start, end)
}

#'SLiM method calcInbreedingLoad
#'
#'Documentation for SLiM function \code{calcInbreedingLoad}, which is a method of
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=707}{SLiM manual: page
#'707}.
#'
#'@param genomes An object of type Genome object. See details for description.
#'@param mutType An object of type null or MutationType object. Must be of length
#'1 (a singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMBuiltin$calcInbreedingLoad .SB$calcInbreedingLoad
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates inbreeding load (the haploid number of lethal equivalents,
#'or B) for a vector of genomes passed in genomes. The calculation can be limited
#'to a focal mutation type passed in mutType; if mutType is NULL (the default),
#'all of the mutations for the focal species will be considered. In any case,
#'only deleterious mutations (those with a negative selection coefficient)
#'will be included in the final calculation. The inbreeding load is a measure
#'of the quantity of recessive deleterious variation that is heterozygous in
#'a population and can contribute to fitness declines under inbreeding. This
#'function implements the following equation from Morton et al. (1956), which
#'assumes no epistasis and random mating: B = sum(qs) − sum(q2s) − 2sum(q(1−q)sh)
#'where q is the frequency of a given deleterious allele, s is the absolute
#'value of the selection coefficient, and h is its dominance coefficient. Note
#'that the implementation sets a maximum |s| of 1.0 (i.e., a lethal allele); |s|
#'can sometimes be greater than 1.0 when s is drawn from a distribution, but in
#'practice an allele with s < -1.0 has the same lethal effect as when s = -1.0.
#'Also note that this implementation will not work when the model changes the
#'dominance coefficients of mutations using mutationEffect() callbacks, since it
#'relies on the dominanceCoeff property of MutationType. Finally, note that, to
#'estimate the diploid number of lethal equivalents (2B), the result from this
#'function can simply be multiplied by two. This function was contributed by Chris
#'Kyriazis; thanks, Chris!
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcInbreedingLoad <- function(genomes, mutType) {
 .SB$calcInbreedingLoad(genomes, mutType)
}

#'SLiM method calcPairHeterozygosity
#'
#'Documentation for SLiM function \code{calcPairHeterozygosity}, which is a method
#'of the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=707}{SLiM manual: page
#'707}.
#'
#'@param genome1 An object of type Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param genome2 An object of type Genome object. Must be of length 1 (a
#'singleton). See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'@param infiniteSites An object of type logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases SLiMBuiltin$calcPairHeterozygosity .SB$calcPairHeterozygosity
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates the heterozygosity for a pair of genomes; these will
#'typically be the two genomes of a diploid individual (individual.genome1 and
#'individual.genome2), but any two genomes may be supplied. The calculation can
#'be narrowed to apply to only a window - a subrange of the full chromosome - by
#'passing the interval bounds [start, end] for the desired window. In this case,
#'the vector of mutations used for the calculation will be subset to include
#'only mutations within the specified window. The default behavior, with start
#'and end of NULL, provides the genome-wide heterozygosity. The implementation
#'calcPairHeterozygosity(), viewable with functionSource(), treats every mutation
#'as independent in the heterozygosity calculations by default (i.e., with
#'infiniteSites=T). If mutations are stacked, the heterozygosity calculated
#'therefore depends upon the number of unshared mutations, not the number of
#'differing sites. Similarly, if multiple Mutation objects exist in different
#'genomes at the same site (whether representing different genetic states, or
#'multiple mutational lineages for the same genetic state), each Mutation object
#'is treated separately for purposes of the heterozygosity calculation, just as
#'if they were at different sites. One could regard these choices as embodying an
#'infinite-sites interpretation of the segregating mutations. In most biologically
#'realistic models, such genetic states will be quite rare, and so the impact of
#'this choice will be negligible; however, in some models this distinction may be
#'important. The behavior of calcPairHeterozygosity() can be switched to calculate
#'based upon the number of differing sites, rather than the number of unshared
#'mutations, by passing infiniteSites=F.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcPairHeterozygosity <- function(genome1, genome2, start, end,
infiniteSites) {
 .SB$calcPairHeterozygosity(genome1, genome2, start, end, infiniteSites)
}

#'SLiM method calcVA
#'
#'Documentation for SLiM function \code{calcVA}, which is a method of the SLiM
#'class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=708}{SLiM manual: page
#'708}.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'@param mutType An object of type integer or MutationType object. Must be of
#'length 1 (a singleton). See details for description.
#'
#'@aliases SLiMBuiltin$calcVA .SB$calcVA
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates VA, the additive genetic variance, among a vector
#'individuals, in a particular mutation type mutType that represents quantitative
#'trait loci (QTLs) influencing a quantitative phenotypic trait. The mutType
#'parameter may be either an integer representing the ID of the desired mutation
#'type, or a MutationType object specified directly. This function assumes
#'that mutations of type mutType encode their effect size upon the quantitative
#'trait in their selectionCoeff property, as is fairly standard in SLiM (see,
#'e.g., section 13.2). The implementation of calcVA(), which is viewable with
#'functionSource(), is quite simple; if effect sizes are stored elsewhere (such as
#'with setValue(), as in section 13.5), a new user-defined function following the
#'pattern of calcVA() can easily be written.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcVA <- function(individuals, mutType) {
 .SB$calcVA(individuals, mutType)
}

#'SLiM method calcWattersonsTheta
#'
#'Documentation for SLiM function \code{calcWattersonsTheta}, which is a method of
#'the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=708}{SLiM manual: page
#'708}.
#'
#'@param genomes An object of type Genome object. See details for description.
#'@param muts An object of type null or Mutation object. The default value is
#'\code{NULL}. See details for description.
#'@param start An object of type null or integer. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'@param end An object of type null or integer. Must be of length 1 (a singleton).
#'The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMBuiltin$calcWattersonsTheta .SB$calcWattersonsTheta
#'@family SLiMBuiltin
#'@return An object of type float. Return will be of length 1 (a singleton)
#'@details Calculates Watterson's theta (a metric of genetic diversity comparable
#'to heterozygosity) for a vector of genomes, based upon the mutations in the
#'genomes. Often genomes will be all of the genomes in a subpopulation, or in
#'the entire population, but any genome vector may be used. By default, with
#'muts=NULL, the calculation is based upon all mutations in the simulation; the
#'calculation can instead be based upon a subset of mutations, such as mutations
#'of a specific mutation type, by passing the desired vector of mutations for
#'muts. The calculation can be narrowed to apply to only a window - a subrange
#'of the full chromosome - by passing the interval bounds [start, end] for the
#'desired window. In this case, the vector of mutations used for the calculation
#'will be subset to include only mutations within the specified window. The
#'default behavior, with start and end of NULL, provides the genome-wide
#'Watterson's theta. The implementation of calcWattersonsTheta(), viewable with
#'functionSource(), treats every mutation as independent in the heterozygosity
#'calculations. One could regard this choice as embodying an infinite-sites
#'interpretation of the segregating mutations, as with calcHeterozygosity(). In
#'most biologically realistic models, such genetic states will be quite rare, and
#'so the impact of this assumption will be negligible; however, in some models
#'this distinction may be important. See calcPairHeterozygosity() for further
#'discussion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
calcWattersonsTheta <- function(genomes, muts, start, end) {
 .SB$calcWattersonsTheta(genomes, muts, start, end)
}

#'SLiM method summarizeIndividuals
#'
#'Documentation for SLiM function \code{summarizeIndividuals}, which is a method
#'of the SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=708}{SLiM manual: page
#'708}.
#'
#'@param individuals An object of type Individual object. See details for
#'description.
#'@param dim An object of type integer. See details for description.
#'@param spatialBounds An object of type numeric. See details for description.
#'@param operation An object of type string. Must be of length 1 (a singleton).
#'See details for description.
#'@param empty An object of type null or logical or integer or float. Must be
#'of length 1 (a singleton). The default value is \code{0.0}. See details for
#'description.
#'@param perUnitArea An object of type logical. Must be of length 1 (a singleton).
#'The default value is \code{F}. See details for description.
#'@param spatiality An object of type null or string. Must be of length 1 (a
#'singleton). The default value is \code{NULL}. See details for description.
#'
#'@aliases SLiMBuiltin$summarizeIndividuals .SB$summarizeIndividuals
#'@family SLiMBuiltin
#'@return An object of type float.
#'@details Returns a vector, matrix, or array that summarizes spatial patterns
#'of information related to the individuals in individuals. In essence, those
#'individuals are assigned into bins according to their spatial position, and
#'then a summary value for each bin is calculated based upon the individuals
#'each bin contains. The individuals might be binned in one dimension (resulting
#'in a vector of summary values), in two dimensions (resulting in a matrix), or
#'in three dimensions (resulting in an array). Typically the spatiality of the
#'result (the dimensions into which the individuals are binned) will match the
#'dimensionality of the model, as indicated by the default value of NULL for the
#'optional spatiality parameter; for example, a two-dimensional ("xy") model would
#'by default produce a two-dimensional matrix as a summary. However, a spatiality
#'that is more restrictive than the model dimensionality may be passed; for
#'example, in a two-dimensional ("xy") model a spatiality of "y" could be passed
#'to summarize individuals into a vector, rather than a matrix, assigning them
#'to bins based only upon their y position (i.e., the value of their y property).
#'Whatever spatiality is chosen, the parameter dim provides the dimensions of the
#'desired result, in the same form that the dim() function does: first the number
#'of rows, then the number of columns, and then the number of planes, as needed
#'(see the Eidos manual for discussion of matrices, arrays, and dim()). The length
#'of dims must match the requested spatiality; for spatiality "xy", for example,
#'dims might be c(50,100) to request that the returned matrix have 50 rows and
#'100 columns. The result vector/matrix/array is in the correct orientation to
#'be directly usable as a spatial map, by passing it to the defineSpatialMap()
#'method of Subpopulation. For further discussion of dimensionality and
#'spatiality, see section 24.1 on initializeInteractionType(), and section 24.8
#'on InteractionType. The spatialBounds parameter defines the spatial boundaries
#'within which the individuals are binned. Typically this is the spatial bounds of
#'a particular subpopulation, within which the individuals reside; for individuals
#'in p1, for example, you would likely pass p1.spatialBounds for this. However,
#'this is not required; individuals may come from any or all subpopulations in the
#'model, and spatialBounds may be any bounds of non-zero area (if an individual
#'falls outside of the given spatial bounds, it is excluded, as if it were not
#'in individuals at all). If you have multiple subpopulations that conceptually
#'reside within the same overall coordinate space, for example, that can be
#'accommodated here. The bounds are supplied in the dimensionality of the model,
#'in the same form as for Subpopulation; for an "xy" model, for example, they
#'are supplied as a four-element vector of the form c(x0, y0, x1, y1) even if
#'the summary is being produced with spatiality "y". To produce the result, a
#'grid with dimensions defined by dims is conceptually stretched out across the
#'given spatial bounds, such that the centers of the edge and corner grid squares
#'are aligned with the limits of the spatial bounds. This matches the way that
#'defineSpatialMap() defines its maps; see section 15.11 for illustration. The
#'particular summary produced depends upon the parameters operation and empty.
#'Consider a single grid square represented by a single element in the result.
#'That grid square contains zero or more of the individuals in individuals. If
#'it contains zero individuals and empty is not NULL, the empty value is used for
#'the result, regardless of operation, providing specific, separate control over
#'the treatment of empty grid squares. If empty is NULL, this separate control
#'over the treatment of empty grid squares is declined; empty grid squares will
#'be handled through the standard mechanism described next. In all other cases
#'for the given grid square - when it contains more than zero individuals, or
#'when empty is NULL - operation is executed as an Eidos lambda, a small snippet
#'of code, supplied as a singleton string, that is executed in a manner similar
#'to a function call. Within the execution of the operation lambda, a constant
#'named individuals is defined to be the focal individuals being evaluated -
#'all of the individuals within that grid square. This lambda should evaluate
#'to a singleton logical, integer, or float value, comprising the result value
#'for the grid square; these types will all be coerced to float (T being 1 and
#'F being 0). Two examples may illustrate the use of empty and operation. To
#'produce a summary indicating presence/absence, simply use the default of 0.0
#'for empty, and "1.0; " (or "1;", or "T;") for operation. This will produce
#'0.0 for empty grid squares, and 1.0 for those that contain at least one
#'individual. Note that the use of empty is essential here, because operation
#'doesn't even check whether individuals are present or not. To produce a summary
#'with a count of the number of individuals in each grid square, again use the
#'default of 0.0 for empty, but now use an operation of "individuals.size();",
#'counting the number of individuals in each grid square. In this case, empty
#'could be NULL instead and operation would still produce the correct result;
#'but using empty makes summarizeIndividuals() more efficient since it allows the
#'execution of operation to be skipped for those squares. Lambdas are not limited
#'in their complexity; they can use if, for, etc., and can call methods and
#'functions. A typical operation to compute the mean phenotype in a quantitative
#'genetic model that stores phenotype values in tagF, for example, would be
#'"mean(individuals.tagF);", and this is still quite simple compared to what is
#'possible. However, keep in mind that the lambda will be evaluated for every grid
#'cell (or at least those that are non-empty), so efficiency can be a concern, and
#'you may wish to pre-calculate values shared by all of the lambda calls, making
#'them available to your lambda code using defineGlobal() or defineConstant().
#'There is one last twist, if perUnitArea is T: values are divided by the area (or
#'length, in 1D, or volume, in 3D) that their corresponding grid cell comprises,
#'so that each value is in units of "per unit area" (or "per unit length", or "per
#'unit volume"). The total area of the grid is defined by the spatial bounds, and
#'the area of a given grid cell is defined by the portion of the spatial bounds
#'that is within that cell. This is not the same for all grid cells; grid cells
#'that fall partially outside spatialBounds (because, remember, the centers of
#'the edge/corner grid cells are aligned with the limits of spatialBounds) will
#'have a smaller area inside the bounds. For an "xy" spatiality summary, for
#'example, corner cells have only a quarter of their area inside spatialBounds,
#'while edge elements have half of their area inside spatialBounds; for purposes
#'of perUnitArea, then, their respective areas are ¼ and ½ the area of an interior
#'grid cell. By default, perUnitArea is F, and no scaling is performed. Whether
#'you want perUnitArea to be F or T depends upon whether the summary you are
#'producing is, conceptually, "per unit area", such as density (individuals
#'per unit area) or local competition strength (total interaction strength
#'per unit area), or is not, such as "mean individual age", or "maximum tag
#'value". For the previous example of counting individuals with an operation of
#'"individuals.size();", a value of F for perUnitArea (the default) will produce a
#'simple count of individuals in each grid square, whereas with T it would produce
#'the density of individuals in each grid square.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
summarizeIndividuals <- function(individuals, dim, spatialBounds, operation,
empty, perUnitArea, spatiality) {
 .SB$summarizeIndividuals(individuals, dim, spatialBounds, operation, empty,
perUnitArea, spatiality)
}

#'SLiM method treeSeqMetadata
#'
#'Documentation for SLiM function \code{treeSeqMetadata}, which is a method of the
#'SLiM class \code{\link{SLiMBuiltin}}.
#'Note that the R function is a stub, it does not do anything in R (except bring
#'up this documentation). It will only do
#'anything useful when used inside a \code{\link{slim_block}} function further
#'nested in a \code{\link{slim_script}}
#'function call, where it will be translated into valid SLiM code as part of a
#'full SLiM script.
#'
#'Documentation for this function can be found in the official
#'\href{http://benhaller.com/slim/SLiM_Manual.pdf#page=710}{SLiM manual: page
#'710}.
#'
#'@param filePath An object of type string or logical. Must be of length 1 (a
#'singleton). See details for description.
#'@param userData An object of type string or logical. Must be of length 1 (a
#'singleton). The default value is \code{T}. See details for description.
#'
#'@aliases SLiMBuiltin$treeSeqMetadata .SB$treeSeqMetadata
#'@family SLiMBuiltin
#'@return An object of type Dictionary object. Return will be of length 1 (a
#'singleton)
#'@details Returns a Dictionary containing top-level metadata from the .trees
#'(tree-sequence) file at filePath. If userData is T (the default), the top-level
#'metadata under the SLiM/user_metadata key is returned; this is the same metadata
#'that can optionally be supplied to treeSeqOutput() in its metadata parameter, so
#'it makes it easy to recover metadata that you attached to the tree sequence when
#'it was saved. If userData is F, the entire top-level metadata Dictionary object
#'is returned; this can be useful for examining the values of other keys under the
#'SLiM key (see section 26.4), or values inside the top-level dictionary itself
#'that might have been placed there by msprime or other software. This function
#'can be used to read in parameter values or other saved state (tag property
#'values, for example), in order to resuscitate the complete state of a simulation
#'that was written to a .trees file. It could be used for more esoteric purposes
#'too, such as to search through .trees files in a directory (with the help of
#'the Eidos function filesAtPath()) to find those files that satisfy some metadata
#'criterion.
#'@section Copyright:
#'This is documentation for a function in the SLiM software, and has been
#'reproduced from the official manual,
#'which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#'documentation is
#'Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#'about SLiM can be found
#'on the official website: \url{https://messerlab.org/slim/}
#'@author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#'(\email{messer@cornell.edu})
#'@export
treeSeqMetadata <- function(filePath, userData) {
 .SB$treeSeqMetadata(filePath, userData)
}







#'Initialize
#'
#'Documentation for Initialize class from SLiM
#'
#'@name Initialize
#'@export
#'@aliases Init
#'@family Initialize
#'@details Before a SLiM simulation can be run, the various classes underlying the
#'simulation need to be
#'set up with an initial configuration. Simulation configuration in SLiM is done
#'in initialize()
#'callbacks that run prior to the beginning of simulation execution. Eidos
#'callbacks are discussed
#'more broadly in chapter 25, but for our present purposes, the idea is very
#'simple. In your input
#'file, you can write something like this:
#'initialize()
#'{
#'...
#'}
#'The initialize() declaration specifies that the script block is to be executed
#'as an
#'initialize() callback before the simulation starts. The script between the
#'braces {} would set up
#'various aspects of the simulation by calling initialization functions. These are
#'SLiM functions that
#'may be called only in an initialize() callback, and their names begin with
#'initialize to mark
#'them clearly as such. You may also use other Eidos functionality in these
#'callbacks; for example,
#'you might automate generating a complex genetic structure containing many genes
#'by using a for
#'loop.
#'In general, it is required for a species to set up its genetic structure in an
#'initialize() callback
#'with calls to initializeMutationRate(), initializeRecombinationRate(),
#'initializeMutationType(), initializeGenomicElementType(), and
#'initializeGenomicElement(); species must call all of these, setting up at least
#'one mutation type,
#'at least one genomic element type, and at least one genomic element. The
#'exception to this
#'general rule is for species that have no genetics at all - species that are
#'modeled purely on an
#'ecological/behavioral level. Such species may be defined by calling none of
#'those initialization
#'functions; in this case, SLiM will default to a zero-length chromosome with
#'mutation and
#'recombination rates of zero. A middle ground between these two configuration
#'paths is not
#'allowed; either a species has no genetics, or it fully defines its genetics.
#'One thing worth mentioning is that in the context of an initialize() callback,
#'the sim global
#'representing the species being simulated is not defined. This is because the
#'state of the simulation
#'is not yet constructed fully, and accessing partially constructed state would
#'not be safe. (Similarly,
#'in multispecies models, the community object and the objects representing
#'individual species are
#'not yet defined.)
#'The above initialize() callback syntax implicitly declares a single species,
#'with the default
#'name of sim, and therefore sets up a single-species model. It is also possible
#'to explicitly declare a
#'species, which is done with this extended syntax (using a species name of fox as
#'an example):
#'species fox initialize() { ... }
#'This sets up a multispecies model (although it might, in fact, declare only a
#'single species, fox;
#'the term "multispecies", in SLiM parlance, really means "explicitly declared
#'species", but
#'multispecies models almost always do contain multiple species, so the
#'distinction is unimportant).
#'See section 1.9 and chapter 19 for further discussion of multispecies models; in
#'most respects they
#'work identically to single-species models, so we will tend to focus on the
#'single-species case in
#'the reference documentation, with a species name of sim, for simplicity and
#'clarity.
#'In single-species models all initialization can be done in a single initialize()
#'callback (or you
#'can have more than one, if you wish). In multispecies models, each species must
#'be initialized
#'with its own callback(s), as shown above. In addition, multispecies models also
#'support an
#'optional community-level initialization callback that is declared as follows:
#'species all initialize() { ... }
#'These callbacks, technically called non-species-specific initialize() callbacks,
#'provide a
#'place for community-level initialization to occur. They are run before any
#'species-specific
#'initialize() callbacks are run, so you might wish to set up all of your model
#'parameters in one,
#'providing a single location for all parameters. In multispecies models, the
#'initialization functions
#'initializeSLiMModelType() and initializeInteractionType() may only be called
#'from a nonspecies-
#'specific initialize() callback, since those aspects of model configuration span
#'the entire
#'community. In single-species models, these functions may be called from an
#'ordinary
#'initialize() callback for simplicity and backward compatibility.
#'Once all initialize() callbacks have executed, in the order in which they are
#'specified in the
#'SLiM input file, the simulation will begin. The tick number at which it starts
#'is determined by the
#'Eidos events you have defined (see section 25.1); the first tick in which an
#'Eidos event is scheduled
#'to execute is the tick at which the simulation starts. Similarly, the simulation
#'will terminate after
#'the last tick for which a script block (either an event or a callback) is
#'registered to execute, unless
#'the stop() function or the simulationFinished() method of Community or Species
#'are called to
#'end the simulation earlier.
#'This class has the following methods (functions):
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
#'\item{\code{\link{initializeSpecies}}}
#'\item{\code{\link{initializeTreeSeq}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{None.}{This class has no properties.}
#'}
NULL
#'Chromosome
#'
#'Documentation for Chromosome class from SLiM
#'
#'@name Chromosome
#'@export
#'@aliases Ch
#'@family Chromosome
#'@details This class represents the layout and properties of the chromosome being
#'simulated. The
#'chromosome currently being simulated is available through the sim.chromosome
#'global. Section
#'1.5.4 presents an overview of the conceptual role of this class.
#'This class has the following methods (functions):
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
#'are "simple" (i.e., not involving resolution of heteroduplex mismatches);
#'the remainder will be "complex". When gene conversion has not been enabled by
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
#'\strong{Property Description:} The last valid position in the chromosome;
#'its length, essentially. Note that the chromosome length is determined by
#'the maximum of the end of the last genomic element, the end of the last
#'recombination region, and the end of the last mutation map region (or hotspot
#'map region). }
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
#'using sex-specific mutation rate maps, this property will be unavailable;
#'see mutationRatesF and mutationRatesM. This property is unavailable in
#'nucleotide-based models. }
#'\item{mutationRatesF}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The mutation rate for
#'each of the mutation rate regions specified by mutationEndPositionsF, when
#'using sex-specific mutation rate maps; unavailable otherwise. This property is
#'unavailable in nucleotide-based models. }
#'\item{mutationRatesM}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The mutation rate for
#'each of the mutation rate regions specified by mutationEndPositionsM, when
#'using sex-specific mutation rate maps; unavailable otherwise. This property is
#'unavailable in nucleotide-based models. }
#'\item{overallMutationRate}{A property of type float. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The overall mutation rate across the whole
#'chromosome determining the overall number of mutation ranges and rates as well
#'as the coverage of the chromosome by genomic elements (since mutations are only
#'generated within genomic elements, regardless of the mutation rate map). When
#'using sex- specific mutation rate maps, this property will unavailable; see
#'overallMutationRateF and overallMutationRateM. This property is unavailable in
#'nucleotide-based models. }
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
#'\item{species}{A property of type Species object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The species to which the target object belongs. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use.}
#'
#'}
NULL
#'Community
#'
#'Documentation for Community class from SLiM
#'
#'@name Community
#'@export
#'@aliases Co
#'@family Community
#'@details This class represents the top level of a SLiM simulation: a community
#'containing one or more
#'species (represented by class Species). The community, represented by a global
#'Community object
#'with the variable name community, is responsible for execution of the tick cycle
#'for active species
#'in each tick, management of the script blocks associated with a simulation, and
#'creation of log
#'files (by creating and owning instances of the LogFile class). The community
#'exists even in singlespecies
#'models.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{createLogFile}}}
#'\item{\code{\link{deregisterScriptBlock}}}
#'\item{\code{\link{genomicElementTypesWithIDs}}}
#'\item{\code{\link{interactionTypesWithIDs}}}
#'\item{\code{\link{mutationTypesWithIDs}}}
#'\item{\code{\link{outputUsage}}}
#'\item{\code{\link{registerEarlyEvent}}}
#'\item{\code{\link{registerFirstEvent}}}
#'\item{\code{\link{registerInteractionCallback}}}
#'\item{\code{\link{registerLateEvent}}}
#'\item{\code{\link{rescheduleScriptBlock}}}
#'\item{\code{\link{scriptBlocksWithIDs}}}
#'\item{\code{\link{simulationFinished}}}
#'\item{\code{\link{speciesWithIDs}}}
#'\item{\code{\link{subpopulationsWithIDs}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{allGenomicElementTypes}{A property of type GenomicElementType object. This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'All of the GenomicElementType objects defined in the simulation. }
#'\item{allInteractionTypes}{A property of type InteractionType object. This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'All of the InteractionType objects defined in the simulation. }
#'\item{allMutationTypes}{A property of type MutationType object. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} All of the
#'MutationType objects defined in the simulation. }
#'\item{allScriptBlocks}{A property of type SLiMEidosBlock object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} All
#'registered SLiMEidosBlock objects in the simulation. }
#'\item{allSpecies}{A property of type Species object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All of the
#'Species objects defined in the simulation (in species declaration order). }
#'\item{allSubpopulations}{A property of type Subpopulation object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} All of
#'the Subpopulation objects defined in the simulation. }
#'\item{cycleStage}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The current cycle stage, as a string. The values of this property
#'essentially mirror the cycle stages of WF and nonWF models (see chapters 22
#'and 23). Common values include "first" (during execution of first() events),
#'"early" (during execution of early() events), "reproduction" (during offspring
#'generation), "fitness" (during fitness evaluation), "survival" (while applying
#'selection and mortality in nonWF models), and "late" (during execution of late()
#'events). Other possible values include "begin" (during internal setup before
#'each cycle), "tally" (while tallying mutation reference counts and removing
#'fixed mutations), "swap" (while swapping the offspring generation into the
#'parental generation in WF models), "end" (during internal bookkeeping after
#'each cycle), and "console" (during the in-between-ticks state in which commands
#'in SLiMgui's Eidos console are executed). It would probably be a good idea not
#'to use this latter set of values; they are probably not user-visible during
#'ordinary model execution anyway. During execution of initialize() callbacks, no
#'Community object yet exists and so this property cannot be accessed. To detect
#'this state, use exists("community"); if that is F, community does not exist, and
#'therefore your code is executing during initialize() callbacks (or outside of
#'SLiM entirely, in some other Eidos-based context). }
#'\item{logFiles}{A property of type LogFile object. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The LogFile objects
#'being used in the simulation. }
#'\item{modelType}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The type of model being simulated, as specified in
#'initializeSLiMModelType(). This will be "WF" for WF models (Wright-Fisher
#'models, the default), or "nonWF" for nonWF models (non-Wright-Fisher models;
#'see section 1.6 for discussion). This must be the same for all species in the
#'community; it is therefore a property on Community, not Species. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'the simulation. }
#'\item{tick}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:} The
#'current tick number. }
#'\item{verbosity}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The verbosity level, for SLiM's logging of information about the simulation.
#'This is 1 by default, but can be changed at the command line with the -l[ong]
#'option. It is provided here so that scripts can consult it to govern the level
#'of verbosity of their own output, or set the verbosity level for particular
#'sections of their code. A verbosity level of 0 suppresses most of SLiM's
#'optional output; 2 adds some extra output beyond SLiM's standard output. See
#'sections 20.3 and 21.4 for more information.}
#'
#'}
NULL
#'Genome
#'
#'Documentation for Genome class from SLiM
#'
#'@name Genome
#'@export
#'@aliases G
#'@family Genome
#'@details This class represents one full genome of an individual (one of the two
#'genomes contained by a
#'diploid individual, that is, in the way that SLiM uses the term), composed of
#'the mutations carried
#'by that individual. Section 1.5.1 presents an overview of the conceptual role of
#'this class.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addMutations}}}
#'\item{\code{\link{addNewDrawnMutation}}}
#'\item{\code{\link{addNewMutation}}}
#'\item{\code{\link{containsMarkerMutation}}}
#'\item{\code{\link{containsMutations}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{mutationCountsInGenomes}}}
#'\item{\code{\link{mutationFrequenciesInGenomes}}}
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
#'initializeSLiMOptions(keepPedigrees=T), genomePedigreeID is a unique
#'non-negative identifier for each genome in a simulation, never re- used
#'throughout the duration of the simulation run. Furthermore, the genomePedigreeID
#'of a given genome will be equal to either (2*pedigreeID) or (2*pedigreeID + 1)
#'of the individual that the genome belongs to (the former for the first genome
#'of the individual, the latter for the second genome of the individual); this
#'invariant relationship is guaranteed. If pedigree tracking is not enabled, this
#'property is unavailable. }
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
#'\strong{Property Description:} T if the genome is a "null" genome, F if it is
#'an ordinary genome object. When a sex chromosome (X or Y) is simulated, the
#'other sex chromosome also exists in the simulation, but it is a "null" genome
#'that does not carry any mutations. Instead, it is a placeholder, present to
#'allow SLiM's code to operate in much the same way as it does when an autosome is
#'simulated. Null genomes should not be accessed or manipulated. }
#'\item{mutations}{A property of type Mutation object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All of the
#'Mutation objects present in this genome. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. Note that the Genome objects used by SLiM are new with every new
#'individual, so the tag value of each new offspring generated in each tick will
#'be initially undefined.}
#'
#'}
NULL
#'GenomicElement
#'
#'Documentation for GenomicElement class from SLiM
#'
#'@name GenomicElement
#'@export
#'@aliases GE
#'@family GenomicElement
#'@details This class represents a genomic element of a particular genomic element
#'type, with a start and
#'end; the chromosome is composed of a series of such genomic elements. Section
#'1.5.4 presents
#'an overview of the conceptual role of this class.
#'This class has the following methods (functions):
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
NULL
#'GenomicElementType
#'
#'Documentation for GenomicElementType class from SLiM
#'
#'@name GenomicElementType
#'@export
#'@aliases GET
#'@family GenomicElementType
#'@details This class represents a type of genomic element, with particular
#'mutation types. The genomic
#'element types currently defined in the simulation are defined as global
#'constants with the same
#'names used in the SLiM input file - g1, g2, and so forth. Section 1.5.4 presents
#'an overview of the
#'conceptual role of this class.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{setMutationFractions}}}
#'\item{\code{\link{setMutationMatrix}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The color used to display genomic elements of this type in SLiMgui. Outside
#'of SLiMgui, this property still exists, but is not used by SLiM. Colors may be
#'specified by name, or with hexadecimal RGB values of the form "#RRGGBB" (see the
#'Eidos manual). If color is the empty string, "", SLiMgui's default color scheme
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
#'\item{species}{A property of type Species object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The species to which the target object belongs. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'genomic element types.}
#'
#'}
NULL
#'Individual
#'
#'Documentation for Individual class from SLiM
#'
#'@name Individual
#'@export
#'@aliases In
#'@family Individual
#'@details This class represents a single simulated individual. Individuals in
#'SLiM are diploid, and thus
#'contain two Genome objects. Most functionality in SLiM is contained in the
#'Genome class; the
#'Individual class is mostly a convenient way to treat the pairs of genomes
#'associated with an
#'individual as a single object, and to associate a tag value with individuals.
#'Section 1.5.1 presents
#'an overview of the conceptual role of this class.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{containsMutations}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{relatedness}}}
#'\item{\code{\link{setSpatialPosition}}}
#'\item{\code{\link{sumOfMutationsOfType}}}
#'\item{\code{\link{uniqueMutationsOfType}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{age}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The age of the individual, measured in cycles. A newly generated offspring
#'individual will have an age of 0 in the same tick in which it was created. The
#'age of every individual is incremented by one at the same point that its species
#'cycle counter is incremented, at the end of the tick cycle, if and only if its
#'species was active in that tick. The age of individuals may be changed; usually
#'this only makes sense when setting up the initial state of a model, however. }
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The color used to display the individual in SLiMgui. Outside of SLiMgui, this
#'property still exists, but is not used by SLiM. Colors may be specified by name,
#'or with hexadecimal RGB values of the form "#RRGGBB" (see the Eidos manual). If
#'color is the empty string, "", SLiMgui's default (fitness-based) color scheme
#'is used; this is the default for new Individual objects. Note that named colors
#'will be converted to RGB internally, so the value of this property will always
#'be a hexadecimal RGB color string (or ""). }
#'\item{fitnessScaling}{A property of type float. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} A float scaling factor applied to the individual's fitness
#'(i.e., the fitness value computed for the individual will be multiplied by this
#'value). This provides a simple, fast way to modify the fitness of an individual;
#'conceptually it is similar to returning a fitness effect for the individual from
#'a fitnessEffect() callback, but without the complexity and performance overhead
#'of implementing such a callback. To scale the fitness of all individuals
#'in a subpopulation by the same factor, see the fitnessScaling property of
#'Subpopulation. The value of fitnessScaling is reset to 1.0 every tick, so
#'that any scaling factor set lasts for only a single tick. This reset occurs
#'immediately after fitness values are calculated, in both WF and nonWF models. }
#'\item{genomes}{A property of type Genome object. This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The pair of Genome objects
#'associated with this individual. If only one of the two genomes is desired, the
#'genome1 or genome2 property may be used. }
#'\item{genomesNonNull}{A property of type Genome object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The pair of
#'Genome objects associated with this individual, as with the genomes property, if
#'both are not null genomes. If one or both are null genomes, the null genomes are
#'excluded from the returned vector. This is a convenience shorthand, sometimes
#'useful in models that involve null genomes. }
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
#'\item{meanParentAge}{A property of type float. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The average age of the parents of this
#'individual, measured in cycles. Parentless individuals will have a meanParentAge
#'of 0.0. The mean parent age is determined when a new offspring is generated,
#'from the age property of the parent or parents involved in generating the
#'offspring. For addRecombinant() that is somewhat complex; see that method for
#'details. }
#'\item{migrant}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} Set to T if the individual is a recent migrant, F otherwise. The
#'definition of "recent" depends upon the model type (WF or nonWF). In WF models,
#'this flag is set at the point when a new child is generated if it is a migrant
#'(i.e., if its source subpopulation is not the same as its subpopulation), and
#'remains valid, with the same value, for the rest of the individual's lifetime.
#'In nonWF models, this flag is F for all new individuals, is set to F in all
#'individuals at the end of the reproduction tick cycle stage, and is set to T on
#'all individuals moved to a new subpopulation by takeMigrants() or a survival()
#'callback; the T value set by takeMigrants() or survival() will remain until it
#'is reset at the end of the next reproduction tick cycle stage. }
#'\item{pedigreeID}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If pedigree tracking is turned on with
#'initializeSLiMOptions(keepPedigrees=T), pedigreeID is a unique non-negative
#'identifier for each individual in a simulation, never re-used throughout the
#'duration of the simulation run. If pedigree tracking is not enabled, this
#'property is unavailable. }
#'\item{pedigreeParentIDs}{A property of type integer. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'pedigreeParentIDs contains the values of pedigreeID that were possessed by
#'the parents of an individual; it is thus a vector of two values. If pedigree
#'tracking is not enabled, this property is unavailable. Parental values may be -1
#'if insufficient ticks have elapsed for that information to be available (because
#'the simulation just started, or because a subpopulation is new). }
#'\item{pedigreeGrandparentIDs}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'pedigreeGrandparentIDs contains the values of pedigreeID that were possessed
#'by the grandparents of an individual; it is thus a vector of four values. If
#'pedigree tracking is not enabled, this property is unavailable. Grandparental
#'values may be -1 if insufficient ticks have elapsed for that information to be
#'available (because the simulation just started, or because a subpopulation is
#'new). }
#'\item{reproductiveOutput}{A property of type integer. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If pedigree tracking is turned on with
#'initializeSLiMOptions(keepPedigrees=T), reproductiveOutput contains the
#'number of offspring for which this individual has been a parent. If pedigree
#'tracking is not enabled, this property is unavailable. If an individual is
#'a parent by cloning or selfing, or as both parents for a biparental mating,
#'this value is incremented by two. Involvement of an individual as a parent
#'for an addRecombinant() call does not change this property's value, since the
#'reproductive contribution in that case is unclear; one must conduct separate
#'bookkeeping for that case if necessary. See also the Subpopulation property
#'lifetimeReproductiveOutput. }
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
#'encompassed by the simulation's dimensionality. This property cannot be set, but
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
#'and setValue() methods (provided by the Dictionary class; see the Eidos manual),
#'for another way of attaching state to individuals. Note that the Individual
#'objects used by SLiM are new for every new offspring, so the tag value of each
#'new offspring generated in each tick will be initially undefined. }
#'\item{tagF}{A property of type float. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined float value (as opposed to tag, which is of type integer).
#'The value of tagF is initially undefined, and it is an error to try to read
#'it; if you wish it to have a defined value, you must arrange that yourself
#'by explicitly setting its value prior to using it elsewhere in your code. The
#'value of tagF is not used by SLiM; it is free for you to use. See also the
#'getValue() and setValue() methods (provided by the Dictionary class; see the
#'Eidos manual), for another way of attaching state to individuals. Note that at
#'present, although many classes in SLiM have an integer-type tag property, only
#'Individual has a float-type tagF property, because attaching model state to
#'individuals seems to be particularly common and useful. If a tagF property would
#'be helpful on another class, it would be easy to add. See the description of the
#'tag property above for additional comments. }
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
#'the optional "continuous space" facility is enabled with the dimensionality
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
#'the optional "continuous space" facility is enabled with the dimensionality
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
#'the optional "continuous space" facility is enabled with the dimensionality
#'parameter to initializeSLiMOptions(), in which case z will be understood to
#'represent the z coordinate of the individual in space (if the dimensionality is
#'"xyz"). If continuous space is not enabled, or the dimensionality is not "xyz",
#'you may use z as an additional tag value of type float.}
#'
#'}
NULL
#'InteractionType
#'
#'Documentation for InteractionType class from SLiM
#'
#'@name InteractionType
#'@export
#'@aliases IT
#'@family InteractionType
#'@details This class represents a type of interaction between individuals. This
#'is an advanced feature, the
#'use of which is optional. Once an interaction type is set up with
#'initializeInteractionType()
#'(see section 24.1), it can be evaluated and then queried to give information
#'such as the nearest
#'interacting neighbors of an individual, or the total strength of interactions
#'felt by an individual,
#'relatively efficiently.
#'There are two types of individual, in the paradigm provided by InteractionType:
#'the receiver of
#'an interaction, and the exerter of that interaction. The same individual might
#'be a receiver for one
#'interaction and the exerter for another interaction, and both of those
#'interactions might be
#'governed by the same InteractionType, but nevertheless, for any given
#'interaction the distinction
#'remains important. The distinction is important because InteractionType enforces
#'this
#'directionality - from exerters, to receivers - throughout its design.
#'Interactions therefore
#'fundamentally define a one-to-many relationship, from one receiver to the
#'(potentially) many
#'exerters that act upon that receiver. In using InteractionType, you will
#'generally start with a
#'receiver, and ask an InteractionType object to handle a query about that
#'receiver, such as "what
#'are the ten nearest exerters to this receiver?". InteractionType is optimized to
#'find and return the
#'set of exerters influencing a given receiver; it is not optimized for the
#'reverse, finding and returning
#'the set of receivers influenced by a given exerter. (If that seems desirable,
#'you might wish to flip
#'your perspective and regard the interaction as actually working in the opposite
#'direction!)
#'Interactions are usually spatial, depending upon the spatial dimensionality
#'established with
#'initializeSLiMOptions() (section 24.1), but they do not have to be spatial. For
#'spatial
#'interactions, the strength of the interaction from an exerter to a receiver
#'often depends (partly, at
#'least) upon the distance between the two; nearby exerters often wield a stronger
#'influence upon a
#'receiver than more distant exerters do. Non-spatial interactions, on the other
#'hand, are of course
#'unrelated to distance, and the strength of interaction between two individuals
#'depends entirely
#'upon other factors, expressed by an interaction() callback in the model script.
#'Spatial
#'interactions can use interaction() callbacks too, to modify interaction
#'strengths calculated by
#'SLiM, if factors other than distance need to influence the strength of
#'interactions.
#'Note that if there are N receivers to be assessed, each of which potentially
#'interacts with M
#'possible exerters, then - depending upon the queries executed - InteractionType
#'may take
#'computational time proportional to N×log(N)×M. If every individual interacts
#'with every other, M
#'is equal to N and there will be N2 interactions to be evaluated, and the overall
#'computational time
#'may be as bad as N2log(N), although in practice it is perhaps closer to N2 -
#'still bad. Modeling
#'interactions with large population sizes can therefore be very expensive,
#'although
#'InteractionType goes to considerable lengths to minimize the overhead. To reduce
#'this
#'computational burden for your models, it is essential to reduce N, M or both.
#'Spatial interactions
#'can have - and almost always should have - a maximum distance, which allows them
#'to be
#'evaluated much more efficiently (since all interactions beyond the maximum
#'distance can be
#'assumed to have a strength of zero); setting this maximum distance to be as
#'small as possible,
#'without introducing unwanted artifacts, is the single most important factor for
#'using
#'InteractionType efficiently. For sexual models, interactions that are specific
#'to the sexes in a
#'particular way (males competing with other males, males competing to mate with
#'females, etc.)
#'can be declared to be sex-specific, which can also substantially reduce the
#'overhead of querying
#'them.
#'We will focus, in the remaining discussion, on spatial interactions since they
#'are more
#'common. The first step in InteractionType's evaluation of a spatial interaction
#'is to determine the
#'distance from the individual receiving the interaction (the receiver) to the
#'individual exerting the
#'interaction (the exerter). This is computed as the Euclidean distance between
#'the spatial positions
#'of the individuals, based upon the spatiality of the interaction (i.e., the
#'spatial dimensions used by
#'the interaction, which may be less than the dimensionality of the simulation as
#'a whole). If the
#'receiver and exerter occupy different subpopulations, it is assumed that they
#'nevertheless occupy
#'the same coordinate system; this can be particularly useful for evaluating
#'interactions between
#'individuals of different species. Second, this distance is compared to the
#'maximum distance for
#'the interaction type; if it is beyond that limit, the interaction strength is
#'always zero (and it is also
#'always zero for the interaction of an individual with itself). Third (when the
#'distance is less than
#'the maximum), the distance is converted into an interaction strength by an
#'interaction function (IF),
#'which is a characteristic of the InteractionType. Finally, this interaction
#'strength may be modified
#'by the interaction() callbacks currently active in the simulation, if any (see
#'section 25.7).
#'InteractionType is actually a wrapper for three different spatial query engines
#'that share some
#'of their data but work very differently. The first engine is a brute-force
#'engine that simply
#'computes distances and interaction strengths in response to queries. This engine
#'is usually used in
#'response to queries for simple information, such as the distance(),
#'distanceToPoint(), and
#'strength() methods.
#'The second engine is based upon a data structure called a "k-d tree" that is
#'designed to
#'optimize searches for spatially proximate points. This engine is usually used
#'directly in response to
#'queries involving "neighbors", such as nearestNeighbors() and
#'nearestNeighborsOfPoint(). In
#'SLiM, the term "neighbor" means an individual that is within the maximum
#'interaction distance of
#'a receiver (excluding the receiver itself) or a focal point; the neighbors of
#'the receiver or point are
#'therefore those that fall within the fixed radius defined by the maximum
#'interaction distance. Calls
#'with "neighbor" in their name explicitly use the k-d tree engine, and may
#'therefore be called only
#'for spatial interactions; in non-spatial interactions there is no concept of a
#'"neighbor". In terms of
#'computational complexity, finding the nearest neighbor of a given receiver by
#'brute force would be
#'an O(N) computation, whereas with the k-d tree it is typically an O(log N)
#'computation - a very
#'important difference, especially for large N. In general, to get the best
#'performance from a spatial
#'model, you should use neighbor-based calls to make minimal queries when
#'possible. If all you
#'really care about is the distance to the nearest neighbor of a receiver, for
#'example, then use
#'nearestNeighbors() to find the neighbor and then call distance() to get the
#'distance to that
#'neighbor, rather than getting the distances to all individuals with distance()
#'and then using min()
#'to select the smallest.
#'The third engine, introduced in SLiM 3.1 and radically modified in SLiM 4, is
#'based upon a data
#'structure called a "sparse array" that is designed to track sparse non-zero
#'values within a dataset
#'that contains mostly zeros. It applies to spatial interactions because most
#'pairs of individuals
#'probably interact with a strength of zero (because typically N >> M, because few
#'individuals fall
#'within the maximum interaction radius from a given individual). In SLiM 4, the
#'full sparse array of
#'interactions is no longer calculated (as it was in SLiM 3); instead, single rows
#'of the sparse array
#'are calculated on demand, providing most of the benefits of the data structure
#'with only a tiny
#'fraction of the memory overhead. In InteractionType parlance, such a single row
#'of the sparse
#'array is called a sparse vector. Sparse vectors are used to temporarily cache
#'calculated distances
#'and strengths for interactions within a given subpopulation. They are built
#'using the k-d tree to
#'find the interacting neighbors of each individual, and once built they can
#'respond extremely
#'quickly to queries from methods such as totalOfNeighborStrengths(); the
#'interacting neighbors
#'of a given individual are already known, allowing response in O(M) time. These
#'sparse vectors are
#'built on demand, when queries that would benefit from them are made. For them to
#'be effective,
#'it is particularly important that a maximum interaction distance be used that is
#'as small as possible,
#'so beginning with SLiM 3.1 a warning is issued when no maximum distance is
#'defined for spatial
#'interactions.
#'As mentioned above, once an interaction distance has been found it is translated
#'into an
#'interaction strength by an interaction function. There are currently five
#'options for interaction
#'functions (IFs) in SLiM, represented by single-character codes:
#'"f" - a fixed interaction strength. This IF type has a single parameter, the
#'interaction strength to
#'be used for all interactions of this type. By default, interaction types use a
#'type "f" IF with a value
#'of 1.0, so interactions are binary: on within the maximum distance, off outside.
#'"l" - a linear interaction strength. This IF type has a single parameter, the
#'maximum interaction
#'strength to be used at distance 0.0. The interaction strength falls off
#'linearly, reaching exactly zero
#'at the maximum distance. In other words, for distance d, maximum interaction
#'distance dmax, and
#'maximum interaction strength fmax, the formula for this IF is f(d) = fmax(1 −
#'d / dmax).
#'"e" - A negative exponential interaction strength. This IF type is specified by
#'two parameters, a
#'maximum interaction strength and a shape parameter. The interaction strength
#'falls off non-
#'linearly from the maximum, and cuts off discontinuously at the maximum distance;
#'typically a
#'maximum distance is chosen such that the interaction strength at that distance
#'is very small
#'anyway. The IF for this type is f(d) = fmaxexp(−λd), where λ is the specified
#'shape parameter. Note
#'that this parameterization is not the same as for the Eidos function rexp().
#'"n" - A normal interaction strength (i.e., Gaussian, but "g" is avoided to
#'prevent confusion with
#'the gamma-function option provided for, e.g., MutationType). The interaction
#'strength falls off
#'non-linearly from the maximum, and cuts off discontinuously at the maximum
#'distance; typically a
#'maximum distance is chosen such that the interaction strength at that distance
#'is very small
#'anyway. This IF type is specified by two parameters, a maximum interaction
#'strength and a
#'standard deviation. The Gaussian IF for this type is f(d) = fmaxexp(−d2/2σ2),
#'where σ is the standard
#'deviation parameter. Note that this parameterization is not the same as for the
#'Eidos function
#'rnorm(). A Gaussian function is often used to model spatial interactions, but is
#'relatively
#'computation-intensive.
#'"c" - A Cauchy-distributed interaction strength. The interaction strength falls
#'off non-linearly
#'from the maximum, and cuts off discontinuously at the maximum distance;
#'typically a maximum
#'distance is chosen such that the interaction strength at that distance is very
#'small anyway. This IF
#'type is specified by two parameters, a maximum interaction strength and a scale
#'parameter. The IF
#'for this type is f(d) = fmax/(1+(d/λ)2), where λ is the scale parameter. Note
#'that this parameterization
#'is not the same as for the Eidos function rcauchy(). A Cauchy distribution can
#'be used to model
#'interactions with relatively fat tails.
#'An InteractionType may be created using the initializeInteractionType() function
#'(see
#'section 24.1). It must then be evaluated, with the evaluate() method, for the
#'subpopulations
#'containing exerters and receivers before it will respond to queries regarding
#'individuals in those
#'subpopulations; querying with exerters or receivers whose subpopulations have
#'not been
#'evaluated will result in an error. Calling evaluate() causes the positions of
#'all receivers and
#'exerters to be cached, thus defining a snapshot in time that the InteractionType
#'will then use to
#'respond to queries (allowing it to build its k-d tree based upon the snapshot
#'positions). In WF
#'models, this evaluated state will last until the current parental generation
#'expires, at the end of the
#'next offspring-generation stage. Before the InteractionType may be used with the
#'new parental
#'generation (the offspring of the old parental generation), the interaction must
#'be evaluated again.
#'In nonWF models, interactions are invalidated twice during the tick cycle: once
#'after new offspring
#'are produced (just before early() events), and once just before individuals die
#'(just after fitness
#'calculations); they are also invalidated any time takeMigrants() is called to
#'move individuals
#'between subpopulations. Note that interaction() callbacks are called when
#'queries are served,
#'not when evaluate() is called.
#'InteractionType will automatically account for any periodic spatial boundaries
#'established
#'with the periodicity parameter of initializeSLiMOptions(); interactions will
#'wrap around the
#'periodic boundaries without any additional configuration of the interaction.
#'Interactions involving
#'periodic spatial boundaries entail some additional overhead in both memory usage
#'and processor
#'time; in particular, setting up the k-d tree after the interaction is evaluated
#'may take many times
#'longer than in the non-periodic case (but this is rarely a bottleneck anyway).
#'Once the k-d tree has
#'been set up, responses to spatial queries involving it should then be nearly as
#'fast as in the non-
#'periodic case. Spatial queries that do not involve the k-d tree will generally
#'be marginally slower
#'than in the non-periodic case, but the difference should not be large.
#'InteractionType provides a fairly large and confusingly similar set of methods,
#'designed to
#'answer every common type of spatial query efficiently. To help find the right
#'method for the job,
#'here is a summary of the methods that involve distances or interaction
#'strengths, either between
#'receivers and exerters, or between a focal point and exerters:
#'Consider whether you want to query for neighbors (all individual near the
#'receiver), for
#'interacting neighbors (nearby individuals that exert an interaction strength
#'upon the receiver,
#'regardless of what that strength is), or for something about the actual
#'interaction strengths. In
#'general, the simpler queries will be faster; finding neighbors is faster than
#'finding interacting
#'neighbors, which is in turn faster than actually evaluating strengths.
#'Furthermore, counting
#'individuals is faster than actually returning the individuals in question. The
#'last three methods in
#'the table have to evaluate the interaction strength between a receiver and every
#'exerter that
#'interacts with it, so they can be quite slow; if you can, for example, simply
#'count the number of
#'neighbors with neighborCount(), rather than using totalOfNeighborStrengths() to
#'sum up their
#'interaction strengths, the former will likely be significantly faster than the
#'latter. As has been
#'mentioned above, for best performance the maximum interaction distance should be
#'set to as
#'small a value as possible.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{clippedIntegral}}}
#'\item{\code{\link{distance}}}
#'\item{\code{\link{distanceFromPoint}}}
#'\item{\code{\link{drawByStrength}}}
#'\item{\code{\link{evaluate}}}
#'\item{\code{\link{interactingNeighborCount}}}
#'\item{\code{\link{interactionDistance}}}
#'\item{\code{\link{localPopulationDensity}}}
#'\item{\code{\link{nearestInteractingNeighbors}}}
#'\item{\code{\link{nearestNeighbors}}}
#'\item{\code{\link{nearestNeighborsOfPoint}}}
#'\item{\code{\link{neighborCount}}}
#'\item{\code{\link{neighborCountOfPoint}}}
#'\item{\code{\link{setInteractionFunction}}}
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
#'\item{sexSegregation}{A property of type integer or float or logical or
#'string or string or integer. It is of length one (a singleton). This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'sex-segregation of the interaction, as specified in initializeInteractionType().
#'For non- sexual simulations, this will be "**". For sexual simulations, this
#'string value indicates the sex of individuals feeling the interaction, and the
#'sex of individuals exerting the interaction; see initializeInteractionType() for
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
#'and setValue() methods (provided by the Dictionary class; see the Eidos manual),
#'for another way of attaching state to interaction types.}
#'
#'}
NULL
#'LogFile
#'
#'Documentation for LogFile class from SLiM
#'
#'@name LogFile
#'@export
#'@aliases LF
#'@family LogFile
#'@details LogFile is a class that can, optionally, be used to log out a table of
#'information about the
#'running simulation to a text file. The information logged out is completely
#'configurable with
#'generators, including the ability to use custom Eidos code as a generator. The
#'resulting file can be
#'formatted with comma separators (a CSV file), tab separators (a TSV file), or
#'with any custom
#'separator string between data values. The file can be plain text or can be
#'compressed in .gz
#'format (decompressible at the command line with the gunzip utility, among other
#'tools). When
#'compression is enabled, writes out to disk are buffered in memory for better
#'performance and
#'smaller file size. A new LogFile object attached to the simulation can be
#'created with the
#'Community method createLogFile(), discussed in section 24.3.2. Any number of
#'LogFile objects
#'can be active simultaneously, writing to different files.
#'Logging can be done automatically, at the end of ticks at a given periodic
#'interval (e.g., every
#'10th tick). This automatic logging is optional, and a log row can always be
#'generated explicitly by
#'called logRow(). Flushing compressed data to disk can be done automatically
#'after a given
#'number of rows have been generated, or can be requested explicitly with a call
#'to flush().
#'Generators always generate a single value in each logged row, resulting in a
#'single column of
#'data in the log file. Some built-in generators are provided by LogFile for the
#'most common cases;
#'these can be added to a given LogFile by calling the add...() methods documented
#'below. A
#'generator with custom Eidos code can be added with addCustomColumn(), and a
#'generator that
#'expects to be supplied with the value to write, rather than generating the value
#'itself, can be added
#'with addSuppliedColumn(). LogFile expects to be fully configured, with calls to
#'add...()
#'methods to add generators, before the first row of data is written out, to
#'ensure consistency in the
#'file's data. When the first row of data is written (or buffered), the LogFile's
#'configuration will then
#'be frozen, and calls to add...() will no longer be allowed. Columns will be
#'written, in each row,
#'in the order in which add...() calls are made on the LogFile, and they will be
#'named in the file's
#'header line as documented in those methods. It is an error to have two columns
#'with the same
#'name.
#'LogFile is a subclass of the Eidos class Dictionary, but unlike other SLiM
#'classes that are
#'Dictionary subclasses, this does not allow you to attach arbitrary key-value
#'pairs to the object.
#'Instead, LogFile uses its Dictionary-ness to make the data from the last logged
#'row available
#'through getValue(), using the name of the generator (i.e., the name of the data
#'column) as the
#'key. One quirk of LogFile is that because its keys are defined by the columns
#'that it generates,
#'and columns can sometimes contain an NA value, LogFile's dictionary can, in
#'effect, contain NULL
#'values (representing NA); this is not normally allowed by Dictionary. This
#'should cause no trouble;
#'just be aware that getValue() on a LogFile might return NULL for a key,
#'representing NA, and that
#'the result of serialize() might contain NA values.
#'Finally: as a general rule, if a Subpopulation is referenced by one of the
#'add...X() methods
#'below it may be supplied as an object if it already exists (p1), or by id (1)
#'even if it does not yet
#'exist. The resulting column will generally have a name of the form pX_colname,
#'where X is the id
#'of the specified subpopulation. If a subpopulation-specific data logger refers
#'to a Subpopulation
#'that does not exist at the time a given row is logged, NA will be written.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addCustomColumn}}}
#'\item{\code{\link{addCycle}}}
#'\item{\code{\link{addCycleStage}}}
#'\item{\code{\link{addKeysAndValuesFrom}}}
#'\item{\code{\link{addMeanSDColumns}}}
#'\item{\code{\link{addPopulationSexRatio}}}
#'\item{\code{\link{addPopulationSize}}}
#'\item{\code{\link{addSubpopulationSexRatio}}}
#'\item{\code{\link{addSubpopulationSize}}}
#'\item{\code{\link{addSuppliedColumn}}}
#'\item{\code{\link{addTick}}}
#'\item{\code{\link{clearKeysAndValues}}}
#'\item{\code{\link{flush}}}
#'\item{\code{\link{logRow}}}
#'\item{\code{\link{setLogInterval}}}
#'\item{\code{\link{setFilePath}}}
#'\item{\code{\link{setSuppliedValue}}}
#'\item{\code{\link{setValue}}}
#'\item{\code{\link{willAutolog}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{allKeys}{A property of type string or string or integer or integer or
#'integer. This property is a constant, so it is not modifiable. \strong{Property
#'Description:} This Dictionary property has an override in LogFile to return,
#'in order, the names of the log file columns, which are the keys for LogFile's
#'dictionary. }
#'\item{filePath}{A property of type string or string or integer or integer or
#'integer. It is of length one (a singleton). This property is a constant, so it
#'is not modifiable. \strong{Property Description:} The path of the log file being
#'written to. This may be changed with setFilePath(). }
#'\item{logInterval}{A property of type string or string or integer or integer
#'or integer. It is of length one (a singleton). This property is a constant, so
#'it is not modifiable. \strong{Property Description:} The interval for automatic
#'logging; a new row of data will be logged every logInterval ticks. This may
#'be changed with setLogInterval(). If automatic logging has been disabled, this
#'property will be 0. }
#'\item{precision}{A property of type string or string or integer or integer or
#'integer. It is of length one (a singleton). This property is a variable, so it
#'is modifiable. \strong{Property Description:} The precision of float output.
#'To be exact, precision specifies the preferred number of significant digits
#'that will be output for float values. The default is 6; values in [1,22] are
#'legal, but 17 is probably the largest value that makes sense given the limits of
#'double-precision floating point. }
#'\item{tag}{A property of type string or string or integer or integer or
#'integer. It is of length one (a singleton). This property is a variable, so
#'it is modifiable. \strong{Property Description:} A user-defined integer value.
#'The value of tag is initially undefined, and it is an error to try to read
#'it; if you wish it to have a defined value, you must arrange that yourself by
#'explicitly setting its value prior to using it elsewhere in your code. The value
#'of tag is not used by SLiM; it is free for you to use.}
#'
#'}
NULL
#'Mutation
#'
#'Documentation for Mutation class from SLiM
#'
#'@name Mutation
#'@export
#'@aliases M
#'@family Mutation
#'@details This class represents a single point mutation. Mutations can be shared
#'by the genomes of many
#'individuals; if they reach fixation, they are converted to Substitution objects.
#'Although Mutation has a tag property, like most SLiM classes, the subpopID can
#'also store
#'custom values if you don't need to track the origin subpopulation of mutations
#'(see below).
#'Section 1.5.2 presents an overview of the conceptual role of this class.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{setMutationType}}}
#'\item{\code{\link{setSelectionCoeff}}}
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
#'\item{isFixed}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} T if the mutation has fixed (in the SLiM sense of having been
#'converted to a Substitution object), F otherwise. Since fixed/substituted
#'mutations are removed from the simulation, you will only see this flag be T if
#'you have held onto a mutation beyond its usual lifetime (see section 27.2). }
#'\item{isSegregating}{A property of type logical. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} T if the mutation is segregating (in the SLiM
#'sense of not having been either lost or converted to a Substitution object), F
#'otherwise. Since both lost and fixed/substituted mutations are removed from the
#'simulation, you will only see this flag be F if you have held onto a mutation
#'beyond its usual lifetime (see section 27.2). Note that if isSegregating is F,
#'isFixed will let you determine whether the mutation is no longer segregating
#'because it was lost, or because it fixed. }
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
#'\item{originTick}{A property of type integer. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The tick in which this mutation arose. }
#'\item{position}{A property of type integer. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The position in the chromosome of this mutation. }
#'\item{selectionCoeff}{A property of type float. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The selection coefficient of the mutation, drawn
#'from the distribution of fitness effects of its MutationType. If a mutation
#'has a selectionCoeff of s, the multiplicative fitness effect of the mutation
#'in a homozygote is 1+s; in a heterozygote it is 1+hs, where h is the dominance
#'coefficient kept by the mutation type (see section 24.11.1). Note that this
#'property has a quirk: it is stored internally in SLiM using a single-precision
#'float, not the double-precision float type normally used by Eidos. This means
#'that if you set a mutation mut's selection coefficient to some number x,
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
#'14.7. If you don't care which subpopulation a mutation originated in, the
#'subpopID may be used as an arbitrary integer "tag" value for any purpose you
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
NULL
#'MutationType
#'
#'Documentation for MutationType class from SLiM
#'
#'@name MutationType
#'@export
#'@aliases MT
#'@family MutationType
#'@details This class represents a type of mutation with a particular distribution
#'of fitness effects, such as
#'neutral mutations or weakly beneficial mutations. Sections 1.5.3 and 1.5.4
#'present an overview of
#'the conceptual role of this class. The mutation types currently defined in the
#'simulation are
#'defined as global constants with the same names used in the SLiM input file -
#'m1, m2, and so forth.
#'There are currently six options for the distribution of fitness effects in SLiM,
#'represented by
#'single-character codes:
#'"f" - A fixed fitness effect. This DFE type has a single parameter, the
#'selection coefficient s to
#'be used by all mutations of the mutation type.
#'"g" - A gamma-distributed fitness effect. This DFE type is specified by two
#'parameters, a mean
#'value and a shape parameter. The gamma distribution from which mutations are
#'drawn is given by
#'the probability density function P(s | α,β) = [Γ(α)βα]−1sα−1exp(−s/β), where α
#'is the shape parameter,
#'and the specified mean for the distribution is equal to αβ. Note that this
#'parameterization is the
#'same as for the Eidos function rgamma(). A gamma distribution is often used to
#'model deleterious
#'mutations at functional sites.
#'"e" - An exponentially-distributed fitness effect. This DFE type is specified by
#'a single
#'parameter, the mean of the distribution. The exponential distribution from which
#'mutations are
#'drawn is given by the probability density function P(s | β) = β−1exp(−s/β),
#'where β is the specified
#'mean for the distribution. This parameterization is the same as for the Eidos
#'function rexp(). An
#'exponential distribution is often used to model beneficial mutations.
#'"n" - A normally-distributed fitness effect. This DFE type is specified by two
#'parameters, a
#'mean and a standard deviation. The normal distribution from which mutations are
#'drawn is given
#'by the probability density function P(s | μ,σ) = (2πσ2)−1/2exp(−(s−μ)2/2σ2),
#'where μ is the mean and σ
#'is the standard deviation. This parameterization is the same as for the Eidos
#'function rnorm(). A
#'normal distribution is often used to model mutations that can be either
#'beneficial or deleterious,
#'since both tails of the distribution are unbounded.
#'"w" - A Weibull-distributed fitness effect. This DFE type is specified by a
#'scale parameter and a
#'shape parameter. The Weibull distribution from which mutations are drawn is
#'given by the
#'probability density function P(s | λ,k) = (k/λk)sk−1exp(−(s/λ)k), where λ is the
#'scale parameter and k is
#'the shape parameter. This parameterization is the same as for the Eidos function
#'rweibull(). A
#'Weibull distribution is often used to model mutations following extreme-value
#'theory.
#'"s" - A script-based fitness effect. This DFE type is specified by a script
#'parameter of type
#'string, specifying an Eidos script to be executed to produce each new selection
#'coefficient. For
#'example, the script "return rbinom(1);" could be used to generate selection
#'coefficients drawn
#'from a binomial distribution, using the Eidos function rbinom(), even though
#'that mutational
#'distribution is not supported by SLiM directly. The script must return a
#'singleton float or integer.
#'Note that these distributions can in principle produce selection coefficients
#'smaller than -1.0.
#'In that case, the mutations will be evaluated as "lethal" by SLiM, and the
#'relative fitness of the
#'individual will be set to 0.0.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{drawSelectionCoefficient}}}
#'\item{\code{\link{setDistribution}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'The color used to display mutations of this type in SLiMgui. Outside of
#'SLiMgui, this property still exists, but is not used by SLiM. Colors may be
#'specified by name, or with hexadecimal RGB values of the form "#RRGGBB" (see
#'the Eidos manual). If color is the empty string, "", SLiMgui's default
#'(selection-coefficient-based) color scheme is used; this is the default for new
#'MutationType objects. }
#'\item{colorSubstitution}{A property of type string. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} The color used to display substitutions of this type in SLiMgui
#'(see the discussion for the colorSubstitution property of the Chromosome class
#'for details). Outside of SLiMgui, this property still exists, but is not used
#'by SLiM. Colors may be specified by name, or with hexadecimal RGB values of the
#'form "#RRGGBB" (see the Eidos manual). If colorSubstitution is the empty string,
#'"", SLiMgui's default (selection-coefficient-based) color scheme is used; this
#'is the default for new MutationType objects. }
#'\item{convertToSubstitution}{A property of type logical. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} This property governs whether mutations of this mutation type
#'will be converted to Substitution objects when they reach fixation. In WF models
#'this property is T by default, since conversion to Substitution objects provides
#'large speed benefits; it should be set to F only if necessary, and only on the
#'mutation types for which it is necessary. This might be needed, for example, if
#'you are using a mutationEffect() callback to implement an epistatic relationship
#'between mutations; a mutation epistatically influencing the fitness of other
#'mutations through a mutationEffect() callback would need to continue having that
#'influence even after reaching fixation, but if the simulation were to replace
#'the fixed mutation with a Substitution object the mutation would no longer be
#'considered in fitness calculations (unless the callback explicitly consulted
#'the list of Substitution objects kept by the simulation). Other script- defined
#'behaviors in mutationEffect(), interaction(), mateChoice(), modifyChild(), and
#'recombination() callbacks might also necessitate the disabling of substitution
#'for a given mutation type; this is an important consideration to keep in mind.
#'See section 22.3 for further discussion of convertToSubstitution in WF models.
#'In contrast, for nonWF models this property is F by default, because even
#'mutations with no epistatis or other indirect fitness effects will continue
#'to influence the survival probabilities of individuals. For nonWF models, only
#'neutral mutation types with no epistasis or other side effects can safely be
#'converted to substitutions upon fixation. When such a pure-neutral mutation
#'type is defined in a nonWF model, this property should be set to T to tell
#'SLiM that substitution is allowed; this may have very large positive effects
#'on performance, so it is important to remember when modeling background neutral
#'mutations. See section 23.5 for further discussion of convertToSubstitution
#'in nonWF models. SLiM consults this flag at the end of each tick when deciding
#'whether to substitute each fixed mutation. If this flag is T, all eligible
#'fixed mutations will be converted at the end of the current tick, even if they
#'were previously left unconverted because of the previous value of the flag.
#'Setting this flag to F will prevent future substitutions, but will not cause any
#'existing Substitution objects to be converted back into Mutation objects. }
#'\item{distributionParams}{A property of type float. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The parameters that
#'configure the chosen distribution of fitness effects. This will be of type
#'string for DFE type "s", and type float for all other DFE types. }
#'\item{distributionType}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The type of distribution of fitness effects; one
#'of "f", "g", "e", "n", "w", or "s" (see section 24.11, above). }
#'\item{dominanceCoeff}{A property of type float. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} The dominance coefficient used for mutations of this type when
#'heterozygous. Changing this will normally affect the fitness values calculated
#'toward the end of the current tick; if you want current fitness values to be
#'affected, you can call the Species method recalculateFitness() - but see the
#'documentation of that method for caveats. Note that the dominance coefficient
#'is not bounded. A dominance coefficient greater than 1.0 may be used to achieve
#'an overdominance effect. By making the selection coefficient very small and
#'the dominance coefficient very large, an overdominance scenario in which both
#'homozygotes have the same fitness may be approximated, to a nearly arbitrary
#'degree of precision. Note that this property has a quirk: it is stored
#'internally in SLiM using a single-precision float, not the double-precision
#'float type normally used by Eidos. This means that if you set a mutation type
#'muttype's dominance coefficient to some number x, muttype.dominanceCoeff==x may
#'be F due to floating-point rounding error. Comparisons of floating-point numbers
#'for exact equality is often a bad idea, but this is one case where it may fail
#'unexpectedly. Instead, it is recommended to use the id or tag properties to
#'identify particular mutation types. }
#'\item{haploidDominanceCoeff}{A property of type float. It is of length
#'one (a singleton). This property is a variable, so it is modifiable.
#'\strong{Property Description:} The dominance coefficient used for mutations
#'of this type when they occur opposite a null genome (as in sex-chromosome
#'models and models involving haploids). This defaults to 1.0, and is used
#'only in models where null genomes are present; the dominanceCoeff property
#'is the dominance coefficient used in most circumstances. Changing this will
#'normally affect the fitness values calculated toward the end of the current
#'tick; if you want current fitness values to be affected, you can call the
#'Species method recalculateFitness() - but see the documentation of that method
#'for caveats. As with the dominanceCoeff property, this is stored internally
#'using a single-precision float; see the documentation for dominanceCoeff for
#'discussion. }
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this mutation type; for mutation type m3, for example, this
#'is 3. }
#'\item{mutationStackGroup}{A property of type integer. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} The group into which this mutation type belongs for purposes of
#'mutation stacking policy. This is equal to the mutation type's id by default.
#'See mutationStackPolicy, below, for discussion. In nucleotide-based models,
#'the stacking group for nucleotide-based mutation types is always -1, and cannot
#'be changed. Non-nucleotide-based mutation types may also be set to share the
#'-1 stacking group, if they should participate in the same stacking policy as
#'nucleotide-based mutations, but that would be quite unusual. }
#'\item{mutationStackPolicy}{A property of type string. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} This property and the mutationStackGroup property together govern
#'whether mutations of this mutation type's stacking group can "stack" - can
#'occupy the same position in a single individual. A set of mutation types with
#'the same value for mutationStackGroup is called a "stacking group", and all
#'mutation types in a given stacking group must have the same mutationStackPolicy
#'value, which defines the stacking behavior of all mutations of the mutation
#'types in the stacking group. In other words, one stacking group might allow
#'its mutations to stack, while another stacking group might not, but the
#'policy within each stacking group must be unambiguous. This property is "s" by
#'default, indicating that mutations in this stacking group should be allowed to
#'stack without restriction. If the policy is set to "f", the first mutation of
#'stacking group at a given site is retained; further mutations of this stacking
#'group at the same site are discarded with no effect. This can be useful for
#'modeling one-way changes; once a gene is disabled by a premature stop codon,
#'for example, you might wish to assume, for simplicity, that further mutations
#'cannot alter that fact. If the policy is set to "l", the last mutation of this
#'stacking group at a given site is retained; earlier mutation of this stacking
#'group at the same site are discarded. This can be useful for modeling an
#'"infinite- alleles" scenario in which every new mutation at a site generates
#'a completely new allele, rather than retaining the previous mutations at the
#'site. The mutation stacking policy applies only within the given mutation type's
#'stacking group; mutations of different stacking groups are always allowed to
#'stack in SLiM. The policy applies to all mutations added to the model after
#'the policy is set, whether those mutations are introduced by calls such as
#'addMutation(), addNewMutation(), or addNewDrawnMutation(), or are added by
#'SLiM's own mutation-generation machinery. However, no attempt is made to
#'enforce the policy for mutations already existing at the time the policy is
#'set; typically, therefore, the policy is set in an initialize() callback so that
#'it applies throughout the simulation. The policy is also not enforced upon the
#'mutations loaded from a file with readFromPopulationFile(); such mutations were
#'governed by whatever stacking policy was in effect when the population file was
#'generated. In nucleotide-based models, the stacking policy for nucleotide-based
#'mutation types is always "l", and cannot be changed. This ensures that new
#'nucleotide mutations always replace the previous nucleotide at a site, and that
#'more than one nucleotide mutation is never present at the same position in a
#'single genome. }
#'\item{nucleotideBased}{A property of type logical. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If the mutation type was created with
#'initializeMutationType(), it is not nucleotide-based, and this property is F.
#'If it was created with initializeMutationTypeNuc(), it is nucleotide-based, and
#'this property is T. See those methods for further discussion. }
#'\item{species}{A property of type Species object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The species to which the target object belongs. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'mutation types.}
#'
#'}
NULL
#'SLiMBuiltin
#'
#'Documentation for SLiMBuiltin class from SLiM
#'
#'@name SLiMBuiltin
#'@export
#'@aliases SB
#'@family SLiMBuiltin
#'@details SLiM provides a small number of built-in functions, documented here.
#'Note that these are
#'distinct from the functions built into the Eidos language itself, which are
#'documented in the Eidos
#'manual.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{codonsToAminoAcids}}}
#'\item{\code{\link{mm16To256}}}
#'\item{\code{\link{mmJukesCantor}}}
#'\item{\code{\link{mmKimura}}}
#'\item{\code{\link{nucleotideCounts}}}
#'\item{\code{\link{nucleotideFrequencies}}}
#'\item{\code{\link{nucleotidesToCodons}}}
#'\item{\code{\link{calcFST}}}
#'\item{\code{\link{calcHeterozygosity}}}
#'\item{\code{\link{calcInbreedingLoad}}}
#'\item{\code{\link{calcPairHeterozygosity}}}
#'\item{\code{\link{calcVA}}}
#'\item{\code{\link{calcWattersonsTheta}}}
#'\item{\code{\link{summarizeIndividuals}}}
#'\item{\code{\link{treeSeqMetadata}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{None.}{This class has no properties.}
#'}
NULL
#'SLiMEidosBlock
#'
#'Documentation for SLiMEidosBlock class from SLiM
#'
#'@name SLiMEidosBlock
#'@export
#'@aliases SEB
#'@family SLiMEidosBlock
#'@details This class represents a block of Eidos code registered in a SLiM
#'simulation. All Eidos events and
#'Eidos callbacks defined in the SLiM input file of the current simulation are
#'instantiated as
#'SLiMEidosBlock objects and are available through the allScriptBlocks property of
#'Community and
#'the scriptBlocks property of Species; see sections 24.3.1 and 24.14.1. In
#'addition, new script
#'blocks can be created programmatically and registered with the simulation, and
#'registered script
#'blocks can be deregistered; see the ‑register...() and ‑deregisterScriptBlock()
#'methods of
#'Community and Species in sections 24.3.2 and 24.14.2. The currently executing
#'script block is
#'available through the self global; see section 25.11.
#'This class has the following methods (functions):
#'\itemize{
#'\item{None. This class has no methods.}
#'}
#'This class has the following properties:
#'\describe{
#'\item{active}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'If this evaluates to logical F (i.e., is equal to 0), the script block is
#'inactive and will not be called. The value of active for all registered script
#'blocks is reset to -1 at the beginning of each tick, prior to script events
#'being called, thus activating all blocks (except callbacks associated with
#'a species that is not active in that tick, which are deactivated as part of
#'the deactivation of the species). Any integer value other than -1 may be used
#'instead of -1 to represent that a block is active; for example, active may
#'be used as a counter to make a block execute a fixed number of times in each
#'tick. This value is not cached by SLiM; if it is changed, the new value takes
#'effect immediately. For example, a callback might be activated and inactivated
#'repeatedly during a single tick. }
#'\item{end}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The last tick in which the script block is active. }
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this script block; for script s3, for example, this is 3. A
#'script block for which no id was given will have an id of -1. }
#'\item{source}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The source code string of the script block. }
#'\item{speciesSpec}{A property of type Species object. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} The
#'species specifier for the script block. The species specifier for a callback
#'block indicates the callback's associated species; the callback is called
#'to modify the default behavior for that species. If the script block has no
#'species specifier, this property's value is a zero-length object vector of
#'class Species. This property is read-only; normally it is set by preceding
#'the definition of a callback with a species specifier, of the form species
#'<species-name>. }
#'\item{start}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The first tick in which the script block is active. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for you
#'to use. }
#'\item{ticksSpec}{A property of type Species object. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The ticks specifier for
#'the script block. The ticks specifier for an event block indicates the event's
#'associated species; the event executes only in ticks when that species is
#'active. If the script block has no ticks specifier, this property's value is a
#'zero-length object vector of class Species. This property is read-only; normally
#'it is set by preceding the definition of an event with a ticks specifier, of the
#'form ticks <species-name>. }
#'\item{type}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The type of the script block; this will be "first", "early", or "late" for
#'the three types of Eidos "mutation", "mutationEffect", "recombination",
#'"reproduction", or "survival" for the respective types of Eidos callbacks (see
#'section 24.1 and chapter 25).}
#'
#'}
NULL
#'SLiMSim
#'
#'Documentation for SLiMSim class from SLiM
#'
#'@name SLiMSim
#'@export
#'@aliases SS
#'@family SLiMSim
#'@details This class represents a SLiM simulation. The current SLiMSim instance
#'is defined as a global
#'constant named sim.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addSubpop}}}
#'\item{\code{\link{addSubpopSplit}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{createLogFile}}}
#'\item{\code{\link{deregisterScriptBlock}}}
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
#'\item{\code{\link{registerMutationCallback}}}
#'\item{\code{\link{registerRecombinationCallback}}}
#'\item{\code{\link{registerReproductionCallback}}}
#'\item{\code{\link{rescheduleScriptBlock}}}
#'\item{\code{\link{simulationFinished}}}
#'\item{\code{\link{subsetMutations}}}
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
#'call SLiMSim's method recalculateFitness() - but see the documentation of that
#'method for caveats. }
#'\item{generation}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The current generation number. }
#'\item{generationStage}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The current generation stage, as a string. The
#'values of this property essentially mirror the generation stages of WF and
#'nonWF models (see chapters 22 and 23). Common values include "early" (during
#'execution of early() events), "reproduction" (during offspring generation),
#'"fitness" (during fitness evaluation), and "late" (during execution of late()
#'events). Other possible values include "begin" (during internal setup before
#'each generation), "selection" (while applying selection and mortality in nonWF
#'models), "tally" (while tallying mutation reference counts and removing fixed
#'mutations), "swap" (while swapping the offspring generation into the parental
#'generation in WF models), "end" (during internal bookkeeping after each
#'generation), and "console" (during the in-between-generations state in which
#'commands in SLiMgui's Eidos console are executed). It would probably be a good
#'idea not to use this latter set of values; they are probably not user-visible
#'during ordinary model execution anyway. During execution of initialize()
#'callbacks, no SLiMSim object yet exists and so this property cannot be accessed.
#'To detect this state, use exists("sim"); if that is F, sim does not exist, and
#'therefore your code is executing during initialize() callbacks (or outside of
#'SLiM entirely, in some other Eidos-based context). }
#'\item{genomicElementTypes}{A property of type GenomicElementType object. This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The GenomicElementType objects being used in the simulation. }
#'\item{inSLiMgui}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} This property has been deprecated, and may be removed in a future
#'release of SLiM. In SLiM 3.2.1 and later, use exists("slimgui") instead. Eidos
#'events fitness() mateChoice() modifyChild() recombination() interaction()
#'reproduction() 564 If T, the simulation is presently running inside SLiMgui;
#'if F, it is running at the command line. In general simulations should not
#'care where they are running, but in special circumstances such as opening plot
#'windows it may be necessary to know the runtime environment. }
#'\item{interactionTypes}{A property of type InteractionType object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'InteractionType objects being used in the simulation. }
#'\item{logFiles}{A property of type LogFile object. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} The LogFile objects
#'being used in the simulation. }
#'\item{modelType}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The type of model being simulated, as specified in
#'initializeSLiMModelType(). This will be "WF" for WF models (Wright-Fisher
#'models, the default), or "nonWF" for nonWF models (non-Wright-Fisher models; see
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
#'\item{periodicity}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The spatial periodicity of the simulation, as
#'specified in initializeSLiMOptions(). This will be "" (the empty string) for
#'non-spatial simulations and simulations with no periodic spatial dimensions
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
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'the simulation. }
#'\item{verbosity}{A property of type integer. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'The verbosity level, for SLiM's logging of information about the simulation.
#'This is 1 by default, but can be changed at the command line with the -l[ong]
#'option. It is provided here so that scripts can consult it to govern the level
#'of verbosity of their own output, or set the verbosity level for particular
#'sections of their code. A verbosity level of 0 suppresses most of SLiM's
#'optional output; 2 adds some extra output beyond SLiM's standard output. See
#'sections 19.3 and 20.4 for more information.}
#'
#'}
NULL
#'Species
#'
#'Documentation for Species class from SLiM
#'
#'@name Species
#'@export
#'@aliases Sp
#'@family Species
#'@details This class represents a species in a SLiM simulation. In a
#'single-species model, the single
#'Species instance is defined as a global constant named sim; in multispecies
#'models, each Species
#'instance is defined as a global constant with the same name as the species.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addSubpop}}}
#'\item{\code{\link{countOfMutationsOfType}}}
#'\item{\code{\link{individualsWithPedigreeIDs}}}
#'\item{\code{\link{killIndividuals}}}
#'\item{\code{\link{mutationCounts}}}
#'\item{\code{\link{mutationFrequencies}}}
#'\item{\code{\link{mutationsOfType}}}
#'\item{\code{\link{outputFixedMutations}}}
#'\item{\code{\link{outputFull}}}
#'\item{\code{\link{outputMutations}}}
#'\item{\code{\link{readFromPopulationFile}}}
#'\item{\code{\link{recalculateFitness}}}
#'\item{\code{\link{registerFitnessEffectCallback}}}
#'\item{\code{\link{registerMateChoiceCallback}}}
#'\item{\code{\link{registerModifyChildCallback}}}
#'\item{\code{\link{registerMutationCallback}}}
#'\item{\code{\link{registerMutationEffectCallback}}}
#'\item{\code{\link{registerRecombinationCallback}}}
#'}
#'This class has the following properties:
#'\describe{
#'\item{avatar}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The avatar string used to represent this species in SLiMgui. Outside of SLiMgui,
#'this property still exists, but is not used by SLiM. Avatars are typically
#'one-character strings, often using an emoji that symbolizes the species. This
#'property is read-only; its value should be set with the avatar parameter of
#'initializeSpecies(). }
#'\item{chromosome}{A property of type Chromosome object. It is of length
#'one (a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The Chromosome object used by the species. }
#'\item{chromosomeType}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The type of chromosome being simulated by this
#'species; this will be one of "A", "X", or "Y". }
#'\item{color}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The color used to display information about this species in SLiMgui. Outside
#'of SLiMgui, this property still exists, but is not used by SLiM. Colors may be
#'specified by name, or with hexadecimal RGB values of the form "#RRGGBB" (see
#'the Eidos manual). This property is read-only; its value should be set with the
#'color parameter of initializeSpecies(). }
#'\item{cycle}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:} The
#'current cycle count for this species. This counter begins at 1, and increments
#'at the end of every tick in which the species is active. In models with
#'non-overlapping generations, particularly WF models, this can be thought of as a
#'generation counter. }
#'\item{description}{A property of type string. It is of length one (a singleton).
#'This property is a variable, so it is modifiable. \strong{Property Description:}
#'A human-readable string description for the species. By default, this is the
#'empty string, ""; however, it may be set to whatever you wish. }
#'\item{dimensionality}{A property of type string. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The spatial dimensionality of the simulation
#'for this species, as specified in initializeSLiMOptions(). This will be "" (the
#'empty string) for non-spatial simulations (the default), or "x", "xy", or "xyz",
#'for simulations using those spatial dimensions respectively. }
#'\item{genomicElementTypes}{A property of type GenomicElementType object. This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The GenomicElementType objects being used in the species. }
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this species. Species identifiers are determined by their
#'declaration order in the script; the first declared species is given an id of 0,
#'the second is given an id of 1, and so forth. }
#'\item{mutationTypes}{A property of type MutationType object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'MutationType objects being used in the species. }
#'\item{mutations}{A property of type Mutation object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} The Mutation
#'objects that are currently active in the species. }
#'\item{name}{A property of type string. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'A human-readable string name for the subpopulation. This is always the declared
#'name of the species, as given in the explicit species declaration in script,
#'and cannot be changed. The name of a species may appear as a label in SLiMgui,
#'and it can be useful in generating output, debugging, and other purposes. See
#'also the description property, which can be changed by the user and used for any
#'purpose. }
#'\item{nucleotideBased}{A property of type logical. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} If T, the model for this species is
#'nucleotide-based; if F, it is not. See the discussion of the nucleotideBased
#'parameter to initializeSLiMOptions() for discussion. }
#'\item{periodicity}{A property of type string. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The spatial periodicity of the simulation for this species, as
#'specified in initializeSLiMOptions(). This will be "" (the empty string) for
#'non-spatial simulations and simulations with no periodic spatial dimensions
#'(the default). Otherwise, it will be a string representing the subset of
#'spatial dimensions that have been declared to be periodic, as specified to
#'initializeSLiMOptions(). }
#'\item{scriptBlocks}{A property of type SLiMEidosBlock object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All registered
#'SLiMEidosBlock objects in the simulation that have been declared with this
#'species as their species specifier (not ticks specifier). These will always be
#'callback blocks; callbacks are species-specific, while other types of blocks are
#'not. }
#'\item{sexEnabled}{A property of type logical. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} If T, sex is enabled for this species; if F, individuals are
#'hermaphroditic. }
#'\item{subpopulations}{A property of type Subpopulation object. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} The
#'Subpopulation instances currently defined in the species. }
#'\item{substitutions}{A property of type Substitution object. This property is
#'a constant, so it is not modifiable. \strong{Property Description:} A vector of
#'Substitution objects, representing all mutations that have been fixed in this
#'species. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'the simulation.}
#'
#'}
NULL
#'Subpopulation
#'
#'Documentation for Subpopulation class from SLiM
#'
#'@name Subpopulation
#'@export
#'@aliases P
#'@family Subpopulation
#'@details This class represents one subpopulation in the simulated population.
#'Section 1.5.5 presents an
#'overview of the conceptual role of this class. The subpopulations currently
#'defined in the
#'simulation are defined as global constants with the same names used in the SLiM
#'input file - p1,
#'p2, and so forth.
#'This class has the following methods (functions):
#'\itemize{
#'\item{\code{\link{addCloned}}}
#'\item{\code{\link{addCrossed}}}
#'\item{\code{\link{addEmpty}}}
#'\item{\code{\link{addRecombinant}}}
#'\item{\code{\link{addSelfed}}}
#'\item{\code{\link{cachedFitness}}}
#'\item{\code{\link{configureDisplay}}}
#'\item{\code{\link{defineSpatialMap}}}
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
#'\item{\code{\link{spatialMapColor}}}
#'\item{\code{\link{spatialMapImage}}}
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
#'\item{description}{A property of type string. It is of length one (a
#'singleton). This property is a variable, so it is modifiable. \strong{Property
#'Description:} A human-readable string description for the subpopulation. By
#'default, this is the empty string, ""; however, it may be set to whatever you
#'wish. When tree-sequence recording is enabled, description is persisted in the
#'subpopulation's metadata in tree-sequence output. }
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
#'in this subpopulation (i.e., the fitness value computed for each individual
#'will be multiplied by this value). This is primarily of use in nonWF models,
#'where fitness is absolute, rather than in WF models, where fitness is relative
#'(and thus a constant factor multiplied into the fitness of every individual
#'will make no difference); however, it may be used in either type of model.
#'This provides a simple, fast way to modify the fitness of all individuals in a
#'subpopulation; conceptually it is similar to returning the same fitness effect
#'for all individuals in the subpopulation from a fitnessEffect() callback, but
#'without the complexity and performance overhead of implementing such a callback.
#'To scale the fitness of individuals by different (individual-specific) factors,
#'see the fitnessScaling property of Individual. The value of fitnessScaling is
#'reset to 1.0 every tick, so that any scaling factor set lasts for only a single
#'tick. This reset occurs immediately after fitness values are calculated, in both
#'WF and nonWF models. }
#'\item{genomes}{A property of type Genome object. This property is a constant,
#'so it is not modifiable. \strong{Property Description:} All of the genomes
#'contained by the subpopulation; there are two genomes per diploid individual. }
#'\item{genomesNonNull}{A property of type Genome object. This property is a
#'constant, so it is not modifiable. \strong{Property Description:} All of the
#'genomes contained by the subpopulation, as with the genomes property, if all
#'of them are not null genomes; any null genomes present are excluded from the
#'returned vector. This is a convenience shorthand, sometimes useful in models
#'that involve null genomes. }
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
#'\item{lifetimeReproductiveOutput}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'lifetimeReproductiveOutput contains the value of the Individual property
#'reproductiveOutput for all individuals in the subpopulation that died in
#'the last viability/survival tick cycle stage (or, for WF models, immediately
#'after reproduction). This allows access to the lifetime reproductive output of
#'individuals in the subpopulation at the end of their lives. If pedigree tracking
#'is not on, this property is unavailable. }
#'\item{lifetimeReproductiveOutputF}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'lifetimeReproductiveOutputF contains the value of the Individual property
#'reproductiveOutput for all female individuals in the subpopulation that died in
#'the last viability/ survival tick cycle stage (or, for WF models, immediately
#'after reproduction). This property is undefined if separate sexes have not been
#'enabled, or if pedigree tracking is not on. }
#'\item{lifetimeReproductiveOutputM}{A property of type integer. This property
#'is a constant, so it is not modifiable. \strong{Property Description:} If
#'pedigree tracking is turned on with initializeSLiMOptions(keepPedigrees=T),
#'lifetimeReproductiveOutputM contains the value of the Individual property
#'reproductiveOutput for all male individuals in the subpopulation that died in
#'the last viability/ survival tick cycle stage (or, for WF models, immediately
#'after reproduction). This property is undefined if separate sexes have not been
#'enabled, or if pedigree tracking is not on. }
#'\item{name}{A property of type string. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A human-readable string name for the subpopulation. By default, this is the
#'subpopulation's symbol as a string; for subpopulation p3, for example, name
#'defaults to "p3". However, it may be set to whatever you wish except that
#'subpopulation names must be unique across time (two different subpopulations
#'may not both have the name "foo", even if they never exist at the same time). A
#'subpopulation's name may appear as a label in SLiMgui, and it can be useful in
#'generating output, debugging, and other purposes. When tree-sequence recording
#'is enabled, name is persisted in the subpopulation's metadata in tree-sequence
#'output, and can then be used in Python to identify the subpopulation; if
#'you plan to take advantage of that feature, name should follow the syntax of
#'Python identifiers: starting with a letter or underscore [a-zA-Z_], followed by
#'letters, digits, or underscores [a-zA-Z0-9_], without spaces, hyphens, or other
#'characters. }
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
#'used in the simulation's dimensionality. This property cannot be set, but the
#'setSpatialBounds() method may be used to achieve the same thing. }
#'\item{species}{A property of type Species object. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The species to which the target object belongs. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:}
#'A user-defined integer value. The value of tag is initially undefined, and
#'it is an error to try to read it; if you wish it to have a defined value, you
#'must arrange that yourself by explicitly setting its value prior to using it
#'elsewhere in your code. The value of tag is not used by SLiM; it is free for
#'you to use. See also the getValue() and setValue() methods (provided by the
#'Dictionary class; see the Eidos manual), for another way of attaching state to
#'subpopulations.}
#'
#'}
NULL
#'Substitution
#'
#'Documentation for Substitution class from SLiM
#'
#'@name Substitution
#'@export
#'@aliases S
#'@family Substitution
#'@details This class represents a mutation that has been fixed; Mutation objects
#'are converted to
#'Substitution objects upon fixation. Its properties are thus very similar to
#'those of Mutation.
#'Section 1.5.2 presents an overview of the conceptual role of this class.
#'Since Substitution objects represent fixation events that occurred in the past,
#'they are
#'relatively immutable. However, since it may be useful to attach (possibly
#'dynamic) state to
#'substitutions, their tag and subpopID properties are mutable, and they also
#'provide the same
#'getValue() / setValue() functionality as Mutation (inherited from the Eidos
#'class Dictionary).
#'Values set on a Mutation object will carry over to the corresponding
#'Substitution object
#'automatically upon fixation.
#'This class has the following methods (functions):
#'\itemize{
#'\item{None. This class has no methods.}
#'}
#'This class has the following properties:
#'\describe{
#'\item{id}{A property of type integer. It is of length one (a singleton). This
#'property is a constant, so it is not modifiable. \strong{Property Description:}
#'The identifier for this mutation. Each mutation created during a run receives
#'an immutable identifier that will be unique across the duration of the run, and
#'that identifier is carried over to the Substitution object when the mutation
#'fixes. }
#'\item{fixationTick}{A property of type integer. It is of length one
#'(a singleton). This property is a constant, so it is not modifiable.
#'\strong{Property Description:} The tick in which this mutation fixed. }
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
#'\item{originTick}{A property of type integer. It is of length one (a singleton).
#'This property is a constant, so it is not modifiable. \strong{Property
#'Description:} The tick in which this mutation arose. }
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
#'is carried over from the Mutation object directly; if a "tag" value was used
#'in the Mutation object (see section 24.10.1), that value will carry over to the
#'corresponding Substitution object. The subpopID in Substitution is a read-write
#'property to allow it to be used as a "tag" in the same way, if the origin
#'subpopulation identifier is not needed. }
#'\item{tag}{A property of type integer. It is of length one (a singleton). This
#'property is a variable, so it is modifiable. \strong{Property Description:} A
#'user-defined integer value. The value of tag is carried over automatically from
#'the original Mutation object. Apart from that, the value of tag is not used by
#'SLiM; it is free for you to use.}
#'
#'}
NULL
