sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
Timer = require('lib/timer')
love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 16))
love.graphics.setDefaultFilter("nearest")
random = function(l, h)
  return love.math.random(l, h)
end
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.p.x, self.p.y = self.p.x + self.p.dx * dt, self.p.y + self.p.dy * dt
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
end
