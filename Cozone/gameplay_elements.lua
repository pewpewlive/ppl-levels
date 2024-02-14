local zm = require'/dynamic/zone/manager.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'
local ph = require'/dynamic/helpers/player_helpers.lua'
local gunner = require'/dynamic/enemies/gunner/code.lua'
local comet = require'/dynamic/enemies/comet/code.lua'
local planithrower = require'/dynamic/enemies/planithrower/code.lua'

children = {

}

m_types = {
    pewpew.MothershipType.SIX_CORNERS,
    pewpew.MothershipType.THREE_CORNERS,
}

m_types2 = {
    pewpew.MothershipType.SEVEN_CORNERS,
    pewpew.MothershipType.FIVE_CORNERS
}


b_types = {
    pewpew.BombType.SMALL_ATOMIZE,
    pewpew.BombType.FREEZE,
    pewpew.BombType.REPULSIVE,
}

weapon_setups = {
    {box_duration = 700, cannon = pewpew.CannonType.HEMISPHERE, frequency = pewpew.CannonFrequency.FREQ_5, weapon_duration = 110},
    {box_duration = 600, cannon = pewpew.CannonType.TRIPLE, frequency = pewpew.CannonFrequency.FREQ_15, weapon_duration = 310}
}

local function random_pos() 
    return gh.verify_position(fmath.random_fixedpoint(0fx, FX),fmath.random_fixedpoint(0fx, FY))
end

function add_cave()
    local id = pewpew.new_customizable_entity(FX/2fx, FY/2fx)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/graphics2.lua", 0)
end

