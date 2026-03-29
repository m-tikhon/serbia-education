local table_example = {name='charger', weigth=4.1, length=10}
print(table_example.name)

local array_example = {24, 23, 1, 3, 0, 80, 90, 7, 11, 21, 40}
print("Array Length: ", #array_example)

print(array_example[2])
print(array_example[2]+array_example[3])

print("All family age")
for i = 1, #array_example do
    print(array_example[i] +1)
end


-- local num = 2
-- print(array_example[num])
