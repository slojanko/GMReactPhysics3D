event_inherited();

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);

ground_texture = sprite_get_texture(g987_spr, 0);
teapot_texture = sprite_get_texture(g1732_spr, 0);

ground_model = import_obj("ground.obj");
teapot_model = import_obj("teapot.obj");

ground_shape = CreateBoxShape(250, 250, 5);
teapot_data = import_obj_collision("teapot_collision.obj");
teapot_face_array = CreatePolygonFaceArray(teapot_data.face_count, teapot_data.vertices_per_face);
teapot_vertex_array = CreatePolygonVertexArray(teapot_data.vertex_count, buffer_get_address(teapot_data.vertex_buffer), buffer_get_address(teapot_data.index_buffer), 
teapot_data.face_count, teapot_face_array, VertexDataType.VERTEX_DOUBLE_TYPE, IndexDataType.INDEX_INTEGER_TYPE);
teapot_mesh = CreatePolyhedronMesh(teapot_vertex_array);
teapot_shape = CreateConvexMeshShape(teapot_mesh);

ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

teapot_count = 384;
teapot_array = array_create(teapot_count);

buffer_seek(global.shared_buffer, buffer_seek_start, 0);
for(var i = 0; i < teapot_count; i++) {
	var dist = 6;
	var dir = (i % 8) * 45 + (floor(i / 8) % 2) * 22.5;
	var height = 5 + 0.5 + 1.0 * floor(i / 8);
	var teapot = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, degtorad(90 - dir));
	var collider = AddCollider(teapot, teapot_shape, 0, 0, 0, 0, 0, 0);
	SetColliderBounciness(collider, 0.1);
	teapot_array[i] = teapot;
	buffer_write(global.shared_buffer, buffer_u64, teapot);
}

GetTransformMatrixShared(teapot_count);

function draw_scene() {
	matrix_set(matrix_world, matrix_build(0, 0, 5, 0, 0, 0, 1, 1, 1));
	vertex_submit(ground_model, pr_trianglelist, ground_texture);

	for(var i = teapot_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, global.shared_array[i]);
		vertex_submit(teapot_model, pr_trianglelist, teapot_texture);
	}
}