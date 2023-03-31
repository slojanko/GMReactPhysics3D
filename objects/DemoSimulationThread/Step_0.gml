if (simulation != SimulationThread.ASYNC) {
	if (queued_destroy) {
		instance_destroy(self);
		return;
	}
}

if (keyboard_check_pressed(ord("1"))) {
	queued_simulation = SimulationThread.NONE;
}

if (keyboard_check_pressed(ord("2"))) {
	queued_simulation = SimulationThread.RUNNER;
}
	
if (keyboard_check_pressed(ord("3"))) {
	queued_simulation = SimulationThread.ASYNC;	
}

if (queued_simulation != simulation) {
	if (simulation != SimulationThread.ASYNC) {
		simulation = queued_simulation;	
		if (simulation == SimulationThread.ASYNC) {
			last_update_start = get_timer();
			UpdatePhysicsWorldAsync(world, 1 / 60);
		}
	}
}

if (simulation == SimulationThread.RUNNER) {	
	last_update_start = get_timer();
	UpdatePhysicsWorld(world, delta_time / 1000000);
	GetTransformMatrixShared(box_count);
	last_update_took = get_timer() - last_update_start;
}