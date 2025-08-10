-- #ID 1
local inventoryUI = {}

-- PROPERTIES
inventoryUI.sprite = love.graphics.newImage('assets/textures/ui/menu/inventory.png')
inventoryUI.test_sprite = love.graphics.newImage('assets/textures/gears/shoe.png')
inventoryUI.visible = false
inventoryUI.offset = {X = inventoryUI.sprite:getWidth()/2, Y = inventoryUI.sprite:getHeight()/2}

inventoryUI.grid = {}
inventoryUI.grid.offset = -60
inventoryUI.grid.padding = 115

inventoryUI.sprite:setFilter('nearest', 'nearest') -- SETS IMAGE FROM BLURRY TO PIXELATED

local inventory = require('inventory')
local test_sprite_item = love.graphics.newImage('assets/textures/gears/SHOE.png')

-- Configurable relative values (percentages)
local SLOT_SCALE_PERCENT = 0.05   -- slot size relative to screen height
local PADDING_PERCENT = 0.01      -- padding between slots (relative to screen width)
local GRID_OFFSET_X_PERCENT = 0.02
local GRID_OFFSET_Y_PERCENT = 0.02

function inventoryUI:draw(scale)
    local screenW, screenH = love.graphics.getDimensions()
    self.position = {X = screenW / 2, Y = screenH / 2}

    -- Scale sprite relative to screen height
    local baseScale = (screenH * SLOT_SCALE_PERCENT) / self.sprite:getHeight()
    scale = scale or baseScale

    if self.visible then
        -- Draw inventory background centered
        love.graphics.draw(
            self.sprite,
            self.position.X,
            self.position.Y,
            nil,
            scale,
            scale,
            self.offset.X,
            self.offset.Y
        )

        -- Calculate grid starting position
        local startX = self.position.X - (self.sprite:getWidth() * scale / 2) + (screenW * GRID_OFFSET_X_PERCENT)
        local startY = self.position.Y - (self.sprite:getHeight() * scale / 2) + (screenH * GRID_OFFSET_Y_PERCENT)

        -- Slot size & padding
        local slotSize = screenH * SLOT_SCALE_PERCENT
        local padding = screenW * PADDING_PERCENT

        -- Draw items
        for rowIndex, mainRow in ipairs(inventory.main) do
            for colIndex, item in ipairs(mainRow) do
                local columnPosition = startX + (colIndex - 1) * (slotSize + padding)
                local rowPosition = startY + (rowIndex - 1) * (slotSize + padding)

                if item and item.texture then
                    item.texture:setFilter('nearest', 'nearest')
                    love.graphics.draw(
                        item.texture,
                        columnPosition,
                        rowPosition,
                        nil,
                        slotSize / item.texture:getWidth(), -- dynamic scaling to fit slot
                        slotSize / item.texture:getHeight()
                    )
                end
            end
        end
    end
end


return inventoryUI