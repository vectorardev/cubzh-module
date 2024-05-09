cubzhMod = {}

-- inventory_list = {}
-- inventory_list["babyJoda"] = false
-- inventory_list["chiwaka"] = false
-- inventory_list["luke"] = false
-- inventory_list["maestro"] = false
-- inventory_list["noidea"] = false
-- inventory_list["r2d2"] = false

-- cubzhMod.test = function()
--     print("HELLO! Testing")
-- end 

-- cubzhMod.create = function(_) 
--     print("HOlaaaa")
-- end 
-- how to make an array or map in lua 
-- cubzhMod.listItems = function()
--     -- Here we need to list the items that the player can buy and their states. 
--     -- for this we need an object which holds the item ?, no, we just need an array that has the list of items and its state. 
-- end

cubzhMod.showInventory = function()
    --- Show Quad or Shape for the background 
    --- Display all the items available. 

    --- These items can be purchased or not. 
    --- Object that has the item, string name, image, button 
    ui = require("uikit")
    bg = ui:createFrame(Color.Red)
    bg.Width = 300
    bg.Height = 300 
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

--- Server Code --- 

-- Server.OnPlayerJoined = function(newPlayer) 
--     print(newPlayer.Username)
--     local store = KeyValueStore(newPlayer.Username)
--     -- tabla items ? 
--     store:get("items", function(success, results)
--         if success then 
--             print("Exist in the database")
--         else
--             print("Doesnt exist in the database")
--     end)

-- end

-- Server.OnStart = function()
--     -- set here the items ? if locally 
--     -- once the items, if new player saved a list for the player with KeyValueStore. 
--     -- how we know how the player is called? We need to receive or either call Player class
--     -- if existing player, just check the list
-- end

return cubzhMod