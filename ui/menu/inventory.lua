-- #ID 1
local inventoryUI = {}

-- PROPERTIES
inventoryUI.sprite = love.graphics.newImage('assets/textures/ui/menu/inventory.png')
inventoryUI.test_sprite = love.graphics.newImage('assets/textures/gears/shoe.png')
inventoryUI.visible = false
inventoryUI.offset = {X = inventoryUI.sprite:getWidth()/2, Y = inventoryUI.sprite:getHeight()/2}

inventoryUI.grid = {}
inventoryUI.grid.offset = 55
inventoryUI.grid.padding = 115

inventoryUI.sprite:setFilter('nearest', 'nearest') -- SETS IMAGE FROM BLURRY TO PIXELATED

local inventory = require('inventory')

function inventoryUI:draw(scale)
    self.position = {X = love.graphics.getWidth()/2, Y = love.graphics.getHeight()/2}

    scale = scale * 4

    if self.visible == true then
        local menu = love.graphics.draw(self.sprite, self.position.X, self.position.Y, nil, scale, scale, self.offset.X, self.offset.Y)

        local item_position = {X = self.position.X - self.offset.X * 2.8, Y = self.position.Y - 8}

        for indexRow, mainRow in ipairs(inventory.main) do
            for indexColumn, item in ipairs(mainRow) do
                indexColumn = indexColumn - 1

                local columnPosition = item_position.X + (self.grid.offset + (self.grid.padding * indexColumn))

                if item and item.texture then
                    local image = love.graphics.draw(item.texture, columnPosition, item_position.Y, nil, scale, scale, nil, self.test_sprite:getHeight()/2)
                end
            end
        end
    end
end

return inventoryUI