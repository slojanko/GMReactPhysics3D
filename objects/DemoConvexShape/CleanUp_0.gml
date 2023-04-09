DestroyPhysicsWorld(world);
vertex_delete_buffer(ground_model);
vertex_delete_buffer(teapot_model);
DestroyBoxShape(ground_shape);
DestroyPolygonFaceArray(teapot_face_array);
DestroyPolygonVertexArray(teapot_vertex_array);
DestroyPolyhedronMesh(teapot_mesh);
DestroyConvexMeshShape(teapot_shape);

if (surface_exists(depth_surface)) {
	surface_free(depth_surface);
}

event_inherited();