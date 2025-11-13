##### File: add.Rd #####

##### File: addCloned.Rd #####

##### File: addCrossed.Rd #####

##### File: addCustomColumn.Rd #####

##### File: addCycle.Rd #####

##### File: addCycleStage.Rd #####

##### File: addEmpty.Rd #####

##### File: addKeysAndValuesFrom.Rd #####

##### File: addMeanSDColumns.Rd #####

##### File: addMultiRecombinant.Rd #####

##### File: addMutations.Rd #####

##### File: addNewDrawnMutation.Rd #####

##### File: addNewMutation.Rd #####

##### File: addPatternForClone.Rd #####

##### File: addPatternForCross.Rd #####

##### File: addPatternForNull.Rd #####

##### File: addPatternForRecombinant.Rd #####

##### File: addPopulationSexRatio.Rd #####

##### File: addPopulationSize.Rd #####

##### File: addRecombinant.Rd #####

##### File: addSelfed.Rd #####

##### File: addSpatialMap.Rd #####

##### File: addSubpop.Rd #####

##### File: addSubpopSplit.Rd #####

##### File: addSubpopulationSexRatio.Rd #####

##### File: addSubpopulationSize.Rd #####

##### File: addSuppliedColumn.Rd #####

##### File: addTick.Rd #####

##### File: ancestralNucleotides.Rd #####

##### File: as_slim_text.Rd #####
### Name: as_slim_text
### Title: Convert a slimr_script to a length 1 character vector
### Aliases: as_slim_text

### ** Examples

slim_script(
   slim_block(initialize(),
          {
            initializeMutationRate(1e-7);
            initializeMutationType("m1", 0.5, "f", 0.0);
            initializeGenomicElementType("g1", m1, 1.0);
            initializeGenomicElement(g1, 0, 99999);
            initializeRecombinationRate(1e-8);
          }),
   slim_block(1,
          {
            sim.addSubpop("p1", 500);
          }),
   slim_block(10000,
          {
            sim.simulationFinished();
          })
) -> script
as_slim_text(script)




##### File: as_slim_text.slimr_script.Rd #####
### Name: as_slim_text.slimr_script
### Title: Convert a slimr_script to a length 1 character vector
### Aliases: as_slim_text.slimr_script

### ** Examples

slim_script(
   slim_block(initialize(),
          {
            initializeMutationRate(1e-7);
            initializeMutationType("m1", 0.5, "f", 0.0);
            initializeGenomicElementType("g1", m1, 1.0);
            initializeGenomicElement(g1, 0, 99999);
            initializeRecombinationRate(1e-8);
          }),
   slim_block(1,
          {
            sim.addSubpop("p1", 500);
          }),
   slim_block(10000,
          {
            sim.simulationFinished();
          })
) -> script
as_slim_text(script)




##### File: as_slimr_code.Rd #####
### Name: as_slimr_code
### Title: Convert SLiM code text into equivalent 'slimr' code to produce
###   the same model
### Aliases: as_slimr_code

### ** Examples

as_slimr_code(slim_recipes$`5.3.4`)




##### File: as_slimr_script.Rd #####
### Name: as_slimr_script
### Title: Convert a character vector into a slim_script object
### Aliases: as_slimr_script

### ** Examples

cat(slim_recipes[[1]])
as_slimr_script(slim_recipes[[1]])




##### File: blend.Rd #####

##### File: cachedFitness.Rd #####

##### File: calcDxy.Rd #####
### Name: calcDxy
### Title: SLiM method calcDxy
### Aliases: calcDxy SLiMBuiltin$calcDxy SB$calcDxy

### ** Examples

## This just brings up the documentation:
calcDxy()




##### File: calcFST.Rd #####
### Name: calcFST
### Title: SLiM method calcFST
### Aliases: calcFST SLiMBuiltin$calcFST SB$calcFST

### ** Examples

## This just brings up the documentation:
calcFST()




##### File: calcHeterozygosity.Rd #####
### Name: calcHeterozygosity
### Title: SLiM method calcHeterozygosity
### Aliases: calcHeterozygosity SLiMBuiltin$calcHeterozygosity
###   SB$calcHeterozygosity

### ** Examples

## This just brings up the documentation:
calcHeterozygosity()




##### File: calcInbreedingLoad.Rd #####
### Name: calcInbreedingLoad
### Title: SLiM method calcInbreedingLoad
### Aliases: calcInbreedingLoad SLiMBuiltin$calcInbreedingLoad
###   SB$calcInbreedingLoad

### ** Examples

## This just brings up the documentation:
calcInbreedingLoad()




##### File: calcLD_D.Rd #####
### Name: calcLD_D
### Title: SLiM method calcLD_D
### Aliases: calcLD_D SLiMBuiltin$calcLD_D SB$calcLD_D

### ** Examples

## This just brings up the documentation:
calcLD_D()




##### File: calcLD_Rsquared.Rd #####
### Name: calcLD_Rsquared
### Title: SLiM method calcLD_Rsquared
### Aliases: calcLD_Rsquared SLiMBuiltin$calcLD_Rsquared SB$calcLD_Rsquared

### ** Examples

## This just brings up the documentation:
calcLD_Rsquared()




##### File: calcMeanFroh.Rd #####
### Name: calcMeanFroh
### Title: SLiM method calcMeanFroh
### Aliases: calcMeanFroh SLiMBuiltin$calcMeanFroh SB$calcMeanFroh

### ** Examples

## This just brings up the documentation:
calcMeanFroh()




##### File: calcPairHeterozygosity.Rd #####
### Name: calcPairHeterozygosity
### Title: SLiM method calcPairHeterozygosity
### Aliases: calcPairHeterozygosity SLiMBuiltin$calcPairHeterozygosity
###   SB$calcPairHeterozygosity

### ** Examples

## This just brings up the documentation:
calcPairHeterozygosity()




##### File: calcPi.Rd #####
### Name: calcPi
### Title: SLiM method calcPi
### Aliases: calcPi SLiMBuiltin$calcPi SB$calcPi

### ** Examples

## This just brings up the documentation:
calcPi()




##### File: calcSFS.Rd #####
### Name: calcSFS
### Title: SLiM method calcSFS
### Aliases: calcSFS SLiMBuiltin$calcSFS SB$calcSFS

### ** Examples

## This just brings up the documentation:
calcSFS()




##### File: calcTajimasD.Rd #####
### Name: calcTajimasD
### Title: SLiM method calcTajimasD
### Aliases: calcTajimasD SLiMBuiltin$calcTajimasD SB$calcTajimasD

### ** Examples

## This just brings up the documentation:
calcTajimasD()




##### File: calcVA.Rd #####
### Name: calcVA
### Title: SLiM method calcVA
### Aliases: calcVA SLiMBuiltin$calcVA SB$calcVA

### ** Examples

## This just brings up the documentation:
calcVA()




##### File: calcWattersonsTheta.Rd #####
### Name: calcWattersonsTheta
### Title: SLiM method calcWattersonsTheta
### Aliases: calcWattersonsTheta SLiMBuiltin$calcWattersonsTheta
###   SB$calcWattersonsTheta

### ** Examples

## This just brings up the documentation:
calcWattersonsTheta()




##### File: callback_initialize.Rd #####
### Name: initialize
### Title: SLiM initialize() callback
### Aliases: initialize

### ** Examples

slim_block(initialize(), {
  initializeMutationRate(1e-7)
  initializeMutationType("m1", 0.5, "f", 0.0)
  initializeGenomicElementType("g1", m1, 1.0)
  initializeGenomicElement(g1, 0, 99999)
  initializeRecombinationRate(1e-8)
})




##### File: changeColors.Rd #####

##### File: changeValues.Rd #####

##### File: Chromosome_Class.Rd #####

##### File: chromosomesOfType.Rd #####

##### File: chromosomesWithIDs.Rd #####

##### File: chromosomesWithSymbols.Rd #####

##### File: clearKeysAndValues.Rd #####

##### File: clippedIntegral.Rd #####

