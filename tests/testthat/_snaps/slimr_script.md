# slimr_script output is correct

    Code
      print(script_1)
    Output
      <slimr_script[3]>
      block_init:initialize() {
          initializeMutationRate(1e-07);
          initializeMutationType("m1", 0.5, "f", 0);
          initializeGenomicElementType("g1", m1, 1);
          initializeGenomicElement(g1, 0, 99999);
          initializeRecombinationRate(1e-08);
      }
      
      block_2:1 early() {
          sim.addSubpop("p1", 500);
      }
      
      block_3:10000 early() {
          sim.simulationFinished();
      }

# conversion from text to slimr_script works

    Code
      print(to_script)
    Output
      <slimr_script[3]>
      block_init_1:initialize() {
          initializeMutationRate(1e-07);
          initializeMutationType("m1", 0.5, "f", asFloat(0));
          initializeGenomicElementType("g1", m1, asFloat(1));
          initializeGenomicElement(g1, 0, 99999);
          initializeRecombinationRate(1e-08);
      }
      
      block_2:1 early() {
          sim.addSubpop("p1", 500);
      }
      
      block_3:10000 early() {
          sim.simulationFinished();
      }

