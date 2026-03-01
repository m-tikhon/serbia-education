maxX = 10
maxY = 10
debug_enabled = true


function debug(str)
    if debug_enabled then
        print(str)
    end
end


-- 0 заправиться
function refuel()
    turtle.refuel(64)
    fuel = turtle.getFuelLevel()
    debug(fuel)
end


function init_array(turtle_state)

    turtle_state.labirinth = {}

    for  turtle_state.x = 1,maxX do
        turtle_state.labirinth[turtle_state.x] = {}
        for turtle_state.y = 1, maxY do
            turtle_state.labirinth[turtle_state.x][turtle_state.y] = 0
        end
    end
end



function forward(turtle_state)
    
    if turtle.forward(turtle_state) then
        
        if turtle_state.direction == '-x' then
            turtle_state.x = turtle_state.x - 1
        elseif turtle_state.direction == '-y' then
            turtle_state.y = turtle_state.y - 1
        elseif turtle_state.direction == '+y' then 
            turtle_state.y = turtle_state.y + 1 
        elseif turtle_state.direction == '+x' then
            turtle_state.x = turtle_state.x + 1
        end

        
    end
end



function turnLeft(turtle_state)
    turtle.turnLeft()
    

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



function turnRight(turtle_state)
    turtle.turnRight()
    
 
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


function block_dig(turtle_state)
    turtle.dig() 
    turtle.suck(1)
    turtle_state.block_found = true
end


function find_block(turtle_state)
    repeat
     
        -- 1 проверяем блок спереди 
        local has_block, data = turtle.inspect()
        
        -- 2 если там стоит блок то разворачиваемся вправо и цикл повторяется
        if has_block  then
            if data.name=="minecraft:soul_soil" then
                minecraft_soul_soil = true  
                block_dig(turtle_state)
                
            else
                turnRight(turtle_state)
            end
        else 
            -- 3 если там нет блока то идем
            forward(turtle_state)
            
            -- 4 разворачивемся влево
            turnLeft(turtle_state)
            
            -- 5 смотрим блок 
            has_block2, data2 = turtle.inspect()
            debug("before_if:" .. tostring(data2.name))
            if has_block2 and data2.name=="minecraft:soul_soil" then
                minecraft_soul_soil = true
                debug(minecraft_soul_soil)
                block_dig(turtle_state)
            else

                -- 6 если есть то разворачиваемся вправо и повторяем цикл заново
                if has_block2 then
                    turnRight(turtle_state)
                    debug("if:" .. tostring(data2.name))
                else
                    -- 7 если там блока нет то идем вперед и повторяем цикл заново 
                    forward(turtle_state)
                end
            end
        end

    until turtle_state.block_found == true
end



function turtle_return()
end





function do_competition()

    local turtle_state = {}
    turtle_state.x = 5
    turtle_state.y = 5
    turtle_state.direction = '+x'
    turtle_state.labirinth = {}
    turtle_state.block_found = false

    refuel()
    init_array(turtle_state)
    find_block(turtle_state)
    

    local f = io.open("debug.txt", "w")
    io.output(f)
    io.write(textutils.serialize(turtle_state))
    io.close(f)

    if true then
        return 1
    end

   
end


do_competition()
