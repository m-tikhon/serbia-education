while true do
    -- redstone.getOutput("right")
    power = redstone.getAnalogInput("left")
    print("Power "..power)
    sleep(1)
end

