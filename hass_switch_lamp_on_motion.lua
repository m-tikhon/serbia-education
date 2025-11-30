HASS_ADDR="..."
LONG_LIVING_TOKEN="..."

sensor="0x08ddebfffea51992_occupancy"
url=HASS_ADDR .. "/api/states/binary_sensor." .. sensor

url_headers={Authorization="Bearer "..LONG_LIVING_TOKEN}


while true do
    response = http.get{url=url, headers=url_headers}

    response_text = response.readAll()
    --local jsonTable = textutils.unserializeJSON(x1)

    --print(x1)
    response.close()
    --print("hello world")

    --print("response"..response_text)

    local jsonTable = textutils.unserialiseJSON(response_text)

    switch_state_str = jsonTable.state
    --print(switch_state_str)
    --switch_state = jsonTable.state == "on"
    --print(switch_state)


    redstone.setOutput("right", jsonTable.state == "on")


--[[
    if jsonTable.state =="on" then
        redstone.setOutput("right",true )    
        print("Turned on")
    else
        redstone.setOutput("right",false )
        print("Turned off")
    end
]]


end
