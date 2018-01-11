assert(love.filesystem.load("lib/lib.lua"))!
require("scenes/kitefight")
export *
sinceFire = 0
score = 0
enemies = {}
isDialogue = false
--Classes--
class Dagger extends Entity
	draw: => love.graphics.draw(dagger, @p.x, @p.y, @p.angle)
	update: (dt, i) => 
		@p.distance += ((@p.dx^2) + (@p.dy^2))^(1/2)*dt
		if @p.distance > 400 do table.remove(bullets, i)
		super dt
class Enemy extends Entity
	new: (p) => 
		@p = p
		world\add(self, @p.x+8, @p.y+8, 48, 48)
	draw: => love.graphics.draw(enemy, @p.x, @p.y, 0,4,4)
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
		g = anim8.newGrid(16, 16, @p.image\getWidth!, @p.image\getHeight!)
		@p.anim = anim8.newAnimation(g('1-3',1, '1-3',2, 1,3), 0.1)
	draw: => @p.anim\draw(@p.image, @p.x, @p.y, 0,4,4)
	update: (dt) =>
		if not @p.disabled
			@p.anim\update(dt)
			if love.keyboard.isDown("a") then @p.x, @p.y = world\move(self, @p.x - @p.speed*dt,@p.y, walls)
			if love.keyboard.isDown("d") then @p.x, @p.y = world\move(self, @p.x + @p.speed*dt,@p.y, walls)
			if love.keyboard.isDown("w") then @p.x, @p.y = world\move(self, @p.x, @p.y - @p.speed*dt, walls)
			if love.keyboard.isDown("s") then @p.x, @p.y = world\move(self, @p.x, @p.y + @p.speed*dt, walls)
			for i=#enemies,1,-1 do if fullCollision(enemies[i].p.x + 8, enemies[i].p.y + 8, 48, 48, @p.x, @p.y, 64, 64) -- the 8's are for a smaller hitbox
					@p.lives -= 1
					table.remove(enemies, i)
--States--

class BeforeFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		player.p.x, player.p.y = (10)*64, (3)*64
		super!
		isDialogue = true
		Moan.speak("Duncan", {"The Devil dam thee black, thou cream faced loon! Why gottest thou that goose face?"}) 
		Moan.speak("Messenger", {"There are ten thousand-"}) 
		Moan.speak("Duncan", {"GEESE villian?"})
		Moan.speak("Messenger", {"Soldiers sir"}, {oncomplete: ()-> isDialogue = false})
		@messenger = love.graphics.newImage("images/messenger.png")
	update: (dt) =>
		if collision(player.p, 64, 64, tile(9, 24), 128, 64) then export STATE = KiteFight!
		player\update(dt)
	draw: (dt) =>
		super!
		love.graphics.draw(@messenger, 10*64, 5*64, 0,4,4)
class Castle extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		player.p.x, player.p.y = (17)*64, (15)*64
		@duncan = love.graphics.newImage("images/duncan.png")
		super!
	update: (dt) => 
		player\update(dt)
		for i,v in ipairs(bullets)
			if collision(v.p, 20, 40, tile(10,3), 64, 64)
				isDialogue = true
				@duncan = love.graphics.newImage("images/duncandead.png")
				Moan.speak("Narrator", {"Macbeth becomes king, and soon Malcolm is leading an army against him."}, 
					{oncomplete: ()-> 
						export STATE = BeforeFight!
						isDialogue = false
					})
	draw: =>
		super!
		love.graphics.draw(@duncan, 10*64, 3*64, 0,4,4)
		
--Actual Game--
love.load = ->	
	export player = Player x: 43*64, y: 6*64, w: 64, h: 64, speed: 400, lives: 5, image: love.graphics.newImage("Oedipus.png")
	export STATE = KiteFight!
	export camera = Camera(player.p.x, player.p.y)
	export bullets = {}
	export dagger = love.graphics.newImage("images/dagger.png")
	export enemy = love.graphics.newImage("images/enemy.png")
love.update = (dt) ->
	Moan.update(dt)
	Timer.update(dt)
	if not isDialogue then STATE\update(dt)
	if player.p.lives > 0
		-- Update world
		map\update(dt)
		sinceFire += dt
		for i=#bullets,1,-1 do bullets[i]\update(dt,i)
		camera\lockPosition(player.p.x, player.p.y)
love.draw = ->
	if player.p.lives > 0
		camera\attach!
		STATE\draw!
		--map\bump_draw(world) --this is the debug code for seeing collision boxes
		camera\detach!
		love.graphics.setColor(255, 0, 0, score)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth!, love.graphics.getHeight!)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setFont(kenPixel)
		love.graphics.print("Lives: "..player.p.lives, 12, 12)
		Moan.draw!
	else 
		love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 30))
		love.graphics.print("GAME OVER MACBETH!", love.graphics.getWidth!/4, love.graphics.getHeight!/2)
		love.graphics.print("Score: ".. score, love.graphics.getWidth!/4, love.graphics.getHeight!/1.5)
		love.graphics.print("Hit enter to play again ", love.graphics.getWidth!/4, love.graphics.getHeight!/1.2)
love.mousepressed = (x, y, button) ->
	if button == 1 and sinceFire > .3 and not isDialogue
		sinceFire = 0
		startX, startY = player.p.x + 32, player.p.y + 32
		mouseX, mouseY = camera\worldCoords(x,y) --this stops the mouse coords from being off from the real coors, cause we have a camera
		angle = math.atan2((mouseY - startY), (mouseX - startX))
		dx, dy = 250 * math.cos(angle), 250 * math.sin(angle)
		table.insert(bullets, Dagger x: startX, y: startY, :dx, :dy, :angle, distance: 0)
love.keyreleased = (key) -> Moan.keyreleased(key)