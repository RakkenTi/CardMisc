---
--- Basic Love2D Template
--- By Mark Martinez
---

local game = require('src.core.game')

function love.load()
    game.init()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end

function love.quit()
    game.exit()
end