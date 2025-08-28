local sti = require('lib.sti')

scenes = {
    ["Garden"] = sti('assets/scenes/garden.lua'),
    ["Stone"] = sti('assets/scenes/stone.lua')
}

scenes.manager = require('assets.scenes.manager')

return scenes