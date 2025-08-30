local controller = {}

local gameManager = require('gameManager')
local sceneManager = require('assets.scenes.manager')
local itemDB = require('data.itemDB')

local player = require('player')
local inventory = require('inventory')

local currentScene = sceneManager.currentScene
local tileSize = currentScene.tilewidth

local keybinds = {
    Keyboard = {
        Menu = {
            Settings    = "escape",
            Inventory   = "e",
            Achievement = "l"
        },
        Action = {
            Jump = "Space"
        }
    },
    Mouse = {
        -- Empty for now
    }
}

local function getTileGID(map, layerName, tx, ty)
    local layer = map.layers[layerName]

    if not layer or layer.type ~= "tilelayer" then
        local layer = map.layers[layerName]
        return nil
    end

    local tile = layer.data[ty] and layer.data[ty][tx]
    if tile then
        return tile.gid
    end
    return nil
end

function controller:mouseMapping(x, y, button)
    local leftClick = 1

    local tileX = math.floor(worldX / tileSize) + 1
    local tileY = math.floor(worldY / tileSize) + 1

    -- "cl" MEANS CLICKED LAYER
    local cl_groundGID = getTileGID(currentScene, "Ground", tileX, tileY)

    local grassGID = 1
    local farmlandGID = 2

    local cornGID = 11
    local nothingGID = 16

    if button == leftClick then
        if player.holding.type == "hoe" then
            if cl_groundGID == grassGID then
                currentScene:setLayerTile("Ground", tileX, tileY, farmlandGID)
            elseif cl_groundGID == farmlandGID then
                currentScene:setLayerTile("Plants", tileX, tileY, nothingGID)
                currentScene:setLayerTile("Ground", tileX, tileY, grassGID)
                print("replace 2 by 1")
            end
        end

        if player.holding.type == "seed" then
            if cl_groundGID == farmlandGID then
                currentScene:setLayerTile("Plants", tileX, tileY, 11)
                currentScene.layers["Plants"].data[tileX][tileY].properties.type = "planted_crop"
                print(currentScene.layers["Plants"].data[tileX][tileY].properties.type)
            end
        end
    else
        print('right')
    end
end

function controller:keyMapping(pressedKey)
    for type, bindings in pairs(keybinds.Keyboard) do
        if type == "Menu" then
            for action, key in pairs(bindings) do
                if pressedKey == key then
                    menu:toggle(action)
                end
            end
        end
    end

    --------------------- DEBUG ---------------------
    if pressedKey == 'b' then
        gameManager:changeScene("Stone")
    end

    if pressedKey == 'o' then
        inventory:load(itemDB.tools[1]) -- Hoe
    end

    if pressedKey == 'u' then
        inventory:load(itemDB.seeds[1])
    end

    if pressedKey:match("%d") then
        inventory.hotbar:changeSelection(pressedKey)
    end

    if pressedKey == 'q' then
        inventory:unload(inventory.hotbar.selectionIndex, inventory.hotbar)
    end
    -------------------------------------------------
end

return controller
