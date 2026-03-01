function recieve_object(channel)
    
    local modem = peripheral.find("modem") or error("No modem attached", 0)
    modem.open(channel)
    if modem.isOpen(channel) == true then 
        channel_open = true
    end
    
    print("Channel is open:" .. tostring(channel_open))
    local event, side, pull_channel, replyChannel, scan_data , distance
    repeat
        event, side, pull_channel, replyChannel, scan_data , distance = os.pullEvent()
    until channel == pull_channel

    print("Event: " .. tostring(event) .. ", Side:" ..tostring(side) .. 
        ", pull_channel: " .. tostring(pull_channel) .. ", replyChannel:" .. tostring(replyChannel))

    return scan_data
end

--[[
scan_data[1..width][1..height]

scan_data[1] = {} == {true, false, true}
scan_data[1][1] == true
scan_data[1][2] == false
scan_data[1][3] == true
scan_data[2] = {} == {false, false, true}
scan_data[2][1] == false
]]--

--height = 9 
--width = 7

channel = 43

function restore_object(scan_data)
    local width = #scan_data
    for column = 1, width do
        local height = #(scan_data[column])
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
end

local scan_data = recieve_object(15)
restore_object(scan_data)



