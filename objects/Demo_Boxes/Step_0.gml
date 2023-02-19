if (simulation == SimulationThread.NONE) {
	if (keyboard_check_pressed(ord("1"))) {
		simulation = SimulationThread.RUNNER;
		updated_once = true;
	}
	
	if (keyboard_check_pressed(ord("2"))) {
		simulation = SimulationThread.SEPARATE;	
		last_start = get_timer();
		UpdatePhysicsWorldAsync(world, 1 / 60);
	}
}

if (simulation == SimulationThread.RUNNER) {
	UpdatePhysicsWorld(world, delta_time / 1000000);
	GetTransformMatrixShared(box_count);
}