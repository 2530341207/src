local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local  monsterBoss = {
    "�ϹŰ�쵻�",
    "����ѩ��",
    "�������",
    "���׷��",
    "�������"
}

function Init_system_Start()
    lualib:AddTimerEx("0",20200422,1000,-1,"����BOSS:refreshMonster","")
    lualib:DelayCall("0",1,"����BOSS:restartRefresh","")

    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die") --������������
    lualib:AddTrigger("0", lua_trigger_player_pre_die, "pre_player_die") --�������ǰ����
    lualib:AddTrigger("0",  lua_trigger_login, "on_login") --�������ʱ�ص�
    lualib:AddTrigger("0", 394, "on_billinex") --��ҳ�ֵǿ�ƴ���
end

function main()
    if lualib:GetDBNum("tyfSystem") == 0 then
        Init_system_Start()       --����ʱ��Ч
        lualib:SetDBNum("tyfSystem", 1)
    end

end

function on_login(player)

    local id = lualib:UserID(player)
    if lualib:GetDBNum("violent"..id) == 1 then
        if lualib:HasBuff(player,"��֮��") ~= true then
            lualib:AddBuff(player,"��֮��",0)
        end
    end
end

function on_post_monster_die(monster, killer)
    local monster = lualib:KeyName(monster)

    for i=1,#monsterBoss do
        if monster == monsterBoss[i] then
            lualib:SetDBNum("����BOSS"..i,0)
        end
    end
end

local kbzl = 34444  --��֮����ɱԪ��

function pre_player_die(player, killer)
    local id = lualib:UserID(player)
    if lualib:GetDBNum("violent"..id) == 1 then
        lualib:DelBuff(player,"��֮��")
        lualib:SetDBNum("violent"..id,0)
        lualib:Player_AddIngot(killer,kbzl,false,"��֮�������ɱ��Ԫ��","��֮��")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(killer).."����ɱ����ҡ�"..lualib:KeyName(player).."���������ҡ�"..lualib:KeyName(killer).."����֮������34444Ԫ��������","��֮��")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(killer).."����ɱ����ҡ�"..lualib:KeyName(player).."���������ҡ�"..lualib:KeyName(killer).."����֮������34444Ԫ��������","��֮��")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(killer).."����ɱ����ҡ�"..lualib:KeyName(player).."���������ҡ�"..lualib:KeyName(killer).."����֮������34444Ԫ��������","��֮��")
    end
end

function on_billinex(id, yb)
    lualib:SetDBNumEx("ljcz"..id,lualib:GetDBNum("ljcz"..id)+yb,2)
    lualib:SetDBNumEx("mrcz"..id..lualib:GetAllDays(0),lualib:GetDBNum("mrcz"..id..lualib:GetAllDays(0)),2)
end

main()