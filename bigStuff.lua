BigStuff = Class{__includes = Stuff}

function BigStuff:init()
    local index = love.math.random(1, 30)
    local imagePrefix = "big"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/bigStuff/" .. filename)

    local speedCoef = Stuff:calcSpeedCoef(gPlayerScore)

    self.scale = bigStuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.x = love.math.random(0, gameWidth - self.width * 1.5)
    self.y = love.math.random(-self.height * 5, -self.height)
    self.speed = love.math.random(speedMin, speedMax) * speedCoef * bigSpeedCoef
    self.score = bigScore
    self.dead = false
end


function BigStuff:update(dt)
    -- twice faster than a normal one
    self.y = self.y + self.speed * dt

    if self.y - self.height > gameHeight and self.dead == false then
            scoreBig:play()
            self.dead = true
    end
end


function BigStuff:render()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end