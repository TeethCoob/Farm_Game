-- LIBRARIES
local sti = require('lib.sti')
local windfield = require('lib.windfield')
local anim8 = require('lib.anim8')
local camera = require('lib.camera')

-- GAME OBJECTS
local player = require('player')
local inventory = require('inventory')
local item = require('item')
local gardenScene = sti('assets/scenes/garden/garden.lua')

-- USER INTERFACE
local ui = require('ui')
local hud = ui.hud
local menu = ui.menu

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
    cam:lookAt(player.position.X,player.position.Y + 7)
end

local keybinds = {
    ["Keyboard"] = {
        ["Menu"] = {
            ["Settings"   ]  = "escape";
            ["Inventory"  ]  = "e"     ;
            ["Achievement"]  = "l"
        },
        ["Debugging"] = {
            ["inventory:debug()"] = "b" ;
        }
    },
    ["Mouse"]    = {

    }
}

function love.mousepressed()
    local 
end

function love.keypressed(pressed_key)

    for _, types in ipairs(keybinds) do
        
    end
    
    if key:match('%d') then
        inventory.hotbar:changeSelection(key)
    end

    if key == 'o' then
        inventory:load(item.Gear.Tool[1]) -- Load the first weapon item
    end

    if key == 'i' then
        inventory:unload(inventory.hotbar.selection_index,inventory.hotbar)
    end

    if key == 'u' then
        inventory:move(3, 'htb')
    end

    if key == 'e' then
        menu:toggle("INVENTORY")
    end

    if key == 'b' then
        inventory:debug()
    end

    if key == 'q' then
        for o, row in ipairs(inventory.main) do
            for i, column in ipairs(row) do
                inventory.main[o][i] = ' '
            end
        end
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
    ui:draw(player)
end