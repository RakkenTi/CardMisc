---
--- Basic Love2D Template
--- By Mark Martinez
---

--// Core
local stack = require('src.core.stack')
local discarder = require('src.core.discarder')

--// Config
local window = require('src.config.window')

function love.load()

    local success = love.window.setMode(window.WIDTH, window.HEIGHT, window.OPTIONS)

    if (not success) then
        love.window.close()
    end

    stack.init()
    discarder.init()
end

--- @param dt number
function love.update(dt)
    stack.update(dt)
    discarder.update(dt)
end

function love.draw()
    discarder.draw()
    stack.draw()
end

function love.quit()
    stack.exit()
    discarder.exit()
end