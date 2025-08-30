local util = {}

local function clamp(a,b,c)
    return math.min(math.max(a, b), c)
end

math.clamp = clamp

function util.loadTexture(path)
    if path then
        local texture = love.graphics.newImage(path)
        texture:setFilter('nearest')

        return texture
    end
end

return util