//draw_surface_ext(color_surface, 0, 0, 0.5, 0.5, 0.0, c_white, 1.0);
//draw_surface_ext(world_pos_surface, window_get_width() / 2, 0, 0.5, 0.5, 0.0, c_white, 1.0);
//draw_surface_ext(norm_surface, 0, window_get_height() / 2, 0.5, 0.5, 0.0, c_white, 1.0);
//draw_surface_ext(depth_surface, window_get_width() / 2, window_get_height() / 2, 0.5, 0.5, 0.0, c_white, 1.0);

//var sampler;
//shader_set(deferred_combine_shd);

//sampler = shader_get_sampler_index(deferred_combine_shd, "s_WorldPos")
//texture_set_stage(sampler, surface_get_texture(world_pos_surface));
//sampler = shader_get_sampler_index(deferred_combine_shd, "s_Norm")
//texture_set_stage(sampler, surface_get_texture(norm_surface));
//sampler = shader_get_sampler_index(deferred_combine_shd, "s_Depth")
//texture_set_stage(sampler, surface_get_texture(depth_surface));

//Camera.RefreshLight(deferred_combine_shd);
//draw_surface_ext(color_surface, 0, 0, 0.5, 0.5, 0.0, c_white, 1.0);
//shader_reset();

draw_text(0, 32, fps);
draw_text(0, 48, "Press 1 for Physics to update on Runner thread");
draw_text(0, 64, "Press 2 for Physics to update on Async thread");
draw_text(0, 80, string("Simulation: {0} took {1}s", SimulationThreadToString[simulation], string_format(last_update_took / 1000000, 1, 3)));