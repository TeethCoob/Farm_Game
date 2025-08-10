local util = require('util')
local loadTexture = util.loadTexture

return {
    Gear = {
        Tool = {
            {name = "Shoe", durability = 120, texture = loadTexture('assets/textures/gears/SHOE.png')}
        },
        Weapon = {
            {name = "     Long Lost Sword     ", damage = 10, rarity = "Common", texture = loadTexture('assets/textures/ui/hud/hotbar_selection.png')},    -- ID#1
            {name = "Pedang Joki Kan Jokes Tir", damage = 20, rarity = "Mythic", }                           -- ID#2
        },
        Armour = {
            {name = "Long Lost Helmet", protDmg = 3.5,}
        }
    },
    Spell = {
        
    }
}