function love.load()
    Object = require "classic"
    require "player"
    require "stuff"
    require "bigStuff"

    player = Player()
    listOfStuffs = {}
    listOfBigStuffs = {}

    -- global variable to set time interval
    TimerSmall = 3
    TimerBig = 7

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")

    -- soundtrack - PLAY
    soundtrackPlay = love.audio.newSource("sound/soundtrack_play.ogg", "stream")
    soundtrackPlay:setLooping(true)
    soundtrackPlay:play()
    
    -- https://love2d.org/wiki/Source:setVolume 
    soundtrackPlay:setVolume(0.5)

    -- sfx
    scoreSmall = love.audio.newSource("sound/score_small.wav", "static")
    scoreBig = love.audio.newSource("sound/score_big.wav", "static")
end


function love.update(dt)
    player:update(dt)

    for i, stuff in ipairs(listOfStuffs) do
        stuff:update(dt)
        stuff:checkCollision(player)
        if stuff.dead then
            table.remove(listOfStuffs, i)
        end
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:update(dt)
        bigStuff:checkCollision(player)
        if bigStuff.dead then
            table.remove(listOfBigStuffs, i)
        end
    end

    -- set timer for time interval event
    if TimerSmall <= 0 then
        TimerSmall = math.random(2, 4)
        table.insert(listOfStuffs, Stuff())
    end
    TimerSmall = TimerSmall - dt

    if TimerBig <= 0 then
        TimerBig = math.random(5, 10)
        table.insert(listOfBigStuffs, BigStuff())
    end
    TimerBig = TimerBig - dt
end


function love.draw()
    player:draw()
    
    for i, stuff in ipairs(listOfStuffs) do
        stuff:draw()
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:draw()
    end

    love.graphics.print("If player collides with the stuff, restart the game", 470, 15)
end