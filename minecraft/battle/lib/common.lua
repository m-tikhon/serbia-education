Debug_enabled = true

local function debug(...)
    if Debug_enabled then
        print(...)
    end
end


-- 0 заправиться
local function refuel()
    turtle.refuel(64)
    local fuel = turtle.getFuelLevel()
    debug('Fuel level:', fuel)
end

Debug_enabled = true

Directions = { { name = '+x', dx = 1, dy = 0, debug='>' },
    { name = '+y', dx = 0,  dy = 1, debug='v' },
    { name = '-x', dx = -1, dy = 0, debug='<' },
    { name = '-y', dx = 0,  dy = -1, debug='^' } }


local function debug_labirinth(turtle_state)
    local labirinth = turtle_state.labirinth
    local turtle_loc = turtle.loc
    for y = 1, #labirinth[1] do
        local row_str = ""
        for x = 1, #labirinth do
            local cell = labirinth[x][y]
            if x == turtle_loc.x+1 and y == turtle_loc.y+1 then
                row_str = ' ' .. Directions[turtle_loc.direction+1].debug .. ' '
            elseif cell == true then
                row_str = row_str .. "###" -- стена
            elseif cell == false then
                row_str = row_str .. "   " -- свободная клетка
            else
                row_str = row_str .. " "
                if cell < 10 then
                    row_str = row_str .. " "
                end
                row_str = row_str .. tostring(cell) -- число шагов
            end
        end
        print(row_str)
    end
end


local function convert_direction_from_string_to_number(directionStr)
    for i = 1, #Directions do
        if directionStr == Directions[i].name then
            return i - 1
        end
    end
    debug('error, direction wasnt recognized', directionStr)
end


return {
    debug=debug,
    refuel=refuel,
    convert_direction_from_string_to_number=convert_direction_from_string_to_number,
}
