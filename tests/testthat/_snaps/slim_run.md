# slim_run works with output

    Code
      run_w_out <- slim_script(slim_block(initialize(), {
        setSeed(12345)
        initializeMutationRate(1e-07)
        initializeMutationType("m1", 0.5, "f", 0)
        initializeGenomicElementType("g1", m1, 1)
        initializeGenomicElement(g1, 0, 99999)
        initializeRecombinationRate(1e-08)
      }), slim_block(1, {
        sim.addSubpop("p1", 100)
      }), slim_block(1, 100, {
        slimr_output(p1.outputMSSample(sampleSize = 10), name = "MS", do_every = 10)
      }), slim_block(100, {
        sim.simulationFinished()
      })) %>% slim_run()
    Message <rlang_message>
      
      
      Simulation finished with exit status: 0
      
      Success!
    Code
      cat(run_w_out$output_data$data)
    Output
      #OUT: 10 SM p1 10
      //
      segsites: 1
      positions: 0.074220742207422
      0
      0
      0
      0
      0
      0
      0
      1
      0
      0
       #OUT: 20 SM p1 10
      //
      segsites: 1
      positions: 0.777187771877719
      0
      0
      0
      0
      0
      0
      0
      0
      1
      0
       #OUT: 30 SM p1 10
      //
      segsites: 2
      positions: 0.153961539615396 0.699106991069911
      00
      00
      00
      00
      01
      00
      00
      00
      00
      10
       #OUT: 40 SM p1 10
      //
      segsites: 2
      positions: 0.146721467214672 0.919809198091981
      00
      10
      00
      01
      00
      00
      00
      00
      00
      10
       #OUT: 50 SM p1 10
      //
      segsites: 4
      positions: 0.153961539615396 0.555835558355584 0.728287282872829 0.853318533185332
      0101
      0000
      0000
      0000
      0000
      0000
      0000
      0000
      0000
      1010
       #OUT: 60 SM p1 10
      //
      segsites: 4
      positions: 0.153961539615396 0.372933729337293 0.383823838238382 0.728287282872829
      0000
      0000
      0000
      0000
      0000
      1001
      0000
      0110
      0000
      0000
       #OUT: 70 SM p1 10
      //
      segsites: 4
      positions: 0.044430444304443 0.277582775827758 0.312583125831258 0.395133951339513
      1000
      0000
      0100
      0010
      0010
      0000
      0001
      0000
      0000
      0000
       #OUT: 80 SM p1 10
      //
      segsites: 4
      positions: 0.153961539615396 0.317443174431744 0.728287282872829 0.865348653486535
      0001
      1010
      0000
      0000
      0000
      1010
      0100
      1010
      0000
      0000
       #OUT: 90 SM p1 10
      //
      segsites: 1
      positions: 0.857898578985790
      1
      0
      0
      0
      0
      1
      0
      0
      1
      0
       #OUT: 100 SM p1 10
      //
      segsites: 3
      positions: 0.153961539615396 0.602986029860299 0.728287282872829
      000
      000
      000
      000
      101
      010
      000
      000
      000
      000

