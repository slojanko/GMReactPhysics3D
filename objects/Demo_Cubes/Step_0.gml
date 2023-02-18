if (mouse_check_button_pressed(mb_left)) {
	started = true;	
}

if (started) {
	UpdatePhysicsWorld(world, delta_time / 1000000);
}