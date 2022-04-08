Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("image/cute_kawauso_13727.png")
    self.x = 380
    self.y = 520
    -- 1 : 10 ratio
    self.height = self.image:getHeight() / 10
    self.width = self.image:getWidth() / 10
end


function Player:update(dt)
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.x = self.x - 120 * dt
    elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.x = self.x + 120 * dt
    end

    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = self.x + 4
    elseif self.x + self.width > window_width then
        self.x = self.x - 4
    end
end


function Player:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.1, 0.1)
end