cubzhMod = {}

cubzhMod.test = function()
    print("HELLO! Testing")
end 

cubzhMod.create = function(_) 
    print("HOlaaaa")
end 


Client.OnStart = function() 
    -- Read the files of the images in the folder
    images = {}
    --- Setting UI system
    ui = require("uikit")
    --- 
    local inputText = ui:createTextInput("", "Type here", "default")
    local btn = Button("Send")
    -- btn:setParent(ui.rootFrame)
    btn.Position = Number2(200, 0) 
    ---
    local urlImages = "https://raw.githubusercontent.com/vectorardev/cubzh-module/master/cubzh-module/inventory-images/"
    local fileType = ".png" 
    local fileName = ""

    btn.OnPress = function(_) 
        print("Helloooooooo") 
        if inputText._text == "babyJoda" then 
            fileName = "babyJoda"
        end
        if inputText._text == "chiwaka" then 
            fileName = "chiwaka"
        end
        if inputText._text == "luke" then 
            fileName = "luke"
        end
        if inputText._text == "maestro" then 
            fileName = "maestro"
        end
        if inputText._text == "noidea" then 
            fileName = "noidea"
        end
        if inputText._text == "r2d2" then 
            fileName = "r2d2"
        end
        local finalUrl = urlImages .. fileName .. fileType
        HTTP:Get(finalUrl, function(res)
            if res.StatusCode == 200 then
                print("The URL IS GOOD")
                -- show the content of the image. 
                print(res.Body)
            else
                print("CAN'T FIND THE URL")
            end
        end)
    end

end

return cubzhMod