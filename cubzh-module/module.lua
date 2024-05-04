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
    local uikit = require("uikit")
    local inputText = uikit:createTextInput("", "Type here", "default")
    local btn = uikit:createButton("Send")
    btn.Position = Number2(200, 0) 
    local boton = uikit:createButton("Send")
    boton.Position = Number2(500, 500)
    boton.OnPress = function () 
        print("Hola que tal?=???? ")
    end
    ---
    local urlImages = "https://raw.githubusercontent.com/vectorardev/cubzh-module/master/cubzh-module/inventory-images/"
    local fileType = ".png" 
    local fileName = ""
    btn.OnRelease = function(_) 
        print("LA CONCHA DE TU MADRE") 
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
    ---


end

return cubzhMod