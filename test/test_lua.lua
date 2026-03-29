local utf8 = require("utf8")

local function test_utf8()
    local turtle_symbols = "▶▼◀▲"
    local p = 2
    local i=utf8.offset(turtle_symbols,p)
    local j=utf8.offset(turtle_symbols,p+1)-1
    local turtle_symbol = string.sub(turtle_symbols, i, j)
    print(turtle_symbol)

    print("Привет")
end

