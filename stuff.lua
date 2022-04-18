Stuff = Object:extend()

function Stuff:new()
    -- https://love2d.org/wiki/love.math.random
    local index = love.math.random(1, 40)
    local imagePrefix = "stuff"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/stuff/" .. filename)

    -- speed coefficient
    local speedCoef = 1
    -- as the player gets more score, stuff's speed also gets faster
    if PlayerScore > LevelOne then
        speedCoef = 1.2
    elseif PlayerScore > LevelTwo then
        speedCoef = 1.4
    elseif PlayerScore > LevelThree then
        speedCoef = 1.6
    elseif PlayerScore > LevelFour then
        speedCoef = 1.8
    elseif PlayerScore > LevelFive then
        speedCoef = 2.0
    elseif PlayerScore > LevelSix then
        speedCoef = 2.5
    elseif PlayerScore > LevelSeven then
        speedCoef = 3
    end

    self.scale = StuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.x = love.math.random(0, GameWidth - self.width)
    self.y = love.math.random(-self.height * 5, -self.height)
    self.speed = love.math.random(SpeedMin, SpeedMax) * speedCoef
    -- self.deg = love.math.random(120, 240)
    self.dead = false
end


function Stuff:update(dt)
    self.y = self.y + self.speed * dt

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            ScoreSmall:play()
            self.dead = true
    end
end


function Stuff:draw()
    -- https://love2d.org/wiki/love.graphics.draw
    -- love.graphics.draw(self.image, self.x, self.y, math.rad(self.deg), 0.1, 0.1, self.width / 2, self.height / 2)
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
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
        PlayerScore = 0
    end
end