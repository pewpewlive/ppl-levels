local layer = {}

function layer:new(layer_interval,persistent_func,special_func,active)--(on_num,off_num},{{interval,spawn_func},{interval,spawn_func},...})
    local z = {
        layer_interval,
        persistent_func,
        off_time = 0,
        time = 1,
        activated = active,
        once = active,
        special_func,

        force_stop = false
    }
    setmetatable(z,self)
    self.__index = self
    z.layer_interval = layer_interval
    z.persistent_func = persistent_func
    z.special_func = special_func
    return z
end

function layer:checkToActivate()
    if self.layer_interval[2] == nil then
        if not self.layer_interval[1].activated then
            self:activate()
        end
    else
        self.off_time = self.off_time + 1
        if self.off_time >= self.layer_interval[2] then
            self:activate()
        end
    end
end

function layer:checkToDeactivate()
    if self.layer_interval[2] == nil then
        if self.layer_interval[1].activated then
            self:deactivate()
        end
    else
        if self.time % self.layer_interval[1] == 0 and self.activated then
            self:deactivate()
            self.time = self.time + 1
        end
    end
end

function layer:work()
    if self.force_stop then return end
    if self.activated and self.once then
        --print("LET IS HAPPAN")
        if self.special_func ~= nil then
            self.special_func[1](table.unpack(self.special_func[2]))
        end
        self.once = false
    elseif not self.activated and not self.once then
        --self.special_func[1](table.unpack(self.special_func[2]))
        self.once = true
    end
    if self.activated then
        self.time = self.time + 1
        if self.persistent_func ~= nil then
            if self.time % self.persistent_func[1] == 0 then
                self.persistent_func[2](table.unpack(self.persistent_func[3]))
                --print("spawned!")
            end
        end
        self:checkToDeactivate()
    else
        self:checkToActivate()
    end
end

function layer:activate()
    self.activated = true
    --print("activated")
    self.off_time = 0
end

function layer:deactivate()
    --print("deactivated")
    self.activated = false
end

function layer:force_state(state)
    self.force_stop = state
end

return layer