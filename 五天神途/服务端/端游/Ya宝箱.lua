local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/logic_def_lua")


local items = {
    {"冰龙战靴", 50},
    {"冰龙战戒", 50},
    {"冰龙战镯", 50},
    {"冰龙战带", 50},
    {"冰龙战盔", 50},
    {"冰龙魔镯", 50},
    {"冰龙魔戒", 50},
    {"冰龙魔带", 50},
    {"冰龙魔盔", 50},
    {"冰龙魔靴", 50},
    {"冰龙道镯", 50},
    {"冰龙道戒", 50},
    {"冰龙道带", 50},
    {"冰龙道盔", 50},
    {"冰龙道靴", 50},
    {"冰龙神甲", 50},
    {"冰龙神袍", 50},
    {"冰龙战刃", 50},

    {"完美战靴", 1},
    {"完美战戒", 1},
    {"完美战镯", 1},
    {"完美战带", 1},
    {"完美战盔", 1},
    {"完美魔镯", 1},
    {"完美魔戒", 1},
    {"完美魔带", 1},
    {"完美魔盔", 1},
    {"完美魔靴", 1},
    {"完美道镯", 1},
    {"完美道戒", 1},
    {"完美道带", 1},
    {"完美道盔", 1},
    {"完美道靴", 1},
    {"完美神甲", 1},
    {"完美神袍", 1},
    {"完美战刃", 1},
}

function main(player, item)
    local allWeights = 0
    for i,v in pairs(items) do
        allWeights = allWeights + v[2]
    end
    local rnd = math.random(1, allWeights)
    local tempWeight = 0
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player, "您的包裹不足1格！")
        return false
    end

    for i=1, #items do
        tempWeight = tempWeight + items[i][2]
        if rnd <= tempWeight then
            if not lualib:AddItem(player, items[i][1], 1, false, "给物品：开启宝箱", "Ya宝箱") then
                lualib:Error("神秘宝盒给物品失败！")
                return false
            end
            lualib:SysMsg_SendBroadcastMsg("恭喜玩家【"..lualib:KeyName(player) .."】开启宝箱活动中获得宝箱获得【"..lualib:KeyName(items[i][1]).."】","激情宝箱")
            lualib:DelItem(player, lualib:KeyName(item), 1, 2, "开启宝箱", "Ya宝箱")
            return true
        end
    end


end


