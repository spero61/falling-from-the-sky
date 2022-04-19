Player = Class{}

function Player:init()
    self.image = love.graphics.newImage("image/player/player.png")
    
    self.scale = playerScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.x = (gameWidth + self.width) / 2 - self.width
    self.y = gameHeight - self.height * 1.1
    self.speed = 0 -- current speed
    self.acceleration = 22 -- speed is goes over or below 0 by acceleration
    self.friction = 12 -- the more friction makes the game easier

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

    -- to prevent unwanted move due to friction addition
    if math.abs(self.friction) > math.abs(self.speed) then
        self.speed = 0
    end

    if self.x < 0 then
        self.x = 4
        self.speed = 0
    elseif self.x + self.width > gameWidth then
        self.x = gameWidth - self.width - 4
        self.speed = 0
    end
end


function Player:render()
    -- https://love2d.org/wiki/love.graphics.draw
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end