export * 
sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
Timer = require('lib/timer')
Moan = require('lib/Moan')
anim8 = require('lib/anim8')
kenPixel = love.graphics.newFont("lib/kenpixel.ttf", 18)
love.graphics.setDefaultFilter("nearest")
--love.window.setFullscreen(true)
Moan.font = kenPixel
Moan.selectButton = 1
Moan.setSpeed(0.05)
random = (l, h) -> love.math.random(l, h)
tile = (x, y) -> {x: x*64, y: y*64}
fullCollision = (x1,y1,w1,h1, x2,y2,w2,h2) -> x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
collision = (first,w1,h1,second,w2,h2) -> first.x < second.x+w2 and second.x < first.x+w1 and first.y < second.y+h2 and second.y < first.y+h1
walls = (item, other) -> if other.p == nil then "slide"
shuffle = (tbl) ->
	size = #tbl
	for i = size, 1, -1 do
		rand = math.random(size)
		tbl[i], tbl[rand] = tbl[rand], tbl[i]
	return tbl
clone = (t) -> -- deep-copy a table
	if type(t) ~= "table" then return t
	meta = getmetatable(t)
	target = {}
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = clone(v)
		else
			target[k] = v
	setmetatable(target, meta)
	return target
class Entity
  new: (p) =>
	@p = p
	@p.g = anim8.newGrid(16, 16, @p.image\getWidth!, @p.image\getHeight!)
	@p.anim = anim8.newAnimation(@p.g(1,1), 0.1)
  update: (dt) => 
	@p.x, @p.y = @p.x + @p.dx*dt, @p.y + @p.dy*dt
	if @p.anim then @p.anim\update(dt)
  draw: => @p.anim\draw(@p.image, @p.x, @p.y, 0,4,4)
  moveTo: (obj, after=() ->) =>
	@handle = Timer.every(.04, () ->
		angle = math.atan2((obj.y - @p.y), (obj.x - @p.x))
		@p.dx, @p.dy  = @p.speed/20 * math.cos(angle), @p.speed/20 * math.sin(angle)
		@p.x, @p.y = @p.x + @p.dx, @p.y + @p.dy
		if math.abs(obj.y - @p.y) + math.abs(obj.x - @p.x) < 10 
			Timer.cancel(@handle)
			after!
	)
  speak: (name, obj, after=()->) =>
	Moan.speak(name, obj, {oncomplete: after})
  follow: (obj, cons = 1) => 
	angle = math.atan2((obj.p.y - @p.y), (obj.p.x - @p.x))
	@p.dx, @p.dy = @p.speed * cons * math.cos(angle), @p.speed * cons * math.sin(angle)

class BaseState
	new: =>
		map\bump_init(world)
		world\add(player, player.p.x + 4, player.p.y + 4, 48, 48)
	draw: =>
		map\draw()
		for i,v in ipairs(bullets) do v\draw!
		player\draw!
	death: => player.p.lives = 5
--could add move up methods here, to assist with cutscene stuff
