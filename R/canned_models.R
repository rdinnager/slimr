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

spatial_sim_w_pedigree <- function(ngen = 10000, N = 500, nloc = 10000, mating_max_dist = 0.25, move_sd = 0.1, xlims = c(-1.5, 1.5), ylims = c(-1.5, 1.5),
                                   sampling_xlim = c(-1, 1), sampling_ylim = c(-1, 1),
                                   mutation_rate = 1e-6, recomb_rate = 1e-8, K = 500, fecundity = 2.0,
                                   N_output = 100, non_overlapping = TRUE, movement_kernel = c("gauss", "laplace"),
                                   .seed = .Random.seed, output_every = "end_only",
                                   output_file = "slim_output.txt") {

  if(output_every == "end_only") {
    output_every <- N
  }

  if(non_overlapping) {
    NO <- 1
  } else {
    NO <- 0
  }

  MK <- match.arg(movement_kernel)

  script <-
'initialize() {
  setSeed(<.seed>);
	initializeSLiMModelType("nonWF");
	initializeSLiMOptions(keepPedigrees = T, dimensionality="xy");

	defineConstant("N", <N>);   // Staring population size
	defineConstant("save_every", <output_every>);   // How often to save some results
	defineConstant("Nsample", <N_output>);   // How many individuals to sample for output?
	defineConstant("NO", <NO>);   // NO, Non-overlapping generation; 1 = Non-overlapping, 0 = overlapping
	defineConstant("MK", "<MK>");   // MK, Movement Kernel; "gauss" or "laplace"
	defineConstant("K", <K>);   // carrying-capacity density
	defineConstant("Fe", <formatC(x, format = "f", digits = 1)>);   // Fecundity
	defineConstant("MD", <mating_max_dist>);   // MD, Maximum mating distance
	defineConstant("OD", 0.01);   // OD, Maximum offspring distance
	defineConstant("MvR", 0.1);   // MvR, Movement Rate

	defineConstant("genome_length", 100000);   // MR, Movement Rate
	defineConstant("M", 1e-6);   // M, Mutation Rate
	defineConstant("R", 1e-7);   // R, Recombination Rate

	initializeMutationType("m1", 0.5, "f", 0.0);
	m1.convertToSubstitution = T;

	initializeGenomicElementType("g1", m1, 1.0);
	initializeGenomicElement(g1, 0, genome_length - 1);
	initializeMutationRate(M);
	initializeRecombinationRate(R);

	// spatial mate choice
	initializeInteractionType(1, "xy", reciprocal = T, maxDistance = MD);
}

reproduction() {
	// choose our nearest neighbor as a mate, within the max distance
	mate = i1.nearestNeighbors(individual, 1);

	for (i in seqLen(rpois(1, Fe)))
	{
		if (mate.size()) {
			offspring = subpop.addCrossed(individual, mate);
			// set offspring position
			do pos = c(individual.spatialPosition + runif(2, -OD, OD));
	    while (!p1.pointInBounds(pos));
	    offspring.setSpatialPosition(pos);

	    offspring.tag = sim.tag;
      sim.tag = sim.tag + 1;

      // log the mating
      line1 = paste(c(sim.generation, individual.tag, offspring.tag));
      line2 = paste(c(sim.generation, mate.tag, offspring.tag));
      writeFile("mating_1.txt", line1, append=T);
      writeFile("mating_1.txt", line2, append=T);
	   }
	}
}

1 early() {
  sim.addSubpop("p1", N);
	p1.setSpatialBounds(c(-1.5, -1.5, 1.5, 1.5));
	// random initial positions
	p1.individuals.setSpatialPosition(p1.pointUniform(N));
  p1.individuals.tag = 0:(N - 1);
  sim.tag = N;

}

1: early() {

 inds = sim.subpopulations.individuals;

 if (NO == 1) { // non-overlapping generations
  inds[inds.age > 0].fitnessScaling = 0.0;
  inds = inds[inds.age == 0]; // focus on juveniles
 }

  // density-dependence for juveniles to make it closer to WF model and to keep pops from exploding
  p1.fitnessScaling = K / size(inds);
}

1: late()
{
	// move around a bit
	for (ind in p1.individuals)
	{
	  if(MK == "gauss") { // gaussian kernel
	    do pos = c(ind.spatialPosition + rnorm(2, 0, MvR));
	    while (!p1.pointInBounds(pos));
	  }
	  if(MK == "laplace") { // laplacian kernel
	    do pos = c(ind.spatialPosition + (rexp(2, MvR) * ((rbinom(2, 1, 0.5) * 2) - 1)));
	    while (!p1.pointInBounds(pos));
	  }
	  ind.setSpatialPosition(pos);

	}

	// then look for mates
	i1.evaluate();

	if(sim.generation % save_every == 0) {
	  inds2 = sim.subpopulations.individuals;

	  // filter out only individuals in central region; probably a more concise way to write this...
	  inds2 = inds2[inds2.x > -1.0 & inds2.x < 1.0 & inds2.y > -1.0 & inds2.y < 1.0];

	  ind_samp = sample(inds2, Nsample);

	  ind_tags = paste(ind_samp.tag);
	  pedigree_inds = paste(ind_samp.pedigreeID);
	  pedigree_parents = paste(ind_samp.pedigreeParentIDs);
	  pedigree_grandparents = paste(ind_samp.pedigreeGrandparentIDs);
	  inds_x = paste(ind_samp.x);
	  inds_y = paste(ind_samp.y);
	  writeFile("sim_spatial_VCF_1.txt", "#OUT", append=T);
  writeFile("sim_spatial_VCF_1.txt", paste(sim.generation), append=T);
  writeFile("sim_spatial_VCF_1.txt", inds_x, append=T);
  writeFile("sim_spatial_VCF_1.txt", inds_y, append=T);
  writeFile("sim_spatial_VCF_1.txt", ind_tags, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_inds, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_parents, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_grandparents, append=T);
  ind_samp.genomes.outputVCF(filePath = "sim_spatial_VCF_1.txt", append = T);

  catn("Generation: " + sim.generation);
}
}

1000 late() {
  sim.outputFull(filePath = "sim_spatial_full_output_end_1.txt", append = T);
  inds2 = sim.subpopulations.individuals;

  // filter out only individuals in central region; probably a more concise way to write this...
  inds2 = inds2[inds2.x > -1.0 & inds2.x < 1.0 & inds2.y > -1.0 & inds2.y < 1.0];

  ind_samp = sample(inds2, Nsample);

  ind_tags = paste(ind_samp.tag);
  pedigree_inds = paste(ind_samp.pedigreeID);
  pedigree_parents = paste(ind_samp.pedigreeParentIDs);
  pedigree_grandparents = paste(ind_samp.pedigreeGrandparentIDs);
  inds_x = paste(ind_samp.x);
  inds_y = paste(ind_samp.y);
  writeFile("sim_spatial_VCF_1.txt", "#OUT", append=T);
  writeFile("sim_spatial_VCF_1.txt", paste(sim.generation), append=T);
  writeFile("sim_spatial_VCF_1.txt", inds_x, append=T);
  writeFile("sim_spatial_VCF_1.txt", inds_y, append=T);
  writeFile("sim_spatial_VCF_1.txt", ind_tags, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_inds, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_parents, append=T);
  writeFile("sim_spatial_VCF_1.txt", pedigree_grandparents, append=T);
  ind_samp.genomes.outputVCF(filePath = "sim_spatial_VCF_1.txt", append = T);
  sim.simulationFinished();
}'
}
