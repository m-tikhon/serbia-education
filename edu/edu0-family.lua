PI = 3.14159

-- local textutils = require("textutils")

local function print_names(age)
    for i=1, #age do
    print("Name:", age[i].name, 'Age:',age[i].age)
    end
end


local function find_min(arr)
    local arr_min = arr[1]
    for i = 2,#arr do
        if arr_min.age > arr[i].age then
            arr_min = arr[i]
        end
    end
    return arr_min
end


local function find_max(arr)
    local arr_max = arr[1]
    for i = 2,#arr do
        if arr_max.age < arr[i].age then
            arr_max = arr[i]
        end
    end
    return arr_max
end
local function find_universal(arr)
    local arr_max = arr[1]
    local arr_min = arr[1]
    for i = 2,#arr do
        if arr_max.age < arr[i].age then
            arr_max = arr[i]
        end
        if arr_min.age > arr[i].age then
            arr_min = arr[i]
        end
       
    end
    
    
    return arr_min,arr_max
    
end

--if type == 'min' then elseif type == 'max' then end
local function find_universal2(arr, type)
    local arr_max = arr[1]
    local arr_min = arr[1]
    for i = 2,#arr do
        if arr_max.age < arr[i].age then
            arr_max = arr[i]
        end
        if arr_min.age > arr[i].age then
            arr_min = arr[i]
        end
       
    end
    
    if type == true then
        return arr_min
    else
        return arr_max
    end
    
    
end


function Find_min_number(arr)
    local arr_min = arr[1]
    
    for  i = 1,#arr do
        
        if arr_min.age > arr[i].age then
            arr_min = arr[i]
           local min_number = i +1
            return min_number  
            
        end
        
    end
    
    
end


local family_members = {
    {name="papa", age=49, sex='M'},
    {name="mama", age=48, sex='F'},
    {name="tikhon", age=14, sex='M'},
    {name="daniel", age=21, sex='M'}
}
local type = true
local min,max = find_universal(family_members)

print("Found: ", min.name)


local min_number_1 = Find_min_number(family_members)
print("Found  min number: ",min_number_1 )


print("Found: [tikhon loh]: ", max.name)


local name_with_type = find_universal2(family_members,type)
if type == true then
    print('find_min', name_with_type.name)
else
    print('find_max', name_with_type.name)
end



-- print("Found: ", textutils.serialize(min))
