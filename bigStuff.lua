BigStuff = Stuff:extend()

require "difficulty"

function BigStuff:new()
    BigStuff.super:new()
    -- 1 : 5 ratio
    self.height = self.image:getHeight() / 5
    self.width = self.image:getWidth() / 5

    -- since lua does not support "switch"
    local index = math.random(1, 9)
    if index == 1 then
        self.image = love.graphics.newImage("image/grand_piano_illust_4023.png")
    elseif index == 2 then
        self.image = love.graphics.newImage("image/music_drum_7605.png")
    elseif index == 3 then
        self.image = love.graphics.newImage("image/music_trumpet_illust_4160.png")
    elseif index == 4 then
        self.image = love.graphics.newImage("image/park_jungle_gym_16191.png")
    elseif index == 5 then
        self.image = love.graphics.newImage("image/stereo_component_10222.png")
    elseif index == 6 then
        self.image = love.graphics.newImage("image/sports_bike_15973.png")
    elseif index == 7 then
        self.image = love.graphics.newImage("image/gasoline_refueling_14791.png")
    elseif index == 8 then
        self.image = love.graphics.newImage("image/passenger_ship_13267.png")
    elseif index == 9 then
        self.image = love.graphics.newImage("image/merry_go_round_9365.png")
    end
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