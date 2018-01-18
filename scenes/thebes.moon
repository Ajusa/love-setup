export * 
class DarkEyes extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/dark.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 23*64, 48*64, 5
		@music = "sound/oedipus.mp3"
		@cutScene = love.graphics.newVideo("cutscenes/The-Blinding-of-Oedipus.ogv")
		@cutScene2 = love.graphics.newVideo("cutscenes/credits.ogv")
		super!
		export isDialogue = true
		player\speak("Oedipus", {"Oh god, what have I done?"}, -> export isDialogue = false)
		export dagger = love.graphics.newImage("images/Brooch.png")
		export shoot = ->
			if sinceFire > .5 and not isDialogue
				x, y = love.mouse.getPosition()
				export sinceFire = 0
				startX, startY = player.p.x + 32, player.p.y + 32
				mouseX, mouseY = camera\worldCoords(x,y) --this stops the mouse coords from being off from the real coors, cause we have a camera
				angle = math.atan2((mouseY - startY), (mouseX - startX))
				dx, dy = 350 * math.cos(angle), 350 * math.sin(angle)
				player.p.lives -= 1
				table.insert(bullets, Dagger x: startX, y: startY, :dx, :dy, :angle, distance: 475)
	update: (dt) =>
		if player.p.lives < 1 
			export isDialogue = true
			@died = true
			@cutScene\play!
			@i = 0
		player\update(dt)
		if collision(player.p, 64, 64, tile(22, 3), 64*4, 64) then export STATE = Palace! --needs to be changed to kabul
	draw: =>
		if @died
			cX,cY = camera\worldCoords(love.graphics.getWidth!/2, 0)
			love.graphics.draw(@cutScene, cX, cY, 0, love.graphics.getHeight!/@cutScene\getHeight!, love.graphics.getHeight!/@cutScene\getHeight!, @cutScene\getWidth!/2)
			if not @cutScene\isPlaying! then
				if @i == 1 then
					@cutScene = @cutScene2
					@cutScene\play!
				else
					@i = 1
					love.audio.stop!
		else super!
class Thebes extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Thebes.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 23*64, 48*64, 5
		@music = "sound/thebes.mp3"
		super!
		export isDialogue = true
		player\speak("Oedipus", {"I wonder if the servant has arrived. Maybe he is talking to Jocasta in the palace, right now?"}, -> export isDialogue = false)
	update: (dt) =>
		player\update(dt)
		if collision(player.p, 64, 64, tile(22, 3), 64*4, 64) then export STATE = Palace! --needs to be changed to kabul
	draw: =>
		super!
class Palace extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Oedipus's Palace.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 24*64, 46*64, 5
		@music = "sound/jocasta.mp3"
		super!
		export isDialogue = true
		@jocasta = Jocasta x:24*64, y: 25*64, speed: 130, image: love.graphics.newImage("images/Jocasta.png"), lives: 30
		player\speak("Oedipus", {"Where is the wife, no wife, the teeming womb -- That bore a double harvest, me and mine?"}, -> 
			@jocasta\speak("Jocasta", {"Right here, wicked Oedipus. Why did you have to find the truth?", 
			"The only way to make things right is to kill you. Guards, take him!"}, -> export isDialogue = false)
		)
		@cutScene = love.graphics.newVideo("cutscenes/Jocasta.ogv")
	update: (dt) =>
		player\update(dt)
		@jocasta\update(dt)
		for i=#brooches,1,-1 do
			if collision(brooches[i].p, 20, 40, player.p, 64, 64) then
				player.p.lives -= 1
				table.remove(brooches, i)
		for i=#brooches,1,-1 do	brooches[i]\update(dt,i)
		if #enemies > 0
			for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		if @jocasta.p.lives < 1 
			export isDialogue = true
			export enemies = {}
			Timer.clear!
			@died = true
			@cutScene\play!
	death: =>
		export score =  score - 10
		export isDialogue = true
		Timer.clear!
		export enemies = {}
		player.p.lives = 5
		@jocasta\speak("Jocasta", {"Foolish husband! If only you had listened to me..."}, ()->
			@jocasta\speak("Game", {"Your score is now " .. score..". Click to redo the fight!"}, ()->
				export STATE = Palace!
			)
		)
	draw: =>
		if @died
			cX,cY = camera\worldCoords(love.graphics.getWidth!/2, 0)
			love.graphics.draw(@cutScene, cX, cY, 0, love.graphics.getHeight!/@cutScene\getHeight!, love.graphics.getHeight!/@cutScene\getHeight!, @cutScene\getWidth!/2)
			if not @cutScene\isPlaying! then export STATE = DarkEyes!
		else
			super!
			@jocasta\draw!
			for i,v in ipairs(brooches) do v\draw!
			for i,v in ipairs(enemies) do v\draw!

export brooch = love.graphics.newImage("images/Brooch.png")
export brooches = {}

class JDagger extends Entity
	new: (p) =>
		@p = p
	draw: => love.graphics.draw(brooch, @p.x, @p.y, @p.angle)
	update: (dt, i) => 
		@p.distance += ((@p.dx^2) + (@p.dy^2))^(1/2)*dt
		if @p.distance > 650 do table.remove(brooches, i)
		super dt
class Jocasta extends Entity
	new: (p) =>
		super p
		@p.anim =  anim8.newAnimation(@p.g('1-2',1, '1-2',2), 0.1)
		Timer.every(.7, ->
			angle = math.atan2((player.p.y - @p.y), (player.p.x - @p.x))
			dx, dy = 450 * math.cos(angle), 450 * math.sin(angle)
			table.insert(brooches, JDagger x: @p.x, y: @p.y, :dx, :dy, :angle, distance: 0)
		)
		self\addMinions!
		@handle = Timer.every(5, () -> 
			self\addMinions!
			@p.lives += 1
		)
	update: (dt) =>
		@p.speed += dt
		super\follow(player)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @p, 64, 64) then --change this collision box
				@p.lives -= 1
				table.remove(bullets, i)
		super dt
	addMinions: =>
		if #enemies < 50
			for i = 1, 3 do table.insert(enemies, Enemy x: random(@p.x + (64*(2)), @p.x - (2)*64), y: random(@p.y + (64*(2)), @p.y - (2)*64), lives: 2, speed: @p.speed-20, image: love.graphics.newImage("images/Laius servant.png"))
	draw: =>
		super!
		love.graphics.setFont(kenPixel)
		love.graphics.print("Lives: "..@p.lives, @p.x, @p.y-30)