Stuff = Object:extend()

require "difficulty"

function Stuff:new()
    -- speed coefficient
    local speedCoef = 1
    -- as the player gets more score, stuff's speed also gets faster
    if PlayerScore > LevelOne then
        speedCoef = 2
    elseif PlayerScore > LevelTwo then
        speedCoef = math.floor(PlayerScore / 2500)
    end
    
    local index = math.random(1, 5)
    if index == 1 then
        self.image = love.graphics.newImage("image/bike_helmet_15988.png")
    elseif index == 2 then
        self.image = love.graphics.newImage("image/mushimegane_search_illust_1949.png")
    elseif index == 3 then
        self.image = love.graphics.newImage("image/dram_11171.png")
    elseif index == 4 then
        self.image = love.graphics.newImage("image/cardboard_illust_3504.png")
    elseif index == 5 then
        self.image = love.graphics.newImage("image/doki_14977.png")
    end

    self.x = math.random(0, 700)
    self.y = math.random(-300, -100)
    self.speed = math.random(100, 200) * speedCoef
    self.height = self.image:getHeight() / 10
    self.width = self.image:getWidth() / 10
    -- self.deg = math.random(120, 240)
    self.dead = false
end


function Stuff:update(dt)
    self.y = self.y + self.speed * dt

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            scoreSmall:play()
            self.dead = true
    end
end


function Stuff:draw()
    -- https://love2d.org/wiki/love.graphics.draw
    -- love.graphics.draw(self.image, self.x, self.y, math.rad(self.deg), 0.1, 0.1, self.width / 2, self.height / 2)
    love.graphics.draw(self.image, self.x, self.y, 0, 0.1, 0.1)
end


-- https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
function Stuff:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    -- when there is a collision
    if self_left < obj_right
    and self_right > obj_left
    and self_top < obj_bottom
    and self_bottom > obj_top then
        self.dead = true

        -- Restart the game
        soundtrackPlay:stop()
        love.load()
    end
end