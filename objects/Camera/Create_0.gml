view_enabled = true;
view_set_visible(0, true);

base_speed = 1;
cx = -100;
cy = 0;
cz = 33;
cdir = 0;
cpitch = -10;

camera = camera_create();
view_set_camera(0, camera);

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_zfunc(cmpfunc_lessequal);
gpu_set_texrepeat(true);
gpu_set_cullmode(cull_noculling);

show_debug_overlay(true);
//window_set_size(1920, 1080);
//camera_set_view_size(camera, 1920, 1080);
//window_set_fullscreen(true);
//surface_resize(application_surface, 1920, 1080);
//view_set_wport(0, 1920);
//view_set_hport(0, 1080);
skip_once = true;

function RefreshMatrices() {
	viewMat = matrix_build_lookat(cx, cy, cz, cx + dcos(cdir), cy - dsin(cdir), cz + dtan(cpitch), 0, 0, 1);
	projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);
	
	camera_set_view_mat(camera, viewMat);
	camera_set_proj_mat(camera, projMat);
	camera_apply(camera);
}

function RefreshLight(shader) {
	lightViewMat = matrix_build_lookat(100, 100, 100, 0, 0, 0, 0, 0, 1);
	shader_set_uniform_matrix_array(shader_get_uniform(shader, "u_mLightViewProj"), lightViewMat);
}