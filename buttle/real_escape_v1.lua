-- 0 заправиться

turtle.refuel(10)
fuel = turtle.getFuelLevel()
print(fuel)

repeat
    
    -- 1 проверяем блок спереди 
    has_block, data = turtle.inspect()
    
    -- 2 если там стоит блок то разворачиваемся вправо и цикл повторяется
    if has_block  then
        if data.name=="minecraft:soul_soil" then
            minecraft_soul_soil = true  
        
        else
            turtle.turnRight()
        end
    else 
        -- 3 если там нет блока то идем
        turtle.forward()

        
        -- 4 разворачивемся влево
        turtle.turnLeft()
        
        -- 5 смотрим блок 
        has_block2, data2 = turtle.inspect()
        print("before_if:" .. tostring(data2.name))
        if has_block2 and data2.name=="minecraft:soul_soil" then
            minecraft_soul_soil = true
            print(minecraft_soul_soil)
        else

            -- 6 если есть то разворачиваемся вправо и повторяем цикл заново
            if has_block2 then
                turtle.turnRight()
                print("if:" .. tostring(data2.name))
            else
                -- 7 если там блока нет то идем вперед и повторяем цикл заново 
                turtle.forward()
            end
        end
    end

until minecraft_soul_soil
