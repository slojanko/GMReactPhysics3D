if (queued_destroy) {
	instance_destroy(self);
	return;
}

last_update_start = get_timer();
UpdatePhysicsWorld(world, simulation_speed * delta_time / 1000000);
GetTransformMatrixShared(box_count);
last_update_took = get_timer() - last_update_start;

simulation_speed = clamp(simulation_speed + (mouse_wheel_up() - mouse_wheel_down()) * 0.1, 0.1, 2.5);