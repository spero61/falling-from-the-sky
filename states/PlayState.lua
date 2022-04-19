-- main game play state
PlayState = Class{__includes = BaseState}

local background = love.graphics.newImage("image/background/main.jpg")

function PlayState:init()
    SoundtrackPlay:play()
end

function PlayState:update(dt)
   
    player:update(dt)

    for i, stuff in ipairs(listOfStuffs) do
        stuff:update(dt)
        stuff:checkCollision(player)
        if stuff.dead then
            table.remove(listOfStuffs, i)
            gPlayerScore = gPlayerScore + stuff.score
        end
    end

    for i, stuff in ipairs(listOfOtherStuffs) do
        stuff:update(dt)
        stuff:checkCollision(player)
        if stuff.dead then
            table.remove(listOfOtherStuffs, i)
            gPlayerScore = gPlayerScore + stuff.score
        end
    end

    for i, bigStuff in ipairs(listOfBigStuffs) do
        bigStuff:update(dt)
        bigStuff:checkCollision(player)
        if bigStuff.dead then
            table.remove(listOfBigStuffs, i)
            gPlayerScore = gPlayerScore + bigStuff.score
        end
    end

    for i, seaStuff in ipairs(listOfSeaStuffs) do
        seaStuff:update(dt)
        seaStuff:checkCollision(player)
        if seaStuff.dead then
            table.remove(listOfSeaStuffs, i)
            gPlayerScore = gPlayerScore + seaStuff.score
        end
    end

    for i, diagonalStuff in ipairs(listOfDiagonalStuffs) do
        diagonalStuff:update(dt)
        diagonalStuff:checkCollision(player)
        if diagonalStuff.dead then
            table.remove(listOfDiagonalStuffs, i)
            gPlayerScore = gPlayerScore + diagonalStuff.score
        end
    end

    
    -- the smaller coefficient the shorter interval between stuffs
    local intervalCoef = 1
    if gPlayerScore > LevelOne then
        intervalCoef = 0.8
    elseif gPlayerScore > LevelTwo then
        intervalCoef = 0.6
    elseif gPlayerScore > LevelThree then
        intervalCoef = 0.4
    elseif gPlayerScore > LevelFour then
        intervalCoef = 0.3
    elseif gPlayerScore > LevelFive then
        intervalCoef = 0.2
    elseif gPlayerScore > LevelSix then
        intervalCoef = 0.15
    elseif gPlayerScore > LevelSeven then
        intervalCoef = 0.1
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

    love.graphics.setFont(LargeFont)
    love.graphics.setColor(love.math.colorFromBytes(239, 242, 156))
    love.graphics.print("Score: ".. tostring(gPlayerScore), 15, 15)
end