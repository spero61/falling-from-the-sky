-- displaying hige score, shown on game over
GameOverState = Class{__includes = BaseState}

local background = love.graphics.newImage("image/background/gameover.jpg")

local tween = require "tween"
local title = { text = "Game Over", x=250, y=gameHeight, color = {213, 227, 249} }
local titleTween = tween.new(3, title, {x=250, y=200})

function GameOverState:init()
    if gHighestScore <= gPlayerScore then
        gHighestScore = gPlayerScore
        if gHighestScore ~= 0 then
            isNewRecord = true
        end
    end

    soundtrackPlay:stop()
    soundtrackGameOver:play()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(102, 103, 171)) -- Very Peri
end

function GameOverState:update(dt)
    titleTween:update(dt)

    if love.keyboard.isDown("return") or love.keyboard.isDown("kpenter") then
        startGame:play()
        -- restart the game
        love.load()
        gStateMachine:change("play")
    end
end

function GameOverState:render()
    love.graphics.draw(background)
    -- title text animation
    love.graphics.setFont(titleFont)
    love.graphics.setColor(title.color)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press enter to restart", 0, 750, gameWidth, "center")
    love.graphics.printf("Press esc to exit", 0, 800, gameWidth, "center")

    love.graphics.setFont(largeFont)
    love.graphics.setColor(love.math.colorFromBytes(239, 242, 156))
    love.graphics.printf("Highest Score: " .. gHighestScore, 0, 900, gameWidth, "center")
    
    if isNewRecord then 
        love.graphics.setColor(love.math.colorFromBytes(213, 170, 237))
        love.graphics.printf("New Record !!", 0, 980, gameWidth, "center")
    end
end