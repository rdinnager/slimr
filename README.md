
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slimr <img src='man/figures/logo.png' style="float:right; height:278px;"/>

<https://rdinnager.github.io/slimr/>

<!-- badges: start -->

[![R build
status](https://github.com/rdinnager/slimr/workflows/R-CMD-check/badge.svg)](https://github.com/rdinnager/slimr/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

The goal of slimr is to run SLiM population genetics forward simulations
from R. It also has utilities for monitoring the simulations, and
bringing the resulting data into R for post-processing and
visualization.

## Setup

To be able to use slimr productively it is important to have a working
version of [SLiM](https://messerlab.org/slim/) and slimr.

### Installing slimr and SLiM

As a first step you need to install the package slimr from github.

``` r

if (!require("devtools")) install.packages(devtools)
devtools::install_github("rdinnager/slimr")  #downloads the latest version

#for other branches you may want to try
devtools::install_github("rdinnager/slimr", re = "v0.2.1")  #version accompanied with the manuscript
```

To facilitate the installation of slim We provide provide a function
`slim_setup()`. This functions aims to download a precompiled binary of
SLiM and automatically links slimr to SLiM. Unfortunately due to the
variety of systems and installs this might not work. If that is is the
case please follow the excellent documentation how to install SLiM on
their websites.

- [Windows](http://benhaller.com/slim/SLiM_Manual.pdf#page=64)
- [Linux](http://benhaller.com/slim/SLiM_Manual.pdf#page=59)
- [MacOS](http://benhaller.com/slim/SLiM_Manual.pdf#page=54)

## A first test run

The next step is to make sure slimr is “linked” to slim (by knowing the
location of the folder where the slim program is installed.). To check
you can try:

``` r
slimr::slim_is_avail()
#> [1] TRUE
```

And if true is returned you are ready to go and run the test example
below. In the case the test was not successful we need to find the
folder where the slim executable has been installed and set this path in
the R environment accordingly.

For example if slim R is installed at
`C:/Program Files/R/R-4.3.1/library/slimr` then you need to specify this
via:

``` r
Sys.setenv(SLIM_HOME='C:/Program Files/R/R-4.3.1/library/slimr')
```

If you want to add this path permanently to your Rstudio installation
(so no need to run Sys.setenv every time) you can use the command
`usethis::edit_r_environ()` and add a line like
`SLIMR_HOME='C:/Program Files/R/R-4.3.1/library/slimr'` to this file.

## Run a first simple test

To be able to run SLiM within slimr we need to create a simple slim
script. Below is the slimr version of the first slim script as presented
in the excellent [SLiM](https://messerlab.org/slim/) manual, called
receipes. There are hundreds of more advanced script and we provide also
several worked out examples in the manuscript (Russell et al. submitted,
[bioRxiv](https://www.biorxiv.org/content/10.1101/2021.08.05.455258v2)
). The example below is simply to test if slim is installed correctly
and works together with slimr.

Running this code should give you the output as below (a return value of
zero means success).

``` r
library(slimr)
#> Welcome to the slimr package for forward population genetics simulation in SLiM. For more information on SLiM please visit https://messerlab.org/slim/ .
#> 
#> Attaching package: 'slimr'
#> The following object is masked from 'package:methods':
#> 
#>     initialize
#> The following object is masked from 'package:base':
#> 
#>     interaction

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

#run slim from within slimr
slim_run(script_1)
#> 
#> 
#> Simulation finished with exit status: 0
#> 
#> Success!
```

slimr shines because it can create so called templates to run scripts
with different parameter settings. It also allows to “collect” the
output from SLiM and load it back into R, so you can run a full
simulation with lots of parameters settings using parallel cores if
available and analyse the output directly in R. See the vignettes for
details of these features and how to use them.

## A complete workflow

Below is a simle “complete” workflow. \* Creating a script in R \* Run
SLiM \* Load the results into R \* Analyse and visualise the results.

As an example we simply will run a single population of 33 individuals
for 100 generations, with a single chromosome of (length=100000 bases),
and high mutation rate (1e-5) \[to shorten run-time\]. Every 10
generation we will save the genetic status of each inidiviual for 100
generations. Once completed we read back in the genotypes (as a genlight
object) and count the number of loci every of the 10 generations (the
number of loci increases due to the mutations, that occurs during the
simulation.

``` r
library(slimr)
# package adegenet as we are using genlight objects
if (!require(adegenet)) install.packages("adegenet")
#> Loading required package: adegenet
#> Loading required package: ade4
#> Warning: package 'ade4' was built under R version 4.2.2
#> 
#>    /// adegenet 2.1.7 is loaded ////////////
#> 
#>    > overview: '?adegenet'
#>    > tutorials/doc/questions: 'adegenetWeb()' 
#>    > bug reports/feature requests: adegenetIssues()
library(adegenet)

slim_script(
  slim_block (initialize(),
  {
    initializeMutationRate(1e-5);
    ## m1 mutation type: neutral
    initializeMutationType("m1", 0.5, "f", 0.0);
    ## g1 genomic element type: uses m1 for all mutations
    
    initializeGenomicElementType("g1", m1, 1.0);
    ## uniform chromosome of length 100 kb
    initializeGenomicElement(g1, 0, 99999 );
    ## uniform recombination along the chromosome
    initializeRecombinationRate(1e-8);
  }),
  slim_block(1, early(),
    {
    ## create a population of 33 individuals
    sim.addSubpop("p1", 33);
    }),
  
  slim_block(1, 100, late(), 
    {
      #create an output 
      slimr_output(p1.genomes.output(), "p1", do_every=10);
    }),
  
    
  slim_block(100,late(),

    {
    sim.simulationFinished();
    })


)->script_2
```

As before we setup a script, but this time we would like to run SLiM in
parallel (does not make much sense as it is a single run only, but this
is for demonstration purposes)

``` r
library(future)
# we want to run SLiM using 5 local cores
# please note on Linux and Windows you would like to use multicore as this is faster as it is a 'real' fork, 
# but multisession works on all systems
plan(multisession, workers = 5)
sr <- slim_run(script_2 , parallel = TRUE)
#> 
#> 
#> Simulation finished with exit status: 0
#> 
#> Success!
```

And finally we want to get the results back into R. The `sr` object has
information on all the runs and output files and data and can be used to
get the results directly back into R. Please note that SLiM will still
produce all the output files it as if it would have been run from the
command line, hence the user can also explore those files.

In a typical slimr workflow though the user wants to have the data
loaded back into R and depending on the output (in this case we used the
function `genomes.output()` to save) we can easily create `genlight`
objects that hold the genomics data in a very memory efficient way. To
do so we use the `slim_extract_genlight` function.

Before we use this function we may want to explore the `sr` object which
is a tibble that holds all the information that was used during runs.

``` r
str(sr)
#> List of 6
#>  $ output     : chr [1:42] "// Initial random seed:" "3575120756" "" "// RunInitializeCallbacks():" ...
#>  $ exit_status: int 0
#>  $ output_data: slmr_tp_ [10 × 5] (S3: slimr_output_data/spec_tbl_df/tbl_df/tbl/data.frame)
#>   ..$ generation: int [1:10] 10 20 30 40 50 60 70 80 90 100
#>   ..$ name      : chr [1:10] "p1" "p1" "p1" "p1" ...
#>   ..$ expression: chr [1:10] "p1.genomes.output()" "p1.genomes.output()" "p1.genomes.output()" "p1.genomes.output()" ...
#>   ..$ type      : chr [1:10] "slim_output" "slim_output" "slim_output" "slim_output" ...
#>   ..$ data      : chr [1:10] "#OUT: 10 GS 66\nMutations:\n118 9 m1 81596 0 0.5 p1 1 5\n59 10 m1 87231 0 0.5 p1 1 7\n60 11 m1 92977 0 0.5 p1 1"| __truncated__ "#OUT: 20 GS 66\nMutations:\n76 43 m1 58278 0 0.5 p1 1 7\n48 44 m1 7534 0 0.5 p1 1 21\n51 45 m1 19321 0 0.5 p1 1"| __truncated__ "#OUT: 30 GS 66\nMutations:\n82 43 m1 58278 0 0.5 p1 1 10\n2 44 m1 7534 0 0.5 p1 1 33\n8 45 m1 19321 0 0.5 p1 1 "| __truncated__ "#OUT: 40 GS 66\nMutations:\n44 44 m1 7534 0 0.5 p1 1 48\n51 45 m1 19321 0 0.5 p1 1 48\n64 46 m1 51375 0 0.5 p1 "| __truncated__ ...
#>   ..- attr(*, "spec")=
#>   .. .. cols(
#>   .. ..   generation = col_integer(),
#>   .. ..   name = col_character(),
#>   .. ..   expression = col_character(),
#>   .. ..   type = col_character(),
#>   .. ..   data = col_character()
#>   .. .. )
#>   ..- attr(*, "problems")=<externalptr> 
#>  $ process    :Classes 'process', 'R6' PROCESS 'slim.exe', finished.
#>  
#>  $ error      : chr(0) 
#>  $ output_file: chr "F:\\Rtemp\\RtmpCsVojl\\file4342c2c7e94.txt"
#>  - attr(*, "class")= chr "slimr_results"

sr$output_data
#> # A tibble: 10 × 5
#>    generation name  expression          type        data                        
#>         <int> <chr> <chr>               <chr>       <chr>                       
#>  1         10 p1    p1.genomes.output() slim_output "#OUT: 10 GS 66\nMutations:…
#>  2         20 p1    p1.genomes.output() slim_output "#OUT: 20 GS 66\nMutations:…
#>  3         30 p1    p1.genomes.output() slim_output "#OUT: 30 GS 66\nMutations:…
#>  4         40 p1    p1.genomes.output() slim_output "#OUT: 40 GS 66\nMutations:…
#>  5         50 p1    p1.genomes.output() slim_output "#OUT: 50 GS 66\nMutations:…
#>  6         60 p1    p1.genomes.output() slim_output "#OUT: 60 GS 66\nMutations:…
#>  7         70 p1    p1.genomes.output() slim_output "#OUT: 70 GS 66\nMutations:…
#>  8         80 p1    p1.genomes.output() slim_output "#OUT: 80 GS 66\nMutations:…
#>  9         90 p1    p1.genomes.output() slim_output "#OUT: 90 GS 66\nMutations:…
#> 10        100 p1    p1.genomes.output() slim_output "#OUT: 100 GS 66\nMutations…
```

Now we can use the `slim_extract_genlight` function to convert the SLiM
output files back into R, which creates a list of 10 genlight objects,
one for each generation.

``` r


gls<- slim_extract_genlight(sr, by=c("generation"))
gls
#> # A tibble: 10 × 2
#>    generation genlight        
#>         <int> <list>          
#>  1         10 <genlight[,232]>
#>  2         20 <genlight[,327]>
#>  3         30 <genlight[,332]>
#>  4         40 <genlight[,402]>
#>  5         50 <genlight[,346]>
#>  6         60 <genlight[,432]>
#>  7         70 <genlight[,478]>
#>  8         80 <genlight[,475]>
#>  9         90 <genlight[,525]>
#> 10        100 <genlight[,550]>


#the genlight object for generation 10
gls$genlight[[1]]
#>  /// GENLIGHT OBJECT /////////
#> 
#>  // 33 genotypes,  232 binary SNPs, size: 70.1 Kb
#>  0 (0 %) missing data
#> 
#>  // Basic content
#>    @gen: list of 33 SNPbin
#> 
#>  // Optional content
#>    @ind.names:  33 individual labels
#>    @loc.names:  232 locus labels
#>    @position: integer storing positions of the SNPs
#>    @other: a list containing: mut_type  prevalence

#number of loci at generation 10
nLoc(gls$genlight[[1]])
#> [1] 232
```

And finally we can use a simply `lapply` to find the number of loci in
the genlight for each generation (e.g. the number of loci that are
polymorphic).

``` r


nloci <- unlist(lapply(gls$genlight, nLoc))
barplot(nloci, col=rainbow(length(gls$genlight)), names.arg = 1:10, xlab="generation",
        ylab="# loci")
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

As we expect, this value gradually increases over time.

Within a simulation, it is also possible to output any file format or
intermediate result in a variety of common and self-defined formats,
(e.g VCF files, Fst values or a pedigree trees) and then extract the
information using the workflow outlined above.

A very important feature, not shown here, is that you can create so
called template scripts that have placeholders for parameters, that can
be filled via a R data structure and all run all simuations via a single
call to SLiM using `slim_run()`. Please see the vignettes for such an
example.

We believe that a simplified workflow will allow researchers to explore
their parameter space in more detail and therefore, ultimately, will
lead to a better understanding of the system under study.

Have fun using slimr!!!

Russell et al.

## Code of Conduct

Please note that the slimr project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
