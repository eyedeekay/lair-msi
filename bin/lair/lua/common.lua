math.randomseed(os.time())

function get_tag_count(variable)
        if type(variable) == "table" then
                return variable.c
        else
                return 0
        end
end

function get_tag_table(variable)
        if type(variable) == "table" then
                return variable
        else
                return 0
        end
end

function where_in_floor_get_x()
        return tonumber(generator_coarse_x.x) + tonumber(room_coarse_x.x)
end

function where_in_floor_get_y()
        return tonumber(generator_coarse_y.y) + tonumber(room_coarse_y.y)
end

function where_in_room_gen_x()
        return generator_coarse_x.x
end
function where_in_room_gen_y()
        return generator_coarse_y.y
end
function how_long_room_gen_w()
        return generator_coarse_w.w
end
function how_long_room_gen_h()
        return generator_coarse_h.h
end
function what_pixel_is_gen_x()
        return generator_x.x
end
function what_pixel_is_gen_y()
        return generator_y.y
end
function where_is_room_corner_x()
        return room_coarse_x.x
end
function where_is_room_corner_y()
        return room_coarse_y.y
end
function where_is_room_farcorner_x()
        return room_coarse_xw.x
end
function where_is_floor_farcorner_x()
        return floor_coarse_h.h
end
function where_is_floor_farcorner_y()
        return floor_coarse_w.w
end
function where_is_room_farcorner_y()
        return room_coarse_yh.y
end
function what_pixel_is_room_corner_x()
        return room_x.x
end
function what_pixel_is_room_corner_y()
        return room_y.y
end
function what_pixel_is_room_farcorner_x()
        return room_xw.x
end
function what_pixel_is_room_farcorner_y()
        return room_yh.y
end
function what_pixel_is_floor_farcorner_x()
        return floor_h.h
end
function what_pixel_is_floor_farcorner_y()
        return floor_w.w
end
function how_long_room_pixels_w()
        return generator_w.w
end
function how_long_room_pixels_h()
        return generator_h.h
end
function how_many_particles_so_far()
        return generator_particle_count.c
end
function how_many_mobiles_so_far()
        return generator_mobile_count.c
end
function get_map_savepath()
        local home = os.getenv("HOME")
        local map = home .. "/.config/lair/map_table.lua"
        return map
end
function get_mob_savepath()
        local home = os.getenv("HOME")
        local map = home .. "/.config/lair/mob_table.lua"
        return map
end
function get_map_archivepath()
        local home = os.getenv("HOME")
        local time = os.time()
        local map = home .. "/.config/lair/map_table-" .. time .. ".lua"
        return map
end
function get_mob_archivepath()
        local home = os.getenv("HOME")
        local time = os.time()
        local map = home .. "/.config/lair/mob_table-" .. time .. ".lua"
        return map
end
function file_exists(name)
        local f=io.open(name,"r")
        if f~=nil then io.close(f) return true else return false end
end

function reload_map()
        if file_exists(get_map_savepath()) then
                dofile(get_map_savepath())
        end
end
function reload_mobs()
        if file_exists(get_mob_savepath()) then
                dofile(get_mob_savepath())
        end
end
function stringup_cell(variable)
        local member = tostring(variable)
        local table = "cell"
        local key = tostring(what_pixel_is_gen_x()) .. "_" .. tostring(what_pixel_is_gen_y())
        local command = table .. "[\"" .. key .. "\"] = \"" .. member .. "\"\n"
        return command
end
function archive_old_map()
        if file_exists(get_map_savepath()) then
                os.rename(get_map_savepath(), get_map_archivepath())
                os.rename(get_mob_savepath(), get_mob_archivepath())
        end
end
function setup_new_map()
        if file_exists(get_map_savepath()) == false then
                file = io.open(get_map_savepath(), "a")
                file:write("cell = {}\n")
                file:close()
        end
end
function setup_new_mob()
        if file_exists(get_mob_savepath()) == false then
                file = io.open(get_mob_savepath(), "a")
                file:write("mobs = {}\n")
                file:close()
        end
end

function record_cell(variable)
        --print(tostring(variable))
        setup_new_map()
        local local_table = stringup_cell(variable)
        file = io.open(get_map_savepath(), "a")
        file:write(local_table)
        file:close()
