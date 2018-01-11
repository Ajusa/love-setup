assert(love.filesystem.load("lib/lib.lua"))!
--love.window.setFullscreen(true)
sinceFire = 0
score = 0
enemies = {}
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
class Macduff extends Entity
	update: (dt) =>
		@p.speed += dt
		super\follow(player)
		super dt
		if fullCollision(@p.x, @p.y, 64, 64, player.p.x, player.p.y, 64, 64)
			player.p.lives = 0
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)
class Player extends Entity		
	draw: => love.graphics.draw(@p.image, @p.x, @p.y, 0,4,4)
	update: (dt) =>
		if not @p.disabled
			if love.keyboard.isDown("a") then @p.x, @p.y = world\move(self, @p.x - @p.speed*dt,@p.y, walls)
			if love.keyboard.isDown("d") then @p.x, @p.y = world\move(self, @p.x + @p.speed*dt,@p.y, walls)
			if love.keyboard.isDown("w") then @p.x, @p.y = world\move(self, @p.x, @p.y - @p.speed*dt, walls)
			if love.keyboard.isDown("s") then @p.x, @p.y = world\move(self, @p.x, @p.y + @p.speed*dt, walls)
			for i=#enemies,1,-1 do if fullCollision(enemies[i].p.x + 8, enemies[i].p.y + 8, 48, 48, @p.x, @p.y, 64, 64) -- the 8's are for a smaller hitbox
					@p.lives -= 1
					table.remove(enemies, i)
--States--
class BaseState
	new: =>
		map\bump_init(world)
		world\add(player, player.p.x + 8, player.p.y + 8, 48, 48)
	draw: =>
		map\draw()
		for i,v in ipairs(bullets) do v\draw!
		player\draw!
class MainGame extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/testmap.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives, score = 43*64, 4*64, 5, 0
		super!
		export enemies = for i = 1, 40 do Enemy x: random(64*(2), (32)*64), y: random(64*(2), (map.height-2)*64), lives: 5, isEnemy: true, speed: 30
		export macduff =  Macduff x:128, y: 20*64, speed: 90, image: love.graphics.newImage("images/macduff.png")
	update: (dt) =>
		if score > 100 then macduff\update(dt)		
		for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		player\update(dt)
		if love.keyboard.isDown("return") then export STATE = MainGame!
	draw: =>
		super!
		for i,v in ipairs(enemies) do v\draw!
class BeforeFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		player.p.x, player.p.y = (10)*64, (3)*64
		super!
		line = love.audio.newSource("sound/beforegame.ogg")
		line\play!
		@messenger = love.graphics.newImage("images/messenger.png")
		player.p.disabled = true
		--line\getDuration!
		Timer.after(2, () -> player.p.disabled = false)
	update: (dt) =>
		if fullCollision(player.p.x, player.p.y, 64, 64, 9*64, 24*64, 128, 64) then export STATE = MainGame!
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
			if fullCollision(v.p.x, v.p.y, 20, 40, 10*64, 3*64, 64, 64)
				Moan.speak("Narrator", {"Macbeth becomes king, and soon Malcolm is leading an army against him."}, 
					{onstart: ()-> player.p.disabled = true, oncomplete: ()-> 
						player.p.disabled = false
						export STATE = BeforeFight!
					 })
				@duncan = love.graphics.newImage("images/duncandead.png")
	draw: =>
		super!
		love.graphics.draw(@duncan, 10*64, 3*64, 0,4,4)
		
--Actual Game--
love.load = ->	
	export player = Player x: 43*64, y: 6*64, w: 64, h: 64, speed: 400, lives: 5, image: love.graphics.newImage("images/player.png")
	export STATE = Castle!
	export camera = Camera(player.p.x, player.p.y)
	export bullets = {}
	export dagger = love.graphics.newImage("images/dagger.png")
	export enemy = love.graphics.newImage("images/enemy.png")
love.update = (dt) ->
	Moan.update(dt)
	Timer.update(dt)
	STATE\update(dt)
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
		if score > 110 then macduff\draw!
		--map\bump_draw(world) --this is the debug code for seeing collision boxes
		camera\detach!
		love.graphics.setColor(255, 0, 0, score)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth!, love.graphics.getHeight!)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print("Lives: "..player.p.lives, 12, 12)
		Moan.draw!
	else 
		love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 30))
		love.graphics.print("GAME OVER MACBETH!", love.graphics.getWidth!/4, love.graphics.getHeight!/2)
		love.graphics.print("Score: ".. score, love.graphics.getWidth!/4, love.graphics.getHeight!/1.5)
		love.graphics.print("Hit enter to play again ", love.graphics.getWidth!/4, love.graphics.getHeight!/1.2)
love.mousepressed = (x, y, button) ->
	if button == 1 and sinceFire > .3 and not player.p.disabled
		sinceFire = 0
		startX, startY = player.p.x + 32, player.p.y + 32
		mouseX, mouseY = camera\worldCoords(x,y) --this stops the mouse coords from being off from the real coors, cause we have a camera
		angle = math.atan2((mouseY - startY), (mouseX - startX))
		dx, dy = 250 * math.cos(angle), 250 * math.sin(angle)
		table.insert(bullets, Dagger x: startX, y: startY, :dx, :dy, :angle, distance: 0)
love.keyreleased = (key) ->
    Moan.keyreleased(key)