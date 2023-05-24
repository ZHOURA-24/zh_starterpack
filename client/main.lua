RegisterNetEvent('zh-vehbox:client:ClaimVehicle', function()
    local pedCoords = GetEntityCoords(cache.ped)
    local heading = GetEntityHeading(cache.ped)
    if Config.Vehbox.spawn and not Config.Vehbox.use_garage then
        lib.callback('zh-vehbox:server:ClaimVehicle', false, function(props)
            if props then
                Framework.SpawnVehicle(Config.Vehbox.model, pedCoords, heading, function(veh)
                    lib.setVehicleProperties(veh, props)
                    SetPedIntoVehicle(cache.ped, veh, -1)
                    lib.notify({
                        title = 'ZH VEHBOX',
                        description = string.format('Success Claim vehicle plate : %s', props.plate),
                        type = 'success'
                    })
                end)
            end
        end, Config.Vehbox.model, nil)
    elseif Config.Vehbox.use_garage then
        local options = {}
        for k, v in pairs(Config.Garages) do
            options[#options + 1] = {
                value = tostring(k),
                label = v.label or k
            }
        end
        local input = lib.inputDialog('Select Garages', {
            {
                type = 'select',
                options = options,
                icon = 'warehouse',
                required = true
            },
        })
        if not input then return end
        lib.callback('zh-vehbox:server:ClaimVehicle', false, function(props)
            if props then
                lib.notify({
                    title = 'ZH VEHBOX',
                    description = string.format('Success Claim vehicle plate : %s', props.plate),
                    type = 'success'
                })
            end
        end, Config.Vehbox.model, tostring(input[1]))
    end
end)
