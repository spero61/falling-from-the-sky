-- global variables ragarding difficulty in a file so as to make adjusting threshold with an ease

-- WindowWidth, WindowHeight = love.window.getDesktopDimensions()
GameWidth, GameHeight = 900, 1200 -- fixed game resolution

-- stuff.lua
-- speed coefficient (speedCoef)

-- main.lua
-- interval coefficient (intervalCoef)

-- a number of PlayerScore that requires proceeds to next level
LevelOne = 300
LevelTwo = 700
LevelThree = 1500
LevelFour = 3000
LevelFive = 5000
LevelSix = 7000
LevelSeven = 9000

-- player.lua
PlayerScale = 0.125 -- 1 : 8

-- stuff.lua
-- stuff's speed range
SpeedMin = 150
SpeedMax = 300
StuffScale = 0.15


-- bigStuff.lua
-- bigStuff is BigSpeedCoef times faster than the normal one
BigSpeedCoef = 1.75
BigStuffScale = 0.25


-- seaStuff.lua
-- seaStuff's VibrateTimer is the time until it starts to fall
VibrateTimer = 3
-- seaStuff's speed is quite fast because a player can predict its movement beforehand
SeaStuffSpeed = 800
SeaStuffScale = 0.2


-- diagonalStuff.lua
-- diagonalStuff's speed is important as it can determine game's difficulty significantly
DiagonalStuffSpeed = 700
DiagonalStuffScale = 0.15


-- main.lua
-- score
NormalScore = 250
BigScore = 350
SeaScore = 400
DiagonalScore = 500


-- Timer related
TimerNormal = 3
TimerNormalOther = 5
TimerBig = 7
TimerSea = 3
TimerDiagonal = 4

NormalIntervalMin, NormalIntervalMax = 1, 3
NormalOtherIntervalMin, NormalOtherIntervalMax = 2, 5
BigIntervalMin, BigIntervalMax = 10, 15
SeaIntervalMin, SeaIntervalMax = 5, 12
DiagonalIntervalMin, DiagonalIntervalMax = 2, 5