
--url=HASS_ADDR .. "/api/services/input_boolean/turn_on"
--url_headers={["Authorization"]="Bearer "..LONG_LIVING_TOKEN}
--response = http.get(url,{headers = {['Authorization'] = ""}})
--response=http.get(url,{headers=url_headers})
--print(response)

HASS_ADDR="..."
LONG_LIVING_TOKEN="..."
action="toggle"
url=HASS_ADDR .. "/api/services/input_boolean/"..action
url_headers={Authorization="Bearer "..LONG_LIVING_TOKEN}
url_body='{"entity_id": "input_boolean.bedroom_light_onoff"}'
--headers,response=http.post(url, url_body, url_headers)
headers,response=http.post{url=url, body=url_body, headers=url_headers}
print(headers)
print(response)

