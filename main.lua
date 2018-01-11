assert(love.filesystem.load("lib/lib.lua"))()
local sinceFire = 0
local score = 0
local enemies = { }
local Dagger
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(dagger, self.p.x, self.p.y, self.p.angle)
    end,
    update = function(self, dt, i)
      self.p.distance = self.p.distance + (((self.p.dx ^ 2) + (self.p.dy ^ 2)) ^ (1 / 2) * dt)
      if self.p.distance > 400 then
        do
          table.remove(bullets, i)
        end
      end
      return _class_0.__parent.__base.update(self, dt)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Dagger",
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
  Dagger = _class_0
end
local Enemy
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(enemy, self.p.x, self.p.y, 0, 4, 4)
    end,
    update = function(self, dt, i)
      self.p.speed = self.p.speed + dt
      _class_0.__parent.follow(self, player)
      _class_0.__parent.__base.update(self, dt)
      self.p.x, self.p.y = world:move(self, self.p.x, self.p.y, walls)
      for i = #bullets, 1, -1 do
        if collision(bullets[i].p, 20, 40, self.p, 64, 64) then
          self.p.lives = self.p.lives - 1
          score = score + 1
          table.remove(bullets, i)
        end
      end
      if self.p.lives < 1 then
        do
          world:remove(self)
          score = score + 5
          return table.remove(enemies, i)
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      self.p = p
      return world:add(self, self.p.x + 8, self.p.y + 8, 48, 48)
    end,
    __base = _base_0,
    __name = "Enemy",
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
  Enemy = _class_0
end
local Macduff
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      self.p.speed = self.p.speed + dt
      _class_0.__parent.follow(self, player)
      _class_0.__parent.__base.update(self, dt)
      if fullCollision(self.p.x, self.p.y, 64, 64, player.p.x, player.p.y, 64, 64) then
        player.p.lives = 0
      end
    end,
    draw = function(self)
      return love.graphics.draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Macduff",
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
  Macduff = _class_0
end
local Player
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
    end,
    update = function(self, dt)
      if not self.p.disabled then
        if love.keyboard.isDown("a") then
          self.p.x, self.p.y = world:move(self, self.p.x - self.p.speed * dt, self.p.y, walls)
        end
        if love.keyboard.isDown("d") then
          self.p.x, self.p.y = world:move(self, self.p.x + self.p.speed * dt, self.p.y, walls)
        end
        if love.keyboard.isDown("w") then
          self.p.x, self.p.y = world:move(self, self.p.x, self.p.y - self.p.speed * dt, walls)
        end
        if love.keyboard.isDown("s") then
          self.p.x, self.p.y = world:move(self, self.p.x, self.p.y + self.p.speed * dt, walls)
        end
        for i = #enemies, 1, -1 do
          if fullCollision(enemies[i].p.x + 8, enemies[i].p.y + 8, 48, 48, self.p.x, self.p.y, 64, 64) then
            self.p.lives = self.p.lives - 1
            table.remove(enemies, i)
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Player",
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
  Player = _class_0
