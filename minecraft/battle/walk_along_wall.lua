-- 0 заправиться

turtle.refuel(10)
fuel = turtle.getFuelLevel()
print(fuel)

repeat
    
    -- 1 проверяем блок спереди 
    has_block, data = turtle.inspect()
    
    -- 2 если там стоит блок то разворачиваемся вправо и цикл повторяется
    if has_block then
        turtle.turnRight()

    else 
        -- 3 если там нет блока то идем
        turtle.forward()

        
        -- 4 разворачивемся влево
        turtle.turnLeft()
        
        -- 5 смотрим блок 
        has_block2, data2 = turtle.inspect()
        
        -- 6 если есть то разворачиваемся вправо и повторяем цикл заново
        if has_block2 then
            turtle.turnRight()
        else
            -- 7 если там блока нет то идем вперед и повторяем цикл заново 
            turtle.forward()
        end
    end

until false
