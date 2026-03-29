package.cpath = package.cpath .. ';C:/Users/tikho/AppData/Roaming/JetBrains/PyCharm2025.3/plugins/IntelliJ-EmmyLua/debugger/emmy/windows/x64/?.dll'
local dbg = require('emmy_core')
dbg.tcpListen('localhost', 9966)


-- Load the debugger module
--local dbg = require('emmy_core')

-- Start the TCP debug server
--dbg.tcpListen('localhost', 9966)

-- Wait for IDE connection
dbg.waitIDE()


A=1
print("Hello Tikhon " .. A)
B=2
print("Good bye Tikhon " .. B)
