BigStuff = Stuff:extend()

function BigStuff:new()
    BigStuff.super:new()
    -- 1 : 5 ratio
    self.height = self.image:getHeight() / 5
    self.width = self.image:getWidth() / 5
    self.image = love.graphics.newImage("image/grand_piano_illust_4023.png")
end


function BigStuff:update(dt)
    -- twice faster than a normal one
    self.y = self.y + self.speed * dt * 2

    local window_height = love.graphics.getHeight()

    if self.y > window_height and self.dead == false then
            scoreBig:play()
            self.dead = true
    end
end


function BigStuff:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.2, 0.2)
end