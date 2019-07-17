local G_buf = {}

function write_file(dir, tar, buf)
	print("Making " .. tar .. "...")
	out_fp = io.open(dir .. "/" .. tar, "w+b")
	out_fp:write(buf)
	out_fp:close()
end

function get_bytes_from_str(str, order)
	local bytes
	if order == 8 then
		bytes = 
		        (string.byte(str, 1, 1) << 56) +
		        (string.byte(str, 2, 2) << 48) +
		        (string.byte(str, 3, 3) << 40) +
		        (string.byte(str, 4, 4) << 32) +
		        (string.byte(str, 5, 5) << 24) +
		        (string.byte(str, 6, 6) << 16) +
		        (string.byte(str, 7, 7) <<  8) +
		        (string.byte(str, 8, 8) <<  0)
	elseif order == 4 then
		bytes = 
		        (string.byte(str, 1, 1) << 24) +
		        (string.byte(str, 2, 2) << 16) +
		        (string.byte(str, 3, 3) <<  8) +
		        (string.byte(str, 4, 4) <<  0)
	elseif order == 2 then
		bytes = 
		        (string.byte(str, 1, 1) <<  8) +
		        (string.byte(str, 2, 2) <<  0)
	elseif order == 1 then
		bytes = 
		        (string.byte(str, 1, 1) <<  0)
	else
	end
	
	return bytes
end

function extract()
	local offset_table_offset_size
	local object_ref_size
	local num_objects
--	local top_object_offset
	local offset_table_start
	
	local obj_ptr
	local marker
	local size
	local element_num
	local link_name
	local link_contents
	local dic
	
	offset_table_offset_size = get_bytes_from_str(string.sub(G_buf.str, string.len(G_buf.str) - 0x19), 1)
	object_ref_size          = get_bytes_from_str(string.sub(G_buf.str, string.len(G_buf.str) - 0x18), 1)
	num_objects              = get_bytes_from_str(string.sub(G_buf.str, string.len(G_buf.str) - 0x17), 8)
--	top_object_offset        = get_bytes_from_str(string.sub(G_buf.str, string.len(G_buf.str) - 0x0F), 8)
	offset_table_start       = get_bytes_from_str(string.sub(G_buf.str, string.len(G_buf.str) - 0x07), 8)
	
	for i = 1, num_objects do
		obj_ptr = get_bytes_from_str(string.sub(G_buf.str, offset_table_start + (offset_table_offset_size * (i - 1)) + 1, offset_table_start + (offset_table_offset_size * (i - 1)) + 1 + offset_table_offset_size), offset_table_offset_size)
		marker = string.byte(G_buf.str, obj_ptr + 1, obj_ptr + 1)
		if ((marker & 0xF0) == 0x40) or ((marker & 0xF0) == 0x50) then
			G_buf[i] = {}
			if ((marker & 0x0F) ~= 0x0F) then
				size = (marker & 0x0F)
				G_buf[i].obj = string.sub(G_buf.str, obj_ptr + 1 + 1, obj_ptr + 1 + 1 + size - 1)
			else
				size = get_bytes_from_str(string.sub(G_buf.str, obj_ptr + 1 + 2, obj_ptr + 1 + 2 + object_ref_size), object_ref_size)
				G_buf[i].obj = string.sub(G_buf.str, obj_ptr + 1 + 2 + object_ref_size, obj_ptr + 1 + 2 + object_ref_size + size - 1)
			end
		-- dictionary
		elseif ((marker & 0xF0) == 0xD0) then
			if ((marker & 0x0F) ~= 0x0F) then
				element_num = (marker & 0x0F)
				size = element_num * 4 * 2
				dic  = string.sub(G_buf.str, obj_ptr + 1 + 1, obj_ptr + 1 + 1 + size - 1)
			else
				element_num = get_bytes_from_str(string.sub(G_buf.str, obj_ptr + 1 + 2, obj_ptr + 1 + 2 + object_ref_size), object_ref_size)
				size = element_num * 4 * 2
				dic  = string.sub(G_buf.str, obj_ptr + 1 + 2 + object_ref_size, obj_ptr + 1 + 2 + object_ref_size + size - 1)
			end
		else
			print("ERROR not supported marker" .. string.format(":0x%02X", marker))
		end
	end
	
	for i = 1, element_num do
		link_name     = get_bytes_from_str(string.sub(dic,                   (4 * (i - 1) + 1),                   (4 * (i - 1) + 1) + 4), 4)
		link_contents = get_bytes_from_str(string.sub(dic, element_num * 4 + (4 * (i - 1) + 1), element_num * 4 + (4 * (i - 1) + 1) + 4), 4)
		write_file(G_buf.dir, G_buf[link_name + 1].obj, G_buf[link_contents + 1].obj)
	end
end

function make_dir()
	print("Making " .. G_buf.dir .. " directory...")
	os.execute("mkdir " .. G_buf.dir)
end

function load_src()
	local src_fp
	local src_size
	
	local ret = false
	
	print("Loading " .. arg[1] .. "...")
	src_fp = io.open(arg[1], "rb")
	if src_fp == nil then
		print("ERROR can not open:" .. arg[1])
		os.exit()
	end
	src_size = src_fp:seek("end")
	src_fp:seek("set")
	G_buf.str = src_fp:read(src_size)
	src_fp:close()
	
	-- magic
	if "bplist00" ~= string.sub(G_buf.str, 1, 8) then
		print("ERROR specify *.mbundle")
		os.exit()
	end
	G_buf.file = arg[1]
	G_buf.dir = string.sub(G_buf.file, 1, string.find(G_buf.file, ".mbundle") - 1)
end

function arg_chek()
	if #arg < 1 then
		print("usage:extract_mbundle.lua [*.mbundle]")
		os.exit()
	end
end

-- main
arg_chek()
load_src()
make_dir()
extract()
