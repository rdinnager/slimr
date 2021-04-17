# Retrieving SLiM recipes works

    // Keywords: 
    
    initialize() {
    	initializeMutationRate(1e-7);
    	initializeMutationType("m1", 0.5, "f", 0.0);
    	initializeGenomicElementType("g1", m1, 1.0);
    	initializeGenomicElement(g1, 0, 99999);
    	initializeRecombinationRate(1e-8);
    }
    1 { sim.addSubpop("p1", 500); }
    10000 late() { sim.outputFull(); }

# All SLiM recipes can be converted to slimr_script objects properly

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

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 late() {
        sim.outputFull();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:5000 late() {
        p1.outputSample(10);
    }
    
    block_4:10000 late() {
        sim.outputFull();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.01);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
        p1.setMigrationRates(p2, 0.01);
        p2.setMigrationRates(p1, 0.01);
    }
    
    block_3:10000 late() {
        allIndividuals = sim.subpopulations.individuals;
        w = asFloat(allIndividuals.countOfMutationsOfType(m2) + 1);
        sampledIndividuals = sample(allIndividuals, 10, weights = w);
        sampledIndividuals.genomes.output();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:5000 late() {
        p1.outputSample(10);
    }
    
    block_4:10000 late() {
        sim.outputFull();
    }
    
    block_5:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 999999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
        sim.addSubpop("p2", 1000);
        p1.setMigrationRates(p2, 0.001);
        p2.setMigrationRates(p1, 0.001);
        log = sim.createLogFile("~/Desktop/sim_log.txt", logInterval = 10);
        log.addGeneration();
        log.addCustomColumn("FST", "calcFST(p1.genomes, p2.genomes);");
    }
    
    block_3:20000 late() {
        ;
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
    }
    
    block_3:2000 late() {
        g = sample(sim.subpopulations.genomes, 10, T);
        m = sortBy(unique(g.mutations), "position");
        cat("\n\nsegsites: " + size(m) + "\n");
        positions = format("%.6f", m.position/sim.chromosome.lastPosition);
        cat("positions: " + paste(positions, sep = " ") + "\n");
        for (genome in g) {
            hasMuts = (match(m, genome.mutations) >= 0);
            cat(paste(asInteger(hasMuts), sep = "") + "\n");
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:1000 early() {
        p1.setSubpopulationSize(100);
    }
    
    block_4:2000 early() {
        p1.setSubpopulationSize(1000);
    }
    
    block_5:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000:1099 early() {
        newSize = asInteger(p1.individualCount * 1.03);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000:1099 early() {
        newSize = asInteger(p1.individualCount * 1.03);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000:1099 early() {
        newSize = asInteger(p1.individualCount * 1.03);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000:1099 early() {
        newSize = asInteger(p1.individualCount * 1.03);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000:1099 early() {
        newSize = asInteger(p1.individualCount * 1.03);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1500);
    }
    
    block_3:early() {
        newSize = cos((sim.generation - 1)/100) * 500 + 1000;
        p1.setSubpopulationSize(asInteger(newSize));
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "e", -0.01);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:early() {
        meanFitness = mean(p1.cachedFitness(NULL));
        newSize = asInteger(100 * meanFitness);
        p1.setSubpopulationSize(newSize);
    }
    
    block_4:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 100);
        sim.addSubpop("p3", 1000);
        p1.setMigrationRates(c(p2, p3), c(0.2, 0.1));
        p2.setMigrationRates(c(p1, p3), c(0.8, 0.01));
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[8]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:100 early() {
        sim.addSubpop("p2", 100);
    }
    
    block_4:100:150 early() {
        migrationProgress = (sim.generation - 100)/50;
        p1.setMigrationRates(p2, 0.2 * migrationProgress);
        p2.setMigrationRates(p1, 0.8 * migrationProgress);
    }
    
    block_5:1000 early() {
        sim.addSubpop("p3", 10);
    }
    
    block_6:1000:1100 early() {
        p3Progress = (sim.generation - 1000)/100;
        p3.setSubpopulationSize(asInteger(990 * p3Progress + 10));
        p1.setMigrationRates(p3, 0.1 * p3Progress);
        p2.setMigrationRates(p3, 0.01 * p3Progress);
    }
    
    block_7:2000 early() {
        p2.setSubpopulationSize(0);
    }
    
    block_8:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[8]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:100 early() {
        sim.addSubpopSplit("p2", 100, p1);
    }
    
    block_4:100:150 early() {
        migrationProgress = (sim.generation - 100)/50;
        p1.setMigrationRates(p2, 0.2 * migrationProgress);
        p2.setMigrationRates(p1, 0.8 * migrationProgress);
    }
    
    block_5:1000 early() {
        sim.addSubpopSplit("p3", 10, p2);
    }
    
    block_6:1000:1100 early() {
        p3Progress = (sim.generation - 1000)/100;
        p3.setSubpopulationSize(asInteger(990 * p3Progress + 10));
        p1.setMigrationRates(p3, 0.1 * p3Progress);
        p2.setMigrationRates(p3, 0.01 * p3Progress);
    }
    
    block_7:2000 early() {
        p2.setSubpopulationSize(0);
    }
    
    block_8:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 1000);
    }
    
    block_3:1000 early() {
        sim.addSubpop("p3", 300);
        p3.setMigrationRates(c(p1, p2), c(0.75, 0.25));
    }
    
    block_4:1000 late() {
        p3.setMigrationRates(c(p1, p2), c(0, 0));
        p1.setSubpopulationSize(0);
        p2.setSubpopulationSize(0);
    }
    
    block_5:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        subpopCount = 10;
        for (i in 1:subpopCount) sim.addSubpop(i, 500);
        for (i in 2:subpopCount) sim.subpopulations[i - 1] %.% setMigrationRates(i - 1, 0.2);
        for (i in 1:(subpopCount - 1)) sim.subpopulations[i - 1] %.% setMigrationRates(i + 1, 0.05);
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        subpopCount = 5;
        for (i in 1:subpopCount) sim.addSubpop(i, 500);
        for (i in 1:subpopCount) for (j in 1:subpopCount) if (i != j) sim.subpopulations[i - 1] %.% setMigrationRates(j, 0.05);
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        metapopSide = 3;
        metapopSize = metapopSide * metapopSide;
        for (i in 1:metapopSize) sim.addSubpop(i, 500);
        subpops = sim.subpopulations;
        for (x in 1:metapopSide) for (y in 1:metapopSide) {
            destID = (x - 1) + (y - 1) * metapopSide + 1;
            destSubpop = subpops[destID - 1];
            if (x > 1) destSubpop.setMigrationRates(destID - 1, 0.05);
            if (x < metapopSide) destSubpop.setMigrationRates(destID + 1, 0.05);
            if (y > 1) destSubpop.setMigrationRates(destID - metapopSide, 0.05);
            if (y < metapopSide) destSubpop.setMigrationRates(destID + metapopSide, 0.05);
        }
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.3);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        mSide = 10;
        for (i in 1:(mSide * mSide)) sim.addSubpop(i, 500);
        subpops = sim.subpopulations;
        for (x in 1:mSide) for (y in 1:mSide) {
            destID = (x - 1) + (y - 1) * mSide + 1;
            ds = subpops[destID - 1];
            if (x > 1) ds.setMigrationRates(destID - 1, runif(1, 0, 0.05));
            if (x < mSide) ds.setMigrationRates(destID + 1, runif(1, 0, 0.05));
            if (y > 1) ds.setMigrationRates(destID - mSide, runif(1, 0, 0.05));
            if (y < mSide) ds.setMigrationRates(destID + mSide, runif(1, 0, 0.05));
            xd = ((x - 1)/(mSide - 1)) * 0.9 + 0.05;
            yd = ((y - 1)/(mSide - 1)) * 0.9 + 0.05;
            ds.configureDisplay(c(xd, yd), 0.4);
        }
        subpops[sample(0:99, 25)] %.% setSubpopulationSize(0);
        target_subpop = sample(sim.subpopulations, 1);
        sample(target_subpop.genomes, 10) %.% addNewDrawnMutation(m2, 20000);
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeMutationRate(2.36e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 9999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", asInteger(round(7310.37086759523)));
    }
    
    block_3:73105 {
        p1.setSubpopulationSize(asInteger(round(14474.5460875357)));
    }
    
    block_4:76968 {
        sim.addSubpopSplit("p2", asInteger(round(1861.28819002769)), p1);
        p1.setMigrationRates(c(p2), c(0.0001524422112));
        p2.setMigrationRates(c(p1), c(0.0001524422112));
    }
    
    block_5:78084 early() {
        sim.addSubpopSplit("p3", asInteger(round(553.8181989)), p2);
        p2.setSubpopulationSize(asInteger(round(1032.10469573334)));
        p1.setMigrationRates(c(p2, p3), c(2.54332678e-05, 7.770583877e-06));
        p2.setMigrationRates(c(p1, p3), c(2.54332678e-05, 3.115817913e-05));
        p3.setMigrationRates(c(p1, p2), c(7.770583877e-06, 3.115817913e-05));
    }
    
    block_6:78084:79024 early() {
        t = sim.generation - 78084;
        p2_size = round(1032.10469573334 * (1 + 0.003784324268)^t);
        p3_size = round(553.8181989 * (1 + 0.004780219543)^t);
        p2.setSubpopulationSize(asInteger(p2_size));
        p3.setSubpopulationSize(asInteger(p3_size));
    }
    
    block_7:79024 late() {
        p1.outputSample(216);
        p2.outputSample(198);
        p3.outputSample(206);
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeMutationRate(2.36e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 9999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", asInteger(round(7310.37086759523)));
    }
    
    block_3:73105 {
        p1.setSubpopulationSize(asInteger(round(14474.5460875357)));
    }
    
    block_4:76968 {
        sim.addSubpopSplit("p2", asInteger(round(1861.28819002769)), p1);
        p1.setMigrationRates(c(p2), c(0.0001524422112));
        p2.setMigrationRates(c(p1), c(0.0001524422112));
    }
    
    block_5:78084 early() {
        sim.addSubpopSplit("p3", asInteger(round(553.8181989)), p2);
        p2.setSubpopulationSize(asInteger(round(1032.10469573334)));
        p1.setMigrationRates(c(p2, p3), c(2.54332678e-05, 7.770583877e-06));
        p2.setMigrationRates(c(p1, p3), c(2.54332678e-05, 3.115817913e-05));
        p3.setMigrationRates(c(p1, p2), c(7.770583877e-06, 3.115817913e-05));
    }
    
    block_6:78084:79024 early() {
        t = sim.generation - 78084;
        p2_size = round(1032.10469573334 * (1 + 0.003784324268)^t);
        p3_size = round(553.8181989 * (1 + 0.004780219543)^t);
        p2.setSubpopulationSize(asInteger(p2_size));
        p3.setSubpopulationSize(asInteger(p3_size));
    }
    
    block_7:79024 late() {
        p1.outputSample(216);
        p2.outputSample(198);
        p3.outputSample(206);
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.01);
        initializeGenomicElementType("g1", c(m1, m2), c(0.8, 0.2));
        initializeGenomicElement(g1, 0, 9999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
    }
    
    block_3:50000 early() {
        p1.setSubpopulationSize(1000);
    }
    
    block_4:55000 early() {
        p1.setSubpopulationSize(5000);
    }
    
    block_5:60000 late() {
        p1.outputSample(10);
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.01);
        initializeGenomicElementType("g1", c(m1, m2), c(0.8, 0.2));
        initializeGenomicElement(g1, 0, 9999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
    }
    
    block_3:50000 early() {
        p1.setSubpopulationSize(1000);
    }
    
    block_4:55000 early() {
        p1.setSubpopulationSize(5000);
    }
    
    block_5:60000 late() {
        p1.outputSample(10);
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        ends = c(sort(sample(0:99998, 999)), 99999);
        rates = runif(1000, 1e-09, 1e-07);
        initializeRecombinationRate(rates, ends);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeGeneConversion(0.2, 500, 1);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(10000, 1));
        initializeGenomicElement(g1, 0, 2999999);
        rates = c(1e-09, 0.5, 1e-09, 0.5, 1e-09);
        ends = c(999999, 1e+06, 1999999, 2e+06, 2999999);
        initializeRecombinationRate(rates, ends);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeSex("A");
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeSex("A");
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500, 0.6);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeSex("A");
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500, 0.6);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeSex("X");
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.setSelfingRate(0.8);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.setCloningRate(0.1);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.setCloningRate(0.1);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeMutationType("m3", 0.1, "g", -0.03, 0.2);
        initializeMutationType("m4", 0.8, "e", 0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeMutationType("m3", 0.1, "g", -0.03, 0.2);
        initializeMutationType("m4", 0.8, "e", 0.1);
        initializeGenomicElementType("g1", c(m2, m3, m4), c(2, 8, 0.1));
        initializeGenomicElementType("g2", c(m1, m3), c(9, 1));
        initializeGenomicElementType("g3", c(m1), 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeMutationType("m3", 0.1, "g", -0.03, 0.2);
        initializeMutationType("m4", 0.8, "e", 0.1);
        initializeGenomicElementType("g1", c(m2, m3, m4), c(2, 8, 0.1));
        initializeGenomicElementType("g2", c(m1, m3), c(9, 1));
        initializeGenomicElementType("g3", c(m1), 1);
        base = 0;
        while (base < 1e+05) {
            nc_length = rdunif(1, 100, 5000);
            initializeGenomicElement(g3, base, base + nc_length - 1);
            base = base + nc_length;
            ex_length = asInteger(rlnorm(1, log(50), log(2))) + 1;
            initializeGenomicElement(g1, base, base + ex_length - 1);
            base = base + ex_length;
            do
            {
                in_length = asInteger(rlnorm(1, log(100), log(1.5))) + 10;
                initializeGenomicElement(g2, base, base + in_length - 1);
                base = base + in_length;
                ex_length = asInteger(rlnorm(1, log(50), log(2))) + 1;
                initializeGenomicElement(g1, base, base + ex_length - 1);
                base = base + ex_length;
            }
            while (runif(1) < 0.8) slimr_special__;
        }
        nc_length = rdunif(1, 100, 5000);
        initializeGenomicElement(g3, base, base + nc_length - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeMutationType("m3", 0.1, "g", -0.03, 0.2);
        initializeMutationType("m4", 0.8, "e", 0.1);
        m1.color = "gray40";
        m2.color = "gray40";
        m3.color = "red";
        m4.color = "green";
        m1.colorSubstitution = "gray20";
        m2.colorSubstitution = "gray20";
        m3.colorSubstitution = "#550000";
        m4.colorSubstitution = "#005500";
        initializeGenomicElementType("g1", c(m2, m3, m4), c(2, 8, 0.1));
        initializeGenomicElementType("g2", c(m1, m3), c(9, 1));
        initializeGenomicElementType("g3", c(m1), 1);
        g1.color = "cornflowerblue";
        g2.color = "#00009F";
        g3.color = "black";
        base = 0;
        while (base < 1e+05) {
            nc_length = rdunif(1, 100, 5000);
            initializeGenomicElement(g3, base, base + nc_length - 1);
            base = base + nc_length;
            ex_length = asInteger(rlnorm(1, log(50), log(2))) + 1;
            initializeGenomicElement(g1, base, base + ex_length - 1);
            base = base + ex_length;
            do
            {
                in_length = asInteger(rlnorm(1, log(100), log(1.5))) + 10;
                initializeGenomicElement(g2, base, base + in_length - 1);
                base = base + in_length;
                ex_length = asInteger(rlnorm(1, log(50), log(2))) + 1;
                initializeGenomicElement(g1, base, base + ex_length - 1);
                base = base + ex_length;
            }
            while (runif(1) < 0.8) slimr_special__;
        }
        nc_length = rdunif(1, 100, 5000);
        initializeGenomicElement(g3, base, base + nc_length - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.chromosome.colorSubstitution = "";
        sim.addSubpop("p1", 5000);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1000:100000 late() {
        if (sim.countOfMutationsOfType(m2) == 0) {
            fixed = (sum(sim.substitutions.mutationType == m2) == 1);
            cat(ifelse(fixed, "FIXED\n", "LOST\n"));
            sim.simulationFinished();
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        defineConstant("simID", getSeed());
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        sim.outputFull("/tmp/slim_" + simID + ".txt");
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1000:100000 late() {
        if (sim.countOfMutationsOfType(m2) == 0) {
            fixed = (sum(sim.substitutions.mutationType == m2) == 1);
            if (fixed) {
                cat(simID + ": FIXED\n");
                sim.simulationFinished();
            } else {
                cat(simID + ": LOST - RESTARTING\n");
                sim.readFromPopulationFile("/tmp/slim_" + simID + ".txt");
                setSeed(rdunif(1, 0, asInteger(2^62) - 1));
                target = sample(p1.genomes, 1);
                target.addNewDrawnMutation(m2, 10000);
            }
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        defineConstant("simID", getSeed());
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        sim.outputFull("/tmp/slim_" + simID + ".txt");
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1000:10000 late() {
        mut = sim.mutationsOfType(m2);
        if (size(mut) == 1) {
            if (sim.mutationFrequencies(NULL, mut) > 0.1) {
                cat(simID + ": ESTABLISHED\n");
                sim.deregisterScriptBlock(self);
            }
        } else {
            cat(simID + ": LOST - RESTARTING\n");
            sim.readFromPopulationFile("/tmp/slim_" + simID + ".txt");
            setSeed(rdunif(1, 0, asInteger(2^62) - 1));
            target = sample(p1.genomes, 1);
            target.addNewDrawnMutation(m2, 10000);
        }
    }
    
    block_5:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1000:10000 late() {
        mut = sim.mutationsOfType(m2);
        if (size(mut) == 0) sim.simulationFinished() else if (mut.selectionCoeff != 0) if (sim.mutationFrequencies(NULL, mut) >= 0.5) mut.setSelectionCoeff(0);
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-05);
        initializeMutationType("m1", 0.45, "f", 0.5);
        m1.convertToSubstitution = F;
        m1.mutationStackPolicy = "f";
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 0);
        initializeRecombinationRate(0);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1e+05);
    }
    
    block_3:1:10000 early() {
        counts = p1.genomes.countOfMutationsOfType(m1);
        freq = mean(counts > 0);
        if (freq == 1) {
            cat("\nTotal mutations: " + size(sim.mutations) + "\n\n");
            for (mut in sortBy(sim.mutations, "originGeneration")) {
                mutFreq = mean(p1.genomes.containsMutations(mut));
                cat("Origin " + mut.originGeneration + ": " + mutFreq + "\n");
            }
            sim.simulationFinished();
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.45, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.tag = 0;
    }
    
    block_3:1000:1100 late() {
        if (sim.generation%%10 == 0) {
            target = sample(p1.genomes, 1);
            if (target.countOfMutationsOfType(m2) == 0) target.addNewDrawnMutation(m2, 10000);
        }
    }
    
    block_4:1:10000 late() {
        if (p1.tag != sim.countOfMutationsOfType(m2)) {
            if (any(sim.substitutions.mutationType == m2)) {
                cat("Hard sweep ended in generation " + sim.generation + "\n");
                sim.simulationFinished();
            } else {
                p1.tag = sim.countOfMutationsOfType(m2);
                cat("Gen. " + sim.generation + ": " + p1.tag + " lineage(s)\n");
                if ((p1.tag == 0) & (sim.generation > 1100)) {
                    cat("Sweep failed to establish.\n");
                    sim.simulationFinished();
                }
            }
        }
        if (all(p1.genomes.countOfMutationsOfType(m2) > 0)) {
            cat("Soft sweep ended in generation " + sim.generation + "\n");
            cat("Frequencies:\n");
            print(sim.mutationFrequencies(p1, sim.mutationsOfType(m2)));
            sim.simulationFinished();
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        gens = cumSum(rpois(10, 10));
        gens = gens + (1000 - min(gens));
        defineConstant("Z", max(gens));
        for (gen in gens) sim.registerLateEvent(NULL, s1.source, gen, gen);
        sim.deregisterScriptBlock(s1);
    }
    
    block_3:s1 1000 late() {
        target = sample(p1.genomes, 1);
        mut = sim.mutationsOfType(m2);
        if (mut.size() > 0) target.addMutations(mut) else target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1:10000 late() {
        if (any(sim.substitutions.mutationType == m2)) {
            catn("Sweep completed in generation " + sim.generation + ".");
            sim.simulationFinished();
        } else if ((sim.countOfMutationsOfType(m2) == 0) & (sim.generation > Z)) {
            catn("Soft sweep failed to establish.");
            sim.simulationFinished();
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 1, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        muts = sim.mutations;
        muts = muts[sim.mutationFrequencies(p1, muts) > 0.1];
        if (size(muts)) {
            mut = sample(muts, 1);
            mut.setSelectionCoeff(0.5);
        } else {
            cat("No contender of sufficient frequency found.\n");
        }
    }
    
    block_4:1000:10000 late() {
        if (sum(sim.mutations.selectionCoeff) == 0) {
            if (sum(sim.substitutions.selectionCoeff) == 0) cat("Sweep mutation lost in gen. " + sim.generation + "\n") else cat("Sweep mutation reached fixation.\n");
            sim.simulationFinished();
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        defineConstant("simID", getSeed());
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        sim.outputFull("/tmp/slim_" + simID + ".txt");
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1000:10000 late() {
        mut = sim.mutationsOfType(m2);
        if (size(mut) == 1) {
            if (sim.mutationFrequencies(NULL, mut) > 0.1) {
                cat(simID + ": ESTABLISHED - CONVERTING TO BENEFICIAL\n");
                mut.setSelectionCoeff(0.5);
                sim.deregisterScriptBlock(self);
            }
        } else {
            cat(simID + ": LOST BEFORE ESTABLISHMENT - RESTARTING\n");
            sim.readFromPopulationFile("/tmp/slim_" + simID + ".txt");
            setSeed(rdunif(1, 0, asInteger(2^62) - 1));
            target = sample(p1.genomes, 1);
            target.addNewDrawnMutation(m2, 10000);
        }
    }
    
    block_5:1000:10000 late() {
        if (sim.countOfMutationsOfType(m2) == 0) {
            fixed = (sum(sim.substitutions.mutationType == m2) == 1);
            cat(simID + ifelse(fixed, ": FIXED\n", ": LOST\n"));
            sim.simulationFinished();
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        subpopCount = 10;
        for (i in 1:subpopCount) sim.addSubpop(i, 500);
        for (i in 2:subpopCount) sim.subpopulations[i - 1] %.% setMigrationRates(i - 1, 0.01);
        for (i in 1:(subpopCount - 1)) sim.subpopulations[i - 1] %.% setMigrationRates(i + 1, 0.2);
    }
    
    block_3:100 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:100:100000 late() {
        if (sim.countOfMutationsOfType(m2) == 0) {
            fixed = (sum(sim.substitutions.mutationType == m2) == 1);
            cat(ifelse(fixed, "FIXED\n", "LOST\n"));
            sim.simulationFinished();
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0.05);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:6000 late() {
        s = 0.05;
        N = 1000;
        p_fix = (1 - exp(-2 * s))/(1 - exp(-4 * N * s));
        n_gens = 1000;
        mu = 1e-06;
        locus_size = 1e+05;
        expected = mu * locus_size * n_gens * 2 * N * p_fix;
        subs = sim.substitutions;
        actual = sum(subs.fixationGeneration >= 5000);
        cat("P(fix) = " + p_fix + "\n");
        cat("Expected fixations: " + expected + "\n");
        cat("Actual fixations: " + actual + "\n");
        cat("Ratio, actual/expected: " + (actual/expected) + "\n");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        mut = target.addNewDrawnMutation(m2, 10000);
        defineConstant("SWEEP", mut);
    }
    
    block_4:1000:100000 late() {
        if (!SWEEP.isSegregating) {
            cat(ifelse(SWEEP.isFixed, "FIXED\n", "LOST\n"));
            sim.simulationFinished();
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("L", 3e+06);
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.8, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        defineConstant("BACKGROUND", target.mutations);
        mut = target.addNewDrawnMutation(m2, asInteger(L/2));
        defineConstant("SWEEP", mut);
    }
    
    block_4:1000:1500 late() {
        if (!SWEEP.isSegregating & !SWEEP.isFixed) stop("LOST");
    }
    
    block_5:1500 late() {
        nonSeg = BACKGROUND[!BACKGROUND.isSegregating];
        fixed = nonSeg[nonSeg.isFixed];
        lost = nonSeg[!nonSeg.isFixed];
        writeFile("~/Desktop/fixed.txt", paste(fixed.position, sep = ", "));
        writeFile("~/Desktop/lost.txt", paste(lost.position, sep = ", "));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(0.995, 0.005));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:2000:3999 fitness(m2) {
        return(1);
    }
    
    block_4:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "e", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(0.99, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
        p1.setMigrationRates(p2, 0.1);
        p2.setMigrationRates(p1, 0.5);
    }
    
    block_3:fitness(m2, p2) {
        return(1/relFitness);
    }
    
    block_4:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeMutationType("m3", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElementType("g3", m3, 1);
        initializeGenomicElement(g1, 0, 10000);
        initializeGenomicElement(g2, 10001, 13000);
        initializeGenomicElement(g1, 13001, 70000);
        initializeGenomicElement(g3, 70001, 73000);
        initializeGenomicElement(g1, 73001, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:fitness(m3) {
        if (genome1.countOfMutationsOfType(m2)) return(0.5) else if (genome2.countOfMutationsOfType(m2)) return(0.5) else return(relFitness);
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeMutationType("m3", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElementType("g3", m3, 1);
        initializeGenomicElement(g1, 0, 10000);
        initializeGenomicElement(g2, 10001, 13000);
        initializeGenomicElement(g1, 13001, 70000);
        initializeGenomicElement(g3, 70001, 73000);
        initializeGenomicElement(g1, 73001, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:fitness(m3) {
        if (genome1.countOfMutationsOfType(m2)) return(0.5) else if (genome2.countOfMutationsOfType(m2)) return(0.5) else return(relFitness);
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(999, 1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:fitness(m2) {
        return(1.5 - sim.mutationFrequencies(p1, mut));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(999, 1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:fitness(m2) {
        return(1.5 - sim.mutationFrequencies(p1, mut));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(999, 1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:fitness(m2) {
        return(1.5 - sim.mutationFrequencies(p1, mut));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(0.99, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:10000 early() {
        sim.simulationFinished();
    }
    
    block_4:late() {
        p1.individuals.tag = rbinom(1000, 1, 0.5);
    }
    
    block_5:fitness(m2) {
        if (individual.tag == 0) return(1) else return(relFitness);
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.convertToSubstitution = F;
        m2.color = "red";
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1 late() {
        target = sample(p1.genomes, 100);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:1:10000 late() {
        p1.individuals.tag = 0;
        for (rep in 1:50) {
            individuals = sample(p1.individuals, 2);
            i0 = individuals[0];
            i1 = individuals[1];
            i0greenbeards = i0.countOfMutationsOfType(m2);
            i1greenbeards = i1.countOfMutationsOfType(m2);
            if (i0greenbeards & i1greenbeards) {
                alleleSum = i0greenbeards + i1greenbeards;
                i0.tag = i0.tag - alleleSum;
                i1.tag = i1.tag + alleleSum * 2;
            }
        }
    }
    
    block_5:fitness(m2) {
        return(1 + individual.tag/10);
    }
    
    block_6:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.1);
        initializeGenomicElementType("g1", c(m1, m2), c(999, 1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        for (index in seqAlong(m2muts)) m2muts[index] %.% setSelectionCoeff(0.5 - freqs[index]);
    }
    
    block_4:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.05);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:mutation(m2) {
        mut.setValue("dom", runif(1));
        return(T);
    }
    
    block_4:fitness(m2) {
        if (homozygous) return(1 + mut.selectionCoeff) else return(1 + mut.getValue("dom") * mut.selectionCoeff);
    }
    
    block_5:100000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.05);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:mutation(m2) {
        mut.setValue("dom", runif(1));
        return(T);
    }
    
    block_4:fitness(m2) {
        if (homozygous) return(1 + mut.selectionCoeff) else return(1 + mut.getValue("dom") * mut.selectionCoeff);
    }
    
    block_5:100000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[8]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.setValue("FST", 0);
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
        p1.setMigrationRates(p2, 0.1);
        p2.setMigrationRates(p1, 0.1);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_4:fitness(m2, p2) {
        return(0.2);
    }
    
    block_5:2000:19999 early() {
        inds = sim.subpopulations.individuals;
        inds.tag = inds.countOfMutationsOfType(m2);
        for (subpop in c(p1, p2)) {
            has_m2 = (subpop.individuals.tag > 0);
            subpop.setValue("weights1", ifelse(has_m2, 2, 1));
            subpop.setValue("weights2", ifelse(has_m2, 0.5, 1));
        }
    }
    
    block_6:2000:19999 mateChoice() {
        if (individual.tag > 0) return(weights * sourceSubpop.getValue("weights1")) else return(weights * sourceSubpop.getValue("weights2"));
    }
    
    block_7:10000:19999 late() {
        FST = calcFST(p1.genomes, p2.genomes);
        sim.setValue("FST", sim.getValue("FST") + FST);
    }
    
    block_8:19999 late() {
        cat("Mean FST at equilibrium: " + (sim.getValue("FST")/10000));
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.025);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1:10001 early() {
        if (sim.generation%%1000 == 1) {
            fixedMuts = sum(sim.substitutions.mutationType == m2);
            osize = fixedMuts * 2 + p1.individuals.countOfMutationsOfType(m2);
            catn(sim.generation + ": Mean ornament size == " + mean(osize));
        }
    }
    
    block_4:mateChoice() {
        fixedMuts = sum(sim.substitutions.mutationType == m2);
        for (attempt in 1:5) {
            mate = sample(p1.individuals, 1, T, weights);
            osize = fixedMuts * 2 + mate.countOfMutationsOfType(m2);
            if (runif(1) < log(osize + 1) * 0.1 + attempt * 0.1) return(mate);
        }
        return(float(0));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.025);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1:10001 early() {
        if (sim.generation%%1000 == 1) {
            fixedMuts = sum(sim.substitutions.mutationType == m2);
            osize = fixedMuts * 2 + p1.individuals.countOfMutationsOfType(m2);
            catn(sim.generation + ": Mean ornament size == " + mean(osize));
        }
    }
    
    block_4:mateChoice() {
        fixedMuts = sum(sim.substitutions.mutationType == m2);
        for (attempt in 1:5) {
            mate = sample(p1.individuals, 1, T, weights);
            osize = fixedMuts * 2 + mate.countOfMutationsOfType(m2);
            if (runif(1) < log(osize + 1) * 0.1 + attempt * 0.1) return(mate);
        }
        return(float(0));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElement(g1, 0, 20000);
        initializeGenomicElement(g2, 20001, 21000);
        initializeGenomicElement(g1, 21001, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:10000 late() {
        cat("m1 mutation count: " + sim.countOfMutationsOfType(m1) + "\n");
        cat("m2 mutation count: " + sim.countOfMutationsOfType(m2) + "\n");
    }
    
    block_4:modifyChild(p1) {
        pollenSMuts = childGenome2.mutationsOfType(m2);
        styleSMuts1 = parent1Genome1.mutationsOfType(m2);
        styleSMuts2 = parent1Genome2.mutationsOfType(m2);
        if (identical(pollenSMuts, styleSMuts1)) if (runif(1) < 0.99) return(F);
        if (identical(pollenSMuts, styleSMuts2)) if (runif(1) < 0.99) return(F);
        return(T);
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(0.99, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
        p1.individuals.tag = rbinom(1000, 1, 0.5);
    }
    
    block_3:modifyChild() {
        parentCulture = (parent1.tag + parent2.tag)/2;
        childCulture = rbinom(1, 1, 0.1 + 0.8 * parentCulture);
        child.tag = childCulture;
        return(T);
    }
    
    block_4:fitness(m2) {
        if (individual.tag == 0) return(1) else return(relFitness);
    }
    
    block_5:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.5);
        m2.convertToSubstitution = F;
        initializeMutationType("m3", 0.5, "f", 0.5);
        m3.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1 late() {
        sample(p1.genomes, 20) %.% addNewDrawnMutation(m2, 10000);
        sample(p1.genomes, 20) %.% addNewDrawnMutation(m3, 20000);
    }
    
    block_4:modifyChild() {
        childGenomes = c(childGenome1, childGenome2);
        hasMutA = any(childGenomes.countOfMutationsOfType(m2) > 0);
        hasMutB = any(childGenomes.countOfMutationsOfType(m3) > 0);
        if (hasMutA & hasMutB) return(F);
        return(T);
    }
    
    block_5:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.5);
        m2.convertToSubstitution = F;
        initializeMutationType("m3", 0.5, "f", 0.5);
        m3.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1 late() {
        sample(p1.genomes, 20) %.% addNewDrawnMutation(m2, 10000);
        sample(p1.genomes, 20) %.% addNewDrawnMutation(m3, 20000);
    }
    
    block_4:modifyChild() {
        childGenomes = c(childGenome1, childGenome2);
        hasMutA = any(childGenomes.countOfMutationsOfType(m2) > 0);
        hasMutB = any(childGenomes.countOfMutationsOfType(m3) > 0);
        if (hasMutA & hasMutB) return(F);
        return(T);
    }
    
    block_5:10000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        for (i in 0:5) sim.addSubpop(i, 500);
        for (i in 1:5) sim.subpopulations[i] %.% setMigrationRates(i - 1, 0.001);
        for (i in 0:4) sim.subpopulations[i] %.% setMigrationRates(i + 1, 0.1);
    }
    
    block_3:100 late() {
        p0.genomes[0:49] %.% addNewDrawnMutation(m2, 10000);
    }
    
    block_4:100:10000 late() {
        if (sim.countOfMutationsOfType(m2) == 0) {
            fixed = any(sim.substitutions.mutationType == m2);
            cat(ifelse(fixed, "FIXED\n", "LOST\n"));
            sim.simulationFinished();
        }
    }
    
    block_5:fitness(m2) {
        return(1.5 - subpop.id * 0.15);
    }
    
    block_6:100:10000 modifyChild() {
        mut = sim.mutationsOfType(m2);
        if (size(mut) == 1) {
            hasMutOnChromosome1 = childGenome1.containsMutations(mut);
            hasMutOnChromosome2 = childGenome2.containsMutations(mut);
            if (hasMutOnChromosome1 & !hasMutOnChromosome2) childGenome2.addMutations(mut) else if (hasMutOnChromosome2 & !hasMutOnChromosome1) childGenome1.addMutations(mut);
        }
        return(T);
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:modifyChild() {
        if (parent1 == parent2) return(F);
        return(T);
    }
    
    block_4:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.individuals.tag = repEach(0:1, 250);
    }
    
    block_3:modifyChild() {
        if (parent1.tag + parent2.tag != 1) return(F);
        child.tag = rdunif(1);
        return(T);
    }
    
    block_4:1:2000 late() {
        catn("Sex ratio (M:M+F): " + mean(p1.individuals.tag));
    }
    
    block_5:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.convertToSubstitution = F;
        m2.color = "red";
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElement(g1, 0, 20000);
        initializeGenomicElement(g2, 20001, 30000);
        initializeGenomicElement(g1, 30001, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:fitness(NULL) {
        phenotype = sum(c(genome1, genome2) %.% countOfMutationsOfType(m2));
        return(1.5 - (phenotype - 10)^2 * 0.005);
    }
    
    block_4:5000 late() {
        print(sim.mutationFrequencies(NULL, sim.mutationsOfType(m2)));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.5);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElement(g1, 0, 20000);
        initializeGenomicElement(g2, 20001, 30000);
        initializeGenomicElement(g1, 30001, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        inds.fitnessScaling = 1.5 - (phenotypes - 10)^2 * 0.005;
        if (sim.generation%%100 == 0) catn(sim.generation + ": Mean phenotype == " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        scriptForQTLs = "if (runif(1) < 0.5) -1 else 1;";
        initializeMutationType("m2", 0.5, "s", scriptForQTLs);
        initializeGenomicElementType("g2", m2, 1);
        m2.convertToSubstitution = F;
        m2.mutationStackPolicy = "l";
        defineConstant("C", 10);
        defineConstant("W", 1000);
        pos = 0;
        q = NULL;
        for (i in 1:C) {
            initializeGenomicElement(g1, pos, pos + W - 1);
            pos = pos + W;
            initializeGenomicElement(g2, pos, pos);
            q = c(q, pos);
            pos = pos + 1;
            initializeGenomicElement(g1, pos, pos + W - 1);
            pos = pos + W;
        }
        defineConstant("Q", q);
        rates = c(rep(c(1e-08, 0.5), C - 1), 1e-08);
        ends = (repEach(Q + W, 2) + rep(c(0, 1), C))[0:(C * 2 - 2)];
        initializeRecombinationRate(rates, ends);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
        p1.setMigrationRates(p2, 0.01);
        p2.setMigrationRates(p1, 0.01);
        sim.registerEarlyEvent("s2", s1.source, 2, 2);
        g = sim.subpopulations.genomes;
        for (q in Q) {
            isPlus = asLogical(rbinom(size(g), 1, 0.5));
            g[isPlus] %.% addNewMutation(m2, 1, q);
            g[!isPlus] %.% addNewMutation(m2, -1, q);
        }
    }
    
    block_3:fitness(m2) {
        return(1);
    }
    
    block_4:1:2001 late() {
        for (subpop in c(p1, p2)) {
            inds = subpop.individuals;
            phenotype = inds.sumOfMutationsOfType(m2);
            optimum = (subpop == p1 %?% 10 %else% -10);
            inds.fitnessScaling = 1 + dnorm(optimum - phenotype, 0, 5);
            inds.tagF = phenotype;
        }
    }
    
    block_5:mateChoice() {
        phenotype = individual.tagF;
        others = sourceSubpop.individuals.tagF;
        return(weights * dnorm(others, phenotype, 5));
    }
    
    block_6:s1 2001 early() {
        cat("-------------------------------\n");
        cat("Output for end of generation " + (sim.generation - 1) + ":\n\n");
        cat("p1 mean fitness = " + mean(p1.cachedFitness(NULL)) + "\n");
        cat("p2 mean fitness = " + mean(p2.cachedFitness(NULL)) + "\n");
        cat("p1 mean phenotype = " + mean(p1.individuals.tagF) + "\n");
        cat("p2 mean phenotype = " + mean(p2.individuals.tagF) + "\n");
        muts = sim.mutationsOfType(m2);
        plus = muts[muts.selectionCoeff == 1];
        minus = muts[muts.selectionCoeff == -1];
        cat("\nOverall frequencies:\n\n");
        for (q in Q) {
            qPlus = plus[plus.position == q];
            qMinus = minus[minus.position == q];
            pf = sum(sim.mutationFrequencies(NULL, qPlus));
            mf = sum(sim.mutationFrequencies(NULL, qMinus));
            pf1 = sum(sim.mutationFrequencies(p1, qPlus));
            mf1 = sum(sim.mutationFrequencies(p1, qMinus));
            pf2 = sum(sim.mutationFrequencies(p2, qPlus));
            mf2 = sum(sim.mutationFrequencies(p2, qMinus));
            cat("   QTL " + q + ": f(+) == " + pf + ", f(-) == " + mf + "\n");
            cat("         in p1: f(+) == " + pf1 + ", f(-) == " + mf1 + "\n");
            cat("         in p2: f(+) == " + pf2 + ", f(-) == " + mf2 + "\n\n");
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("h2", 0.1);
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:1:1e+05 late() {
        inds = sim.subpopulations.individuals;
        additive = inds.sumOfMutationsOfType(m2);
        V_A = sd(additive)^2;
        V_E = (V_A - h2 * V_A)/h2;
        env = rnorm(size(inds), 0, sqrt(V_E));
        phenotypes = additive + env;
        inds.fitnessScaling = 1 + dnorm(10 - phenotypes, 0, 5);
        inds.tagF = phenotypes;
    }
    
    block_4:fitness(m2) {
        return(1);
    }
    
    block_5:1:100000 late() {
        if (sim.generation == 1) cat("Mean phenotype:\n");
        meanPhenotype = mean(p1.individuals.tagF);
        cat(format("%.2f", meanPhenotype));
        if (abs(meanPhenotype - 10) > 0.1) {
            cat(", ");
            return;
        }
        cat("\n\n-------------------------------\n");
        cat("QTLs at generation " + sim.generation + ":\n\n");
        qtls = sim.mutationsOfType(m2);
        f = sim.mutationFrequencies(NULL, qtls);
        s = qtls.selectionCoeff;
        p = qtls.position;
        o = qtls.originGeneration;
        indices = order(f, F);
        for (i in indices) cat("   " + p[i] + ": s = " + s[i] + ", f == " + f[i] + ", o == " + o[i] + "\n");
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.15);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        cat("Phenotypes: 0");
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        scale = dnorm(5, 5, 2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, 5, 2)/scale;
        if (sim.generation%%10 == 0) cat(", " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.15);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        cat("Phenotypes: 0");
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        scale = dnorm(5, 5, 2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, 5, 2)/scale;
        if (sim.generation%%10 == 0) cat(", " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.15);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        cat("Phenotypes: 0");
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        scale = dnorm(5, 5, 2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, 5, 2)/scale;
        if (sim.generation%%10 == 0) cat(", " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.15);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        cat("Phenotypes: 0");
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        scale = dnorm(5, 5, 2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, 5, 2)/scale;
        if (sim.generation%%10 == 0) cat(", " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 0.15);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        cat("Phenotypes: 0");
    }
    
    block_4:1:5000 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        scale = dnorm(5, 5, 2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, 5, 2)/scale;
        if (sim.generation%%10 == 0) cat(", " + mean(phenotypes));
    }
    
    block_5:5000 late() {
        m2muts = sim.mutationsOfType(m2);
        freqs = sim.mutationFrequencies(NULL, m2muts);
        effects = m2muts.selectionCoeff;
        catn();
        print(cbind(freqs, effects));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeSLiMOptions(keepPedigrees = T);
        initializeMutationRate(1e-05);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:mateChoice() {
        return(weights * (individual.relatedness(sourceSubpop.individuals) + 0.01));
    }
    
    block_4:1000 late() {
        heterozygosity = calcHeterozygosity(p1.genomes);
        cat("Mean heterozygosity = " + heterozygosity + "\n");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.005);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:fitness(m2) {
        if (runif(1) < relFitness) return(1) else return(0);
    }
    
    block_4:10000 late() {
        sim.outputMutations(sim.mutationsOfType(m2));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.005);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:fitness(m2) {
        if (runif(1) < relFitness) return(1) else return(0);
    }
    
    block_4:10000 late() {
        sim.outputMutations(sim.mutationsOfType(m2));
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", -0.005);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:fitness(m2) {
        if (runif(1) < relFitness) return(1) else return(0);
    }
    
    block_4:10000 late() {
        sim.outputMutations(sim.mutationsOfType(m2));
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:20000 late() {
        p1.outputMSSample(2000, replace = F, filePath = "~/Desktop/ms.txt");
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:20000 late() {
        p1.outputMSSample(2000, replace = F, filePath = "~/Desktop/ms.txt");
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.color = "red";
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-06);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1 late() {
        inverted = sample(p1.individuals, integerDiv(p1.individualCount, 2));
        inverted.genomes.addNewDrawnMutation(m2, 25000);
    }
    
    block_4:1:9999 late() {
        if (sim.generation%%50 != 0) return;
        pScr = "sum(applyValue.genomes.containsMarkerMutation(m2, 25000));";
        p = sapply(p1.individuals, pScr);
        p__ = sum(p == 0);
        pI_ = sum(p == 1);
        pII = sum(p == 2);
        cat("Generation " + format("%%4d", sim.generation) + ": ");
        cat(format("%%3d", p__) + " --   ");
        cat(format("%%3d", pI_) + " I-   ");
        cat(format("%%3d", pII) + " II\n");
        if (p__ == 0) stop("Inversion fixed!");
        if (pII == 0) stop("Inversion lost!");
    }
    
    block_5:fitness(m2) {
        f = sim.mutationFrequencies(NULL, mut);
        return(1 - (f - 0.5) * 0.2);
    }
    
    block_6:recombination() {
        if (genome1.containsMarkerMutation(m2, 25000) == genome2.containsMarkerMutation(m2, 25000)) return(F);
        inInv = (breakpoints > 25000) & (breakpoints < 75000);
        if (!any(inInv)) return(F);
        breakpoints = breakpoints[!inInv];
        return(T);
    }
    
    block_7:9999 late() {
        sim.outputFixedMutations();
        pos = sim.substitutions.position;
        cat(sum((pos >= 25000) & (pos < 75000)) + " inside inversion.\n");
        cat(sum((pos < 25000) | (pos >= 75000)) + " outside inversion.\n");
    }

---

    <slimr_script[5]>
    block_init:initialize() {
        initializeMutationRate(1.5e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0);
        initializeMutationType("m3", 1, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElementType("g2", m2, 1);
        initializeGenomicElement(g1, 0, 2699999);
        initializeGenomicElement(g2, 2700000, 5999999);
        initializeSex("A");
        initializeRecombinationRate(c(1e-08, 0), c(2699999, 5999999), sex = "M");
        initializeRecombinationRate(1e-08, sex = "F");
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 1000);
        i = p1.individuals;
        i[i.sex == "M"] %.% genome2.addNewMutation(m3, 0, 5999999);
    }
    
    block_3:modifyChild() {
        if (child.sex == "F") return(!childGenome2.containsMarkerMutation(m3, 5999999)) else return(childGenome2.containsMarkerMutation(m3, 5999999));
    }
    
    block_4:1:10000 late() {
        if (sim.generation%%1000 == 0) {
            numY = sum(p1.individuals.sex == "M");
            numX = 2 * size(p1.individuals) - numY;
            firstMale = p1.individuals[p1.individuals.sex == "M"][0];
            fMG = firstMale.genomes;
            if (fMG[0] %.% containsMarkerMutation(m3, 5999999)) {
                firstY = fMG[0];
                firstX = fMG[1];
            } else if (fMG[1] %.% containsMarkerMutation(m3, 5999999)) {
                firstY = fMG[1];
                firstX = fMG[0];
            } else stop("### ERROR: no Ys in first male");
            ymuts = firstY.mutationsOfType(m2);
            ycounts = sim.mutationCounts(NULL, ymuts);
            removeY = ymuts[ycounts == numY];
            xmuts = firstX.mutationsOfType(m2);
            xcounts = sim.mutationCounts(NULL, xmuts);
            removeX = xmuts[xcounts == numX];
            cat("Gen. " + sim.generation + ": Removing ");
            cat(removeX.size() + "/" + removeY.size() + " on X/Y\n");
            removes = c(removeY, removeX);
            sim.subpopulations.genomes.removeMutations(removes, T);
        }
    }
    
    block_5:10000 late() {
        p1.outputMSSample(10, replace = F, requestedSex = "F");
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(mu);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 999999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 100);
    }
    
    block_3:1000 late() {
        cat(sim.mutations.size() + "\n");
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        defineConstant("L", 10000);
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0.1);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
    }
    
    block_3:1 late() {
        p1.genomes.addNewDrawnMutation(m1, asInteger(L * 0.2));
        p2.genomes.addNewDrawnMutation(m1, asInteger(L * 0.8));
        p1.genomes.addNewMutation(m2, 0, 0:(L - 1));
        sim.addSubpop("p3", 1000);
        p3.setMigrationRates(c(p1, p2), c(0.5, 0.5));
    }
    
    block_4:2 late() {
        p3.setMigrationRates(c(p1, p2), c(0, 0));
        p1.setSubpopulationSize(0);
        p2.setSubpopulationSize(0);
    }
    
    block_5:2:1e+05 late() {
        if (sim.mutationsOfType(m1) %.% size() == 0) {
            p3g = p3.genomes;
            p1Total = sum(p3g.countOfMutationsOfType(m2));
            maxTotal = p3g.size() * L;
            p1TotalFraction = p1Total/maxTotal;
            catn("Fraction with p1 ancestry: " + p1TotalFraction);
            p1Counts = integer(L);
            for (g in p3g) p1Counts = p1Counts + integer(L, 0, 1, g.positionsOfMutationsOfType(m2));
            maxCount = p3g.size();
            p1Fractions = p1Counts/maxCount;
            catn("Fraction with p1 ancestry, by position:");
            catn(format("%.3f", p1Fractions));
            sim.simulationFinished();
        }
    }
    
    block_6:100000 late() {
        stop("Did not reach fixation of beneficial alleles.");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        if (fileExists("/usr/bin/Rscript")) defineConstant("RSCRIPT", "/usr/bin/Rscript") else if (fileExists("/usr/local/bin/Rscript")) defineConstant("RSCRIPT", "/usr/local/bin/Rscript") else stop("Couldn't find Rscript.");
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 5000);
        sim.setValue("fixed", NULL);
        defineConstant("pngPath", writeTempFile("plot_", ".png", ""));
        if (exists("slimgui")) slimgui.openDocument(pngPath);
    }
    
    block_3:1:50000 early() {
        if (sim.generation%%10 == 0) {
            count = sim.substitutions.size();
            sim.setValue("fixed", c(sim.getValue("fixed"), count));
        }
        if (sim.generation%%1000 != 0) return;
        y = sim.getValue("fixed");
        rstr = paste("{", "x <- (1:" + size(y) + ") * 10", "y <- c(" + paste(y, sep = ", ") + ")", "png(width=4, height=4, units=\"in\", res=72, file=\"" + pngPath + "\")", "par(mar=c(4.0, 4.0, 1.5, 1.5))", "plot(x=x, y=y, xlim=c(0, 50000), ylim=c(0, 500), type=\"l\",", "xlab=\"Generation\", ylab=\"Fixed mutations\", cex.axis=0.95,", "cex.lab=1.2, mgp=c(2.5, 0.7, 0), col=\"red\", lwd=2,", "xaxp=c(0, 50000, 2))", "box()", "dev.off()", "}", sep = "\n");
        scriptPath = writeTempFile("plot_", ".R", rstr);
        system(RSCRIPT, args = scriptPath);
        deleteFile(scriptPath);
    }
    
    block_4:50000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 1, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(0);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
        p1.setCloningRate(1);
    }
    
    block_3:late() {
        sim.subpopulations.individuals.genome2.removeMutations();
        muts = sim.mutationsOfType(m1);
        freqs = sim.mutationFrequencies(NULL, muts);
        if (any(freqs == 0.5)) sim.subpopulations.genomes.removeMutations(muts[freqs == 0.5], T);
    }
    
    block_4:200000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationType("m1", 0.5, "f", -0.01);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        ends = c(20000, 30000, 70000, 90000, 99999);
        densities = c(1e-09, 2e-08, 1e-09, 5e-08, 1e-09);
        initializeMutationRate(densities, ends);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:200000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        defineConstant("L", 1e+06);
        defineConstant("msatCount", 10);
        defineConstant("msatMu", 1e-04);
        defineConstant("msatUnique", T);
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.convertToSubstitution = F;
        m2.color = "#900090";
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        genomes = sim.subpopulations.genomes;
        positions = rdunif(msatCount, 0, L - 1);
        repeats = rpois(msatCount, 20) + 5;
        for (msatIndex in 0:(msatCount - 1)) {
            pos = positions[msatIndex];
            mut = genomes.addNewDrawnMutation(m2, pos);
            mut.tag = repeats[msatIndex];
        }
        defineConstant("msatPositions", positions);
    }
    
    block_3:modifyChild() {
        for (genome in child.genomes) {
            mutCount = rpois(1, msatMu * msatCount);
            if (mutCount) {
                mutSites = sample(msatPositions, mutCount);
                msats = genome.mutationsOfType(m2);
                for (mutSite in mutSites) {
                    msat = msats[msats.position == mutSite];
                    repeats = msat.tag;
                    repeats = repeats + (rdunif(1, 0, 1) * 2 - 1);
                    if (repeats < 5) next;
                    if (msatUnique) {
                        all_msats = sim.mutationsOfType(m2);
                        msatsAtSite = all_msats[all_msats.position == mutSite];
                        matchingMut = msatsAtSite[msatsAtSite.tag == repeats];
                        if (matchingMut.size() == 1) {
                          genome.removeMutations(msat);
                          genome.addMutations(matchingMut);
                          next;
                        }
                    }
                    genome.removeMutations(msat);
                    msat = genome.addNewDrawnMutation(m2, mutSite);
                    msat.tag = repeats;
                }
            }
        }
        return(T);
    }
    
    block_4:10000 late() {
        all_msats = sim.mutationsOfType(m2);
        for (pos in sort(msatPositions)) {
            catn("Microsatellite at " + pos + ":");
            msatsAtPos = all_msats[all_msats.position == pos];
            for (msat in sortBy(msatsAtPos, "tag")) catn("   variant with " + msat.tag + " repeats: " + sim.mutationFrequencies(NULL, msat));
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("L", 1e+06);
        defineConstant("teInitialCount", 100);
        defineConstant("teJumpP", 1e-04);
        defineConstant("teDisableP", 5e-05);
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
        initializeMutationType("m2", 0.5, "f", 0);
        m2.convertToSubstitution = F;
        m2.color = "#FF0000";
        initializeMutationType("m3", 0.5, "f", 0);
        m3.convertToSubstitution = F;
        m3.color = "#700000";
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        sim.tag = 0;
        genomes = sim.subpopulations.genomes;
        positions = rdunif(teInitialCount, 0, L - 1);
        for (teIndex in 0:(teInitialCount - 1)) {
            pos = positions[teIndex];
            mut = genomes.addNewDrawnMutation(m2, pos);
            mut.tag = sim.tag;
            sim.tag = sim.tag + 1;
        }
    }
    
    block_3:modifyChild() {
        for (genome in child.genomes) {
            tes = genome.mutationsOfType(m2);
            teCount = tes.size();
            mutatedCount = teCount %?% rpois(1, teCount * teDisableP) %else% 0;
            if (mutatedCount) {
                mutatedTEs = sample(tes, mutatedCount);
                for (te in mutatedTEs) {
                    all_disabledTEs = sim.mutationsOfType(m3);
                    disabledTE = all_disabledTEs[all_disabledTEs.tag == te.tag];
                    if (size(disabledTE)) {
                        genome.removeMutations(te);
                        genome.addMutations(disabledTE);
                        next;
                    }
                    genome.removeMutations(te);
                    disabledTE = genome.addNewDrawnMutation(m3, te.position);
                    disabledTE.tag = te.tag;
                }
            }
        }
        return(T);
    }
    
    block_4:late() {
        for (individual in sim.subpopulations.individuals) {
            for (genome in individual.genomes) {
                tes = genome.mutationsOfType(m2);
                teCount = tes.size();
                jumpCount = teCount %?% rpois(1, teCount * teJumpP) %else% 0;
                if (jumpCount) {
                    jumpTEs = sample(tes, jumpCount);
                    for (te in jumpTEs) {
                        pos = rdunif(1, 0, L - 1);
                        jumpTE = genome.addNewDrawnMutation(m2, pos);
                        jumpTE.tag = sim.tag;
                        sim.tag = sim.tag + 1;
                    }
                }
            }
        }
    }
    
    block_5:5000 late() {
        all_tes = sortBy(sim.mutationsOfType(m2), "position");
        all_disabledTEs = sortBy(sim.mutationsOfType(m3), "position");
        genomeCount = size(sim.subpopulations.genomes);
        catn("Active TEs:");
        for (te in all_tes) {
            cat("   TE at " + te.position + ": ");
            active = sim.mutationCounts(NULL, te);
            disabledTE = all_disabledTEs[all_disabledTEs.tag == te.tag];
            if (size(disabledTE) == 0) {
                disabled = 0;
            } else {
                disabled = sim.mutationCounts(NULL, disabledTE);
                all_disabledTEs = all_disabledTEs[all_disabledTEs != disabledTE];
            }
            total = active + disabled;
            cat("frequency " + format("%%0.3f", total/genomeCount) + ", ");
            catn(round(active/total * 100) + "%% active");
        }
        catn("\nCompletely disabled TEs: ");
        for (te in all_disabledTEs) {
            freq = sim.mutationFrequencies(NULL, te);
            cat("   TE at " + te.position + ": ");
            catn("frequency " + format("%%0.3f", freq));
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeGenomicElement(g1, 9900000, 9999999);
        initializeRecombinationRate(1.5e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:200000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeGenomicElement(g1, 9900000, 9999999);
        initializeRecombinationRate(1.5e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:200000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeMutationRate(1e-08);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.color = "yellow";
        m1.colorSubstitution = "yellow";
        initializeMutationType("m2", 0.5, "f", 0.1);
        m2.color = "red";
        m2.colorSubstitution = "red";
        initializeMutationType("m3", 0.5, "f", 0);
        m3.color = "blue";
        m3.colorSubstitution = "blue";
        initializeMutationType("m4", 0.5, "f", 0.1);
        m4.color = "green";
        m4.colorSubstitution = "green";
        initializeGenomicElementType("g1", c(m1, m2), c(1, 1e-04));
        initializeGenomicElement(g1, 0, 9999999);
        initializeRecombinationRate(1e-07);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
        sim.addSubpop("p2", 1000);
    }
    
    block_3:mutation(m1, p2) {
        mut.setMutationType(m3);
        return(T);
    }
    
    block_4:mutation(m2, p2) {
        mut.setMutationType(m4);
        return(T);
    }
    
    block_5:10000 early() {
        sim.chromosome.setMutationRate(0);
        p1.setMigrationRates(p2, 0.01);
        p2.setMigrationRates(p1, 0.01);
    }
    
    block_6:15000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.x = runif(p1.individualCount);
        p1.individuals.y = runif(p1.individualCount);
    }
    
    block_3:modifyChild() {
        do
        {
            child.x = parent1.x + rnorm(1, 0, 0.02);
        }
        while ((child.x < 0) | (child.x > 1)) slimr_special__;
        do
        {
            child.y = parent1.y + rnorm(1, 0, 0.02);
        }
        while ((child.y < 0) | (child.y > 1)) slimr_special__;
        return(T);
    }
    
    block_4:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.x = runif(p1.individualCount);
        p1.individuals.y = runif(p1.individualCount);
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
    }
    
    block_4:fitness(NULL) {
        totalStrength = i1.totalOfNeighborStrengths(individual);
        return(1.1 - totalStrength/p1.individualCount);
    }
    
    block_5:modifyChild() {
        do
        {
            child.x = parent1.x + rnorm(1, 0, 0.02);
        }
        while ((child.x < 0) | (child.x > 1)) slimr_special__;
        do
        {
            child.y = parent1.y + rnorm(1, 0, 0.02);
        }
        while ((child.y < 0) | (child.y > 1)) slimr_special__;
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
    }
    
    block_4:fitness(NULL) {
        totalStrength = i1.totalOfNeighborStrengths(individual);
        return(1.1 - totalStrength/p1.individualCount);
    }
    
    block_5:modifyChild() {
        pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        child.setSpatialPosition(p1.pointStopped(pos));
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
    }
    
    block_4:fitness(NULL) {
        totalStrength = i1.totalOfNeighborStrengths(individual);
        return(1.1 - totalStrength/p1.individualCount);
    }
    
    block_5:modifyChild() {
        pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        child.setSpatialPosition(p1.pointStopped(pos));
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
    }
    
    block_4:fitness(NULL) {
        totalStrength = i1.totalOfNeighborStrengths(individual);
        return(1.1 - totalStrength/p1.individualCount);
    }
    
    block_5:modifyChild() {
        pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        child.setSpatialPosition(p1.pointStopped(pos));
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
    }
    
    block_4:fitness(NULL) {
        totalStrength = i1.totalOfNeighborStrengths(individual);
        return(1.1 - totalStrength/p1.individualCount);
    }
    
    block_5:modifyChild() {
        pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        child.setSpatialPosition(p1.pointStopped(pos));
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
        initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.1);
        i2.setInteractionFunction("n", 1, 0.02);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
        inds = sim.subpopulations.individuals;
        competition = i1.totalOfNeighborStrengths(inds);
        inds.fitnessScaling = 1.1 - competition/size(inds);
        i2.evaluate();
    }
    
    block_4:1:2000 mateChoice() {
        return(i2.strength(individual));
    }
    
    block_5:modifyChild() {
        do
        {
            pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        }
        while (!p1.pointInBounds(pos)) slimr_special__;
        child.setSpatialPosition(pos);
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = 0.3);
        i1.setInteractionFunction("n", 3, 0.1);
        initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        p1.individuals.setSpatialPosition(p1.pointUniform(500));
    }
    
    block_3:1:2000 late() {
        i1.evaluate();
        inds = sim.subpopulations.individuals;
        competition = i1.totalOfNeighborStrengths(inds);
        inds.fitnessScaling = 1.1 - competition/size(inds);
        i2.evaluate();
    }
    
    block_4:1:2000 mateChoice() {
        neighbors = i2.nearestNeighbors(individual, 3);
        return((size(neighbors) %?% sample(neighbors, 1) %else% float(0)));
    }
    
    block_5:modifyChild() {
        do
        {
            pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        }
        while (!p1.pointInBounds(pos)) slimr_special__;
        child.setSpatialPosition(pos);
        return(T);
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        defineConstant("optimum", 5);
        defineConstant("sigma_K", 1);
        defineConstant("sigma_C", 0.4);
        defineConstant("NORM", dnorm(0, mean = 0, sd = sigma_C));
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "", reciprocal = T);
        i1.setInteractionFunction("f", 1);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 late() {
        sim.addSubpop("p1", 500);
    }
    
    block_4:1:2001 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, optimum, sigma_K);
        inds.tagF = phenotypes;
        i1.evaluate();
        competition = sapply(inds, "sum(i1.strength(applyValue));");
        effects = 1 - competition/size(inds);
        inds.fitnessScaling = inds.fitnessScaling * effects;
    }
    
    block_5:interaction(i1) {
        return(dnorm(exerter.tagF, receiver.tagF, sigma_C)/NORM);
    }
    
    block_6:1:2001 late() {
        if (sim.generation == 1) cat("  gen    mean      sd\n");
        if (sim.generation%%100 == 1) {
            phenotypes = p1.individuals.tagF;
            cat(format("%%5d  ", sim.generation));
            cat(format("%%6.2f  ", mean(phenotypes)));
            cat(format("%%6.2f\n", sd(phenotypes)));
        }
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("optimum", 5);
        defineConstant("sigma_K", 1);
        defineConstant("sigma_C", 0.4);
        defineConstant("NORM", dnorm(0, mean = 0, sd = sigma_C));
        initializeSLiMOptions(dimensionality = "x");
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "x", reciprocal = T, maxDistance = sigma_C * 3);
        i1.setInteractionFunction("n", 1, sigma_C);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 late() {
        sim.addSubpop("p1", 500);
        p1.setSpatialBounds(c(0, 10));
    }
    
    block_4:1:2001 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, optimum, sigma_K);
        inds.x = phenotypes;
        i1.evaluate();
        competition = sapply(inds, "sum(i1.strength(applyValue));");
        effects = 1 - competition/size(inds);
        inds.fitnessScaling = inds.fitnessScaling * effects;
    }
    
    block_5:1:2001 late() {
        if (sim.generation == 1) cat("  gen    mean      sd\n");
        if (sim.generation%%100 == 1) {
            phenotypes = p1.individuals.x;
            cat(format("%%5d  ", sim.generation));
            cat(format("%%6.2f  ", mean(phenotypes)));
            cat(format("%%6.2f\n", sd(phenotypes)));
        }
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        defineConstant("optimum", 5);
        defineConstant("sigma_K", 1);
        defineConstant("sigma_C", 0.4);
        defineConstant("sigma_M", 0.5);
        defineConstant("NORM", dnorm(0, mean = 0, sd = sigma_C));
        initializeSLiMOptions(dimensionality = "x");
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.01));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "x", reciprocal = T, maxDistance = sigma_C * 3);
        i1.setInteractionFunction("n", 1, sigma_C);
        initializeInteractionType(2, "x", reciprocal = T, maxDistance = sigma_M * 3);
        i2.setInteractionFunction("n", 1, sigma_M);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 late() {
        sim.addSubpop("p1", 500);
        p1.setSpatialBounds(c(0, 10));
    }
    
    block_4:1:2001 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        inds.fitnessScaling = 1 + dnorm(phenotypes, optimum, sigma_K);
        inds.x = phenotypes;
        i1.evaluate();
        competition = sapply(inds, "sum(i1.strength(applyValue));");
        effects = 1 - competition/size(inds);
        inds.fitnessScaling = inds.fitnessScaling * effects;
        i2.evaluate();
    }
    
    block_5:mateChoice() {
        return(i2.strength(individual));
    }
    
    block_6:1:2001 late() {
        if (sim.generation == 1) cat("  gen    mean      sd\n");
        if (sim.generation%%100 == 1) {
            phenotypes = p1.individuals.x;
            cat(format("%%5d  ", sim.generation));
            cat(format("%%6.2f  ", mean(phenotypes)));
            cat(format("%%6.2f\n", sd(phenotypes)));
        }
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        defineConstant("sigma_C", 0.1);
        defineConstant("sigma_K", 0.5);
        defineConstant("sigma_M", 0.1);
        defineConstant("slope", 1);
        defineConstant("N", 500);
        initializeSLiMOptions(dimensionality = "xyz");
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xyz", reciprocal = T, maxDistance = sigma_C * 3);
        i1.setInteractionFunction("n", 1, sigma_C);
        initializeInteractionType(2, "xyz", reciprocal = T, maxDistance = sigma_M * 3);
        i2.setInteractionFunction("n", 1, sigma_M);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 late() {
        sim.addSubpop("p1", N);
        p1.setSpatialBounds(c(0, 0, -slope, 1, 1, slope));
        p1.individuals.setSpatialPosition(p1.pointUniform(N));
        p1.individuals.z = 0;
    }
    
    block_4:modifyChild() {
        do
        {
            pos = c(parent1.spatialPosition[0:1] + rnorm(2, 0, 0.005), 0);
        }
        while (!p1.pointInBounds(pos)) slimr_special__;
        child.setSpatialPosition(pos);
        return(T);
    }
    
    block_5:1:5001 late() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m2);
        optima = (inds.x - 0.5) * slope;
        inds.fitnessScaling = 1 + dnorm(phenotypes, optima, sigma_K);
        inds.z = phenotypes;
        for (ind in inds) {
            hue = ((ind.z + slope)/(slope * 2)) * 0.66;
            ind.color = rgb2color(hsv2rgb(c(hue, 1, 1)));
        }
        i1.evaluate();
        competition = sapply(inds, "sum(i1.strength(applyValue));");
        effects = 1 - competition/size(inds);
        inds.fitnessScaling = inds.fitnessScaling * effects;
        i2.evaluate();
    }
    
    block_6:mateChoice() {
        return(i2.strength(individual));
    }
    
    block_7:1:5001 late() {
        if (sim.generation == 1) cat("  gen    mean      sd\n");
        if (sim.generation%%100 == 1) {
            phenotypes = p1.individuals.z;
            cat(format("%%5d  ", sim.generation));
            cat(format("%%6.2f  ", mean(phenotypes)));
            cat(format("%%6.2f\n", sd(phenotypes)));
        }
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        defineConstant("sigma_C", 0.1);
        defineConstant("sigma_K", 0.5);
        defineConstant("sigma_M", 0.1);
        defineConstant("N", 500);
        initializeSLiMOptions(dimensionality = "xyz");
        initializeMutationRate(1e-06);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "n", 0, 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 1e+05 - 1);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xyz", reciprocal = T, maxDistance = sigma_C * 3);
        i1.setInteractionFunction("n", 1, sigma_C);
        initializeInteractionType(2, "xyz", reciprocal = T, maxDistance = sigma_M * 3);
        i2.setInteractionFunction("n", 1, sigma_M);
    }
    
    block_2:fitness(m2) {
        return(1);
    }
    
    block_3:1 late() {
        sim.addSubpop("p1", N);
        p1.setSpatialBounds(c(0, 0, 0, 1, 1, 1));
        p1.individuals.setSpatialPosition(p1.pointUniform(N));
        p1.individuals.z = 0;
        defineConstant("mapValues", matrix(runif(25, 0, 1), ncol = 5));
        p1.defineSpatialMap("map1", "xy", mapValues, interpolate = T, valueRange = c(0, 1), colors = c("red", "yellow"));
    }
    
    block_4:modifyChild() {
        do
        {
            pos = c(parent1.spatialPosition[0:1] + rnorm(2, 0, 0.005), 0);
        }
        while (!p1.pointInBounds(pos)) slimr_special__;
        child.setSpatialPosition(pos);
        return(T);
    }
    
    block_5:1:10000 late() {
        inds = sim.subpopulations.individuals;
        phenotype = inds.sumOfMutationsOfType(m2);
        location = inds.spatialPosition[rep(c(T, T, F), inds.size())];
        optimum = p1.spatialMapValue("map1", location);
        inds.fitnessScaling = 1 + dnorm(phenotype, optimum, sigma_K);
        inds.z = phenotype;
        inds.color = p1.spatialMapColor("map1", phenotype);
        i1.evaluate();
        competition = sapply(inds, "sum(i1.strength(applyValue));");
        effects = 1 - competition/size(inds);
        inds.fitnessScaling = inds.fitnessScaling * effects;
        i2.evaluate();
    }
    
    block_6:mateChoice() {
        return(i2.strength(individual));
    }
    
    block_7:10000 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeSLiMOptions(dimensionality = "xy", periodicity = "xy");
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
        initializeInteractionType("i1", "xy", reciprocal = T, maxDistance = 0.2);
        i1.setInteractionFunction("n", 1, 0.1);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 2000);
        p1.individuals.setSpatialPosition(p1.pointUniform(2000));
    }
    
    block_3:late() {
        i1.evaluate();
        focus = sample(p1.individuals, 1);
        s = i1.strength(focus);
        inds = p1.individuals;
        for (i in seqAlong(s)) inds[i] %.% color = rgb2color(c(1 - s[i], 1 - s[i], s[i]));
        focus.color = "red";
    }
    
    block_4:modifyChild() {
        pos = parent1.spatialPosition + rnorm(2, 0, 0.02);
        child.setSpatialPosition(p1.pointPeriodic(pos));
        return(T);
    }
    
    block_5:1000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_5:late() {
        inds = p1.individuals;
        catn(sim.generation + ": " + size(inds) + " (" + max(inds.age) + ")");
    }
    
    block_6:2000 late() {
        sim.outputFull(ages = T);
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 30);
        defineConstant("L", c(0.7, 0, 0, 0, 0.25, 0.5, 0.75, 1));
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        if (individual.age > 2) {
            mate = subpop.sampleIndividuals(1, minAge = 3);
            subpop.addCrossed(individual, mate);
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
        p1.individuals.age = rdunif(10, min = 0, max = 7);
    }
    
    block_4:early() {
        inds = p1.individuals;
        ages = inds.age;
        mortality = L[ages];
        survival = 1 - mortality;
        inds.fitnessScaling = survival;
        p1.fitnessScaling = K/(p1.individualCount * mean(survival));
    }
    
    block_5:late() {
        catn(sim.generation + ": " + paste(sort(p1.individuals.age)));
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        parents = sample(p1.individuals, p1.individualCount);
        for (i in seq(0, p1.individualCount - 2, by = 2)) {
            parent1 = parents[i];
            parent2 = parents[i + 1];
            litterSize = rpois(1, 2.7);
            for (j in seqLen(litterSize)) p1.addCrossed(parent1, parent2);
        }
        self.active = 0;
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_5:late() {
        inds = p1.individuals;
        catn(sim.generation + ": " + size(inds) + " (" + max(inds.age) + ")");
    }
    
    block_6:2000 late() {
        sim.outputFull(ages = T);
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeMutationType("m2", 1, "f", 0.5);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        for (i in 1:5) subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
    }
    
    block_4:100 early() {
        mutant = sample(p1.individuals.genomes, 10);
        mutant.addNewDrawnMutation(m2, 10000);
    }
    
    block_5:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_6:late() {
        inds = p1.individuals;
        catn(sim.generation + ": " + size(inds) + " (" + max(inds.age) + ")");
    }
    
    block_7:2000 late() {
        sim.outputFull(ages = T);
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 50);
        defineConstant("N", 10);
        defineConstant("m", 0.01);
        defineConstant("e", 0.1);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        for (i in 1:N) sim.addSubpop(i, (i == 1) %?% 10 %else% 0);
    }
    
    block_4:early() {
        nIndividuals = sum(sim.subpopulations.individualCount);
        nMigrants = rpois(1, nIndividuals * m);
        migrants = sample(sim.subpopulations.individuals, nMigrants);
        for (migrant in migrants) {
            do
            {
                dest = sample(sim.subpopulations, 1);
            }
            while (dest == migrant.subpopulation) slimr_special__;
            dest.takeMigrants(migrant);
        }
        for (subpop in sim.subpopulations) {
            if (runif(1) < e) subpop.fitnessScaling = 0 else subpop.fitnessScaling = K/subpop.individualCount;
        }
    }
    
    block_5:late() {
        if (sum(sim.subpopulations.individualCount) == 0) stop("Global extinction in generation " + sim.generation + ".");
    }
    
    block_6:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[8]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeMutationType("m2", 0.5, "e", 0.1);
        m2.color = "red";
        initializeMutationType("m3", 0.5, "e", 0.1);
        m3.color = "green";
        initializeGenomicElementType("g1", c(m1, m2, m3), c(0.98, 0.01, 0.01));
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        dest = sample(sim.subpopulations, 1);
        dest.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
        sim.addSubpop("p2", 10);
    }
    
    block_4:early() {
        inds = sim.subpopulations.individuals;
        inds_m2 = inds.countOfMutationsOfType(m2);
        inds_m3 = inds.countOfMutationsOfType(m3);
        pref_p1 = 0.5 + (inds_m2 - inds_m3) * 0.1;
        pref_p1 = pmax(pmin(pref_p1, 1), 0);
        inertia = ifelse(inds.subpopulation.id == 1, 1, 0);
        pref_p1 = pref_p1 * 0.75 + inertia * 0.25;
        choice = ifelse(runif(inds.size()) < pref_p1, 1, 2);
        moving = inds[choice != inds.subpopulation.id];
        from_p1 = moving[moving.subpopulation == p1];
        from_p2 = moving[moving.subpopulation == p2];
        p2.takeMigrants(from_p1);
        p1.takeMigrants(from_p2);
    }
    
    block_5:early() {
        p1.fitnessScaling = K/p1.individualCount;
        p2.fitnessScaling = K/p2.individualCount;
    }
    
    block_6:fitness(m2, p2) {
        return(1/relFitness);
    }
    
    block_7:fitness(m3, p1) {
        return(1/relFitness);
    }
    
    block_8:1000 late() {
        for (id in 1:2) {
            subpop = sim.subpopulations[sim.subpopulations.id == id];
            s = subpop.individualCount;
            inds = subpop.individuals;
            c2 = sum(inds.countOfMutationsOfType(m2));
            c3 = sum(inds.countOfMutationsOfType(m3));
            catn("subpop " + id + " (" + s + "): " + c2 + " m2, " + c3 + " m3");
        }
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        defineConstant("opt1", 0);
        defineConstant("opt2", 10);
        defineConstant("Tdelta", 10000);
        initializeMutationType("m1", 0.5, "n", 0, 1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_4:early() {
        inds = sim.subpopulations.individuals;
        phenotypes = inds.sumOfMutationsOfType(m1);
        optimum = (sim.generation < Tdelta) %?% opt1 %else% opt2;
        deviations = optimum - phenotypes;
        fitnessFunctionMax = dnorm(0, 0, 5);
        adaptation = dnorm(deviations, 0, 5)/fitnessFunctionMax;
        inds.fitnessScaling = 0.1 + adaptation * 0.9;
        inds.tagF = phenotypes;
        p1.fitnessScaling = min(K/p1.individualCount, 1.5);
    }
    
    block_5:fitness(m1) {
        return(1);
    }
    
    block_6:late() {
        if (p1.individualCount == 0) {
            catn("Extinction in generation " + sim.generation + ".");
            sim.simulationFinished();
        } else {
            phenotypes = p1.individuals.tagF;
            cat(sim.generation + ": " + p1.individualCount + " individuals");
            cat(", phenotype mean " + mean(phenotypes));
            if (size(phenotypes) > 1) cat(" (sd " + sd(phenotypes) + ")");
            catn();
        }
    }
    
    block_7:20000 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 200);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        fertilizedOvules = rbinom(1, 30, 0.5);
        other = (subpop == p1) %?% p2 %else% p1;
        pollenSources = ifelse(runif(fertilizedOvules) < 0.99, subpop, other);
        for (source in pollenSources) subpop.addCrossed(individual, source.sampleIndividuals(1));
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
        sim.addSubpop("p2", 10);
    }
    
    block_4:early() {
        for (subpop in sim.subpopulations) subpop.fitnessScaling = K/subpop.individualCount;
    }
    
    block_5:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeSex("A");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeMutationType("m2", 0.5, "n", 0, 0.3);
        initializeGenomicElementType("g1", c(m1, m2), c(1, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction(NULL, "F") {
        mate = subpop.sampleIndividuals(1, sex = "M");
        if (mate.size()) {
            qtlValue = individual.tagF;
            expectedLitterSize = max(0, qtlValue + 3);
            litterSize = rpois(1, expectedLitterSize);
            penalty = 3/litterSize;
            for (i in seqLen(litterSize)) {
                offspring = subpop.addCrossed(individual, mate);
                offspring.setValue("penalty", rgamma(1, penalty, 20));
            }
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
        p1.individuals.setValue("penalty", 1);
    }
    
    block_4:early() {
        inds = sim.subpopulations.individuals;
        inds[inds.age > 0] %.% fitnessScaling = 0;
        inds = inds[inds.age == 0];
        inds.tagF = inds.sumOfMutationsOfType(m2);
        inds.fitnessScaling = inds.getValue("penalty");
        p1.fitnessScaling = K/size(inds);
    }
    
    block_5:fitness(m2) {
        return(1);
    }
    
    block_6:late() {
        qtlValues = p1.individuals.tagF;
        expectedSizes = pmax(0, qtlValues + 3);
        cat(sim.generation + ": " + p1.individualCount + " individuals");
        cat(", mean litter size " + mean(expectedSizes));
        catn();
    }
    
    block_7:20000 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeSLiMOptions(dimensionality = "xy", periodicity = "xy");
        defineConstant("K", 300);
        defineConstant("S", 0.1);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = S);
        initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.1);
    }
    
    block_2:reproduction() {
        mate = i2.nearestNeighbors(individual, 1);
        for (i in seqLen(rpois(1, 0.1))) {
            if (mate.size()) offspring = subpop.addCrossed(individual, mate) else offspring = subpop.addSelfed(individual);
            pos = individual.spatialPosition + rnorm(2, 0, 0.02);
            offspring.setSpatialPosition(p1.pointPeriodic(pos));
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 1);
        p1.individuals.setSpatialPosition(p1.pointUniform(1));
    }
    
    block_4:early() {
        i1.evaluate();
        inds = p1.individuals;
        competition = i1.totalOfNeighborStrengths(inds);
        competition = (competition + 1)/(PI * S^2);
        inds.fitnessScaling = K/competition;
    }
    
    block_5:late() {
        for (ind in p1.individuals) {
            newPos = ind.spatialPosition + runif(2, -0.01, 0.01);
            ind.setSpatialPosition(p1.pointPeriodic(newPos));
        }
        i2.evaluate();
    }
    
    block_6:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeSLiMOptions(dimensionality = "xy", periodicity = "xy");
        defineConstant("K", 300);
        defineConstant("S", 0.1);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = S * 3);
        i1.setInteractionFunction("n", 1, S);
        initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.1);
    }
    
    block_2:reproduction() {
        mate = i2.nearestNeighbors(individual, 1);
        for (i in seqLen(rpois(1, 0.1))) {
            if (mate.size()) offspring = subpop.addCrossed(individual, mate) else offspring = subpop.addSelfed(individual);
            pos = individual.spatialPosition + rnorm(2, 0, 0.02);
            offspring.setSpatialPosition(p1.pointPeriodic(pos));
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 1);
        p1.individuals.setSpatialPosition(p1.pointUniform(1));
    }
    
    block_4:early() {
        i1.evaluate();
        inds = p1.individuals;
        competition = i1.totalOfNeighborStrengths(inds);
        competition = (competition + 1)/(2 * PI * S^2);
        inds.fitnessScaling = K/competition;
    }
    
    block_5:late() {
        for (ind in p1.individuals) {
            newPos = ind.spatialPosition + runif(2, -0.01, 0.01);
            ind.setSpatialPosition(p1.pointPeriodic(newPos));
        }
        i2.evaluate();
    }
    
    block_6:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 10);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
        deleteFile("~/Desktop/mating.txt");
        deleteFile("~/Desktop/death.txt");
    }
    
    block_2:reproduction() {
        mate = subpop.sampleIndividuals(1);
        child = subpop.addCrossed(individual, mate);
        child.tag = sim.tag;
        sim.tag = sim.tag + 1;
        line = paste(sim.generation, individual.tag, mate.tag, child.tag);
        writeFile("~/Desktop/mating.txt", line, append = T);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
        p1.individuals.tag = 1:10;
        sim.tag = 11;
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
        sim.setValue("extant", sim.subpopulations.individuals.tag);
    }
    
    block_5:late() {
        oldExtant = sim.getValue("extant");
        newExtant = sim.subpopulations.individuals.tag;
        survived = (match(oldExtant, newExtant) >= 0);
        died = oldExtant[!survived];
        for (indTag in died) {
            line = sim.generation + " " + indTag;
            writeFile("~/Desktop/death.txt", line, append = T);
        }
    }
    
    block_6:100 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 10);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
        deleteFile("~/Desktop/mating.txt");
        deleteFile("~/Desktop/death.txt");
    }
    
    block_2:reproduction() {
        mate = subpop.sampleIndividuals(1);
        child = subpop.addCrossed(individual, mate);
        child.tag = sim.tag;
        sim.tag = sim.tag + 1;
        line = paste(sim.generation, individual.tag, mate.tag, child.tag);
        writeFile("~/Desktop/mating.txt", line, append = T);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 10);
        p1.individuals.tag = 1:10;
        sim.tag = 11;
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
        sim.setValue("extant", sim.subpopulations.individuals.tag);
    }
    
    block_5:late() {
        oldExtant = sim.getValue("extant");
        newExtant = sim.subpopulations.individuals.tag;
        survived = (match(oldExtant, newExtant) >= 0);
        died = oldExtant[!survived];
        for (indTag in died) {
            line = sim.generation + " " + indTag;
            writeFile("~/Desktop/death.txt", line, append = T);
        }
    }
    
    block_6:100 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        subpop.addRecombinant(genome1, NULL, NULL, NULL, NULL, NULL);
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_5:late() {
        muts = sim.mutationsOfType(m1);
        freqs = sim.mutationFrequencies(NULL, muts);
        if (any(freqs == 0.5)) sim.subpopulations.genomes.removeMutations(muts[freqs == 0.5], T);
    }
    
    block_6:50000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 1e+05);
        defineConstant("L", 1e+05);
        defineConstant("H", 0.001);
        initializeMutationType("m1", 1, "f", 0);
        initializeMutationType("m2", 1, "f", 0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeMutationRate(0);
        initializeRecombinationRate(0);
    }
    
    block_2:reproduction() {
        if (runif(1) < H) {
            HGTsource = p1.sampleIndividuals(1, exclude = individual) %.% genome1;
            do
            {
                breaks = rdunif(2, max = L - 1);
            }
            while (breaks[0] == breaks[1]) slimr_special__;
            if (breaks[0] > breaks[1]) breaks = c(0, breaks[1], breaks[0]);
            subpop.addRecombinant(genome1, HGTsource, breaks, NULL, NULL, NULL);
        } else {
            subpop.addRecombinant(genome1, NULL, NULL, NULL, NULL, NULL);
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", 2);
        g = p1.individuals.genome1;
        g[0] %.% addNewDrawnMutation(m2, asInteger(L * 0.25));
        g[1] %.% addNewDrawnMutation(m2, asInteger(L * 0.75));
    }
    
    block_4:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_5:late() {
        muts = sim.mutations;
        freqs = sim.mutationFrequencies(NULL, muts);
        if (all(freqs == 0.5)) {
            catn(sim.generation + ": " + sum(freqs == 0.5) + " fixed.");
            sim.simulationFinished();
        }
    }
    
    block_6:1e6 late() {
        catn(sim.generation + ": no result.");
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        K = sim.getValue("K");
        for (i in seqLen(K)) {
            firstParent = p1.sampleIndividuals(1);
            secondParent = p1.sampleIndividuals(1);
            p1.addCrossed(firstParent, secondParent);
        }
        self.active = 0;
    }
    
    block_3:1 early() {
        sim.setValue("K", 500);
        sim.addSubpop("p1", sim.getValue("K"));
    }
    
    block_4:early() {
        inds = sim.subpopulations.individuals;
        inds[inds.age > 0] %.% fitnessScaling = 0;
    }
    
    block_5:10000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_init:initialize() {
        defineConstant("K", 500);
        defineConstant("MU", 1e-07);
        defineConstant("R", 1e-07);
        defineConstant("L1", 1e+05 - 1);
        initializeSLiMModelType("nonWF");
        initializeSex("A");
        initializeMutationRate(MU);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L1);
        initializeRecombinationRate(R);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", K);
        sim.addSubpop("p2", 0);
    }
    
    block_3:reproduction(p1) {
        g_1 = genome1;
        g_2 = genome2;
        for (meiosisCount in 1:5) {
            if (individual.sex == "M") {
                breaks = sim.chromosome.drawBreakpoints(individual);
                s_1 = p2.addRecombinant(g_1, g_2, breaks, NULL, NULL, NULL, "M");
                s_2 = p2.addRecombinant(g_2, g_1, breaks, NULL, NULL, NULL, "M");
                breaks = sim.chromosome.drawBreakpoints(individual);
                s_3 = p2.addRecombinant(g_1, g_2, breaks, NULL, NULL, NULL, "M");
                s_4 = p2.addRecombinant(g_2, g_1, breaks, NULL, NULL, NULL, "M");
            } else if (individual.sex == "F") {
                breaks = sim.chromosome.drawBreakpoints(individual);
                if (runif(1) <= 0.5) e = p2.addRecombinant(g_1, g_2, breaks, NULL, NULL, NULL, "F") else e = p2.addRecombinant(g_2, g_1, breaks, NULL, NULL, NULL, "F");
            }
        }
    }
    
    block_4:reproduction(p2, "F") {
        mate = p2.sampleIndividuals(1, sex = "M", tag = 0);
        mate.tag = 1;
        child = p1.addRecombinant(individual.genome1, NULL, NULL, mate.genome1, NULL, NULL);
    }
    
    block_5:early() {
        if (sim.generation%%2 == 0) {
            p1.fitnessScaling = 0;
            p2.individuals.tag = 0;
            sim.chromosome.setMutationRate(0);
        } else {
            p2.fitnessScaling = 0;
            p1.fitnessScaling = K/p1.individualCount;
            sim.chromosome.setMutationRate(MU);
        }
    }
    
    block_6:10000 late() {
        sim.simulationFinished();
    }

---

    <slimr_script[7]>
    block_1:function (i)driveBreakpoints(o<Genome>$ gen1, o<Genome>$ gen2) {
        breaks = sim.chromosome.drawBreakpoints();
        gen1has = gen1.containsMarkerMutation(m2, D_pos);
        gen2has = gen2.containsMarkerMutation(m2, D_pos);
        if (gen1has == gen2has) return(breaks);
        polarity = sum(breaks <= D_pos)%%2;
        polarityI = (gen1has %?% 0 %else% 1);
        desiredPolarity = (runif(1) < D_prob) %?% polarityI %else% !polarityI;
        if (desiredPolarity != polarity) return(c(0, breaks));
        return(breaks);
    }
    
    block_2:initialize() {
        initializeSLiMModelType("nonWF");
        defineConstant("K", 500);
        defineConstant("D_pos", 20000);
        defineConstant("D_prob", 0.8);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeMutationType("m2", 0.1, "f", -0.1);
        m2.color = "red";
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_3:reproduction() {
        m = subpop.sampleIndividuals(1);
        b1 = driveBreakpoints(genome1, genome2);
        b2 = driveBreakpoints(m.genome1, m.genome2);
        subpop.addRecombinant(genome1, genome2, b1, m.genome1, m.genome2, b2);
    }
    
    block_4:1 early() {
        sim.addSubpop("p1", 10);
    }
    
    block_5:early() {
        p1.fitnessScaling = K/p1.individualCount;
    }
    
    block_6:100 early() {
        target = sample(p1.genomes, 10);
        target.addNewDrawnMutation(m2, D_pos);
    }
    
    block_7:100:1000 late() {
        mut = sim.mutationsOfType(m2);
        if (size(mut) == 0) {
            catn(sim.generation + ": LOST");
            sim.simulationFinished();
        } else if (sim.mutationFrequencies(NULL, mut) == 1) {
            catn(sim.generation + ": FIXED");
            sim.simulationFinished();
        }
    }

---

    <slimr_script[7]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeSLiMOptions(dimensionality = "xy", periodicity = "xy");
        defineConstant("K", 10000);
        defineConstant("S", 0.01);
        defineConstant("HEALTH_S", 0);
        defineConstant("HEALTH_I", 1);
        defineConstant("HEALTH_R", 2);
        defineConstant("FERTILITY", 0.05);
        defineConstant("INFECTIVITY", 4);
        defineConstant("RATE_DEATH", 0.3);
        defineConstant("RATE_CLEAR", 0.05);
        defineConstant("MAX_AGE", 100);
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
        initializeInteractionType(1, "xy", reciprocal = T, maxDistance = S * 3);
        i1.setInteractionFunction("n", 1, S);
        initializeInteractionType(2, "xy", reciprocal = T, maxDistance = 0.05);
    }
    
    block_2:reproduction() {
        litterSize = rpois(1, FERTILITY);
        if (litterSize) {
            mate = i2.nearestNeighbors(individual, 1);
            if (mate.size()) for (i in seqLen(litterSize)) {
                    offspring = subpop.addCrossed(individual, mate);
                    pos = individual.spatialPosition + rnorm(2, 0, 0.005);
                    offspring.setSpatialPosition(p1.pointPeriodic(pos));
                    offspring.tag = HEALTH_S;
                }
        }
    }
    
    block_3:1 early() {
        sim.addSubpop("p1", K);
        p1.individuals.setSpatialPosition(p1.pointUniform(K));
        p1.individuals.tag = HEALTH_S;
    }
    
    block_4:100 early() {
        target = p1.sampleIndividuals(1, tag = HEALTH_S);
        target.tag = HEALTH_I;
    }
    
    block_5:early() {
        i1.evaluate();
        inds = p1.individuals;
        competition = i1.totalOfNeighborStrengths(inds);
        competition = (competition + 1)/(2 * PI * S^2);
        inds.fitnessScaling = K/competition;
        age_mortality = sqrt((MAX_AGE - inds.age)/MAX_AGE);
        inds.fitnessScaling = inds.fitnessScaling * age_mortality;
        infected = inds[inds.tag == HEALTH_I];
        for (ind in infected) {
            contacts = i1.drawByStrength(ind, rpois(1, INFECTIVITY));
            for (contact in contacts) {
                if (contact.tag == HEALTH_S) {
                    strength = i1.strength(ind, contact);
                    if (runif(1) < strength) contact.tag = HEALTH_I;
                }
            }
            if (runif(1) < RATE_DEATH) ind.fitnessScaling = 0;
            if (runif(1) < RATE_CLEAR) ind.tag = HEALTH_R;
        }
    }
    
    block_6:late() {
        inds = p1.individuals;
        for (ind in inds) {
            newPos = ind.spatialPosition + runif(2, -0.005, 0.005);
            ind.setSpatialPosition(p1.pointPeriodic(newPos));
        }
        inds_tags = inds.tag;
        inds[inds_tags == HEALTH_S] %.% color = "green";
        inds[inds_tags == HEALTH_I] %.% color = "red";
        inds[inds_tags == HEALTH_R] %.% color = "blue";
        i2.evaluate();
    }
    
    block_7:1:1000 late() {
        tags = p1.individuals.tag;
        cat(sum(tags == HEALTH_S) + ", " + sum(tags == HEALTH_I) + ", " + sum(tags == HEALTH_R) + ", ");
        if ((sum(tags == HEALTH_I) == 0) & (sim.generation >= 100)) {
            catn("\nLOST in generation " + sim.generation);
            sim.simulationFinished();
        }
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        defineConstant("K", 1000);
        defineConstant("N", 10);
        defineConstant("M", 0.01);
        defineConstant("R", 1.04);
        initializeSLiMModelType("nonWF");
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction() {
        litterSize = rpois(1, R);
        for (i in seqLen(litterSize)) {
            mate = subpop.sampleIndividuals(1, exclude = individual);
            if (mate.size()) subpop.addCrossed(individual, mate);
        }
    }
    
    block_3:1 early() {
        for (i in seqLen(N)) sim.addSubpop(i, (i == 0) %?% 100 %else% 0);
    }
    
    block_4:1 late() {
        log = sim.createLogFile("~/Desktop/sim_log.txt", sep = "\t", logInterval = 10);
        log.addGeneration();
        log.addPopulationSize();
        log.addMeanSDColumns("size", "sim.subpopulations.individualCount;");
        log.addCustomColumn("pop_migrants", "sum(sim.subpopulations.individuals.migrant);");
        log.addMeanSDColumns("migrants", "sapply(sim.subpopulations, 'sum(applyValue.individuals.migrant);');");
    }
    
    block_5:early() {
        inds = sim.subpopulations.individuals;
        ages = inds.age;
        inds[ages > 0] %.% fitnessScaling = 0;
        inds = inds[ages == 0];
        numMigrants = rbinom(1, inds.size(), M);
        if (numMigrants) {
            migrants = sample(inds, numMigrants);
            currentSubpopID = migrants.subpopulation.id;
            displacement = -1 + rbinom(migrants.size(), 1, 0.5) * 2;
            newSubpopID = currentSubpopID + displacement;
            actuallyMoving = (newSubpopID >= 0) & (newSubpopID < N);
            if (sum(actuallyMoving)) {
                migrants = migrants[actuallyMoving];
                newSubpopID = newSubpopID[actuallyMoving];
                for (subpop in sim.subpopulations) subpop.takeMigrants(migrants[newSubpopID == subpop.id]);
            }
        }
        for (subpop in sim.subpopulations) {
            juvenileCount = sum(subpop.individuals.age == 0);
            subpop.fitnessScaling = K/juvenileCount;
        }
    }
    
    block_6:1001 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        defineConstant("K", 50000);
        defineConstant("R", 1.1);
        defineConstant("M", K/(R - 1));
        initializeSLiMModelType("nonWF");
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 50);
        sim.addSubpop("p2", 50);
        sim.addSubpop("p3", 50);
        log = sim.createLogFile("~/Desktop/sim_log.txt", logInterval = 1);
        log.addGeneration();
        log.addSubpopulationSize(p1);
        log.addSubpopulationSize(p2);
        log.addSubpopulationSize(p3);
    }
    
    block_3:reproduction(p1) {
        litterSize = rpois(1, R);
        for (i in seqLen(litterSize)) subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_4:reproduction(p2) {
        n_t = subpop.individualCount;
        n_t_plus_1 = (R * n_t)/(1 + n_t/M);
        mean_litter_size = n_t_plus_1/n_t;
        litterSize = rpois(1, mean_litter_size);
        for (i in seqLen(litterSize)) subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_5:reproduction(p3) {
        litterSize = rpois(1, R);
        for (i in seqLen(litterSize)) subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_6::200 early() {
        inds = p1.individuals;
        inds[inds.age > 0] %.% fitnessScaling = 0;
        n_t_plus_pt5 = sum(inds.age == 0);
        p1.fitnessScaling = K/n_t_plus_pt5;
        inds = p2.individuals;
        inds[inds.age > 0] %.% fitnessScaling = 0;
        inds = p3.individuals;
        inds[inds.age > 0] %.% fitnessScaling = 0;
        n_t_plus_pt5 = sum(inds.age == 0);
        p3.fitnessScaling = 1/(1 + (n_t_plus_pt5/R)/M);
    }

---

    <slimr_script[10]>
    block_01:initialize() {
        initializeSLiMModelType("nonWF");
        initializeMutationType("m1", 0.5, "f", 0);
        m1.convertToSubstitution = T;
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 99999);
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08);
    }
    
    block_02:reproduction() {
        subpop.addCrossed(individual, subpop.sampleIndividuals(1));
    }
    
    block_03:1 early() {
        sim.addSubpop("p1", 10) %.% setValue("K", 500);
        sim.addSubpop("p2", 10) %.% setValue("K", 600);
    }
    
    block_04:early() {
        for (subpop in sim.subpopulations) {
            K = subpop.getValue("K");
            subpop.fitnessScaling = K/subpop.individualCount;
        }
    }
    
    block_05:5000 late() {
        ;
    }
    
    block_06:999 late() {
        sim.addSubpop("p3", 0) %.% setValue("K", 750);
    }
    
    block_07:1000 reproduction() {
        founderCount = rdunif(1, 10, 20);
        p1_inds = p1.individuals;
        p2_inds = p2.individuals;
        all_inds = c(p1_inds, p2_inds);
        for (i in seqLen(founderCount)) {
            parent1 = sample(all_inds, 1);
            if (rdunif(1) < 0.2) parent2 = sample(p1_inds, 1) else parent2 = sample(p2_inds, 1);
            p3.addCrossed(parent1, parent2);
        }
        self.active = 0;
    }
    
    block_08:1000 early() {
        c(p1, p2) %.% fitnessScaling = 0;
    }
    
    block_09:1999 late() {
        sim.addSubpop("p4", 0) %.% setValue("K", 100);
    }
    
    block_10:2000 reproduction() {
        founderCount = rdunif(1, 10, 20);
        all_inds = p3.individuals;
        for (i in seqLen(founderCount)) {
            parent1 = sample(all_inds, 1);
            parent2 = sample(all_inds, 1);
            p4.addCrossed(parent1, parent2);
        }
        self.active = 0;
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeTreeSeq();
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 1e+08 - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:5000 late() {
        sim.treeSeqOutput("./recipe_17.1.trees");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "g", -0.01, 1);
        initializeMutationType("m3", 1, "f", 0.05);
        initializeGenomicElementType("g1", c(m1, m2), c(0.9, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        defineConstant("simID", getSeed());
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m3, 10000);
        sim.outputFull("/tmp/slim_" + simID + ".txt");
    }
    
    block_4:1000:100000 late() {
        if (sim.countOfMutationsOfType(m3) == 0) {
            if (sum(sim.substitutions.mutationType == m3) == 1) {
                cat(simID + ": FIXED\n");
                sim.simulationFinished();
            } else {
                cat(simID + ": LOST - RESTARTING\n");
                sim.readFromPopulationFile("/tmp/slim_" + simID + ".txt");
                setSeed(rdunif(1, 0, asInteger(2^62) - 1));
            }
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeMutationRate(1e-07);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "g", -0.01, 1);
        initializeMutationType("m3", 1, "f", 0.05);
        initializeGenomicElementType("g1", c(m1, m2), c(0.9, 0.1));
        initializeGenomicElement(g1, 0, 99999);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        defineConstant("simID", getSeed());
        sim.addSubpop("p1", 500);
    }
    
    block_3:1000 late() {
        target = sample(p1.genomes, 1);
        target.addNewDrawnMutation(m3, 10000);
        sim.outputFull("/tmp/slim_" + simID + ".txt");
    }
    
    block_4:1000:100000 late() {
        if (sim.countOfMutationsOfType(m3) == 0) {
            if (sum(sim.substitutions.mutationType == m3) == 1) {
                cat(simID + ": FIXED\n");
                sim.simulationFinished();
            } else {
                cat(simID + ": LOST - RESTARTING\n");
                sim.readFromPopulationFile("/tmp/slim_" + simID + ".txt");
                setSeed(rdunif(1, 0, asInteger(2^62) - 1));
            }
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("N", 10000);
        defineConstant("L", 1e+08);
        defineConstant("L0", 2e+05);
        defineConstant("L1", 1000);
        initializeTreeSeq();
        initializeMutationRate(1e-07);
        initializeRecombinationRate(1e-08, L - 1);
        initializeMutationType("m2", 0.5, "g", -(5/N), 1);
        initializeGenomicElementType("g2", m2, 1);
        for (start in seq(from = L0, to = L - (L0 + L1), by = (L0 + L1))) initializeGenomicElement(g2, start, (start + L1) - 1);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", N);
        sim.rescheduleScriptBlock(s1, 10 * N, 10 * N);
    }
    
    block_3:s1 10 late() {
        sim.treeSeqOutput("./recipe_17.4.trees");
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("L", 1e+08);
        initializeTreeSeq();
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        sim.addSubpop("p2", 500);
        sim.treeSeqRememberIndividuals(sim.subpopulations.individuals);
        p1.genomes.addNewDrawnMutation(m1, asInteger(L * 0.2));
        p2.genomes.addNewDrawnMutation(m1, asInteger(L * 0.8));
        sim.addSubpop("p3", 1000);
        p3.setMigrationRates(c(p1, p2), c(0.5, 0.5));
    }
    
    block_3:2 late() {
        p3.setMigrationRates(c(p1, p2), c(0, 0));
        p1.setSubpopulationSize(0);
        p2.setSubpopulationSize(0);
    }
    
    block_4:2:10000 late() {
        if (sim.mutationsOfType(m1) %.% size() == 0) {
            sim.treeSeqOutput("./recipe_17.5.trees");
            sim.simulationFinished();
        }
    }
    
    block_5:10000 late() {
        stop("Did not reach fixation of beneficial alleles.");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeTreeSeq(checkCoalescence = T);
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1);
        initializeGenomicElement(g1, 0, 1e+08 - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1:1e+05 late() {
        if (sim.treeSeqCoalesced()) {
            catn(sim.generation + ": COALESCED");
            sim.simulationFinished();
        }
    }
    
    block_4:100000 late() {
        catn("NO COALESCENCE BY GENERATION 100000");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeTreeSeq();
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        initializeGenomicElementType("g1", m2, 1);
        initializeGenomicElement(g1, 0, 1e+08 - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.readFromPopulationFile("recipe_17.8.trees");
        target = sample(sim.subpopulations.genomes, 1);
        target.addNewDrawnMutation(m2, 10000);
    }
    
    block_3:1:2000 late() {
        if (sim.mutationsOfType(m2) %.% size() == 0) {
            print(sim.substitutions.size() %?% "FIXED" %else% "LOST");
            sim.treeSeqOutput("recipe_17.8_II.trees");
            sim.simulationFinished();
        }
    }
    
    block_4:2000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[6]>
    block_1:initialize() {
        initializeSLiMModelType("nonWF");
        initializeTreeSeq();
        initializeSex("A");
        initializeMutationRate(0);
        initializeMutationType("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        m2.convertToSubstitution = T;
        initializeGenomicElementType("g1", m2, 1);
        initializeGenomicElement(g1, 0, 1e+08 - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:reproduction(NULL, "F") {
        subpop.addCrossed(individual, subpop.sampleIndividuals(1, sex = "M"));
    }
    
    block_3:1 early() {
        sim.readFromPopulationFile("recipe_17.9.trees");
    }
    
    block_4:early() {
        p0.fitnessScaling = 5000/p0.individualCount;
    }
    
    block_5:1:2000 late() {
        if (sim.mutationsOfType(m2) %.% size() == 0) {
            print(sim.substitutions.size() %?% "FIXED" %else% "LOST");
            sim.treeSeqOutput("recipe_17.9_II.trees");
            sim.simulationFinished();
        }
    }
    
    block_6:2000 early() {
        sim.simulationFinished();
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeTreeSeq(simplificationRatio = INF);
        initializeMutationRate(0);
        initializeMutationType("m2", 0.5, "f", 1);
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", m2, 1);
        initializeGenomicElement(g1, 0, 1e+06 - 1);
        initializeRecombinationRate(3e-10);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 1e+05);
    }
    
    block_3:100 late() {
        sample(p1.genomes, 1) %.% addNewDrawnMutation(m2, 5e+05);
    }
    
    block_4:100:10000 late() {
        mut = sim.mutationsOfType(m2);
        if (mut.size() != 1) stop(sim.generation + ": LOST") else if (sum(sim.mutationFrequencies(NULL, mut)) == 1) {
            sim.treeSeqOutput("recipe_17.10_decap.trees");
            sim.simulationFinished();
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+06);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(1e-07));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 10);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(2.5e-05));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        c = sim.chromosome;
        catn("Ancestral: " + c.ancestralNucleotides());
        catn("Ancestral: " + paste(c.ancestralNucleotides(format = "char")));
        catn("Ancestral: " + paste(c.ancestralNucleotides(format = "integer")));
        catn("positions: " + paste(0:(L - 1)));
        catn();
        sim.addSubpop("p1", 500);
    }
    
    block_3:5000 late() {
        catn("Fixed:     " + paste(sim.substitutions.nucleotide));
        catn("Fixed:     " + paste(sim.substitutions.nucleotideValue));
        catn("positions: " + paste(sim.substitutions.position));
        catn();
        c = sim.chromosome;
        catn("Ancestral: " + c.ancestralNucleotides());
        catn("Ancestral: " + paste(c.ancestralNucleotides(format = "char")));
        catn("Ancestral: " + paste(c.ancestralNucleotides(format = "integer")));
        catn("positions: " + paste(0:(L - 1)));
        catn();
        g = p1.genomes[0];
        catn("SNPs:      " + paste(g.mutations.nucleotide));
        catn("SNPs:      " + paste(g.mutations.nucleotideValue));
        catn("positions: " + paste(g.mutations.position));
        catn();
        catn("Derived:   " + g.nucleotides());
        catn("Derived:   " + paste(g.nucleotides(format = "char")));
        catn("Derived:   " + paste(g.nucleotides(format = "integer")));
        catn("positions: " + paste(0:(L - 1)));
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 10);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(2.5e-05));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:5000 late() {
        g = p1.sampleIndividuals(5) %.% genomes;
        g.outputVCF(simplifyNucleotides = F);
        g.outputVCF(simplifyNucleotides = T);
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+05);
        defineConstant("mu", 7.5e-06);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        mm = mm16To256(mmJukesCantor(mu/3));
        xcg = c("ACG", "CCG", "GCG", "TCG");
        xcg_codons = nucleotidesToCodons(paste0(xcg));
        mm[xcg_codons, 3] = mm[xcg_codons, 3] * 20;
        cgx = c("CGA", "CGC", "CGG", "CGT");
        cgx_codons = nucleotidesToCodons(paste0(cgx));
        mm[cgx_codons, 0] = mm[cgx_codons, 0] * 20;
        initializeGenomicElementType("g1", m1, 1, mutationMatrix = mm);
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 10);
    }
    
    block_3:1:10000000 early() {
        if (sim.generation%%10000 == 1) {
            cat(sim.generation + ": ");
            print(nucleotideFrequencies(sim.chromosome.ancestralNucleotides()));
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+05);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeMutationType("m2", 0.5, "f", 0.1);
        m2.convertToSubstitution = F;
        m2.color = "red";
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(1e-07));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 500);
        sample(p1.genomes, 10) %.% addNewDrawnMutation(m2, 20000);
    }
    
    block_3:2000 late() {
        print(sim.mutationsOfType(m2));
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(3e+05));
        mm = mmJukesCantor(2.5e-08);
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeMutationTypeNuc("m2", 0.1, "g", -0.03, 0.2);
        initializeGenomicElementType("g1", c(m1, m2), c(3, 3), mm);
        initializeGenomicElementType("g2", c(m1, m2), c(5, 1), mm);
        initializeRecombinationRate(1e-08);
        types = rep(c(g1, g2), 1e+05);
        starts = repEach(seqLen(1e+05) * 3, 2) + rep(c(0, 2), 1e+05);
        ends = starts + rep(c(1, 0), 1e+05);
        initializeGenomicElement(types, starts, ends);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1e6 late() {
        sub = sim.substitutions;
        pos3 = (sub.position%%3 == 2);
        pos12 = !pos3;
        catn(size(sub) + " substitutions occurred.");
        catn(mean(sub.mutationType == m1) * 100 + "%% are neutral.");
        catn(mean(sub.mutationType == m2) * 100 + "%% are non-neutral.");
        catn();
        catn(size(sub[pos12]) + " substitutions are at position 1 or 2.");
        catn(mean(sub[pos12] %.% mutationType == m1) * 100 + "%% are neutral.");
        catn(mean(sub[pos12] %.% mutationType == m2) * 100 + "%% are non-neutral.");
        catn();
        catn(size(sub[pos3]) + " substitutions are at position 3.");
        catn(mean(sub[pos3] %.% mutationType == m1) * 100 + "%% are neutral.");
        catn(mean(sub[pos3] %.% mutationType == m2) * 100 + "%% are non-neutral.");
        catn();
    }

---

    <slimr_script[5]>
    block_1:initialize() {
        defineConstant("L", 10000);
        defineConstant("EFF", c(1, 0.1, 1.5, 3));
        initializeSLiMOptions(nucleotideBased = T);
        seq = randomNucleotides(100) + "A" + randomNucleotides(10000 - 101);
        initializeAncestralNucleotides(seq);
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(2.5e-07));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:late() {
        if (sum(sim.mutations.position == 100) == 0) s1.active = 0;
    }
    
    block_4:s1  fitness(NULL) {
        nuc1 = genome1.nucleotides(100, 100, format = "integer");
        nuc2 = genome2.nucleotides(100, 100, format = "integer");
        return(EFF[nuc1] * EFF[nuc2]);
    }
    
    block_5:10000 late() {
        subs = sim.substitutions[sim.substitutions.position == 100];
        for (sub in subs) catn("Sub to " + sub.nucleotide + " in " + sub.fixationGeneration);
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        defineConstant("L", 10000);
        defineConstant("TAA", nucleotidesToCodons("TAA"));
        defineConstant("TAG", nucleotidesToCodons("TAG"));
        defineConstant("TGA", nucleotidesToCodons("TGA"));
        defineConstant("STOP", c(TAA, TAG, TGA));
        defineConstant("NONSTOP", (0:63)[match(0:63, STOP) < 0]);
        codons = sample(NONSTOP, 194, replace = T);
        seq1 = randomNucleotides(253);
        seq2 = paste0(codonsToNucleotides(codons, format = "char")[0:417]);
        seq3 = randomNucleotides(200);
        seq4 = paste0(codonsToNucleotides(codons, format = "char")[418:581]);
        seq5 = randomNucleotides(L - 1035);
        seq = seq1 + seq2 + seq3 + seq4 + seq5;
        catn("Initial AA sequence: " + codonsToAminoAcids(codons));
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(seq);
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(2.5e-06));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:fitness(NULL) {
        for (g in individual.genomes) {
            seq = g.nucleotides(253, 670) + g.nucleotides(871, 1034);
            codons = nucleotidesToCodons(seq);
            if (sum(match(codons, STOP) >= 0)) return(0);
        }
        return(1);
    }
    
    block_4:100000 late() {
        catn(sim.substitutions.size() + " fixed mutations.");
        as1 = sim.chromosome.ancestralNucleotides(253, 670, "integer");
        as2 = sim.chromosome.ancestralNucleotides(871, 1034, "integer");
        as = c(as1, as2);
        codons = nucleotidesToCodons(as);
        catn("Final AA sequence: " + codonsToAminoAcids(codons));
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+05);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        m1.color = "black";
        initializeGenomicElementType("g1", m1, 1, mmKimura(1.8e-07, 6e-08));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
        ends = c(sort(sample(0:(L - 2), 99)), L - 1);
        multipliers = rlnorm(100, 0, 0.75);
        initializeHotspotMap(multipliers, ends);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:2000 late() {
        sim.outputFixedMutations();
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+05);
        defineConstant("alpha", 2.5e-06);
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(alpha));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-05);
        initializeGeneConversion(0.7, 1500, 0.8, 0.1);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:1:500001 early() {
        if (sim.generation%%1000 == 1) {
            cat(sim.generation + ": ");
            print(nucleotideFrequencies(sim.chromosome.ancestralNucleotides()));
        }
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeSLiMOptions(nucleotideBased = T);
        length = initializeAncestralNucleotides("hs37d5_chr22_patched.fa");
        defineConstant("L", length);
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeMutationTypeNuc("m2", 0.5, "f", 0);
        m2.color = "red";
        m2.convertToSubstitution = F;
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(0));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-08);
    }
    
    block_2:1 late() {
        sim.addSubpop("p1", 99);
        p1.genomes.readFromVCF("chr22_filtered.recode.vcf", m1);
        p1.setSubpopulationSize(1000);
    }
    
    block_3:5 late() {
        mut = sample(sim.mutations, 1);
        mut.setMutationType(m2);
        mut.setSelectionCoeff(0.5);
    }
    
    block_4:1:2000 late() {
        mut = sim.mutationsOfType(m2);
        if (mut.size()) {
            f = sim.mutationFrequencies(p1, mut);
            catn(sim.generation + ": " + sim.mutations.size() + ", f = " + f);
            if (f == 1) {
                catn("\nFIXED in generation " + sim.generation);
                catn(sim.substitutions.size() + " substitutions.");
                catn(paste(sim.substitutions.nucleotide));
                sim.simulationFinished();
            }
        } else {
            catn(sim.generation + ": " + sim.mutations.size());
        }
    }

