local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local zhuangbei = {
    "ͷ��",
    "����",
    "����",
    "��ָ",
    "����",
    "Ь��",
    "�·�",
    "����"
}

function main(player, item)
    local num = lualib:GetInt(player,"zhuangbei")
    for i = 1,#zhuangbei do
        lualib:AddItem(player,zhuangbei[i]..i,1,false,"װ��","װ��")
    end
    return
end
