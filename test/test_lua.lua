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

local function test_arr_xy()
    local my_arr={}
    for i=1,10 do
        my_arr[i] = i
    end

    local my_arr2 = {}
    for i=1,10 do
        local loc_arr = {}
        for j = 1,10 do
            loc_arr[j] = j
        end
        my_arr2[i] = loc_arr
    end
end

local function test_term_size()
    io.write("\27[18t")
    io.flush()

    local response = io.read()
    print(response)
    -- убираем ESC[
    response = response:gsub("\27%[", "")

    -- парсим числа
    local _, rows, cols = response:match("(%d+);(%d+);(%d+)t")

    rows = tonumber(rows)
    cols = tonumber(cols)
    print(rows, cols)
end

-- test_utf8()
--test_term_size()

--local m_tbl={}
--print(m_tbl)
local labirinth_row_string = ''

local my_arr = { true, 0, false, 0, true, 0, false }
for i = 1, #my_arr do
    local labirinth_block_str = ' '
    local labirinth_block = my_arr[i]
    if labirinth_block == true then
        labirinth_block_str = '#'
    elseif labirinth_block == false then
        labirinth_block_str = ' '
    elseif labirinth_block == 0 then
        labirinth_block_str = '?'
    end
    labirinth_row_string = labirinth_row_string .. labirinth_block_str
end
print(labirinth_row_string)