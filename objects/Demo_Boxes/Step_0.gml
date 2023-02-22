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
	var ray_direction =  convert_2d_to_3d_cam(Camera.camera, window_mouse_get_x(), window_get_height() - window_mouse_get_y());
	var hit = RaycastPhysicsWorld(world, Camera.cx, Camera.cy, Camera.cz, Camera.cx + ray_direction[0] * 1000, Camera.cy + ray_direction[1] * 1000, Camera.cz + ray_direction[2] * 1000);
		
	if (mouse_check_button(mb_left)) {
		PhysicsWorldApplyForceDecreasing(world, hit.px, hit.py, hit.pz, 2.0, 10.0, -100.0);
	} else if (mouse_check_button(mb_right)) {
		PhysicsWorldApplyForceDecreasing(world, hit.px, hit.py, hit.pz, 2.0, 10.0, 100.0);
	}
	
	last_start = get_timer();
	UpdatePhysicsWorld(world, delta_time / 1000000);
	GetTransformMatrixShared(box_count);
	last_update_took = get_timer() - last_start;
}