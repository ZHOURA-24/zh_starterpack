if Framework.ESX() then
    local ESX = exports['es_extended']:getSharedObject()
    function Framework.SpawnVehicle(model, coords, heading, cb)
        ESX.Game.SpawnVehicle(model, coords, heading, cb)
    end
end

if Framework.QBCore() then
    local QBCore = exports['qb-core']:GetCoreObject()
    function Framework.SpawnVehicle(model, coords, heading, cb)
        QBCore.Functions.SpawnVehicle(model, cb, coords, true, false)
    end
end
