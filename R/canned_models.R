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
  setSeed(<<.seed>>);

	defineConstant("sigma_M", <<mating_sd>>);
	defineConstant("N", <<N>>);

	initializeSLiMOptions(dimensionality="xy");
	initializeMutationRate(<mutation_rate>);
	initializeMutationType("m1", 0.5, "f", 0.0);        // neutral

	initializeGenomicElementType("g1", m1, 1.0);
	initializeGenomicElement(g1, 0, <<nloc - 1>>);
	initializeRecombinationRate(<<recomb_rate>>);

	initializeInteractionType(2, "xy", reciprocal=T, maxDistance= sigma_M * 3); // mate choice
	i2.setInteractionFunction("n", 1.0, sigma_M);
}

1 late() {
	sim.addSubpop("p1", N);
	p1.setSpatialBounds(c(<<xlims[1]>>, <<ylims[1]>>, <<xlims[2]>>, <<ylims[2]>>));
	p1.individuals.setSpatialPosition(p1.pointUniform(N));
}
modifyChild() {
	// set offspring position based on parental position
	do pos = c(parent1.spatialPosition + rnorm(2, 0, <<move_sd>>));
	while (!p1.pointInBounds(pos));
	child.setSpatialPosition(pos);

	return T;
}
1: late() {

	// evaluate mate choice in preparation for next generation
	i2.evaluate();


	if(sim.generation % <output_every> == 0) {
	  sim.outputFull(filePath = "<<output_file>>", append = T);
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

  script <- glue::glue(mod, .open = "<<", .close = ">>")[[1]]

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

  output_dir <- dirname(output_file)
  output_filename <- basename(output_file)
  file_split <- strsplit(output_filename, ".", fixed = TRUE)

  output_mating <- file_split[[1]]
  output_mating[1] <- paste0(output_mating[1], "_mating")
  output_mating <- paste0(output_mating, collapse = ".")
  output_mating <- file.path(output_dir, output_mating)

  output_full <- file_split[[1]]
  output_full[1] <- paste0(output_full[1], "_full_at_end")
  output_full <- paste0(output_full, collapse = ".")
  output_full <- file.path(output_dir, output_full)

  script <-
'initialize() {
  setSeed(<<.seed>>);
	initializeSLiMModelType("nonWF");
	initializeSLiMOptions(keepPedigrees = T, dimensionality="xy");

	defineConstant("N", <<N>>);   // Staring population size
	defineConstant("save_every", <<output_every>>);   // How often to save some results
	defineConstant("Nsample", <<N_output>>);   // How many individuals to sample for output?
	defineConstant("NO", <<NO>>);   // NO, Non-overlapping generation; 1 = Non-overlapping, 0 = overlapping
	defineConstant("MK", "<<MK>>");   // MK, Movement Kernel; "gauss" or "laplace"
	defineConstant("K", <<K>>);   // carrying-capacity density
	defineConstant("Fe", <<formatC(fecundity, format = "f", digits = 1)>>);   // Fecundity
	defineConstant("MD", <<mating_max_dist>>);   // MD, Maximum mating distance
	defineConstant("OD", 0.01);   // OD, Maximum offspring distance
	defineConstant("MvR", <<move_sd>>);   // MvR, Movement Rate

	defineConstant("genome_length", <<nloc>>);   // MR, Movement Rate
	defineConstant("M", <<mutation_rate>>);   // M, Mutation Rate
	defineConstant("R", <<recomb_rate>>);   // R, Recombination Rate

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
      writeFile("<<output_mating>>", line1, append=T);
      writeFile("<<output_mating>>", line2, append=T);
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
	  writeFile("<<output_file>>", "#OUT", append=T);
    writeFile("<<output_file>>", paste(sim.generation), append=T);
    writeFile("<<output_file>>", inds_x, append=T);
    writeFile("<<output_file>>", inds_y, append=T);
    writeFile("<<output_file>>", ind_tags, append=T);
    writeFile("<<output_file>>", pedigree_inds, append=T);
    writeFile("<<output_file>>", pedigree_parents, append=T);
    writeFile("<<output_file>>", pedigree_grandparents, append=T);
    ind_samp.genomes.outputVCF(filePath = "<<output_file>>", append = T);

    catn("Generation: " + sim.generation);
}
}

<<ngen>> late() {
  sim.outputFull(filePath = "<<output_full>>", append = T);
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
  writeFile("<<output_file>>", "#OUT", append=T);
  writeFile("<<output_file>>", paste(sim.generation), append=T);
  writeFile("<<output_file>>", inds_x, append=T);
  writeFile("<<output_file>>", inds_y, append=T);
  writeFile("<<output_file>>", ind_tags, append=T);
  writeFile("<<output_file>>", pedigree_inds, append=T);
  writeFile("<<output_file>>", pedigree_parents, append=T);
  writeFile("<<output_file>>", pedigree_grandparents, append=T);
  ind_samp.genomes.outputVCF(filePath = "<<output_file>>", append = T);
  sim.simulationFinished();
}'

  script_filled <- glue::glue(script, .open = "<<", .close = ">>")[[1]]
  script_filled
}

