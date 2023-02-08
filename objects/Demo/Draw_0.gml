//if (updated_once == false) {
//	return;
//}

for(var i = 0; i < cube_count; i++) {
	matrix_set(matrix_world, GetTransform(box_array[i]));
	vertex_submit(cube, pr_trianglelist, sprite_get_texture(crate_spr, 0));
}

//var ray_direction =  convert_2d_to_3d_cam(camera, window_mouse_get_x(), window_get_height() - window_mouse_get_y());
//ray = RaycastPhysicsWorld(world, xx, yy, zz, xx + ray_direction[0] * 1000, yy + ray_direction[1] * 1000, zz + ray_direction[2] * 1000);

//matrix_set(matrix_world, matrix_build(ray.x - ray_direction[0], ray.y - ray_direction[1], ray.z - ray_direction[2], ray.nx, ray.ny, ray.nz, 1, 1, 1));
//vertex_submit(raycast_cube, pr_trianglelist, sprite_get_texture(target_spr, 0));

matrix_set(matrix_world, matrix_build_identity());