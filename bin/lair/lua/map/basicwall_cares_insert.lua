
function thickwall_cares_insert(vari)
        if type(vari) == "string" then
                decided_to = vari
        else
                decided_to = "false"
        end
        local decided_to = vari
        if lesser_than(where_in_floor_get_x(), 3) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_x(), where_is_floor_farcorner_x()- (4)) then
                decided_to="true"
        end
        if lesser_than(where_in_floor_get_y(), 3) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_y(), where_is_floor_farcorner_y() - (4)) then
                decided_to="true"
        end
        print("Should a thick wall be inserted? ", decided_to)
        return decided_to
end

function medwall_cares_insert(vari)
        if type(vari) == "string" then
                decided_to = vari
        else
                decided_to = "false"
        end
        local decided_to = vari
        if lesser_than(where_in_floor_get_x(), 2) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_x(), where_is_floor_farcorner_x() - (3)) then
                decided_to="true"
        end
        if lesser_than(where_in_floor_get_y(), 2) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_y(), where_is_floor_farcorner_y() - (3)) then
                decided_to="true"
        end
        print("Should a medium wall be inserted? ", decided_to)
        return decided_to
end

function thinwall_cares_insert(vari)
        if type(vari) == "string" then
                decided_to = vari
        else
                decided_to = "false"
        end
        local decided_to = vari
        if lesser_than(where_in_floor_get_x(), 1) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_x(), where_is_floor_farcorner_x() - (2)) then
                decided_to="true"
        end
        if lesser_than(where_in_floor_get_y(), 1) then
                decided_to="true"
        end
        if greater_than(where_in_floor_get_y(), where_is_floor_farcorner_y() - (2)) then
                decided_to="true"
        end
        print("Should a thick wall be inserted? ", decided_to)
        return decided_to
end
