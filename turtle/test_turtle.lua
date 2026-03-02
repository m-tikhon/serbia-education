local turtle = require("minecraft_debug.turtle")
turtle.debug_enable(true)
turtle.debug_init_viewport(3, 2, 4, 3, 'minecraft:wall')
-- turtle.debug_state()
turtle.debug_put_block(3,2, 'minecraft:wall2')
-- turtle.debug_state()

turtle.debug_add_arr(1,1, {
    {1,0,0,0},
    {1,0,0,1},
    {1,1,0,1}
}, 'minecraft:wall3')

for i = 0, 3 do
    turtle.forward()
    -- turtle.debug_state()
    turtle.turnLeft()
    -- turtle.debug_state()
end