##### File: code.Rd #####
### Name: code
### Title: Extract or set code from a 'slimr_script' object
### Aliases: code code<-

### ** Examples

script <- slim_script(
  slim_block_init_minimal(),
  slim_block_finish(100)
)
code(script)
code(minimal_slimr_script())




##### File: codonsToAminoAcids.Rd #####
### Name: codonsToAminoAcids
### Title: SLiM method codonsToAminoAcids
### Aliases: codonsToAminoAcids SLiMBuiltin$codonsToAminoAcids
###   SB$codonsToAminoAcids

### ** Examples

## This just brings up the documentation:
codonsToAminoAcids()




##### File: codonsToNucleotides.Rd #####
### Name: codonsToNucleotides
### Title: SLiM method codonsToNucleotides
### Aliases: codonsToNucleotides SLiMBuiltin$codonsToNucleotides
###   SB$codonsToNucleotides

### ** Examples

## This just brings up the documentation:
codonsToNucleotides()




##### File: Community_Class.Rd #####

##### File: configureDisplay.Rd #####

##### File: containsMarkerMutation.Rd #####

##### File: containsMutations.Rd #####

##### File: countOfMutationsOfType.Rd #####

##### File: createLogFile.Rd #####

##### File: createPlot.Rd #####

##### File: defineSpatialMap.Rd #####

##### File: deregisterScriptBlock.Rd #####

##### File: deviatePositions.Rd #####

##### File: deviatePositionsWithMap.Rd #####

##### File: distance.Rd #####

##### File: distanceFromPoint.Rd #####

##### File: divide.Rd #####

##### File: drawBreakpoints.Rd #####

##### File: drawByStrength.Rd #####

##### File: drawSelectionCoefficient.Rd #####

##### File: early.Rd #####
### Name: early
### Title: SLiM early() callback
### Aliases: early

### ** Examples

slim_block(1, early(), {
  sim.addSubpop("p1", 100)
})




##### File: eidos_abs.Rd #####

##### File: eidos_acos.Rd #####

##### File: eidos_all.Rd #####

##### File: eidos_any.Rd #####

##### File: eidos_apply.Rd #####

##### File: eidos_array.Rd #####

##### File: eidos_asFloat.Rd #####

##### File: eidos_asin.Rd #####

##### File: eidos_asInteger.Rd #####

##### File: eidos_asLogical.Rd #####

##### File: eidos_assert.Rd #####

##### File: eidos_asString.Rd #####

##### File: eidos_asVector.Rd #####

##### File: eidos_atan.Rd #####

##### File: eidos_atan2.Rd #####

##### File: eidos_beep.Rd #####

##### File: eidos_c.Rd #####

##### File: eidos_cat.Rd #####

##### File: eidos_catn.Rd #####

##### File: eidos_cbind.Rd #####

##### File: eidos_ceil.Rd #####

##### File: eidos_citation.Rd #####

##### File: Eidos_Class.Rd #####

##### File: eidos_clock.Rd #####

##### File: eidos_cmColors.Rd #####

##### File: eidos_color2rgb.Rd #####

##### File: eidos_colors.Rd #####

##### File: eidos_colSums.Rd #####

##### File: eidos_cor.Rd #####

##### File: eidos_cos.Rd #####

##### File: eidos_cov.Rd #####

##### File: eidos_createDirectory.Rd #####

##### File: eidos_cumProduct.Rd #####

##### File: eidos_cumSum.Rd #####

##### File: eidos_date.Rd #####

##### File: eidos_dbeta.Rd #####

##### File: eidos_debugIndent.Rd #####

##### File: eidos_defineConstant.Rd #####

##### File: eidos_defineGlobal.Rd #####

##### File: eidos_deleteFile.Rd #####

##### File: eidos_det.Rd #####

##### File: eidos_dexp.Rd #####

##### File: eidos_dgamma.Rd #####

##### File: eidos_diag.Rd #####

##### File: eidos_dim.Rd #####

##### File: eidos_dmvnorm.Rd #####

##### File: eidos_dnorm.Rd #####

##### File: eidos_doCall.Rd #####

##### File: eidos_drop.Rd #####

##### File: eidos_elementType.Rd #####

##### File: eidos_executeLambda.Rd #####

##### File: eidos_exists.Rd #####

##### File: eidos_exp.Rd #####

##### File: eidos_fileExists.Rd #####

##### File: eidos_filesAtPath.Rd #####

##### File: eidos_filter.Rd #####

##### File: eidos_findInterval.Rd #####

##### File: eidos_float.Rd #####

##### File: eidos_floor.Rd #####

##### File: eidos_flushFile.Rd #####

##### File: eidos_format.Rd #####

##### File: eidos_functionSignature.Rd #####

##### File: eidos_functionSource.Rd #####

##### File: eidos_getSeed.Rd #####

##### File: eidos_getwd.Rd #####

##### File: eidos_grep.Rd #####

##### File: eidos_heatColors.Rd #####

##### File: eidos_hsv2rgb.Rd #####

##### File: eidos_identical.Rd #####

##### File: eidos_ifelse.Rd #####

##### File: eidos_integer.Rd #####

##### File: eidos_integerDiv.Rd #####

##### File: eidos_integerMod.Rd #####

##### File: eidos_inverse.Rd #####

##### File: eidos_isFinite.Rd #####

##### File: eidos_isFloat.Rd #####

##### File: eidos_isInfinite.Rd #####

##### File: eidos_isInteger.Rd #####

##### File: eidos_isLogical.Rd #####

##### File: eidos_isNAN.Rd #####

##### File: eidos_isNULL.Rd #####

##### File: eidos_isObject.Rd #####

##### File: eidos_isString.Rd #####

##### File: eidos_length.Rd #####

##### File: eidos_license.Rd #####

##### File: eidos_log.Rd #####

##### File: eidos_log10.Rd #####

##### File: eidos_log2.Rd #####

##### File: eidos_logical.Rd #####

##### File: eidos_lowerTri.Rd #####

##### File: eidos_ls.Rd #####

##### File: eidos_match.Rd #####

##### File: eidos_matrix.Rd #####

##### File: eidos_matrixMult.Rd #####

##### File: eidos_matrixPow.Rd #####

##### File: eidos_max.Rd #####

##### File: eidos_mean.Rd #####

##### File: eidos_min.Rd #####

##### File: eidos_nchar.Rd #####

##### File: eidos_ncol.Rd #####

##### File: eidos_nrow.Rd #####

##### File: eidos_object.Rd #####

##### File: eidos_order.Rd #####

##### File: eidos_outerProduct.Rd #####

##### File: eidos_parallelGetMaxThreads.Rd #####

##### File: eidos_parallelGetNumThreads.Rd #####

##### File: eidos_parallelGetTaskThreadCounts.Rd #####

##### File: eidos_parallelSetNumThreads.Rd #####

##### File: eidos_parallelSetTaskThreadCounts.Rd #####

##### File: eidos_paste.Rd #####

##### File: eidos_paste0.Rd #####

##### File: eidos_pmax.Rd #####

##### File: eidos_pmin.Rd #####

##### File: eidos_pnorm.Rd #####

##### File: eidos_print.Rd #####

##### File: eidos_product.Rd #####

##### File: eidos_qnorm.Rd #####

##### File: eidos_quantile.Rd #####

##### File: eidos_rainbow.Rd #####

##### File: eidos_range.Rd #####

##### File: eidos_rank.Rd #####

##### File: eidos_rbeta.Rd #####

##### File: eidos_rbind.Rd #####

##### File: eidos_rbinom.Rd #####

##### File: eidos_rcauchy.Rd #####

##### File: eidos_rdunif.Rd #####

##### File: eidos_readCSV.Rd #####

##### File: eidos_readFile.Rd #####

##### File: eidos_rep.Rd #####

##### File: eidos_repEach.Rd #####

##### File: eidos_rev.Rd #####

##### File: eidos_rexp.Rd #####

##### File: eidos_rf.Rd #####

