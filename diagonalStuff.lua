-- DiagonalStuff makes a user to move player constantly, as it target's current player's x coordinate
DiagonalStuff = Stuff:extend()

require "difficulty"

function DiagonalStuff:new(playerX, playerWidth)
    DiagonalStuff.super:new()

    -- since lua does not support "switch"
    local index = math.random(1, 16)
    local imagePrefix = "diagonal"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/diagonalStuff/" .. filename)

    -- diagonalStuff's x value is dependant on player's x coordinate
    local window_width = love.graphics.getWidth()
    if playerX < window_width / 2 then
        self.x = window_width / 2 + math.random(0, 300)
        self.targetX = playerX - playerWidth - self.width
        self.isGoingRight = false
    else
        self.x = window_width / 2 - math.random(0, 300)
        self.targetX = playerX + playerWidth + self.width
        self.isGoingRight = true
    end
    self.y = -self.height

    -- diagonalX's movement target x coordinate is player's x at the moment a diagonalStuff is created
    -- thus, distanceX is the distance between player's x and diagonalStuff's x at that moment
    self.distanceX = math.abs(self.targetX - self.x)
    
    -- 1 : 10 ratio inherited
    self.speed = DiagonalStuffSpeed
end


function DiagonalStuff:update(dt)
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()

    -- diagonal Stuff moves like homming missiles toward player at the moment of creation
    -- but not following player's movement throughly to not to make game too difficult
    self.y = self.y + self.speed * dt
    if self.isGoingRight == true then
        self.x = self.x + self.speed * dt * (self.distanceX / window_width)
    else
        self.x = self.x - self.speed * dt * (self.distanceX / window_width)
    end


    if self.y - self.height > window_height and self.dead == false then
            ScoreDiagonal:play()
            self.dead = true
    end
end


function SeaStuff:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.1, 0.1)
end