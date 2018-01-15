export * 
class America extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 9*64, 6*64, 5
		super!
		@barker = Entity x: 8*64, y: 23*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Mrs. Barker.png")
		--player\moveTo(tile(43, 10))
	update: (dt) =>
		player\update(dt)
		if collision(player.p, 64, 64, tile(9, 23), 64, 128)
			export isDialogue = true
			@barker\speak("Mrs. Barker", {"Are you sure you want to do this dear?", 
				"I understand what happened now, so I don't blame you for wanting to, but this decision is permanent.", 
				"Yes? Good luck then,"}, ->
				player\moveTo(tile(9, 24), ()->export STATE = AmericaFight!)
				
			)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		@barker\draw!

class Mommy extends Entity
	new: (p) =>
		super p
		@p.g = anim8.newGrid(32, 32, @p.image\getWidth!, @p.image\getHeight!)
		@p.anim = anim8.newAnimation(@p.g(1,1), 0.1)
	talk: =>
		Mommy\speak("Mommy", {"Oh hi there Young Man...",
			"Why are you still here?"
		 	"You're here to kill me? For what, hurting that useless bumble?",
		 	"Fine, who's going notice another dead child? Go Daddy, kill him to prove your masculinity."}, 
			() -> 
				export isDialogue = false
				export mommy = BossMommy(@p)
		)
class BossMommy extends Entity
	new: (p) => 
		super p
		@p.image = love.graphics.newImage("images/Mommy Mad.png")
		@p.g = anim8.newGrid(32, 32, @p.image\getWidth!, @p.image\getHeight!)
		@p.anim = anim8.newAnimation(@p.g('1-2',1, '1-2',2), 0.1)
		self\addMinions!
		@handle = Timer.every(10, () -> 
			self\addMinions!
			@p.lives += 3
		)
	update: (dt) =>
		super dt
		super\follow(player)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @p, 128, 128) then --change this collision box
				@p.lives -= 1
				table.remove(bullets, i)
	addMinions: =>
		if #enemies < 100
			for i = 1, 10 do table.insert(enemies, Enemy x: random(@p.x + (64*(5)), @p.x - (5)*64), y: random(@p.y + (64*(5)), @p.y - (5)*64), lives: 2, speed: 100, image: love.graphics.newImage("images/Daddy.png"))
	draw: =>
		super!
		love.graphics.setFont(kenPixel)
		love.graphics.print("Lives: "..@p.lives, @p.x, @p.y-30)
    --do something
class AmericaFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/American Dream Apartment.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 24*64, 48*64, 5
		@died = false
		@cutScene = love.graphics.newVideo("cutscenes/Mommy-death.ogv")
		super!
		export mommy = Mommy x:24*64, y: 18*64, dx:0, dy:0, speed: 100, lives: 30, image: love.graphics.newImage("images/Mommy.png")
		player\moveTo(tile(24, 22), -> mommy\talk!)
		--player\moveTo(tile(43, 10))
	death: =>
		export score =  score - 10
		export isDialogue = true
		Timer.cancel(mommy.handle)
		export enemies = {}
		player.p.lives = 5
		Mommy\speak("Mommy", {"You see! Another bumble falls. Aren't we such good parents, Daddy?"}, ()->
			Mommy\speak("Game", {"Your score is now " .. score..". Click to redo the fight!"}, ()->
				export STATE = AmericaFight!
			)
		)
	update: (dt) =>
		player\update(dt)
		mommy\update(dt)
		if collision(mommy.p, 64, 64, player.p, 64, 64) then self\death!
		if mommy.p.lives < 1 
			export isDialogue = true
			Mommy\speak("Mommy", {"NOOOO!"}, ()->
				export enemies = {}
				Timer.cancel(mommy.handle)
				@died = true
				@cutScene\play!
				
			)
		if #enemies > 0
			for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		if @died
			cX,cY = camera\worldCoords(love.graphics.getWidth!/2, 0)
			love.graphics.draw(@cutScene, cX, cY, 0, love.graphics.getHeight!/@cutScene\getHeight!, love.graphics.getHeight!/@cutScene\getHeight!, @cutScene\getWidth!/2)
			if not @cutScene\isPlaying! then export STATE = CrossRoads3!
		else
			super!
			for i,v in ipairs(enemies) do v\draw!
			mommy\draw!
