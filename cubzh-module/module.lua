cubzhMod = {}

inventory_list = {}
inventory_list["babyJoda"] = false
inventory_list["chiwaka"] = false
inventory_list["luke"] = false
inventory_list["maestro"] = false
inventory_list["noidea"] = false
inventory_list["r2d2"] = false

function printItems(results) 
    for k,v in pairs(results) do 
        for n,r in pairs(v) do 
            print("N and R are: ", r)
        end
    end
end

cubzhMod.createAndInitButtonsTesting = function(name1, name2)
    local ui = require("uikit")
    btn = ui:createButton(name1)
    btn.onRelease = function()
        local ev = Event()
        ev.action = "Reset"
        ev:SendTo(Server)
    end
    btn2 = ui:createButton(name2)
    btn2.Position = btn.Position + Number3(btn.Width, 0, 0)
    btn2.onRelease = function()
        local ev = Event()
        ev.action = "Print"
        ev:SendTo(Server)
    end
end

--make a function to check if the player has entered before
-- or not
cubzhMod.serverReceiveEventForData = function(event)
    -- using my own nickname to test the code
    local store = KeyValueStore("vectorwins")
    print("La concha de su madre")
    if event.action == "Reset" then
        -- Get the items and change the result ? 
        store:Get("items", function(success, results) 
            if success then 
                printItems(results)
            end
        end)
        store:Set("items", {}, function(success) 
            if success then 
                print("Tabla borrada")
            end
        end)
    end
    if event.action == "Print" then 
        printItems(results)
    end
end

--- This function is executed inside Server.OnPlayerJoin
cubzhMod.testingPlayer = function(u)
    local store = KeyValueStore(username)
    print("My name is: ", u)
    store:Get("items", function(success, results) 
        print("player joined was: ", success)
        if success then 
            --- The player does exist in the KeyValue thing ? 
            local count = 0
            for k,v in pairs(results) do
                if k == "items" then
                    for n,s in pairs(v) do 
                        count = count + 1
                    end
                end
            end
            if count > 0 then   
                print("Jugador con nombre: ", username, "tiene items")
            else 
                print("Jugador con nombre: ", username, "es nuevo en la sala")
            end
            if count == 0 then 
                print("The table is empty")
                store:Set("items", inventory_list, function(success) 
                    if success then
                        print("The table was set for the first time")
                        store:Get("items", function(success, results)
                            if success then 
                                printItems(results)
                            end
                        end)
                    else
                        print("The table couldn't be filled for the first time")
                    end
                end)
            else 
                print("count is not equal to 0, so the player has items")
                for k,v in pairs(results) do 
                    for r,s in pairs(v) do 
                        print(s, "with value: ", r)
                    end
                end
            end
        end
    end)
end

cubzhMod.sendRequestForImage = function() 
       -- Read the files of the images in the folder
       images = {}
       cubzhMod.showInventory()
       --- Setting UI system
       ui = require("uikit")
       --- 
       local inputText = ui:createTextInput("", "Type here", "default")
       local btn = ui:createButton("Send")
       -- btn:setParent(ui.rootFrame)
       btn.Position = Number2(200, 0) 
       ---
       local urlImages = "https://raw.githubusercontent.com/vectorardev/cubzh-module/master/cubzh-module/inventory-images/"
       local fileType = ".png" 
       local fileName = ""
       btn.onRelease = function() 
           local t = inputText.Text
           if t == "babyJoda" then 
               fileName = "babyJoda"
           end
           if t == "chiwaka" then 
               fileName = "chiwaka"
           end
           if t == "luke" then 
               fileName = "luke"
           end
           if t == "maestro" then 
               fileName = "maestro"
           end
           if t == "noidea" then 
               fileName = "noidea"
           end
           if t == "r2d2" then 
               fileName = "r2d2"
           end
           local finalUrl = urlImages .. fileName .. fileType
           HTTP:Get(finalUrl, function(res)
               if res.StatusCode == 200 then
                   print("The URL IS GOOD")
                   -- show the content of the image. 
                   print(res.Body)
                   -- conver the table to a quad ? 
                   local quad = Quad()
                   quad.Width = 20
                   quad.Height = 20
                   quad.Image = res.Body 
                   quad:SetParent(Player)
               else
                   print("CAN'T FIND THE URL")
               end
           end)
       end
end

return cubzhMod