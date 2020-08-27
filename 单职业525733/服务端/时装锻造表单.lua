local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local data =  {
    {
        {"����ʱװ", {"ʱװ��Ƭ", 888}, 888,"����װ������","ʱװ��Ƭ","2%","2%"},--����ʱװ + {�������+����} + ����Ԫ�� + ʱװ��������ʾ�ã�+ ��ȡ���ò��� + ���ﱬ�� + ��������
    },
    {
        {"����ʱװ", {"ʱװ��Ƭ", 888}, 888,"����װ������","ʱװ��Ƭ","2%","2%"},
    },
    {
        {"����ʱװ", {"ʱװ��Ƭ", 888}, 888,"����װ������","ʱװ��Ƭ","2%","2%"},
    },
    {
        {"��ʥʱװ", {"ʱװ��Ƭ", 888}, 888,"��ʥװ������","ʱװ��Ƭ","2%","2%"},
    },
    {
        {"����ʱװ", {"ʱװ��Ƭ", 888}, 888,"����װ������","ʱװ��Ƭ","2%","2%"},
    },
}

local fashionsRelated = {   --ʱװkeyname,�ϳɺ��ʱװkeyname
    {"����ʱװ","����ʱװSS",288888},
    {"����ʱװ","����ʱװSS",288888},
    {"����ʱװ","����ʱװSS",288888},
    {"��ʥʱװ","��ʥʱװSS",288888},
    {"����ʱװ","����ʱװSS",288888},
}

function show(player)
    local str = " fashion_tab = "..serialize(data) .. ";fashionsRelated = ".. serialize(fashionsRelated)
    lualib:ShowFormWithContent(player, "�ű���", str)
    lualib:ShowFormWithContent(player, "form�ļ���", "ʱװ����Wnd")
    return ""
end

function main(player, pos, idx, types)
    local pos = tonumber(pos)
    local idx = tonumber(idx)
    local types = tonumber(types)
    if data == nil then
        lualib:MsgBox(player, "NPC���������ݴ���,��ϸ������ݱ�.")
        return ""
    end
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player, "�����ٱ���һ�������ռ䡣")
        return "�����ٱ���һ�������ռ䡣"
    end
    local t = data[pos][idx]
    --����
    if types == 1 then
        if lualib:ItemCount(player, t[2][1]) < t[2][2] then
            lualib:MsgBox(player, "��Ǹ�����ġ�ʱװ��Ƭ�����㡣")
            return "��Ǹ�����ġ�ʱװ��Ƭ�����㡣"
        end
        lualib:DelItem(player, t[2][1], t[2][2], 2, "ʱװ����", "ʱװ����")
        lualib:AddItem(player, t[1], 1, false, "ʱװ����", "ʱװ����")
        lualib:MsgBox(player, "��ϲ���ɹ��������".. lualib:KeyName2Name(t[1], 4) .."����")
        return "��ϲ���ɹ��������".. lualib:KeyName2Name(t[1], 4) .."����"
    end

    --��ȡ
    if types == 2 then
        local r = math.random(1,5)
        if not lualib:SubIngot(player, t[3], "ʱװ����", "ʱװ����") then
            lualib:MsgBox(player, "��Ǹ������Ԫ�����㡣")
            return "��Ǹ������Ԫ�����㡣"
        end
        lualib:AddItem(player, t[5], r, false, "ʱװ����", "ʱװ����")
        lualib:MsgBox(player, "��ϲ����ȡ��á�".. lualib:KeyName2Name(t[5], 4) .."����")
        return "��ϲ����ȡ��á�".. lualib:KeyName2Name(t[5], 4) .."����"
    end
end

function automaticallyPlaced(player)

    local fashionsCount = {}
    local str = ""
    for i=1,#fashionsRelated do
        fashionsCount[i] = lualib:ItemCountEx(player,fashionsRelated[i][1],2,false,true,false,false)
    end
    str = "fashionsRelated = ".. serialize(fashionsRelated) .. ";fashionsCount = ".. serialize(fashionsCount)
    lualib:ShowFormWithContent(player,"�ű���",str)
    lualib:ShowFormWithContent(player,"�ű���",[[Fashion.update()]])

    return ""
end

function Synthesis(player,keyname)
    local num = 0 --��������keyname��fashionsRelated�ڼ���
    for i=1,#fashionsRelated do
        if keyname == fashionsRelated[i][1] then
            num = i
        end
    end
    if lualib:GetIngot(player) > fashionsRelated[num][3] then
        if lualib:Player_SubIngot(player, fashionsRelated[num][3], false, "��Ԫ��:ԭ��", "������") ~= true then
            lualib:MsgBox(player,"�۳�Ԫ��ʧ�ܣ�����ϵ����Ա")
            return
        end
    else
        lualib:MsgBox(player,"Ԫ�����㣡��")
    end
    if lualib:ItemCountEx(player,keyname,2,false,true,false,false) < 3 then
        lualib:MsgBox(player,"���ı������ʱװ��"..keyname.."�������������޷��ϳɣ�����")
    end
    lualib:DelItem(player,keyname,3,2,"�ϳɸ߼�ʱװɾ������","ʱװ�����")
    lualib:AddItem(player,fashionsRelated[num][2],1,false,"�ϳɸ߼�ʱװ","ʱװ�����")
    lualib:MsgBox(player,"�ϳɡ�"..fashionsRelated[num][2].."���ɹ�������")

    lualib:ShowFormWithContent(player,"�ű���",[[Fashion.clearFashion()]])
    return ""
end
