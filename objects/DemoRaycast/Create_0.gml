event_inherited();

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);

ground_texture = sprite_get_texture(g987_spr, 0);
ground_model = import_obj("ground.obj");
ground_shape = CreateBoxShape(250, 250, 5);
ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

box_count = 256;
box_texture = sprite_get_texture(g1732_spr, 0);
box_model = import_obj("brick.obj");
box_shape = CreateBoxShape(2, 1, 0.5);
box_array = array_create(box_count);

buffer_seek(global.shared_buffer, buffer_seek_start, 0);
for(var i = 0; i < box_count; i++) {
	var dist = 6;
	var dir = (i % 8) * 45 + (floor(i / 8) % 2) * 22.5;
	var height = 5 + 0.5 + 1.0 * floor(i / 8);
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, degtorad(90 - dir));
	var collider = AddCollider(box, box_shape, 0, 0, 0, 0, 0, 0);
	SetColliderBounciness(collider, 0.1);
	box_array[i] = box;
	buffer_write(global.shared_buffer, buffer_u64, box);
}

GetTransformMatrixShared(box_count);
hit = { hit : false };

function draw_scene() {
	matrix_set(matrix_world, matrix_build(0, 0, 5, 0, 0, 0, 1, 1, 1));
	vertex_submit(ground_model, pr_trianglelist, ground_texture);

	for(var i = box_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, global.shared_array[i]);
		vertex_submit(box_model, pr_trianglelist, box_texture);
	}
	
	if (hit.hit) {
		matrix_set(matrix_world, matrix_build(hit.px, hit.py, hit.pz, 0, 0, 0, 1, 1, 1));
		vertex_submit(box_model, pr_trianglelist, sprite_get_texture(target_spr, 0));
	}
}