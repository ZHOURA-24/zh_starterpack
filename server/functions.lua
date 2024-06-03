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

--- Credit: https://github.com/Qbox-project/qbx_core/blob/34efde8d3b0de9c5125ababc07099f7f1b962227/modules/lib.lua#L232
function SpawnVehicle(model, coords, props)
    local tempVehicle = CreateVehicle(model, 0, 0, -200, 0, true, true)
    while not DoesEntityExist(tempVehicle) do Wait(0) end
    local vehicleType = GetVehicleType(tempVehicle)
    DeleteEntity(tempVehicle)

    local veh = CreateVehicleServerSetter(model, vehicleType, coords.x, coords.y, coords.z, coords.w)
    while not DoesEntityExist(veh) do Wait(0) end
    while GetVehicleNumberPlateText(veh) == '' do Wait(0) end
    local state = Entity(veh).state
    state:set('setVehicleProperties', props, true)

    lib.waitFor(function()
        if state.setVehicleProperties then return false end
        return true
    end, 'Failed to set vehicle properties', 5000)

    return veh
end
