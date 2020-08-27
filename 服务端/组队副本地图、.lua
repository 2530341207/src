local monster = {
    ["���֮ս"] = {
        {"45������", 8, 8, 200, 20},--������+X+Y+��Χ+����
        {"45������ͷ��", 88, 102, 1, 1},
    },
    ["�ٶ�֮ս"] = {
        {"50����", 8, 8, 200, 20},--������+X+Y+��Χ+����
        {"50��boss", 77, 56, 1, 1},
    },
    ["����֮ս"] = {
        {"57����", 8, 8, 300, 20},--������+X+Y+��Χ+����
        {"57��boss", 133, 102, 1, 1},
    },
    ["��֮ͤս"] = {
        {"60����", 8, 8, 200, 20},--������+X+Y+��Χ+����
        {"60��boss", 89, 74, 1, 1},
    },
    ["����ħ����"] = {
        {"��ħ��1", 8, 8, 200, 5},--������+X+Y+��Χ+����
        {"��ħ��2", 8, 8, 200, 5},
        {"��ħ��3", 8, 8, 200, 5},
        {"��ħ��BOSS", 163, 57, 1, 1},
    },
    ["�������ӡ�"] = {
        {"������1", 8, 8, 200, 5},--������+X+Y+��Χ+����
        {"������2", 8, 8, 200, 5},
        {"������3", 8, 8, 200, 5},
        {"������BOSS", 83, 152, 1, 1},
    },
    ["����Ȫ·��"] = {
        {"��Ȫ·1", 8, 8, 200, 5},--������+X+Y+��Χ+����
        {"��Ȫ·2", 8, 8, 200, 5},
        {"��Ȫ·3", 8, 8, 200, 5},
        {"��Ȫ·BOSS", 41, 30, 1, 1},
    },
    ["������̨��"] = {
        {"����̨1", 8, 8, 200, 5},--������+X+Y+��Χ+����
        {"����̨2", 8, 8, 200, 5},
        {"����̨3", 8, 8, 200, 5},
        {"����̨BOSS", 38, 27, 1, 1},
    },
}

function on_map_create(map, mapkey)
    lualib:AddTimer(map, 1, 1000, -1, "on_check")
    lualib:AddTrigger(map, lua_trigger_leave_map, "on_leave_map")                        --����뿪��ͼ����
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map");
    if monster[mapkey] ~= nil then
        for _, v in ipairs(monster[mapkey]) do
            lualib:Map_GenMonster(map, v[2], v[3], v[4], lualib:GenRandom(1, 8), v[1], v[5], false)
        end
    end
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

end

function on_check(map)
    local list = lualib:Map_GetMapPlayers(map, true)
    for _, v in ipairs(list) do
        if not lualib:Player_HasTeam(v) then
            lualib:Player_GoHome(v)
        end
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
    local count = lualib:Map_GetPlayerCount(map, false)
    if count <= 1 then
        lualib:Map_DestroyDgn(map)
    end
end