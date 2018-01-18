do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      for i = #bullets, 1, -1 do
        if collision(bullets[i].p, 20, 40, self.tree.p, 64, 64) then
          isDialogue = true
          self.tree:speak("Tree", {
            "Amir and Hassan, the sultans of Kabul."
          }, function()
            isDialogue = false
          end)
        end
      end
      if collision(player.p, 64, 64, tile(13, 48), 192, 64) then
        STATE = Kabul()
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.tree:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Dark Room.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 14 * 64, 2 * 64, 5
      self.music = "sound/darkroom.mp3"
      _class_0.__parent.__init(self)
      self.tree = Entity({
        x = 21 * 64,
        y = 18 * 64,
        w = 64,
        h = 64,
        image = love.graphics.newImage("images/Pomegranate Tree.png")
      })
      isDialogue = true
      return player:speak("Amir", {
        "Where am I? Better find the exit..."
      }, function()
        isDialogue = false
      end)
    end,
    __base = _base_0,
    __name = "DarkRoom",
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
  DarkRoom = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      if collision(player.p, 64, 64, tile(3, 10), 128, 64) then
        STATE = KiteFight()
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
      map = sti("data/Kabul Concept.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 48 * 64, 34 * 64, 5
      self.music = "sound/kabul.mp3"
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Kabul",
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
  Kabul = _class_0
  return _class_0
end
