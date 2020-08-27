local x = 56	--����������������

local y = 50	--����������������

local times = 60	--�������ʼ����

local _times = 600	--�������ʼ˫����Ѫ

local pct = 90	--�����ٷֱ�1-100֮��

local buff = "����"	--��̨����˫������buff������[����Ϊ���ߡ���������ͼ��������]

local _buff = "����"	--�����߽����ͼ�����buff������[����Ϊ���ߡ���������ͼ��������]

local __buff = "������ʱ"	--ʱ�䳬��ĳ��ֵ���������ÿ���Ѫ��buff������[����Ϊ���ߡ���������ͼ��������]

local time_t = {
    [30] = "���������ʼ����30�뿪ʼ��",
    [40] = "���������ʼ����20�뿪ʼ��",
    [50] = "���������ʼ����10�뿪ʼ��",
    [55] = "���������ʼ����5�뿪ʼ��",
    [56] = "���������ʼ����4�뿪ʼ��",
    [57] = "���������ʼ����3�뿪ʼ��",
    [58] = "���������ʼ����2�뿪ʼ��",
    [59] = "���������ʼ����1�뿪ʼ��",
}

function on_map_create(map)
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map")
    lualib:AddTrigger(map, lua_trigger_leave_map, "on_leave_map")
    lualib:AddTrigger(map, lua_trigger_player_post_die, "on_post_player_die")
    lualib:AddTrigger(map, lua_trigger_player_relive, "on_player_relive")
end

function on_player_relive(player, param)
    lualib:Player_Relive(player, "", x, y, 1, 98)
    lualib:AddBuff(player, _buff, 0)
    local hero = lualib:GetCurrentHero(player)
    if hero ~= "" then
        lualib:AddBuff(hero, _buff, 0)
        local map = lualib:MapGuid(player)
        lualib:Player_MapMoveXY(hero, lualib:KeyName(map), x, y, 1)
    end
    return false
end

function on_leave_map(player)
    if lualib:GUIDType(player) == 0 then
        on_post_player_die(player)
    end
end

function on_post_player_die(player)

    local map = lualib:MapGuid(player)

    local data = lualib:GetStr(map, "rolelist")

    if data == "" then return end

    local tb = lualib:StrSplit(data, "#")

    if tb[1] ~= player and tb[4] ~= player then return end

    local killer = tb[1]

    if player == tb[1] then
        killer = tb[4]
    end

    local tb = lualib:StrSplit(data, "#")
    local ingot = math.floor(tonumber(tb[3]) * 2 * pct / 100)
    if killer ~= "" then
        lualib:AddIngot(killer, ingot, "��̨��", map)
        lualib:SysMsg_SendBroadcastMsg("ϵͳ��ʾ��"..lualib:Name(killer).."�ڱ�����ȡ����ʤ����Ӯ��"..ingot.."Ԫ����", "")
        lualib:Player_MapMoveXY(killer, lualib:KeyName(map), x, y, 1)
    end
    local hero = lualib:GetCurrentHero(killer)
    if hero ~= "" then
        lualib:AddBuff(hero, _buff, 0)
        lualib:Player_MapMoveXY(hero, lualib:KeyName(map), x, y, 1)
    end
    lualib:AddBuff(killer, _buff, 0)
    lualib:SetStr(map, "rolelist", "")
    lualib:DisableTimer(map, 2)
end

function on_check(map, id, role, _role)

    local second = lualib:GetInt(map, "second_ex") + 1
    lualib:SetInt(map, "second_ex", second)

    if time_t[second] ~= nil then
        lualib:SysMsg_SendMapMsg(map, time_t[second])
    end

    if second < times then return end

    if second == times then
        if lualib:Player_IsOnline(role) then
            lualib:DelBuff(role, buff)
        end
        if lualib:Player_IsOnline(_role) then
            lualib:DelBuff(_role, buff)
        end
        local msg = "��̨������ʽ��ʼ��˭��վ����̨��վ�����Ϊʤ���������ĵȴ�ϵͳ������"
        lualib:SysMsg_SendMapMsg(map, msg)
        return end

    if second >= times + _times then
        if not lualib:HasBuff(role, __buff) then
            lualib:AddBuff(role, __buff, 0)
        end
        if not lualib:HasBuff(_role, __buff) then
            lualib:AddBuff(_role, __buff, 0)
        end
    end
end

function on_enter_map(player)
    local map = lualib:MapGuid(player)
    local data = lualib:GetStr(map, "rolelist")
    if data ~= "" then
        local tb = lualib:StrSplit(data, "#")
        local second = lualib:GetInt(map, "second_ex")
        if player == tb[1] or player == tb[4] or lualib:GetHeroLord(player) == tb[1] or lualib:GetHeroLord(player) == tb[4] then
            lualib:AddBuff(player, buff, times - second)
        else
            lualib:AddBuff(player, _buff, 0)
        end
    else
        lualib:AddBuff(player, _buff, 0)
    end
    if lualib:GUIDType(player) == 0 then
        local servant_t = lualib:Player_GetServantList(player)
        if #servant_t > 0 then
            for _, v in pairs(servant_t) do
                lualib:Monster_Remove(v)
            end
        end
    end
end