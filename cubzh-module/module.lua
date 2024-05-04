cubzhMod = {}

cubzhMod.test = function()
    print("HELLO! Testing")
end 

cubzhMod.create = function(_) 
    print("HOlaaaa")
end 

cubzhMod.sendRequestForImage = function() 
       -- Read the files of the images in the folder
       images = {}
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
           print("Helloooooooo") 
           print("The input text inside is: ", inputText.Text)
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
           print("The url was: ", finalUrl)
           HTTP:Get(finalUrl, function(res)
               if res.StatusCode == 200 then
                   print("The URL IS GOOD")
                   -- show the content of the image. 
                   print(res.Body)
                   -- conver the table to a quad ? 
                   local quad = Quad()
                   quad.Width = 100
                   quad.Height = 100
                   quad.Anchor = { 0.5, 0 }
                   quad.Image = res.Body 
                   quad:SetParent(Player) 
                   quad.Position = {0, 0, 0} 
               else
                   print("CAN'T FIND THE URL")
               end
           end)
       end
end

return cubzhMod