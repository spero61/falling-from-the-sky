-- starting screen of the game, shown on startup
TitleScreenState = Class{__includes = BaseState}

local title = { text = "Falling from the Sky", x=90, y=10, color = {213, 227, 249} }
local titleTween = Tween.new(1.2, title, {x=90, y=90})

local isPressed = false
local startTimer = 1
local background = love.graphics.newImage("image/background/main.jpg")

function TitleScreenState:init()
    soundtrackTitle:play()
end

function TitleScreenState:update(dt)
    titleTween:update(dt)

    -- return: includes enter key
    -- kpenter: the numpad enter key
    if love.keyboard.isDown("return") or love.keyboard.isDown("kpenter") then
        isPressed = true
        soundtrackTitle:stop()
        startGame:play()
    end

    if isPressed then
        startTimer = startTimer - dt
    end
    if startTimer < 0 then
        gStateMachine:change("countdown")
    end
end

function TitleScreenState:render()
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.draw(background)
    
    -- title text animation
    love.graphics.setFont(titleFont)
    love.graphics.setColor(title.color)
    love.graphics.print(title.text, title.x, title.y)

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press f key to toggle full screen mode", 0, 800, gameWidth, "center")
    love.graphics.setFont(largeFont)
    love.graphics.printf("Press Enter", 0, 900, gameWidth, "center")

end