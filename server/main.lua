local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end

for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
    local generatedPlate
    generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))
    local check = Framework.IsPlateReady(generatedPlate)
    if check then
        return GeneratePlate()
    end
    return generatedPlate
end

function GetRandomNumber(length)
    Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

function GetRandomLetter(length)
    Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

Framework.CreateUsableItem('boxvehicle', function(source)
    TriggerClientEvent('zh-vehbox:client:ClaimVehicle', source)
end)

lib.callback.register('zh-vehbox:server:ClaimVehicle', function(source, model, garage, state)
    local src = source
    local plate = GeneratePlate()
    local props = {
        model = GetHashKey(model),
        plate = plate
    }
    Framework.SetVehicleOwned(source, model, props, garage, state)
    Framework.RemoveItem(src, 'boxvehicle', 1)
    return props
end)
