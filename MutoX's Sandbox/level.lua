local player_helpers = require("/dynamic/helpers/player_helpers.lua")

local random = fmath.random_int(1,10)

if random == 1 then
    local width = 500fx
    local height = 500fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 3})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)

    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % 22 == 0 then
            local x, y = random_position()
            pewpew.new_mothership(x,y,pewpew.MothershipType.SEVEN_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
    end)
elseif random == 2 then
    local width = 1200fx
    local height = 1200fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 2})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 1)

    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        pewpew.increase_score_of_player(0,1)
        if time % 10 == 0 then
            local x, y = random_position()
            pewpew.new_rolling_sphere(x, y, fmath.random_fixedpoint(0fx,fmath.tau()), 2fx)
        end
        if pewpew.get_score_of_player(0) % 3000 == 0 then
            local x, y = random_position()
            pewpew.new_bomb(x,y,0)
        end
    end)
elseif random == 3 then
    local width = 800fx
    local height = 1500fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.SINGLE}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx+500fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 3})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local randomm = fmath.random_int(1,5)
    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 2)
    local hi = pewpew.new_customizable_entity(width / 2fx, height / 2fx+450fx)
    pewpew.customizable_entity_set_string(hi,"#0000ffffgo down")
    local h2i = pewpew.new_customizable_entity(width / 2fx, height / 2fx-550fx)
    if randomm == 1 then
        pewpew.customizable_entity_set_string(h2i,"#0000ffffhi")
    elseif randomm == 2 then
        pewpew.customizable_entity_set_string(h2i,"#0000ffffASasfsdjgfksdNFWIEUFBWIEUFuibdfdsiojfks")
    elseif randomm == 3 then
        pewpew.customizable_entity_set_string(h2i,"#0000ffffhello")
    elseif randomm == 4 then
        pewpew.customizable_entity_set_string(h2i,"#0000ffffGo up")
    elseif randomm == 5 then
        pewpew.customizable_entity_set_string(h2i,"#0000ffff133713371337133713371337133713371337133713371337133713371337133713371337133713371337133713371337133713371337133713371337")
    end
 
    local time = 0
    local mod = 2
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time == 500 then
            mod = mod - 1
        end
        if time % mod == 0 then
            local x, y = random_position()
            pewpew.new_baf_blue(x,y,fmath.random_fixedpoint(0fx,fmath.tau()),9fx,-10)
        end
    end)
elseif random == 4 then
    local width = 300fx
    local height = 300fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_2, cannon = pewpew.CannonType.HEMISPHERE}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 3})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 3)

    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % 20 == 0 then
            local x, y = random_position()
            pewpew.new_inertiac(x, y, 13fx/10fx, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
        if time % 100 == 0 then
            local x, y = random_position()
            pewpew.new_mothership(x,y,pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
    end)
elseif random == 5 then
    local width = 1400fx
    local height = 700fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.SINGLE}
    local ship = pewpew.new_player_ship(width / 2fx+60fx, height / 2fx, 0)
    local ship2 = pewpew.new_player_ship(width / 2fx-60fx, height / 2fx, 0)
    local ship3 = pewpew.new_player_ship(width / 2fx, height / 2fx+60fx, 0)
    local ship4 = pewpew.new_player_ship(width / 2fx, height / 2fx-60fx, 0)
    pewpew.configure_player_ship_weapon(ship, weapon_config)
    pewpew.configure_player_ship_weapon(ship2, weapon_config)
    pewpew.configure_player_ship_weapon(ship3, weapon_config)
    pewpew.configure_player_ship_weapon(ship4, weapon_config)
    pewpew.configure_player(0, {shield = 0})
    pewpew.configure_player(0, {shield = 0})
    pewpew.configure_player(0, {shield = 0})
    pewpew.configure_player(0, {shield = 0})


    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 4)

    for x = 0fx, width/2fx,50fx do
        pewpew.new_rolling_sphere(x, 0fx, fmath.tau(), 12fx)
        pewpew.new_rolling_sphere(x, height, fmath.tau(), 12fx)
    end
    for x = width, width/2fx,-50fx do
        pewpew.new_rolling_sphere(x, 0fx, fmath.tau()/2, 12fx)
        pewpew.new_rolling_sphere(x, height, fmath.tau()/2, 12fx)
    end
    for y = 0fx, height/2fx,50fx do
        pewpew.new_rolling_sphere(0fx, y, fmath.tau()/4, 12fx)
        pewpew.new_rolling_sphere(width, y, fmath.tau()/4, 12fx)
    end
    for y = height, height/2fx,-50fx do
        pewpew.new_rolling_sphere(0fx, y, fmath.tau()/2+fmath.tau()/4, 12fx)
        pewpew.new_rolling_sphere(width, y, fmath.tau()/2+fmath.tau()/4, 12fx)
    end

    local times = 0
    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        if pewpew.get_player_configuration(0)["has_lost"] and times < 4 then 
            times = times + 1
            pewpew.configure_player(0, {has_lost = false, shield = 0})
        elseif times == 4 then
            pewpew.stop_game()
        end

        if time % 30 == 0 then
            local x, y = random_position()
            pewpew.new_asteroid(x,y)
        end
    end)
