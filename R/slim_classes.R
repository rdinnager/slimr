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
Chromosome <- new.env()
Genome <- new.env()
GenomicElement <- new.env()
GenomicElementType <- new.env()
Individual <- new.env()
InteractionType <- new.env()
LogFile <- new.env()
Mutation <- new.env()
MutationType <- new.env()
SLiMBuiltin <- new.env()
SLiMEidosBlock <- new.env()
SLiMSim <- new.env()
Subpopulation <- new.env()
Substitution <- new.env()

#'@export
"Initialize"

#'@export
"Chromosome"

#'@export
"Genome"

#'@export
"GenomicElement"

#'@export
"GenomicElementType"

#'@export
"Individual"

#'@export
"InteractionType"

#'@export
"LogFile"

#'@export
"Mutation"

#'@export
"MutationType"

#'@export
"SLiMBuiltin"

#'@export
"SLiMEidosBlock"

#'@export
"SLiMSim"

#'@export
"Subpopulation"

#'@export
"Substitution"
