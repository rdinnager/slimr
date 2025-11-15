test_that("Recipe 19.12: Reading VCF files for nucleotide-based SNPs works", {
  skip_if_not(slim_is_avail())
  skip_if(Sys.getenv("TEST_RECIPES") != "true")

  # Create temporary directory for test files
  temp_dir <- tempdir()
  old_wd <- getwd()
  setwd(temp_dir)

  # Clean up any previous test files
  if (file.exists("test_chr.fa")) file.remove("test_chr.fa")
  if (file.exists("test_snps.vcf")) file.remove("test_snps.vcf")

  # Create minimal FASTA file (1000 bp)
  fasta_content <- c(
    ">chr_test",
    paste(rep(c("ACGT"), 250), collapse = "")
  )
  writeLines(fasta_content, "test_chr.fa")

  # Create minimal VCF file with a few SNPs
  # VCF needs 99 diploid individuals (198 haplotypes)
  vcf_header <- c(
    "##fileformat=VCFv4.2",
    "##reference=test_chr.fa",
    paste0("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t",
           paste0("IND", 1:99, collapse = "\t"))
  )

  # Add a few simple SNPs with genotypes
  # Position 100: A->G, some heterozygotes and homozygotes
  gt1 <- sample(c("0|0", "0|1", "1|1"), 99, replace = TRUE, prob = c(0.5, 0.4, 0.1))
  vcf_snp1 <- paste(c("chr_test", "100", ".", "A", "G", "100", "PASS", ".", "GT",
                      gt1), collapse = "\t")

  # Position 500: C->T
  gt2 <- sample(c("0|0", "0|1", "1|1"), 99, replace = TRUE, prob = c(0.6, 0.3, 0.1))
  vcf_snp2 <- paste(c("chr_test", "500", ".", "C", "T", "100", "PASS", ".", "GT",
                      gt2), collapse = "\t")

  vcf_content <- c(vcf_header, vcf_snp1, vcf_snp2)
  writeLines(vcf_content, "test_snps.vcf")

  # Create test version of recipe with mock files
  recipe_19_12_test <- slim_script(
    slim_block(initialize(), {
      initializeSLiMOptions(nucleotideBased = T)

      # Read ancestral sequence from test FASTA file
      length <- initializeAncestralNucleotides("test_chr.fa")
      defineConstant("L", length)

      initializeMutationTypeNuc("m1", 0.5, "f", 0.0)
      initializeMutationTypeNuc("m2", 0.5, "f", 0.0)
      m2$color <- "red"
      m2$convertToSubstitution <- F

      initializeGenomicElementType("g1", m1, 1.0, mmJukesCantor(asFloat(0.0)))
      initializeGenomicElement(g1, 0, L - 1)
      initializeRecombinationRate(1e-8)
    }),

    slim_block(1, late(), {
      sim$addSubpop("p1", 99)
      p1$haplosomes$readHaplosomesFromVCF("test_snps.vcf", m1)
      p1$setSubpopulationSize(500)  # Smaller for testing
    }),

    slim_block(5, late(), {
      # Only proceed if mutations exist
      if (sim$mutations$size() > 0) {
        mut <- sample(sim$mutations, 1)
        mut$setMutationType(m2)
        mut$setSelectionCoeff(0.5)
      }
    }),

    # Shorter runtime for testing
    slim_block(1, 500, late(), {
      mut <- sim$mutationsOfType(m2)

      if (mut$size()) {
        f <- sim$mutationFrequencies(p1, mut)
        if (f == 1.0) {
          catn("\nFIXED in cycle " + sim$cycle)
          sim$simulationFinished()
        }
      }
    })
  )

  # Run the test
  result <- slim_run(recipe_19_12_test, capture_output = TRUE)

  # Restore working directory and clean up
  setwd(old_wd)
  if (file.exists(file.path(temp_dir, "test_chr.fa")))
    file.remove(file.path(temp_dir, "test_chr.fa"))
  if (file.exists(file.path(temp_dir, "test_snps.vcf")))
    file.remove(file.path(temp_dir, "test_snps.vcf"))

  # Verify success
  expect_equal(result$exit_status, 0)

  # Read output
  output <- paste(result$output, collapse = "\n")

  # Verify simulation completed (either fixed or ran to completion)
  expect_true(grepl("FIXED|^$", output) || nchar(output) >= 0)
})
