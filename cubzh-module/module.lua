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
            print("N and R are: ", n, r)
        end
    end
end

cubzhMod.createAndInitButtonsTesting = function(name1, name2, playerName)
    local ui = require("uikit")
    local store = KeyValueStore(playerName)
    btn = ui:createButton(name1)
    btn.onRelease = function()
		--- Get the items and change the result ? 
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
    btn2 = ui:createButton(name2)
    btn2.Position = btn.Position + Number3(btn.Width, 0, 0)
    btn2.onRelease = function()
		--- Get the items and change the result ? 
		store:Get("items", function(success, results)
            if success then
                printItems(results)
            end
		end)
    end
end

--make a function to check if the player has entered before
-- or not
cubzhMod.serverReceiveEventForData = function(event)
    local store = KeyValueStore(event.playerName)
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

inventory_ui = {}

inventory_ui.state = false

inventory_ui.item = function(color, imageUrl, text, position, purchasedOrNot)
    -- Create the frame for the item
    local margin = 10
    local ui = require("uikit")
    bg = ui:createFrame(color)
    bg.Width = 200
    bg.Height = 75
    bg.Position = position
    -- Create the image inside the frame to display the item 
    image = ui:createFrame(Color.White)
    image.Width = 65
    image.Height = 65
    image.Position = bg.Position + Number3(image.Width/2+margin, 0, 0)
    -- image:SetParent(bg) [object:SetParent] argument 1 should have Object component
    -- Make a http or get the image from the repo (sendRequestForImage)
    -- Set the text of the item
    itemName = ui:createText(text)
    -- itemName:SetParent(bg)
    -- itemName:SetColor(Color.black)
    itemName.Position = bg.Position + Number3(bg.Width/2, 0, 0)
    -- create the button to purchase the item
    local buttonName = ""
    if purchasedOrNot then
        buttonName = "Purchased"
    else
        buttonName = "Buy"
    end
    purchaseButton = ui:createButton(buttonName)
    -- purchaseButton:SetParent(bg)
    purchaseButton.Position = bg.Position + Number3(bg.Width-purchaseButton.Width/2-margin,0,0)
end

inventory_ui.init = function(items)
    -- Create the frame and have the set the properties (bg)
    if items then 
        print("Intiating the inventory_ui")
    else 
        print("items is not valid")
        return
    end
    local ui = require("uikit")
    inventory_ui.bg = ui:createFrame(Color(92, 179, 219))
    inventory_ui.bg.Width = 300
    inventory_ui.bg.Height = 500
    inventory_ui.bg.Position = Number3(Screen.Width / 2 - inventory_ui.bg.Width / 2, Screen.Height / 2 - inventory_ui.bg.Height / 2, 0) 
    -- display items received and put them as a child of the frame
    -- items is a table with {key: string, value: bool}
    local itemCount = 0
    for k,v in pairs(items) do
        for n,r in pairs(v) do
            itemCount = itemCount + 50
            ---Number3(inventory_ui.bg.Width / 2 + 10, inventory_ui.bg.Height / 2 + 10, 0)
            inventory_ui.item(Color.Green, "nil", n, inventory_ui.bg.Position + Number3(50, itemCount, 0), r)
        end
    end
end

inventory_ui.toggleHide = function() 
    if inventory_ui.bg then 
        inventory_ui.state = not inventory_ui.state
        if inventory_ui.state then
            inventory_ui.bg:setColor(Color.Red)
        else
            inventory_ui.bg:setColor(Color(0,0,0,0))
        end
    else
        print("inventory_ui.bg is nil")
    end
end

--- This function is executed inside Server.OnPlayerJoin
cubzhMod.initOrGetPlayer = function(u)
    print("My name is: ", u)
    local store = KeyValueStore(u)
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
                print("Jugador con nombre: ", u, "tiene items")
            else 
                print("Jugador con nombre: ", u, "es nuevo en la sala")
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
                printItems(results)
                inventory_ui.init(results)
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