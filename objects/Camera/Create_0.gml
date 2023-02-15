view_enabled = true;
view_set_visible(0, true);

move_speed = 1;
cx = 0;
cy = 96;
cz = 25;
cdir = 0;
cpitch = 0;

camera = camera_create();
projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);
camera_set_proj_mat(camera, projMat);
view_set_camera(0, camera);

buffer = import_obj("text.obj");