##### File: eidos_rgamma.Rd #####

##### File: eidos_rgb2color.Rd #####

##### File: eidos_rgb2hsv.Rd #####

##### File: eidos_rgeom.Rd #####

##### File: eidos_rlnorm.Rd #####

##### File: eidos_rm.Rd #####

##### File: eidos_rmvnorm.Rd #####

##### File: eidos_rnbinom.Rd #####

##### File: eidos_rnorm.Rd #####

##### File: eidos_round.Rd #####

##### File: eidos_rowSums.Rd #####

##### File: eidos_rpois.Rd #####

##### File: eidos_runif.Rd #####

##### File: eidos_rweibull.Rd #####

##### File: eidos_rztpois.Rd #####

##### File: eidos_sample.Rd #####

##### File: eidos_sapply.Rd #####

##### File: eidos_sd.Rd #####

##### File: eidos_seq.Rd #####

##### File: eidos_seqAlong.Rd #####

##### File: eidos_seqLen.Rd #####

##### File: eidos_setDifference.Rd #####

##### File: eidos_setIntersection.Rd #####

##### File: eidos_setSeed.Rd #####

##### File: eidos_setSymmetricDifference.Rd #####

##### File: eidos_setUnion.Rd #####

##### File: eidos_setwd.Rd #####

##### File: eidos_sign.Rd #####

##### File: eidos_sin.Rd #####

##### File: eidos_size.Rd #####

##### File: eidos_sort.Rd #####

##### File: eidos_sortBy.Rd #####

##### File: eidos_source.Rd #####

##### File: eidos_sqrt.Rd #####

##### File: eidos_stop.Rd #####

##### File: eidos_str.Rd #####

##### File: eidos_strcontains.Rd #####

##### File: eidos_strfind.Rd #####

##### File: eidos_string.Rd #####

##### File: eidos_strprefix.Rd #####

##### File: eidos_strsplit.Rd #####

##### File: eidos_strsuffix.Rd #####

##### File: eidos_substr.Rd #####

##### File: eidos_sum.Rd #####

##### File: eidos_sumExact.Rd #####

##### File: eidos_suppressWarnings.Rd #####

##### File: eidos_sysinfo.Rd #####

##### File: eidos_system.Rd #####

##### File: eidos_t.Rd #####

##### File: eidos_tabulate.Rd #####

##### File: eidos_tan.Rd #####

##### File: eidos_tempdir.Rd #####

##### File: eidos_terrainColors.Rd #####

##### File: eidos_time.Rd #####

##### File: eidos_tr.Rd #####

##### File: eidos_trunc.Rd #####

##### File: eidos_ttest.Rd #####

##### File: eidos_type.Rd #####

##### File: eidos_unique.Rd #####

##### File: eidos_upperTri.Rd #####

##### File: eidos_usage.Rd #####

##### File: eidos_var.Rd #####

##### File: eidos_version.Rd #####

##### File: eidos_which.Rd #####

##### File: eidos_whichMax.Rd #####

##### File: eidos_whichMin.Rd #####

##### File: eidos_writeFile.Rd #####

##### File: eidos_writeTempFile.Rd #####

##### File: end_gen.Rd #####
### Name: end_gen
### Title: Extract or set end generation
### Aliases: end_gen end_gen<-

### ** Examples

script <- slim_script(
  slim_block_init_minimal(),
  slim_block(1, 100, {
    sim.outputFull()
  })
)
script
end_gen(script)
end_gen(script)[2] <- 1000
script




##### File: estimatedLastTick.Rd #####

##### File: evaluate.Rd #####

##### File: exp.Rd #####

##### File: first.Rd #####
### Name: first
### Title: SLiM first() callback
### Aliases: first

### ** Examples

slim_block(1, early(), {
  sim.addSubpop("p1", 100)
})




##### File: fitness.Rd #####
### Name: fitness
### Title: SLiM fitness() callback
### Aliases: fitness

### ** Examples

slim_block(fitness(m2), {
  ## sets up frequency dependent selection for m2
  return(1.5 - sim.mutationFrequencies(p1, mut))
})




##### File: fitnessEffect.Rd #####
### Name: fitnessEffect
### Title: SLiM fitnessEffect() callback
### Aliases: fitnessEffect

### ** Examples

slim_block(fitnessEffect(p3), {
  # multiplies all individual's fitness by 0.75
  return(0.75)
})




##### File: flush.Rd #####

##### File: GenomicElement_Class.Rd #####

##### File: genomicElementForPosition.Rd #####

##### File: GenomicElementType_Class.Rd #####

##### File: genomicElementTypesWithIDs.Rd #####

##### File: get_block.Rd #####
### Name: get_block
### Title: Extract a single code block from a 'slimr_script'
### Aliases: get_block

### ** Examples

script <- slim_script(
  slim_block_init_minimal(),
  slim_block_finish(100)
)
get_block(script, "block_1")
get_block(script, 2)




##### File: get_slim_call.Rd #####

##### File: grapes-.-grapes.Rd #####
### Name: %.%
### Title: slimrlang stub for the SLiM '.' operator
### Aliases: %.%

### ** Examples

slim_script(
  slim_block_init_minimal(mutation_rate = 1e-6),
  slim_block(1, early(), {
    sim%.%Sp$addSubpop("p1", 100);
  })
)




##### File: grapes-else-grapes.Rd #####
### Name: %else%
### Title: slimrlang stub for the second part of the SLiM ternary operator
###   ('condition ? yes else no').
### Aliases: %else%

### ** Examples

slim_script(slim_block_init_minimal(),
            slim_block(cat(fixed %?% "FIXED\\n" %else% "LOST\\n"))) |>
  as_slim_text() |>
  cat()




##### File: grapes-help-grapes.Rd #####
### Name: %?%
### Title: slimrlang stub for the first part of the SLiM ternary operator
###   ('condition ? yes else no').
### Aliases: %?%

### ** Examples

slim_script(slim_block_init_minimal(),
            slim_block(cat(fixed %?% "FIXED\\n" %else% "LOST\\n"))) |>
  as_slim_text() |>
  cat()




##### File: gridValues.Rd #####

##### File: Haplosome_Class.Rd #####

##### File: haplosomesForChromosomes.Rd #####

##### File: hasGenomicElementForPosition.Rd #####

##### File: Individual_Class.Rd #####

##### File: individualsWithPedigreeIDs.Rd #####

##### File: Initialize_Class.Rd #####

##### File: initializeAncestralNucleotides.Rd #####
### Name: initializeAncestralNucleotides
### Title: SLiM method initializeAncestralNucleotides
### Aliases: initializeAncestralNucleotides
###   Initialize$initializeAncestralNucleotides
###   Init$initializeAncestralNucleotides

### ** Examples

## This just brings up the documentation:
initializeAncestralNucleotides()




##### File: initializeChromosome.Rd #####
### Name: initializeChromosome
### Title: SLiM method initializeChromosome
### Aliases: initializeChromosome Initialize$initializeChromosome
###   Init$initializeChromosome

### ** Examples

## This just brings up the documentation:
initializeChromosome()




##### File: initializeGeneConversion.Rd #####
### Name: initializeGeneConversion
### Title: SLiM method initializeGeneConversion
### Aliases: initializeGeneConversion Initialize$initializeGeneConversion
###   Init$initializeGeneConversion

### ** Examples

## This just brings up the documentation:
initializeGeneConversion()




##### File: initializeGenomicElement.Rd #####
### Name: initializeGenomicElement
### Title: SLiM method initializeGenomicElement
### Aliases: initializeGenomicElement Initialize$initializeGenomicElement
###   Init$initializeGenomicElement

### ** Examples

## This just brings up the documentation:
initializeGenomicElement()




##### File: initializeGenomicElementType.Rd #####
### Name: initializeGenomicElementType
### Title: SLiM method initializeGenomicElementType
### Aliases: initializeGenomicElementType
###   Initialize$initializeGenomicElementType
###   Init$initializeGenomicElementType

