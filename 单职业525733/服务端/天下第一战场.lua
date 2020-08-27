local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/logic_def_lua")

function on_map_create(map)
    lualib:Print("���µ�һս����ͼ�����ص���")
    if not lualib:Map_GenNpc(map, "��ݽ�������", 24, 58, 6, 3) then
        lualib:Print("���µ�һս����NPC��ݽ�������ˢ��ʧ�ܣ�")
    end
    lualib:Print("���µ�һս����NPC��ݽ�������ˢ�³ɹ���")

    lualib:AddTrigger(map,  lua_trigger_enter_map, "on_enter_map")
    lualib:AddTrigger(map,  lua_trigger_post_die, "on_die")
    lualib:AddTrigger(map,  lua_trigger_pre_process_pk, "on_pk")
    lualib:AddTrigger(map,  lua_trigger_dungeon_end, "on_dungeon_end")

    if not lualib:AddTimer(map, 1, 660000, 1, "on_timer_check_begin") then
        lualib:Print("���µ�һս�����볡У��������ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս�����볡У��������ʱ���ɹ���")

    if not lualib:AddTimer(map, 20, 1800000, 1, "on_timer_event") then
        lualib:Print("���µ�һս�����¼���ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս�����¼���ʱ���ɹ���")

    if not lualib:AddTimer(map, 15, 3600000, 1, "jiasu") then
        lualib:Print("���µ�һս����ս�����ٶ�ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս����ս�����ٶ�ʱ���ɹ���")
end

function jiasu(map, id)
    if not lualib:AddTimer(map, 25, 15000, -1, "cost") then
        lualib:Print("���µ�һս����ѭ����Ѫ��ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս����ѭ����Ѫ��ʱ���ɹ���")
    return
end



function cost(map, id)
    local player_table = lualib:Map_GetRegionPlayers(map, 38, 47, 35, true)
    if  #player_table == 0 then return end

    for _, v in pairs(player_table) do
        local CostHp = lualib:Hp(v, true) * 0.05
        local Hp = lualib:Hp(v, false) - CostHp
        local CostMp = lualib:Mp(v, true) * 0.05
        local Mp = lualib:Mp(v, false) - CostMp

        if Hp > 0 then
            lualib:SetHp(v, Hp, false)
        elseif Hp <= 0 then
            lualib:Kill(v)
        end

        if Mp > 0 then
            lualib:SetMp(v, Mp, false)
        end
    end
    return
end



function on_map_destroy(map, keyname)
    lualib:ClearTrigger(map)
    lualib:Print("���µ�һս�������٣�")
end

function on_enter_map(player)
    lualib:Print("���µ�һս���������ͼ�ص���")
    lualib:Player_ChangeAttackMode(player,  lua_atk_mode_all)
end

function on_dungeon_end(map, keyname)
    result(map)
end

function on_pk(killer, victim)
    if lualib:Player_IsPlayer(victim) and lualib:Player_IsPlayer(killer) then
        local name = lualib:Player_GetStrProp(victim,  lua_role_user_name)
        lualib:SysMsg_SendPromptMsg(killer, "����ɱ��"..name.."����PK�ͷ���")
        lualib:SysMsg_SendTipsMsg(killer, "����ɱ��"..name.."����PK�ͷ���")
    end
    return false
end

function on_die(actor, killer)
    local name = ""
    if lualib:Player_IsPlayer(killer) then
        name = lualib:Player_GetStrProp(killer,  lua_role_user_name)
        lualib:SysMsg_SendPromptMsg(actor, "����"..name.."ɱ���ˣ�")
        lualib:SysMsg_SendTipsMsg(actor, "����"..name.."ɱ���ˣ�")
    elseif lualib:Monster_IsMonster(killer) then
        name = lualib:Monster_GetMaster(killer)
        if name == "" then return end
        lualib:SysMsg_SendPromptMsg(actor, "����"..name.."�����ɱ���ˣ�")
        lualib:SysMsg_SendTipsMsg(actor, "����"..name.."�����ɱ���ˣ�")
    end
    return
end

