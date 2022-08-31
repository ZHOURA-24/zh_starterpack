local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('zhoura:client:opengaragemenu', function()
	local option = {}
        for k,v in pairs(Garages) do
            table.insert(option, {
                value = tostring(k), text = v.label
            })
        end
    local dialog = exports['qb-input']:ShowInput({
        header = Config.lang.Header,
        submitText = "Continue",
        inputs = {
            {
                text = Config.lang.Text, 
                name = "GarasiP", 
                type = "select", 
                options = option
            }
        }
    })
	local args = {
		GarasiP = dialog,
		args = args,
	}
    if dialog ~= nil then
        TriggerServerEvent("zhoura:server:redeemvehicle", args, item)
    end
end)
