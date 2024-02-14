local zone = require'/dynamic/zone/code.lua'
local child_zone = require'/dynamic/zone/child/code.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'

local zone_manager = {zones = {},player_in_zone = false}

function zone_manager.new_zone(x,y,m_id,index)
    local z = zone:new(x,y,m_id,index)
    table.insert(zone_manager.zones,{z,nil,false})
    return z
end

function zone_manager.manage()
    for i = 1, #zone_manager.zones do
        if zone_manager.zones[i][1].player_inside then
            gh.player_inside = true
            return
        end
    end
    gh.player_inside = false
end

function zone_manager.new_zone_child(buff,index,time_to_live)
    local z
    if buff == "shield" then
        z = child_zone:new(zone_manager.zones[index][1],buff,time_to_live)
    else
        z = child_zone:new(zone_manager.zones[index][1],buff,time_to_live)
    end
    zone_manager.zones[index][2] = z
end

return zone_manager