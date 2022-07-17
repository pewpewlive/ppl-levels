local dart = require("/dynamic/dart/dart.lua")
local explobox = require("/dynamic/explobox/explobox.lua")
local baf = require("/dynamic/green_baf/green_baf.lua")
local rps = require("/dynamic/grps/grps.lua")
local inertic = require("/dynamic/inertiac/inertiac.lua")
local powerups = require("/dynamic/powerups/powerups.lua")
local spring = require("/dynamic/anchor/spring.lua")
local BAF = require("/dynamic/BAF/BAF.lua")

local gameplay = {}

local function random_position()
    return fmath.random_fixedpoint(0fx, 750fx), fmath.random_fixedpoint(0fx, 600fx)
end
local function random_position2()
    return fmath.random_fixedpoint(150fx, 600fx), fmath.random_fixedpoint(150fx, 450fx)
end

local positions = {{120fx,120fx}, {260fx,120fx}, {490fx,120fx}, {630fx,120fx},
                    {120fx,240fx},                               {630fx,240fx},
                    {120fx,360fx},                                {630fx,360fx},
                    {120fx,480fx}, {260fx,480fx}, {490fx,480fx}, {630fx,480fx}}

local function random_valid_positions()
  local index = fmath.random_int(1, #positions)
  return positions[index][1], positions[index][2]
end

function gameplay.activate(player_id)
    local blue_theme = true
    local red_theme = false
    local green_theme = false
    local pink_theme = false
    local yellow_theme = false
    local cyan_theme = false
    local a = 0
    local b = 0
    local c = 0 
    local d = 0
    local e = 0
    local f = 0
    local idk = true
    local once3 = true
    local time = 0
    local mod = 0
    local spawn = false
    local mod3 = 0
    local two = false
    local cplus = 0
    local c2 = 0
    local x, y = random_position()
    local i2 = 0
    local bafs = 0
    local mod4 = 0
    local bafs2 = 0
    local exploboxx = 0
    local n = true
    local fake = false
    pewpew.add_update_callback(function()
        if pewpew.entity_get_is_alive(player_id) then
            time = time + 1
        end
        if time <= 0 then
            local e = pewpew.get_entities_colliding_with_disk(375fx, 300fx, 1400fx)
            if time % 1 then
                for i=1,#e do
                    if e[i] == player_id then
                        fake = true
                    else
                        pewpew.entity_destroy(e[i])
                    end
                end
            end
        end

        if blue_theme and time <= 870 and time > 0 then
            a = a + 1
            if n then
                exploboxx = exploboxx + 1
            end
            if a % 250 == 0 and mod < 8 then
                mod = mod + 1
            end
            if a % (45-mod-3) == 0 then
                for i = 0, 4 do
                    dart.new(player_id)
                end
            end
            if exploboxx == 500 then
                local x,y = random_position()
                explobox(x,y)
                exploboxx = 0
                n = false
            end
            if a % (40-mod) == 0 then
                local x, y = random_position()
                pewpew.new_wary(x,y)
            end
            if a % (11-mod) == 0 then
                local x,y = random_position()
                pewpew.new_baf_blue(x,y,fmath.random_fixedpoint(0fx,fmath.tau()),4fx,400)
            end        
        elseif blue_theme and time > 900 then
            if spawn then
                if spheres > 0 then
                    for i = 1, spheres do
                        local x, y = random_valid_positions()
                        pewpew.new_rolling_sphere(x, y, fmath.random_fixedpoint(0fx,fmath.tau()), 4fx)
                    end
                end
            end
            red_theme = true
            blue_theme = false
            pewpew.make_player_ship_transparent(player_id, 30)
            time = -35
        end

        if red_theme and time <= 870 and time > 0 then
            b = b + 1
            local mod2 = 0
            if b % 250 == 0 then
                if mod2 < 70 then
                    mod2 = mod2 + 5
                end
            end
            if b % (78-mod2) == 0 then
                for i = 1, 4, 3 do pewpew.new_baf_red(120fx,120fx,fmath.tau()/i,9fx,400) end
                for i = 2, 4, 2 do pewpew.new_baf_red(630fx,480fx,fmath.tau()/-i,9fx,400) end
            end
            if b % (70-mod2) == 0 then
                local x, y = random_valid_positions()
                pewpew.new_mothership(x,y,pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            end
            if b % 85 == 0 then
                local x, y = random_valid_positions()
                pewpew.new_rolling_sphere(x, y, fmath.random_fixedpoint(0fx,fmath.tau()), 4fx)
            end
        elseif red_theme and time > 900 then
            spawn = true
            red_theme = false
            n = true
            spheres = pewpew.get_entity_count(pewpew.EntityType.ROLLING_SPHERE)
            green_theme = true
            pewpew.make_player_ship_transparent(player_id, 30)
            time = -35
        end

        if green_theme and time <= 870 and time > 0 then
            c = c + 1
            c2 = c2 + 1
            if c % 360 == 0 then
                mod3 = mod3 + 10
            end
            if idk then
                bafs = bafs + 1
            end
            local random = fmath.random_int(1,4)
            if c2 == (160-cplus) then
                if random == 1 then
                    for y = 0fx, 600fx, 30fx do
                        baf.green(5fx, y, player_id, fmath.tau())
                    end
                end
                if random == 2 then
                    for y = 0fx, 600fx, 30fx do
                        baf.green(745fx, y, player_id, fmath.tau())
                    end
                end
                if random == 3 then
                    for x = 0fx, 750fx, 30fx do
                        baf.green(x, 5fx, player_id, fmath.tau()/4)
                    end
                end
                if random == 4 then
                    for x = 0fx, 750fx, 30fx do
                        baf.green(x, 595fx, player_id, fmath.tau()/4)
                    end
                end
                if cplus < 100 then
                    cplus = cplus + 5
                end
                c2 = 0
            end
            if bafs == 450 then
                local x, y = random_position2()
                powerups.yellow(x, y, player_id,false)
                bafs = 0
                idk = false
            end
            if c % 75 == 0 then
                local x, y = random_position()
                rps.green(x, y, fmath.random_fixedpoint(0fx,fmath.tau()), player_id)
            end
            if c % (270-mod3) == 0 then
                local x, y = random_position()
                pewpew.new_mothership(x,y,pewpew.MothershipType.SIX_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            end
            if not two then
                local x, y = random_position()
                inrt = inertic.inertic(x, y, player_id)
                two = true
            end
        elseif green_theme and time > 900 then
            two = false
            green_theme = false
            inertic.die(inrt)
            pink_theme = true
            idk = true
            pewpew.make_player_ship_transparent(player_id, 30)
            time = -35
        end

        if pink_theme and time <= 870 and time > 0 then
            d = d + 1
            if d % 32 == 0 then
                local mother = pewpew.new_mothership(750fx/2fx,600fx/2fx,pewpew.MothershipType.THREE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            end
            if d % 340 == 0 then
                i2 = i2 + 1
            end
            local rand = fmath.random_int(1,4)
            if d % 160 == 0 then
                pewpew.new_wary(0fx, 0fx)
                pewpew.new_wary(750fx, 0fx)
                pewpew.new_wary(750fx, 600fx)
                pewpew.new_wary(0fx, 600fx)
                if rand == 1 then
                    for i = 0, i2 do pewpew.new_wary(0fx, 600fx) end
                elseif rand == 2 then
                    for i = 0, i2 do pewpew.new_wary(750fx, 600fx) end
                elseif rand == 3 then
                    for i = 0, i2 do pewpew.new_wary(750fx, 0fx) end
                else
                    for i = 0, i2 do pewpew.new_wary(0fx, 0fx) end
                end
            end
        elseif pink_theme and time > 900 then
            two = false
            pink_theme = false
            idk = true
            yellow_theme = true
            pewpew.make_player_ship_transparent(player_id, 30)
            time = -35
        end

        if yellow_theme and time <= 870 and time > 0 then
            e = e + 1
            if idk then
                bafs = bafs + 1
            end
            if e % 370 == 0 then
                if mod4 < 150 then
                    mod4 = mod4 + 10
                end
            end
            if e % (10-mod4/10) == 0 then
                local x, y = random_position()
                pewpew.new_baf(x, y, fmath.random_fixedpoint(0fx,fmath.tau()),10fx, 300)
            end
            if e % (80-mod4/2-2) == 0 then
                local x, y = random_position()
                pewpew.new_mothership(x, y,pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            end
            local random = fmath.random_int(1,2)
            if e % (185-mod4-5) == 0 then
                if random == 1 then
                    for y = 0fx, 600fx, 30fx do
                        pewpew.new_baf(0fx,y,fmath.tau(),10fx,300)
                    end
                    for x = 0fx, 750fx, 30fx do
                        pewpew.new_baf(x,0fx,fmath.tau()/4fx,10fx,300)
                    end
                else
                    for y = 0fx, 600fx, 30fx do
                        pewpew.new_baf(750fx,y,fmath.tau(),10fx,300)
                    end
                    for x = 0fx, 750fx, 30fx do
                        pewpew.new_baf(x,600fx,fmath.tau()/4fx,10fx,300)
                    end
                end
            end
            if bafs == 600 then
                for y = 0fx, 600fx, 30fx do
                    pewpew.new_baf(750fx,y,fmath.tau(),10fx,300)
                end
                for x = 0fx, 750fx, 30fx do
                    pewpew.new_baf(x,600fx,fmath.tau()/4fx,10fx,300)
                end
                for y = 0fx, 600fx, 30fx do
                    pewpew.new_baf(0fx,y,fmath.tau(),10fx,300)
                end
                for x = 0fx, 750fx, 30fx do
                    pewpew.new_baf(x,0fx,fmath.tau()/4fx,10fx,300)
                end
                bafs = 0
                idk = false
            end
            if bafs == 420 then
                local x, y = random_position()
                powerups.yellow(x, y, player_id,true)
            end
        elseif yellow_theme and time > 900 then
            two = false
            yellow_theme = false
            cyan_theme = true
            idk = true
            pewpew.make_player_ship_transparent(player_id, 30)
            time = -35
        end
        
        if cyan_theme and time <= 870 and time > 0 then
            f = f + 1
            if time == 1 then
                springy_boi = spring.spawn({750fx / 2fx, 600fx / 2fx}, 150fx, 1fx/20fx, 65fx/100fx, player_id, "pewpew2")
            end
            if time < 10 then
                pewpew.entity_set_position(player_id,375fx,300fx)
            end
            if bafs2 > 0 and once3 then
                for i = 1, bafs2 do
                    local x,y = random_position()
                    BAF.new(x,y,player_id,4fx,fmath.random_fixedpoint(0fx,fmath.tau()))
                end
                once3 = false
            end
            if f % 24 == 0 then
                local x,y = random_position()
                BAF.new(x,y,player_id,4fx,fmath.random_fixedpoint(0fx,fmath.tau()))
                bafs2 = bafs2 + 1
            end
        elseif cyan_theme and time > 900 then
            cyan_theme = false
            blue_theme = true
            spring.dispose(springy_boi)
            time = -35
            pewpew.make_player_ship_transparent(player_id, 30)
            once3 = true
        end
    end)
    return player_id
end

return gameplay