if (queued_destroy) {
	instance_destroy(self);
	return;
}

last_update_start = get_timer();
UpdatePhysicsWorld(world, delta_time_seconds);
GetTransformMatrixShared(teapot_count);
last_update_took = get_timer() - last_update_start;