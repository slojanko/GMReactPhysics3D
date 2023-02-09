gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
show_debug_overlay(true);

view_enabled = true;
view_set_visible(0, true);

cx = 1;
cy = 80;
cz = 25;
cdir = 90;
cpitch = 0;

camera = camera_create();
projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);
camera_set_proj_mat(camera, projMat);
view_set_camera(0, camera);

box_model = model_build_cube(-1, -1, -1, 1, 1, 1);
raycast_model = model_build_cube(-0.5, -0.5, -0.5, 0.5, 0.5, 0.5);

// Physics setup
shared_buffer = buffer_create(65536, buffer_fixed, 1);
//shared_array = array_create(65536)
Init(buffer_get_address(shared_buffer));

world = CreatePhysicsWorld();
SetPhysicsWorldIterationsSolver(world, 5, 3);

var ground_surface = surface_create(128, 128);
surface_set_target(ground_surface);
draw_sprite(heightmap_spr, 0, 0, 0);
surface_reset_target();

ground_model = vertex_create_buffer();
vertex_begin(ground_model, global.format);
ground_buffer = buffer_create(128 * 128 * 4, buffer_fixed, 4);
buffer_seek(ground_buffer, buffer_seek_start, 0);
for(var xx = 0; xx < 128; xx++) {
	for(var yy = 0; yy < 128; yy++) {
		var h1 = color_get_blue(surface_getpixel(ground_surface, xx, yy)) * 0.1;
		buffer_write(ground_buffer, buffer_f64, h1);
		
		if (xx < 127 && yy < 127) {
			var h2 = color_get_blue(surface_getpixel(ground_surface, xx + 1, yy)) * 0.1;
			var h3 = color_get_blue(surface_getpixel(ground_surface, xx, yy + 1)) * 0.1;
			var h4 = color_get_blue(surface_getpixel(ground_surface, xx + 1, yy + 1)) * 0.1;
			
			vertex_default(ground_model, xx, yy, h1, 0, 0, c_white, 1);
			vertex_default(ground_model, xx + 1 , yy, h2, 1, 0, c_white, 1);
			vertex_default(ground_model, xx, yy + 1, h3, 0, 1, c_white, 1);

			vertex_default(ground_model, xx + 1 , yy, h2, 1, 0, c_white, 1);
			vertex_default(ground_model, xx + 1 , yy + 1, h4, 1, 1, c_white, 1);
			vertex_default(ground_model, xx, yy + 1, h3, 0, 1, c_white, 1);
		}
	}
}

vertex_end(ground_model);
vertex_freeze(ground_model);
	
surface_free(ground_surface);

ground_shape = CreateHeightFieldShape(128, 128, 0, 255 * 0.1, buffer_get_address(ground_buffer), HeightDataType.HEIGHT_DOUBLE_TYPE);
ground_texture = sprite_get_texture(ground_spr, 0);
ground = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground, BodyType.STATIC);
AddCollider(ground, ground_shape, 0, 0, 0, 0, 0, 0);

cube_count = 128;
box_shape = CreateBoxShape(1, 1, 1);
box_texture = sprite_get_texture(box_spr, 0)
box_array =  array_create(cube_count, 0);

for(var i = 0; i < cube_count; i++) {
	var dist = random_range(10, 60);
	var dir = 15 + i * 30;
	var height = 5 + i / 15;
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, 0);
	AddCollider(box, box_shape, 0, 0, 0, 0, 0, 0);
	box_array[i] = box;
}