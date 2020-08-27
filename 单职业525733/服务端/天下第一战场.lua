local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/logic_def_lua")

function on_map_create(map)
    lualib:Print("天下第一战场地图建创回调！")
    if not lualib:Map_GenNpc(map, "武馆教练场内", 24, 58, 6, 3) then
        lualib:Print("天下第一战场：NPC武馆教练场内刷新失败！")
    end
    lualib:Print("天下第一战场：NPC武馆教练场内刷新成功！")

    lualib:AddTrigger(map,  lua_trigger_enter_map, "on_enter_map")
    lualib:AddTrigger(map,  lua_trigger_post_die, "on_die")
    lualib:AddTrigger(map,  lua_trigger_pre_process_pk, "on_pk")
    lualib:AddTrigger(map,  lua_trigger_dungeon_end, "on_dungeon_end")

    if not lualib:AddTimer(map, 1, 660000, 1, "on_timer_check_begin") then
        lualib:Print("天下第一战场：入场校验人数定时器失败！")
        return
    end
    lualib:Print("天下第一战场：入场校验人数定时器成功！")

    if not lualib:AddTimer(map, 20, 1800000, 1, "on_timer_event") then
        lualib:Print("天下第一战场：事件定时器失败！")
        return
    end
    lualib:Print("天下第一战场：事件定时器成功！")

    if not lualib:AddTimer(map, 15, 3600000, 1, "jiasu") then
        lualib:Print("天下第一战场：战斗加速定时器失败！")
        return
    end
    lualib:Print("天下第一战场：战斗加速定时器成功！")
end

function jiasu(map, id)
    if not lualib:AddTimer(map, 25, 15000, -1, "cost") then
        lualib:Print("天下第一战场：循环扣血定时器失败！")
        return
    end
    lualib:Print("天下第一战场：循环扣血定时器成功！")
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
    lualib:Print("天下第一战场：销毁！")
end

function on_enter_map(player)
    lualib:Print("天下第一战场：进入地图回调！")
    lualib:Player_ChangeAttackMode(player,  lua_atk_mode_all)
end

function on_dungeon_end(map, keyname)
    result(map)
end

function on_pk(killer, victim)
    if lualib:Player_IsPlayer(victim) and lualib:Player_IsPlayer(killer) then
        local name = lualib:Player_GetStrProp(victim,  lua_role_user_name)
        lualib:SysMsg_SendPromptMsg(killer, "您已杀死"..name.."，无PK惩罚！")
        lualib:SysMsg_SendTipsMsg(killer, "您已杀死"..name.."，无PK惩罚！")
    end
    return false
end

function on_die(actor, killer)
    local name = ""
    if lualib:Player_IsPlayer(killer) then
        name = lualib:Player_GetStrProp(killer,  lua_role_user_name)
        lualib:SysMsg_SendPromptMsg(actor, "您被"..name.."杀死了！")
        lualib:SysMsg_SendTipsMsg(actor, "您被"..name.."杀死了！")
    elseif lualib:Monster_IsMonster(killer) then
        name = lualib:Monster_GetMaster(killer)
        if name == "" then return end
        lualib:SysMsg_SendPromptMsg(actor, "您被"..name.."的随从杀死了！")
        lualib:SysMsg_SendTipsMsg(actor, "您被"..name.."的随从杀死了！")
    end
    return
end

function on_timer_check_begin(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("天下第一战场地图不存在！")
        return
    end
    local player_count = lualib:Map_GetPlayerCount(map, false)
    if player_count <= 1 then
        lualib:Map_DestroyDgn(map)
        return
    end
    if not lualib:AddTimer(map, 10, 60000, -1, "on_timer_check") then
        lualib:Print("天下第一战场：入场校验人数定时器失败！")
        return
    end
    lualib:Print("天下第一战场：入场校验人数定时器成功！")
end

function on_timer_check(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("天下第一战场地图不存在！")
        return
    end
    local player_count = lualib:Map_GetPlayerCount(map, false)
    if player_count <= 1 then lualib:Map_DestroyDgn(map) end
end

function on_timer_event(map, timer_id)
    if not lualib:Map_IsDgnExist(map) then
        lualib:Print("天下第一战场地图不存在！")
        return
    end
    lualib:Print("天下第一战场：场景事件！")
    if not lualib:AddTimer(map, timer_id + 1, 1200000, 1, "on_timer_event") then
        lualib:Print("天下第一战场：事件定时器失败！")
        return
    end
    lualib:Print("天下第一战场：事件定时器成功！")
end

function result(map)
    local job_table = {"战士", "法师", "道士", ""}
    local npc_table = {"天下第一战士", "天下第一法师", "天下第一道士", "天下第一"}
    local wday = 4
    if job_table[wday] == nil then return end

    local players = lualib:Map_GetMapPlayers(map, false)
    local player_count = lualib:Map_GetPlayerCount(map, false)

    if player_count ~= 1 then
        lualib:SysMsg_SendTopMsg(1, "天下第一"..job_table[wday].."争霸赛结束，玩家无胜负！")
        lualib:SysMsg_SendBroadcastMsg("天下第一"..job_table[wday].."争霸赛结束，玩家无胜负！", "系统通知")
        SetMaster("", wday)
    else
        local name = lualib:Player_GetStrProp(players[1],  lua_role_user_name)
        if name == "" then return "取得玩家名字失败！" end

        lualib:Player_SetCustomVarInt(players[1], "scheduled_txdyzc_result", wday)
        lualib:Player_SetCustomVarInt(players[1], "scheduled_txdyzc_title", 1)

        SetMaster(players[1], wday)

        local title_table = {27, 28, 29, 26}
        if lualib:HasTitle(players[1], title_table[wday]) then
            lualib:RemoveTitle(players[1], title_table[wday])
        end

        lualib:AddTitle(players[1], title_table[wday])

        lualib:GSTriggerScript("天下第一触发:GSTriggerScript", string.format("巫山城#%s#%d", npc_table[wday], wday))

        lualib:SysMsg_SendTopMsg(3, name.."力挫群雄，最终赢得了天下第一"..job_table[wday].."争霸赛的冠军宝座，篆刻雕象，名留青史！")
        lualib:SysMsg_SendCenterMsg(1, name.."力挫群雄，最终赢得了天下第一"..job_table[wday].."争霸赛的冠军宝座，篆刻雕象，名留青史！", "")
    end
end

function SetMaster(player, type)
    local record_file = {"天下第一战士.txt", "天下第一法师.txt", "天下第一道士.txt", "天下第一.txt"}
    local record_master = "天下第一"
    local record_changeline = "\\n"
    local record_sex = {"男", "女"}
    local record_job = {"战士", "法师", "道士"}

    if player == "" then
        lualib:IO_EmptyTextFile(record_file[type])
        return
    end

    local job = lualib:Player_GetIntProp(player,  lua_role_job)
    local name = lualib:Player_GetStrProp(player,  lua_role_user_name)
    local level = lualib:Player_GetIntProp(player,  lua_role_level)
    local sex = lualib:Player_GetIntProp(player,  lua_role_gender)
    if job == -1 or name == "" or level == -1 or sex == -1 then
        lualib:Print("取得玩家信息出错！")
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
        if result == false then lualib:Print("创建文件"..record_file[type].."失败！") end

        result = lualib:IO_SetFileText(record_file[type], content)
        if result == false then lualib:Print("写文件"..record_file[type].."失败！") end

        return
    end

    result = lualib:IO_SetFileText(record_file[type], content)
    if result == false then lualib:Print("写文件"..record_file[type].."失败！") end
end
