function love.load()
    Object = require "classic"
    require "player"
    require "stuff"
    require "bigStuff"
    require "seaStuff"
    require "difficulty"

    Player = Player()
    ListOfStuffs = {}
    ListOfBigStuffs = {}
    ListOfSeaStuffs = {}

    -- timer
    TimerNormal = 3
    TimerBig = 7
    TimerSea = 15

    -- score
    PlayerScore = 0

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")

    -- soundtrack - PLAY
    SoundtrackPlay = love.audio.newSource("sound/soundtrack_play.ogg", "stream")
    SoundtrackPlay:setLooping(true)
    SoundtrackPlay:play()
    
    -- https://love2d.org/wiki/Source:setVolume 
    SoundtrackPlay:setVolume(0.5)

    -- sfx
    ScoreSmall = love.audio.newSource("sound/score_normal.wav", "static")
    ScoreBig = love.audio.newSource("sound/score_big.wav", "static")
    ScoreSea = love.audio.newSource("sound/score_sea.wav", "static")
end


function love.update(dt)
    Player:update(dt)

    for i, stuff in ipairs(ListOfStuffs) do
        stuff:update(dt)
        stuff:checkCollision(Player)
        if stuff.dead then
            table.remove(ListOfStuffs, i)
            -- score 30
            PlayerScore = PlayerScore + NormalScore
        end
    end

    for i, bigStuff in ipairs(ListOfBigStuffs) do
        bigStuff:update(dt)
        bigStuff:checkCollision(Player)
        if bigStuff.dead then
            -- score 70
            table.remove(ListOfBigStuffs, i)
            PlayerScore = PlayerScore + BigScore
        end
    end

    for i, seaStuff in ipairs(ListOfSeaStuffs) do
        seaStuff:update(dt)
        seaStuff:checkCollision(Player)
        if seaStuff.dead then
            -- score 70
            table.remove(ListOfSeaStuffs, i)
            PlayerScore = PlayerScore + SeaScore
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
    if TimerNormal <= 0 then
        TimerNormal = math.random(1, 3) * intervalCoef
        table.insert(ListOfStuffs, Stuff())
    end
    TimerNormal = TimerNormal - dt

    if TimerBig <= 0 then
        TimerBig = math.random(10, 15) * intervalCoef
        table.insert(ListOfBigStuffs, BigStuff())
    end
    TimerBig = TimerBig - dt

    if TimerSea <= 0 then
        TimerSea = math.random(15, 25) * intervalCoef
        table.insert(ListOfBigStuffs, SeaStuff())
    end
    TimerSea = TimerSea - dt
end


function love.draw()
    Player:draw()
    
    for i, stuff in ipairs(ListOfStuffs) do
        stuff:draw()
    end

    for i, bigStuff in ipairs(ListOfBigStuffs) do
        bigStuff:draw()
    end

    for i, seaStuff in ipairs(ListOfSeaStuffs) do
        seaStuff:draw()
    end

    love.graphics.print("Score: ".. tostring(PlayerScore), 15, 15)
    love.graphics.print("If player collides with the stuff, reset the score", 490, 15)
end