//draw_surface(depth_surface, 0, 0);

draw_text(0, 32, fps);
draw_text(0, 48, "Press 1 for Physics to update on Runner thread");
draw_text(0, 64, "Press 2 for Physics to update on Separate thread");
draw_text(0, 80, string("Simulation: {0} took {1}s", SimulationThreadToString[simulation], string_format(last_update_took / 1000000, 1, 3)));