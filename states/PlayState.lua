--[[
    Falling from the Sky

    -- PlayState Class --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    Responsible for the game's main logic. A user can control player character.
    'a' or 'left' key to move left and 'd' or 'right' key to move right.
    when a 'stuff' falls beyond the bottom of the window, a user earns
    score with respect to its type of stuff.
    When a 'stuff' collides with the player character, it transits to GameOverState.
]]
PlayState = Class{__includes = BaseState}

---@diagnostic disable-next-line: missing-parameter
local background = love.graphics.newImage("image/background/main.jpg")
local intervalCoef = 1

function PlayState:init()
    soundtrackPlay:play()

    player = Player()

    listOfStuffs = {}
    listOfOtherStuffs = {}
    listOfBigStuffs = {}
    listOfSeaStuffs = {}
    listOfDiagonalStuffs = {}

    -- reset timers
    TimerNormal = 1
    TimerNormalOther = 2
    TimerBig = 5
    TimerSea = 10
    TimerDiagonal = 15

    -- reset interval coefficient when play or replay the game
    intervalCoef = 1
end


function PlayState:update(dt)
    player:update(dt)

    for i, stuff in ipairs(listOfStuffs) do
        stuff:update(dt)
        if stuff.dead then
            table.remove(listOfStuffs, i)
            gPlayerScore = gPlayerScore + stuff.score
        end
        stuff:checkCollision(player)
    end

    for i, stuff in ipairs(listOfOtherStuffs) do
        stuff:update(dt)
        if stuff.dead then
            table.remove(listOfOtherStuffs, i)
            gPlayerScore = gPlayerScore + stuff.score
        end
        stuff:checkCollision(player)
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:update(dt)
        if bigStuff.dead then
            table.remove(listOfBigStuffs, i)
            gPlayerScore = gPlayerScore + bigStuff.score
        end
        bigStuff:checkCollision(player)
    end

    for i, seaStuff in ipairs(listOfSeaStuffs) do
        seaStuff:update(dt)
        if seaStuff.dead then
            table.remove(listOfSeaStuffs, i)
            gPlayerScore = gPlayerScore + seaStuff.score
        end
        seaStuff:checkCollision(player)
    end

    for i, diagonalStuff in ipairs(listOfDiagonalStuffs) do
        diagonalStuff:update(dt)
        if diagonalStuff.dead then
            table.remove(listOfDiagonalStuffs, i)
            gPlayerScore = gPlayerScore + diagonalStuff.score
        end
        diagonalStuff:checkCollision(player)
    end

    -- the smaller coefficient the shorter interval between stuffs
    if gPlayerScore > LevelOne and gPlayerScore < LevelTwo then intervalCoef = 0.8
    elseif gPlayerScore > LevelTwo and gPlayerScore < LevelThree then intervalCoef = 0.65
    elseif gPlayerScore > LevelThree and gPlayerScore < LevelFour then intervalCoef = 0.5
    elseif gPlayerScore > LevelFour and gPlayerScore < LevelFive then intervalCoef = 0.35
    elseif gPlayerScore > LevelFive and gPlayerScore < LevelSix then intervalCoef = 0.2
    elseif gPlayerScore > LevelSix and gPlayerScore < LevelSeven then intervalCoef = 0.15
    elseif gPlayerScore > LevelSeven then intervalCoef = 0.1
    end

    -- set timer for time interval event
    if TimerNormal <= 0 then
        TimerNormal = love.math.random(NormalIntervalMin, NormalIntervalMax) * intervalCoef
        table.insert(listOfStuffs, Stuff())
    end
    TimerNormal = TimerNormal - dt

    if TimerNormalOther <= 0 then
        TimerNormalOther = love.math.random(NormalOtherIntervalMin, NormalOtherIntervalMax) * intervalCoef
        table.insert(listOfOtherStuffs, Stuff())
    end
    TimerNormalOther = TimerNormalOther - dt

    if TimerBig <= 0 then
        TimerBig = love.math.random(BigIntervalMin, BigIntervalMax) * intervalCoef
        table.insert(listOfBigStuffs, BigStuff())
    end
    TimerBig = TimerBig - dt

    if TimerSea <= 0 then
        TimerSea = love.math.random(SeaIntervalMin, SeaIntervalMax) * intervalCoef
        table.insert(listOfBigStuffs, SeaStuff())
    end
    TimerSea = TimerSea - dt

    if TimerDiagonal <= 0 then
        TimerDiagonal = love.math.random(DiagonalIntervalMin, DiagonalIntervalMax) * intervalCoef
        table.insert(listOfDiagonalStuffs, DiagonalStuff(player.x, player.width))
    end
    TimerDiagonal = TimerDiagonal - dt
end


function PlayState:render()
    love.graphics.draw(background)
    player:render()
    
    for i, stuff in ipairs(listOfStuffs) do
        stuff:render()
    end

    for i, otherStuff in ipairs(listOfOtherStuffs) do
        otherStuff:render()
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:render()
    end

    for i, seaStuff in ipairs(listOfSeaStuffs) do
        seaStuff:render()
    end

    for i, diagonalStuff in ipairs(listOfDiagonalStuffs) do
        diagonalStuff:render()
    end

    love.graphics.setFont(largeFont)
    love.graphics.setColor(love.math.colorFromBytes(239, 242, 156))
    love.graphics.print("Score: ".. tostring(gPlayerScore), 15, 15)
end