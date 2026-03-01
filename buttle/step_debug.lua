debug_enabled = true
debug_step = true
start_x = 0
start_y = 0
start_z = 0

function debug(str)
    if debug_enabled then
        print(str)
    end
end


function search_block()
    debug("Search block ...")
    
    repeat
        search_block_step()
    until is_turtle_on_start()
end


function search_block_step()
    fwd = turtle.forward()
    if not fwd then
        turtle.turnLeft()
    end
end



function init0()
    start_x = 10
    start_y = 11
    start_z = 12
end


function init()
    start_x, start_y, start_z = gps.locate(5)
    -- return start_x, start_y, start_z
    debug("X0:" .. tostring(start_x) .. ", Y0:" .. tostring(start_y) .. ", Z0:" .. tostring(start_z))
end


function is_turtle_on_start()
--[[     local x, y, z = gps.locate(2)
    if x and math.abs(x - start_x) <= 1 and math.abs(y - start_y) <= 1 and math.abs(z - start_z) <= 1 then
        return true
    end
    return false
 ]]
    return false
end


function do_competition()
    debug("Before GPS...")

    if debug_step then
    else
        init()
    end


    debug("X0:" .. tostring(start_x) .. ", Y0:" .. tostring(start_y) .. ", Z0:" .. tostring(start_z))
    search_block()

    test_global = 3
end

function debug_single_step()
    init0()
    search_block_step()
end

-- init()
-- do_competition()
debug_single_step()
