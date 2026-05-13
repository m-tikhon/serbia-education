local scan_labirinth = require('battle.scan_labirinth')
local find_array_exit = require('battle.find_array_exit')


local turtle_state = {}
turtle_state.x = 5
turtle_state.y = 5
turtle_state.direction = '+x'
turtle_state.labirinth = {}
turtle_state.block_found = false


scan_labirinth.init_array(turtle_state)

scan_labirinth.find_block(turtle_state)

local path = find_array_exit.find_path(turtle_state)

find_array_exit.turtle_return(turtle_state, path)
