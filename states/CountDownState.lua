-- displaying counting down numbers before start playing the game
CountDownState = Class{__includes = BaseState}

local countDownSecond = 0.8

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