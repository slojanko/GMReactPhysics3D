DestroyPhysicsWorld(world);
vertex_delete_buffer(ground_model);
vertex_delete_buffer(box_model);
DestroyBoxShape(ground_shape);
DestroyBoxShape(box_shape);

if (surface_exists(depth_surface)) {
	surface_free(depth_surface);
}

event_inherited();