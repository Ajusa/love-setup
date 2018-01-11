export sti = require("lib/sti")
export Camera = require("lib/camera")
export bump = require('lib/bump')
export Timer = require('lib/timer')
love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 16))
love.graphics.setDefaultFilter("nearest")
export random = (l, h) -> love.math.random(l, h)
export class Entity
  new: (p) => @p = p
  update: (dt) => @p.x, @p.y = @p.x + @p.dx*dt, @p.y + @p.dy*dt

