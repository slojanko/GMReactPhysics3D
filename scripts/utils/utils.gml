#macro log show_debug_message

function random_rgb(min_value, max_value) {
	return make_color_rgb(irandom_range(min_value, max_value), irandom_range(min_value, max_value), irandom_range(min_value, max_value));
}

function random_greyscale_rgb(min_value, max_value) {
	var greyscale = irandom_range(min_value, max_value);
	return make_color_rgb(greyscale, greyscale, greyscale);
}

//function model_build_cube(x1, y1, z1, x2, y2, z2) {
//	var buffer = vertex_create_buffer();
//	vertex_begin(buffer, global.format);

//	/* Top */
//	vertex_default(buffer, x1, y1, z2, 0, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z2, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z2, 0, 1, random_rgb(170, 255), 1);

//	vertex_default(buffer, x2, y1, z2, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z2, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z2, 0, 1, random_rgb(170, 255), 1);

//	/* Bottom */
//	vertex_default(buffer, x1, y2, z1, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y1, z1, 0, 0, random_rgb(170, 255), 1);

//	vertex_default(buffer, x1, y2, z1, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z1, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z1, 1, 0, random_rgb(170, 255), 1);

//	/* Front */
//	vertex_default(buffer, x1, y2, z2, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z1, 0, 0, random_rgb(170, 255), 1);

//	vertex_default(buffer, x1, y2, z2, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z2, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z1, 1, 0, random_rgb(170, 255), 1);

//	/* Back */
//	vertex_default(buffer, x1, y1, z1, 0, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y1, z2, 0, 1, random_rgb(170, 255), 1);

//	vertex_default(buffer, x2, y1, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z2, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y1, z2, 0, 1, random_rgb(170, 255), 1);

//	/* Right */
//	vertex_default(buffer, x2, y1, z1, 0, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z2, 0, 1, random_rgb(170, 255), 1);

//	vertex_default(buffer, x2, y2, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y2, z2, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x2, y1, z2, 0, 1, random_rgb(170, 255), 1);

//	/* Left */
//	vertex_default(buffer, x1, y1, z2, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z1, 1, 0, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y1, z1, 0, 0, random_rgb(170, 255), 1);

//	vertex_default(buffer, x1, y1, z2, 0, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z2, 1, 1, random_rgb(170, 255), 1);
//	vertex_default(buffer, x1, y2, z1, 1, 0, random_rgb(170, 255), 1);

//	vertex_end(buffer);
//	vertex_freeze(buffer);

//	return buffer;
//}

//function vertex_default(buffer, px, py, pz, tx, ty, c, a) {
//	gml_pragma("forceinline");

//	vertex_position_3d(buffer, px, py, pz);
//	vertex_texcoord(buffer, tx, ty);
//	// vertex_colour(buffer, c, a);
//}

function convert_2d_to_3d_cam(camera, _x, _y)
{
    /*
    Transforms a 2D coordinate (in window space) to a 3D vector.
    Returns an array of the following format:
    [dx, dy, dz, ox, oy, oz]
    where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.
    Works for both orthographic and perspective projections.
    Script created by TheSnidr
    */
    var V = camera_get_view_mat(camera);
    var P = camera_get_proj_mat(camera);
    var mx = 2 * (_x / window_get_width()  - .5) / P[0];
    var my = 2 * (_y / window_get_height() - .5) / P[5];
    var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
    var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
    var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);
    if (P[15] == 0)
    {    //This is a perspective projection
        return [V[2]  + mx * V[0] + my * V[1],
                V[6]  + mx * V[4] + my * V[5],
                V[10] + mx * V[8] + my * V[9],
                camX,
                camY,
                camZ];
    }
    else
    {    //This is an ortho projection
        return [V[2],
                V[6],
                V[10],
                camX + mx * V[0] + my * V[1],
                camY + mx * V[4] + my * V[5],
                camZ + mx * V[8] + my * V[9]];
    }
}