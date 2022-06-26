local function getIP(ID)
    if player.is_player_valid(ID) then
        local playerip = player.get_player_ip(ID)
        return string.format('%i.%i.%i.%i', (playerip >> 24) & 0xff, ((playerip >> 16) & 0xff), ((playerip >> 8) & 0xff), playerip & 0xff)
    else
        return -1
    end
end

local iplookup = menu.add_player_feature("IP Lookup", "action_value_str", 0, function(f, id)
    if not menu.is_trusted_mode_enabled(1 << 3) then
        menu.notify('Not available while trusted mode for http is turned off')
        return
    end
    
    local IP = getIP(id)
    local State, Result = web.get("http://ip-api.com/csv/" .. IP)

    if State ~= 200 then
        menu.notify('IP lookup failed. Error code: ' .. State)
        return
    end

    local parts = {}
    for part in Result:gmatch("[^,]+") do
        parts[#parts + 1] = part
    end

    local Success = parts[1]
    if Success == 'fail' then
        menu.notify('IP lookup failed')
        return
    end

    local name = player.get_player_name(id)
    local Data = 'Country : ' .. parts[2] .. ' [' .. parts[3] .. ']\n' ..
    'Region: ' .. parts[5] .. ' [' .. parts[4] .. ']\n' ..
    'City: ' .. parts[6] .. '\n' ..
    'Zip Code: ' .. parts[7] .. '\n' ..
    'Coords: ' .. parts[8] .. '/' .. parts[9] .. '\n' ..
    'Continent: ' .. parts[10] .. '\n' ..
    'Provider: ' .. parts[11]
    
    if f.value == 0 then
        menu.notify('IP Address : ' .. IP .. '\n' .. Data, 'IP Lookup for ' .. name)
    elseif f.value == 1 then
        utils.to_clipboard('IP Lookup for ' .. name .. '\nIP Address : ' .. IP .. '\n' .. Data)
    elseif f.value == 2 then
        network.send_chat_message('IP Lookup for ' .. name .. '\nIP Address : ' .. IP .. '\n' .. Data, false)
    end
end)
iplookup:set_str_data({'Notify', 'Copy to Clipboard', 'Send in Chat'})
