SeaStuff = Stuff:extend()

require "difficulty"

function SeaStuff:new()
    self.x = math.random(0, 680)
    
    -- 1 : 8 ratio
    self.height = self.image:getHeight() / 8
    self.width = self.image:getWidth() / 8
    self.speed = SeaStuffSpeed
    self.dead = false

    -- since lua does not support "switch"
    local index = math.random(1, 20)
    local imagePrefix = "sea"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/" .. filename)

    -- for seaStuff specific behavior
    self.vibrateTimer = VibrateTimer
end


function SeaStuff:update(dt)

    if self.vibrateTimer > 0 then
        self.y = math.random(15, 20)
    end
    self.vibrateTimer = self.vibrateTimer - dt

    if self.vibrateTimer <= 0 then
        -- twice faster than a normal one
        self.y = self.y + self.speed * dt
    end

    local window_height = love.graphics.getHeight()

    if self.y - self.height > window_height and self.dead == false then
            ScoreSea:play()
            self.dead = true
    end
end


function SeaStuff:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.125, 0.125)
end