gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

view_enabled = true;
view_set_visible(0, true);

zz = 50;
xx = 1;
yy = 50;

camera = camera_create();
projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);
camera_set_proj_mat(camera, projMat);
view_set_camera(0, camera);

mLookat = matrix_build_lookat(xx,yy,zz, 0, 0, 0 ,0, 0, 1);
camera_set_view_mat(view_camera[0], mLookat);

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
format = vertex_format_end();

vb_plane = model_build_cube(-1, -1, -1, 1, 1, 1, 1, 1);

world = CreatePhysicsWorld()
SetIterationsSolver(world, 5, 3);
ground_shape = CreateBoxShape(100, 100, 1);
ground = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetType(ground, BodyType.staticc);
AddCollider(ground, ground_shape);

box_shape = CreateBoxShape(1, 1, 1);
box_list = ds_list_create();
cube_count = 1024;

for(var i = 0; i < cube_count; i++) {
	var dist = random_range(10, 35);
	var dir = 15 + i * 30;
	var height = 5 + i / 15;
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, 0);
	AddCollider(box, box_shape);
	
	ds_list_add(box_list, box);
}