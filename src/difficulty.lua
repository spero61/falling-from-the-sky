--[[
    Falling from the Sky

    -- difficulty.lua --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    Stores global variables ragarding difficulty in a file
    so as to make adjusting threshold with an ease.
]]

-- WindowWidth, WindowHeight = love.window.getDesktopDimensions()
gameWidth, gameHeight = 900, 1200 -- fixed game resolution

-- stuff.lua
-- speed coefficient (speedCoef)

-- main.lua
-- interval coefficient (intervalCoef)

-- a number of gPlayerScore that requires proceeds to next level
LevelOne = 500
LevelTwo = 1200
LevelThree = 2500
LevelFour = 3500
LevelFive = 5000
LevelSix = 7000
LevelSeven = 9000

-- player.lua
playerScale = 0.125 -- 1 : 8

-- stuff.lua
-- stuff's speed range
speedMin = 180
speedMax = 330
stuffScale = 0.15


-- bigStuff.lua
-- bigStuff is BigSpeedCoef times faster than the normal one
bigSpeedCoef = 1.75
bigStuffScale = 0.25


-- seaStuff.lua
-- seaStuff's VibrateTimer is the time until it starts to fall
vibrateTimer = 3
-- seaStuff's speed is quite fast because a player can predict its movement beforehand
seaStuffSpeed = 850
seaStuffScale = 0.2


-- diagonalStuff.lua
-- diagonalStuff's speed is important as it can determine game's difficulty significantly
diagonalStuffSpeed = 750
diagonalStuffScale = 0.15


-- main.lua
-- score
normalScore = 70
bigScore = 120
seaScore = 180
diagonalScore = 210


-- Timer related
TimerNormal = 1
TimerNormalOther = 2
TimerBig = 5
TimerSea = 17
TimerDiagonal = 30

NormalIntervalMin, NormalIntervalMax = 1, 3
NormalOtherIntervalMin, NormalOtherIntervalMax = 2, 5
BigIntervalMin, BigIntervalMax = 5, 8
SeaIntervalMin, SeaIntervalMax = 7, 12
DiagonalIntervalMin, DiagonalIntervalMax = 9, 18