do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.baba:draw()
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
      isDialogue = true
      player.p.x, player.p.y, player.p.lives = 9 * 64, 6 * 64, 5
      _class_0.__parent.__init(self)
      self.baba = Entity({
        x = 7 * 64,
        y = 6 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Baba.png")
      })
      return player:speak("Amir", {
        "Baba? Is that you? Where is my mother?"
      }, function()
        return self.baba:speak("Baba", {
          "You killed her Amir. My Princess. She died giving birth to you."
        }, function()
          self.baba:moveTo(tile(10, 7))
          return self.baba:speak("Baba", {
            "Do you know what it is like growing up without a mother? Your story will not be a happy one, Amir."
          }, function()
            return player:speak("Amir", {
              "No Baba! It wasn't -- my -- fault"
            }, function()
              STATE = CrossRoads2()
            end)
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "BabaScene",
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
  BabaScene = _class_0
  return _class_0
end
