DestroyPhysicsWorld(world);
vertex_delete_buffer(ground_model);
vertex_delete_buffer(box_model);
buffer_delete(town_data.vertex_buffer);
buffer_delete(town_data.index_buffer);
DestroyTriangleVertexArray(town_vertex_array);
DestroyTriangleMesh(town_mesh);
DestroyConcaveMeshShape(town_shape);
DestroyBoxShape(box_shape);

if (surface_exists(depth_surface)) {
	surface_free(depth_surface);
}

event_inherited();