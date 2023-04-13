if (queued_destroy) {
	instance_destroy(self);
	return;
}

last_update_start = get_timer();
UpdatePhysicsWorld(world, delta_time_seconds);
GetTransformMatrixShared(box_count);
last_update_took = get_timer() - last_update_start;

var ray_direction =  convert_2d_to_3d_cam(Camera.camera, window_mouse_get_x(), window_get_height() - window_mouse_get_y());
hit = RaycastPhysicsWorld(world, Camera.cx, Camera.cy, Camera.cz, Camera.cx + ray_direction[0] * 1000, Camera.cy + ray_direction[1] * 1000, Camera.cz + ray_direction[2] * 1000);
