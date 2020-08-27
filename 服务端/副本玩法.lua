local monster_table={
    [45]={"45������","45������","45������","45������","45������ͷ��"},
    [50]={"50����","50����","50����","50����","50��boss"},
    [54]={"54����","54����","54����","54����","54��boss"},
    [57]={"57����","57����","57����","57����","57��boss"},
    [60]={"60����","60����","60����","60����","60��boss"},
    [65]={"65����","65����","65����","65����","65��boss"},
}

function on_map_create(map)
    lualib:AddTimer(map,1,2000,-1,"on_ai")
    lualib:AddTrigger(map,lua_trigger_leave_map, "on_leave_map")
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map");
end
function on_enter_map(player)

    if lualib:HasBuff(player,"2������") then
        --ɾ��buff
        lualib:DelBuff(player, "2������")          --ȡ�����ϵ�buff
        lualib:SysPromptMsg(player, "����ȡ����������Ч��")
    end

    if lualib:HasBuff(player,"4������") then
        --ɾ��buff
        lualib:DelBuff(player, "4������")          --ȡ�����ϵ�buff
        lualib:SysPromptMsg(player, "����ȡ����������Ч��")
    end

    if lualib:HasBuff(player,"6������") then
        --ɾ��buff
        lualib:DelBuff(player, "6������")          --ȡ�����ϵ�buff
        lualib:SysPromptMsg(player, "����ȡ����������Ч��")
    end

    if lualib:HasBuff(player,"8������") then
        --ɾ��buff
        lualib:DelBuff(player, "8������")          --ȡ�����ϵ�buff
        lualib:SysPromptMsg(player, "����ȡ����������Ч��")
    end

    if lualib:HasBuff(player,"10������") then
        lualib:DelBuff(player, "10������")          --ȡ�����ϵ�buff
        lualib:SysPromptMsg(player, "����ȡ����������Ч��")
    end


    local map = lualib:MapGuid(player)
    local i=lualib:GetInt(player,"fuben_dengji")
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][1],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][2],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][3],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][4],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][5],1,false)
end

function on_ai(map)
    if lualib:Map_GetMonsterCount(map,"",true,true)==0 then
        local playerList = lualib:Map_GetMapPlayers(map, true)
        lualib:SetInt(playerList[1],"fuben_jiangli",1)
        lualib:Player_MapMoveXY(playerList[1],"����",140,127,0)
        lualib:Map_DestroyDgn(map)
    end
end

function on_leave_map(player)

    local level = lualib:Level(player)
    local max = lualib:GetDBNum("��ߵȼ�")
    if level > max then
        max = level
        lualib:SetDBNumEx("��ߵȼ�", level, 2)
    end
    if max >= 1 then
        if max - level >= 7 then
            lualib:AddBuff(player, "10������", 7200)
            lualib:SysPromptMsg(player, "������ߵȼ����7���������10������")
        elseif max - level >= 6 then
            lualib:AddBuff(player, "8������", 7200)
            lualib:SysPromptMsg(player, "������ߵȼ����6���������8������")
        elseif max - level >= 5 then
            lualib:AddBuff(player, "6������", 7200)
            lualib:SysPromptMsg(player, "������ߵȼ����5���������6������")
        elseif max - level >= 4 then
            lualib:AddBuff(player, "4������", 7200)
            lualib:SysPromptMsg(player, "������ߵȼ����4���������4������")
        elseif max - level >= 3 then
            lualib:AddBuff(player, "2������", 7200)
            lualib:SysPromptMsg(player, "������ߵȼ����3���������2������")
        end
    end


    local map = lualib:MapGuid(player)
    lualib:Map_DestroyDgn(map)
end
