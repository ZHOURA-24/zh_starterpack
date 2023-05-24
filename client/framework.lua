if Framework.ESX() then
    local ESX = exports['es_extended']:getSharedObject()
    function Framework.SpawnVehicle(model, coords, heading, cb)
        ESX.Game.SpawnVehicle(model, coords, heading, cb)
    end

    function Framework.TriggerServerCallBack(event, arg)
        ESX.TriggerServerCallback(event, function(result)
            return result
        end, arg)
    end
end

if Framework.QBCore() then
    local QBCore = exports['qb-core']:GetCoreObject()
    function Framework.SpawnVehicle(model, coords, heading, cb)
        QBCore.Functions.SpawnVehicle(model, cb, coords, true, false)
    end

    function Framework.TriggerServerCallBack(event, arg)
        QBCore.Functions.TriggerCallback(event, function(result)

        end, arg)
    end
end