### ** Examples

## This just brings up the documentation:
initializeGenomicElementType()




##### File: initializeHotspotMap.Rd #####
### Name: initializeHotspotMap
### Title: SLiM method initializeHotspotMap
### Aliases: initializeHotspotMap Initialize$initializeHotspotMap
###   Init$initializeHotspotMap

### ** Examples

## This just brings up the documentation:
initializeHotspotMap()




##### File: initializeInteractionType.Rd #####
### Name: initializeInteractionType
### Title: SLiM method initializeInteractionType
### Aliases: initializeInteractionType Initialize$initializeInteractionType
###   Init$initializeInteractionType

### ** Examples

## This just brings up the documentation:
initializeInteractionType()




##### File: initializeMutationRate.Rd #####
### Name: initializeMutationRate
### Title: SLiM method initializeMutationRate
### Aliases: initializeMutationRate Initialize$initializeMutationRate
###   Init$initializeMutationRate

### ** Examples

## This just brings up the documentation:
initializeMutationRate()




##### File: initializeMutationRateFromFile.Rd #####
### Name: initializeMutationRateFromFile
### Title: SLiM method initializeMutationRateFromFile
### Aliases: initializeMutationRateFromFile
###   Initialize$initializeMutationRateFromFile
###   Init$initializeMutationRateFromFile

### ** Examples

## This just brings up the documentation:
initializeMutationRateFromFile()




##### File: initializeMutationType.Rd #####
### Name: initializeMutationType
### Title: SLiM method initializeMutationType
### Aliases: initializeMutationType Initialize$initializeMutationType
###   Init$initializeMutationType

### ** Examples

## This just brings up the documentation:
initializeMutationType()




##### File: initializeMutationTypeNuc.Rd #####
### Name: initializeMutationTypeNuc
### Title: SLiM method initializeMutationTypeNuc
### Aliases: initializeMutationTypeNuc Initialize$initializeMutationTypeNuc
###   Init$initializeMutationTypeNuc

### ** Examples

## This just brings up the documentation:
initializeMutationTypeNuc()




##### File: initializeRecombinationRate.Rd #####
### Name: initializeRecombinationRate
### Title: SLiM method initializeRecombinationRate
### Aliases: initializeRecombinationRate
###   Initialize$initializeRecombinationRate
###   Init$initializeRecombinationRate

### ** Examples

## This just brings up the documentation:
initializeRecombinationRate()




##### File: initializeRecombinationRateFromFile.Rd #####
### Name: initializeRecombinationRateFromFile
### Title: SLiM method initializeRecombinationRateFromFile
### Aliases: initializeRecombinationRateFromFile
###   Initialize$initializeRecombinationRateFromFile
###   Init$initializeRecombinationRateFromFile

### ** Examples

## This just brings up the documentation:
initializeRecombinationRateFromFile()




##### File: initializeSex.Rd #####
### Name: initializeSex
### Title: SLiM method initializeSex
### Aliases: initializeSex Initialize$initializeSex Init$initializeSex

### ** Examples

## This just brings up the documentation:
initializeSex()




##### File: initializeSLiMModelType.Rd #####
### Name: initializeSLiMModelType
### Title: SLiM method initializeSLiMModelType
### Aliases: initializeSLiMModelType Initialize$initializeSLiMModelType
###   Init$initializeSLiMModelType

### ** Examples

## This just brings up the documentation:
initializeSLiMModelType()




##### File: initializeSLiMOptions.Rd #####
### Name: initializeSLiMOptions
### Title: SLiM method initializeSLiMOptions
### Aliases: initializeSLiMOptions Initialize$initializeSLiMOptions
###   Init$initializeSLiMOptions

### ** Examples

## This just brings up the documentation:
initializeSLiMOptions()




##### File: initializeSpecies.Rd #####
### Name: initializeSpecies
### Title: SLiM method initializeSpecies
### Aliases: initializeSpecies Initialize$initializeSpecies
###   Init$initializeSpecies

### ** Examples

## This just brings up the documentation:
initializeSpecies()




##### File: initializeTreeSeq.Rd #####
### Name: initializeTreeSeq
### Title: SLiM method initializeTreeSeq
### Aliases: initializeTreeSeq Initialize$initializeTreeSeq
###   Init$initializeTreeSeq

### ** Examples

## This just brings up the documentation:
initializeTreeSeq()




##### File: interactingNeighborCount.Rd #####

##### File: interaction.Rd #####
### Name: interaction
### Title: SLiM interaction() callback
### Aliases: interaction

### ** Examples

slim_block(interaction(), {
  # custom interaction strength as a function of values held in exerter and receiver tagF element.
  return(dnorm(exerter.tagF, receiver.tagF, 0.1) / dnorm(0, 0, 0.1))
})




##### File: interactionDistance.Rd #####

##### File: InteractionType_Class.Rd #####

##### File: interactionTypesWithIDs.Rd #####

##### File: interpolate.Rd #####

##### File: killIndividuals.Rd #####

##### File: late.Rd #####
### Name: late
### Title: SLiM late() callback
### Aliases: late

### ** Examples

slim_block(100, late(), {
  sim.simulationFinished()
})




##### File: load_herm.Rd #####
### Name: load_herm
### Title: Download and load herm.rdata file containing SNP data from Sandy
###   Inland Mouse Details can be found in the article at
###   https://rdinnager.github.io/slimr/articles/Main_manuscript_example_v2.html
### Aliases: load_herm

### ** Examples

herm <- load_herm(download = FALSE)
herm




##### File: localPopulationDensity.Rd #####

##### File: LogFile_Class.Rd #####

##### File: logFileData.Rd #####

##### File: logRow.Rd #####

##### File: mapColor.Rd #####

##### File: mapImage.Rd #####

##### File: mapValue.Rd #####

##### File: mateChoice.Rd #####
### Name: mateChoice
### Title: SLiM mateChoice() callback
### Aliases: mateChoice

### ** Examples

slim_block(mateChoice(p2), {

  ## in subpopulation 2, high fitness individuals are preferred
  return(weights^2)

})




##### File: minimal_slim_sim.Rd #####
### Name: minimal_slim_sim
### Title: Generate a minimal SLiM simulation script
### Aliases: minimal_slim_sim

### ** Examples

minimal_slim_sim()




##### File: minimal_slimr_script.Rd #####
### Name: minimal_slimr_script
### Title: Generate a minimal slimr_script object
### Aliases: minimal_slimr_script

### ** Examples

minimal_slimr_script()




##### File: mm16To256.Rd #####
### Name: mm16To256
### Title: SLiM method mm16To256
### Aliases: mm16To256 SLiMBuiltin$mm16To256 SB$mm16To256

### ** Examples

## This just brings up the documentation:
mm16To256()




##### File: mmJukesCantor.Rd #####
### Name: mmJukesCantor
### Title: SLiM method mmJukesCantor
### Aliases: mmJukesCantor SLiMBuiltin$mmJukesCantor SB$mmJukesCantor

### ** Examples

## This just brings up the documentation:
mmJukesCantor()




##### File: mmKimura.Rd #####
### Name: mmKimura
### Title: SLiM method mmKimura
### Aliases: mmKimura SLiMBuiltin$mmKimura SB$mmKimura

### ** Examples

## This just brings up the documentation:
mmKimura()




##### File: modifyChild.Rd #####
### Name: modifyChild
### Title: SLiM modifyChild() callback
### Aliases: modifyChild

### ** Examples

slim_block(modifyChild(), {

  # prevent hermaphroditic selfing
  if(parent1 == parent2) {
    return(F)
  }
  return(T)

})




##### File: multiply.Rd #####

##### File: mutation.Rd #####
### Name: mutation
### Title: SLiM mutation() callback
### Aliases: mutation

### ** Examples

slim_block(recombination(), {
  if (genome1.containsMarkerMutation(m2, 25000) ==
      genome2.containsMarkerMutation(m2, 25000)) {

    return(F)

  }

  inInv = (breakpoints > 25000) & (breakpoints < 75000)
  if (!any(inInv)) {
    return(F)
  }

  breakpoints = breakpoints[!inInv]
  return(T)

})




