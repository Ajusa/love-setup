export * 
class CrossRoads extends BaseState
	new: =>
		export world = bump.newWorld!
		--export isDialogue = true
		export map = sti("data/castle.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives, score = 9*64, 6*64, 5, 0
		super!
		@oedipus = Entity x: 7*64, y: 6*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/messenger.png")
		player\speak("Amir", {"Who are you, traveller?"}, -> 
			@oedipus\moveTo(tile(8, 6), ->
				@oedipus\moveTo(tile(5, 6), ->
					@oedipus\speak("Oedipus", {"I am Oedipus. -- I was a mighty king. Now I am a blind man."})
				)
			))
		--player\moveTo(tile(43, 10))
	update: (dt) =>
		player\update(dt)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		@oedipus\draw!
