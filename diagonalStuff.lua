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

    self.scale = DiagonalStuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale

    -- diagonalStuff's x value is dependant on player's x coordinate
    if playerX < GameWidth / 2 then
        self.x = GameWidth / 2 + math.random(0, GameWidth / 2)
        self.targetX = playerX + playerWidth + self.width / 2
        self.isGoingRight = false
    else
        self.x = math.random(0, GameWidth / 2)
        self.targetX = playerX - playerWidth - self.width / 2
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

    -- diagonal Stuff moves like homming missiles toward player at the moment of creation
    -- but not following player's movement throughly to not to make game too difficult
    self.y = self.y + self.speed * dt
    if self.isGoingRight == true then
        self.x = self.x + self.speed * dt * (self.distanceX / GameWidth)
    else
        self.x = self.x - self.speed * dt * (self.distanceX / GameWidth)
    end


    if self.y - self.height > GameHeight and self.dead == false then
            ScoreDiagonal:play()
            self.dead = true
    end
end


function SeaStuff:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end