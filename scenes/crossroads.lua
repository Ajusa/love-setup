do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      self.oedipus:draw()
      return self.man:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Cross Roads.lua", {
        "bump"
      })
      isDialogue = true
      _class_0.__parent.__init(self)
      local score
      player.p.x, player.p.y, player.p.lives, score = 42 * 64, 46 * 64, 5, 0
      self.oedipus = Entity({
        x = 37 * 64,
        y = 48 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Oedipus.png")
      })
      self.man = Entity({
        x = 54 * 64,
        y = 47 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Young Man.png")
      })
      return player:speak("Amir", {
        "Who are you, blind traveller?"
      }, function()
        return self.oedipus:moveTo(tile(38, 49), function()
          return self.oedipus:moveTo(tile(36, 45), function()
            return self.oedipus:speak("Oedipus", {
              "I am Oedipus. -- I was a mighty king. Now I am a lost soul."
            }, function()
              self.man:moveTo(tile(45, 47))
              return self.man:speak("Young Man", {
                "Hey guys? What are all of you doing out here?"
              }, function()
                return self.oedipus:speak("Oedipus", {
                  "Do any of you know stories?",
                  "When you have been in the wilderness for so long, you start to long for something exciting"
                }, function()
                  return player:speak("Amir", {
                    "Luckily for you, I am a prime storyteller. Let me tell you about my past..."
                  }, function()
                    STATE = KiteFight()
                  end)
                end)
              end)
            end)
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
