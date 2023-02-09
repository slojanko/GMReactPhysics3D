var mLookat = matrix_build_lookat(cx, cy, cz, cx + dcos(cdir), cy - dsin(cdir), cz + dsin(cpitch), 0, 0, 1);
camera_set_view_mat(camera, mLookat);
camera_apply(camera);

matrix_set(matrix_world, matrix_build(-64, -64, -255 * 0.1 * 0.5, 0, 0, 0, 1, 1, 1));
vertex_submit(ground_model, pr_trianglelist, ground_texture);

for(var i = 0; i < cube_count; i++) {
	matrix_set(matrix_world, GetTransform(box_array[i]));
	vertex_submit(box_model, pr_trianglelist, box_texture);
}

var ray_direction =  convert_2d_to_3d_cam(camera, window_mouse_get_x(), window_get_height() - window_mouse_get_y());
ray = RaycastPhysicsWorld(world, cx, cy, cz, cx + ray_direction[0] * 1000, cy + ray_direction[1] * 1000, cz + ray_direction[2] * 1000);

matrix_set(matrix_world, matrix_build(ray.x - ray_direction[0], ray.y - ray_direction[1], ray.z - ray_direction[2], 0, 0, 0, 1, 1, 1));
vertex_submit(raycast_model, pr_trianglelist, sprite_get_texture(target_spr, 0));

matrix_set(matrix_world, matrix_build_identity());