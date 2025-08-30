local gameManager = {}

local breezefield = require('lib.breezefield')
local camera = require('lib.camera')

local scenes = require('assets.scenes')
local ui = require('ui')
local player = require('player')

local sceneManager = scenes.manager

-- CAMERA SETTINGS
local CamScale = 3
local CamOffset = {
    X = 0,
    Y = 7
}

function gameManager:load()
    cam = camera()
    cam.scale = CamScale

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
    local camOriginPosition = {X = player.position.X, Y = player.position.Y}
    cam:lookAt(camOriginPosition.X, camOriginPosition.Y + camOffset.Y)

    mousePositionX, mousePositionY = cam:mousePosition()
    loveMousePositionX, loveMousePositionY = love.mouse.getPosition()
    worldX, worldY = cam:worldCoords(loveMousePositionX, loveMousePositionY)
end

local function drawOutlineSelection(x, y)
    local outlineSize = 32

    if player.holding.type == "hoe" or player.holding.type == "seed" then
        love.graphics.rectangle("line", x, y, outlineSize, outlineSize)
    end
end


function gameManager:draw()
    local currentScene = sceneManager.currentScene

    cam:attach()
        local tileX = math.floor(mousePositionX / mapTileSize)
        local tileY = math.floor(mousePositionY / mapTileSize)

        local worldX = tileX * mapTileSize
        local worldY = tileY * mapTileSize

        currentScene:drawLayer(currentScene.layers["Ground"])
        currentScene:drawLayer(currentScene.layers["Plants"])
        currentScene:drawLayer(currentScene.layers["FenceFront"])
        drawOutlineSelection(worldX, worldY)
        player:draw()
        currentScene:drawLayer(currentScene.layers["Tree"])
        currentScene:drawLayer(currentScene.layers["FenceBack"])
    cam:detach()

    ui:draw()
end

function gameManager:changeScene(sceneName)
    -- clear world before loading new scene
    for _, body in ipairs(world:getBodies()) do
        body:destroy()
    end

    -- load new scene
    sceneManager:load(sceneName)

    -- reset spawn location
    local currentScene = sceneManager.currentScene
    local mapSpawnLocation = {
        X = currentScene.layers["Spawn Location"].objects[1].x,
        Y = currentScene.layers["Spawn Location"].objects[1].y
    }

    player:load(world, mapSpawnLocation)
    print("Switched to scene:", sceneName)
end


return gameManager
