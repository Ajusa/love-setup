export * 
class BabaScene extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Baba's House.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 30*64, 12*64, 5
		@music = "sound/kabul.mp3"
		super!
		@baba = Entity x: 16*64, y: 7*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Baba.png")
		export isDialogue = true
		player\speak("Amir", {"... Where am I? This looks like Baba's house?! -- But it is brand new, as if the bombings never happened."}, -> export isDialogue = false)
		--player\moveTo(tile(43, 10))
	update: (dt) =>
		player\update(dt)
		for i=#bullets,1,-1 do if collision(bullets[i].p, 20, 40, @baba.p, 64, 64) then
			export isDialogue = true
			player\speak("Amir", {"Baba? Is that you? Where is my mother?"}, -> 
				@baba\speak("Baba", {"You killed her Amir. My Princess. She died giving birth to you."}, ->
					@baba\speak("Baba", {"Do you know what it is like growing up without a mother? Your story will not be a happy one, Amir."}, ->
						player\speak("Amir", {"No Baba! It wasn't -- my -- fault"}, ->
							export STATE = CrossRoads2!
						)
					)
				)
			)
		--if love.keyboard.isDown("return") then export STATE = KiteFight!
	draw: =>
		super!
		@baba\draw!
