--[[
    Falling from the Sky

    -- DiagonalStuff Class --

    Author: Yoru Sung
    https://github.com/spero61/falling-from-the-sky

    DiagonalStuff makes a user to move player constantly,
    as it target's current player's x coordinate.
]]
DiagonalStuff = Class{__includes = Stuff}

function DiagonalStuff:init(playerX, playerWidth)
    local index = love.math.random(1, 16)
    local imagePrefix = "diagonal"
    if index < 10 then
        imagePrefix = imagePrefix .. "0"
    end
    local filename = imagePrefix .. tostring(index) .. ".png"
    self.image = love.graphics.newImage("image/diagonalStuff/" .. filename)

    self.scale = diagonalStuffScale
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale

    -- diagonalStuff's x value is dependant on player's x coordinate
    if playerX < gameWidth / 2 then
        self.x = gameWidth / 2 + love.math.random(0, gameWidth / 2)
        self.targetX = playerX + playerWidth + self.width / 2
        self.isGoingRight = false
    else
        self.x = love.math.random(0, gameWidth / 2)
        self.targetX = playerX - playerWidth - self.width / 2
        self.isGoingRight = true
    end
    self.y = -self.height

    -- diagonalX's movement target x coordinate is player's x at the moment a diagonalStuff is created
    -- thus, distanceX is the distance between player's x and diagonalStuff's x at that moment
    self.distanceX = math.abs(self.targetX - self.x)
    self.speed = diagonalStuffSpeed
    self.score = diagonalScore
    self.dead = false
end


function DiagonalStuff:update(dt)
    -- diagonal Stuff moves like homming missiles toward player at the moment of creation
    -- but not following player's movement throughly to not to make game too difficult
    self.y = self.y + self.speed * dt
    if self.isGoingRight == true then
        self.x = self.x + self.speed * dt * (self.distanceX / gameWidth)
    else
        self.x = self.x - self.speed * dt * (self.distanceX / gameWidth)
    end

    if self.y - self.height > gameHeight and self.dead == false then
            scoreDiagonal:play()
            self.dead = true
    end
end


function SeaStuff:render()
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end