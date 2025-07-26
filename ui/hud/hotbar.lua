hotbarUI = {}
hotbarUI.hotbar_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar.png')
hotbarUI.hotbar_selection_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar_selection.png')
hotbarUI.grid = {}
hotbarUI.grid.slotCount = 9
hotbarUI.grid.slotWidth = 51
hotbarUI.grid.slotHeight = 51
hotbarUI.grid.slotSpacing = 26
hotbarUI.grid.outerPaddingX = 20
hotbarUI.grid.outerPaddingY = 21

local inventory = require('inventory') -- INVENTORY REQUIRED TO SHOW ITEMS INSIDE

function hotbarUI.grid:new(index, offset, scale)
    local baseX = position.x - offset.x * (scale or 1)
    local baseY = position.y - offset.y * (scale or 1)

    local x = baseX + self.outerPaddingX * (scale or 1) + index * (self.slotWidth + self.slotSpacing) * (scale or 1)
    local y = baseY + self.outerPaddingY * (scale or 1)

    return x, y
end

function hotbarUI:draw(scale)
    position = {x = love.graphics.getWidth()/2, y = love.graphics.getHeight() - 15}      -- *POSITION OF HOTBAR
    offset = {x = self.hotbar_sprite:getWidth()/2, y = self.hotbar_sprite:getHeight()/2} -- *OFFSET OF HOTBAR

    position.y = position.y - (offset.y - 20)

    local item_scale = scale * 2.75

    love.graphics.draw(self.hotbar_sprite, position.x, position.y, nil, scale, scale, offset.x, offset.y)

    for slotIndex, item in ipairs(inventory.hotbar) do
        local drawX,drawY = self.grid:new(slotIndex - 1, offset)

        if item and item.texture then
            if item and item.texture then
                item.texture:setFilter('nearest', 'nearest')

                local drawX, drawY = self.grid:new(slotIndex - 1, offset, scale)

                -- Calculate size
                local w = item.texture:getWidth() * item_scale
                local h = item.texture:getHeight() * item_scale

                -- Center inside slot
                local centeredX = drawX + (self.grid.slotWidth - w) / 2
                local centeredY = drawY + (self.grid.slotHeight - h) / 2

                local texW = item.texture:getWidth() * item_scale
                local texH = item.texture:getHeight() * item_scale

                local iconX = drawX + (self.grid.slotWidth * scale - texW) / 2
                local iconY = drawY + (self.grid.slotHeight * scale - texH) / 2

                love.graphics.draw(item.texture, iconX, iconY, nil, item_scale, item_scale)
            end
        end
    end
end

return hotbarUI