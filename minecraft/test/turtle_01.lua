--turtle.forward()
--turtle.up()
--local ok,reason = turtle.back()
--local ok,reason = turtle.place()
-- local ok,reason = turtle.dig()
--[[ local ok,reason = turtle.suck()
if not ok then
    print("can't suck. reason:"..reason)
end
]]

local modem = peripheral.find("modem") or error("No modem attached", 0)
print("Network:".. modem.getNameLocal())

local has_block, data = turtle.inspect()
if has_block then
    local file = fs.open("out.txt", "w")
    file.write("Front block"..textutils.serialise(data))
    file.close()

  --print(textutils.serialise(data))
  -- {
  --   name = "minecraft:oak_log",
  --   state = { axis = "x" },
  --   tags = { ["minecraft:logs"] = true, ... },
  -- }
else
  print("No block in front of the turtle")
end