##### File: Mutation_Class.Rd #####

##### File: mutationCounts.Rd #####

##### File: mutationCountsInHaplosomes.Rd #####

##### File: mutationEffect.Rd #####
### Name: mutationEffect
### Title: SLiM mutationEffect() callback
### Aliases: mutationEffect

### ** Examples

slim_block(mutationEffect(), {
  if (homozygous) {
    return(1.0 + mut.selectionCoeff);
  } else {
    return(1.0 + mut.mutationType.dominanceCoeff * mut.selectionCoeff);
  }
})




##### File: mutationFrequencies.Rd #####

##### File: mutationFrequenciesInHaplosomes.Rd #####

##### File: mutationsFromHaplosomes.Rd #####

##### File: mutationsOfType.Rd #####

##### File: MutationType_Class.Rd #####

##### File: mutationTypesWithIDs.Rd #####

##### File: nearestInteractingNeighbors.Rd #####

##### File: nearestNeighbors.Rd #####

##### File: nearestNeighborsOfPoint.Rd #####

##### File: neighborCount.Rd #####

##### File: neighborCountOfPoint.Rd #####

##### File: new_slimr_script_coll.Rd #####

##### File: nucleotideCounts.Rd #####
### Name: nucleotideCounts
### Title: SLiM method nucleotideCounts
### Aliases: nucleotideCounts SLiMBuiltin$nucleotideCounts
###   SB$nucleotideCounts

### ** Examples

## This just brings up the documentation:
nucleotideCounts()




##### File: nucleotideFrequencies.Rd #####
### Name: nucleotideFrequencies
### Title: SLiM method nucleotideFrequencies
### Aliases: nucleotideFrequencies SLiMBuiltin$nucleotideFrequencies
###   SB$nucleotideFrequencies

### ** Examples

## This just brings up the documentation:
nucleotideFrequencies()




##### File: nucleotides.Rd #####

##### File: nucleotidesToCodons.Rd #####
### Name: nucleotidesToCodons
### Title: SLiM method nucleotidesToCodons
### Aliases: nucleotidesToCodons SLiMBuiltin$nucleotidesToCodons
###   SB$nucleotidesToCodons

### ** Examples

## This just brings up the documentation:
nucleotidesToCodons()




##### File: openDocument.Rd #####

##### File: outputFixedMutations.Rd #####

##### File: outputFull.Rd #####

##### File: outputHaplosomes.Rd #####

##### File: outputHaplosomesToMS.Rd #####

##### File: outputHaplosomesToVCF.Rd #####

##### File: outputIndividuals.Rd #####

##### File: outputIndividualsToVCF.Rd #####

##### File: outputMSSample.Rd #####

##### File: outputMutations.Rd #####

##### File: outputSample.Rd #####

##### File: outputUsage.Rd #####

##### File: outputVCFSample.Rd #####

##### File: pauseExecution.Rd #####

##### File: pipe.Rd #####

##### File: plot_abline.Rd #####

##### File: plot_addLegend.Rd #####

##### File: plot_axis.Rd #####

##### File: Plot_Class.Rd #####

##### File: plot_image.Rd #####

##### File: plot_legendLineEntry.Rd #####

##### File: plot_legendPointEntry.Rd #####

##### File: plot_legendSwatchEntry.Rd #####

##### File: plot_legendTitleEntry.Rd #####

##### File: plot_lines.Rd #####

##### File: plot_matrix.Rd #####

##### File: plot_mtext.Rd #####

##### File: plot_points.Rd #####

##### File: plot_rects.Rd #####

##### File: plot_segments.Rd #####

##### File: plot_setBorderless.Rd #####

##### File: plot_text.Rd #####

##### File: plot_write.Rd #####

##### File: plotWithTitle.Rd #####

##### File: pointDeviated.Rd #####

##### File: pointInBounds.Rd #####

##### File: pointPeriodic.Rd #####

##### File: pointReflected.Rd #####

##### File: pointStopped.Rd #####

##### File: pointUniform.Rd #####

##### File: pointUniformWithMap.Rd #####

##### File: positionsOfMutationsOfType.Rd #####

##### File: power.Rd #####

##### File: r_inline.Rd #####
### Name: r_inline
### Title: Insert R objects into SLiM scripts
### Aliases: r_inline slimr_inline

### ** Examples

popsizes <- c(100, 200, 300)
slim_script(
 slim_block(initialize(),
        {
          initializeMutationRate(1e-7);
          initializeMutationType("m1", 0.5, "f", 0.0);
          initializeGenomicElementType("g1", m1, 1.0);
          initializeGenomicElement(g1, 0, 99999);
          initializeRecombinationRate(1e-8);
        }),
 slim_block(1,
        {
          popsizes <- r_inline(popsizes)
          sim.addSubpop("p1", popsizes[1]);
          sim.addSubpop("p2", popsizes[2]);
          sim.addSubpop("p3", popsizes[3]);
        }),
 slim_block(10000,
        {
          sim.simulationFinished();
        })
)




##### File: r_message.Rd #####
### Name: r_message
### Title: Send SLiM output to the R console as a message while a
###   simulation is running
### Aliases: r_message slimr_message

### ** Examples

slim_script(
  slim_block(initialize(),
             {
               initializeMutationRate(1e-7);
               initializeMutationType("m1", 0.5, "f", 0.0);
               initializeGenomicElementType("g1", m1, 1.0);
               initializeGenomicElement(g1, 0, 99999);
               initializeRecombinationRate(1e-8);
             }),
  slim_block(1,
             {
               sim.addSubpop("p1", 100);
             }),
  slim_block(1, 10000, {
    r_message(c("This is generation", community.tick), do_every = 100);
  }),
  slim_block(10000,
             {
               sim.simulationFinished();
             })
) -> test_sim
test_sim




##### File: r_output.Rd #####
### Name: r_output
### Title: Tell SLiM to produce easily parseable output
### Aliases: r_output slimr_output

### ** Examples

if(slim_is_avail()) {
slim_script(
  slim_block(initialize(),
             {
               initializeMutationRate(1e-7);
               initializeMutationType("m1", 0.5, "f", 0.0);
               initializeGenomicElementType("g1", m1, 1.0);
               initializeGenomicElement(g1, 0, 99999);
               initializeRecombinationRate(1e-8);
             }),
  slim_block(1,
             {
               sim.addSubpop("p1", 100);
             }),
  slim_block(100,
             {
               r_output(p1.outputVCFSample(sampleSize = 10), name = "VCF");
               sim.simulationFinished();
             })
) %>%
slim_run() -> run_w_out

cat(run_w_out$output_data$data[[1]])
}




##### File: r_output_coords.Rd #####
### Name: r_output_coords
### Title: Utility function to tell SLiM to output coordinates from spatial
###   simulations
### Aliases: r_output_coords slimr_output_coords

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(

    slim_block(initialize(),  {
        initializeSLiMOptions(dimensionality = "xy")
        initializeMutationRate(1e-07)
        initializeMutationType("m1", 0.5, "f", asFloat(0))
        initializeGenomicElementType("g1", m1, asFloat(1))
        initializeGenomicElement(g1, 0, 99999)
        initializeRecombinationRate(1e-08)
    }),

    slim_block(1, late(),  {
        sim.addSubpop("p1", 500)
        p1.individuals.x = runif(p1.individualCount)
        p1.individuals.y = runif(p1.individualCount)
    }),

    slim_block(1, 2000, late(), {
      r_output_coords(dimensionality = "xy", do_every = 10);
    }),

    slim_block(modifyChild(),  {
      child.x = parent1.x + rnorm(1, 0, 0.02)
      while((child.x < asFloat(0)) | (child.x > asFloat(1))) {
        child.x = parent1.x + rnorm(1, 0, 0.02)
      }
      child.y = parent1.y + rnorm(1, 0, 0.02)
      while((child.y < asFloat(0)) | (child.y > asFloat(1))) {
        child.y = parent1.y + rnorm(1, 0, 0.02)
      }
      return(T)
    }),

    slim_block(2000, late(),  {
        sim.outputFixedMutations()
    })
  ) |>
    slim_run()
  slim_results_to_data(test_sim)
}




