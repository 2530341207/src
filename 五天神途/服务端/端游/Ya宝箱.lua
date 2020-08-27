local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/logic_def_lua")


local items = {
    {"����սѥ", 50},
    {"����ս��", 50},
    {"����ս��", 50},
    {"����ս��", 50},
    {"����ս��", 50},
    {"����ħ��", 50},
    {"����ħ��", 50},
    {"����ħ��", 50},
    {"����ħ��", 50},
    {"����ħѥ", 50},
    {"��������", 50},
    {"��������", 50},
    {"��������", 50},
    {"��������", 50},
    {"������ѥ", 50},
    {"�������", 50},
    {"��������", 50},
    {"����ս��", 50},

    {"����սѥ", 1},
    {"����ս��", 1},
    {"����ս��", 1},
    {"����ս��", 1},
    {"����ս��", 1},
    {"����ħ��", 1},
    {"����ħ��", 1},
    {"����ħ��", 1},
    {"����ħ��", 1},
    {"����ħѥ", 1},
    {"��������", 1},
    {"��������", 1},
    {"��������", 1},
    {"��������", 1},
    {"������ѥ", 1},
    {"�������", 1},
    {"��������", 1},
    {"����ս��", 1},
}

function main(player, item)
    local allWeights = 0
    for i,v in pairs(items) do
        allWeights = allWeights + v[2]
    end
    local rnd = math.random(1, allWeights)
    local tempWeight = 0
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player, "���İ�������1��")
        return false
    end

    for i=1, #items do
        tempWeight = tempWeight + items[i][2]
        if rnd <= tempWeight then
            if not lualib:AddItem(player, items[i][1], 1, false, "����Ʒ����������", "Ya����") then
                lualib:Error("���ر��и���Ʒʧ�ܣ�")
                return false
            end
            lualib:SysMsg_SendBroadcastMsg("��ϲ��ҡ�"..lualib:KeyName(player) .."�����������л�ñ����á�"..lualib:KeyName(items[i][1]).."��","���鱦��")
            lualib:DelItem(player, lualib:KeyName(item), 1, 2, "��������", "Ya����")
            return true
        end
    end


end


