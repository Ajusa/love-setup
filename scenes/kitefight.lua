do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    death = function(self)
      self.died = true
      return self.cutScene:play()
    end,
    update = function(self, dt)
      if #enemies > 0 then
        for i = #enemies, 1, -1 do
          enemies[i]:update(dt, i)
        end
      end
      player:update(dt)
      assef:update(dt)
      if collision(assef.p, 64, 64, player.p, 64, 64) then
        return self:death()
      end
    end,
    draw = function(self)
      if self.died then
        local cX, cY = camera:worldCoords(love.graphics.getWidth() / 2, 0)
        love.graphics.draw(self.cutScene, cX, cY, 0, love.graphics.getHeight() / self.cutScene:getHeight(), love.graphics.getHeight() / self.cutScene:getHeight(), self.cutScene:getWidth() / 2)
        if not self.cutScene:isPlaying() then
          STATE = BabaScene()
        end
      else
        _class_0.__parent.__base.draw(self)
        for i, v in ipairs(enemies) do
          v:draw()
        end
        return assef:draw()
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/dark.lua", {
        "bump"
      })
      isDialogue = true
      local score
      player.p.x, player.p.y, player.p.lives, score = 43 * 64, 6 * 64, 5, 0
      _class_0.__parent.__init(self)
      assef = Assef({
        x = 43 * 64,
        y = 13 * 64,
        speed = 175,
        image = love.graphics.newImage("images/Assef.png")
      })
      self.died = false
      self.cutScene = love.graphics.newVideo("cutscenes/Jocasta.ogv")
      return Moan.speak("Amir", {
        "I decided to walk in to the building, hoping to find Sohrab"
      }, {
        oncomplete = function()
          world = bump.newWorld()
          map = sti("data/testmap.lua", {
            "bump"
          })
          _class_0.__parent.__init(self)
          player:moveTo(tile(43, 10))
          return assef:moveTo(tile(47, 10), (function()
            local _base_1 = assef
            local _fn_0 = _base_1.talk
            return function(...)
              return _fn_0(_base_1, ...)
            end
          end)())
        end
      })
    end,
    __base = _base_0,
    __name = "KiteFight",
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
  KiteFight = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    talk = function(self)
      return Moan.speak("Assef", {
        "What, didn't recognize me?",
        "I never forget a face. You can do away with that now",
        "You can have the boy, of course. However, we still have something to settle, don't we?",
        "Hassan can't help you either. Let's do this."
      }, {
        oncomplete = function()
          isDialogue = false
          assef = BossAssef(self.p)
          for i = 1, 10 do
            table.insert(enemies, Enemy({
              x = random(64 * (2), (32) * 64),
              y = random(64 * (2), (map.height - 2) * 64),
              lives = 2,
              speed = 30,
              image = love.graphics.newImage("images/Taliban Member 1.png")
            }))
          end
          for i = 1, 10 do
            table.insert(enemies, Enemy({
              x = random(64 * (2), (32) * 64),
              y = random(64 * (2), (map.height - 2) * 64),
              lives = 2,
              speed = 30,
              image = love.graphics.newImage("images/Taliban Member.png")
            }))
          end
        end
      })
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      return _class_0.__parent.__init(self, p)
    end,
    __base = _base_0,
    __name = "Assef",
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
  Assef = _class_0
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
    __name = "BossAssef",
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
  BossAssef = _class_0
  return _class_0
end