function add_level_outlines(indexes)
    local ids = {}
    local ar,ag,ab,aa = 204, 104, 64, 50

    local er,eg,eb,ea = 150, 175, 255, 255

    local tr,tg,tb,ta = 255,0,0,255
    for i = 1, indexes do
        local t = gh.invLerp(1,indexes,i)
        local r,g,b,a = gh.lerpINT(ar,er,t)//1,gh.lerpINT(ag,eg,t)//1,gh.lerpINT(ab,eb,t)//1,gh.lerpINT(aa,ea,t)//1
        table.insert(ids,{pewpew.new_customizable_entity(0fx, 0fx),{r,g,b,a}})
        pewpew.customizable_entity_set_mesh(ids[i][1], "/dynamic/graphics.lua", i-1)
        pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(r,g,b,a))
    end

    local px,py = pewpew.entity_get_position(ph.player_ships[1])
    local player_warn = pewpew.new_customizable_entity(px, py)
    pewpew.customizable_entity_set_mesh(player_warn, "/dynamic/extra/danger_graphics.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(player_warn, true)

    local player_warn2 = pewpew.new_customizable_entity(px, py)
    pewpew.customizable_entity_set_mesh(player_warn2, "/dynamic/extra/danger_graphics.lua", 1)
    pewpew.customizable_entity_set_position_interpolation(player_warn2, true)
    local pcolor = 0x99ddff00
    local pcolorOpaque = 0x99ddffff
    local pcolor2 = 0xff805000
    local pcolorOpaque2 = 0xff8050ff
    
    local max_time = 35
    local interval = 15
    local damage_player = false
    local intertime = interval-1
    local time = 0
    local stop = false
    local function euc()
        if not pewpew.entity_get_is_alive(ph.player_ships[1]) then
            time = 0
            pewpew.customizable_entity_set_mesh_color(player_warn, pcolor)
            pewpew.customizable_entity_set_mesh_color(player_warn2, pcolor)
            stop = true
        end
        if stop then
            for i = 1, #ids do
                pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(ids[i][2][1],ids[i][2][2],ids[i][2][3],ids[i][2][4]))
            end
            return
        end
        px,py = pewpew.entity_get_position(ph.player_ships[1])
        pewpew.entity_set_position(player_warn, px, py)
        pewpew.entity_set_position(player_warn2, px, py)
        if gh.hypothermia_mode then
            if gh.player_inside then
                pewpew.customizable_entity_set_mesh_color(player_warn, pcolorOpaque2)
                pewpew.customizable_entity_set_mesh_color(player_warn2, pcolorOpaque2)
                pewpew.customizable_entity_add_rotation_to_mesh(player_warn, fmath.tau()/40fx, 0fx, 0fx, 1fx)
                pewpew.customizable_entity_add_rotation_to_mesh(player_warn2, -fmath.tau()/30fx, 0fx, 0fx, 1fx)
                time = time + 1
                local t = gh.invLerp(0,max_time,time)
                if t > 1 then t = 1 end
                for i = 1, #ids do
                    local r,g,b = gh.lerpINT(ids[i][2][1],tr,t)//1,gh.lerpINT(ids[i][2][2],tg,t)//1,gh.lerpINT(ids[i][2][3],tb,t)//1
                    pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(r,g,b,ids[i][2][4]))
                end
                if time >= max_time then
                    damage_player = true
                end
                if damage_player then
                    intertime = intertime + 1
                    if intertime % interval-2 == 0 then
                        pewpew.add_damage_to_player_ship(ph.player_ships[1], 1)
                    end
                end
                for i = 1, #zm.zones do 
                    local r,g,b = gh.lerpINT(zm.zones[i][1].red,tr,t)//1,gh.lerpINT(zm.zones[i][1].gre,tg,t)//1,gh.lerpINT(zm.zones[i][1].blu,tb,t)//1
                    pewpew.customizable_entity_set_mesh_color(zm.zones[i][1].entity_id, ch.make_color(r,g,b,255))
                end
            else
                for i = 1, #zm.zones do 
                    pewpew.customizable_entity_set_mesh_color(zm.zones[i][1].entity_id, ch.make_color(zm.zones[i][1].red,zm.zones[i][1].gre,zm.zones[i][1].blu,255))
                end
                pewpew.customizable_entity_set_mesh_color(player_warn, pcolor2)
                pewpew.customizable_entity_set_mesh_color(player_warn2, pcolor2)
                time = 0
                for i = 1, #ids do
                    pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(ids[i][2][1],ids[i][2][2],ids[i][2][3],ids[i][2][4]))
                end
                damage_player = false
                intertime = interval-1
            end
        else
            if gh.player_inside then
                pewpew.customizable_entity_set_mesh_color(player_warn, pcolor)
                pewpew.customizable_entity_set_mesh_color(player_warn2, pcolor)
                time = 0
                for i = 1, #ids do
                    pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(ids[i][2][1],ids[i][2][2],ids[i][2][3],ids[i][2][4]))
                end
                damage_player = false
                intertime = interval-1
                for i = 1, #zm.zones do 
                    pewpew.customizable_entity_set_mesh_color(zm.zones[i][1].entity_id, ch.make_color(zm.zones[i][1].red,zm.zones[i][1].gre,zm.zones[i][1].blu,255))
                end
            else
                pewpew.customizable_entity_set_mesh_color(player_warn, pcolorOpaque)
                pewpew.customizable_entity_set_mesh_color(player_warn2, pcolorOpaque)
                pewpew.customizable_entity_add_rotation_to_mesh(player_warn, fmath.tau()/40fx, 0fx, 0fx, 1fx)
                pewpew.customizable_entity_add_rotation_to_mesh(player_warn2, -fmath.tau()/30fx, 0fx, 0fx, 1fx)
                time = time + 1
                local t = gh.invLerp(0,max_time,time)
                if t > 1 then t = 1 end
                for i = 1, #ids do
                    local r,g,b = gh.lerpINT(ids[i][2][1],tr,t)//1,gh.lerpINT(ids[i][2][2],tg,t)//1,gh.lerpINT(ids[i][2][3],tb,t)//1
                    pewpew.customizable_entity_set_mesh_color(ids[i][1], ch.make_color(r,g,b,ids[i][2][4]))
                end
                if time >= max_time then
                    damage_player = true
                end
                if damage_player then
                    intertime = intertime + 1
                    if intertime % interval == 0 then
                        pewpew.add_damage_to_player_ship(ph.player_ships[1], 1)
                    end
                end
                for i = 1, #zm.zones do 
                    local r,g,b = gh.lerpINT(zm.zones[i][1].red,tr,t)//1,gh.lerpINT(zm.zones[i][1].gre,tg,t)//1,gh.lerpINT(zm.zones[i][1].blu,tb,t)//1
                    pewpew.customizable_entity_set_mesh_color(zm.zones[i][1].entity_id, ch.make_color(r,g,b,255))
                end
            end
        end
    end

    pewpew.entity_set_update_callback(ids[1][1], euc)
