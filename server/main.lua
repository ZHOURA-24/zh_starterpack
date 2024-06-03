local config = require 'shared.config'

lib.callback.register('zh_starterpack:server:ClaimVehicle', function(source, model, garage, state, spawn)
    local player = Framework.GetPlayer(source)
    if config.one_time_use then
        if player then
            if player.getMeta('zh_starterpack') == 1 then
                return false, 'You already claim the starterpack'
            end
            player.setMeta('zh_starterpack', 1)
        end
    end
    if config.give_item then
        if player then
            for k, v in pairs(config.items) do
                player.addInventoryItem(k, v)
            end
        end
    end
    local plate = GeneratePlate()
    local props = {
        model = joaat(model),
        plate = plate
    }
    Framework.SetVehicleOwned(source, model, props, garage, state)
    if spawn then
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        local playerHeading = GetEntityHeading(ped)
        local coords = vec4(playerCoords.x, playerCoords.y, playerCoords.z, playerHeading)
        local vehicle = SpawnVehicle(props.model, coords, props)
        if vehicle then
            SetPedIntoVehicle(ped, vehicle, -1)
        end
    end
    player.removeInventoryItem(config.item, 1)
    return true, 'Success Claim vehicle plate : ' .. plate
end)

RegisterCommand('resetstarterpack', function(source, args)
    local player = Framework.GetPlayer(source)
    if player then
        player.setMeta('zh_starterpack', 0)
    end
end, false)

if GetResourceState('ox_inventory') == 'missing' then
    Framework.CreateUsableItem('boxvehicle', function(source)
        TriggerClientEvent('zh_starterpack:client:GetStarterPack', source)
    end)
end

if config.give_item_new_player then
    if Framework.ESX() then
        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(_, xPlayer, isNew)
            if isNew then
                Wait(5000)
                xPlayer.addInventoryItem(config.item, 1)
            end
        end)
    end

    if Framework.QBCore() then
        RegisterNetEvent('qb-multicharacter:server:createCharacter', function()
            local src = source
            local player = Framework.GetPlayer(src)
            player.addInventoryItem(config.item, 1)
        end)
    end
end
