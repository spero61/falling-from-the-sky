 -- a virtual resolution handling library
local push = require "push"

-- a classic OOP class library
Class = require "class"

require "Player"
require "Stuff"
require "BigStuff"
require "SeaStuff"
require "DiagonalStuff"

-- to adjust game difficulty and details in a file
require "difficulty"

-- game state and state machines
require "StateMachine"
require "states/BaseState"
require "states/TitleScreenState"
require "states/PlayState"
require "states/GameOverState"

-- score keeping
gHighestScore = 0

function love.load()
    player = Player()
    listOfStuffs = {}
    listOfOtherStuffs = {}
    listOfBigStuffs = {}
    listOfSeaStuffs = {}
    listOfDiagonalStuffs = {}

    gPlayerScore = 0
    isNewRecord = false
    
    
    -- initialize text fonts
    smallFont = love.graphics.newFont("Boogaloo-Regular.ttf", 18)
    mediumFont = love.graphics.newFont("Boogaloo-Regular.ttf", 32)
    largeFont = love.graphics.newFont("Boogaloo-Regular.ttf", 48)
    titleFont = love.graphics.newFont("orange juice 2.0.ttf", 90)
    love.graphics.setFont(mediumFont) -- default font
    
    -- soundtrack
    soundtrackTitle = love.audio.newSource("sound/soundtrack/2019-10-24 Failing Forward.mp3", "stream")
    soundtrackPlay = love.audio.newSource("sound/soundtrack/2022-02-02 Getting Through the Day.mp3", "stream")
    soundtrackGameOver = love.audio.newSource("sound/soundtrack/2022-03-02 Can We Just Enjoy Stuff Again.mp3", "stream")
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

    love.window.setTitle("Falling from the sky")
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(gameWidth, gameHeight, 1920, 1080, {
        vsync = true,
        fullscreen = false,
        resizable = false,
    })
    
    gStateMachine = StateMachine {
        ["title"] = function() return TitleScreenState() end,
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
    end
end