end

function add_gunner(amount)
    for i = 1, amount do
        local vx,vy = random_pos()
        gunner:new(vx,vy)
    end
end

local amount1,step1 = 2,0.05
function add_crowder(concentrated)
    local vx,vy = random_pos()
    for i = 1, amount1//1 do
        if not concentrated then
            vx,vy = random_pos()
        end
        pewpew.new_crowder(vx, vy)
    end
    amount1 = amount1 + step1
end

function add_crowder2(amount, concentrated)
    local vx,vy = random_pos()
    for i = 1, amount do
        if not concentrated then
            vx,vy = random_pos()
        end
        pewpew.new_crowder(vx, vy)
    end
end

local amount2,step2 = 3,0.03
function add_bafs_red()
    local angle_step = fmath.tau()/fmath.to_fixedpoint(amount2//1)
    local c_ang = 0fx
    local vx,vy = random_pos()
    for i = 1, (amount2//1) do 
        pewpew.new_baf_red(vx, vy, c_ang, 5fx, 450)
        c_ang = c_ang + angle_step
    end
    amount2 = amount2 + step2
end

local amount3,step3 = 4,0.04
function add_bafs_blue()
    local angle_step = fmath.tau()/fmath.to_fixedpoint(amount3//1)
    local c_ang = 0fx
    local vx,vy = random_pos()
    for i = 1, (amount3//1) do 
        pewpew.new_baf_blue(vx, vy, c_ang, 5fx, 700)
        c_ang = c_ang + angle_step
    end
    amount3 = amount3 + step3
end

function add_mothership(types)
    local rn = fmath.random_int(1, #types)
    local vx,vy = random_pos()
    pewpew.new_mothership(vx, vy, types[rn], fmath.random_fixedpoint(0fx, fmath.tau()))
end

function add_comet(amount)
    for i = 1, amount do
        local vx,vy = random_pos()
        comet.new(vx,vy,20fx,1fx)
    end
end

function add_asteroid(amount)
    for i = 1, amount do
        local vx,vy = random_pos()
        pewpew.new_asteroid(vx, vy)
    end
end

function add_pt()
    local vx,vy = random_pos()
    planithrower.new(vx,vy)
end

function add_rs()
    local vx,vy = random_pos()
    pewpew.new_rolling_sphere(vx, vy, fmath.random_fixedpoint(0fx, fmath.tau()), 4fx)
end

--GOOD STUFF

function add_bomb(amount,type,concentraed)
    local vx,vy = random_pos()
    for i = 1, amount do
        if not concentrated then
            vx,vy = random_pos()
        end
        pewpew.new_bomb(vx, vy, type)
    end
end

function speed_bonus()
    local dx,dy = zm.zones[1][1].position[1]-zm.zones[2][1].position[1], zm.zones[1][1].position[2]-zm.zones[2][1].position[2]
    local dist = fmath.sqrt((dx*dx)+(dy*dy))
    if dist < 525fx then return end

    local zone
    for i = 1, #zm.zones do
        if zm.zones[i][1].player_inside then
            zone = zm.zones[i][1]
            break
        end
    end
    if zone == nil then
        zone = zm.zones[fmath.random_int(1, #zm.zones)][1]
    end
    local rangle = fmath.random_fixedpoint(0fx, fmath.tau())
    local roff = fmath.random_fixedpoint(0fx, 240fx)
    local ny, nx = fmath.sincos(rangle)
    local rx,ry = zone.position[1]+nx*roff,zone.position[2]+ny*roff
    local vx,vy = gh.verify_position(rx,ry)
    pewpew.new_bonus(vx, vy, pewpew.BonusType.SPEED, {box_duration = 150, speed_factor = 1fx, speed_offset = 11fx, speed_duration = 40})
end

function powerup(setup)
    local vx,vy = random_pos()
    pewpew.new_bonus(vx, vy, pewpew.BonusType.WEAPON, setup)
end

function random_powerup()
    local vx,vy = random_pos()
    pewpew.new_bonus(vx, vy, pewpew.BonusType.WEAPON, weapon_setups[fmath.random_int(1, #weapon_setups)])
end

--EVENTS

local m_types3 = {
    pewpew.MothershipType.SEVEN_CORNERS,
    pewpew.MothershipType.SIX_CORNERS
}

local total_mships = 8
local spawn_points = 3
local total_gunners = 5
local total_planithrowers = 5
local total_crowders = 14
function getout()
    local duration = 1200

    local time = 0
    local once = false
    local px,py = 0fx,0fx

    local function message(text)
        gh.floating_message(px, py, text, 2fx+1fx/2fx, 0xffffffff, 0, 5fx)
        gh.floating_message(px, py, text, 2fx+1fx/2fx, 0xffffffff, 0, 4fx+1fx/2fx)
    end

    if pewpew.entity_get_is_alive(ph.player_ships[1]) then
        px,py = pewpew.entity_get_position(ph.player_ships[1])
        message("LEAVE THE ZONE!")
    end

    local rn = fmath.random_int(1, 4)
    local mship_amount = total_mships//(spawn_points//1)
    local crowd_amount = total_crowders//(spawn_points//1)
    if rn == 1 then
        for i = 1, spawn_points//1 do
            for j = 1, mship_amount do
                add_mothership(m_types3)
            end
        end
    elseif rn == 2 then
        for i = 1, total_planithrowers do
            add_pt()
        end
    elseif rn == 3 then
        for i = 1, total_gunners do
            add_gunner(1)
        end
    else
        for i = 1, spawn_points//1 do
            add_crowder2(crowd_amount,true)
        end
    end
    
    local e = pewpew.new_customizable_entity(0fx, 0fx)
    local function euc()
        time = time + 1
        if time > 30 and time <= 31 then
            gh.hypothermia_mode = true
        end
        if time >= duration-40 and not once then
            if pewpew.entity_get_is_alive(ph.player_ships[1]) then
                px,py = pewpew.entity_get_position(ph.player_ships[1])
                message("GET BACK IN!")
            end
            once = true
        end
        if time >= duration then
            pewpew.entity_destroy(e)
            pewpew.entity_set_update_callback(e, nil)
            gh.hypothermia_mode = false
        end
    end

    pewpew.entity_set_update_callback(e, euc)

    total_mships = total_mships + 3
    total_gunners = total_gunners + 3
    total_planithrowers = total_planithrowers + 3
    total_crowders = total_crowders + 3
    spawn_points = spawn_points + 0.5
end

local function timeSwitch()
    if gh.timeScale == 1fx then
        gh.timeScale = 0fx
    else
        gh.timeScale = 1fx
    end
end

local function disableChildrenLayers()
    for i = 1, #children do
        children[i]:force_state(true)
    end
end

local function enableChildrenLayers()
    for i = 1, #children do
        children[i]:force_state(false)
    end
end

function freeze_zones()
    timeSwitch()
    disableChildrenLayers()
    local e = pewpew.new_customizable_entity(0fx, 0fx)

    local duration = 590
    local time = 0
    local function euc()
        time = time + 1
        if time >= duration then
            pewpew.entity_destroy(e)
            pewpew.entity_set_update_callback(e, nil)
            enableChildrenLayers()
            timeSwitch()
        end
    end
    pewpew.entity_set_update_callback(e, euc)
end