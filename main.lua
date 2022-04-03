function love.load()
    player = {}
    player.x = 300
    player.y = 500
    player.height = 90
    player.width = 80

    listOfStuffs = {}

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")
end

function createStuff(x, y, speed)
    local stuff = {}
    stuff.x = x
    stuff.y = y
    stuff.height = 70
    stuff.width = 100
    stuff.speed = speed

    table.insert(listOfStuffs, stuff)
end

function love.keypressed(key)
    if key == "space" then
        local x = math.random(0, 700)
        local y = math.random(-300, -100)
        local speed = math.random(50, 120)
        createStuff(x, y, speed)
    end
end

function love.update(dt)
    -- a stuff is falling from the top
    for i, v in ipairs(listOfStuffs) do
        v.y = v.y + v.speed * dt
    end

    -- if it goes below the window, delete it
    

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
        love.graphics.rectangle(mode, player.x, player.y, player.width, player.height)
    end
    love.graphics.print("If player collides with the stuff, both become colored", 470, 15)
    love.graphics.print("Press space to start game or to add another stuff", 470, 30)
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