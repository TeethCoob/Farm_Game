-- LIBRARIES
local sti = require('lib.sti')
local windfield = require('lib.windfield')
local anim8 = require('lib.anim8')
local camera = require('lib.camera')
local util = require('util')

-- UTILITY
local loadTexture = util.loadTexture

-- GAME OBJECTS
local player = require('player')
local inventory = require('inventory')
local itemDB = require('data.itemDB')
local gardenScene = sti('assets/scenes/garden.lua')

-- USER INTERFACE
local ui = require('ui')
local hud = ui.hud
local menu = ui.menu

local tile_highlight = loadTexture("assets/textures/tile_highlight.png")
local tile_highlight_position = {
    X = nil,
    Y = nil
}

local camOffset = 7

local tileSize = 32

function love.load()
    -- SETUP CAMERA
    cam = camera()
    cam.scale = 3

    -- WORLD FOR PHYSICS
    world = windfield.newWorld(0,0)

    -- MAKES COLLISION BOX/AREA
    if gardenScene.layers['Collision'] then
        for _, obj in ipairs(gardenScene.layers['Collision'].objects) do
            local collisionArea = world:newRectangleCollider(obj.x,obj.y,obj.width,obj.height)
            collisionArea:setType('static')
        end
    end

    -- LOADS PLAYER
    player:load(world, gardenScene.properties.spawn_location)
end

function love.update(deltaTime)
    world:update(deltaTime)
    player:update(deltaTime)
    gardenScene:update(deltaTime)
    cam:lookAt(player.position.X, player.position.Y + camOffset)

    mouse_positionX, mouse_positionY = love.mouse.getPosition()

    worldX, worldY = cam:worldCoords(mouse_positionX, mouse_positionY)
end

local function getTileGID(map, layerName, tx, ty)
    local layer = map.layers[layerName]
    if not layer or layer.type ~= "tilelayer" then
        return nil
    end

    local tile = layer.data[ty] and layer.data[ty][tx]
    if tile then
        return tile.gid
    end
    return nil
end

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

function love.mousepressed(x, y, button, istouch)

    local tileX = math.floor(worldX / tileSize) + 1
    local tileY = math.floor(worldY / tileSize) + 1

    if player.holding.type == "Hoe" then
        local gid = getTileGID(gardenScene, "Ground", tileX, tileY)
      
        if gid == 1 then
           gardenScene:setLayerTile("Ground", tileX, tileY, 2)
        elseif gid == 2 then
            gardenScene:setLayerTile("Ground", tileX, tileY, 1)
        end
    end
end

function love.keypressed(pressed_key)
    for type, bindings in pairs(keybinds.Keyboard) do
        if type == "Menu" then
            for action, key in pairs(bindings) do
                if pressed_key == key then
                    menu:toggle(action)
                end
            end
        end
    end

    -- DEBUG
    if pressed_key == 'o' then
        inventory:load(itemDB.tools[1]) -- Hoe
    end
    
    if pressed_key:match("%d") then
        inventory.hotbar:changeSelection(pressed_key)
    end

    if pressed_key == 'q' then
        inventory:unload(inventory.hotbar.selection_index, inventory.hotbar)
    end
end

function love.draw()
    cam:attach()
        gardenScene:drawLayer(gardenScene.layers["Ground"])
        gardenScene:drawLayer(gardenScene.layers["FenceFront"])
        player:draw()
        gardenScene:drawLayer(gardenScene.layers["Tree"])
        gardenScene:drawLayer(gardenScene.layers["FenceBack"])
    cam:detach()
    
    local tileX = math.floor(mouse_positionX / tileSize)
    local tileY = math.floor(mouse_positionY / tileSize)

    local worldX = tileX * tileSize
    local worldY = tileY * tileSize

    love.graphics.draw(
        tile_highlight,
        tileX,
        tileY,
        nil,
        2,
        2,
        tile_highlight:getWidth()/2,
        tile_highlight:getHeight()/2
    )
    ui:draw()
end