elseif random == 6 then
    local width = 450fx
    local height = 400fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.SINGLE}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 3})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 5)
    pewpew.new_mothership(0fx,height,pewpew.MothershipType.THREE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
    pewpew.new_mothership(width,height-100fx,pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
    pewpew.new_mothership(0fx,height-200fx,pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
    pewpew.new_mothership(width,height-300fx,pewpew.MothershipType.SIX_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
    pewpew.new_mothership(0fx,height-400fx,pewpew.MothershipType.SEVEN_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))

    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % 130 == 0 then
            pewpew.new_mothership(0fx,height,pewpew.MothershipType.THREE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            pewpew.new_mothership(width,height-100fx,pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            pewpew.new_mothership(0fx,height-200fx,pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            pewpew.new_mothership(width,height-300fx,pewpew.MothershipType.SIX_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            pewpew.new_mothership(0fx,height-400fx,pewpew.MothershipType.SEVEN_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
        if time % 180 == 0 then
            for x = 0fx,width, 60fx do
                pewpew.new_baf(x,0fx,fmath.tau()/4,6fx,-10)
                pewpew.new_baf(x+30,height,fmath.tau()/2+fmath.tau()/4,6fx,-10)
            end
        end
    end)
elseif random == 7 then
    local width = 2000fx
    local height = 2000fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.TRIPLE}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {camera_distance = -50fx, shield = 3,camera_rotation_x_axis = -fmath.tau()/18fx})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)

    local time = 0
    local count = 0
    pewpew.add_update_callback(function()
        time = time + 1
        count = count + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % 2 == 0 then
            local x, y = random_position()
            pewpew.new_baf_blue(x,y,fmath.random_fixedpoint(0fx,fmath.tau()),11fx,-10)
            local x, y = random_position()
            pewpew.new_baf(x,y,fmath.random_fixedpoint(0fx,fmath.tau()),10fx,-10)
            local x, y = random_position()
            pewpew.new_baf_red(x,y,fmath.random_fixedpoint(0fx,fmath.tau()),9fx,-10)
        end
        if count == 30 then
            pewpew.customizable_entity_set_mesh_color(background,0xffff00ff)
        elseif count == 60 then
            pewpew.customizable_entity_set_mesh_color(background,0xff0000ff)
        elseif count == 90 then
            pewpew.customizable_entity_set_mesh_color(background,0x0070ffff)
            count = 0
        end
    end)
elseif random == 8 then
    local width = 800fx
    local height = 800fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 0})
    pewpew.configure_player_ship_weapon(ship, weapon_config)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 7)
    local counter = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh_scale(counter,3fx)
    local wait = pewpew.new_customizable_entity(width / 2fx, height / 2fx-100fx)
    pewpew.customizable_entity_set_string(wait,"#ff00ffffWait for it")

    local time = 0
    local count = 60
    local timer = 0
    pewpew.customizable_entity_set_string(counter, "#ff00ffff" .. count)
    pewpew.add_update_callback(function()
        time = time + 1
        timer = timer + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if timer % 25 == 0 then
            local x,y = random_position() 
            pewpew.new_mothership(x,y,pewpew.MothershipType.THREE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
        if time % 30 == 0 then
            count = count - 1
        end
        if pewpew.entity_get_is_alive(counter) then
            if count >= 50 then
                pewpew.customizable_entity_set_string(counter, "#ff00ffff" .. count)
            elseif count < 50 and count >= 40 then
                pewpew.customizable_entity_set_string(counter, "#800099ff" .. count)
            elseif count < 40 and count >= 30 then
                pewpew.customizable_entity_set_string(counter, "#600070ff" .. count)
            elseif count < 30 and count >= 20 then
                pewpew.customizable_entity_set_string(counter, "#500060ff" .. count)
            elseif count < 20 and count >= 10 then
                pewpew.customizable_entity_set_string(counter, "#400050ff" .. count)
            elseif count < 10 and count >= 0 then
                pewpew.customizable_entity_set_string(counter, "#200030ff" .. count)
            end
            if count == -1 then
                pewpew.entity_destroy(counter)
                pewpew.customizable_entity_set_string(wait,"#ff00ffffNothing >:)")
                pewpew.stop_game()
            end
        end
        if count > 0 then
            if timer == 30 then
                pewpew.customizable_entity_set_string(wait,"#ff00ffffWait for it.")
            elseif timer == 60 then
                pewpew.customizable_entity_set_string(wait,"#ff00ffffWait for it..")
            elseif timer == 90 then
                pewpew.customizable_entity_set_string(wait,"#ff00ffffWait for it...")
            elseif timer == 120 then
                pewpew.customizable_entity_set_string(wait,"#ff00ffffWait for it")
                timer = 0
            end
        end
    end)
elseif random == 9 then
    local width = 500fx
    local height = 500fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {cannon = pewpew.CannonType.TIC_TOC}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 2})
    pewpew.configure_player_ship_weapon(ship, weapon_config)
    pewpew.set_player_ship_speed(ship, 1fx, 15fx, -1)

    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 8)

    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % 100 == 0 then
            local x, y = random_position()
            pewpew.new_bomb(x,y,2)
        end
        if time % 22 == 0 then
            local x, y = random_position()
            pewpew.new_mothership(x,y,pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
    end)
