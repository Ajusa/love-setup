export * 
class Thebes extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Thebes.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 23*64, 48*64, 5
		super!
		export isDialogue = true
		player\speak("Oedipus", {"I wonder if the servant has arrived. Maybe he is talking to Jocasta in the palace, right now?"}, -> export isDialogue = false)
	update: (dt) =>
		player\update(dt)
		if collision(player.p, 64, 64, tile(22, 3), 64*4, 64) then export STATE = Palace! --needs to be changed to kabul
	draw: =>
		super!
class Palace extends BaseState
	new: =>
		export world = bump.newWorld!
		export map = sti("data/Oedipus's Palace.lua", {"bump"})
		player.p.x, player.p.y, player.p.lives = 24*64, 46*64, 5
		super!
		export isDialogue = true
		@jocasta = Jocasta x:24*64, y: 25*64, speed: 175, image: love.graphics.newImage("images/Jocasta.png")
		player\speak("Oedipus", {"Where is the wife, no wife, the teeming womb -- That bore a double harvest, me and mine?"}, -> 
			@jocasta\speak("Jocasta", {"Right here, wicked Oedipus. Why did you have to find the truth?", 
			"The only way to make things right is to kill you. Guards, take him!"})
			export isDialogue = false
		)
	update: (dt) =>
		player\update(dt)
		@jocasta\update(dt)
	draw: =>
		super!
		@jocasta\draw!

class Jocasta extends Entity
	new: (p) = >
		super p
		@p.anim =  anim8.newAnimation(@p.g('1-2',1, '1-2',2), 0.1)
	update: (dt) =>
		@p.speed += dt
		super\follow(player)
		super dt
	draw: => love.graphics.draw(@p.image, @p.x, @p.y,0, 4, 4)

