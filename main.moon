assert(love.filesystem.load("lib/lib.lua"))!
require("scenes/kabul")
require("scenes/kitefight")
require("scenes/crossroads")
require("scenes/babascene")
require("scenes/america")
export *
sinceFire = 0
score = 0
enemies = {}
isDialogue = false
--Classes--
class Dagger extends Entity
	new: (p) =>
  		@p = p
	draw: => love.graphics.draw(dagger, @p.x, @p.y, @p.angle)
	update: (dt, i) => 
		@p.distance += ((@p.dx^2) + (@p.dy^2))^(1/2)*dt
		if @p.distance > 500 do table.remove(bullets, i)
		super dt
class Enemy extends Entity
	new: (p) => 
		super p
		world\add(self, @p.x+8, @p.y+8, 48, 48)
	update: (dt, i) =>
		@p.speed += dt
		super\follow(player)
		super dt
		@p.x, @p.y = world\move(self,@p.x, @p.y, walls)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @p, 64, 64) then
				@p.lives -= 1
				score += 1
				table.remove(bullets, i)
		if @p.lives < 1 do 
				world\remove(self)
				score += 5
				table.remove(enemies, i)
class Player extends Entity	
	new: (p) =>
		@p = p
		@order = {"a", "d", "w", "s"}
		@base = {"a", "d", "w", "s"}
		@p.g = anim8.newGrid(16, 16, @p.image\getWidth!, @p.image\getHeight!)
		@p.anim = anim8.newAnimation(@p.g('1-2',1, '1-2',2), 0.1)
	draw: => @p.anim\draw(@p.image, @p.x, @p.y, 0,4,4)
	scramble: (time) =>
		@order = shuffle(@order)
		Timer.after(time, -> @order = clone(@base))
	update: (dt) =>
		@p.anim\update(dt)
		if love.keyboard.isDown(@order[1]) then @p.x, @p.y = world\move(self, @p.x - @p.speed*dt,@p.y, walls)
		if love.keyboard.isDown(@order[2]) then @p.x, @p.y = world\move(self, @p.x + @p.speed*dt,@p.y, walls)
		if love.keyboard.isDown(@order[3]) then @p.x, @p.y = world\move(self, @p.x, @p.y - @p.speed*dt, walls)
		if love.keyboard.isDown(@order[4]) then @p.x, @p.y = world\move(self, @p.x, @p.y + @p.speed*dt, walls)
		for i=#enemies,1,-1 do if fullCollision(enemies[i].p.x + 8, enemies[i].p.y + 8, 48, 48, @p.x, @p.y, 64, 64) -- the 8's are for a smaller hitbox
				@p.lives -= 1
				table.remove(enemies, i)
shoot = ->
	if sinceFire > .5 and not isDialogue
		x, y = love.mouse.getPosition()
		sinceFire = 0
		startX, startY = player.p.x + 32, player.p.y + 32
		mouseX, mouseY = camera\worldCoords(x,y) --this stops the mouse coords from being off from the real coors, cause we have a camera
		angle = math.atan2((mouseY - startY), (mouseX - startX))
		dx, dy = 350 * math.cos(angle), 350 * math.sin(angle)
		table.insert(bullets, Dagger x: startX, y: startY, :dx, :dy, :angle, distance: 0)
--Actual Game--
love.load = ->	
	export player = Player x: 43*64, y: 6*64, w: 64, h: 64, speed: 200, lives: 5, image: love.graphics.newImage("images/Amir.png")
	export camera = Camera(player.p.x, player.p.y)
	export bullets = {}
	export dagger = love.graphics.newImage("images/dagger.png")
	export cameraX,cameraY = camera\cameraCoords(player.p.x, player.p.y)
	export STATE = AmericaFight!
love.update = (dt) ->
	Moan.update(dt)
	Timer.update(dt)
	if love.mouse.isDown(1) then shoot!
	if not isDialogue then STATE\update(dt)
	if player.p.lives > 0
		-- Update world
		map\update(dt)
		sinceFire += dt
		for i=#bullets,1,-1 do bullets[i]\update(dt,i)
	else STATE\death!
	--camera\lockWindow(player.p.x, player.p.y, cameraX-64, cameraX+64, cameraY-64, cameraY+64) --rectangle for camera to follow
	camera\lockPosition(player.p.x, player.p.y)
love.draw = ->
	camera\attach!
	STATE\draw!
	--map\bump_draw(world) --this is the debug code for seeing collision boxes
	camera\detach!
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(kenPixel)
	love.graphics.print("Lives: "..player.p.lives, 12, 12)
	love.graphics.print("Score: "..score, 130, 12)
	Moan.draw!
	--else 
	--	love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 30))
	--	love.graphics.print("GAME OVER!", love.graphics.getWidth!/4, love.graphics.getHeight!/2)
	--	love.graphics.print("Score: ".. score, love.graphics.getWidth!/4, love.graphics.getHeight!/1.5)
	--	love.graphics.print("Hit enter to play again ", love.graphics.getWidth!/4, love.graphics.getHeight!/1.2)

love.keyreleased = (key) -> Moan.keyreleased(key)
love.mousereleased = (x, y, key) -> Moan.keyreleased(key)