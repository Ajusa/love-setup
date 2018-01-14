export * 
class CrossRoads extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Cross Roads.lua", {"bump"})
		export isDialogue = true
		super!
		player.p.x, player.p.y, player.p.lives, player.p.anim = 42*64, 46*64, 5, anim8.newAnimation(player.p.g('1-2',1, '1-2',2), 0.1)
		@oedipus = Entity x: 37*64, y: 48*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Blind Oedipus.png")
		@man = Entity x: 54*64, y: 47*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Young Man.png")
		player\speak("Amir", {"Who are you, blind traveller?"}, -> 
			@oedipus\moveTo(tile(38, 49), ->
				@oedipus\moveTo(tile(36, 45), ->
					@oedipus\speak("Oedipus", {"I am Oedipus. -- I was a mighty king. Now I am a lost soul."}, ->
						@man\moveTo(tile(45, 47))
						@man\speak("Young Man", {"Hey guys? What are all of you doing out here?"}, ->
							@oedipus\speak("Oedipus", {"Do any of you know stories?", "When you have been in the wilderness for so long, you start to long for something exciting"}, ->
								player\speak("Amir", {"Luckily for you, I am a prime storyteller. Let me tell you about my past..."}, -> export STATE = DarkRoom!)
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
class CrossRoads2 extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Cross Roads.lua", {"bump"})
		export isDialogue = true
		super!
		player.p.x, player.p.y, player.p.lives, player.p.image, player.p.anim = 45*64, 47*64, 5, love.graphics.newImage("images/Young Man.png"), anim8.newAnimation(player.p.g('1-2',1, '1-2',2), 0.1)
		@oedipus = Entity x: 40*64, y: 45*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Blind Oedipus.png")
		@amir = Entity x: 42*64, y: 46*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Amir.png")
		player\speak("Young Man", {"Wow, you've gone through a lot."}, -> 
			@oedipus\speak("Oedipus", {"I too never had a mother's love."}, ->
				@amir\speak("Young Man", {"You guys are regretting that? Now let me tell you what my mother did..."}, ->
					export isDialogue = false
					export STATE = America!
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
		@amir\draw!
class CrossRoads3 extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Cross Roads.lua", {"bump"})
		export isDialogue = true
		super!
		player.p.x, player.p.y, player.p.lives, player.p.image = 40*64, 46*64, 5, love.graphics.newImage("images/Blind Oedipus.png")
		player.p.g = anim8.newGrid(16, 16, player.p.image\getWidth!, player.p.image\getHeight!)
		player.p.anim = anim8.newAnimation(player.p.g(1,1), 0.1)
		@man = Entity x: 45*64, y: 47*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Young Man.png")
		@amir = Entity x: 42*64, y: 46*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Amir.png")
		player\speak("Oedipus", {"Child, you killed your own mother?"}, -> 
			@amir\speak("Amir", {"That is pretty dark."}, ->
				@man\speak("Young Man", {"Hey, she killed my brother when she bought him at an orphanage."}, ->
					player\speak("Oedipus", {"I actually had a good reason for killing my mother. Well, she was also my wife.", "It all started with me killing my father..."}, -> 
						@amir\speak("Amir", {"..."}, ->
							@man\speak("Young Man", {"..."}, ->
								export STATE = CrossRoadsFight!
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
		@man\draw!
		@amir\draw!
class CrossRoadsFight extends BaseState
	new: =>
		export isDialogue = true
		export world = bump.newWorld!
		export map = sti("data/Cross Roads.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives, player.p.image = 56*64, 49*64, 5, love.graphics.newImage("images/Oedipus.png")
		player.p.g = anim8.newGrid(16, 16, player.p.image\getWidth!, player.p.image\getHeight!)
		player.p.anim = anim8.newAnimation(player.p.g('1-3',1, '1-3',2, '1-2',2), 0.1)
		export laius = Entity x: 36*64, y: 52*64, w: 64, h: 64, speed: 200, image: love.graphics.newImage("images/Laius.png")
		player\moveTo(tile(39, 50), ->
			player\speak("Oedipus", {"Get out of the way, old man."},  ->
				laius\speak("Laius", {"Do you have any idea who you are talking to, boy?"}, ->
					player\speak("Oedipus", {"If you don't get out of the way, I will remove you forcibly."}, ->
						laius\speak("Laius", {"You can try. Guards, take him!"}, ->
							export isDialogue = false
						)
					)
				)
			)
		)
		super!
		export mommy = Mommy x:41*64, y: 13*64, dx:0, dy:0, speed: 100, lives: 20, image: love.graphics.newImage("images/Mommy.png")
		--mommy\talk!
		--player\moveTo(tile(43, 10))
	death: =>
		export score =  score - 10
		export isDialogue = false
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
		laius\draw!