event_inherited();

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);

ground_texture = sprite_get_texture(Mulan, 0);
box_texture = sprite_get_texture(g1732_spr, 0);

ground_model = import_obj("town.obj");
box_model = import_obj("brick.obj");

town_data = import_obj_collision("town_collision.obj");
town_vertex_array = CreateTriangleVertexArray(town_data.vertex_count, buffer_get_address(town_data.vertex_buffer), town_data.face_count, 
buffer_get_address(town_data.index_buffer), VertexDataType.VERTEX_DOUBLE_TYPE, IndexDataType.INDEX_INTEGER_TYPE);
town_mesh = CreateTriangleMesh();
AddTriangleMeshSubpart(town_mesh, town_vertex_array);
town_shape = CreateConcaveMeshShape(town_mesh);
box_shape = CreateBoxShape(2, 1, 0.5);

ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
AddCollider(ground_body, town_shape, 0, 0, 0, 0, 0, 0);

box_count = 512 + 256;
box_array = array_create(box_count);

buffer_seek(global.shared_buffer, buffer_seek_start, 0);
for(var i = 0; i < box_count; i++) {
	var dist = 22;
	var dir = (i % 8) * 45 + (floor(i / 8) % 2) * 22.5;
	var height = 25 + 0.5 + 1.0 * floor(i / 8);
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, degtorad(90 - dir));
	var collider = AddCollider(box, box_shape, 0, 0, 0, 0, 0, 0);
	SetColliderBounciness(collider, 0.1);
	box_array[i] = box;
	buffer_write(global.shared_buffer, buffer_u64, box);
}

GetTransformMatrixShared(box_count);

function draw_scene() {
	matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));
	vertex_submit(ground_model, pr_trianglelist, ground_texture);

	for(var i = box_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, global.shared_array[i]);
		vertex_submit(box_model, pr_trianglelist, box_texture);
	}
}