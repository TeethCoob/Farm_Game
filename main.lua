-- LIBRARIES
local sti = require('lib.sti')
local windfield = require('lib.windfield')
local anim8 = require('lib.anim8')
local camera = require('lib.camera')

-- GAME OBJECTS
local player = require('player')
local inventory = require('inventory')
local itemDB = require('data.itemDB')
local gardenScene = sti('assets/scenes/garden.lua')

-- USER INTERFACE
local ui = require('ui')
local hud = ui.hud
local menu = ui.menu

local tileSize = 32 -- make sure this matches your Tiled map's tile size

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

    local position = {X = 20, Y = 30}

    -- LOADS PLAYER
    player:load(world, gardenScene.properties.spawn_location)
end

function love.update(deltaTime)
    world:update(deltaTime)
    player:update(deltaTime)
    gardenScene:update(deltaTime)
    cam:lookAt(player.position.X,player.position.Y + 7)
end

local keybinds = {
    Keyboard = {
        Menu = {
            Settings    = "escape",
            Inventory   = "e",
            Achievement = "l"
        },
    },
    Mouse = {
        -- Empty for now
    }
}

local tilex = 0
local tiley = 0

function love.mousepressed(x, y, button, istouch)
    local worldX, worldY = cam:worldCoords(x, y)

    local tileX = math.floor(worldX / tileSize) + 1
    local tileY = math.floor(worldY / tileSize) + 1

    if player.holding.type == "Hoe" then
        if gardenScene.layers['Ground'].data[tileX][tileY].gid == 1 then
            gardenScene:setLayerTile("Ground", tileX, tileY, 2)
        else
            print('aa')
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
        inventory:load(itemDB.tools[1])
    end
    
    if pressed_key:match("%d") then
        inventory.hotbar:changeSelection(pressed_key)
    end

    if pressed_key == 'q' then
        inventory:unload(inventory.hotbar.selection_index, inventory.hotbar)
    end

--[[    if pressed_key == 't' then
        gardenScene:setLayerTile("Ground", 1, 1, 2)
    end]]
end

function love.draw()
    cam:attach()
        gardenScene:drawLayer(gardenScene.layers["Ground"])
        gardenScene:drawLayer(gardenScene.layers["FenceFront"])
        player:draw()
        gardenScene:drawLayer(gardenScene.layers["Tree"])
        gardenScene:drawLayer(gardenScene.layers["FenceBack"])
        love.graphics.rectangle("line", tilex, tiley, 5, 5)
    cam:detach()
    ui:draw()
end