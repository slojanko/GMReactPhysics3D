var last_update_took = get_timer() - update_start_time;

for(var i = 0; i < cube_count; i++) {
	box_transforms[i] = GetTransform(box_array[i]);
}

UpdatePhysicsWorldAsync(world, last_update_took / 1000000);
update_start_time = get_timer();
updated_once = true;