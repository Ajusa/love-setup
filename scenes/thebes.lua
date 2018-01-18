do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      if collision(player.p, 64, 64, tile(22, 3), 64 * 4, 64) then
        STATE = Palace()
      end
    end,
    draw = function(self)
      return _class_0.__parent.__base.draw(self)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Thebes.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 23 * 64, 48 * 64, 5
      _class_0.__parent.__init(self)
      isDialogue = true
      return player:speak("Oedipus", {
        "I wonder if the servant has arrived. Maybe he is talking to Jocasta in the palace, right now?"
      }, function()
        isDialogue = false
      end)
    end,
    __base = _base_0,
    __name = "Thebes",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Thebes = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      return self.jocasta:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.jocasta:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Oedipus's Palace.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 24 * 64, 46 * 64, 5
      _class_0.__parent.__init(self)
      isDialogue = true
      self.jocasta = Jocasta({
        x = 24 * 64,
        y = 25 * 64,
        speed = 175,
        image = love.graphics.newImage("images/Jocasta.png")
      })
      return player:speak("Oedipus", {
        "Where is the wife, no wife, the teeming womb -- That bore a double harvest, me and mine?"
      }, function()
        self.jocasta:speak("Jocasta", {
          "Right here, wicked Oedipus. Why did you have to find the truth?",
          "The only way to make things right is to kill you. Guards, take him!"
        })
        isDialogue = false
      end)
    end,
    __base = _base_0,
    __name = "Palace",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Palace = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      self.p.speed = self.p.speed + dt
      _class_0.__parent.follow(self, player)
      return _class_0.__parent.__base.update(self, dt)
    end,
    draw = function(self)
      return love.graphics.draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Jocasta",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Jocasta = _class_0
  return _class_0
end
