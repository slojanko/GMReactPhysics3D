draw_text(0, 48, string("Simulation: {0} took {1}s", SimulationThreadToString(simulation), string_format(last_update_took / 1000000, 1, 3)));
draw_text(0, 64, "Press 1 to Pause");
draw_text(0, 80, "Press 2 for Runner thread");
draw_text(0, 96, "Press 3 for Async thread");