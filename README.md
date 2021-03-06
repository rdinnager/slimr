
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slimr <img src='man/figures/logo.png' align="right" height="278" />

<https://rdinnager.github.io/slimr/>

<!-- badges: start -->

[![R build
status](https://github.com/rdinnager/slimr/workflows/R-CMD-check/badge.svg)](https://github.com/rdinnager/slimr/actions)
[![Codecov test
coverage](https://codecov.io/gh/rdinnager/slimr/branch/master/graph/badge.svg)](https://codecov.io/gh/rdinnager/slimr?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of slimr is to run SLiM population genetics forward simulations
from R. It also has utilities for monitoring the simulations, and
bringing the resulting data into R for post-processing and
visualization.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("rdinnager/slimr")
```

## Writing SLiM Scripts in R

Using `slimr`, this is how you write the first example script (or
recipe) from the (excellent) [SLiM](https://messerlab.org/slim/) manual:

``` r
library(slimr)
#> Welcome to the slimr package for forward population genetics simulation in SLiM. For more information on SLiM please visit https://messerlab.org/slim/ .

slim_script(
  slim_block(initialize(),
             {
               ## set the overall mutation rate
               initializeMutationRate(1e-7); 
               ## m1 mutation type: neutral
               initializeMutationType("m1", 0.5, "f", 0.0);
               ## g1 genomic element type: uses m1 for all mutations
               initializeGenomicElementType("g1", m1, 1.0);
               ## uniform chromosome of length 100 kb
               initializeGenomicElement(g1, 0, 99999);
               ## uniform recombination along the chromosome
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
) -> script_1

script_1
#> <slimr_script[3]>
#> block_init:initialize() {
#>     initializeMutationRate(1e-07);
#>     initializeMutationType("m1", 0.5, "f", 0);
#>     initializeGenomicElementType("g1", m1, 1);
#>     initializeGenomicElement(g1, 0, 99999);
#>     initializeRecombinationRate(1e-08);
#> }
#> 
#> block_2:1 early() {
#>     sim.addSubpop("p1", 500);
#> }
#> 
#> block_3:10000 early() {
#>     sim.simulationFinished();
#> }
```

You can output this script to text to run in a standalone SLiM
installation, or you can run it in SLiM directly from R, and many other
things. Please see the package website for lots of examples (link in top
right corner of github repo).

You can also do fancy stuff like make the above script or another script
into a template that you can dynamically fill-in with parameters
generated in R. You can also make SLiM generate R-friendly input. See
the vignettes for details of these features and how to use them.

## Code of Conduct

Please note that the slimr project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
