cubzhMod = {}

cubzhMod.test = function()
    print("HELLO! Testing")
end 

cubzhMod.create = function(_) 
    print("HOlaaaa")
end 

Client.OnStart = function() 
    File:OpenAndReadAll(function(success, result)
        -- success is a boolean
        if not success then
          print("Could not read file")
          return
        end
      
        -- the user has cancelled the file selection
        if result == nil then
          print("No file selected")
          return
        end
      
        -- result is a Data instance
        local str = result:ToString()
        print("Content: ", str) 
      end)
end

return cubzhMod