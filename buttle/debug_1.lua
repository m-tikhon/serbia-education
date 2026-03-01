debug_enabled = true


function debug(str)
    if debug_enabled then
        print(str)
    end
end


function test_change(my_var)
    debug('my_var=' .. tostring(my_var))
    my_var = 10
    debug('my_var after update=' .. tostring(my_var))
end


function do_test()
    local mmm = 5
    debug('mmm before update=' .. tostring(mmm))
    test_change(mmm)
    debug('mmm after update=' .. tostring(mmm))
end


-- ===================================================

function test_change_table(my_var)
    debug('my_var=' .. tostring(my_var.var1))
    my_var.var1 = 10
    debug('my_var after update=' .. tostring(my_var.var1))
    return 7
end


function do_test_table()
    local mmm = {}
    mmm.var1 = 5
    debug('mmm before update=' .. tostring(mmm.var1))
    local mmm2 = test_change_table(mmm)
    debug('mmm after update=' .. tostring(mmm.var1))
end


-- ====================================================

function test_for()
    for x=1,10 do
        debug('x=' .. x)
    end
    debug('x after for =' .. tostring(x))
end

test_for()
