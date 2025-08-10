-- #ID 1
local hotbarUI = {}

-- PROPERTIES
hotbarUI.hotbar_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar.png')
hotbarUI.hotbar_selection_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar_selection.png')
hotbarUI.offset = {x = hotbarUI.hotbar_sprite:getWidth()/2, y = hotbarUI.hotbar_sprite:getHeight()/2}

hotbarUI.grid = {}
hotbarUI.grid.slotCount = 9
hotbarUI.grid.slotMargin = 51
hotbarUI.grid.slotSpacing = 26
hotbarUI.grid.outerPaddingX = 20
hotbarUI.grid.outerPaddingY = 21

local utility = require('ui.util')
local inventory = require('inventory')

function hotbarUI:draw(scale)
    -- hotbarUI
    hotbar_position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight() - 15} -- *POSITION OF hotbarUI

    hotbar_position.y = hotbar_position.y - (self.offset.y - 20) -- RECORRECTS THE Y AXIS POSITION

    love.graphics.draw(self.hotbar_sprite, hotbar_position.x, hotbar_position.y, nil, scale, scale, self.offset.x, self.offset.y)

    -- hotbarUI SELECTION OUTLINE
    local selection_index = inventory.hotbar.selection_index - 1 -- INDEX OF THE hotbarUI SELECTION ON INVENTORY
    local selection_scale = scale
    local selection_offset = {x = self.hotbar_selection_sprite:getWidth()/4 , y = self.hotbar_selection_sprite:getHeight()/4}

    local gridX,gridY = self.grid:new(selection_index, selection_scale)
    gridX = gridX * 1.002 -- RECORRECTS THE X AXIS
    gridY = gridY - 1     -- RECORRECTS THE Y AXIS
    
    love.graphics.draw(self.hotbar_selection_sprite, gridX, gridY, nil, selection_scale, selection_scale, selection_offset.x, selection_offset.y)

    -- ITEM 
    for slotIndex, item in ipairs(inventory.hotbar) do
        slotIndex = slotIndex - 1

        local drawX, drawY = self.grid:new(slotIndex, scale)
        local item_scale = scale * 2.75

        if item and item.texture then
            item.texture:setFilter('nearest', 'nearest') -- MAKE IMAGE PIXELATED

            local textureW = item.texture:getWidth() * item_scale
            local textureH = item.texture:getHeight() * item_scale

            local itemX = drawX + (self.grid.slotMargin * scale - textureW) / 2
            local itemY = drawY + (self.grid.slotMargin * scale - textureH) / 2

            local image = love.graphics.draw(item.texture, itemX, itemY, nil, item_scale, item_scale)
        end
    end
end

function hotbarUI.grid:new(index, scale)
    local baseX = hotbar_position.x - hotbarUI.offset.x * (scale or 1)
    local baseY = hotbar_position.y - hotbarUI.offset.y * (scale or 1)

    local x = baseX + self.outerPaddingX * (scale or 1) + index * (self.slotMargin + self.slotSpacing) * (scale or 1)
    local y = baseY + self.outerPaddingY * (scale or 1)

    return x, y
end

return hotbarUI