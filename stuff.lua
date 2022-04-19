Stuff = Class{}

function Stuff:init()
    -- https://love2d.org/wiki/love.math.random
    local index = love.math.random(1, 40)
    local imagePrefix = "stuff"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/stuff/" .. filename)

    local speedCoef = Stuff:calcSpeedCoef(gPlayerScore)

    self.scale = stuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.x = love.math.random(0, gameWidth - self.width)
    self.y = love.math.random(-self.height * 5, -self.height)
    self.speed = love.math.random(speedMin, speedMax) * speedCoef
    self.score = normalScore
    self.dead = false
end

function Stuff:calcSpeedCoef(gPlayerScore)
    -- speed coefficient
    local speedCoef = 1
    -- as the player gets more score, stuff's speed also gets faster
    if gPlayerScore > LevelOne then
        speedCoef = 1.2
    elseif gPlayerScore > LevelTwo then
        speedCoef = 1.4
    elseif gPlayerScore > LevelThree then
        speedCoef = 1.6
    elseif gPlayerScore > LevelFour then
        speedCoef = 1.8
    elseif gPlayerScore > LevelFive then
        speedCoef = 2.0
    elseif gPlayerScore > LevelSix then
        speedCoef = 2.5
    elseif gPlayerScore > LevelSeven then
        speedCoef = 3
    end

    return speedCoef
end

function Stuff:update(dt)
    self.y = self.y + self.speed * dt

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            scoreSmall:play()
            self.dead = true
    end
end


function Stuff:render()
    -- https://love2d.org/wiki/love.graphics.draw
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

        -- if a player collides with a stuff, game over
        soundtrackPlay:stop()
        gStateMachine:change("gameover")
    end
end