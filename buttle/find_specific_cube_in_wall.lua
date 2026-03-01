-- 1 заправиться
turtle.refuel(10)
turtle.getFuelLevel()
print(getFuelLevel)

--ДЕРЕВО - "minecraft:oak_log"
--ВЫХОД - minecraft:soul_soil

-- 1.1 - черепаха стоит вдоль стены
-- 2 пойти вперед
repeat
    turtle.forward()
    -- 3 анализировать блоки стены
    -- 3.1 * развернутся лицом к стене
    turtle.turnLeft()

    -- 3.2* посмотреть что за блок

    has_block, data = turtle.inspect()
    
    if has_block then
        
        if data.name=="minecraft:soul_soil" then 
            minecraf_soul_soil = true
        else      
            turtle.turnRight()
        end
        

    else
        turtle.forward()
        
    end

    -- 3.3- если это блок то идем на второй пункт
until minecraft_soul_soil

-- 4 выбить нужный блок
-- 5 закончиться
