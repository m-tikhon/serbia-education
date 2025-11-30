set HASS_TOKEN="..."
set HASS_ADDR=https://...

set url="%HASS_ADDR%/api/states/binary_sensor.0x08ddebfffea51992_occupancy"
curl "%url%" -H "Authorization: Bearer %HASS_TOKEN%"
:: | jq '.'
