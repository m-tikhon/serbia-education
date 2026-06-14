local common = require('lib.common')
local debug = common.debug


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


-- Direction_deltas это сколько надо сделать поворотов чтобы развернуться черепахе к нужным координатам
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
end


local function find_path(turtle_state)
    fill_steps(turtle_state)
    local path ={}

    local labirinth = turtle_state.labirinth
    local direction = common.convert_direction_from_string_to_number(turtle_state.direction)
    debug('local direction', direction)
    local finish = turtle_state.finish
    local steps = labirinth[finish.x][finish.y]
    debug('start:', turtle_state.start.x, turtle_state.start.y)
    debug('finish:', finish.x, finish.y)
    debug('steps:', steps, 'direction:', direction)
    debug('direction:', Directions[direction+1])
   debug(' local steps', steps)
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
        --debug_labirinth(turtle_state)
    end
end


return {
    find_path = find_path,
    turtle_return = turtle_return
}
