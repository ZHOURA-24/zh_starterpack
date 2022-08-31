local QBCore = exports['qb-core']:GetCoreObject()

local function RandomPlate()
    local plate = Config.Plate..QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return RandomPlate()
    else
        return plate:upper()
    end
end

local function GiveVehicle(pData, garage)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local plate = RandomPlate()
    local vehicle = Config.Vehicle
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
        pData.PlayerData.license,
        cid,
        vehicle,
        GetHashKey(vehicle),
        '{}',
        plate,
        garage,
        1
    })
    Player.Functions.RemoveItem("boxvehicle", 1)
    TriggerClientEvent('QBCore:Notify', src, 'Success Claim' ..vehicle.. " Plate "..plate.." Di Garasi "..garage, 'success')
end

QBCore.Functions.CreateUseableItem("boxvehicle", function(source)
    TriggerClientEvent("zhoura:client:opengaragemenu", source)
end)

RegisterNetEvent('zhoura:server:redeemvehicle', function(args)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    GiveVehicle(Player, args.GarasiP.GarasiP)
end)
 