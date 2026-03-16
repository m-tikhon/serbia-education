local names = {
    "тихон", "умный", "программист"
}

max = #names[1] 

for i=1,#names do
    if max < #names[i] then
        max = #names[i]
    end     
end
print("Found max: " .. max)


--[[
local str = "sdgadfgsdfg"
local str_length = #str
print("Str length: " .. str_length)
 ]]





-- 0) min = 49
-- 1) 49 * 48 ; 49 > 48 ; min: 48
-- 2) 48 * 14 ; 48 > 14 ; min: 14
-- 3) 14 * 21 ; 14 < 21 ; min: 14
-- 4) min * x5; ? ; min
-- 5) min * x6; ? ; min
-- 6) min * x7; ? ; min
-- 7) min * x8; ? ; min



local age = {49, 48, 14, 21}

min = age[1]
for i = 2,#age do
    if min > age[i] then
        min = age[i]
    end
end

print("Found min: " .. min)
