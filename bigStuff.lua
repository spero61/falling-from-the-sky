BigStuff = Stuff:extend()

require "difficulty"

function BigStuff:new()
    BigStuff.super:new()

    -- since lua does not support "switch"
    local index = math.random(1, 30)
    local imagePrefix = "big"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/bigStuff/" .. filename)

    -- 1 : 5 ratio
    self.height = self.image:getHeight() / 5
    self.width = self.image:getWidth() / 5
end


function BigStuff:update(dt)
    -- twice faster than a normal one
    self.y = self.y + self.speed * dt * BigSpeedCoef

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            ScoreBig:play()
            self.dead = true
    end
end


function BigStuff:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.2, 0.2)
end