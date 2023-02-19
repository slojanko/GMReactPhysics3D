draw_text(0, 32, fps);
draw_text(0, 48, "Press 1 for Physics to update on Runner thread");
draw_text(0, 64, "Press 2 for Physics to update on Separate thread");
draw_text(0, 80, SimulationThreadToString[simulation]);
draw_text(0, 96, string_format(last_update_took / 1000000, 1, 3));