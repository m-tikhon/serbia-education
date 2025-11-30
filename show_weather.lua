-- todo [!] call config.lua here and read weather_key
local response = http.get("https://api.openweathermap.org/data/2.5/weather?lat=44.8127191&lon=20.455255&appid=" .. weather_key)
x1 = response.readAll()
--local jsonTable = textutils.unserializeJSON(x1)

--print(x1)
response.close()
--print("hello world")
local jsonTable = textutils.unserialiseJSON(x1)
print("temp in kelvin="..jsonTable.main.temp)
ltemp=jsonTable.main.temp-273.15
print("temp in Celsius="..ltemp.." in "..jsonTable.name)
-- This doesn't work
--function: a_p2()

--[[ peremennaya = 1
x = a_p2(peremennaya)
my_str = "X:".. x .. ", peremennaya:"..peremennaya

print(my_str)

print("Tikhon is said")

 ]]
print("end")
