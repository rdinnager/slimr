#' SLiM Classes
#'
#' A data.frame containing the name of the SLiM classes and an abbreviation that can be
#' used to refer to them in R.
#'
#' @format A data frame with 15 rows and 2 variables:
#' \describe{
#'   \item{class_name}{The name of SLiM class}
#'   \item{class_abbr}{An abbreviation of the class name that can be used to save typing. They
#'   always begin with '.' to reduce the chance of name collisions with short variable names}
#' }
"slim_classes"

Initialize <- new.env()
Init <- Initialize
Chromosome <- new.env()
Ch <- Chromosome
Community <- new.env()
Co <- Community
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
SLiMSim <- new.env()
SS <- SLiMSim
Species <- new.env()
Sp <- Species
Subpopulation <- new.env()
P <- Subpopulation
Substitution <- new.env()
S <- Substitution

#'@name Init
#'@rdname Initialize
#'@export
NULL

#'@name Ch
#'@rdname Chromosome
#'@export
NULL

#'@name Co
#'@rdname Community
#'@export
NULL

#'@name G
#'@rdname Genome
#'@export
NULL

#'@name GE
#'@rdname GenomicElement
#'@export
NULL

#'@name GET
#'@rdname GenomicElementType
#'@export
NULL

#'@name In
#'@rdname Individual
#'@export
NULL

#'@name IT
#'@rdname Interactiontype
#'@export
NULL

#'@name LF
#'@rdname LogFile
#'@export
NULL

#'@name M
#'@rdname Mutation
#'@export
NULL

#'@name MT
#'@rdname MutationType
#'@export
NULL

#'@name SB
#'@rdname SLiMBuiltin
#'@export
NULL

#'@name SEB
#'@rdname SLiMEidosBlock
#'@export
NULL

#'@name SS
#'@rdname SLiMSim
#'@export
NULL

#'@name Sp
#'@rdname Species
#'@export
NULL

#'@name P
#'@rdname Subpopulation
#'@export
NULL

#'@name S
#'@rdname Substitution
#'@export
NULL
