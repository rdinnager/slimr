callbacks <- list()

#' SLiM initialize() callback
#'
#' This callback specifies the code should be called to set up the simulation.
#' For details on what you can do in an \code{initialize()} callback code blocks see
#' \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=516}{SLiM Manual: page 516}
#' @family callbacks
#' @return None
#' @rdname callback_initialize
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(initialize(), {
#'   initializeMutationRate(1e-7)
#'   initializeMutationType("m1", 0.5, "f", 0.0)
#'   initializeGenomicElementType("g1", m1, 1.0)
#'   initializeGenomicElement(g1, 0, 99999)
#'   initializeRecombinationRate(1e-8)
#' })
initialize <- function() {
  callbacks$initialize()
}

callbacks$initialize <- function() {
  cb <- "initialize()"
  class(cb) <- "callback"
  cb
}

#' SLiM first() callback
#'
#' This callback specifies the code should be called first (before anything else) in the simulation cycle.
#' For details on exactly when \code{\link{first}()}, \code{\link{early}()} and \code{early()} callbacks are
#' run during a simulation see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=541}{SLiM Manual: page 541}
#' for "WF" models, or \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=549}{SLiM Manual: page 549} for "nonWF" models.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(1, early(), {
#'   sim.addSubpop("p1", 100)
#' })
first <- function() {
  callbacks$first()
}

callbacks$first <- function() {
  cb <- "first()"
  class(cb) <- "callback"
  cb
}

#' SLiM early() callback
#'
#' This callback specifies the code should be called early in the simulation cycle.
#' For details on exactly when \code{\link{first}()}, \code{\link{late}()} and \code{early()} callbacks are
#' run during a simulation see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=541}{SLiM Manual: page 541}
#' for "WF" models, or \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=549}{SLiM Manual: page 549} for "nonWF" models.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(1, early(), {
#'   sim.addSubpop("p1", 100)
#' })
early <- function() {
  callbacks$early()
}

callbacks$early <- function() {
  cb <- "early()"
  class(cb) <- "callback"
  cb
}

#' SLiM late() callback
#'
#' This callback specifies the code should be called late in the simulation cycle.
#' For details on exactly when \code{\link{first}()}, \code{late()} and \code{\link{early}()} callbacks are
#' run during a simulation see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=541}{SLiM Manual: page 541}
#' for "WF" models, or \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=549}{SLiM Manual: page 549} for "nonWF" models.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(100, late(), {
#'   sim.simulationFinished()
#' })
late <- function() {
  callbacks$late()
}

callbacks$late <- function() {
  cb <- "late()"
  class(cb) <- "callback"
  cb
}

#' SLiM fitness() callback
#'
#' This callback specifies that a code block is providing logic to decide the fitness of a mutation in an individual.
#' The callback should return a the relative fitness value of the mutation, where a value of 1.0 is neutral. This is
#' called once per mutation per individual per generation in which it is active. If \code{mut_id_type = NULL} then
#' the callback will be called only once per individual and should return a global relative fitness value that is
#' independent of mutations the individual possesses.
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=596}{SLiM Manual: page 596}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{mut}{A Mutation object, the mutation whose relative fitness is being evaluated}
#'   \item{homozygous}{A value of T (the mutation is homozygous), F (heterozygous), or NULL (it is
#'   paired with a null chromosome, which can occur with sex chromosomes)}
#'   \item{relFitness}{The default relative fitness value calculated by SLiM}
#'   \item{individual}{The individual carrying this mutation (an object of class Individual)}
#'   \item{genome1}{One genome of the individual carrying this mutation}
#'   \item{genome2}{The other genome of that individual}
#'   \item{subpop}{The subpopulation in which that individual lives}
#' }
#'
#' @param mut_type_id The id of the mutationType to which this callback should apply. Can be an
#' integer 1, 2, etc., or character "m1", "m2", etc.
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' # From page 182 of the SLiM Manual
#' slim_block(fitness(m2), {
#'   ## sets up frequency dependent selection for m2
#'   return(1.5 - sim.mutationFrequencies(p1, mut))
#' })
fitness <- function(mut_type_id, subpop_id) {
  callbacks$fitness(mut_type_id, subpop_id)
}

callbacks$fitness <- function(mut_type_id, subpop_id) {

  argus <- rlang::enexprs(mut_type_id, subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(fitness(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM mateChoice() callback
#'
#' This callback specifies that a code block is providing logic for an individual to choose a mate. The first parent is
#' chosen based on fitness values, then this callback is called to determine the second parent (if no callback is specified, it is chosen
#' randomly proportional to fitness). The callback code should return a vector of weights specifying the proportional probability of each individual in the population
#' being the second parent (including the first parent, as selfing is possible). Alternatively, it could return an \code{Individual} object
#' referring to the individual chosen as the second parent. Returning a numeric \code{0} tells SLiM that no mate could be found. Lastly, returning
#' \code{NULL} tells SLiM to use the default \code{weights} vector, which is the same as just returning \code{weights} but is more efficient.
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=599}{SLiM Manual: page 599}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{individual}{The parent already chosen (the female, in sexual simulations)}
#'   \item{genome1}{One genome of the parent already chosen}
#'   \item{genome2}{The other genome of the parent already chosen}
#'   \item{subpop}{The subpopulation into which the offspring will be placed}
#'   \item{sourceSubpop}{The subpopulation from which the parents are being chosen}
#'   \item{weights}{The standard fitness-based weights for all individuals}
#' }
#'
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' # From page 600 of the SLiM Manual
#' slim_block(mateChoice(p2), {
#'
#'   ## in subpopulation 2, high fitness individuals are preferred
#'   return(weights^2)
#'
#' })
mateChoice <- function(subpop_id) {
  callbacks$mateChoice(subpop_id)
}

callbacks$mateChoice <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(mateChoice(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM modifyChild() callback
#'
#' This callback specifies that a code block is providing logic to modify an offspring that has been produced
#' during a SLiM simulation, and is called for every offspring produced. The code should modify the pseudo-variables
#' associated with the child (see details) \code{child}, \code{childGenome1}, and \code{childGenome2}. It should also
#' return a single logical \code{T} or \code{F}. If \code{F}, the offspring will be discarded and the callback called again.
#' Make sure there is a non-zero probability of returning \code{T}, or the simulation could hang indefinitely.
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=601}{SLiM Manual: page 601}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{child}{The generated child (an object of class Individual) }
#'   \item{childGenome1}{One genome of the generated child}
#'   \item{childGenome2}{The other genome of the generated child}
#'   \item{childIsFemale}{T if the child will be female, F if male (defined only if sex is enabled)}
#'   \item{parent1}{The first parent (an object of class Individual)}
#'   \item{parent1Genome1}{One genome of the first parent}
#'   \item{parent1Genome2}{The other genome of the first parent}
#'   \item{isCloning}{T if the child is the result of cloning}
#'   \item{isSelfing}{T if the child is the result of selfing}
#'   \item{parent2}{The second parent (an object of class Individual)}
#'   \item{parent2Genome1}{One genome of the second parent}
#'   \item{parent2Genome2}{The other genome of the second parent}
#'   \item{subpop}{The subpopulation in which the child will live}
#'   \item{sourceSubpop}{The subpopulation of the parents (==subpop if not a migration mating)}
#' }
#'
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' # From page 217 of the SLiM Manual
#' slim_block(modifyChild(), {
#'
#'   # prevent hermaphroditic selfing
#'   if(parent1 == parent2) {
#'     return(F)
#'   }
#'   return(T)
#'
#' })
modifyChild <- function(subpop_id) {
 callbacks$modifyChild(subpop_id)
}

callbacks$modifyChild <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(modifyChild(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM recombination() callback
#'
#' This callback specifies that a code block is providing logic to determine the breakpoints
#' in the genome for recombination. It is called during the generation of gametes for each gamete
#' in the generations it is active. This is achieved by setting breakpoints into the pseudo-variable
#' \code{breakpoints}, replacing the default (as integer positions). If \code{breakpoints} is modified
#' the callback must return \code{T}. If \code{return(F)} is used, SLiM will use the original
#' \code{breakpoints}.
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=604}{SLiM Manual: page 604}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{individual}{The focal parent that is generating a gamete}
#'   \item{genome1}{One genome of the focal parent; this is the initial copy strand}
#'   \item{genome2}{The other genome of the focal parent}
#'   \item{subpop}{The subpopulation to which the focal parent belongs}
#'   \item{breakpoints}{An integer vector of crossover breakpoints}
#' }
#'
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' # From page 261 of the SLiM Manual
#' slim_block(recombination(), {
#'   if (genome1.containsMarkerMutation(m2, 25000) ==
#'       genome2.containsMarkerMutation(m2, 25000)) {
#'
#'     return(F)
#'
#'   }
#'
#'   inInv = (breakpoints > 25000) & (breakpoints < 75000)
#'   if (!any(inInv)) {
#'     return(F)
#'   }
#'
#'   breakpoints = breakpoints[!inInv]
#'   return(T)
#'
#' })
recombination <- function(subpop_id) {
  callbacks$recombination(subpop_id)
}

callbacks$recombination <- function(subpop_id) {

  argus <- rlang::enexprs(subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(recombination(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM interaction() callback
#'
#' This callback specifies that a code block is providing logic to determine the
#' strength of interaction between individuals. It should return the strength of the interaction
#' as a numeric value. You must explicitly use \code{return(value)} at the end of the code block.
#' For more information on how to use \code{interaction()} callback
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=604}{SLiM Manual: page 604}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{distance}{The distance from receiver to exerter, in spatial simulations; NAN otherwise}
#'   \item{strength}{The default interaction strength calculated by the interaction function}
#'   \item{receiver}{The individual receiving the interaction (an object of class Individual)}
#'   \item{exerter}{The individual exerting the interaction (an object of class Individual)}
#'   \item{subpop}{The subpopulation in which the receiver and exerter live}
#' }
#'
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @param int_type_id The id of the InteractionType to apply this callback to. Can
#' be an integer 1, 2, etc., or character "i1", "i2", etc.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(interaction(), {
#'   # custom interaction strength as a function of values held in exerter and receiver tagF element.
#'   return(dnorm(exerter.tagF, receiver.tagF, 0.1) / dnorm(0, 0, 0.1))
#' })
interaction <- function(int_type_id, subpop_id) {
  callbacks$interaction(int_type_id, subpop_id)
}

callbacks$interaction <- function(int_type_id, subpop_id) {

  argus <- rlang::enexprs(int_type_id, subpop_id)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(interaction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

#' SLiM reproduction() callback
#'
#' This callback specifies that a code block is providing logic for the production
#' of offspring. It is called once per individual for each generation in which it is active,
#' and is expected to add new individuals to the simulation using the SLiM functions provided
#' for that purpose. This is only used in "nonWF" simulations.
#' For more information on how to use \code{reproduction()} callback
#' see \href{http://benhaller.com/slim/SLiM_Manual.pdf#page=606}{SLiM Manual: page 606}
#'
#' @details
#' Global variables available in reproduction callbacks:
#' \describe{
#'   \item{individual}{The focal individual that is expected to reproduce}
#'   \item{genome1}{One genome of the focal individual}
#'   \item{genome2}{The other genome of the focal individual}
#'   \item{subpop}{The subpopulation to which the focal individual belongs}
#' }
#' @param subpop_id The id(s) of the subpopulation(s) to which this callback should apply. Can
#' be an integer 1, 2, etc., or character "p1", "p2", etc.
#' @param sex The sex of the individuals to apply this callback to.
#' @family callbacks
#' @return None
#' @export
#' @section Copyright:
#' This is documentation for a function in the SLiM software, and has been
#' modified from the official manual,
#' which can be found here: \url{http://benhaller.com/slim/SLiM_Manual.pdf}. This
#' documentation is
#' Copyright © 2016-2020 Philipp Messer. All rights reserved. More information
#' about SLiM can be found
#' on the official website: \url{https://messerlab.org/slim/}
#' @author Benjamin C Haller (\email{bhaller@benhaller.com}) and Philipp W Messer
#' (\email{messer@cornell.edu})
#' @examples
#' slim_block(reproduction(), {
#'
#'   subpop.addCrossed(individual, subpop.sampleIndividuals(1))
#'
#' })
reproduction <- function(subpop_id, sex) {
  callbacks$reproduction(subpop_id, sex)
}

callbacks$reproduction <- function(subpop_id, sex) {

  argus <- rlang::enexprs(subpop_id, sex)

  argus <- argus[!purrr::map_lgl(argus, rlang::is_missing)]

  cb <- rlang::expr(reproduction(!!!rlang::maybe_missing(argus)))

  cb <- rlang::expr_text(cb)

  class(cb) <- "callback"
  cb

}

callbacks <- list2env(callbacks)

#' SLiM Callbacks
#'
#' These functions are stubs that don't do anything in R, but
#' represent callback functions in SLiM. Call these functions
#' as part of a \code{\link{slim_block}} call to specify that the
#' code is designed to work with a particular callback.
#' Most callbacks are designed to be called within SLiM under special
#' circumstances, and will have 'pseudo-variables' that are accessible
#' only inside that particular callback. See help files for individuals
#' callbacks listed below for more details.
#' Available callbacks are:
#' \itemize{
#' \item{\code{\link{initialize}}}
#' \item{\code{\link{early}}}
#' \item{\code{\link{late}}}
#' \item{\code{\link{fitness}}}
#' \item{\code{\link{mateChoice}}}
#' \item{\code{\link{modifyChild}}}
#' \item{\code{\link{recombination}}}
#' \item{\code{\link{interaction}}}
#' \item{\code{\link{reproduction}}}
#' }
#' @family callbacks
slim_callbacks <- function() {
  callbacks
}
