export * 
class CrossRoads extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Cross Roads.lua", {"bump"})
		export isDialogue = true
		super!
		player.p.x, player.p.y, player.p.lives, score = 42*64, 46*64, 5, 0
		@oedipus = Entity x: 37*64, y: 48*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Oedipus.png")
		@man = Entity x: 54*64, y: 47*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Young Man.png")
		player\speak("Amir", {"Who are you, blind traveller?"}, -> 
			@oedipus\moveTo(tile(38, 49), ->
				@oedipus\moveTo(tile(36, 45), ->
					@oedipus\speak("Oedipus", {"I am Oedipus. -- I was a mighty king. Now I am a lost soul."}, ->
						@man\moveTo(tile(45, 47))
						@man\speak("Young Man", {"Hey guys? What are all of you doing out here?"}, ->
							@oedipus\speak("Oedipus", {"Do any of you know stories?", "When you have been in the wilderness for so long, you start to long for something exciting"}, ->
								player\speak("Amir", {"Luckily for you, I am a prime storyteller. Let me tell you about my past..."}, -> export STATE = KiteFight!)
							)
						)
					)
				)
			)
		)
		--player\moveTo(tile(43, 10))
	update: (dt) =>
		player\update(dt)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		@oedipus\draw!
		@man\draw!
