export * 
class KiteFight extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/dark.lua", {"bump"})
		export isDialogue = true
		player.p.x, player.p.y, player.p.lives, score = 43*64, 6*64, 5, 0
		super!
		export assef =  Assef x:43*64, y: 13*64, speed: 175, image: love.graphics.newImage("images/Assef.png")
		Moan.speak("Amir", {"I decided to walk in to the building, hoping to find Sohrab"}, 
		{oncomplete: -> 
			export world = bump.newWorld!
			export map = sti("data/testmap.lua", {"bump"})
			super!
			player\moveTo(tile(43, 10))
			assef\moveTo(tile(47, 10), assef\talk)
		})
	death: =>
		for i=#enemies,1,-1 do world\remove(enemies[i])
		enemies = {}
		--play the movie
		export STATE = BabaScene!
	update: (dt) =>
		for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		player\update(dt)
		assef\update(dt)
		if collision(assef.p, 64, 64, player.p, 64, 64) then self\death!
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
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
				for i = 1, 10 do table.insert(enemies,Enemy x: random(64*(2), (32)*64), y: random(64*(2), (map.height-2)*64), lives: 2, speed: 30, image: love.graphics.newImage("images/Taliban Member 1.png"))
				for i = 1, 10 do table.insert(enemies,Enemy x: random(64*(2), (32)*64), y: random(64*(2), (map.height-2)*64), lives: 2, speed: 30, image: love.graphics.newImage("images/Taliban Member.png"))
			})

class BossAssef extends Entity
	update: (dt) =>
		--@p.speed += dt
		super\follow(player)
		super dt
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)
