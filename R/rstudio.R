slim_run_snippet <- function(x) {

  if(inherits(x, "character")) {
    if(length(x) > 1) {
      parsed <- rlang::parse_expr("{" %+% paste(x, collapse = "\n") %+% "}")
    } else {
      pasrsed <- rlang::parse_expr(paste(x, collapse = "\n"))
    }
  } else {
    parsed <- rlang::enexpr(x)
  }

  t_script <- eval(rlang::expr(!!minimal_slim_sim(!!parsed)))

  scrpt_txt <- as_slim_text(t_script) %>%
    paste(collapse = "\n")

  slim_run_script(scrpt_txt)

}

minimal_slim_sim <- function(command) {

  rlang::expr(slim_script(
    slim_block(initialize(), {
      initializeMutationRate(1e-7);
      initializeMutationType("m1", 0.5, "f", 0.0);
      initializeGenomicElementType("g1", m1, 1.0);
      initializeGenomicElement(g1, 0, 99999);
      initializeRecombinationRate(1e-8);
    }),
    slim_block(1, {
      sim.addSubpop("p1", 500);
      !!rlang::enexpr(command);
      sim.simulationFinished();
    })
  ))

}