elseif random == 10 then
    local width = 200fx
    local height = 200fx
    pewpew.set_level_size(width, height)

    local function random_position()
        return fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height)
    end

    local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE_SWIPE}
    local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
    pewpew.configure_player(0, {--[[camera_distance = 100fx,]] shield = 1})
    pewpew.configure_player_ship_weapon(ship, weapon_config)
    local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
    pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 9)
    pewpew.make_player_ship_transparent(ship, 60)

    pewpew.new_rolling_sphere(width-100fx, height-100fx, fmath.tau()/8, 10fx)
    pewpew.new_rolling_sphere(width-100fx, height-100fx, fmath.tau()/4+fmath.tau()/8, 10fx)
    pewpew.new_rolling_sphere(width-100fx, height-100fx, fmath.tau()/2+fmath.tau()/8, 10fx)
    pewpew.new_rolling_sphere(width-100fx, height-100fx, fmath.tau()/2+fmath.tau()/4+fmath.tau()/8, 10fx)

    local mod = 70
    local time = 0
    pewpew.add_update_callback(function()
        time = time + 1
        local conf = pewpew.get_player_configuration(0)
        if conf["has_lost"] then
            pewpew.stop_game()
        end
        if time % mod == 0 then
            local x, y = random_position()
            pewpew.new_mothership(x,y,pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
            mod = mod - 1
        end
    end)
end
    