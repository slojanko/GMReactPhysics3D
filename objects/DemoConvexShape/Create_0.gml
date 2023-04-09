event_inherited();

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);

ground_texture = sprite_get_texture(g987_spr, 0);
box_texture = sprite_get_texture(g1732_spr, 0);

ground_model = import_obj("ground.obj");
box_model = import_obj("brick_collision.obj");

ground_shape = CreateBoxShape(250, 250, 5);
box_data = import_obj_collision("brick_collision.obj");
box_face_array = CreatePolygonFaceArray(box_data.face_count, box_data.vertices_per_face);
box_vertex_array = CreatePolygonVertexArray(box_data.vertex_count, buffer_get_address(box_data.vertex_buffer), buffer_get_address(box_data.index_buffer), 
box_data.face_count, box_face_array, VertexDataType.VERTEX_DOUBLE_TYPE, IndexDataType.INDEX_INTEGER_TYPE);
box_mesh = CreatePolyhedronMesh(box_vertex_array);
box_shape = CreateConvexMeshShape(box_mesh);

ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

box_count = 512;
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

function draw_scene() {
	matrix_set(matrix_world, matrix_build(0, 0, 5, 0, 0, 0, 1, 1, 1));
	vertex_submit(ground_model, pr_trianglelist, ground_texture);

	for(var i = box_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, global.shared_array[i]);
		vertex_submit(box_model, pr_trianglelist, box_texture);
	}
}