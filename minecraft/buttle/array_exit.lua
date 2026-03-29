MaxX, MaxY = 10, 10
WindowX0, WindowY0, WindowX1, WindowY1 = 1, 1, 10, 10

--[[
 true = wall
 false = free space
 number = path - 0..1..2..?
 nil = unknown
]]

local turtle_state = {
    labirinth = {
{}
    },
    start = {x = 3, y = 4},
    finish = {x = 7, y = 3},
}


local function debug_labirinth(turtle_state)
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
end

local function fill_step_near(turtle_state, next_cells, x, y, step)
    if turtle_state.labirinth[x][y] == false then
        turtle_state.labirinth[x][y] = step
        local length = #next_cells
        next_cells[length+1] = {x=x, y=y}
    end 
end

local function fill_step(turtle_state, prev_cells, step)
    local next_cells = {}
    for i=1, #prev_cells do
        local x,y = prev_cells[i].x, prev_cells[i].y
        fill_step_near(turtle_state, next_cells, x + 1, y, step)
        fill_step_near(turtle_state, next_cells, x, y - 1, step)
        fill_step_near(turtle_state, next_cells, x - 1, y, step)
        fill_step_near(turtle_state, next_cells, x, y + 1, step)
    end
end


local function fill_steps(turtle_state)
    local prev_cells = {
        {x=???????,y=????????}
    } -- start
    local x,y = turtle_state.start[1],turtle_state.start[2]
    turtle_state.labirinth[x][y] = 0
    for i = 1, 100 do
        prev_cells = fill_step(turtle_state, prev_cells, i)

        ??? test #prev_cells == 0
        ??? test finish filled
    end
end


local function find_path(turtle_state)
end


local function find_path_movements(turtle_state)
end


fill_steps(turtle_state)
find_path(turtle_state)

