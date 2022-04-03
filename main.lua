function love.load()
    player = {}
    player.x = 300
    player.y = 500
    player.height = 90
    player.width = 80

    listOfStuffs = {}
    -- automatically start the game by creating the first stuff
    createStuff()
    
    -- global variable to set time interval
    Timer = 3

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")
end


function createStuff()
    local stuff = {}
    stuff.x = math.random(0, 700)
    stuff.y = math.random(-300, -100)
    stuff.height = 70
    stuff.width = 100
    stuff.speed = math.random(50, 120)

    table.insert(listOfStuffs, stuff)
end


function love.update(dt)
    -- a stuff is falling from the top
    for i, v in ipairs(listOfStuffs) do
        v.y = v.y + v.speed * dt

        -- if it goes below the window, delete it
        -- (make sure listOfStuffs is not empty to prevent error)
        if #listOfStuffs > 2 and v.y > 600 then
            table.remove(listOfStuffs, i - 1)
        end
    end

    -- set timer for time interval event
    if Timer <= 0 then
        Timer = math.random(0.5, 1.5)
        createStuff()
    end
    Timer = Timer - dt

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
    for i, v in ipairs(listOfStuffs) do
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