export * 
sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
Timer = require('lib/timer')
Timer = require('lib/Moan')
anim8 = require('lib/anim8')
kenPixel = love.graphics.newFont("lib/kenpixel.ttf", 18)
love.graphics.setDefaultFilter("nearest")
love.window.setFullscreen(true)
Moan.font = kenPixel
Moan.selectButton = "return"
random = (l, h) -> love.math.random(l, h)
tile = (x, y) -> {x: x*64, y: y*64}
fullCollision = (x1,y1,w1,h1, x2,y2,w2,h2) -> x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
collision = (first,w1,h1,second,w2,h2) -> first.x < second.x+w2 and second.x < first.x+w1 and first.y < second.y+h2 and second.y < first.y+h1
walls = (item, other) -> if other.p == nil then "slide"
class Entity
  new: (p) => @p = p
  update: (dt) => @p.x, @p.y = @p.x + @p.dx*dt, @p.y + @p.dy*dt
  follow: (obj) => 
  	angle = math.atan2((obj.p.y - @p.y), (obj.p.x - @p.x))
  	@p.dx, @p.dy  = @p.speed * math.cos(angle), @p.speed * math.sin(angle)

--could add move up methods here, to assist with cutscene stuff
