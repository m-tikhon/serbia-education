local level = turtle.getFuelLevel()
local ok, err = turtle.refuel()
if ok then
  local new_level = turtle.getFuelLevel()
  print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
else
  printError("Refuel error:" .. err)
end
