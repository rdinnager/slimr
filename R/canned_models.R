#' Title
#'
#' @param ngen
#' @param N
#' @param nloc
#' @param mating_sd
#' @param move_sd
#' @param xlims
#' @param ylims
#' @param mutation_rate
#' @param recomb_rate
#' @param .seed
#' @param output_prop
#' @param output_file
#'
#' @return
#' @export
#'
#' @examples
simple_spatial_model <- function(ngen = 10000, N = 500, nloc = 10000, mating_sd = 0.1, move_sd = 0.01, xlims = c(0, 1), ylims = c(0, 1),
                                 mutation_rate = 1e-6, recomb_rate = 1e-8, .seed = .Random.seed, output_prop = 1/100,
                                 output_file = "slim_output.txt") {


  output_every <- ceiling(ngen * output_prop)

  mod <-
'
initialize() {
  setSeed(<.seed>);

	defineConstant("sigma_M", <mating_sd>);
	defineConstant("N", <N>);

	initializeSLiMOptions(dimensionality="xy");
	initializeMutationRate(<mutation_rate>);
	initializeMutationType("m1", 0.5, "f", 0.0);        // neutral

	initializeGenomicElementType("g1", m1, 1.0);
	initializeGenomicElement(g1, 0, <nloc - 1>);
	initializeRecombinationRate(<recomb_rate>);

	initializeInteractionType(2, "xy", reciprocal=T, maxDistance= sigma_M * 3);     // mate choice
	i2.setInteractionFunction("n", 1.0, sigma_M);
}

1 late() {
	sim.addSubpop("p1", N);
	p1.setSpatialBounds(c(<xlims[1]>, <ylims[1]>, <xlims[2]>, <ylims[2]>));
	p1.individuals.setSpatialPosition(p1.pointUniform(N));
}
modifyChild() {
	// set offspring position based on parental position
	do pos = c(parent1.spatialPosition + rnorm(2, 0, <move_sd>));
	while (!p1.pointInBounds(pos));
	child.setSpatialPosition(pos);

	return T;
}
1: late() {

	// evaluate mate choice in preparation for next generation
	i2.evaluate();


	if(sim.generation % <output_every> == 0) {
	  sim.outputFull(filePath = "<output_file>", append = T);
	  catn("Generation: " + sim.generation);
	}
}
mateChoice() {
	// spatial mate choice
	return i2.strength(individual);
}
<ngen> late() {
  sim.simulationFinished();
}
'

  script <- glue::glue(mod, .open = "<", .close = ">")[[1]]

  script

}
