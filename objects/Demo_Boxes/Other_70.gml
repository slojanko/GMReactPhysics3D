if (simulation == SimulationThread.SEPARATE) {
	UpdatePhysicsWorldAsyncFinish();
	
	GetTransformMatrixShared(box_count);

	last_update_took = get_timer() - last_start;
	last_start = get_timer();
	updated_once = true;
	
	UpdatePhysicsWorldAsync(world, last_update_took / 1000000);
}