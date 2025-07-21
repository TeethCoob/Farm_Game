gui = {
    hud = {},
    popUp = {},
}

function gui:draw()
    for _, k in pairs(self.hud) do
        for z, v in pairs(k) do
            love.graphics.draw(k.sprite, k.position.x, k.position.y, nil, k.scale, k.scale, k.sprite:getWidth() / 2, k.sprite:getHeight() / 2)
        end
    end

    for _, k in pairs(self.popUp) do
        for z, v in pairs(k) do
            love.graphics.draw(k.sprite, k.position.x, k.position.y)
        end
    end

end

return gui