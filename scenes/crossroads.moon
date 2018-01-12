export * 
class CrossRoads extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		export isDialogue = true
		super!
		player.p.x, player.p.y, player.p.lives, score = 9*64, 6*64, 5, 0
		
		@oedipus = Entity x: 7*64, y: 6*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/duncan.png")
		@man = Entity x: 17*64, y: 7*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/messenger.png")
		player\speak("Amir", {"Who are you, traveller?"}, -> 
			@oedipus\moveTo(tile(8, 6), ->
				@oedipus\moveTo(tile(5, 6), ->
					@oedipus\speak("Oedipus", {"I am Oedipus. -- I was a mighty king. Now I am a blind man."}, ->
						@man\moveTo(tile(10, 7))
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
