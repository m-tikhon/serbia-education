local common = require('lib.common')
local debug = common.debug


local function init_array(turtle_state)
    turtle_state.labirinth = {}

    for x = 1, MaxX do
        turtle_state.labirinth[x] = {}
        for y = 1, MaxY do
            turtle_state.labirinth[x][y] = 0
        end
    end
end


local function next_coordinates(turtle_state)
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


local function update_coordinates(turtle_state)
    turtle_state.x, turtle_state.y = next_coordinates(turtle_state)
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


local function search(turtle_state)
    repeat
        -- 1 проверяем блок спереди
        local has_block, data = turtle.inspect()

        -- 2 если там стоит блок то разворачиваемся вправо и цикл повторяется
        if has_block then
            if data.name == "minecraft:soul_soil" then
                --finish_recording(turtle_state)
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
                --finish_recording(turtle_state)
                local minecraft_soul_soil = true
                debug(minecraft_soul_soil)
                block_dig(turtle_state)
            else
                -- 6 если есть то разворачиваемся вправо и повторяем цикл заново
                if has_block2 then
                    maze_recording(turtle_state)
                    turnRight(turtle_state)
                    --debug("if:" .. tostring(data2.name))
                else
                    -- 7 если там блока нет то идем вперед и повторяем цикл заново
                    forward(turtle_state)
                end
            end
        end
        -- labirinth_debug(turtle_state)
    until turtle_state.block_found == true
end


return {
    search=search,
    init_array=init_array
}
