local cubzhMod = {}

cubzhMod.test = function()
    print("HELLO! Testing")
end 

cubzhMod.test2 = function() 
    print("HELLO!")
end

cubzhMod.carlos = function() 
    cubzhMod.test2()
    cubzhMod.test()
end

return cubzhMod