-- #ID 1
local inventoryUI = {}

local util = require('util')
local inventory = require('inventory')

local loadTexture = util.loadTexture

local DEFAULT_INDEX = -1

-- PROPERTIES
inventoryUI.sprite = loadTexture('assets/textures/ui/menu/inventory.png')
inventoryUI.visible = true
inventoryUI.position = {}
inventoryUI.scale = 6
inventoryUI.scale_offset = {
    X = inventoryUI.sprite:getWidth()/2,
    Y = inventoryUI.sprite:getHeight()/2
}
inventoryUI.grid = {
    gap                    = {
        X = 193,
        Y = 167
    },
    row                    = inventory.main.row,
    column                 = inventory.main.column,
    item_scale             = 3.5,
    item_scale_offset      = {},
    origin_position        = {},
    origin_position_offset = {
        X = -289,
        Y = 12
    }
}

function inventoryUI:draw()
    self.position.X = love.graphics.getWidth()/2
    self.position.Y = love.graphics.getHeight()/2

    if self.visible then
        local draw_inventory_background = love.graphics.draw(
            self.sprite,
            self.position.X,
            self.position.Y,
            nil,
            self.scale,
            self.scale,
            self.scale_offset.X,
            self.scale_offset.Y
        )

        for _rowIndex, row in ipairs(inventory.main) do
            _rowIndex = _rowIndex - 1
            for _columnIndex, item in ipairs(row) do
                if item.texture then
                    -- MAKES INDEX ARRAY TO START FROM 0
                    _columnIndex = _columnIndex - 1

                    local texture = item.texture

                    --SETS OFFSET TO GRID'S ORIGIN POSITION FOR ELEMENTS
                    self.grid.origin_position.X = self.position.X + self.grid.origin_position_offset.X
                    self.grid.origin_position.Y = self.position.Y + self.grid.origin_position_offset.Y
                    
                    self.grid.item_scale_offset.X = texture:getWidth()/2
                    self.grid.item_scale_offset.Y = texture:getHeight()/2

                    local item_row_position = self.grid.origin_position.Y + self.grid.gap.Y * _rowIndex
                    local item_column_position = self.grid.origin_position.X + self.grid.gap.X * _columnIndex

                    local draw_item_texture = love.graphics.draw(
                        texture,
                        item_column_position,
                        item_row_position,
                        nil,
                        self.grid.item_scale,
                        self.grid.item_scale,
                        self.grid.item_scale_offset.X,
                        self.grid.item_scale_offset.Y
                    )
                end
            end
        end
    end
end

return inventoryUI