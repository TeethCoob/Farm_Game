local inventory = {
    main    = {},
    hotbar  = {},
}

-- SETTINGS
inventory.main.row      = 2
inventory.main.column   = 4
inventory.hotbar.column = 9

local empty = ' '

local player

function inventory:init(client) -- INITIALIZES INVENTORY
    for i = 1, self.main.row do self.main[i] = {} for k = 1, self.main.column do self.main[i][k] = empty end end -- SETS SLOTS FOR MAIN
    for i = 1, 9 do self.hotbar[i] = empty end                                        -- SETS SLOTS FOR HOTBAR

    player = client
    self.hotbar.selectionIndex = 1
    player.holding = self.hotbar[self.hotbar.selectionIndex]
end

function inventory.hotbar:changeSelection(key)
    local numPressedKey = tonumber(key)

    if numPressedKey and numPressedKey >= 1 and numPressedKey <= 9 then
        self.selectionIndex = numPressedKey
        player.holding = self[self.selectionIndex]

        if player.holding.name then
            print('You are holding: ' .. player.holding.name)
        else
            print('You are not holding anything')
        end
    end
end

function inventory:load(item)

    local function findFirstEmptySlot() -- FINDS THE FIRST EMPTY SLOT IN A TABLE
        local indexHotbar        = 0
        local columnIndexMain    = 0
        local rowIndexMain       = 0

        for index, slot in ipairs(self.hotbar) do
            if slot == empty then
                indexHotbar = index
                break
            end
        end

        for rowIndex, row in ipairs(self.main) do
            for columnIndex, column in ipairs(row) do
                if column == empty then
                    rowIndexMain    = rowIndex
                    columnIndexMain = columnIndex
                    break
                end
            end
        end

        return indexHotbar, rowIndexMain, columnIndexMain
    end

    local function arrayEmptySlot()
        local hotbarEmptySlots  = 0
        local mainRowEmptySlots = 0

        for _, hotbarSlot in ipairs(self.hotbar) do
            if hotbarSlot == empty then
                hotbarEmptySlots = hotbarEmptySlots + 1
            end
        end

        for _, mainRow in ipairs(self.main) do
            for _, mainColumn in ipairs(mainRow) do
                if mainColumn == empty then
                    mainRowEmptySlots = mainRowEmptySlots + 1
                end
            end
        end

        return hotbarEmptySlots, mainRowEmptySlots
    end

    local hotbarEmptySlots, mainEmptySlots = arrayEmptySlot()
    local hotbarIndex, mainRowIndex, mainColumnIndex = findFirstEmptySlot()

    if hotbarEmptySlots > 0 then
        self.hotbar[hotbarIndex] = item

        if self.hotbar.selectionIndex == hotbarIndex then
            player.holding = self.hotbar[hotbarIndex]
        end

        print('Loaded item: ' .. item.name .. ' into hotbar slot ' .. hotbarIndex)
    elseif mainEmptySlots > 0 then
        self.main[mainRowIndex][mainColumnIndex] = item

        print('Loaded item: ' .. item.name .. ' into inventory slot row ' .. mainRowIndex .. ' column ' .. mainColumnIndex)
    else
        return
    end
end

function inventory:unload(id,from,method)
    -- Optionally store the item being removed
    local removedItem = from[id]

    -- Clear the slot
    from[id] = empty

    -- Clear holding if the removed item is the one being held
    if from == self.hotbar and player.holding == removedItem then
        player.holding = empty
        print("[Inventory] Cleared held item.")
    end

    print('Unloaded item from slot ' .. id)
end

function inventory:move(item, targetTo)
    
end

function inventory:debug()

    for i = 1, 50 do
        print(' ')
    end

    print('Items in inventory:')

    for _, row in ipairs(self.main) do
        local mainItems = {}

        for _, item in ipairs(row) do
            table.insert(mainItems, item.name or item)
        end

        print(table.concat(mainItems, ' | '))
    end

    for i = 1, 3 do
        print('')
    end

    print('Items in hotbar:')

    local hotbarItems = {}

    for _, item in ipairs(self.hotbar) do
        table.insert(hotbarItems, item.name or item)
    end

    print(table.concat(hotbarItems, ' | '))
end

return inventory
