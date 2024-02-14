local ph = require'/dynamic/helpers/player_helpers.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'
local gh = require'/dynamic/helpers/gameplay_helpers.lua'

local child = {}

function child:show_text(value,pop)
    if #gh.ship_texts ~= 0 or gh.ship_texts[1] ~= nil then
        if pop then
            gh.ship_texts[1]:popup(value)
        else 
            gh.ship_texts[1].value = value
        end
    end
end
--print
function child:apply_buff()
    if self.buff == "shield" and self.player_inside then
        self.time = self.time + 1
        if self.time % self.shield_interval == 0 then
            local config = pewpew.get_player_configuration(0)
            self.shield_outtake = fmath.to_fixedpoint(self.shield_outtake)
            self.shield_outtake = fmath.to_int(self.shield_outtake)
            config.shield = config.shield + self.shield_outtake
            pewpew.configure_player(0, config)
            pewpew.new_floating_message(self.position[1], self.position[2], "#ffff00ffShield +"..self.shield_outtake, {scale = 1fx+1fx/2fx, ticks_before_fade = 40})
        end
    elseif self.buff == "multiplier" then
        if self.player_inside and not once then
            ph.multiplier_status[1] = self.multiplier_bonus
            self:show_text(ph.multiplier_status[1]+1,true)
            once = true
        elseif not self.player_inside and once then
            ph.multiplier_status[1] = 0
            self:show_text(ph.multiplier_status[1]+1,false)
            once = false
        end
    end
end

function child:animate()
    pewpew.customizable_entity_set_mesh(self.entity_id, "/dynamic/zone/child/graphics.lua", self.frame)
    self.frame = self.frame + 1
    if self.frame > self.frames then
        self.frame = 0
    end
end

function child:checkPlayerInside()
    if pewpew.entity_get_is_started_to_be_destroyed(self.entity_id) then return end
    self:animate()
    if not pewpew.entity_get_is_alive(ph.player_ships[1]) then return end
    local px,py = pewpew.entity_get_position(ph.player_ships[1])

    local dx,dy = px-self.position[1],py-self.position[2]
    local dist = fmath.sqrt((dx*dx)+(dy*dy))

    --pewpew.print(self.ref_radius*self.radius)
    if dist >= self.ref_radius*self.radius then
        self.player_inside = false
    else
        self.player_inside = true
    end
    self:step_variables()
    self:apply_buff()
end

function child:step_variables()
    local min = 3
    local max = min*3
    self.multiplier_bonus = gh.lerpINT(min,max,gh.t)//1
    local max2 = 3
    local min2 = 1
    self.shield_outtake = gh.lerpINT(min2,max2,gh.t)//1
end

function child:new(parent_zone,buff_type,time_to_live)
    local offpushback = 40fx
    local z = {
        ref_radius = 100fx,
        radius = 0fx,

        entity_id = -99999,player_inside = false,
        a = 255,
        move_vector = {0fx,0fx},
        angle = fmath.random_fixedpoint(0fx, fmath.tau()),
        angle_step = fmath.tau()/360fx,
        offset = 120fx,
        position = {0fx,0fx},
        parent_position = {0fx,0fx},

        buff = buff_type,
        time = 0,
        shield_interval = 45,
        shield_outtake = 1,
        multiplier_bonus = 3,

        time_to_live = 96,
        color,
        ttime = 0,
        once = false,

        frames = 60+10-1,
        frame = 0
    }
    setmetatable(z,self)
    self.__index = self
    z.radius = parent_zone.scale
    if buff_type == "shield" then
        z.radius = z.radius - 1fx/3fx
    end
    z.time_to_live = time_to_live
    z.move_vector[2],z.move_vector[1] = fmath.sincos(z.angle)
    z.parent_position[1],z.parent_position[2] = pewpew.entity_get_position(parent_zone.entity_id)
    z.offset = 120fx * z.radius
    z.offset = z.offset - offpushback
    z.radius = z.radius + z.ref_radius/(z.ref_radius-offpushback)/2
    z.entity_id = pewpew.new_customizable_entity(z.parent_position[1]+z.move_vector[1]*z.offset, z.parent_position[2]+z.move_vector[2]*z.offset)
    pewpew.customizable_entity_set_position_interpolation(z.entity_id, true)
    pewpew.customizable_entity_set_mesh(z.entity_id, "/dynamic/zone/child/graphics.lua", 0)
    pewpew.customizable_entity_set_mesh_scale(z.entity_id, z.radius)
    pewpew.entity_set_radius(z.entity_id, z.ref_radius*z.radius)

    if z.buff == "shield" then
        color = 0xffff0000
    else
        color = 0x00aaff00
    end

    function z.euc(entity_id)
        if buff_type == "shield" then
            z.radius = parent_zone.scale - 1fx/3fx
        else 
            z.radius = parent_zone.scale 
        end
        z.offset = 120fx * z.radius
        z.radius = z.radius + z.ref_radius/(z.ref_radius-offpushback)/2
        z.offset = z.offset - offpushback
        pewpew.customizable_entity_set_mesh_scale(z.entity_id, z.radius)
        z.move_vector[2],z.move_vector[1] = fmath.sincos(z.angle)
        z.parent_position[1],z.parent_position[2] = pewpew.entity_get_position(parent_zone.entity_id)
        if gh.timeScale ~= 0fx then
            pewpew.entity_set_position(z.entity_id, z.parent_position[1]+z.move_vector[1]*z.offset, z.parent_position[2]+z.move_vector[2]*z.offset)
        end
        z.position[1],z.position[2] = pewpew.entity_get_position(z.entity_id)

        z:checkPlayerInside()
        local t = gh.invLerp(0,z.time_to_live,z.ttime)
        a = gh.lerpINT(255,60,t)//1
        pewpew.customizable_entity_set_mesh_color(z.entity_id, ch.make_color_with_alpha(color,a))
        if gh.timeScale == 1fx then
            z.angle = z.angle + z.angle_step
            z.ttime = z.ttime + 1
        end
        if z.ttime >= z.time_to_live then
            pewpew.entity_set_update_callback(z.entity_id, nil)
            ph.multiplier_status[1] = 0
            pewpew.customizable_entity_start_exploding(z.entity_id, 60)
        end
    end

    pewpew.entity_set_update_callback(z.entity_id, z.euc)
    return z
end

return child