gui = {
    hud = {
        { -- HOTBAR
            sprite = love.graphics.newImage('assets/textures/gui/hotbar.png'),
            position = { x = function() return love.graphics.getWidth()/2 end ,y = function() return love.graphics.getHeight()/2 * 1.97 end},
            offset = {x = 354, y = 88},
            scale = .7
        },
    }
}

function gui:draw()
    for _, elements in ipairs(self.hud) do
        local posX = elements.position.x()
        local posY = elements.position.y()

        love.graphics.draw(
            elements.sprite,
            posX,
            posY,
            nil,
            elements.scale,
            elements.scale,
            elements.offset.x,
            elements.offset.y
        )
    end
end

return gui