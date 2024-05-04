cubzhMod = {}

cubzhMod.test = function(name)
    print("HELLO!")
end 

cubzhMod.lee = function() 
    print("Hello")
    -- File:OpenAndReadAll(function(success, result)
    --     -- success is a boolean
    --     if not success then
    --         print("Could not read file")
    --         return
    --     end
    --     -- the user has cancelled the file selection
    --     if result == nil then
    --         print("No file selected")
    --         return
    --     end
    --     local str = result:ToString()
    --     print("Content: ", str)
    -- end)
end

Client.OnStart = function() 
    local uikit = require("uikit")
    local textInput = uikit.createTextInput("", "Type the image here", "default")
    local btn = uikit:createButton("send")
    local fileName = ""
    if textInput._text == "babyJoda" then 
        fileName = "babyJoda"
    end
    if textInput._text == "chiwaka" then 
        fileName = "chiwaka"
    end
    if textInput._text == "luke" then 
        fileName = "luke"
    end
    if textInput._text == "maestro" then 
        fileName = "maestro"
    end
    if textInput._text == "noidea" then 
        fileName = "noidea"
    end
    if textInput._text == "r2d2" then 
        fileName = "r2d2"
    end
    -- btn.OnRelease = function() 
    --     local e = Event()
    --     e.action = "image_requested"
    --     e.someMessage = fileName
    --     e:SendTo(Server)
    -- end
end

-- Client.DidReceiveEvent = function(event) 
--     local url = "github.com/vectorardev/cubzh-module/cubzh-module/inventory-images/" + event. + ".png"
--     HTTP:Get(url, function(res)
--         if res.StatusCode ~= 200 then 
--             print("Error " .. res.StatusCode)
--         else 
--             print(res.Body)
--         end
--     end)
-- end

-- Server.OnStart = function() 
--     local rootImages = "github.com/vectorardev/cubzh-module/cubzh-module/inventory-images/"
--     local babyJoda = KeyValueStore("babyJoda")
--     local chiwaka = KeyValueStore("chiwaka")
--     local luke = KeyValueStore("luke")
--     local maestro = KeyValueStore("maestro")
--     local noidea = KeyValueStore("noidea")
--     local r2d2 = KeyValueStore("r2d2")
--     babyJoda:Set(rootImages + "babyJoda.png")
--     babyJoda:Set(rootImages + "chiwaka.png")
--     babyJoda:Set(rootImages + "luke.png")
--     babyJoda:Set(rootImages + "maestro.png")
--     babyJoda:Set(rootImages + "noidea.png")
--     babyJoda:Set(rootImages + "r2d2.png")
-- end

-- Server.DidReceiveEvent = function(event) 
--     print("Event received: ", event)
--     -- send request for the image
--     -- assuming all are PNG's. 
--     if(event.action == "image_requested") then 
--         local store = KeyValueStore(event.someMessage)
--         store:Get(event.someMessage)
--     end
-- end

return cubzhMod