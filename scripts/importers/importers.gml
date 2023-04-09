function import_obj(filename) {
	var file = file_text_open_read(filename);
	var position = ds_list_create();
	var texture = ds_list_create();
	var normal = ds_list_create();
	//var color = ds_list_create();
	
	var buffer = vertex_create_buffer();
	vertex_begin(buffer, global.format);
	while (!file_text_eof(file))
	{
	    var line = file_text_readln(file);
		var tokens = string_split(line, " ", true);
		if(tokens[0] == "v") {
			ds_list_add(position, real(tokens[1]), -real(tokens[2]), real(tokens[3]));
		} else if (tokens[0] == "vt") {
			ds_list_add(texture, real(tokens[1]), 1.0 - real(tokens[2]));
		} else if (tokens[0] == "vn") {
			ds_list_add(normal, real(tokens[1]), -real(tokens[2]), real(tokens[3]));
		} else if (tokens[0] == "f") {
			var first = string_split(tokens[1], "/", true);
			var second = string_split(tokens[2], "/", true);
			var third = string_split(tokens[3], "/", true);
			
			var v, t, n;
			v = 3 * (real(first[0]) - 1);
			t = 2 * (real(first[1]) - 1);
			n = 3 * (real(first[2]) - 1);
			vertex_add(buffer, position[| v], position[| v + 1], position[| v + 2], texture[| t], texture[| t + 1], normal[| n], normal[| n + 1], normal[| n + 2]);
			
			v = 3 * (real(second[0]) - 1);
			t = 2 * (real(second[1]) - 1);
			n = 3 * (real(second[2]) - 1);
			vertex_add(buffer, position[| v], position[| v + 1], position[| v + 2], texture[| t], texture[| t + 1], normal[| n], normal[| n + 1], normal[| n + 2]);
			
			v = 3 * (real(third[0]) - 1);
			t = 2 * (real(third[1]) - 1);
			n = 3 * (real(third[2]) - 1);
			vertex_add(buffer, position[| v], position[| v + 1], position[| v + 2], texture[| t], texture[| t + 1], normal[| n], normal[| n + 1], normal[| n + 2]);
		}
	}
	
	file_text_close(file);
	ds_list_destroy(position);
	ds_list_destroy(texture);
	ds_list_destroy(normal);
	vertex_end(buffer);
	vertex_freeze(buffer);
	return buffer;
}

function import_obj_collision(filename/*, vertex_type, index_type*/) {
	var file = file_text_open_read(filename);
	var position = ds_list_create();
	var index = ds_list_create();
	
	while (!file_text_eof(file))
	{
	    var line = file_text_readln(file);
		var tokens = string_split(line, " ", true);
		if(tokens[0] == "v") {
			ds_list_add(position, real(tokens[1]), -real(tokens[2]), real(tokens[3]));
		} else if (tokens[0] == "f") {
			var first = string_split(tokens[1], "/", true);
			var second = string_split(tokens[2], "/", true);
			var third = string_split(tokens[3], "/", true);
			//var fourth = string_split(tokens[4], "/", true);
			ds_list_add(index, real(first[0]) - 1, real(third[0]) - 1, real(second[0]) - 1);
			//ds_list_add(index, real(second[0]) - 1, real(first[0]) - 1, real(fourth[0]) - 1, real(third[0]) - 1);
		}
	}
	
	var vertex_buffer = buffer_create(65536, buffer_fixed, 1);
	var index_buffer = buffer_create(65536, buffer_fixed, 1);
	
	var count = ds_list_size(position);
	for(var i = 0; i < count; i++) {
		buffer_write(vertex_buffer, buffer_f64, position[| i]);
	}
	
	count = ds_list_size(index);
	for(var i = 0; i < count; i++) {
		buffer_write(index_buffer, buffer_u32, index[| i]);
	}
	
	var result = { 
		vertex_buffer : vertex_buffer, 
		index_buffer : index_buffer,
		vertex_count : ds_list_size(position) / 3, 
		face_count : ds_list_size(index) / 3,
		vertices_per_face : 3,
	};
	
	file_text_close(file);
	ds_list_destroy(position);
	ds_list_destroy(index);
	return result;
}

function vertex_add(buffer, px, py, pz, tx, ty, nx, ny, nz) {
	gml_pragma("forceinline");

	vertex_position_3d(buffer, px, py, pz);
	vertex_texcoord(buffer, tx, ty);
	vertex_normal(buffer, nx, ny, nz);
}