---
--- Basic Love2D Template
--- By Mark Martinez
---

local game = require('src.core.stack')
local window = require('src.config.window')

function love.load()

    local success = love.window.setMode(window.WIDTH, window.HEIGHT, window.OPTIONS)

    if (not success) then
        love.window.close()
    end

    game.init()
end

--- @param dt number
function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
    love.graphics.setColor(255,255,255)
end

function love.quit()
    game.exit()
end