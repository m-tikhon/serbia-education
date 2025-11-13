print("Hello minecraft")

while true do
    sleep(1)
    print("Red Stone:" .. tostring(rs.getInput("left")))
    if rs.getInput("left") then
        print("pressed")
    end
end

