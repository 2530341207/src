local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local zhuangbei = {
    "头盔",
    "项链",
    "手镯",
    "戒指",
    "腰带",
    "鞋子",
    "衣服",
    "武器"
}

function main(player, item)
    local num = lualib:GetInt(player,"zhuangbei")
    for i = 1,#zhuangbei do
        lualib:AddItem(player,zhuangbei[i]..i,1,false,"装备","装备")
    end
    return
end
