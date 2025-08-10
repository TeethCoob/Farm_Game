-- #ID 1
local hotbarUI = {}

local util = require('util')
local inventory = require('inventory')

local loadTexture = util.loadTexture

local hotbar = inventory.hotbar

-- PROPERTIES
hotbarUI.sprite = loadTexture('assets/textures/ui/hud/hotbar.png')
hotbarUI.selection_sprite = loadTexture('assets/textures/ui/hud/hotbar_selection.png')
hotbarUI.position = {}
hotbarUI.scale = 0.7
hotbarUI.scale_offset = {
    X = hotbarUI.sprite:getWidth()/2,
    Y = hotbarUI.sprite:getHeight()/2
}
hotbarUI.grid = {
    padding                = 54,
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

    love.graphics.draw(self.sprite, self.position.X, self.position.Y, nil, self.scale, self.scale, self.scale_offset.X, self.scale_offset.Y)

    for row, item in ipairs(hotbar) do
        if item.texture then
            row = row - 1

            self.grid.origin_position.X = self.position.X - self.sprite:getWidth()/3.25
            self.grid.origin_position.Y = self.position.Y

            self.grid.origin_position.X = self.grid.origin_position.X + self.grid.origin_position_offset.X
            self.grid.origin_position.Y = self.grid.origin_position.Y + self.grid.origin_position_offset.Y

            local row_position = self.grid.origin_position.X + self.grid.padding * row

            self.grid.item_scale_offset.X = item.texture:getWidth()/2
            self.grid.item_scale_offset.Y = item.texture:getHeight()/2

            love.graphics.draw(
                item.texture,
                row_position,
                self.grid.origin_position.Y,
                nil, self.grid.item_scale, self.grid.item_scale,
                self.grid.item_scale_offset.X,
                self.grid.item_scale_offset.Y
            )
        end
    end
end

return hotbarUI