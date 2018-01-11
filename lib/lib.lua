sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
Timer = require('lib/timer')
Timer = require('lib/Moan')
kenPixel = love.graphics.newFont("lib/kenpixel.ttf", 18)
love.graphics.setDefaultFilter("nearest")
Moan.font = kenPixel
Moan.selectButton = "return"
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
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.p.x, self.p.y = self.p.x + self.p.dx * dt, self.p.y + self.p.dy * dt
    end,
    follow = function(self, obj)
      local angle = math.atan2((obj.p.y - self.p.y), (obj.p.x - self.p.x))
      self.p.dx, self.p.dy = self.p.speed * math.cos(angle), self.p.speed * math.sin(angle)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, p)
      self.p = p
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
  return _class_0
end
