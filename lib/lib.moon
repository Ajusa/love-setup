export sti = require("lib/sti")
export Camera = require("lib/camera")
export bump = require('lib/bump')
export Timer = require('lib/timer')
love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 16))
love.graphics.setDefaultFilter("nearest")
export random = (l, h) -> love.math.random(l, h)
export collision = (x1,y1,w1,h1, x2,y2,w2,h2) -> x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
export walls = (item, other) -> if other.p == nil then "slide"
export class Entity
  new: (p) => @p = p
  update: (dt) => @p.x, @p.y = @p.x + @p.dx*dt, @p.y + @p.dy*dt

--could add move up methods here, to assist with cutscene stuff