end
local BaseState
do
  local _class_0
  local _base_0 = {
    draw = function(self)
      map:draw()
      for i, v in ipairs(bullets) do
        v:draw()
      end
      return player:draw()
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      map:bump_init(world)
      return world:add(player, player.p.x + 8, player.p.y + 8, 48, 48)
    end,
    __base = _base_0,
    __name = "BaseState"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  BaseState = _class_0
end
local MainGame
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      if score > 100 then
        macduff:update(dt)
      end
      for i = #enemies, 1, -1 do
        enemies[i]:update(dt, i)
      end
      player:update(dt)
      if love.keyboard.isDown("return") then
        STATE = MainGame()
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      for i, v in ipairs(enemies) do
        v:draw()
      end
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
      player.p.x, player.p.y, player.p.lives, score = 43 * 64, 4 * 64, 5, 0
      _class_0.__parent.__init(self)
      do
        local _accum_0 = { }
        local _len_0 = 1
        for i = 1, 40 do
          _accum_0[_len_0] = Enemy({
            x = random(64 * (2), (32) * 64),
            y = random(64 * (2), (map.height - 2) * 64),
            lives = 5,
            isEnemy = true,
            speed = 30
          })
          _len_0 = _len_0 + 1
        end
        enemies = _accum_0
      end
      macduff = Macduff({
        x = 128,
        y = 20 * 64,
        speed = 90,
        image = love.graphics.newImage("images/macduff.png")
      })
    end,
    __base = _base_0,
    __name = "MainGame",
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
  MainGame = _class_0
end
local BeforeFight
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      if fullCollision(player.p.x, player.p.y, 64, 64, 9 * 64, 24 * 64, 128, 64) then
        STATE = MainGame()
      end
      return player:update(dt)
    end,
    draw = function(self, dt)
      _class_0.__parent.__base.draw(self)
      return love.graphics.draw(self.messenger, 10 * 64, 5 * 64, 0, 4, 4)
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
      player.p.x, player.p.y = (10) * 64, (3) * 64
      _class_0.__parent.__init(self)
      local line = love.audio.newSource("sound/beforegame.ogg")
      line:play()
      self.messenger = love.graphics.newImage("images/messenger.png")
      player.p.disabled = true
      return Timer.after(2, function()
        player.p.disabled = false
      end)
    end,
    __base = _base_0,
    __name = "BeforeFight",
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
  BeforeFight = _class_0
end
local Castle
do
  local _class_0
  local _parent_0 = BaseState
  local _base_0 = {
    update = function(self, dt)
      player:update(dt)
      for i, v in ipairs(bullets) do
        if fullCollision(v.p.x, v.p.y, 20, 40, 10 * 64, 3 * 64, 64, 64) then
          if love.window.showMessageBox("Narrator", "Macbeth becomes king, and soon Malcolm is leading an army against him.") then
            STATE = BeforeFight()
          end
          self.duncan = love.graphics.newImage("images/duncandead.png")
        end
      end
    end,
    draw = function(self)
      _class_0.__parent.__base.draw(self)
      return love.graphics.draw(self.duncan, 10 * 64, 3 * 64, 0, 4, 4)
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
      player.p.x, player.p.y = (17) * 64, (15) * 64
      self.duncan = love.graphics.newImage("images/duncan.png")
      self.temp = false
      self.time = 0
      return _class_0.__parent.__init(self)
    end,
    __base = _base_0,
    __name = "Castle",
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
  Castle = _class_0
end
love.load = function()
  player = Player({
    x = 43 * 64,
    y = 6 * 64,
    w = 64,
    h = 64,
    speed = 400,
    lives = 5,
    image = love.graphics.newImage("images/player.png")
  })
  STATE = Castle()
  camera = Camera(player.p.x, player.p.y)
  bullets = { }
  dagger = love.graphics.newImage("images/dagger.png")
  enemy = love.graphics.newImage("images/enemy.png")
end
love.update = function(dt)
  Timer.update(dt)
  STATE:update(dt)
  if player.p.lives > 0 then
    map:update(dt)
    sinceFire = sinceFire + dt
    for i = #bullets, 1, -1 do
      bullets[i]:update(dt, i)
    end
    return camera:lockPosition(player.p.x, player.p.y)
  end
end
love.draw = function()
  if player.p.lives > 0 then
    camera:attach()
    STATE:draw()
    if score > 110 then
      macduff:draw()
    end
    camera:detach()
    love.graphics.setColor(255, 0, 0, score)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(255, 255, 255, 255)
    return love.graphics.print("Lives: " .. player.p.lives, 12, 12)
  else
    love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 30))
    love.graphics.print("GAME OVER MACBETH!", love.graphics.getWidth() / 4, love.graphics.getHeight() / 2)
    love.graphics.print("Score: " .. score, love.graphics.getWidth() / 4, love.graphics.getHeight() / 1.5)
    return love.graphics.print("Hit enter to play again ", love.graphics.getWidth() / 4, love.graphics.getHeight() / 1.2)
  end
end
love.mousepressed = function(x, y, button)
  if button == 1 and sinceFire > .3 and not player.p.disabled then
    sinceFire = 0
    local startX, startY = player.p.x + 32, player.p.y + 32
    local mouseX, mouseY = camera:worldCoords(x, y)
    local angle = math.atan2((mouseY - startY), (mouseX - startX))
    local dx, dy = 250 * math.cos(angle), 250 * math.sin(angle)
    return table.insert(bullets, Dagger({
      x = startX,
      y = startY,
      dx = dx,
      dy = dy,
      angle = angle,
      distance = 0
    }))
  end
end
