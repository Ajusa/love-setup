export * 
class KiteFight extends BaseState
	new: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth!, love.graphics.getHeight!)
		export world = bump.newWorld!
		export map = sti("data/testmap.lua", {"bump"})
		export isDialogue = true
		player.p.x, player.p.y, player.p.lives, score = 43*64, 6*64, 5, 0
		super!
		export assef =  Assef x:43*64, y: 10*64, speed: 90, image: love.graphics.newImage("images/macduff.png")
		--export enemies = for i = 1, 40 do Enemy x: random(64*(2), (32)*64), y: random(64*(2), (map.height-2)*64), lives: 5, isEnemy: true, speed: 30
	update: (dt) =>
		assef\update(dt)		
		for i=#enemies,1,-1 do enemies[i]\update(dt,i)
		player\update(dt)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		for i,v in ipairs(enemies) do v\draw!
		assef\draw!

class Assef extends Entity
	new:(p) =>
		super p
		
		Moan.speak("Assef", {"What, didn't recognize me?",
		 "I never forget a face. You can do away with that now"
		 	"You can have the boy, of course. However, we still have something to settle, don't we?",
		 	"Hassan can't help you either. Let's do this."}, 
			{oncomplete: ()-> 
				export isDialogue = false
				export assef = BossAssef(@p)
			})
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)

class BossAssef extends Entity
	update: (dt) =>
		@p.speed += dt
		super\follow(player)
		super dt
		if collision(@p, 64, 64, player.p, 64, 64)
			player.p.lives = 0
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)
