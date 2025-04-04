---
--- Basic Love2D Template
--- By Mark Martinez
---

local game = require('src.core.game')
local vector2d = require("src.shared.utils.vector2d")

function love.load()
    game.init()
end

function love.update(dt)
    print(vector2d.new(1, 5))
    game.update(dt)
end

function love.draw()
    game.draw()
end

function love.quit()
    game.exit()
end