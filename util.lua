util = {}

function clamp(a,b,c) assert(a and b and c, "not very useful error message here") return math.min(math.max(a, b), c) end

function util.loadTexture(path)
    if path then
        local texture = love.graphics.newImage(path)
        texture:setFilter('nearest')

        return texture
    end
end

math.clamp = clamp

return util