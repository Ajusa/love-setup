assert(love.filesystem.load("lib/lib.lua"))()
require("scenes/kabul")
require("scenes/kitefight")
require("scenes/crossroads")
require("scenes/babascene")
require("scenes/america")
sinceFire = 0
score = 0
enemies = { }
isDialogue = false
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(dagger, self.p.x, self.p.y, self.p.angle)
    end,
    update = function(self, dt, i)
      self.p.distance = self.p.distance + (((self.p.dx ^ 2) + (self.p.dy ^ 2)) ^ (1 / 2) * dt)
      if self.p.distance > 500 then
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
    __init = function(self, p)
      self.p = p
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
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return love.graphics.draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
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
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      return self.p.anim:draw(self.p.image, self.p.x, self.p.y, 0, 4, 4)
    end,
    update = function(self, dt)
      self.p.anim:update(dt)
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
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, p)
      self.p = p
      self.p.g = anim8.newGrid(16, 16, self.p.image:getWidth(), self.p.image:getHeight())
      self.p.anim = anim8.newAnimation(self.p.g('1-2', 1, '1-2', 2), 0.1)
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
love.load = function()
  player = Player({
    x = 43 * 64,
    y = 6 * 64,
    w = 64,
    h = 64,
    speed = 200,
    lives = 5,
    image = love.graphics.newImage("images/Amir.png")
  })
  camera = Camera(player.p.x, player.p.y)
  bullets = { }
  dagger = love.graphics.newImage("images/dagger.png")
  cameraX, cameraY = camera:cameraCoords(player.p.x, player.p.y)
  STATE = KiteFight()
end
love.update = function(dt)
  Moan.update(dt)
  Timer.update(dt)
  if not isDialogue then
    STATE:update(dt)
  end
  if player.p.lives > 0 then
    map:update(dt)
    sinceFire = sinceFire + dt
    for i = #bullets, 1, -1 do
      bullets[i]:update(dt, i)
    end
  else
    STATE:death()
  end
  return camera:lockPosition(player.p.x, player.p.y)
end
love.draw = function()
  camera:attach()
  STATE:draw()
  camera:detach()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.setFont(kenPixel)
  love.graphics.print("Lives: " .. player.p.lives, 12, 12)
  love.graphics.print("Score: " .. score, 130, 12)
  return Moan.draw()
end
love.mousepressed = function(x, y, button)
  if button == 1 and sinceFire > .3 and not isDialogue then
    sinceFire = 0
    local startX, startY = player.p.x + 32, player.p.y + 32
    local mouseX, mouseY = camera:worldCoords(x, y)
    local angle = math.atan2((mouseY - startY), (mouseX - startX))
    local dx, dy = 350 * math.cos(angle), 350 * math.sin(angle)
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
love.keyreleased = function(key)
  return Moan.keyreleased(key)
end
