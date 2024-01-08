# `<-` and `$` are handled directly in slim_block and slim_script

    Code
      print(test_script)
    Output
      <slimr_script[3]>
      block_1:initialize() {
          initializeMutationRate(1e-07);
          initializeMutationType("m1", 0.5, "f", 0);
          initializeGenomicElementType("g1", m1, 1);
          initializeGenomicElement(g1, 0, 1e+05 - 1);
          initializeRecombinationRate(1e-08);
      }
      
      block_2:1:100 early() {
          y = sim.generation;
          print(y);
      }
      
      block_3:100 early() {
          sim.simulationFinished();
      }

