gui = {
    hud = {
        hotbar = {
            sprite = love.graphics.newImage('assets/textures/gui/hotbar.png'),
            position = {x = love.graphics.getWidth()/2,y = love.graphics.getHeight()/2},
            offset = {x = 354, y = 88},
            scale = 0.7
        }
    }
}

function gui:draw()
    for _, elements in pairs(self.hud) do
        for _, properties in pairs(elements) do
            love.graphics.draw(properties.sprite,properties.position.x,properties.position.y,nil,properties.scale,properties.scale,properties.offset.x,properties.offset.y)
        end
    end
end

return gui