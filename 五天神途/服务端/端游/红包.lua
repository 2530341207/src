local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local jine = {
    ["С���"] = {1,50},
    ["�к��"] = {51,100},
    ["����"] = {101,200},
}

function main(player,item)
    local key = lualib:KeyName(item)
    local random = lualib:GenRandom(jine[key][1],jine[key][2])
    lualib:AddIngot(player,random, "ʹ��Ԫ�����", "���")
    lualib:SysPromptMsg(player,"��ϲ���"..random.."Ԫ��")
    return true
end

lualib:SysMsg_SendBroadcastMsg("�귨��½��ʿ["..lualib:KeyName(killer).."]���������Ĵ���["..lualib:KeyName(player).."]��ɱ���500Ԫ����ǿ��Χ���У�����
", "[����Ҫ��]")


local job = lualib:Job(player)
if job == 1 then
    lualib:Player_AddSkill(player, "��������4��")
    lualib:Player_AddSkill(player, "��ɱ����4��")
    lualib:Player_AddSkill(player, "��ɱ����4��")
    lualib:Player_AddSkill(player, "�����䵶4��")
    lualib:Player_AddSkill(player, "Ұ����ײ4��")
    lualib:Player_AddSkill(player, "�һ𽣷�4��")

elseif job == 2 then
    lualib:Player_AddSkill(player, "������4��")
    lualib:Player_AddSkill(player, "���ܻ�4��")
    lualib:Player_AddSkill(player, "�ջ�֮��4��")
    lualib:Player_AddSkill(player, "�׵���4��")
    lualib:Player_AddSkill(player, "�����4��")
    lualib:Player_AddSkill(player, "˲Ϣ�ƶ�4��")
    lualib:Player_AddSkill(player, "���ѻ���4��")
    lualib:Player_AddSkill(player, "�����Ӱ4��")
    lualib:Player_AddSkill(player, "�����׹�4��")
    lualib:Player_AddSkill(player, "ʥ����4��")
    lualib:Player_AddSkill(player, "ħ����4��")
    lualib:Player_AddSkill(player, "������4��")

elseif job == 3 then
    lualib:Player_AddSkill(player, "������4��")
    lualib:Player_AddSkill(player, "������ս��4��")
    lualib:Player_AddSkill(player, "ʩ����4��")
    lualib:Player_AddSkill(player, "������4��")
    lualib:Player_AddSkill(player, "�����4��")
    lualib:Player_AddSkill(player, "�ٻ�����4��")
    lualib:Player_AddSkill(player, "����������4��")
    lualib:Player_AddSkill(player, "�����4��")
    lualib:Player_AddSkill(player, "��ʥս����4��")
    lualib:Player_AddSkill(player, "��ħ��4��")
    lualib:Player_AddSkill(player, "Ⱥ��������4��")
    lualib:Player_AddSkill(player, "�ٻ�����4��")
end

if lualib:Job(player) == 1 and lualib:Level(pleyer) > 48 then
    lualib:DelSkill(player,"�ٻ�����4��")
    lualib:AddSkill(player,"�ٻ��׻�4��")
end