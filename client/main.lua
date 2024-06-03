local config = require 'shared.config'

---@return { model: string, garage?: string } | nil
local function DialogStarterPack()
    local modelOptions = {}
    local dialogs = {}
    if not config.vehicle.use_all_models and not config.vehicle.use_garage then
        return {
            model = config.vehicle.models[1]
        }
    end
    if config.vehicle.use_all_models then
        local models = config.vehicle.models
        for i = 1, #models, 1 do
            table.insert(modelOptions, {
                value = models[i],
                label = models[i]:upper()
            })
        end
        table.insert(dialogs, {
            type = 'select',
            options = modelOptions,
            icon = 'car',
            required = true,
            label = 'Select Model'
        })
    end
    if config.vehicle.use_garage then
        table.insert(dialogs, {
            type = 'select',
            options = config.get_garage(),
            icon = 'warehouse',
            required = true,
            label = 'Select Garage'
        })
    end
    local input = lib.inputDialog(config.vehicle.use_all_models and 'Select Garage and Models' or 'Select Garage',
        dialogs)
    if not input then return nil end
    local modelSelected = input[1]
    local garageSelected = input[2]
    return { model = modelSelected, garage = garageSelected }
end

local function StarterPackAction()
    local result = DialogStarterPack()
    if not result then return end
    lib.callback('zh_starterpack:server:ClaimVehicle', false, function(success, message)
        config.notify('zh_starterpack', message, success and 'success' or 'error')
    end, result.model, result.garage, result.garage == nil and 0 or 1, result.garage == nil)
end

RegisterNetEvent('zh_starterpack:client:GetStarterPack', StarterPackAction)

if GetResourceState('ox_inventory') ~= 'missing' then
    exports('box_starterpack', StarterPackAction)
end

AddStateBagChangeHandler("setVehicleProperties", nil, function(bagName, _, props)
    if not props then
        return
    end
    local netId = tonumber(bagName:gsub('entity:', ''), 10)
    local vehicle = lib.waitFor(function()
        if NetworkDoesEntityExistWithNetworkId(netId) then
            return NetworkGetEntityFromNetworkId(netId)
        end
    end, ('statebag timed out while awaiting entity creation! (%s)'):format(bagName), 10000)
    SetTimeout(0, function()
        local state = Entity(vehicle).state
        local timeOut = GetGameTimer() + 10000
        while state.setVehicleProperties do
            if NetworkGetEntityOwner(vehicle) == cache.playerId then
                if lib.setVehicleProperties(vehicle, props) then
                    state:set('setVehicleProperties', nil, true)
                end
            end
            if GetGameTimer() > timeOut then
                break
            end
            Wait(50)
        end
    end)
end)