end

function record_mobile(variable)
        --print(tostring(variable))
        setup_new_mob()
        local local_table = stringup_cell(variable)
        file = io.open(get_mob_savepath(), "a")
        file:write(local_table)
        file:close()
end

function particle_index_byxy(xx, yy)
        local cell_index = tostring(xx) .. "_" .. tostring(yy)
        local r
        if type(cell) == "table" then
                print("cell table present")
                if cell[cell_index] ~= "nil" then
                        print(cell_index)
                        print(cell[cell_index])
                        r = tostring(cell[cell_index])
                else
                        print("Cell member not present " .. cell_index)
                        for key, value in pairs(cell) do
                                io.write(key .. " " .. value .. " : ")
                        end
                        print("")
                end
        else
                print("cell table not present")
        end
        return r
end

function mobile_index_byxy(xx, yy)
        local mob_index = tostring(xx) .. "_" .. tostring(yy)
        local r
        if type(mobs) == "table" then
                print("mob table present")
                if mobs[mob_index] ~= "nil" then
                        print(mobs .. " " .. mob_index .. " " .. mobs[mob_index])
                        r = tostring(mobs[mob_index])
                else
                        print("mob member not present " .. mob_index)
                        for key, value in pairs(mobs) do
                                io.write(key .. " " .. value .. " : ")
                        end
                        print("")
                end
        else
                print("mob table not present")
        end
        return r
end

function what_is_tile_w()
        local w = tonumber(generator_w.w) / tonumber(generator_coarse_w.w)
        return w
end

function what_is_tile_h()
        local h = tonumber(generator_h.h) / tonumber(generator_coarse_h.h)
        return h
end

function particle_index_by_coarse_xy(xx, yy)
        xxx = xx * what_is_tile_w()
        yyy = yy * what_is_tile_h()
        local r = particle_index_byxy(xxx,yyy)
        return r
end

function mobile_index_by_coarse_xy(xx, yy)
        xxx = xx * what_is_tile_w()
        yyy = yy * what_is_tile_h()
        local r = mobile_index_byxy(xxx,yyy)
        return r
end

function print_general_props()
        print("  Generator is at Coarse X: " .. generator_coarse_x.x .. " in the room")
        print("  Generator is at Coarse Y: " .. generator_coarse_y.y .. " in the room")
        print("  Room Starts at Coarse X: " .. room_coarse_x.x)
	print("  Room Starts at Coarse Y: " .. room_coarse_y.y)
        print("  Room Coarse Width: " .. generator_coarse_w.w)
	print("  Room Coarse Height: " .. generator_coarse_h.h)
        print("  Room Ends at Coarse X + Width: " .. room_coarse_xw.x)
	print("  Room Ends at Coarse Y + Height: " .. room_coarse_yh.y)
	print("  Generator is at Pixel X: " .. generator_x.x)
	print("  Generator is at Pixel Y: " .. generator_y.y)
        print("  Room Pixel Height: " .. generator_w.w)
	print("  Room Pixel Width: " .. generator_h.h)
        print("  Room Starts at Pixel X: " .. room_x.x)
	print("  Room Starts at Pixel Y: " .. room_y.y)
        print("  Room Ends at Pixel X + Width: " .. room_xw.x)
	print("  Room Ends at Pixel Y + Height: " .. room_yh.y)
        print("  Generator is at Coarse X: " .. where_in_floor_get_x() .. " on the floor")
	print("  Generator is at Coarse Y: " .. where_in_floor_get_y() .." on the floor")
        print("  Floor Coarse Width: " .. floor_coarse_w.w)
        print("  Floor Coarse Height: " .. floor_coarse_h.h)
        print("  Floor Pixel Width: " .. floor_w.w)
        print("  Floor Pixel Height: " .. floor_h.h)
        print("  Generator Particle Count: " .. generator_particle_count.c)
	print("  Generator Mobile Count: " .. generator_mobile_count.c)
        print("  Generator Tile Width: " .. tostring(what_is_tile_w()))
        print("  Generator Tile Height: " .. tostring(what_is_tile_h()))
end