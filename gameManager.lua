local gameManager = {}

local breezefield = require('lib.breezefield')
local camera = require('lib.camera')

local scenes = require('assets.scenes')
local ui = require('ui')
local player = require('player')

local sceneManager = scenes.manager

-- CAMERA SETTINGS
local cam_scale = 3
local cam_offset = {
    X = 0,
    Y = 7
}

function gameManager:load()
    cam = camera()
    cam.scale = cam_scale

    world = breezefield.newWorld(0, 0)

    -- Load initial scene
    sceneManager:load("Garden")

    local currentScene = sceneManager.currentScene
    mapTileSize = currentScene.tilewidth

    local mapSpawnLocation = {
        X = currentScene.layers["Spawn Location"].objects[1].x,
        Y = currentScene.layers["Spawn Location"].objects[1].y
    }

    player:load(world, mapSpawnLocation)
end

function gameManager:update(deltaTime)
    world:update(deltaTime)
    player:update(deltaTime)

    local currentScene = sceneManager.currentScene
    currentScene:update(deltaTime)

    -- Camera follows player
    local cam_origin_position = {X = player.position.X, Y = player.position.Y}
    cam:lookAt(cam_origin_position.X, cam_origin_position.Y + cam_offset.Y)

    mouse_positionX, mouse_positionY = cam:mousePosition()
    love_mouse_positionX, love_mouse_positionY = love.mouse.getPosition()
    worldX, worldY = cam:worldCoords(love_mouse_positionX, love_mouse_positionY)
end

function gameManager:draw()
    local currentScene = sceneManager.currentScene

    cam:attach()
        local tileX = math.floor(mouse_positionX / mapTileSize)
        local tileY = math.floor(mouse_positionY / mapTileSize)

        local worldX = tileX * mapTileSize
        local worldY = tileY * mapTileSize

        currentScene:drawLayer(currentScene.layers["Ground"])
        -- currentScene:drawLayer(currentScene.layers["Plants"])
        -- currentScene:drawLayer(currentScene.layers["FenceFront"])
        if player.holding.type == "hoe" or player.holding.type == "seed" then
            love.graphics.rectangle("line", worldX, worldY, 32, 32)
        end
        player:draw()
        -- currentScene:drawLayer(currentScene.layers["Tree"])
        -- currentScene:drawLayer(currentScene.layers["FenceBack"])
    cam:detach()
 
    ui:draw()
end

function gameManager:changeScene(scene_name)
    -- clear world before loading new scene
    for _, body in ipairs(world:getBodies()) do
        body:destroy()
    end

    -- load new scene
    sceneManager:load(scene_name)

    -- reset spawn location
    local currentScene = sceneManager.currentScene
    local mapSpawnLocation = {
        X = currentScene.layers["Spawn Location"].objects[1].x,
        Y = currentScene.layers["Spawn Location"].objects[1].y
    }

    player:load(world, mapSpawnLocation)
    print("Switched to scene:", scene_name)
end


return gameManager
