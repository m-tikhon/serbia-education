local scan_labirinth = require('lib.search_and_scan')
local common = require('lib.common')
local debug = common.debug

WindowX0, WindowY0, WindowX1, WindowY1 = 1, 1, 20, 20


local function debug_init()
    turtle = require("minecraft.turtle_debug.turtle")
-- local textutils = require("textutils")
    turtle.debug_enable(true)
    turtle.debug_init_viewport(4, 3, 5, 3, 'minecraft:wall')
    turtle.debug_put_block(1, 1, 'minecraft:soul_soil')
    turtle.debug_add_arr(3, 2, {
        { 1, 1, 1, 1, 1, 1 },
        { 1, 0, 0, 0 },
        { 1, 1, 0, 0 }
    }, 'minecraft:wall3')
end


local function do_competition()
    debug_init()

    local turtle_state = {}
    turtle_state.x = 5
    turtle_state.y = 5
    turtle_state.direction = '+x'
    turtle_state.labirinth = {}
    turtle_state.block_found = false

    refuel()
    init_array(turtle_state)
    find_block(turtle_state)
end


labirinth_debug = function(turtle_state)
    for y = WindowY0, WindowY1 do
        local labirinth_row_string = ''
        for x = WindowX0, WindowX1 do
            local labirinth_block_str = ''
            local labirinth_block = turtle_state.labirinth[x][y]
            if labirinth_block == true then
                labirinth_block_str = '#'
            elseif labirinth_block == false then
                labirinth_block_str = ' '
            elseif labirinth_block == 0 then
                labirinth_block_str = '?'
            end
            labirinth_row_string = labirinth_row_string .. labirinth_block_str
        end
        print(labirinth_row_string, 'y:', y)
    end
    print('direction:' .. turtle_state.direction, 'coordinates', turtle_state.x, turtle_state.y)
end


local function labirinth_debug_file(turtle_state)
    local f = io.open("debug.txt", "w")
    io.output(f)
    io.write(textutils.serialize(turtle_state))
    io.close(f)
end


local function turtle_return()
    
end


-- do_competition()

