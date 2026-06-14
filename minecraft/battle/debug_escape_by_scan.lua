local turtle = require("lib.turtle_debug")
local common = require('lib.common')
local debug = common.debug

WindowX0, WindowY0, WindowX1, WindowY1 = 1, 1, 10, 10

--[[
 true = wall
 false = free space
 number = path - 0..1..2..?
 nil = unknown
]]

local turtle_state = {
    labirinth = {
        { true, true,  true,  true,  true,  true,  true,  true,  true,  true },
        { true, false, false, false, true,  false, false, false, false, true },
        { true, false, true,  false, true,  false, false, false, false, true }, -- здесь финиш (7,3)
        { true, false, false, false, false, false, true,  false, false, true }, -- здесь старт (3,4)
        { true, true,  true,  false, true,  true,  true,  false, true,  true },
        { true, false, false, false, false, false, false, false, false, true },
        { true, false, true,  true,  true,  true,  true,  true,  false, true },
        { true, false, false, false, false, false, false, true,  false, true },
        { true, true,  true,  false, true,  true,  false, true,  false, true },
        { true, true,  true,  true,  true,  true,  true,  true,  true,  true }
    },
    start = { x = 3, y = 4 },
    -- finish = { x = 7, y = 3 }, -- path length = 13
    finish = { x = 5, y = 8 },
    direction = 0
}



local function debug_path_simple(path)
    for i = 1, #path do
        print(path[i].x, path[i].y)
    end
end


    

   --[[
    --можно либо оставить 4 отдельных вызова find_forward_location + if, либо запихать это в цикл
    for i = 1, #Direction_deltas do
        local delta_direction = Direction_deltas[i]

    end


    -- 4 отдельных вызова find_forward_location + if
    -- todo [!]: сейчас неправильно - direction при возврате может выйти за границы 0..3 
    local next_cell = find_forward_location(prev_cell, direction, 0)
    if labirinth[next_cell.x][next_cell.y] == step then
        return {delta_direction=0, direction=direction,  prev_cell=prev_cell, next_cell = next_cell, step = step}
    end

    local next_cell = find_forward_location(prev_cell, direction, -1)
    if labirinth[next_cell.x][next_cell.y] == step then
        return {delta_direction=-1, direction=direction - 1,  prev_cell=prev_cell, next_cell = next_cell, step = step}
    end

    local next_cell = find_forward_location(prev_cell, direction, 1)
    if labirinth[next_cell.x][next_cell.y] == step then
        return {delta_direction=1, direction=direction + 1,  prev_cell=prev_cell, next_cell = next_cell, step = step}
    end

    local next_cell = find_forward_location(prev_cell, direction, 2)
    if labirinth[next_cell.x][next_cell.y] == step then
        return {delta_direction=2, direction=direction + 2,  prev_cell=prev_cell, next_cell = next_cell, step = step}
    end

    debug("Error. Was not able to find next cell")
    -- exaple
    return {delta_direction = 0, direction = -1,  prev_cell = {x = 10, y = 12}, next_cell = {x = 9, y = 12}, step = 3}
]]


local function debug_path(turtle_state, path_w_d)
    for i = 1, #path_w_d do
        local path_step = path_w_d[i]
        local prev_cell = path_step.prev_cell
        local next_cell = path_step.next_cell
        local direction = Directions[path_step.direction + 1]
        local delta_direction = path_step.delta_direction
        debug("prev:" .. prev_cell.x .. ',' .. prev_cell.y, "direction:" .. direction.name .. '(' .. delta_direction .. ')', "next:" .. next_cell.x .. ',' .. next_cell.y)
    end
end


local function init_debug_turtle(turtle_state)
    local labirinth = turtle_state.labirinth
    local labirinth_size = {x=#labirinth, y=#labirinth[1]}
    local turtle_loc = {x=turtle_state.start.x, y=turtle_state.start.y, direction=turtle_state.direction}
    turtle.debug_init2(labirinth_size, turtle_loc, 'wall')
    for x = 1, #labirinth do
        for y = 1, #labirinth[x] do
            turtle.labirinth[y+1][x+1] = {wall=true, name='wall'}
        end
    end
end



local function run_local()
    init_debug_turtle(turtle_state)


    -- Заполняем лабиринт количеством шагов от старта до финиша
    fill_steps(turtle_state)
    debug_labirinth(turtle_state)

    -- Ищем путь (по клеточкам) от финиша до старта. Получаем массив координат с клеточками
    --[[local path_simple = find_path_simple(turtle_state)
    debug_path_simple(path_simple)]]

    -- Ищем путь настоящей черепахи (с поворотами) - выясняем сколько и куда черепаха долна повернуть на каждом шаге
    local path_w_d = find_path(turtle_state)
    debug_path(turtle_state, path_w_d)


    --тут можно двинуть черепашку по пути из find_pth - использовать функции turtle.turnLeft, turnRight и forward
    turtle_return(turtle_state, path_w_d)
end

-- run_local()

