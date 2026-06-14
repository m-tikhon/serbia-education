local common = require('lib.common')
local debug = common.debug

debug('Search and escape ...')

MaxX, MaxY = 20, 20

local search_and_scan = require('lib.search_and_scan')
local escape_by_scan = require('lib.escape_by_scan')


local turtle_state = {}
turtle_state.x = 10
turtle_state.y = 10
turtle_state.direction = '+x'
turtle_state.labirinth = {}
turtle_state.block_found = false
turtle_state.start = {x = turtle_state.x, y = turtle_state.y}

common.refuel()
search_and_scan.init_array(turtle_state)

search_and_scan.search(turtle_state)
debug('start', turtle_state.start.x, turtle_state.start.y)
turtle_state.finish = {x = turtle_state.x, y = turtle_state.y}

local path = escape_by_scan.find_path(turtle_state)

escape_by_scan.turtle_return(turtle_state, path)
