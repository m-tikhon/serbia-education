
scan_data = {{true, false, true}, 
             {false, false, true}}

--[[
scan_data[1..width][1..height]

scan_data[1] = {} == {true, false, true}
scan_data[1][1] == true
scan_data[1][2] == false
scan_data[1][3] == true
scan_data[2] = {} == {false, false, true}
scan_data[2][1] == false
]]--

height = 3
width = 2
for column = 1, width do

    for row = 1, height do

        if scan_data[column][row] == true then 
            block_placed,block_d_placed = turtle.place()
            if block_placed == false then
                print(block_d_placed)
            end
        end

        if row < height then
            turtle.up()
        end

        --print("column:"..tostring(column)..",  row:"..tostring(row))
        

    end

    for row = 1, height-1 do
        turtle.down()

    end

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

end