##### File: r_output_full.Rd #####
### Name: r_output_full
### Title: Utility function to tell SLiM to output its outputFull() output
### Aliases: r_output_full slimr_output_full

### ** Examples

test_sim <- slim_script(
  slim_block_init_minimal(mutation_rate = 1e-6),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    r_output_full("out", do_every = 10)
  })
)
test_sim




##### File: r_output_nucleotides.Rd #####
### Name: r_output_nucleotides
### Title: Utility function to tell SLiM to output Nucleotides
### Aliases: r_output_nucleotides slimr_output_nucleotides

### ** Examples

test_sim <- slim_script(
  slim_block(initialize(), {

    ## tell SLiM to simulate nucleotides
    initializeSLiMOptions(nucleotideBased=T);
    initializeAncestralNucleotides(randomNucleotides(1000));
    initializeMutationTypeNuc("m1", 0.5, "f", 0.0);

    initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(1e-5));
    initializeGenomicElement(g1, 0, 1000 - 1);
    initializeRecombinationRate(1e-8);

  }),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    r_output_nucleotides("out", do_every = 10)
  })
)
test_sim




##### File: r_output_sex.Rd #####
### Name: r_output_sex
### Title: Utility function to tell SLim to output sexes of individuals
### Aliases: r_output_sex slimr_output_sex

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output_sex("sex", do_every = 10)
    })
  ) %>%
    slim_run()
  slim_results_to_data(test_sim$output_data)
}




##### File: r_output_snp.Rd #####
### Name: r_output_snp
### Title: Utility function to tell SLiM to output SNP format data
### Aliases: r_output_snp slimr_output_snp

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output_snp("snp", do_every = 10)
    })
  ) %>%
    slim_run()
  slim_results_to_data(test_sim)
}




##### File: r_template.Rd #####
### Name: r_template
### Title: Create a templated variable
### Aliases: r_template slimr_template

### ** Examples

test_sim <- slim_script(
 slim_block_init_minimal(mutation_rate = r_template("mut_rate", 1e-7)),
 slim_block(1, early(), {
   sim.addSubpop("p1", r_template("p1", 100));
 })
)
test_sim
slim_script_render(test_sim, data.frame(p1 = c(100, 200),
                                        mut_rate = c(1e-7, 1e-8)))




##### File: r_template_constant.Rd #####
### Name: r_template_constant
### Title: Like slimr_template but automatically inserts code to setup
###   variable as a defineConstant() call in the SLiM initialization block.
### Aliases: r_template_constant slimr_template_constant

### ** Examples

test_sim <- slim_script(
  slim_block(initialize(), {
    r_template_constant("pop1", 100)
    r_template_constant("pop2", 100)
  }),
  slim_block(1, early(), {
    sim.addSubpop("p1", pop1);
    sim.addSubpop("p2", pop2);
  })
)
test_sim
slim_script_render(test_sim, data.frame(pop1 = c(200, 200), pop2 = c(100, 300)))




##### File: randomNucleotides.Rd #####
### Name: randomNucleotides
### Title: SLiM method randomNucleotides
### Aliases: randomNucleotides SLiMBuiltin$randomNucleotides
###   SB$randomNucleotides

### ** Examples

## This just brings up the documentation:
randomNucleotides()




##### File: range.Rd #####

##### File: readFromPopulationFile.Rd #####

##### File: readHaplosomesFromMS.Rd #####

##### File: readHaplosomesFromVCF.Rd #####

##### File: readIndividualsFromVCF.Rd #####

##### File: recalculateFitness.Rd #####

##### File: recombination.Rd #####
### Name: recombination
### Title: SLiM recombination() callback
### Aliases: recombination

### ** Examples

slim_block(recombination(), {
  if (genome1.containsMarkerMutation(m2, 25000) ==
      genome2.containsMarkerMutation(m2, 25000)) {

    return(F)

  }

  inInv = (breakpoints > 25000) & (breakpoints < 75000)
  if (!any(inInv)) {
    return(F)
  }

  breakpoints = breakpoints[!inInv]
  return(T)

})




##### File: reconstruct.Rd #####
### Name: reconstruct
### Title: Reconstruct slimrlang code to make this slimr_script
### Aliases: reconstruct

### ** Examples

slim_script(
    slim_block(initialize(),
         {
              .Init$initializeMutationRate(1e-7);
              .Init$initializeMutationType("m1", 0.5, "f", 0.0);
              .Init$initializeGenomicElementType("g1", m1, 1.0);
              .Init$initializeGenomicElement(g1, 0, 99999);
              .Init$initializeRecombinationRate(1e-8);
         }),
           slim_block(1,
           {
              sim%.%.SS$addSubpop("p1", 500);
           }),
   slim_block(10000,
         {
              sim%.%.SS$simulationFinished();
         })
) -> script
reconstruct(script)




##### File: reconstruct.slimr_script.Rd #####
### Name: reconstruct.slimr_script
### Title: Reconstruct slimrlang code to make this slimr_script
### Aliases: reconstruct.slimr_script

### ** Examples

slim_script(
    slim_block(initialize(),
         {
              .Init$initializeMutationRate(1e-7);
              .Init$initializeMutationType("m1", 0.5, "f", 0.0);
              .Init$initializeGenomicElementType("g1", m1, 1.0);
              .Init$initializeGenomicElement(g1, 0, 99999);
              .Init$initializeRecombinationRate(1e-8);
         }),
           slim_block(1,
           {
              sim%.%.SS$addSubpop("p1", 500);
           }),
   slim_block(10000,
         {
              sim%.%.SS$simulationFinished();
         })
) -> script
reconstruct(script)




##### File: registerEarlyEvent.Rd #####

##### File: registerFirstEvent.Rd #####

##### File: registerFitnessEffectCallback.Rd #####

##### File: registerInteractionCallback.Rd #####

##### File: registerLateEvent.Rd #####

##### File: registerMateChoiceCallback.Rd #####

##### File: registerModifyChildCallback.Rd #####

##### File: registerMutationCallback.Rd #####

##### File: registerMutationEffectCallback.Rd #####

##### File: registerRecombinationCallback.Rd #####

##### File: registerReproductionCallback.Rd #####

##### File: registerSurvivalCallback.Rd #####

##### File: relatedness.Rd #####

##### File: removeMutations.Rd #####

##### File: removeSpatialMap.Rd #####

##### File: removeSubpopulation.Rd #####

##### File: reproduction.Rd #####
### Name: reproduction
### Title: SLiM reproduction() callback
### Aliases: reproduction

### ** Examples

slim_block(reproduction(), {

  subpop.addCrossed(individual, subpop.sampleIndividuals(1))

})




##### File: rescale.Rd #####

##### File: rescheduleScriptBlock.Rd #####

##### File: sampleImprovedNearbyPoint.Rd #####

##### File: sampleIndividuals.Rd #####

##### File: sampleNearbyPoint.Rd #####

##### File: scriptBlocksWithIDs.Rd #####

##### File: setAncestralNucleotides.Rd #####

##### File: setCloningRate.Rd #####

##### File: setConstraints.Rd #####

##### File: setDistribution.Rd #####

##### File: setFilePath.Rd #####

##### File: setGeneConversion.Rd #####

##### File: setGenomicElementType.Rd #####

##### File: setHotspotMap.Rd #####

##### File: setInteractionFunction.Rd #####

##### File: setLogInterval.Rd #####

##### File: setMigrationRates.Rd #####

##### File: setMutationFractions.Rd #####

##### File: setMutationMatrix.Rd #####

##### File: setMutationRate.Rd #####

##### File: setMutationType.Rd #####

##### File: setRecombinationRate.Rd #####

