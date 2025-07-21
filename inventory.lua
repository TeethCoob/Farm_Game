inventory = {
    main = {},
    htb = {},
}

function inventory:new() -- INITIALIZES INVENTORY
    for i = 1, 27 do self.main[i] = '_' end -- SETS SLOTS FOR INVENTORY
    for i = 1, 9 do self.htb[i] = '_' end   -- SETS SLOTS FOR HOTBAR

    self.holding = self.htb[1]
end

local function manyEmptySlot(tbl) -- COUNTS HOW MANY EMPTY SLOTS ARE IN THE TABLE
    local count = 0
    for _, v in ipairs(tbl) do
        if v == '_' then
            count = count + 1
        end
    end
    return count
end

local function findFirstEmptySlot(tbl) -- FINDS THE FIRST EMPTY SLOT IN THE TABLE
    local index = 0
    for _, v in ipairs(tbl) do
        index = index + 1
        if v == '_' then
           break
        end
    end
    return index
end

function inventory:changeHotbar(key)
    local numPressedKey = tonumber(key)
    if numPressedKey and numPressedKey >= 1 and numPressedKey <= 9 then
        self.holding = self.htb[numPressedKey]
        if self.holding.name then
            print('You are holding: ' .. self.holding.name)
        else
            print('You are not holding anything')
        end
    end
end

function inventory:load(item)
    local mainEmptySlots = manyEmptySlot(self.main)
    local htbEmptySlots = manyEmptySlot(self.htb)

    if htbEmptySlots > 0 then
        local index = findFirstEmptySlot(self.htb)
        self.htb[index] = item
        print('Loaded item: ' .. item.name .. ' into hotbar slot ' .. index)
    elseif mainEmptySlots > 0 then
        local index = findFirstEmptySlot(self.main)
        self.main[index] = item
        print('Loaded item: ' .. item.name .. ' into inventory slot ' .. index)
    else
        return
    end
end

function inventory:unload(id,from)
    from[id] = '_'
    print('Unloaded item from slot ' .. id)
end

function inventory:move(item, targetTo)
    
end

function inventory:debug()
    print('Items in inventory:')
    for _, v in ipairs(self.main) do
        print(v.name or tostring(v))
    end
    print('Items in hotbar:')
    for _, v in ipairs(self.htb) do
        print(v.name or tostring(v))
    end
end


return inventory
