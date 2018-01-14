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
		self\addMinions!
		@handle = Timer.every(10, () -> self\addMinions!)
	update: (dt) =>
		super dt
		super\follow(player)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @p, 64, 64) then --change this collision box
				@p.lives -= 1
				table.remove(bullets, i)
	addMinions: =>
		if #enemies < 100
			for i = 1, 10 do table.insert(enemies, Enemy x: random(64*(2), (32)*64), y: random(64*(2), (map.height-2)*64), lives: 2, speed: 60, image: love.graphics.newImage("images/Daddy.png"))
	draw: =>
		super!
		love.graphics.setFont(kenPixel)
		love.graphics.print("Lives: "..@p.lives, @p.x, @p.y-30)
    --do something
class AmericaFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/testmap.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 38*64, 13*64, 5
		super!
		export mommy = Mommy x:43*64, y: 13*64, dx:0, dy:0, speed: 100, lives: 20, image: love.graphics.newImage("images/Granny.png")
		mommy\talk!
		--player\moveTo(tile(43, 10))
	death: =>
		export score =  score - 10
		export isDialogue = true
		Timer.cancel(mommy.handle)
		export enemies = {}
		player.p.lives = 5
		Mommy\speak("Mommy", {"You see! Another bumble falls. Aren't we such good parents, Daddy?"}, ()->
			Mommy\speak("Game", {"Your score is now " .. score..". Hit enter to redo the fight!"}, ()->
				export STATE = AmericaFight!
			)
		)
	update: (dt) =>
		player\update(dt)
		mommy\update(dt)
		if collision(mommy.p, 64, 64, player.p, 64, 64) then self\death!
		if mommy.p.lives < 1 
			export isDialogue = true
			Mommy\speak("Mommy", {"Argh... you done killed me."}, ()->
				export enemies = {}
				Timer.cancel(mommy.handle)
				export STATE = CrossRoads!
			)
		if #enemies > 0
			for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		for i,v in ipairs(enemies) do v\draw!
		mommy\draw!
