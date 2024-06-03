return {
    ---@type string
    item = 'box_starterpack',
    ---@type boolean
    give_item = true, -- if true it will give items
    ---@type boolean
    give_item_new_player = true,
    ---@type boolean
    one_time_use = true, -- if true it will only use one time
    vehicle = {
        ---@type string[]
        models = { "dubsta", "guardian", "enduro" },
        ---@type boolean
        use_garage = true,    -- if true it will use garages options
        ---@type boolean
        use_all_models = true -- if false it will only use the first model in models
    },
    ---@type { [string]: number }
    items = { -- if giveitem is true it will give items
        water = 10,
        bread = 10,
        phone = 1
    },
    ---@param title string
    ---@param description string
    ---@param type string
    notify = not IsDuplicityVersion() and function(title, description, type)
        lib.notify({ title = title, description = description, type = type })
    end,
    ---@return { value: string, label: string }[]
    get_garage = not IsDuplicityVersion() and function() -- garage options
        local options = {}
        if GetResourceState("esx_garage") ~= "missing"  then
            require '@esx_garage.config'
            for k, v in pairs(Config.Garages) do
                table.insert(options, {
                    value = tostring(k),
                    label = v.label or k
                })
            end
        elseif GetResourceState("qb-garages") ~= "missing" then
            require '@qb-garages.config'
            for k, v in pairs(Config.Garages) do
                table.insert(options, {
                    value = tostring(k),
                    label = v.label or k
                })
            end
        end
        return options
    end
}
