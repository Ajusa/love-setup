export * 
class BabaScene extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/castle.lua", {"bump"})
		export isDialogue = true
		player.p.x, player.p.y, player.p.lives, score = 9*64, 6*64, 5, 0
		super!
		@baba = Entity x: 7*64, y: 6*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Baba.png")
		player\speak("Amir", {"Baba? Is that you? Where is my mother?"}, -> 
			@baba\speak("Baba", {"You killed her Amir. My Princess. She died giving birth to you."}, ->
				@baba\moveTo(tile(10, 7))
				@baba\speak("Baba", {"Do you know what it is like growing up without a mother? Your story will not be a happy one, Amir."}, ->
					player\speak("Amir", {"No Baba! It wasn't -- my -- fault"}, ->
						export STATE = CrossRoads!
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
		@baba\draw!
