do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      if collision(player.p, 64, 64, tile(9, 23), 64, 128) then
        isDialogue = true
        return self.barker:speak("Mrs. Barker", {
          "Are you sure you want to do this dear?",
          "I understand what happened now, so I don't blame you for wanting to, but this decision is permanent.",
          "Yes? Good luck then,"
        }, function()
          return player:moveTo(tile(9, 24), function()
            STATE = AmericaFight()
          end)
        end)
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return self.barker:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/castle.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 9 * 64, 6 * 64, 5
      _class_0.__parent.__init(self)
      self.barker = Entity({
        x = 8 * 64,
        y = 23 * 64,
        w = 64,
        h = 64,
        speed = 200,
        image = love.graphics.newImage("images/Mrs. Barker.png")
      })
    end,
    __base = _base_0,
    __name = "America",
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
  America = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    talk = function(self)
      return Mommy:speak("Mommy", {
        "Oh hi there Young Man...",
        "Why are you still here?",
        "You're here to kill me? For what, hurting that useless bumble?",
        "Fine, who's going notice another dead child? Go Daddy, kill him to prove your masculinity."
      }, function()
        isDialogue = false
        mommy = BossMommy(self.p)
      end)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      _class_0.__parent.__init(self, p)
      self.p.g = anim8.newGrid(32, 32, self.p.image:getWidth(), self.p.image:getHeight())
      self.p.anim = anim8.newAnimation(self.p.g(1, 1), 0.1)
    end,
    __base = _base_0,
    __name = "Mommy",
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
  Mommy = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      _class_0.__parent.__base.update(self, dt)
      _class_0.__parent.follow(self, player)
      for i = #bullets, 1, -1 do
        if collision(bullets[i].p, 20, 40, self.p, 128, 128) then
          self.p.lives = self.p.lives - 1
          table.remove(bullets, i)
        end
      end
    end,
    addMinions = function(self)
      if #enemies < 100 then
        for i = 1, 10 do
          table.insert(enemies, Enemy({
            x = random(64 * (2), (32) * 64),
            y = random(64 * (2), (map.height - 2) * 64),
            lives = 2,
            speed = 70,
            image = love.graphics.newImage("images/Daddy.png")
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
      self.p.image = love.graphics.newImage("images/Mommy Mad.png")
      self.p.g = anim8.newGrid(32, 32, self.p.image:getWidth(), self.p.image:getHeight())
      self.p.anim = anim8.newAnimation(self.p.g('1-2', 1, '1-2', 2), 0.1)
      self:addMinions()
      self.handle = Timer.every(10, function()
        return self:addMinions()
      end)
    end,
    __base = _base_0,
    __name = "BossMommy",
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
  BossMommy = _class_0
end
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    death = function(self)
      score = score - 10
      isDialogue = true
      Timer.cancel(mommy.handle)
      enemies = { }
      player.p.lives = 5
      return Mommy:speak("Mommy", {
        "You see! Another bumble falls. Aren't we such good parents, Daddy?"
      }, function()
        return Mommy:speak("Game", {
          "Your score is now " .. score .. ". Click to redo the fight!"
        }, function()
          STATE = AmericaFight()
        end)
      end)
    end,
    update = function(self, dt)
      player:update(dt)
      mommy:update(dt)
      if collision(mommy.p, 64, 64, player.p, 64, 64) then
        self:death()
      end
      if mommy.p.lives < 1 then
        isDialogue = true
        Mommy:speak("Mommy", {
          "Argh... you done killed me."
        }, function()
          enemies = { }
          Timer.cancel(mommy.handle)
          STATE = CrossRoads3()
        end)
      end
      if #enemies > 0 then
        for i = #enemies, 1, -1 do
          enemies[i]:update(dt, i)
        end
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      for i, v in ipairs(enemies) do
        v:draw()
      end
      return mommy:draw()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      world = bump.newWorld()
      map = sti("data/testmap.lua", {
        "bump"
      })
      player.p.x, player.p.y, player.p.lives = 38 * 64, 13 * 64, 5
      _class_0.__parent.__init(self)
      mommy = Mommy({
        x = 41 * 64,
        y = 13 * 64,
        dx = 0,
        dy = 0,
        speed = 100,
        lives = 30,
        image = love.graphics.newImage("images/Mommy.png")
      })
      return mommy:talk()
    end,
    __base = _base_0,
    __name = "AmericaFight",
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
  AmericaFight = _class_0
  return _class_0
end
