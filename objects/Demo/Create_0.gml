gpu_set_zwriteenable(true);//Enables writing to the z-buffer
gpu_set_ztestenable(true);//Enables the depth testing, so far away things are drawn beind closer things
//show_debug_overlay(true);

//First, we need to enable views and make our view visible (in this case, view 0)
view_enabled = true;//Enable the use of views
view_set_visible(0, true);//Make this view visible

//First, create the camera. We could use camera_create_view, but that is more useful in a 2D environment
camera = camera_create();

//Then, we need to build a projection matrix. I keep this in instance scope in case I need to reassign it later. (Though you can retrieve matrices from a camera with camera_get functions
//I use matrix_build_projection_perspective_fov, as it gives the most control over how your projections looks.
//Here's how I use the arguments: I give a 60 degree vertical field of view, with a ratio of view_wport/view_hport, with a 32 unit near clipping plane, and a 32000 far clipping plane. Some of these values may need tweaking to your liking.
projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);

//Now we assign the projection matrix to the camera
camera_set_proj_mat(camera, projMat);

//Finally, we bind the camera to the view
view_set_camera(0, camera);

//Set up camera location
zz = 50;
xx = 1;
yy = 50;

//Build a matrix that looks from the camera location above, to the room center. The up vector points to -z
mLookat = matrix_build_lookat(xx,yy,zz, 0, 0, 0 ,0, 0, 1);

//Assign the matrix to the camera. This updates were the camera is looking from, without having to unnecessarily update the projection.
camera_set_view_mat(view_camera[0], mLookat);

//Begin defining a format
vertex_format_begin();

vertex_format_add_position_3d();//Add 3D position info
vertex_format_add_color();//Add color info
vertex_format_add_texcoord();//Texture coordinate info

//End building the format, and assign the format to the variable "format"
format = vertex_format_end();

//Create the vertex buffer. Another function, vetex_create_buffer_ext can be used to create the buffer with its size predefined and fixed.
//With the standard vertex_create_buffer, the buffer will just grow automatically as needed.
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