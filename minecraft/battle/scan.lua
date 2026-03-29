height = 3
width = 2

--scan_data[10] = 0

scan_data = {}






-- todo: init scan_data array


--[[
scan_data[1..width][1..height]
scan_data[column][row]

scan_data[1] = {} == {true, false, true}
scan_data[1][1] == true
scan_data[1][2] == false
scan_data[1][3] == true
scan_data[2] = {} == {false, false, true}
scan_data[2][1] == false


scan_data[2][1]
left = right
right:
    expression: + 0- , ..
    var
    array element
    function_call()


]]--



for column = 1, width do
    scan_data[column] = {}

    for row = 1, height do
        has_block, data = turtle.inspect()
        -- scan_data[column][row] = has_block


        if  has_block then 
            scan_data[column][row] = true
        else
            scan_data[column][row] = false
           
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
    print(textutils.serialize(scan_data))

end
