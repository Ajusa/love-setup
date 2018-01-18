do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      self.oedipus:draw()
      return self.man:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Cross Roads.lua", {
        "bump"
      })
      isDialogue = true
      self.music = "sound/crossroads.mp3"
      _class_0.__parent.__init(self)
      player.p.x, player.p.y, player.p.lives, player.p.anim = 42 * 64, 46 * 64, 5, anim8.newAnimation(player.p.g('1-2', 1, '1-2', 2), 0.1)
      self.oedipus = Entity({
        x = 37 * 64,
        y = 48 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Blind Oedipus.png")
      })
      self.man = Entity({
        x = 54 * 64,
        y = 47 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Young Man.png")
      })
      return player:speak("Amir", {
        "Who are you, blind traveller?"
      }, function()
        return self.oedipus:moveTo(tile(38, 49), function()
          return self.oedipus:moveTo(tile(36, 45), function()
            return self.oedipus:speak("Oedipus", {
              "I am Oedipus. -- I was a mighty king. Now I am a lost soul."
            }, function()
              self.man:moveTo(tile(45, 47))
              return self.man:speak("Young Man", {
                "Hey guys? What are all of you doing out here?"
              }, function()
                return self.oedipus:speak("Oedipus", {
                  "Do any of you know stories?",
                  "When you have been in the wilderness for so long, you start to long for something exciting"
                }, function()
                  return player:speak("Amir", {
                    "Luckily for you, I am a prime storyteller. Let me tell you about my past..."
                  }, function()
                    STATE = DarkRoom()
                  end)
                end)
              end)
            end)
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "CrossRoads",
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
  CrossRoads = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      self.oedipus:draw()
      return self.amir:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Cross Roads.lua", {
        "bump"
      })
      isDialogue = true
      self.music = "sound/crossroads.mp3"
      _class_0.__parent.__init(self)
      player.p.x, player.p.y, player.p.lives, player.p.image, player.p.anim = 45 * 64, 47 * 64, 5, love.graphics.newImage("images/Young Man.png"), anim8.newAnimation(player.p.g('1-2', 1, '1-2', 2), 0.1)
      self.oedipus = Entity({
        x = 40 * 64,
        y = 45 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Blind Oedipus.png")
      })
      self.amir = Entity({
        x = 42 * 64,
        y = 46 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Amir.png")
      })
      return player:speak("Young Man", {
        "Wow, you've gone through a lot."
      }, function()
        return self.oedipus:speak("Oedipus", {
          "I too never had a mother's love."
        }, function()
          return self.amir:speak("Young Man", {
            "You guys are regretting that? Now let me tell you what my mother did..."
          }, function()
            isDialogue = false
            STATE = America()
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "CrossRoads2",
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
  CrossRoads2 = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      return player:update(dt)
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      self.man:draw()
      return self.amir:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/Cross Roads.lua", {
        "bump"
      })
      isDialogue = true
      self.music = "sound/crossroads.mp3"
      _class_0.__parent.__init(self)
      player.p.x, player.p.y, player.p.lives, player.p.image = 40 * 64, 46 * 64, 5, love.graphics.newImage("images/Blind Oedipus.png")
      player.p.g = anim8.newGrid(16, 16, player.p.image:getWidth(), player.p.image:getHeight())
      player.p.anim = anim8.newAnimation(player.p.g(1, 1), 0.1)
      self.man = Entity({
        x = 45 * 64,
        y = 47 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Young Man.png")
      })
      self.amir = Entity({
        x = 42 * 64,
        y = 46 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Amir.png")
      })
      return player:speak("Oedipus", {
        "Child, you killed your own mother?"
      }, function()
        return self.amir:speak("Amir", {
          "That is pretty dark."
        }, function()
          return self.man:speak("Young Man", {
            "Hey, she killed my brother when she bought him at an orphanage."
          }, function()
            return player:speak("Oedipus", {
              "I actually had a good reason for killing my mother. Well, she was also my wife.",
              "It all started with me killing my father many years ago..."
            }, function()
              return self.amir:speak("Amir", {
                "..."
              }, function()
                return self.man:speak("Young Man", {
                  "..."
                }, function()
                  STATE = CrossRoadsFight()
                end)
              end)
            end)
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "CrossRoads3",
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
  CrossRoads3 = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      _class_0.__parent.follow(self, player, self.direction)
      for i = #bullets, 1, -1 do
        if collision(bullets[i].p, 20, 40, self.p, 64, 64) then
          self.p.lives = self.p.lives - 1
          table.remove(bullets, i)
        end
      end
      if #enemies < 3 then
        for i = 1, 10 do
          local enem = Enemy({
            x = random(64 * (25), (55) * 64),
            y = random(64 * (30), (60) * 64),
            lives = 3,
            speed = 120,
            image = love.graphics.newImage("images/Knuckles.png")
          })
          enem.p.anim = anim8.newAnimation(enem.p.g(1, 1, 1, 2), 0.2)
          table.insert(enemies, enem)
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
      self.direction = 1
      Timer.every(10.01, function()
        self.p.speed = 300
      end)
      return Timer.every(5, function()
        self.p.speed = 100
        self.p.lives = self.p.lives + 2
      end)
    end,
    __base = _base_0,
    __name = "BossLaius",
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
  BossLaius = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    death = function(self)
      score = score - 10
      isDialogue = true
      Timer.clear()
      enemies = { }
      player.p.lives = 5
      return laius:speak("Laius", {
        "Fool! No man is a match for the King of Thebes!"
      }, function()
        return laius:speak("Game", {
          "Your score is now " .. score .. ". Click to redo the fight!"
        }, function()
          STATE = CrossRoadsFight()
        end)
      end)
    end,
    update = function(self, dt)
      player:update(dt)
      laius:update(dt)
      if collision(laius.p, 64, 64, player.p, 64, 64) and not recentScramble then
        self.recentScramble = true
        laius.direction = -1
        Timer.after(3, function()
          self.recentScramble = false
          laius.direction = 1
        end)
        player:scramble(5)
      end
      if laius.p.lives < 1 then
        isDialogue = true
        laius:speak("Laius", {
          "Argh... may the gods curse you!"
        }, function()
          enemies = { }
          self.died = true
          self.cutScene:play()
          Timer.clear()
          player.order = clone(player.base)
          self.i = 0
        end)
      end
      if #enemies > 0 then
        for i = #enemies, 1, -1 do
          enemies[i]:update(dt, i)
        end
      end
    end,
    draw = function(self)
      if self.died then
        local cX, cY = camera:worldCoords(love.graphics.getWidth() / 2, 0)
        love.graphics.draw(self.cutScene, cX, cY, 0, love.graphics.getHeight() / self.cutScene:getHeight(), love.graphics.getHeight() / self.cutScene:getHeight(), self.cutScene:getWidth() / 2)
        if not self.cutScene:isPlaying() then
          if self.i == 1 then
            STATE = Thebes()
          end
          self.i = self.i + 1
          self.cutScene = self.cutScene2
          return self.cutScene:play()
        end
      else
        _class_0.__parent.__base.draw(self)
        for i, v in ipairs(enemies) do
          v:draw()
        end
        return laius:draw()
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      isDialogue = true
      world = bump.newWorld()
      map = sti("data/Cross Roads.lua", {
        "bump"
      })
      self.recentScramble = false
      self.died = false
      self.cutScene = love.graphics.newVideo("cutscenes/Oedipus-Sphinx.ogv")
      self.cutScene2 = love.graphics.newVideo("cutscenes/Crowning.ogv")
      player.p.x, player.p.y, player.p.lives, player.p.image = 56 * 64, 49 * 64, 5, love.graphics.newImage("images/Oedipus.png")
      player.p.g = anim8.newGrid(16, 16, player.p.image:getWidth(), player.p.image:getHeight())
      player.p.anim = anim8.newAnimation(player.p.g('1-3', 1, '1-3', 2, '1-2', 2), 0.1)
      player:scramble(.01)
      self.music = "sound/laius.mp3"
      _class_0.__parent.__init(self)
      laius = Entity({
        x = 36 * 64,
        y = 52 * 64,
        dx = 0,
        dy = 0,
        w = 64,
        h = 64,
        speed = 100,
        image = love.graphics.newImage("images/Laius.png"),
        lives = 30
      })
      return player:moveTo(tile(39, 50), function()
        return player:speak("Oedipus", {
          "Get out of the way, old man."
        }, function()
          return laius:speak("Laius", {
            "Do you have any idea who you are talking to, boy?"
          }, function()
            return player:speak("Oedipus", {
              "If you don't get out of the way, I will remove you forcibly."
            }, function()
              return laius:speak("Laius", {
                "You can try. Guards, take him!"
              }, function()
                isDialogue = false
                laius = BossLaius(laius.p)
              end)
            end)
          end)
        end)
      end)
    end,
    __base = _base_0,
    __name = "CrossRoadsFight",
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
  CrossRoadsFight = _class_0
  return _class_0
end
