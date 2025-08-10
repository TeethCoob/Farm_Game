local settings = {}

-- PROPERTIES
settings.visible = false

function settings:draw()
    if self.visible == true then
        love.graphics.print("Settings")
    end
end

return settings