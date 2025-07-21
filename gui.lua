gui = {
    hud = {
        { -- HOTBAR
            sprite = love.graphics.newImage('assets/textures/gui/hud/hotbar.png'),
            position = { x = function() return love.graphics.getWidth()/2 end, y = function() return love.graphics.getHeight()/2 * 1.97 end},
            offset = {x = 354, y = 88},
            scale = .7
        },
    },
    menu = {
        { -- INVENTORY
            sprite = love.graphics.newImage('assets/textures/gui/menu/inventory.png'),
            position = {x = function() return love.graphics.getWidth()/2 end, y = function() return love.graphics.getHeight()/2 end},
            offset = {x = 94.5, y = 67},
            scale = 3.5,
            visible = false
        }
    }
}

function gui:toggle(ui)
    ui.visible = not ui.visible
end

function gui:draw()
    -- DISPLAY'S HUD
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

    -- DISPLAY'S MENU
    for _, elements in ipairs(self.menu) do
        local posX = elements.position.x()
        local posY = elements.position.y()

        if elements.visible then
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
end

return gui