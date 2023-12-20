#' SLiM Classes
#'
#' A data.frame containing the name of the SLiM classes and an abbreviation that can be
#' used to refer to them in R.
#'
#' @format A data frame with 15 rows and 2 variables:
#' \describe{
#'   \item{class_name}{The name of SLiM class}
#'   \item{class_internal}{The name used internally by `slimr` for the class.
#'   Generally not useful for users.}
#'   \item{class_abbr}{An abbreviation of the class name that can be used to save typing.}
#' }
"slim_classes"

Initialize <- new.env()
Init <- Initialize
Chromosome <- new.env()
Ch <- Chromosome
Community <- new.env()
Co <- Community
Eidos <- new.env()
E <- Eidos
Genome <- new.env()
G <- Genome
GenomicElement <- new.env()
GE <- GenomicElement
GenomicElementType <- new.env()
GET <- GenomicElementType
Individual <- new.env()
In <- Individual
InteractionType <- new.env()
IT <- InteractionType
LogFile <- new.env()
LF <- LogFile
Mutation <- new.env()
M <- Mutation
MutationType <- new.env()
MT <- MutationType
SLiMBuiltin <- new.env()
SB <- SLiMBuiltin
SLiMEidosBlock <- new.env()
SEB <- SLiMEidosBlock
SLiMgui <- new.env()
SG <- SLiMgui
SpatialMap <- new.env()
SM <- SpatialMap
SLiMSim <- new.env()
SS <- SLiMSim
Species <- new.env()
Sp <- Species
Subpopulation <- new.env()
P <- Subpopulation
Substitution <- new.env()
S <- Substitution

#'@name Init
#'@rdname Initialize_Class
#'@export
NULL

#'@name Ch
#'@rdname Chromosome_Class
#'@export
NULL

#'@name Co
#'@rdname Community_Class
#'@export
NULL

#'@name E
#'@rdname Eidos_Class
#'@export
NULL

#'@name G
#'@rdname Genome_Class
#'@export
NULL

#'@name GE
#'@rdname GenomicElement_Class
#'@export
NULL

#'@name GET
#'@rdname GenomicElementType_Class
#'@export
NULL

#'@name In
#'@rdname Individual_Class
#'@export
NULL

#'@name IT
#'@rdname InteractionType_Class
#'@export
NULL

#'@name LF
#'@rdname LogFile_Class
#'@export
NULL

#'@name M
#'@rdname Mutation_Class
#'@export
NULL

#'@name MT
#'@rdname MutationType_Class
#'@export
NULL

#'@name SB
#'@rdname SLiMBuiltin_Class
#'@export
NULL

#'@name SEB
#'@rdname SLiMEidosBlock_Class
#'@export
NULL

#'@name SG
#'@rdname SLiMgui_Class
#'@export
NULL

#'@name SM
#'@rdname SpatialMap_Class
#'@export
NULL

#' SLiMSim was a class used prior to v4.0 in SLiM. It remains in `slimr`
#' for backwards compatibility but its use is now deprecated.
#'@name SS
#'@rdname SLiMSim_Class
#'@export
NULL

#'@name Sp
#'@rdname Species_Class
#'@export
NULL

#'@name P
#'@rdname Subpopulation_Class
#'@export
NULL

#'@name S
#'@rdname Substitution_Class
#'@export
NULL
