Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("image/cute_kawauso_13727.png")
    self.x = 380
    self.y = 520
    self.speed = 0 -- current speed
    self.acceleration = 24 -- speed is goes over or below 0 by acceleration
    self.friction = 12 -- the more friction makes the game easier

    -- 1 : 10 ratio
    self.height = self.image:getHeight() / 10
    self.width = self.image:getWidth() / 10
end


function Player:update(dt)
    -- update player's position
    self.x = self.x + self.speed * dt
   
    -- when speed is positive, player character goes right
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.speed = self.speed + self.acceleration
    else
        if self.speed > 0 then
            self.speed = self.speed - self.friction
        end
    end

    -- when speed is negative, player character goes left
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.speed = self.speed - self.acceleration
    else
        if self.speed < 0 then
            self.speed = self.speed + self.friction
        end
    end

    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 4
        self.speed = 0
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width - 4
        self.speed = 0
    end
end


function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.1, 0.1)
end