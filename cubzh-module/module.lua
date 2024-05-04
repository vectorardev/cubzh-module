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
    local urlImages = "https://raw.githubusercontent.com/vectorardev/cubzh-module/master/cubzh-module/inventory-images/"
    local uikit = require("uikit")
    local inputText = uikit:createTextInput("", "Type here", "default")
    local btn = uikit:createButton("Send")
    local fileType = ".png" 
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
    local finalUrl = urlImages .. fileName .. fileType
    btn.OnRelease = function() 
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