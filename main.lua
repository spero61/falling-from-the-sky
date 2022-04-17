local push = require "push"
local background = love.graphics.newImage("image/background/main.jpg")

function love.load()
    Object = require "classic"
    require "player"
    require "stuff"
    require "bigStuff"
    require "seaStuff"
    require "diagonalStuff"
    require "difficulty"
    
    Player = Player()
    ListOfStuffs = {}
    ListOfOtherStuffs = {}
    ListOfBigStuffs = {}
    ListOfSeaStuffs = {}
    ListOfDiagonalStuffs = {}
    
    -- score
    PlayerScore = 0
    
    love.window.setTitle("Falling from the sky")
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(GameWidth, GameHeight, 1920, 1080, {
        vsync = true,
        fullscreen = false,
        resizable = false,
    })
    -- love.window.setMode(GameWidth, GameHeight, {resizable=false, vsync=true})

    -- soundtrack - PLAY
    SoundtrackPlay = love.audio.newSource("sound/soundtrackPlay.ogg", "stream")
    SoundtrackPlay:setLooping(true)
    SoundtrackPlay:play()
    
    -- https://love2d.org/wiki/Source:setVolume 
    SoundtrackPlay:setVolume(0.5)

    -- sfx
    ScoreSmall = love.audio.newSource("sound/scoreNormal.wav", "static")
    ScoreBig = love.audio.newSource("sound/scoreBig.wav", "static")
    ScoreSea = love.audio.newSource("sound/scoreSea.wav", "static")
    ScoreDiagonal = love.audio.newSource("sound/scoreDiagonal.wav", "static")
end


function love.update(dt)
    Player:update(dt)

    for i, stuff in ipairs(ListOfStuffs) do
        stuff:update(dt)
        stuff:checkCollision(Player)
        if stuff.dead then
            table.remove(ListOfStuffs, i)
            PlayerScore = PlayerScore + NormalScore
        end
    end

    for i, stuff in ipairs(ListOfOtherStuffs) do
        stuff:update(dt)
        stuff:checkCollision(Player)
        if stuff.dead then
            table.remove(ListOfOtherStuffs, i)
            PlayerScore = PlayerScore + NormalScore
        end
    end

    for i, bigStuff in ipairs(ListOfBigStuffs) do
        bigStuff:update(dt)
        bigStuff:checkCollision(Player)
        if bigStuff.dead then
            table.remove(ListOfBigStuffs, i)
            PlayerScore = PlayerScore + BigScore
        end
    end

    for i, seaStuff in ipairs(ListOfSeaStuffs) do
        seaStuff:update(dt)
        seaStuff:checkCollision(Player)
        if seaStuff.dead then
            table.remove(ListOfSeaStuffs, i)
            PlayerScore = PlayerScore + SeaScore
        end
    end

    for i, diagonalStuff in ipairs(ListOfDiagonalStuffs) do
        diagonalStuff:update(dt)
        diagonalStuff:checkCollision(Player)
        if diagonalStuff.dead then
            table.remove(ListOfDiagonalStuffs, i)
            PlayerScore = PlayerScore + DiagonalScore
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
        TimerNormal = math.random(NormalIntervalMin, NormalIntervalMax) * intervalCoef
        table.insert(ListOfStuffs, Stuff())
    end
    TimerNormal = TimerNormal - dt

    if TimerNormalOther <= 0 then
        TimerNormalOther = math.random(NormalOtherIntervalMin, NormalOtherIntervalMax) * intervalCoef
        table.insert(ListOfOtherStuffs, Stuff())
    end
    TimerNormalOther = TimerNormalOther - dt

    if TimerBig <= 0 then
        TimerBig = math.random(BigIntervalMin, BigIntervalMax) * intervalCoef
        table.insert(ListOfBigStuffs, BigStuff())
    end
    TimerBig = TimerBig - dt

    if TimerSea <= 0 then
        TimerSea = math.random(SeaIntervalMin, SeaIntervalMax) * intervalCoef
        table.insert(ListOfBigStuffs, SeaStuff())
    end
    TimerSea = TimerSea - dt

    if TimerDiagonal <= 0 then
        TimerDiagonal = math.random(DiagonalIntervalMin, DiagonalIntervalMax) * intervalCoef
        table.insert(ListOfDiagonalStuffs, DiagonalStuff(Player.x, Player.width))
    end
    TimerDiagonal = TimerDiagonal - dt
end


function love.draw()
    push:start()
    love.graphics.draw(background)
    Player:draw()
    
    for i, stuff in ipairs(ListOfStuffs) do
        stuff:draw()
    end

    for i, otherStuff in ipairs(ListOfOtherStuffs) do
        otherStuff:draw()
    end

    for i, bigStuff in ipairs(ListOfBigStuffs) do
        bigStuff:draw()
    end

    for i, seaStuff in ipairs(ListOfSeaStuffs) do
        seaStuff:draw()
    end

    for i, diagonalStuff in ipairs(ListOfDiagonalStuffs) do
        diagonalStuff:draw()
    end

    love.graphics.print("Score: ".. tostring(PlayerScore), 15, 15)
    love.graphics.print("If player collides with the stuff, reset the score", GameWidth - 300, 15)
    love.graphics.print("Press 'f' to toggle full screen mode", GameWidth - 228, 35)
    push:finish()
end


function love.keypressed(key)
    -- terminate the game
    if key == "escape" then
        love.event.quit()
    elseif key == "f" then
        push:switchFullscreen()
    end
end