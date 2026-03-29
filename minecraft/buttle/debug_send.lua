channel = 15
replyChannel = 43
scan_data = {{true, false, true}, 
             {false, false, true}}


local modem = peripheral.find("modem") or error("No modem attached", 0)


modem.open(replyChannel) -- Open 43 so we can receive replies

-- Send our message
modem.transmit(channel,replyChannel ,scan_data )

-- And wait for a reply




