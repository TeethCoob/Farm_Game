function love.load()
    image = love.graphics.newImage("assets/textures/ui/hud/hotbar.png")

    slotCount = 9
    slotWidth = 64
    slotHeight = 64
    slotSpacing = 13.5
    outerPaddingX = 12
    outerPaddingY = 12
end

function setGrid(i)
    local x = imageX + outerPaddingX + i * (slotWidth + slotSpacing)
    local y = imageY + outerPaddingY

    print(x,y)

    return x, y
end

function love.draw()
    imageX = love.graphics.getWidth()/2 -- screen position
    imageY = love.graphics.getHeight()/2 + 100

    -- Draw the image
    love.graphics.draw(image, imageX, imageY, nil, 1, 1, image:getWidth()/2, image:getHeight()/2)

    -- Set red semi-transparent lines
    love.graphics.setColor(1, 0, 0, 0.5)

    for i = 0, slotCount - 1 do
        local x,y = setGrid(i)
        love.graphics.rectangle("line", x - image:getWidth()/2, y - image:getHeight()/2, slotWidth, slotHeight)
    end

    love.graphics.setColor(1, 1, 1, 1) -- reset
end
