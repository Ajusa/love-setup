do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.oedipus:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/castle.lua", {
        "bump"
      })
      local score
      player.p.x, player.p.y, player.p.lives, score = 9 * 64, 6 * 64, 5, 0
      _class_0.__parent.__init(self)
      self.oedipus = Entity({
        x = 7 * 64,
        y = 6 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/messenger.png")
      })
      return player:speak("Amir", {
        "Who are you, traveller?"
      }, function()
        return self.oedipus:moveTo(tile(8, 6), function()
          return self.oedipus:moveTo(tile(5, 6), function()
            return self.oedipus:speak("Oedipus", {
              "I am Oedipus. -- I was a mighty king. Now I am a blind man."
            })
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "CrossRoads",
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
  CrossRoads = _class_0
  return _class_0
end
