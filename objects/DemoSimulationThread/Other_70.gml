if (queued_simulation != simulation) {
	simulation = queued_simulation;	
	UpdatePhysicsWorldAsyncFinish();
	GetTransformMatrixShared(box_count);

	last_update_took = get_timer() - last_update_start;
	last_update_start = get_timer();
	return;
}

if (simulation == SimulationThread.ASYNC) {
	UpdatePhysicsWorldAsyncFinish();
	GetTransformMatrixShared(box_count);

	last_update_took = get_timer() - last_update_start;
	last_update_start = get_timer();
	
	UpdatePhysicsWorldAsync(world, last_update_took / 1000000);
}