do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      if player.p.lives < 1 then
        isDialogue = true
        self.died = true
        self.cutScene:play()
        self.i = 0
      end
      player:update(dt)
      if collision(player.p, 64, 64, tile(22, 3), 64 * 4, 64) then
        STATE = Palace()
      end
    end,
    draw = function(self)
      if self.died then
        local cX, cY = camera:worldCoords(love.graphics.getWidth() / 2, 0)
        love.graphics.draw(self.cutScene, cX, cY, 0, love.graphics.getHeight() / self.cutScene:getHeight(), love.graphics.getHeight() / self.cutScene:getHeight(), self.cutScene:getWidth() / 2)
        if not self.cutScene:isPlaying() then
          if self.i == 1 then
            self.cutScene = self.cutScene2
            return self.cutScene:play()
          else
            self.i = 1
            return love.audio.stop()
          end
        end
      else
        return _class_0.__parent.__base.draw(self)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/dark.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 23 * 64, 48 * 64, 5
      self.music = "sound/oedipus.mp3"
      self.cutScene = love.graphics.newVideo("cutscenes/The-Blinding-of-Oedipus.ogv")
      self.cutScene2 = love.graphics.newVideo("cutscenes/credits.ogv")
      _class_0.__parent.__init(self)
      isDialogue = true
      player:speak("Oedipus", {
        "Oh god, what have I done?"
      }, function()
        isDialogue = false
      end)
      dagger = love.graphics.newImage("images/Brooch.png")
      shoot = function()
        if sinceFire > .5 and not isDialogue then
          local x, y = love.mouse.getPosition()
          sinceFire = 0
          local startX, startY = player.p.x + 32, player.p.y + 32
          local mouseX, mouseY = camera:worldCoords(x, y)
          local angle = math.atan2((mouseY - startY), (mouseX - startX))
          local dx, dy = 350 * math.cos(angle), 350 * math.sin(angle)
          player.p.lives = player.p.lives - 1
          return table.insert(bullets, Dagger({
            x = startX,
            y = startY,
            dx = dx,
            dy = dy,
            angle = angle,
            distance = 475
          }))
        end
      end
    end,
    __base = _base_0,
    __name = "DarkEyes",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  DarkEyes = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      if collision(player.p, 64, 64, tile(22, 3), 64 * 4, 64) then
        STATE = Palace()
      end
    end,
    draw = function(self)
      return _class_0.__parent.__base.draw(self)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Thebes.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 23 * 64, 48 * 64, 5
      self.music = "sound/thebes.mp3"
      _class_0.__parent.__init(self)
      isDialogue = true
      return player:speak("Oedipus", {
        "I wonder if the servant has arrived. Maybe he is talking to Jocasta in the palace, right now?"
      }, function()
        isDialogue = false
      end)
    end,
    __base = _base_0,
    __name = "Thebes",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Thebes = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      self.jocasta:update(dt)
      for i = #brooches, 1, -1 do
        if collision(brooches[i].p, 20, 40, player.p, 64, 64) then
          player.p.lives = player.p.lives - 1
          table.remove(brooches, i)
        end
      end
      for i = #brooches, 1, -1 do
        brooches[i]:update(dt, i)
      end
      if #enemies > 0 then
        for i = #enemies, 1, -1 do
          enemies[i]:update(dt, i)
        end
      end
      if self.jocasta.p.lives < 1 then
        isDialogue = true
        enemies = { }
        Timer.clear()
        self.died = true
        return self.cutScene:play()
      end
    end,
    death = function(self)
      score = score - 10
      isDialogue = true
      Timer.clear()
      enemies = { }
      player.p.lives = 5
      return self.jocasta:speak("Jocasta", {
        "Foolish husband! If only you had listened to me..."
      }, function()
        return self.jocasta:speak("Game", {
          "Your score is now " .. score .. ". Click to redo the fight!"
        }, function()
          STATE = Palace()
        end)
      end)
    end,
    draw = function(self)
      if self.died then
        local cX, cY = camera:worldCoords(love.graphics.getWidth() / 2, 0)
        love.graphics.draw(self.cutScene, cX, cY, 0, love.graphics.getHeight() / self.cutScene:getHeight(), love.graphics.getHeight() / self.cutScene:getHeight(), self.cutScene:getWidth() / 2)
        if not self.cutScene:isPlaying() then
          STATE = DarkEyes()
        end
      else
        _class_0.__parent.__base.draw(self)
        self.jocasta:draw()
        for i, v in ipairs(brooches) do
          v:draw()
        end
        for i, v in ipairs(enemies) do
          v:draw()
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Oedipus's Palace.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 24 * 64, 46 * 64, 5
      self.music = "sound/jocasta.mp3"
      _class_0.__parent.__init(self)
      isDialogue = true
      self.jocasta = Jocasta({
        x = 24 * 64,
        y = 25 * 64,
        speed = 130,
        image = love.graphics.newImage("images/Jocasta.png"),
        lives = 30
      })
      player:speak("Oedipus", {
        "Where is the wife, no wife, the teeming womb -- That bore a double harvest, me and mine?"
      }, function()
        return self.jocasta:speak("Jocasta", {
          "Right here, wicked Oedipus. Why did you have to find the truth?",
          "The only way to make things right is to kill you. Guards, take him!"
        }, function()
          isDialogue = false
        end)
      end)
      self.cutScene = love.graphics.newVideo("cutscenes/Jocasta.ogv")
    end,
    __base = _base_0,
    __name = "Palace",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Palace = _class_0
