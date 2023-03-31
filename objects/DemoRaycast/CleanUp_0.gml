DestroyPhysicsWorld(world);
DestroyBoxShape(ground_shape);
vertex_delete_buffer(ground_model);
DestroyBoxShape(box_shape);
vertex_delete_buffer(box_model);

if (surface_exists(depth_surface)) {
	surface_free(depth_surface);
}

event_inherited();