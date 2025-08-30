local player = {}

-- LIBRARIES
local anim8 = require('lib.anim8')
local camera = require('lib.camera')
local util = require('util')

local loadTexture = util.loadTexture

-- GAME OBJECTS
local inventory = require('inventory')

function player:load(world, spawn_location)
    -- STATISTICS
    self.money = 1000
    self.position = {X = spawn_location.X, Y = spawn_location.Y}
    self.walkSpeed = 4400

    -- GRAPHICS
    self.spriteSheet = loadTexture('assets/textures/entities/kernSpriteSheet.png')
    self.grid = anim8.newGrid(64,64,self.spriteSheet:getWidth(),self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.right = anim8.newAnimation(self.grid('1-7',1), 0.07)
    self.animations.left = anim8.newAnimation(self.grid('1-7',2), 0.07)

    -- PHYSICS
    self.collider_size = {X = 17, Y = 2}
    self.collider = world:newCollider("Rectangle", {spawn_location.X,spawn_location.Y, 17, 23})
    self.collider:setFixedRotation(true)

    -- PLAYER STATE
    self.currentAnimation = self.animations.left

    -- PLAYER INVENTORY
    inventory:init(self) -- PLAYER HOTBAR SELECTION IS ON INVENTORY.LUA
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

    if idle == true then
        self.currentAnimation:gotoFrame(1)
    end

    -- MAKES THE PLAYER SPRITE MOVE AS LONG WITH PLAYER'S COLLIDER
    self.position.X = self.collider:getX() - 1
    self.position.Y = self.collider:getY() - 7

end

function player:draw()
    local character = self.currentAnimation:draw(self.spriteSheet, self.position.X, self.position.Y, nil, 0.6, nil, 32, 32)
    
    local item_position = {X = self.position.X + 10, Y = self.position.Y + 17}
    local item_scale = {X = 0.7, Y = 0.7}
    local item_orientation

    if self.currentAnimation == self.animations.left then
        item_position.X = self.position.X - 10
        item_scale.X = 0.7
        item_orientation = 85
    elseif self.currentAnimation == self.animations.right then
        item_position.X = self.position.X + 10
        item_scale.X = -0.7
        item_orientation = -85
    end

    if self.holding.texture then
        love.graphics.draw(self.holding.texture, item_position.X, item_position.Y, item_orientation, item_scale.X, item_scale.Y, self.holding.texture:getWidth()/2, self.holding.texture:getHeight()/2)
    end
end

return player