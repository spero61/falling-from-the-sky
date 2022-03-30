function love.load()
    player = {}
    player.x = 300
    player.y = 500
    player.height = 90
    player.width = 80

    stuff = {}
    stuff.x = math.random(200, 600)
    stuff.y = -100
    stuff.height = 70
    stuff.width = 100

    love.graphics.setBackgroundColor(119/255, 136/255, 153/255)
    love.window.setTitle("Falling from the sky")
end

function love.update(dt)
    -- stuff is falling from the top
    stuff.y = stuff.y + 200 * dt
    -- if it goes below the window, start from the top again
    if stuff.y > 600 then
        stuff.y = -100
        stuff.x = math.random(200, 600)
    end

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
    if checkCollision(player, stuff) then
        mode = "fill"
    else
        mode = "line"
    end

    love.graphics.rectangle(mode, player.x, player.y, player.width, player.height)
    love.graphics.rectangle(mode, stuff.x, stuff.y, stuff.width, stuff.height)
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