function on_timer_check_begin(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("���µ�һս����ͼ�����ڣ�")
        return
    end
    local player_count = lualib:Map_GetPlayerCount(map, false)
    if player_count <= 1 then
        lualib:Map_DestroyDgn(map)
        return
    end
    if not lualib:AddTimer(map, 10, 60000, -1, "on_timer_check") then
        lualib:Print("���µ�һս�����볡У��������ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս�����볡У��������ʱ���ɹ���")
end

function on_timer_check(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("���µ�һս����ͼ�����ڣ�")
        return
    end
    local player_count = lualib:Map_GetPlayerCount(map, false)
    if player_count <= 1 then lualib:Map_DestroyDgn(map) end
end

function on_timer_event(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("���µ�һս����ͼ�����ڣ�")
        return
    end
    lualib:Print("���µ�һս���������¼���")
    if not lualib:AddTimer(map, timer_id + 1, 1200000, 1, "on_timer_event") then
        lualib:Print("���µ�һս�����¼���ʱ��ʧ�ܣ�")
        return
    end
    lualib:Print("���µ�һս�����¼���ʱ���ɹ���")
end

function result(map)
    local job_table = {"սʿ", "��ʦ", "��ʿ", ""}
    local npc_table = {"���µ�һսʿ", "���µ�һ��ʦ", "���µ�һ��ʿ", "���µ�һ"}
    local wday = 4
    if job_table[wday] == nil then return end

    local players = lualib:Map_GetMapPlayers(map, false)
    local player_count = lualib:Map_GetPlayerCount(map, false)

    if player_count ~= 1 then
        lualib:SysMsg_SendTopMsg(1, "���µ�һ"..job_table[wday].."�����������������ʤ����")
        lualib:SysMsg_SendBroadcastMsg("���µ�һ"..job_table[wday].."�����������������ʤ����", "ϵͳ֪ͨ")
        SetMaster("", wday)
    else
        local name = lualib:Player_GetStrProp(players[1],  lua_role_user_name)
        if name == "" then return "ȡ���������ʧ�ܣ�" end

        lualib:Player_SetCustomVarInt(players[1], "scheduled_txdyzc_result", wday)
        lualib:Player_SetCustomVarInt(players[1], "scheduled_txdyzc_title", 1)

        SetMaster(players[1], wday)

        local title_table = {27, 28, 29, 26}
        if lualib:HasTitle(players[1], title_table[wday]) then
            lualib:RemoveTitle(players[1], title_table[wday])
        end

        lualib:AddTitle(players[1], title_table[wday])

        lualib:GSTriggerScript("���µ�һ����:GSTriggerScript", string.format("��ɽ��#%s#%d", npc_table[wday], wday))

        lualib:SysMsg_SendTopMsg(3, name.."����Ⱥ�ۣ�����Ӯ�������µ�һ"..job_table[wday].."�������Ĺھ�������׭�̵���������ʷ��")
        lualib:SysMsg_SendCenterMsg(1, name.."����Ⱥ�ۣ�����Ӯ�������µ�һ"..job_table[wday].."�������Ĺھ�������׭�̵���������ʷ��", "")
    end
end

function SetMaster(player, type)
    local record_file = {"���µ�һսʿ.txt", "���µ�һ��ʦ.txt", "���µ�һ��ʿ.txt", "���µ�һ.txt"}
    local record_master = "���µ�һ"
    local record_changeline = "\\n"
    local record_sex = {"��", "Ů"}
    local record_job = {"սʿ", "��ʦ", "��ʿ"}

    if player == "" then
        lualib:IO_EmptyTextFile(record_file[type])
        return
    end

    local job = lualib:Player_GetIntProp(player,  lua_role_job)
    local name = lualib:Player_GetStrProp(player,  lua_role_user_name)
    local level = lualib:Player_GetIntProp(player,  lua_role_level)
    local sex = lualib:Player_GetIntProp(player,  lua_role_gender)
    if job == -1 or name == "" or level == -1 or sex == -1 then
        lualib:Print("ȡ�������Ϣ����")
        return
    end

    local content = ""
    if type == 4 then
        content =  record_master..record_changeline..name.."\n"..player.."\n"..level.."\n"
    else
        content = record_master..record_sex[sex]..record_job[job]..record_changeline..name.."\n"..player.."\n"..level.."\n"
    end

    local result = false
    if lualib:IO_FileExists(record_file[type]) ==  false then
        result = lualib:IO_CreateTextFile(record_file[type], false)
        if result == false then lualib:Print("�����ļ�"..record_file[type].."ʧ�ܣ�") end

        result = lualib:IO_SetFileText(record_file[type], content)
        if result == false then lualib:Print("д�ļ�"..record_file[type].."ʧ�ܣ�") end

        return
    end

    result = lualib:IO_SetFileText(record_file[type], content)
    if result == false then lualib:Print("д�ļ�"..record_file[type].."ʧ�ܣ�") end
end
