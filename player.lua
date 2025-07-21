player = {}

-- LIBRARIES
local anim8 = require('lib.anim8')
local camera = require('lib.camera')
local wf = require('lib.windfield')
local util = require('util')

-- GAME OBJECTS
local item = require('item')
local inv = require('inventory')

-- BLURRY PIXEL ART > CLEAN PIXEL ART
love.graphics.setDefaultFilter('nearest', 'nearest')

function player:load(world,spawnLocX,spawnLocY)
    -- GRAPHICS
    self.spriteSheet = love.graphics.newImage('assets/textures/entities/kernSpriteSheet.png')
    self.grid = anim8.newGrid(64,64,self.spriteSheet:getWidth(),self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.right = anim8.newAnimation(self.grid('1-7',1), 0.07)
    self.animations.left = anim8.newAnimation(self.grid('1-7',2), 0.07)

    -- PHYSICS
    self.collider = world:newBSGRectangleCollider(spawnLocX,spawnLocY,17,23,2)
    self.collider:setFixedRotation(true)

    -- STATISTICS
    self.money = 1000
    self.position = {X = 523,Y = 466}
    self.walkSpeed = 4400

    -- PLAYER STATE
    self.currentAnimation = self.animations.left

    inv:new()

end

function player:update(dt)
    self:move(dt)
    self.currentAnimation:update(dt)
end

-- MOVES PLAYER
function player:move(dt)
    -- PLAYER'S STATE
    local idle = true

    -- PLAYER'S VELOCITY
    local velocityX = 0
    local velocityY = 0

    -- CONTROL
    if love.keyboard.isDown("up", 'w') then
        velocityY = self.walkSpeed * -1 * dt
        idle = false
    elseif love.keyboard.isDown("down", 's') then
        velocityY = self.walkSpeed * dt
        idle = false
    elseif love.keyboard.isDown("right", 'd') then
        velocityX = self.walkSpeed * dt
        self.currentAnimation = self.animations.right
        idle = false
    elseif love.keyboard.isDown("left", 'a') then
        velocityX = self.walkSpeed * -1 * dt
        self.currentAnimation = self.animations.left
        idle = false
    end

    -- MOVES PLAYER COLLIDER
    self.collider:setLinearVelocity(velocityX,velocityY)

    -- IDLE ANIMATION
    if idle == true then
        self.currentAnimation:gotoFrame(1)
    end

    -- MAKES THE PLAYER SPRITE MOVE AS LONG WITH PLAYER'S COLLIDER
    self.position.X = self.collider:getX() - 1
    self.position.Y = self.collider:getY() - 7 
    
end

-- DRAWS PLAYER'S SPRITE
function player:draw()
    self.currentAnimation:draw(self.spriteSheet, self.position.X, self.position.Y, nil, 0.6, nil, 32, 32)
end

return player