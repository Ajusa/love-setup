export * 
class DarkRoom extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Dark Room.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 14*64, 2*64, 5
		@music = "sound/darkroom.mp3"
		super!
		@tree = Entity x: 21*64, y: 18*64, w: 64, h: 64, image: love.graphics.newImage("images/Pomegranate Tree.png")
		export isDialogue = true
		player\speak("Amir", {"Where am I? Better find the exit..."}, -> export isDialogue = false)
		--player\moveTo(tile(43, 10))
	update: (dt) =>
		player\update(dt)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @tree.p, 64, 64) then
			export isDialogue = true
			@tree\speak("Tree", {"Amir and Hassan, the sultans of Kabul."}, -> 
				export isDialogue = false
			)
		if collision(player.p, 64, 64, tile(13, 48), 192, 64) then export STATE = Kabul! --needs to be changed to kabul
	draw: =>
		super!
		@tree\draw!

class Kabul extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Kabul Concept.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 48*64, 34*64, 5
		@music = "sound/kabul.mp3"
		super!
	update: (dt) =>
		player\update(dt)
		if collision(player.p, 64, 64, tile(3, 10), 128, 64) then export STATE = KiteFight! --needs to be changed to kabul
	draw: =>
		super!

