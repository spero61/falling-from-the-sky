function love.load()
    Object = require "classic"
    require "player"
    require "stuff"
    require "bigStuff"
    require "difficulty"

    player = Player()
    listOfStuffs = {}
    listOfBigStuffs = {}

    -- timer
    TimerSmall = 3
    TimerBig = 7

    -- score
    PlayerScore = 0

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
            -- score 30
            PlayerScore = PlayerScore + NormalScore
        end
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:update(dt)
        bigStuff:checkCollision(player)
        if bigStuff.dead then
            -- score 70
            table.remove(listOfBigStuffs, i)
            PlayerScore = PlayerScore + BigScore
        end
    end

    -- the smaller coefficient the shorter interval between stuffs
    local intervalCoef = 1
    if PlayerScore > LevelOne then
        intervalCoef = 0.8
    elseif PlayerScore > LevelTwo then
        intervalCoef = 0.6
    elseif PlayerScore > LevelThree then
        intervalCoef = 0.4
    elseif PlayerScore > LevelFour then
        intervalCoef = 0.3
    elseif PlayerScore > LevelFive then
        intervalCoef = 0.2
    elseif PlayerScore > LevelSix then
        intervalCoef = 0.15
    elseif PlayerScore > LevelSeven then
        intervalCoef = 0.1
    end

    -- set timer for time interval event
    if TimerSmall <= 0 then
        TimerSmall = math.random(1, 3) * intervalCoef
        table.insert(listOfStuffs, Stuff())
    end
    TimerSmall = TimerSmall - dt

    if TimerBig <= 0 then
        TimerBig = math.random(10, 15) * intervalCoef
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

    love.graphics.print("Score: ".. tostring(PlayerScore), 15, 15)
    love.graphics.print("If player collides with the stuff, restart the game", 490, 15)
end