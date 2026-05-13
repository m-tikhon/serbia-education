-- local turtle = require("turtle_debug.turtle")

MaxX, MaxY = 10, 10
WindowX0, WindowY0, WindowX1, WindowY1 = 1, 1, 10, 10

Debug_enabled = true

local function debug(...)
    if Debug_enabled then
        print(...)
--[[ 
        local args = {...}
        for i = 1, #args do
            local arg = args[i]
            print(i, v)
        end
 ]]
    end
end

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


local function fill_step_near(turtle_state, next_cells, x, y, step)
    if turtle_state.labirinth[x][y] == false then
        turtle_state.labirinth[x][y] = step
        local length = #next_cells
        next_cells[length + 1] = { x = x, y = y }
    end
end

local function fill_step(turtle_state, prev_cells, step)
    local next_cells = {}
    for i = 1, #prev_cells do
        local x, y = prev_cells[i].x, prev_cells[i].y
        fill_step_near(turtle_state, next_cells, x + 1, y, step)
        fill_step_near(turtle_state, next_cells, x, y - 1, step)
        fill_step_near(turtle_state, next_cells, x - 1, y, step)
        fill_step_near(turtle_state, next_cells, x, y + 1, step)
    end
    return next_cells
end


local function fill_steps(turtle_state)
    local start = turtle_state.start
    local finish = turtle_state.finish
    local prev_cells = { start }
    turtle_state.labirinth[start.x][start.y] = 0
    local step = 0
    while true do
        step = step + 1
        prev_cells = fill_step(turtle_state, prev_cells, step)
        if turtle_state.labirinth[finish.x][finish.y] == step then
            break
        end
        if #prev_cells == 0 then
            break
        end
    end
end


local function find_next_cell_simple(labirinth, prev_cell, step)
    if labirinth[prev_cell.x + 1][prev_cell.y] == step then
        return { x = prev_cell.x + 1, y = prev_cell.y }
    elseif labirinth[prev_cell.x - 1][prev_cell.y] == step then
        return { x = prev_cell.x - 1, y = prev_cell.y }
    elseif labirinth[prev_cell.x][prev_cell.y - 1] == step then
        return { x = prev_cell.x, y = prev_cell.y - 1 }
    elseif labirinth[prev_cell.x][prev_cell.y + 1] == step then
        return { x = prev_cell.x, y = prev_cell.y + 1 }
    else
        print("Error. Invalid labirinth on step", step)
    end
end


local function find_path_simple(turtle_state)
    local labirinth = turtle_state.labirinth
    local finish = turtle_state.finish
    local start = turtle_state.start
    local steps = labirinth[finish.x][finish.y]
    local path = { finish }
    local prev_cell = finish
    for i = steps - 1, 0, -1 do
        prev_cell = find_next_cell_simple(labirinth, prev_cell, i)
        path[#path + 1] = prev_cell
    end
    return path
end


local function debug_path_simple(path)
    for i = 1, #path do
        print(path[i].x, path[i].y)
    end
end


-- выясняет куда попадёт черепашка если повернётся на delta_direction и сделает шаг вперёд
local function find_forward_location(prev_cell, direction, delta_direction)
    local next_direction = (direction + delta_direction) % 4
    --     { name = '+y', dx = 0,  dy = 1 },
    local next_direction_description = Directions[next_direction+1]
    local next_cell = {x = prev_cell.x + next_direction_description.dx, y = prev_cell.y + next_direction_description.dy}
    return next_cell
end


-- эта функция не помогает сделать программу понятнее
local function step_direction(labirinth, prev_cell, direction, step, delta_direction)
    local next_cell = find_forward_location(prev_cell, direction, delta_direction)
    if labirinth[next_cell.x][next_cell.y] == step then
        return {delta_direction=0, direction=direction,  prev_cell=prev_cell, next_cell = next_cell, step = step}
    end

    
end


Direction_deltas = {0, 1, -1, 2}

-- проверяет все возможные углы поворота черепашки такие, что сделав шаг вперёд черепаха попадёт в нужную
-- ячейку. Возвращает минимально возможный угол поворота - массив из {угол поворота, новое направление и т.д.}
local function find_next_path_step(labirinth, prev_cell, direction, step)
    
    -- debug('prev_cell:', prev_cell, 'step:', step, 'labirinth:', labirinth, 'direction:', direction)
    -- debug('prev_cell:', prev_cell.x, prev_cell.y)
    -- debug('labirinth[prev_cell.x]:', labirinth[prev_cell.x])
    debug('prev_cell', prev_cell.x, prev_cell.y, 'step:', step, 'labirinth[prev_cell]:', labirinth[prev_cell.x][prev_cell.y], 'direction', direction)
    for i = 1, 4 do
        local delta_direction = Direction_deltas[i]
        local next_cell = find_forward_location(prev_cell, direction, delta_direction)
        debug('delta_direction:', delta_direction, 'next_cell:', next_cell.x, next_cell.y, 'labirinth[next_cell]', labirinth[next_cell.x][next_cell.y])

        if labirinth[next_cell.x][next_cell.y] == step  - 1 then
            return {
                delta_direction = delta_direction, direction = (direction + delta_direction) % 4, prev_cell = prev_cell, next_cell = next_cell, step = step
            }
        end
    end

    debug("Error. Was not able to find next cell")


    

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
end


local function find_path(turtle_state)
    local path ={}
    
    local labirinth = turtle_state.labirinth
    local direction = turtle_state.direction
    local finish = turtle_state.finish
    local steps = turtle_state.labirinth[finish.x][finish.y]
    local prev_cell = finish
    for i = steps, 1, -1 do
        local next_path_step = find_next_path_step(labirinth, prev_cell, direction, i)
        direction = next_path_step.direction
        path [#path + 1] = next_path_step
        prev_cell = next_path_step.next_cell
        
    end


    return path
    --????
    --тут надо вызвать последовательно find_next_cell (по количеству шагов),
    --результат сохранить в массив и массив вернуть
end


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


local function turtle_return(turtle_state, path_w_d)
    for i = 1, #path_w_d do
        local path_element = path_w_d[i]
        local path_element_direction = path_element.delta_direction
        if path_element_direction == 0 then
            turtle.forward()
        elseif path_element_direction == -1 then
            turtle.turnLeft()
            turtle.forward()
        elseif path_element_direction == 1 then
            turtle.turnRight()
            turtle.forward()       
        elseif path_element_direction == 2 or path_element_direction == -2 then
            turtle.turnRight()
            turtle.turnRight()
            turtle.forward()
        else
            debug('Unsupported direction', path_element_direction)
        end
        debug_labirinth(turtle_state)
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

return {
    find_path = find_path,
    turtle_return = turtle_return
}
