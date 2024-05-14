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

inventory_ui.item = function(color, imageUrl, text, position, purchasedOrNot, playerName)
    -- Create the frame for the item
    local margin = 10
    local ui = require("uikit")
    bg = ui:createFrame(color)
    bg.Width = 250
    bg.Height = 65
    bg.Position = position
    -- Create the image inside the frame to display the item 
    local image = ui:createFrame(Color.White)
    image.Width = 50
    image.Height = 50
    local marginImage = (bg.Height - image.Height) / 2
    image.Position = bg.Position + Number3(marginImage, marginImage, 0)
    -- load imageurl on the frame (URL HTTP)
    local urlImages = "https://raw.githubusercontent.com/vectorardev/cubzh-module/master/cubzh-module/inventory-images/"
    local fileType = ".png" 
    local fileName = text -- we are assuming that text variable its the same as the file name in the repo
    local finalUrl = urlImages .. fileName .. fileType
    HTTP:Get(finalUrl, function(res)
        if res.StatusCode == 200 then
            image:setImage(res.Body)
        else
            print("CAN'T FIND THE URL")
        end
    end)
    -- image:SetParent(bg) [object:SetParent] argument 1 should have Object component
    -- Make a http or get the image from the repo (sendRequestForImage)
    -- Set the text of the item
    local itemName = ui:createText(text)
    -- itemName:SetParent(bg)
    -- itemName:SetColor(Color.black)
    local textX = bg.Width / 2 - itemName.Width / 2
    local textY = bg.Height / 2 - itemName.Height / 2
    itemName.Position = bg.Position + Number3(textX, textY, 0)
    -- create the button to purchase the item
    local buttonName = ""
    local purchaseButton = ui:createButton("")
    -- purchaseButton:SetParent(bg)
    purchaseButton.Position = bg.Position + Number3(bg.Width - purchaseButton.Width * 2 - margin, bg.Height / 2 - purchaseButton.Height / 2, 0)
    if purchasedOrNot then
        buttonName = "Own"
        purchaseButton.Text = buttonName
    else
        buttonName = "Buy"
        purchaseButton.Text = buttonName 
        --- test if we have purchased this item or not. 
        purchaseButton.onRelease = function()
            inventory_ui.purchaseItem(playerName, text, purchaseButton)
        end
    end
end

inventory_ui.purchaseItem = function(playerName, key, btn) 
    local store = KeyValueStore(playerName)
    store:Get("items", function(success, results) 
        if success and results then
            local items = nil
            for k,v in pairs(results) do 
                print("Tabla,", k,v)
                if k == "items" then
                    items = v or {}
                    break
                end
            end
            for l,d in pairs(items) do 
                print("Dime los valores,", l,d)
            end
            if items[key] ~= nil then 
                items[key] = true 
                store:Set("items", items, function(success) 
                    if success then
                        print(key .. " ha sido marcado como comprado.")
                        btn.Text = "Own"
                    else
                        print(key .. " ha sido marcado como comprado.")
                        btn.Text = "Error"
                    end
                end)
            else
                print("El item con nombre ", key, "no existe dentro de la tabla")
            end
        end
    end)
end

inventory_ui.init = function(items, playerName)
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
    local amountOfElements = 0 
    for k,v in pairs(items) do 
        for n,r in pairs(v) do 
            amountOfElements = amountOfElements + 1
        end
    end
    print("AmountOfElements: ", amountOfElements)
    local itemCount = 0
    local i = 0
    for k,v in pairs(items) do
        for n,r in pairs(v) do
            itemCount = i * 75
            inventory_ui.item(Color.Green, "nil", n, inventory_ui.bg.Position + Number3(25, 30 + itemCount, 0), r, playerName) --6*65 = 390, 75 - 65 = 10 * 5 = 50 = 60px restantes.
            i = i + 1
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
            end
            store:Get("items", function(success, updated_results) 
                if success then
                    inventory_ui.init(updated_results, u)
                end
            end)
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