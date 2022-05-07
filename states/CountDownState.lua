--[[
    Falling from the Sky

    -- CountDownState Class --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    Display countdown starting from 3 on the screen
    so as to a user can prepare the game play.
    And it also may provide buffer time between repetitive game plays.
    Change game state to the PlayState immediately after the countdown is complete.
]]
CountDownState = Class{__includes = BaseState}

local countDownSecond = 0.8

---@diagnostic disable-next-line: missing-parameter
local background = love.graphics.newImage("image/background/main.jpg")

function CountDownState:init()
    self.count = 3
    self.timer = 0
end


function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > countDownSecond then
        self.timer = self.timer % countDownSecond
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change("play")
        end
    end
end


function CountDownState:render()
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(background)
    
    love.graphics.setFont(largeFont)
    love.graphics.printf("Ready", 0, 300, gameWidth, "center")
    love.graphics.setFont(titleFont)
    love.graphics.printf(tostring(self.count), 0, 400, gameWidth, "center")
end