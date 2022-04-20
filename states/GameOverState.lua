--[[
    Falling from the Sky

    -- GameOverState Class --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    Show highest score and player score.
    If the current player score breaks the new record,
    display "New Record !!" message on the screen.
    A user can restart the game by pressing 'enter' or 'return' key.
]]
GameOverState = Class{__includes = BaseState}

local background = love.graphics.newImage("image/background/gameover.jpg")

local title = { text = "Game Over", x=250, y=gameHeight, color = {213, 227, 249} }
local titleTween = Tween.new(3, title, {x=250, y=200})

function GameOverState:init()
    if gHighestScore <= gPlayerScore then
        gHighestScore = gPlayerScore
        if gHighestScore ~= 0 then
            isNewRecord = true
        end
    end

    soundtrackPlay:stop()
    soundtrackGameOver:play()
end


function GameOverState:update(dt)
    titleTween:update(dt)

    if love.keyboard.isDown("return") or love.keyboard.isDown("kpenter") then
        startGame:play()
        soundtrackGameOver:stop()
        -- restart the game
        love.load()
        soundtrackTitle:stop()
        gStateMachine:change("countdown")
    end
end


function GameOverState:render()
    love.graphics.draw(background)
    -- title text animation
    love.graphics.setFont(titleFont)
    love.graphics.setColor(title.color)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press enter to restart", 0, 700, gameWidth, "center")
    love.graphics.printf("Press esc to exit", 0, 750, gameWidth, "center")

    love.graphics.setColor(love.math.colorFromBytes(145, 235, 156))
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Your Score: " .. gPlayerScore, 0, 850, gameWidth, "center")
    love.graphics.setColor(love.math.colorFromBytes(239, 242, 156))
    love.graphics.setFont(largeFont)
    love.graphics.printf("Highest Score: " .. gHighestScore, 0, 900, gameWidth, "center")
    
    if isNewRecord then 
        love.graphics.setColor(love.math.colorFromBytes(213, 170, 237))
        love.graphics.printf("New Record !!", 0, 980, gameWidth, "center")
    end
end