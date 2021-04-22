# templating works

    Code
      print(script_temp)
    Output
      <slimr_script[3]>
      block_init:initialize() {
          initializeMutationRate(..mut_rate..);
          initializeMutationType("m1", 0.5, "f", 0);
          initializeGenomicElementType("g1", m1, 1);
          initializeGenomicElement(g1, 0, ..genome_size..);
          initializeRecombinationRate(1e-08);
      }
      
      block_2:1 early() {
          sim.addSubpop("p1", 500);
      }
      
      block_3:10000 early() {
          sim.simulationFinished();
      }
      This slimr_script has templating in block(s) block_init for variables mut_rate
      and genome_size.

---

    Code
      print(script_partial)
    Output
      <slimr_script_coll[2]>
      <1>
      
      block_init:initialize() {
          initializeMutationRate(1e-05);
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
      
      <2>
      
      block_init:initialize() {
          initializeMutationRate(1e-07);
          initializeMutationType("m1", 0.5, "f", 0);
          initializeGenomicElementType("g1", m1, 1);
          initializeGenomicElement(g1, 0, 2999);
          initializeRecombinationRate(1e-08);
      }
      
      block_2:1 early() {
          sim.addSubpop("p1", 500);
      }
      
      block_3:10000 early() {
          sim.simulationFinished();
      }

