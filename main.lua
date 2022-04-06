function love.load()
    player = {}
    player.x = 300
    player.y = 500
    player.height = 90
    player.width = 80

    listOfStuffs = {}
    listOfFastStuffs = {}
    -- automatically start the game by creating the first stuff
    createStuff()
    createFastStuff()

    -- global variable to set time interval
    TimerSmall = 3
    TimerBig = 10

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")

    -- sound
    
    -- soundtrack - PLAY
    soundtrackPlay = love.audio.newSource("sound/soundtrack_play.ogg", "stream")
    soundtrackPlay:setLooping(true)
    soundtrackPlay:play()
    
    -- https://love2d.org/wiki/Source:setVolume 
    soundtrackPlay:setVolume(0.5)

    -- sfx
    scoreSmall = love.audio.newSource("sound/score_small.wav", "static")
    scoreBig = love.audio.newSource("sound/score_big.wav", "static")
end


function createStuff()
    local stuff = {}
    stuff.x = math.random(0, 700)
    stuff.y = math.random(-300, -100)
    stuff.height = 70
    stuff.width = 100
    stuff.speed = math.random(50, 120)
    stuff.dead = false

    table.insert(listOfStuffs, stuff)
end

function createFastStuff()
    local stuff = {}
    stuff.x = math.random(0, 700)
    stuff.y = math.random(-200, -50)
    stuff.height = 50
    stuff.width = 50
    stuff.speed = math.random(200, 300)
    stuff.dead = false

    table.insert(listOfFastStuffs, stuff)
end


function love.update(dt)
    -- a stuff is falling from the top
    for i, v in ipairs(listOfStuffs) do
        v.y = v.y + v.speed * dt

        -- TODO: introduce "delete" the object when implementing using OOP

        if v.y > 600 and v.dead == false then
            scoreSmall:play()
            v.dead = true
        end
        
    end

    -- a fast stuff is falling from the top
    for i, v in ipairs(listOfFastStuffs) do
        v.y = v.y + v.speed * dt

        -- TODO: introduce "delete" the object when implementing using OOP

        if v.y > 600 and v.dead == false then
            scoreBig:play()
            v.dead = true
        end
        
    end

    -- set timer for time interval event
    if TimerSmall <= 0 then
        TimerSmall = math.random(2, 4)
        createStuff()
    end
    TimerSmall = TimerSmall - dt
    
    if TimerBig <= 0 then
        TimerBig = math.random(5, 10)
        createFastStuff()
    end
    TimerBig = TimerBig - dt

    -- player movement
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        player.x = player.x - 120 * dt
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        player.x = player.x + 120 * dt
    end

    if player.x < 0 then
        player.x = player.x + 4
    elseif player.x + player.width > 800 then
        player.x = player.x - 4
    end

end


function love.draw()
    local mode
    -- stuffs
    for i, v in ipairs(listOfStuffs) do
        if checkCollision(player, v) then
            mode = "fill"
        else
            mode = "line"
        end
        love.graphics.rectangle(mode, v.x, v.y, v.width, v.height)    
    end

    -- fast stuffs
    for i, v in ipairs(listOfFastStuffs) do
        if checkCollision(player, v) then
            mode = "fill"
        else
            mode = "line"
        end
        love.graphics.rectangle(mode, v.x, v.y, v.width, v.height)    
    end

    love.graphics.rectangle(mode, player.x, player.y, player.width, player.height)
    
    love.graphics.print("If player collides with the stuff, both become colored", 470, 15)
end


-- https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    return a_left < b_right
        and a_right > b_left
        and a_top < b_bottom
        and a_bottom > b_top
end