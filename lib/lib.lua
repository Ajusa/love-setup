sti = require("lib/sti")
Camera = require("lib/camera")
bump = require('lib/bump')
love.graphics.setFont(love.graphics.newFont("lib/kenpixel.ttf", 16))
love.graphics.setDefaultFilter("nearest")
local random
random = function(l, h)
  return love.math.random(l, h)
end