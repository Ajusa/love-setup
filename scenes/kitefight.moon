export * 
class KiteFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/dark.lua", {"bump"})
		export isDialogue = true
		player.p.x, player.p.y, player.p.lives, score = 37*64, 22*64, 5, 0
		super!
		export assef =  Assef x:32*64, y: 13*64, speed: 175, image: love.graphics.newImage("images/Assef.png")
		@died = false
		@cutScene = love.graphics.newVideo("cutscenes/Assef-Death.ogv")
		Moan.speak("Amir", {"I decided to walk in to the building, hoping to find Sohrab"}, 
		{oncomplete: -> 
			export world = bump.newWorld!
			export map = sti("data/Assef's House.lua", {"bump"})
			super!
			player\moveTo(tile(37, 19))
			assef\moveTo(tile(37, 15), assef\talk)
		})
	death: =>
		@died = true
		@cutScene\play!
		export enemies = {}
		--play the movie
		
	update: (dt) =>
		if #enemies > 0
			for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		player\update(dt)
		assef\update(dt)
		if collision(assef.p, 64, 64, player.p, 64, 64) then self\death!
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		if @died
			cX,cY = camera\worldCoords(love.graphics.getWidth!/2, 0)
			love.graphics.draw(@cutScene, cX, cY, 0, love.graphics.getHeight!/@cutScene\getHeight!, love.graphics.getHeight!/@cutScene\getHeight!, @cutScene\getWidth!/2)
			if not @cutScene\isPlaying! then export STATE = BabaScene!
		else 
			super!
			for i,v in ipairs(enemies) do v\draw!
			assef\draw!

class Assef extends Entity
	new:(p) =>
		super p
	talk: =>
		Moan.speak("Assef", {"What, didn't recognize me?",
		 "I never forget a face. You can do away with that now"
		 	"You can have the boy, of course. However, we still have something to settle, don't we?",
		 	"Hassan can't help you either. Let's do this."}, 
			{oncomplete: ()-> 
				export isDialogue = false
				export assef = BossAssef(@p)
				for i = 1, 10 do table.insert(enemies,Enemy x: random(64*(2), (52)*64), y: random(64*(2), (30)*64), lives: 2, speed: 30, image: love.graphics.newImage("images/Taliban Member 1.png"))
				for i = 1, 10 do table.insert(enemies,Enemy x: random(64*(2), (52)*64), y: random(64*(2), (30)*64), lives: 2, speed: 30, image: love.graphics.newImage("images/Taliban Member.png"))
			})

class BossAssef extends Entity
	update: (dt) =>
		@p.speed += dt
		super\follow(player)
		super dt
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)
