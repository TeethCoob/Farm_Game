-- #ID 1
local inventoryUI = {}

local util = require('util')
local inventory = require('inventory')

local loadTexture = util.loadTexture

-- PROPERTIES
inventoryUI.sprite = loadTexture('assets/textures/ui/menu/inventory.png')
inventoryUI.visible = false
inventoryUI.position = {}
inventoryUI.scale = 4
inventoryUI.scale_offset = {
    X = inventoryUI.sprite:getWidth()/2,
    Y = inventoryUI.sprite:getHeight()/2
}
inventoryUI.grid = {
    padding = nil
}

function inventoryUI:draw()
    self.position.X = love.graphics.getWidth()/2
    self.position.Y = love.graphics.getHeight()/2

    if self.visible then
        love.graphics.draw(
            self.sprite,
            self.position.X,
            self.position.Y,
            nil,
            self.scale,
            self.scale,
            self.scale_offset.X,
            self.scale_offset.Y
        )
    end
end

return inventoryUI