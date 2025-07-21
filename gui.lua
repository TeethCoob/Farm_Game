gui = {
    hud = {
        hotbar = {
            sprite = love.graphics.newImage('assets/textures/gui/hotbar.png'),
            position = {x = 0,0}
        }
    },
    popUp = {}
}

function gui:draw()
    for _, k in ipairs(self.hud) do
        for z, v in ipairs(k) do
            love.graphics.draw(v.sprite, v.position.x, v.position.y)
        end
    end

     love.graphics.draw(self.hud.hotbar.sprite,self.hud.hotbar.position.x,self.hud.hotbar.position.y)

    print('test')
end

return gui