##### File: setSelectionCoeff.Rd #####

##### File: setSelfingRate.Rd #####

##### File: setSexRatio.Rd #####

##### File: setSpatialBounds.Rd #####

##### File: setSpatialPosition.Rd #####

##### File: setSubpopulationSize.Rd #####

##### File: setSuppliedValue.Rd #####

##### File: setValue.Rd #####

##### File: sharedParentCount.Rd #####

##### File: simulationFinished.Rd #####

##### File: skipTick.Rd #####

##### File: slim_block.Rd #####
### Name: slim_block
### Title: Setup a SLiM code block
### Aliases: slim_block

### ** Examples

slim_script(slim_block("s1", 1, 10000, late(), {print("Hello World!")}))




##### File: slim_block_add_subpops.Rd #####
### Name: slim_block_add_subpops
### Title: Generate a code block that just adds subpopulations to a SLiM
###   simulation
### Aliases: slim_block_add_subpops

### ** Examples

slim_block_add_subpops(2, 100)




##### File: slim_block_finish.Rd #####
### Name: slim_block_finish
### Title: Generate simulationFinished Block
### Aliases: slim_block_finish

### ** Examples

slim_script(
  slim_block_init_minimal(),
  slim_block_finish(100)
)




##### File: slim_block_init_minimal.Rd #####
### Name: slim_block_init_minimal
### Title: Generate minimal initialize() block
### Aliases: slim_block_init_minimal

### ** Examples

slim_script(
  slim_block_init_minimal(),
  slim_block_finish(100)
)




##### File: slim_block_progress.Rd #####

##### File: slim_callbacks.Rd #####

##### File: slim_classes.Rd #####

##### File: slim_code_Rify.Rd #####

##### File: slim_code_SLiMify.Rd #####

##### File: slim_compare_recipe.Rd #####
### Name: slim_compare_recipe
### Title: Compare original SLiM recipe with slimr conversion
### Aliases: slim_compare_recipe

### ** Examples


# Compare recipe 4.1
slim_compare_recipe("4.1")

# Save to specific file
slim_compare_recipe("5.2.1", output_file = "recipe_comparison.html")





##### File: slim_extract_full.Rd #####
### Name: slim_extract_full
### Title: Extract Elements from SLiM's outputFull()
### Aliases: slim_extract_full

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(sim.outputFull(), "out", do_every = 10)
    })
  ) %>%
    slim_run()
  slim_extract_full(test_sim$output_data, type = "mutations")
}




##### File: slim_extract_genlight.Rd #####
### Name: slim_extract_genlight
### Title: Extract data into a genlight object
### Aliases: slim_extract_genlight

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(sim.outputFull(), "out", do_every = 10)
    })
  ) %>%
    slim_run()
  if(require("adegenet", quietly = TRUE)) {
    plot(slim_extract_genlight(test_sim$output_data))
  }
}




##### File: slim_extract_genome.Rd #####
### Name: slim_extract_genome
### Title: Extract Elements from SLiM's output() for genomes
### Aliases: slim_extract_genome

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(sim.outputFull(), "out", do_every = 10)
    })
  ) %>%
    slim_run()
  slim_extract_genome(test_sim$output_data, type = "mutations")
}




##### File: slim_extract_output_data.Rd #####
### Name: slim_extract_output_data
### Title: Extract data produced by SLiM
### Aliases: slim_extract_output_data

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(p1$size(), "MS", do_every = 10)
    })
  ) %>%
    slim_run(simple = TRUE)
  slim_extract_output_data(test_sim$output)
}




##### File: slim_file.Rd #####

##### File: slim_function.Rd #####
### Name: slim_function
### Title: Specify an Eidos function to be included in the SLiM script
### Aliases: slim_function

### ** Examples

test_sim <- slim_script(
  slim_function("o<Subpopulation>$ subpop1", "o<Subpopulation>$ subpop2",
               name = "calculateFST",
               return_type = "f$", body = function(subpop1, subpop2) {
                 p1_p = sim.mutationFrequencies(subpop1);
                 p2_p = sim.mutationFrequencies(subpop2);
                 mean_p = (p1_p + p2_p) / 2.0;
                 H_t = 2.0 * mean_p * (1.0 - mean_p);
                 H_s = p1_p * (1.0 - p1_p) + p2_p * (1.0 - p2_p);
                 fst = 1.0 - H_s/H_t;
                 fst = fst[isFinite(fst)]; ## exclude muts where mean_p is 0.0 or 1.0
                 return(mean(fst));
               }),
  slim_block_init_minimal(mutation_rate = 1e-6),
  slim_block_add_subpops(2, 100),
  slim_block(1, 20, late(), {
    r_output(calculateFST(p1, p2), "out", do_every = 10)
  })
)
test_sim




##### File: slim_get_recipe.Rd #####
### Name: slim_get_recipe
### Title: Get a SLiM recipe
### Aliases: slim_get_recipe

### ** Examples


# Get recipe by name
recipe <- slim_get_recipe("4.1")

# Get recipe by index
recipe <- slim_get_recipe(1)

# Convert to slimr_script
script <- as_slimr_script(slim_get_recipe(1))





##### File: slim_get_recipes.Rd #####
### Name: slim_get_recipes
### Title: Get multiple SLiM recipes
### Aliases: slim_get_recipes

### ** Examples


# Get all recipes
all_recipes <- slim_get_recipes("all")

# Get specific recipes by index
some_recipes <- slim_get_recipes(c(1, 45, 53, 132))

# Get specific recipes by name
some_recipes <- slim_get_recipes(c("4.1", "9.2", "15.20"))





##### File: slim_install_path.Rd #####
### Name: slim_install_path
### Title: Find the SLiM executable path 'slimr' is using
### Aliases: slim_install_path

### ** Examples

slim_install_path()





##### File: slim_is_avail.Rd #####
### Name: slim_is_avail
### Title: Check if SLiM is installed and 'slimr' can find it
### Aliases: slim_is_avail

### ** Examples

slim_is_avail()




##### File: slim_load_globals.Rd #####
### Name: slim_load_globals
### Title: Load SLiM Globals into R Global environment
### Aliases: slim_load_globals

### ** Examples

slim_load_globals(c(p = 4, g = 2))




##### File: slim_make_pop_input.Rd #####
### Name: slim_make_pop_input
### Title: Create a file to initialise a population in SLiM
### Aliases: slim_make_pop_input

### ** Examples

pop_file <- slim_make_pop_input(matrix(rbinom(1000, 2, 0.25), nrow = 100, ncol = 100))
cat(readLines(pop_file))




##### File: slim_open.Rd #####
### Name: slim_open
### Title: Title
### Aliases: slim_open

### ** Examples

if(interactive()) {
  slim_open(minimal_slimr_script())
}




##### File: slim_recipe_metadata.Rd #####
### Name: slim_recipe_metadata
### Title: Metadata for SLiM recipes converted to slimr format
### Aliases: slim_recipe_metadata
### Keywords: datasets

### ** Examples

# Load the metadata
data(slim_recipe_metadata)

# View recipes by chapter
table(sub("\..*", "", slim_recipe_metadata$recipe_num))

# Find recipes with specific features
library(dplyr)
slim_recipe_metadata %>%
  filter(grepl("spatial", features)) %>%
  select(recipe_num, recipe_title)

# Find recipes about selection
slim_recipe_metadata %>%
  filter(grepl("selection", features)) %>%
  select(recipe_num, recipe_title, features)




##### File: slim_recipes.Rd #####

##### File: slim_results_to_data.Rd #####
### Name: slim_results_to_data
### Title: Convert output data from a slimr_results object to a tibble
### Aliases: slim_results_to_data

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(sim.outputFull(), "out", do_every = 10)
    })
  ) %>%
    slim_run()
  slim_results_to_data(test_sim)
}




##### File: slim_run.Rd #####
### Name: slim_run
### Title: Run a SLiM script from R
### Aliases: slim_run slim_run.character slim_run.slimr_script
###   slim_run.slimr_script_coll

