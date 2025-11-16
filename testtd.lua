local request = http.get("https://api.openweathermap.org/data/2.5/weather?lat=44.8127191&lon=20.455255&appid=297925969fd78afe0cef6058205425cc")
print(request.readAll())
request.close()
