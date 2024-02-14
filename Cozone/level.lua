require'/dynamic/gv.lua'
require'/dynamic/gameplay_elements.lua'
local ph = require'/dynamic/helpers/player_helpers.lua'
local zone_manager = require'/dynamic/zone/manager.lua'
local obstacle = require'/dynamic/obstacle/code.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'
local st = require'/dynamic/extra/ship_text.lua'

pewpew.set_level_size(FX,FY)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.DOUBLE}
local ship = ph.new_player_ship(FX/2fx,FY/2fx, 0)
pewpew.configure_player_ship_weapon(ship, weapon_config)
pewpew.configure_player(0, {camera_distance = 100fx, shield = 10})

add_level_outlines(3)

pewpew.configure_player(0, {camera_distance = -100fx})

local zone_speed = 4fx
zone_manager.new_zone(FX/2fx,FY/2fx,zone_speed,0)
zone_manager.new_zone(FX/2fx,FY/2fx,zone_speed,1)

st:new(70,0x40ffff00,"Multiplier: ",ph.multiplier_status[1])

--zone_manager.new_zone_child("multiplier")

local obstacle_positions = {
    {265fx,550fx,75fx},
    {680fx,300fx,75fx}
}

obstacle.new(obstacle_positions[1][1],obstacle_positions[1][2],fmath.tau()/2fx-fmath.tau()/8fx)
obstacle.new(obstacle_positions[2][1],obstacle_positions[2][2],-fmath.tau()/8fx)

for i = 1, #obstacle_positions do
    table.insert(gh.obstacle_positions,obstacle_positions[i])
end

local bottom_left = {
    {X//2.5,0},{X//2.5-Y//7,Y//7},{0,Y//7}
}

local top_right = {
    {X-X//8,1500},{X-X//8,Y-Y//3},{X,Y-Y//3-X//8}
}

bottom_left = gh.arr_to_fixedpoint(bottom_left)
top_right = gh.arr_to_fixedpoint(top_right)

table.insert(gh.wall_positions,gh.copy_table(bottom_left))
table.insert(gh.wall_positions,gh.copy_table(top_right))

local function make_wall_from_arr(arr,loop)
    for i = 1, #arr do 
        if i == #arr then
            if loop then
                pewpew.add_wall(arr[i][1], arr[i][2], arr[1][1], arr[1][2])
            end
        else
            --pewpew.print("{"..arr[i][1]..", "..arr[i][2].."} ".." | ".."{"..arr[i+1][1]..", "..arr[i+1][2].."} ")
            pewpew.add_wall(arr[i][1], arr[i][2], arr[i+1][1], arr[i+1][2])
        end
    end
end

make_wall_from_arr(bottom_left,false)
make_wall_from_arr(top_right,false)

add_cave()

add_bomb(1,b_types[1])
add_gunner(1)
add_crowder(5,true)
add_crowder(3,true)
add_bafs_blue(5)
add_bomb(4,b_types[1],true)
add_crowder(15,true)
add_pt()
add_bomb(1,b_types[2])

local gn = gh.new_layer({700,600},{210,add_gunner,{1}},nil,true,"-")
gh.new_layer({gn},{210,add_pt,{}},nil,true,"-")

gh.new_layer({700,600},{140,add_crowder,{true}},nil,false,"-")
local la = gh.new_layer({300,300},{85,add_bafs_red,{}},nil,true,"-")
gh.new_layer({la},{115,add_bafs_blue,{}},nil,true,"-")
gh.new_layer({300,900},{75,add_comet,{1}},{pewpew.new_floating_message,{FX/2fx, FY/2fx, "#ddccffffCOSMIC SHOWER", {scale = 2fx+1fx/2fx, ticks_before_fade = 60}}},false,"-")
local ms = gh.new_layer({1500,1000},{300,add_mothership,{m_types}},nil,true,"-")
gh.new_layer({ms},{250,add_mothership,{m_types2}},nil,true,"-")

gh.new_layer({642,1321},nil,{freeze_zones,{}},false,"+")
local gt = gh.new_layer({1300,1900},nil,{getout,{}},false,"+")
gt:force_state(true)
--gh.new_layer({800,943},{200,speed_bonus,{}},nil,true,"+")
local aa = gh.new_layer({920,980},nil,{zone_manager.new_zone_child,{"multiplier",1,870}},true,"+")
local dd = gh.new_layer({aa},nil,{zone_manager.new_zone_child,{"shield",2,920}},false,"+")
table.insert(children,aa)
table.insert(children,dd)
gh.new_layer({1650,1120},{550,random_powerup,{}},nil,false,"+")
local fb = gh.new_layer({2104,1783},{1000,add_bomb,{1,b_types[1],false}},nil,true,"+")
gh.new_layer({fb},{1000,add_bomb,{1,b_types[2],false}},nil,false,"+")

add_asteroid(3)

local once = true
local old_score = pewpew.get_score_of_player(0)

local function callback() 
    TIME = TIME + 1
    if TIME % 890 == 0 then
        add_rs()
    end
    if gh.t2 > 0.5 and gt.force_stop == true then
        pewpew.print("this happened!")
        gt:force_state(false)
    end
    pewpew.configure_player_hud(0, {top_left_line = "#60ffffffMultiplier: "..ph.multiplier_status[1]+1})
    gh.work_layers()
    gh.step_layer_modulos()
    zone_manager.manage()
    --print(gh.player_inside)
    if pewpew.get_player_configuration(0).has_lost then 
        pewpew.stop_game() 
    end

    local score = pewpew.get_score_of_player(0)
    if old_score ~= score then
        if once then
            pewpew.increase_score_of_player(0, (score-old_score)*ph.multiplier_status[1])
            once = false
        end
        old_score = score
    else
        once = true
    end
    gh.mathf1(TIME)
    if gh.timeScale ~= 0fx then
        gh.mathf2(TIME)
    end
end

pewpew.add_update_callback(callback)