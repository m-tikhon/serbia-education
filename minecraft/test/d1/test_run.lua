print('Hello')

--shell.run('d1/test_s1.lua> d1/out.log')
--shell.run('d1/test_s1.lua > out.log')

local fn, err = loadfile("d1/test_app.lua")

if fn then
    print('Loaded')
else
    print('Load error')
    local f = fs.open("d1/error.log", "w")
    f.write("LOAD ERROR:\n" .. tostring(err))
    f.close()
    return
end

local ok, runtimeErr = pcall(fn)
if ok then
    print('Run ok')
else
    print('Run error', runtimeErr)
    local f = fs.open("d1/error.log", "w")
    f.write("RUNTIME ERROR:\n" .. tostring(runtimeErr))
    f.close()
end
