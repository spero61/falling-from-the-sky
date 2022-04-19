-- starting screen of the game, shown on startup
TitleScreenState = Class{__includes = BaseState}

local tween = require "tween"
local title = { text = "Falling from the Sky", x=90, y=10, color = {213, 227, 249} }
local titleTween = tween.new(1.2, title, {x=90, y=90})

local isPressed = false
local startTimer = 1
local background = love.graphics.newImage("image/background/main.jpg")

function TitleScreenState:init()
end

function TitleScreenState:update(dt)
    titleTween:update(dt)

    -- return: includes enter key
    -- kpenter: the numpad enter key
    if love.keyboard.isDown("return") or love.keyboard.isDown("kpenter") then
        isPressed = true
        StartGame:play()
    end

    if isPressed then
        startTimer = startTimer - dt
    end
    if startTimer < 0 then
        gStateMachine:change("play")
    end
end

function TitleScreenState:render()
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(background)
    
    -- title text animation
    love.graphics.setFont(TitleFont)
    love.graphics.setColor(title.color)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(MediumFont)
    love.graphics.printf("Press f key to toggle full screen mode", 0, 800, gameWidth, "center")
    love.graphics.setFont(LargeFont)
    love.graphics.printf("Press Enter", 0, 900, gameWidth, "center")

end