### ** Examples

if(slim_is_avail()) {
  test_sim <- slim_script(
    slim_block_init_minimal(mutation_rate = 1e-6),
    slim_block_add_subpops(1, 100),
    slim_block(1, 20, late(), {
      r_output(sim.outputFull(), "out", do_every = 10)
    })
  ) %>%
    slim_run()
  test_sim
}




##### File: slim_script.Rd #####
### Name: slim_script
### Title: Create a SLiMR script
### Aliases: slim_script

### ** Examples

slim_script(
   slim_block(initialize(),
          {
            initializeMutationRate(1e-7);
            initializeMutationType("m1", 0.5, "f", 0.0);
            initializeGenomicElementType("g1", m1, 1.0);
            initializeGenomicElement(g1, 0, 99999);
            initializeRecombinationRate(1e-8);
          }),
   slim_block(1,
          {
            sim.addSubpop("p1", 500);
          }),
   slim_block(10000,
          {
            sim.simulationFinished();
          })
)




##### File: slim_script_duration.Rd #####
### Name: slim_script_duration
### Title: Set the duration of a slimr_script
### Aliases: slim_script_duration

### ** Examples

test_sim <- slim_script(
  slim_block_init_minimal(mutation_rate = 1e-6),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    slimr_output(sim.outputFull(), "out", do_every = 10)
  })
)

slim_script_duration(test_sim, 100)




##### File: slim_script_render.Rd #####
### Name: slim_script_render
### Title: Render a SLiM script with special slimrlang formatting
### Aliases: slim_script_render

### ** Examples

test_sim <- slim_script(
  slim_block_init_minimal(mutation_rate = r_template("mu", 1e-7)),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    r_output(sim.outputFull(), "out", do_every = 10)
  })
) %>%
  slim_script_render(data.frame(mu = c(1e-7, 1e-6, 1e-5)))
test_sim




##### File: slim_script_render_dots.Rd #####
### Name: slim_script_render_dots
### Title: Version of 'slim_script_render()' that takes dots (named
###   arguments) instead of a template list
### Aliases: slim_script_render_dots

### ** Examples

test_sim <- slim_script(
  slim_block_init_minimal(mutation_rate = r_template("mu", 1e-7)),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    r_output(sim.outputFull(), "out", do_every = 10)
  })
) %>%
  slim_script_render_dots(mu = c(1e-7, 1e-6, 1e-5))
test_sim




##### File: slim_setup.Rd #####
### Name: slim_setup
### Title: Attempt to install and / or setup SLiM for use with slimr
### Aliases: slim_setup

### ** Examples

if(interactive()) {
  slim_setup()
}




##### File: slim_template_info.Rd #####
### Name: slim_template_info
### Title: Get information on templating in a slimr_script
### Aliases: slim_template_info

### ** Examples

test_sim <- slim_script(
  slim_block_init_minimal(mutation_rate = r_template("mu", 1e-7)),
  slim_block_add_subpops(1, 100),
  slim_block(1, 20, late(), {
    r_output(sim.outputFull(), "out", do_every = 10)
  })
)




##### File: slim_unload_globals.Rd #####
### Name: slim_unload_globals
### Title: Unload SLiM Globals from R Global environment
### Aliases: slim_unload_globals

### ** Examples

slim_load_globals(c(p = 1))
slim_unload_globals()




##### File: slim_version.Rd #####
### Name: slim_version
### Title: Find out what version of SLiM is being used by 'slimr'
### Aliases: slim_version

### ** Examples

if(slim_is_avail()) {
  slim_version()
}




##### File: SLiMBuiltin_Class.Rd #####

##### File: SLiMEidosBlock_Class.Rd #####

##### File: SLiMgui_Class.Rd #####

##### File: slimr_clip_original.Rd #####
### Name: slimr_clip_original
### Title: Copy original slimrlang code used to create a slimr_script
###   object to the clipboard
### Aliases: slimr_clip_original

### ** Examples

test <- minimal_slimr_script()
if(rlang::is_installed("clipr") && interactive()) {
    slimr_clip_original("test")
}




##### File: slimr_code.Rd #####
### Name: slimr_code
### Title: Create a 'slimr_code' object
### Aliases: slimr_code

### ** Examples

slimr_code('print("Hello")', 'print("World!")')




##### File: slimr_name.Rd #####
### Name: slimr_name
### Title: Convert a string to a SLiM object name
### Aliases: slimr_name

### ** Examples

slimr_name("p1")




##### File: slimr_open_original.Rd #####
### Name: slimr_open_original
### Title: Open original slimrlang code used to create a slimr_script
###   object in a new document
### Aliases: slimr_open_original

### ** Examples

test <- minimal_slimr_script()
if(rlang::is_installed("rstudioapi") && interactive()) {
    slimr_open_original("test")
}




##### File: slimr_script_coll.Rd #####

##### File: slimr_write.Rd #####
### Name: slimr_write
### Title: Write a slimr_script object to a text file
### Aliases: slimr_write

### ** Examples

slim_script(
   slim_block(initialize(),
          {
            initializeMutationRate(1e-7);
            initializeMutationType("m1", 0.5, "f", 0.0);
            initializeGenomicElementType("g1", m1, 1.0);
            initializeGenomicElement(g1, 0, 99999);
            initializeRecombinationRate(1e-8);
          }),
   slim_block(1,
          {
            sim.addSubpop("p1", 500);
          }),
   slim_block(10000,
          {
            sim.simulationFinished();
          })
) -> script
temp_file <- tempfile(fileext = ".txt")
slimr_write(script, temp_file)
readLines(temp_file)




##### File: slimrlang-vctrs.Rd #####

##### File: smooth.Rd #####

##### File: SpatialMap_Class.Rd #####

##### File: spatialMapColor.Rd #####

##### File: spatialMapImage.Rd #####

##### File: spatialMapValue.Rd #####

##### File: Species_Class.Rd #####

##### File: speciesWithIDs.Rd #####

##### File: strength.Rd #####

##### File: Subpopulation_Class.Rd #####

##### File: subpopulationsWithIDs.Rd #####

##### File: subpopulationsWithNames.Rd #####

##### File: subsetIndividuals.Rd #####

##### File: subsetMutations.Rd #####

##### File: Substitution_Class.Rd #####

##### File: substitutionsOfType.Rd #####

##### File: subtract.Rd #####

##### File: summarizeIndividuals.Rd #####
### Name: summarizeIndividuals
### Title: SLiM method summarizeIndividuals
### Aliases: summarizeIndividuals SLiMBuiltin$summarizeIndividuals
###   SB$summarizeIndividuals

### ** Examples

## This just brings up the documentation:
summarizeIndividuals()




##### File: sumOfMutationsOfType.Rd #####

##### File: survival.Rd #####
### Name: survival
### Title: SLiM survival() callback
### Aliases: survival

### ** Examples

# From page 461 of the SLiM Manual
slim_block(survival(p1), {
  # move dying males into cold storage in case they have mated
  if (!surviving) {
    if (individual.sex == "M") {
      return(p1000);
    }
    return(NULL);
  }
})




##### File: takeMigrants.Rd #####

##### File: testConstraints.Rd #####

##### File: tidyeval.Rd #####

##### File: totalOfNeighborStrengths.Rd #####

##### File: treeSeqCoalesced.Rd #####

##### File: treeSeqMetadata.Rd #####
### Name: treeSeqMetadata
### Title: SLiM method treeSeqMetadata
### Aliases: treeSeqMetadata SLiMBuiltin$treeSeqMetadata SB$treeSeqMetadata

### ** Examples

## This just brings up the documentation:
treeSeqMetadata()




##### File: treeSeqOutput.Rd #####

##### File: treeSeqRememberIndividuals.Rd #####

##### File: treeSeqSimplify.Rd #####

##### File: unevaluate.Rd #####

##### File: uniqueMutationsOfType.Rd #####

##### File: usage.Rd #####

##### File: willAutolog.Rd #####

