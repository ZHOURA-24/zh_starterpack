if Framework.ESX() then
    local ESX = exports['es_extended']:getSharedObject()

    function Framework.GetPlayer(src)
        return ESX.GetPlayerFromId(src)
    end

    function Framework.SetVehicleOwned(src, model, properties, garage, state)
        local xPlayer = ESX.GetPlayerFromId(src)
        MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, parking) VALUES (?, ?, ?, ?, ?)',
            {
                xPlayer.identifier,
                properties.plate,
                json.encode(properties),
                state,
                garage
            }
        )
    end

    function Framework.IsPlateReady(plate)
        local result = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', { plate })
        if result then
            return true
        end
        return false
    end

    function Framework.CreateUsableItem(item, cb)
        ESX.RegisterUsableItem(item, cb)
    end
end

if Framework.QBCore() then
    local QBCore = exports['qb-core']:GetCoreObject()

    function Framework.GetPlayer(src)
        local player = QBCore.Functions.GetPlayer(src)
        local self = {}
        self.getMeta = function(key)
            return player.PlayerData.metadata[key]
        end
        self.setMeta = function(key, value)
            player.Functions.SetMetaData(key, value)
        end
        self.addInventoryItem = function(item, amount)
            player.Functions.AddItem(item, amount)
        end
        self.removeInventoryItem = function(item, amount)
            player.Functions.RemoveItem(item, amount)
        end
        return self
    end

    function Framework.SetVehicleOwned(src, model, properties, garage, state)
        local Player = QBCore.Functions.GetPlayer(src)
        MySQL.insert(
            'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state, garage) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                model,
                properties.model,
                json.encode(properties),
                properties.plate,
                state,
                garage
            }
        )
    end

    function Framework.IsPlateReady(plate)
        local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result then
            return true
        end
        return false
    end

    function Framework.CreateUsableItem(item, cb)
        QBCore.Functions.CreateUseableItem(item, cb)
    end
end
