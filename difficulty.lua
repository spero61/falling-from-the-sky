-- global variables ragarding difficulty in a file so as to make adjusting threshold with an ease

-- 1)
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

-- 2)
-- stuff.lua
-- stuff's speed range
SpeedMin = 150
SpeedMax = 300


-- 3)
-- bigStuff.lua
-- bigStuff is BigSpeedCoef times faster than the normal one
BigSpeedCoef = 1.75


-- 4)
-- seaStuff.lua
-- seaStuff's VibrateTimer is the time until it starts to fall
VibrateTimer = 3
-- seaStuff's speed is quite fast because a player can predict its movement beforehand
SeaStuffSpeed = 500


-- 5)
-- diagonalStuff.lua
-- diagonalStuff's speed is important as it can determine game's difficulty significantly
DiagonalStuffSpeed = 450


-- 6)
-- main.lua
-- score
-- NormalScore = 70
-- BigScore = 150
NormalScore = 270
BigScore = 550
SeaScore = 500
DiagonalScore = 600