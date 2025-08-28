local itemDB = {}

local util = require('util')

local loadTexture = util.loadTexture

itemDB.tools = require('data.itemDB.tools')
itemDB.seeds = require('data.itemDB.seeds')
itemDB.wearables = require('data.itemDB.wearables')

local container = {
    itemDB.tools,
    itemDB.seeds,
    itemDB.wearables
}

-- Loads Items Texture Because Nono On Database
for _, categoryChild in ipairs(container) do
    for _, item in ipairs(categoryChild) do
        local texture = loadTexture(item.texture)
        item.texture = texture
    end
end

return itemDB