---

    <slimr_script[3]>
    block_1:initialize() {
        defineConstant("L", 1e+05);
        initializeSLiMOptions(nucleotideBased = T);
        initializeTreeSeq();
        initializeAncestralNucleotides(randomNucleotides(L));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(1e-06));
        initializeGenomicElement(g1, 0, L - 1);
        initializeRecombinationRate(1e-06);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 1000);
    }
    
    block_3:1000 late() {
        sim.treeSeqOutput("recipe_nucleotides.trees");
    }

---

    <slimr_script[4]>
    block_1:initialize() {
        initializeSLiMOptions(nucleotideBased = T);
        initializeAncestralNucleotides(randomNucleotides(100));
        initializeMutationTypeNuc("m1", 0.5, "f", 0);
        initializeGenomicElementType("g1", m1, 1, mmJukesCantor(1e-04/3));
        initializeGenomicElement(g1, 0, 99);
        initializeRecombinationRate(0.001);
    }
    
    block_2:1 early() {
        sim.addSubpop("p1", 500);
    }
    
    block_3:mutation(m1) {
        m = sim.subsetMutations(position = mut.position, nucleotide = mut.nucleotide);
        if (m.length()) return(m);
        return(T);
    }
    
    block_4:1000 late() {
        for (pos in 0:99) {
            muts = sim.subsetMutations(position = pos);
            nucs = muts.nucleotide;
            cat(pos + " : " + paste(nucs));
            if (size(nucs) != size(unique(nucs))) cat("     DUPLICATES!");
            catn();
        }
    }

