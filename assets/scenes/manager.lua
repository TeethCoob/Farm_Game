local sceneManager = {}

sceneManager.currentScene = scenes["Garden"]

function sceneManager:init_collision()
    if self.currentScene.layers['Map Collision'] then
        for _, obj in ipairs(self.currentScene.layers['Map Collision'].objects) do
            local collisionArea = world:newCollider("Rectangle", {obj.x + obj.width / 2,obj.y + obj.height / 2,obj.width,obj.height})
            collisionArea:setType('static')
        end
    end
end

function sceneManager:load(scene_name)
    self.currentScene = scenes[scene_name]
    self:init_collision()
end

return sceneManager