spatial_sim_with_sex_and_inbreeding_avoidance <- function(ngen = 10000, N = 500, nloc = 10000, mating_max_dist = 0.25, move_sd = 0.1, xlims = c(-1.5, 1.5), ylims = c(-1.5, 1.5),
                                   sampling_xlim = c(-1, 1), sampling_ylim = c(-1, 1),
                                   max_relatedness = 0.5,
                                   mutation_rate = 1e-6, recomb_rate = 1e-8, K = 500, fecundity = 2.5,
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

  output_dir <- dirname(output_file)
  output_filename <- basename(output_file)
  file_split <- strsplit(output_filename, ".", fixed = TRUE)

  output_mating <- file_split[[1]]
  output_mating[1] <- paste0(output_mating[1], "_mating")
  output_mating <- paste0(output_mating, collapse = ".")
  output_mating <- file.path(output_dir, output_mating)

  output_full <- file_split[[1]]
  output_full[1] <- paste0(output_full[1], "_full_at_end")
  output_full <- paste0(output_full, collapse = ".")
  output_full <- file.path(output_dir, output_full)

  script <-
    'initialize() {
  setSeed(<<.seed>>);
  initializeSLiMModelType("nonWF");
  initializeSLiMOptions(keepPedigrees = T, dimensionality="xy");

  defineConstant("N", <<N>>);   // Staring population size
  defineConstant("save_every", <<output_every>>);   // How often to save some results
  defineConstant("Nsample", <<N_output>>);   // How many individuals to sample for output?
  defineConstant("NO", <<NO>>);   // NO, Non-overlapping generation; 1 = Non-overlapping, 0 = overlapping
  defineConstant("MK", "<<MK>>");   // MK, Movement Kernel; "gauss" or "laplace"
  defineConstant("K", <<K>>);   // carrying-capacity density
  defineConstant("Fe", <<formatC(fecundity, format = "f", digits = 1)>>);   // Fecundity
  defineConstant("MD", <<mating_max_dist>>);   // MD, Maximum mating distance
  defineConstant("OD", 0.01);   // OD, Maximum offspring distance
  defineConstant("MvR", <<move_sd>>);   // MvR, Movement Rate
  defineConstant("max_rel", <<max_relatedness>>);   // max_rel, maximum relatedness for first pass mate choice

  defineConstant("genome_length", <<nloc>>);   // MR, Movement Rate
  defineConstant("M", <<mutation_rate>>);   // M, Mutation Rate
  defineConstant("R", <<recomb_rate>>);   // R, Recombination Rate

  initializeMutationType("m1", 0.5, "f", 0.0);
  m1.convertToSubstitution = T;

  initializeGenomicElementType("g1", m1, 1.0);
  initializeGenomicElement(g1, 0, genome_length - 1);
  initializeMutationRate(M);
  initializeRecombinationRate(R);

  // add sexes to sim
  initializeSex("A");

  // spatial mate choice
  initializeInteractionType(1, "xy", reciprocal = T, maxDistance = MD);
}

reproduction(NULL, "F") {
// find all males within maximum mating distance
possible_mates = i1.nearestNeighbors(individual, N);
possible_mates = possible_mates[possible_mates.sex == "M"];
// which are close relatives?
relatedness = individual.relatedness(possible_mates);
unrelated_mates = possible_mates[relatedness < max_rel];
// choose mate from unrelated individuals unless there are none
if(size(unrelated_mates))
{
  mate = sample(unrelated_mates, 1);
}
// choose mate from full pool if only close relatives available
else
{
  if(size(possible_mates))
  {
    mate = sample(possible_mates, 1);
  }
// return empty vector if no mates exist within mating distance
  else
  {
    mate = integer(0);
  }
}
//mate = size(unrelated_mates) ? sample(unrelated_mates, 1) else sample(possible_mates, 1);

for (i in seqLen(rpois(1, Fe)))
{
  if (size(mate)) {
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
  writeFile("<<output_mating>>", line1, append=T);
  writeFile("<<output_mating>>", line2, append=T);
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
  writeFile("<<output_file>>", "#OUT", append=T);
  writeFile("<<output_file>>", paste(sim.generation), append=T);
  writeFile("<<output_file>>", inds_x, append=T);
  writeFile("<<output_file>>", inds_y, append=T);
  writeFile("<<output_file>>", ind_tags, append=T);
  writeFile("<<output_file>>", pedigree_inds, append=T);
  writeFile("<<output_file>>", pedigree_parents, append=T);
  writeFile("<<output_file>>", pedigree_grandparents, append=T);
  ind_samp.genomes.outputVCF(filePath = "<<output_file>>", append = T);

  catn("Generation: " + sim.generation);
  }
}

<<ngen>> late() {
sim.outputFull(filePath = "<<output_full>>", append = T);
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
writeFile("<<output_file>>", "#OUT", append=T);
writeFile("<<output_file>>", paste(sim.generation), append=T);
writeFile("<<output_file>>", inds_x, append=T);
writeFile("<<output_file>>", inds_y, append=T);
writeFile("<<output_file>>", ind_tags, append=T);
writeFile("<<output_file>>", pedigree_inds, append=T);
writeFile("<<output_file>>", pedigree_parents, append=T);
writeFile("<<output_file>>", pedigree_grandparents, append=T);
ind_samp.genomes.outputVCF(filePath = "<<output_file>>", append = T);
sim.simulationFinished();
}'

  script_filled <- glue::glue(script, .open = "<<", .close = ">>")[[1]]
  script_filled
}
