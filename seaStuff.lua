SeaStuff = Class{__includes = Stuff}

function SeaStuff:init()
    local index = love.math.random(1, 20)
    local imagePrefix = "sea"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/seaStuff/" .. filename)

    self.scale = seaStuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.x = love.math.random(0, gameWidth - self.width)
    self.speed = seaStuffSpeed
    self.score = seaScore
    self.dead = false

    -- for seaStuff specific behavior
    self.vibrateTimer = vibrateTimer
end


function SeaStuff:update(dt)

    if self.vibrateTimer > 0 then
        self.y = love.math.random(15, 20)
    end
    self.vibrateTimer = self.vibrateTimer - dt

    if self.vibrateTimer <= 0 then
        -- twice faster than a normal one
        self.y = self.y + self.speed * dt
    end

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            scoreSea:play()
            self.dead = true
    end
end


function SeaStuff:render()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end