enum BodyType {
	staticc = 0,
	kinematic = 1,
	dynamic = 2,
}

function model_build_cube(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	var x1 = argument0,
	    y1 = argument1,
	    z1 = argument2,
	    x2 = argument3,
	    y2 = argument4,
	    z2 = argument5,
	    hr = argument6,
	    vr = argument7,
	    vb = vertex_create_buffer();

	/* Prepare VBO */
	vertex_begin(vb, format);

	/* Top */
	vertex_default(vb, x1, y1, z2, 0, 0, 1, 0, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 0, 0, 1, hr, 0, c_white, 1);
	vertex_default(vb, x1, y2, z2, 0, 0, 1, 0, vr, c_white, 1);

	vertex_default(vb, x2, y1, z2, 0, 0, 1, hr, 0, c_white, 1);
	vertex_default(vb, x2, y2, z2, 0, 0, 1, hr, vr, c_white, 1);
	vertex_default(vb, x1, y2, z2, 0, 0, 1, 0, vr, c_white, 1);

	/* Bottom */
	vertex_default(vb, x1, y2, z1, 0, 0, -1, 0, vr, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, 0, -1, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z1, 0, 0, -1, 0, 0, c_white, 1);

	vertex_default(vb, x1, y2, z1, 0, 0, -1, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 0, -1, hr, vr, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, 0, -1, hr, 0, c_white, 1);

	/* Front */
	vertex_default(vb, x1, y2, z2, 0, 1, 0, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y2, z1, 0, 1, 0, 0, 0, c_white, 1);

	vertex_default(vb, x1, y2, z2, 0, 1, 0, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z2, 0, 1, 0, hr, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 1, 0, hr, 0, c_white, 1);

	/* Back */
	vertex_default(vb, x1, y1, z1, 0, -1, 0, 0, 0, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, -1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z2, 0, -1, 0, 0, vr, c_white, 1);

	vertex_default(vb, x2, y1, z1, 0, -1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 0, -1, 0, hr, vr, c_white, 1);
	vertex_default(vb, x1, y1, z2, 0, -1, 0, 0, vr, c_white, 1);

	/* Right */
	vertex_default(vb, x2, y1, z1, 1, 0, 0, 0, 0, c_white, 1);
	vertex_default(vb, x2, y2, z1, 1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 1, 0, 0, 0, vr, c_white, 1);

	vertex_default(vb, x2, y2, z1, 1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y2, z2, 1, 0, 0, hr, vr, c_white, 1);
	vertex_default(vb, x2, y1, z2, 1, 0, 0, 0, vr, c_white, 1);

	/* Left */
	vertex_default(vb, x1, y1, z2, -1, 0, 0, 0, vr, c_white, 1);
	vertex_default(vb, x1, y2, z1, -1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z1, -1, 0, 0, 0, 0, c_white, 1);

	vertex_default(vb, x1, y1, z2, -1, 0, 0, 0, vr, c_white, 1);
	vertex_default(vb, x1, y2, z2, -1, 0, 0, hr, vr, c_white, 1);
	vertex_default(vb, x1, y2, z1, -1, 0, 0, hr, 0, c_white, 1);

	/* Finalize VBO */
	vertex_end(vb);
	vertex_freeze(vb);

	return vb;
}

function vertex_default(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {
	gml_pragma("forceinline");

	vertex_position_3d(argument0, argument1, argument2, argument3);
	vertex_texcoord(argument0, argument7, argument8);
	vertex_colour(argument0, argument9, argument10);
}

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