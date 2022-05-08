--[[
    CS50x final project
    Falling from the Sky

    -- main.lua --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    -- Dependencies --
     [vrld/hump/class.lua](https://github.com/vrld/hump) a classic OOP class library
     [Ulydev/push](https://github.com/Ulydev/push) a simple resolution-handling library
     [kikito/tween](https://github.com/kikito/tween.lua) small sets of functions for performing tweening in Lua

    A file to organize global dependencies, game assets to this project.
]]
-- a virtual resolution handling library
local push = require "lib/push"

-- a classic OOP class library
Class = require "lib/class"

-- a LÖVE animation library
Tween = require "lib/tween"

require "src/Player"
require "src/Stuff"
require "src/BigStuff"
require "src/SeaStuff"
require "src/DiagonalStuff"

-- to adjust game difficulty and details in a file
require "src/difficulty"

-- game state and state machines
require "src/StateMachine"
require "states/BaseState"
require "states/TitleScreenState"
require "states/CountDownState"
require "states/PlayState"
require "states/GameOverState"

-- score keeping
gHighestScore = 0

-- keep fullscreen option
isFullScreen = false

function love.load()
    gPlayerScore = 0
    isNewRecord = false
    
    -- initialize text fonts
    smallFont = love.graphics.newFont("fonts/Boogaloo-Regular.ttf", 18)
    mediumFont = love.graphics.newFont("fonts/Boogaloo-Regular.ttf", 32)
    largeFont = love.graphics.newFont("fonts/Boogaloo-Regular.ttf", 48)
    titleFont = love.graphics.newFont("fonts/orange juice 2.0.ttf", 90)
    love.graphics.setFont(mediumFont) -- default font
    
    -- soundtrack
    soundtrackTitle = love.audio.newSource("sound/soundtrack/2019-10-24-Failing-Forward.ogg", "stream")
    soundtrackPlay = love.audio.newSource("sound/soundtrack/2022-02-02-Getting-Through-the-Day.ogg", "stream")
    soundtrackGameOver = love.audio.newSource("sound/soundtrack/2022-03-02-Can-We-Just-Enjoy-Stuff-Again.ogg", "stream")
    soundtrackTitle:setLooping(true)
    soundtrackPlay:setLooping(true)
    soundtrackGameOver:setLooping(true)
    
    -- https://love2d.org/wiki/Source:setVolume 
    soundtrackPlay:setVolume(0.7)
    
    -- sfx
    startGame = love.audio.newSource("sound/sfx/start.wav", "static")
    scoreSmall = love.audio.newSource("sound/sfx/scoreNormal.wav", "static")
    scoreBig = love.audio.newSource("sound/sfx/scoreBig.wav", "static")
    scoreSea = love.audio.newSource("sound/sfx/scoreSea.wav", "static")
    scoreDiagonal = love.audio.newSource("sound/sfx/scoreDiagonal.wav", "static")
    listOfSfx = {startGame, scoreSmall, scoreBig, scoreSea, scoreDiagonal}
    for i, sfx in ipairs(listOfSfx) do
        sfx:setVolume(0.6)
    end

    love.window.setTitle("Falling from the sky")
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(gameWidth, gameHeight, 1920, 1080, {
        vsync = true,
        fullscreen = false,
        resizable = false,
    })
    
    -- keep screen mode when restart the game from GameOverState
    if isFullScreen then
        push:switchFullscreen()
    end

    gStateMachine = StateMachine {
        ["title"] = function() return TitleScreenState() end,
        ["countdown"] = function() return CountDownState() end,
        ["play"] = function() return PlayState() end,
        ["gameover"] = function() return GameOverState() end,
    }
    gStateMachine:change("title")
end


function love.update(dt)
    gStateMachine:update(dt)
end


function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end


function love.keypressed(key)
    -- terminate the game
    if key == "escape" then
        love.event.quit()

    elseif key == "f" then
        push:switchFullscreen()
        if isFullScreen == false then
            isFullScreen = true
        else
            isFullScreen = false
        end
    end
end