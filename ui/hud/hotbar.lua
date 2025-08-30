-- #ID 1
local hotbarUI = {}

local util = require('util')
local inventory = require('inventory')

local loadTexture = util.loadTexture

local hotbar = inventory.hotbar

-- PROPERTIES
hotbarUI.sprite = loadTexture('assets/textures/ui/hud/hotbar.png')
hotbarUI.selection_outline_sprite = love.graphics.newImage('assets/textures/ui/hud/hotbar_selection_outline.png')
hotbarUI.position = {}
hotbarUI.scale = 0.7
hotbarUI.scale_offset = {
    X = hotbarUI.sprite:getWidth()/2,
    Y = hotbarUI.sprite:getHeight()/2
}
hotbarUI.selection_outline_scale = 0.7
hotbarUI.selection_outline_scale_offset = {
    X = hotbarUI.selection_outline_sprite:getWidth()/2,
    Y = hotbarUI.selection_outline_sprite:getHeight()/2
}
hotbarUI.grid = {
    gap                    = 54,
    item_scale             = 2,
    item_scale_offset      = {},
    origin_position        = {},
    origin_position_offset = {
        X = 1,
        Y = 3
    }
}

function hotbarUI:draw()
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()

    self.position.X = screenW / 2
    self.position.Y = screenH * 0.95
    
    self.grid.origin_position.X = self.position.X - self.sprite:getWidth()/3.25
    self.grid.origin_position.Y = self.position.Y
    
    -- SETS OFFSET TO GRID'S ORIGIN POSITION FOR ELEMENTS
    self.grid.origin_position.X = self.grid.origin_position.X + self.grid.origin_position_offset.X
    self.grid.origin_position.Y = self.grid.origin_position.Y + self.grid.origin_position_offset.Y

    local main = love.graphics.draw(
        self.sprite,
        self.position.X,
        self.position.Y,
        nil,
        self.scale,
        self.scale,
        self.scale_offset.X,
        self.scale_offset.Y
    )

    for _rowIndex, item in ipairs(hotbar) do
        if item.texture then
            _rowIndex = _rowIndex - 1 -- MAKES INDEX ARRAY TO START FROM 0

            local texture = item.texture

            local item_column_position = self.grid.origin_position.X + self.grid.gap * _rowIndex

            self.grid.item_scale_offset.X = texture:getWidth()/2
            self.grid.item_scale_offset.Y = texture:getHeight()/2

            local draw_item_texture = love.graphics.draw(
                texture,
                item_column_position,
                self.grid.origin_position.Y,
                nil,
                self.grid.item_scale,
                self.grid.item_scale,
                self.grid.item_scale_offset.X,
                self.grid.item_scale_offset.Y
            )
        end
    end
    
    local hotbarSelectionIndex = hotbar.selectionIndex - 1
    local selection_outline_row_position = self.grid.origin_position.X + self.grid.gap * hotbarSelectionIndex

    local selection_outline = love.graphics.draw(
        self.selection_outline_sprite,
        selection_outline_row_position,
        self.position.Y,
        nil,
        self.selection_outline_scale,
        self.selection_outline_scale,
        self.selection_outline_scale_offset.X,
        self.selection_outline_scale_offset.Y
    )
end

return hotbarUI