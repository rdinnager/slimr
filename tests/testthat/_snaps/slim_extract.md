# slim_results_to_data works as expected

    Code
      print(dat)
    Output
      # A tibble: 5 x 5
        type        expression       generation name   data          
        <chr>       <chr>                 <int> <chr>  <list>        
      1 slim_output sim.outputFull()         20 output <slmr_tF_ [3]>
      2 slim_output sim.outputFull()         40 output <slmr_tF_ [3]>
      3 slim_output sim.outputFull()         60 output <slmr_tF_ [3]>
      4 slim_output sim.outputFull()         80 output <slmr_tF_ [3]>
      5 slim_output sim.outputFull()        100 output <slmr_tF_ [3]>

---

    Code
      print(dat_nuc)
    Output
      # A tibble: 4 x 6
        type             expression                 generation name  data       subpops
        <chr>            <chr>                           <int> <chr> <list>     <list> 
      1 slim_nucleotides slimr_output_nucleotides()        250 seqs  <DNAStrnS> <chr [~
      2 slim_nucleotides slimr_output_nucleotides()        500 seqs  <DNAStrnS> <chr [~
      3 slim_nucleotides slimr_output_nucleotides()        750 seqs  <DNAStrnS> <chr [~
      4 slim_nucleotides slimr_output_nucleotides()       1000 seqs  <DNAStrnS> <chr [~

# slim_extract_genome works as expected

    Code
      print(dat)
    Output
      # A tibble: 30 x 11
         generation mut_id unique_mut_id mut_type chrome_pos selection dominance
              <int>  <int>         <int> <chr>         <int>     <dbl>     <dbl>
       1         20      2             8 m1             9563         0       0.5
       2         20      1            16 m1             6162         0       0.5
       3         20      0            31 m1            51960         0       0.5
       4         40      2            40 m1            66794         0       0.5
       5         40      0            46 m1            67286         0       0.5
       6         40      1            54 m1            14124         0       0.5
       7         60      2            46 m1            67286         0       0.5
       8         60      1            70 m1            55941         0       0.5
       9         60      4            86 m1            90078         0       0.5
      10         60      6            89 m1            44993         0       0.5
      # ... with 20 more rows, and 4 more variables: subpop <chr>, first_gen <int>,
      #   prevalence <int>, nucleotide <chr>

---

    Code
      print(dat2)
    Output
      # A tibble: 100 x 4
         generation gen_id gen_type mut_list 
              <int> <chr>  <chr>    <list>   
       1         20 p*:0   A        <int [1]>
       2         20 p*:1   A        <int [1]>
       3         20 p*:2   A        <int [1]>
       4         20 p*:3   A        <int [1]>
       5         20 p*:4   A        <int [1]>
       6         20 p*:5   A        <int [1]>
       7         20 p*:6   A        <int [1]>
       8         20 p*:7   A        <int [1]>
       9         20 p*:8   A        <int [1]>
      10         20 p*:9   A        <int [1]>
      # ... with 90 more rows

---

    Code
      print(dat3)
    Output
      # A tibble: 105 x 13
         generation gen_id gen_type mut_id unique_mut_id mut_type chrome_pos selection
              <int> <chr>  <chr>     <int>         <int> <chr>         <int>     <dbl>
       1         20 p*:0   A             0            31 m1            51960         0
       2         20 p*:1   A            NA            NA <NA>             NA        NA
       3         20 p*:2   A            NA            NA <NA>             NA        NA
       4         20 p*:3   A            NA            NA <NA>             NA        NA
       5         20 p*:4   A            NA            NA <NA>             NA        NA
       6         20 p*:5   A            NA            NA <NA>             NA        NA
       7         20 p*:6   A            NA            NA <NA>             NA        NA
       8         20 p*:7   A            NA            NA <NA>             NA        NA
       9         20 p*:8   A            NA            NA <NA>             NA        NA
      10         20 p*:9   A            NA            NA <NA>             NA        NA
      # ... with 95 more rows, and 5 more variables: dominance <dbl>, subpop <chr>,
      #   first_gen <int>, prevalence <int>, nucleotide <chr>

# slim_extract_genlight works as expected

    Code
      print(gl)
    Output
       /// GENLIGHT OBJECT /////////
      
       // 500 genotypes,  497 binary SNPs, size: 812.8 Kb
       0 (0 %) missing data
      
       // Basic content
         @gen: list of 500 SNPbin
      
       // Optional content
         @ind.names:  500 individual labels
         @loc.names:  497 locus labels
         @position: integer storing positions of the SNPs
         @pop: population of each individual (group size range: 500-500)
         @other: a list containing: mut_type  prevalence 
      

