print("aaa")


while true do
  -- redstone.getOutput("right")
    power = redstone.getAnalogInput("left")
    print("Power "..power)
    delay = power/10+0.1
    -- redstone.getOutput("right")
    print('turn on')
    redstone.setOutput("right", true)
    print('delay')
    sleep(delay)
    -- redstone.getOutput("right")
    print('turn off')
    redstone.setOutput("right", false)
    print('delay')
    sleep(delay)
    print('finish')

    help.topics()
end

