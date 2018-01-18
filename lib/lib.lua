sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
Timer = require('lib/timer')
Moan = require('lib/Moan')
anim8 = require('lib/anim8')
kenPixel = love.graphics.newFont("lib/kenpixel.ttf", 18)
love.graphics.setDefaultFilter("nearest")
Moan.font = kenPixel
Moan.selectButton = 1
Moan.setSpeed(0.05)
random = function(l, h)
  return love.math.random(l, h)
end
tile = function(x, y)
  return {
    x = x * 64,
    y = y * 64
  }
end
fullCollision = function(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
collision = function(first, w1, h1, second, w2, h2)
  return first.x < second.x + w2 and second.x < first.x + w1 and first.y < second.y + h2 and second.y < first.y + h1
end
walls = function(item, other)
  if other.p == nil then
    return "slide"
  end
end
shuffle = function(tbl)
  local size = #tbl
  for i = size, 1, -1 do
    local rand = math.random(size)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end
clone = function(t)
  if type(t) ~= "table" then
    return t
  end
  local meta = getmetatable(t)
  local target = { }
  for k, v in pairs(t) do
    if type(v) == "table" then
      target[k] = clone(v)
    else
      target[k] = v
    end
  end
  setmetatable(target, meta)
  return target
end
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.p.x, self.p.y = self.p.x + self.p.dx * dt, self.p.y + self.p.dy * dt
      if self.p.anim then
        return self.p.anim:update(dt)
      end
    end,
    draw = function(self)
      return self.p.anim:draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
    end,
    moveTo = function(self, obj, after)
      if after == nil then
        after = function() end
      end
      self.handle = Timer.every(.04, function()
        local angle = math.atan2((obj.y - self.p.y), (obj.x - self.p.x))
        self.p.dx, self.p.dy = self.p.speed / 20 * math.cos(angle), self.p.speed / 20 * math.sin(angle)
        self.p.x, self.p.y = self.p.x + self.p.dx, self.p.y + self.p.dy
        if math.abs(obj.y - self.p.y) + math.abs(obj.x - self.p.x) < 10 then
          Timer.cancel(self.handle)
          return after()
        end
      end)
    end,
    speak = function(self, name, obj, after)
      if after == nil then
        after = function() end
      end
      return Moan.speak(name, obj, {
        oncomplete = after
      })
    end,
    follow = function(self, obj, cons)
      if cons == nil then
        cons = 1
      end
      local angle = math.atan2((obj.p.y - self.p.y), (obj.p.x - self.p.x))
      self.p.dx, self.p.dy = self.p.speed * cons * math.cos(angle), self.p.speed * cons * math.sin(angle)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, p)
      self.p = p
      self.p.g = anim8.newGrid(16, 16, self.p.image:getWidth(), self.p.image:getHeight())
      self.p.anim = anim8.newAnimation(self.p.g(1, 1), 0.1)
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
do
  local _class_0
  local _base_0 = {
    draw = function(self)
      map:draw()
      for i, v in ipairs(bullets) do
        v:draw()
      end
      return player:draw()
    end,
    death = function(self)
      player.p.lives = 5
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      map:bump_init(world)
      world:add(player, player.p.x + 4, player.p.y + 4, 48, 48)
      love.audio.stop()
      if self.music ~= nil then
        local music = love.audio.newSource(self.music)
        music:setVolume(0.4)
        music:setLooping(true)
        return music:play()
      end
    end,
    __base = _base_0,
    __name = "BaseState"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  BaseState = _class_0
  return _class_0
end
