local utf8 = require("utf8")

local turtle = {
    loc = {x = 100,y = 100, direction = 0},
    maxX = 200,
    maxY = 200,
    -- wall: boolean, name: string
    labirinth = {},
    debug = false
}

local directions = {
    {name='+x',dx=1, dy=0 },
    {name='+y',dx=0, dy=1 },
    {name='-x',dx=-1,dy=0 },
    {name='-y',dx=0, dy=-1},
}

local viewport = {
    x0=90, y0=90, x1=110, y1=110
}

local debug_state_if_enabled

local function init()
    for y = 1, turtle.maxY do
        turtle.labirinth[y] = {}
        for x = 1, turtle.maxX do
            turtle.labirinth[y][x] = {wall=false}
        end
    end
end

local function add_loc(loc, fwd)
    local d = directions[loc.direction+1]
    return {
        x = loc.x + d.dx*fwd,
        y = loc.y + d.dy*fwd,
        direction = loc.direction
    }
end

local function labirinth_data(loc)
    return turtle.labirinth[loc.y][loc.x]
end

local function move(next_loc)
    local next_data = labirinth_data(next_loc)
    if next_data.wall == false then
        turtle.loc = next_loc
        debug_state_if_enabled()
        return true
    else
        return false, "wall:" .. next_data.name
    end
end

local function inspect()
    local next_loc = add_loc(turtle.loc, 1)
    local next_data = labirinth_data(next_loc)
    if next_data.wall == false then
        return false
    else
        return true, {
            name = next_data.name,
        }
    end
end


local function term_gotoxy(x, y)
    io.write(string.format("\27[%d;%dH", y, x))
end

local function term_save_cursor()
    io.write("\27[s")
end

local function term_restore_cursor()
    io.write("\27[u")
end

local function term_size()
    local f = io.popen("stty size")
    local rows, cols = f:read("*n", "*n")
    f:close()
    if cols == nil or rows == nil then
        cols = 80
        rows = 25
    end
    return cols, rows
end

local turtle_symbols = "▶▼◀▲"
local function turtle_symbol(direction)
    local i=utf8.offset(turtle_symbols,direction+1)
    local j=utf8.offset(turtle_symbols,direction+2)-1
    local symbol = string.sub(turtle_symbols, i, j)
    return symbol
end

local function debug_state()
    local dx = viewport.x1 - viewport.x0 + 1;
    local dy = viewport.y1 - viewport.y0 + 1;
    local term_dx, term_dy = term_size()
    local loc = turtle.loc
    term_save_cursor()
    term_gotoxy(term_dx - dx+1, 1)
    local info = (loc.x - viewport.x0) .. ':' .. (loc.y-viewport.y0)
    if #info < viewport.y1 - viewport.y0 then
        info = info .. string.rep(' ', #info - viewport.y1 + viewport.y0)
    end
    print(info)
    for y = viewport.y0, viewport.y1 do
        local str = ""
        for x = viewport.x0, viewport.x1 do
            if x == loc.x and y == loc.y then
                str = str .. turtle_symbol(loc.direction)
            elseif turtle.labirinth[y][x].wall then
                str = str .. '#'
            else
                str = str .. ' '
            end
        end
        term_gotoxy(term_dx - dx+1, y-viewport.y0+2)
        print(str)
    end

    term_restore_cursor()
end

debug_state_if_enabled = function()
    if turtle.debug then
        debug_state()
    end
end


local function debug_put_block(x, y, name)
    turtle.labirinth[y + viewport.y0-1][x + viewport.y0-1] = {
        wall=true,
        name=name,
    }
    debug_state_if_enabled()
end


local function debug_init_viewport(dx0, dy0, dx1, dy1, name)
    local x0 = turtle.loc.x - dx0
    local y0 = turtle.loc.y - dy0
    local x1 = turtle.loc.x + dx1
    local y1 = turtle.loc.y + dy1
    viewport = {x0=x0, y0=y0, x1=x1, y1=x1}

    for x=x0,x1 do
        turtle.labirinth[y0][x] = {wall=true, name=name}
        turtle.labirinth[y1][x] = {wall=true, name=name}
    end
    for y=y0,y1 do
        turtle.labirinth[y][x0] = {wall=true, name=name}
        turtle.labirinth[y][x1] = {wall=true, name=name}
    end
    debug_state_if_enabled()
end

--@param dx0 number
--@param dy0 number
local function debug_add_arr(dx0, dy0, arr, name)
    for y_ = 1, #arr do
        local y = y_ + viewport.y0 + dy0 - 1
        local arr_line = arr[y_]
        for x_ = 1, #arr_line do
            local x = x_ + viewport.y0 + dx0 - 2
            if arr_line[x_] == true or arr_line[x_] == 1 then
                turtle.labirinth[y][x].wall = true
                turtle.labirinth[y][x].name = name
            end
        end
    end

    debug_state_if_enabled()
end

local function debug_enable(debug)
    turtle.debug = debug
end

local function forward()
    local next_loc = add_loc(turtle.loc, 1)
    return move(next_loc)
end

local function back()
    local next_loc = add_loc(turtle.loc, -1)
    return move(next_loc)
end

local function refuel(fuel)
    print("Refuel", fuel)
end

local function turnLeft()
    turtle.loc.direction = (turtle.loc.direction+3) % 4
    debug_state_if_enabled()
end

local function turnRight()
    turtle.loc.direction = (turtle.loc.direction+1) % 4
    debug_state_if_enabled()
end



turtle.refuel = refuel
turtle.turnLeft = turnLeft
turtle.turnRight = turnRight
turtle.dig = dig
turtle.suck = suck
turtle.inspect = inspect
turtle.forward = forward
turtle.back = back

turtle.debug_put_block = debug_put_block
turtle.debug_init_viewport = debug_init_viewport
turtle.debug_state = debug_state
turtle.debug_add_arr = debug_add_arr
turtle.debug_enable = debug_enable


init()

return turtle
