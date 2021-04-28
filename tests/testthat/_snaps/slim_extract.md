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
        type           expression               generation name  data      subpops    
        <chr>          <chr>                         <int> <chr> <list>    <list>     
      1 slim_nucleoti~ slimr_output_nucleotide~        250 seqs  <DNAStrn~ <chr [1,00~
      2 slim_nucleoti~ slimr_output_nucleotide~        500 seqs  <DNAStrn~ <chr [1,00~
      3 slim_nucleoti~ slimr_output_nucleotide~        750 seqs  <DNAStrn~ <chr [1,00~
      4 slim_nucleoti~ slimr_output_nucleotide~       1000 seqs  <DNAStrn~ <chr [1,00~

