 -- a virtual resolution handling library
local push = require "push"
local background = love.graphics.newImage("image/background/main.jpg")

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

function love.load()
    player = Player()
    listOfStuffs = {}
    listOfOtherStuffs = {}
    listOfBigStuffs = {}
    listOfSeaStuffs = {}
    listOfDiagonalStuffs = {}

    -- score keeping
    gPlayerScore = 0
    
    love.window.setTitle("Falling from the sky")
    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(gameWidth, gameHeight, 1920, 1080, {
        vsync = true,
        fullscreen = false,
        resizable = false,
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('title')

    -- initialize text fonts
    SmallFont = love.graphics.newFont("Boogaloo-Regular.ttf", 18)
    MediumFont = love.graphics.newFont("Boogaloo-Regular.ttf", 32)
    LargeFont = love.graphics.newFont("Boogaloo-Regular.ttf", 48)
    TitleFont = love.graphics.newFont("orange juice 2.0.ttf", 90)
    love.graphics.setFont(MediumFont) -- default font

    -- soundtrack - PLAY
    SoundtrackPlay = love.audio.newSource("sound/soundtrackPlay.ogg", "stream")
    SoundtrackPlay:setLooping(true)
    
    -- https://love2d.org/wiki/Source:setVolume 
    SoundtrackPlay:setVolume(0.2)

    -- sfx
    StartGame = love.audio.newSource("sound/start.wav", "static")
    ScoreSmall = love.audio.newSource("sound/scoreNormal.wav", "static")
    ScoreBig = love.audio.newSource("sound/scoreBig.wav", "static")
    ScoreSea = love.audio.newSource("sound/scoreSea.wav", "static")
    ScoreDiagonal = love.audio.newSource("sound/scoreDiagonal.wav", "static")
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