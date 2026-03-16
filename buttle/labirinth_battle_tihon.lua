local turtle = require("minecraft_debug.turtle")
-- local textutils = require("textutils")

local labirinth_debug
local next_coordinates

turtle.debug_enable(true)
turtle.debug_init_viewport(4, 3, 5, 3, 'minecraft:wall')
turtle.debug_put_block(1, 1, 'minecraft:soul_soil')
turtle.debug_add_arr(3, 2, {
    { 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0 },
    { 1, 1, 0, 0 }
}, 'minecraft:wall3')

MaxX, MaxY = 10, 10
WindowX0, WindowY0, WindowX1, WindowY1 = 1, 1, 10, 10

Debug_enabled = true

local function debug(str)
    if Debug_enabled then
        print(str)
    end
end


-- 0 заправиться
local function refuel()
    turtle.refuel(64)
    local fuel = turtle.getFuelLevel()
    debug(fuel)
end



local function init_array(turtle_state)
    turtle_state.labirinth = {}

    for x = 1, MaxX do
        turtle_state.labirinth[x] = {}
        for y = 1, MaxY do
            turtle_state.labirinth[x][y] = 0
        end
    end
end


local function update_coordinates(turtle_state)
    turtle_state.x, turtle_state.y = next_coordinates(turtle_state)
end


next_coordinates = function(turtle_state)
    local x,y = turtle_state.x, turtle_state.y
    if turtle_state.direction == '-x' then
        x = turtle_state.x - 1
    elseif turtle_state.direction == '-y' then
        y = turtle_state.y - 1
    elseif turtle_state.direction == '+y' then
        y = turtle_state.y + 1
    elseif turtle_state.direction == '+x' then
        x = turtle_state.x + 1
    end
    return x,y
end





local function maze_recording(turtle_state)
    local x,y = next_coordinates(turtle_state)
    turtle_state.labirinth[x][y] = true
end

local function finish_recording(turtle_state)
    update_coordinates(turtle_state)
    turtle_state.labirinth[turtle_state.x][turtle_state.y] = true
    
end

local function forward(turtle_state)
    local x,y = next_coordinates(turtle_state)
    if turtle.forward() then
        turtle_state.labirinth[x][y] = false
        turtle_state.x, turtle_state.y = x, y
    else
        turtle_state.labirinth[x][y] = true
    end
end




local function turnLeft(turtle_state)
    turtle.turnLeft()

    
    if turtle_state.direction == '-x' then
        turtle_state.direction = '+y'
    elseif turtle_state.direction == '+y' then
        turtle_state.direction = '+x'
    elseif turtle_state.direction == '+x' then
        turtle_state.direction = '-y'
    elseif turtle_state.direction == '-y' then
        turtle_state.direction = '-x'
    end
end



local function turnRight(turtle_state)
    turtle.turnRight()
    if turtle_state.direction == '-x' then
        turtle_state.direction = '-y'
    elseif turtle_state.direction == '-y' then
        turtle_state.direction = '+x'
    elseif turtle_state.direction == '+x' then
        turtle_state.direction = '+y'
    elseif turtle_state.direction == '+y' then
        turtle_state.direction = '-x'
    end
    
end


local function block_dig(turtle_state)
    turtle.dig()
    turtle.suck(1)
    turtle_state.block_found = true
end


local function find_block(turtle_state)
    repeat
        -- 1 проверяем блок спереди
        local has_block, data = turtle.inspect()

        -- 2 если там стоит блок то разворачиваемся вправо и цикл повторяется
        if has_block then
            if data.name == "minecraft:soul_soil" then
                finish_recording(turtle_state)
                local minecraft_soul_soil = true
                debug(minecraft_soul_soil)
                block_dig(turtle_state)
            else
                maze_recording(turtle_state)
                turnRight(turtle_state)
            end
        else
            -- 3 если там нет блока то идем
            forward(turtle_state)

            -- 4 разворачивемся влево
            turnLeft(turtle_state)

            -- 5 смотрим блок
            local has_block2, data2 = turtle.inspect()
            if has_block2 and data2.name == "minecraft:soul_soil" then
                finish_recording(turtle_state)
                local minecraft_soul_soil = true
                debug(minecraft_soul_soil)
                block_dig(turtle_state)
            else
                -- 6 если есть то разворачиваемся вправо и повторяем цикл заново
                if has_block2 then
                    maze_recording(turtle_state)
                    turnRight(turtle_state)
                    debug("if:" .. tostring(data2.name))
                else
                    -- 7 если там блока нет то идем вперед и повторяем цикл заново
                    forward(turtle_state)
                end
            end
        end
        labirinth_debug(turtle_state)
    until turtle_state.block_found == true
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





local function do_competition()
    local turtle_state = {}
    turtle_state.x = 5
    turtle_state.y = 5
    turtle_state.direction = '+x'
    turtle_state.labirinth = {}
    turtle_state.block_found = false

    refuel()
    init_array(turtle_state)
    find_block(turtle_state)


    if true then
        return 1
    end
end


do_competition()
