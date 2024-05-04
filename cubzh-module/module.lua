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
    local urlImages = "https://github.com/vectorardev/cubzh-module/tree/7ad4f4d0370d8164735800ff6051b50c9025ce58/cubzh-module/inventory-images"
    HTTP:Get(urlImages, function(res)
        if res.StatusCode == 200 then
            print("The URL IS GOOD")
        else
            print("CAN'T FIND THE URL")
        end
    end)
end

return cubzhMod