gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
show_debug_overlay(true);

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

cube = model_build_cube(-1, -1, -1, 1, 1, 11);
raycast_cube = model_build_cube(-0.5, -0.5, -0.5, 0.5, 0.5, 0.5);

// Physics setup
shared_buffer = buffer_create(65536, buffer_fixed, 1);
//shared_array = array_create(65536)
//Init(buffer_get_address(shared_buffer));

world = CreatePhysicsWorld()
SetIterationsSolver(world, 5, 3);
ground_shape = CreateBoxShape(100, 100, 1);
ground = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetType(ground, BodyType.staticc);
AddCollider(ground, ground_shape);

cube_count = 4096;
box_shape = CreateBoxShape(1, 1, 1);
box_array =  array_create(cube_count, 0);
box_transforms = array_create(cube_count, 0);

for(var i = 0; i < cube_count; i++) {
	var dist = random_range(10, 60);
	var dir = 15 + i * 30;
	var height = 5 + i / 15;
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, 0);
	AddCollider(box, box_shape);
	box_array[i] = box;
}