end
brooch = love.graphics.newImage("images/Brooch.png")
brooches = { }
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(brooch, self.p.x, self.p.y, self.p.angle)
    end,
    update = function(self, dt, i)
      self.p.distance = self.p.distance + (((self.p.dx ^ 2) + (self.p.dy ^ 2)) ^ (1 / 2) * dt)
      if self.p.distance > 650 then
        do
          table.remove(brooches, i)
        end
      end
      return _class_0.__parent.__base.update(self, dt)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      self.p = p
    end,
    __base = _base_0,
    __name = "JDagger",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  JDagger = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      self.p.speed = self.p.speed + dt
      _class_0.__parent.follow(self, player)
      for i = #bullets, 1, -1 do
        if collision(bullets[i].p, 20, 40, self.p, 64, 64) then
          self.p.lives = self.p.lives - 1
          table.remove(bullets, i)
        end
      end
      return _class_0.__parent.__base.update(self, dt)
    end,
    addMinions = function(self)
      if #enemies < 50 then
        for i = 1, 3 do
          table.insert(enemies, Enemy({
            x = random(self.p.x + (64 * (2)), self.p.x - (2) * 64),
            y = random(self.p.y + (64 * (2)), self.p.y - (2) * 64),
            lives = 2,
            speed = self.p.speed - 20,
            image = love.graphics.newImage("images/Laius servant.png")
          }))
        end
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      love.graphics.setFont(kenPixel)
      return love.graphics.print("Lives: " .. self.p.lives, self.p.x, self.p.y - 30)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      _class_0.__parent.__init(self, p)
      self.p.anim = anim8.newAnimation(self.p.g('1-2', 1, '1-2', 2), 0.1)
      Timer.every(.7, function()
        local angle = math.atan2((player.p.y - self.p.y), (player.p.x - self.p.x))
        local dx, dy = 450 * math.cos(angle), 450 * math.sin(angle)
        return table.insert(brooches, JDagger({
          x = self.p.x,
          y = self.p.y,
          dx = dx,
          dy = dy,
          angle = angle,
          distance = 0
        }))
      end)
      self:addMinions()
      self.handle = Timer.every(5, function()
        self:addMinions()
        self.p.lives = self.p.lives + 1
      end)
    end,
    __base = _base_0,
    __name = "Jocasta",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Jocasta = _class_0
  return _class_0
end
