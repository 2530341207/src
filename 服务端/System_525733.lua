local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

require("system/logic_def_lua")
--require("system/forbid_role")
require("system/����ϵͳ")
require("system/master")
require("system/family")
require("system/item_exp")
require("system/horse")
require("system/online_gift")
require("system/marry")
require("npc/����������Ա")
require("system/��ֵ���")
require("system/��ȡ����")
require("system/ÿ��ǩ��")
require("campaign/��Ӣ�������������淨")
require("campaign/��Ӣ������������淨")
require("system/��Ѩ̽��")
require("system/Ŀ��ϵͳ")
require("system/����")
require("system/ת��")
require("form/�����")
require("form/��һ�")
require("form/��Ӫ�")
require("form/����")
require("form/�Ϸ��")
require("form/ս������")

local map_name_table = {{"����ڣ1", "����ڣһ��"}, {"����ڣ2", "����ڣ����"}, {"����ڣ3", "����ڣ����"}, {"��ɽ��Ѩ1", "��ɽ��Ѩһ��"}, {"��ɽ��Ѩ2", "��ɽ��Ѩ����"}, {"��ɽ��Ѩ3", "��ɽ��Ѩ����"}, {"��ɽ��Ѩ4", "��ɽ��Ѩ�Ĳ�"}, {"��ɽ��Ѩ5", "��ɽ��Ѩ���"}, {"а��1", "���а��һ��"}, {"а��2", "���а�����"}, {"а��3", "���а������"}, {"а��4", "���а���Ĳ�"}, {"�����1", "�����һ��"}, {"�����2", "��������"}, {"�����3", "���������"}, {"�����4", "������Ĳ�"}, {"�����5", "��������"}, {"�����6", "���������"}, {"��·��1", "��·�Ƕ���"}, {"��·��2", "��·���ϲ�"}, {"��·��3", "��·������"}, {"������1", "�����"}, {"������2", "�ϲ�����"}, {"������3", "��������"}, {"������4", "�����ɼ���"}, {"������5", "�ϲ��ɼ���"}}
local timer_table = {{9900, "15����"}, {10200, "10����"}, {10500, "5����"}, {10620, "3����"}, {10680, "2����"}, {10740, "1����"}}
local ma_timer_table = {{6300, "15����"}, {6600, "10����"}, {6900, "5����"}, {7020, "3����"}, {7080, "2����"}, {7140, "1����"}}
local npc_timer_table = {{3420, "3����"}, {3480, "2����"}, {3540, "1����"}}


local ysax_dgwf_call_back_func = "on_timer_ysax_dgwf_call_back_func"
function on_system_start()
    --��������һ������ִ��
    if lualib:IO_GetCustomVarInt("fuwuqishushihua") == 0 then
        lualib:IO_SetCustomVarInt("fuwuqishushihua",1)

        --�弶����������ݳ�ʼ��
        lualib:IO_SetCustomVarInt("chongjizhanshi40",20)
        lualib:IO_SetCustomVarInt("chongjifashi40",20)
        lualib:IO_SetCustomVarInt("chongjidaoshi40",20)
        lualib:IO_SetCustomVarInt("chongjizhanshi45",10)
        lualib:IO_SetCustomVarInt("chongjifashi45",10)
        lualib:IO_SetCustomVarInt("chongjidaoshi45",10)
        lualib:IO_SetCustomVarInt("chongjizhanshi50",1)
        lualib:IO_SetCustomVarInt("chongjifashi50",1)
        lualib:IO_SetCustomVarInt("chongjidaoshi50",1)
    end
    ltszuduiqingli() --������Ӿ���������
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_captcha_result, "on_captcha_result")

    lualib:AddTrigger("0",  lua_trigger_login, "on_login")
    lualib:AddTrigger("0",  lua_trigger_billin, "on_billin")
    lualib:AddTrigger("0",  lua_trigger_logout, "on_logout")
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start")
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end")
    lualib:AddTrigger("0",  lua_trigger_castle_war_init, "trigger_castle_war_init")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")
    lualib:AddTrigger("0",  lua_trigger_add_exp, "on_add_exp")
    --lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")
    lualib:AddTimer("", 700, 60000, -1, "shijie_boss")
    lualib:AddTrigger("0",  lua_trigger_post_equip, "chuandaiqian")   --��װ��֮�󴥷�
    lualib:AddTrigger("0",  lua_trigger_post_un_equip, "tuozhuangbei")   --��װ��֮�󴥷�
    lualib:AddTrigger("0",  lua_trigger_kill, "on_trigger_kill")
    lualib:AddTrigger("0",  362, "on_pre_logout")  --���߹һ�������
    lualib:AddTrigger("0",  363, "on_ride_request")  --������
    lualib:AddTrigger("0",  364, "on_unride_request")  --������
    lualib:AddTrigger("0", lua_trigger_pre_equip, "on_pre_equip") --��װ��֮ǰ����
    lualib:AddTrigger("0", lua_trigger_post_un_equip, "on_post_un_equip")
    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die") --������������
    --lualib:AddTrigger("0", lua_trigger_game_guard_check, "on_game_guard_check") --
    --lualib:AddTrigger("0", lua_trigger_game_guard_hack_rpt, "on_game_guard_hack_rpt") --
    --lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2")


    --�Ϸ�� ����������ʱִ��
    HF_on_system_start()

    --lualib:AddTrigger("0",  lua_trigger_spell, "on_spell")

    --lualib:SetTriggerFilters("0",  lua_trigger_spell, "25,26")

    --lualib:AddTrigger("0",  lua_trigger_item_apply, "on_item_apply")

    --------------------------------
    if lualib:GetDBNum("Y_hequ_biaoshi") == 2 then
        lualib:SetDBNum("Y_hequ_gongcheng", 3)
    end
    lualib:SetDBNumEx("Y_hequ_biaoshi", 1, 4)
    --------------------------------

    init_castle()
    lualib:AddTimerEx("0", 151, 60000, 1, "fanhuan", "")

    local CastleWar = lualib:GetConstVar("CastleWar")
    local CastleWarTime = lualib:Str2Time(CastleWar)
    local times = lualib:GetAllTime()
    if CastleWarTime > times then
        local addtimer = CastleWarTime - times - 80000
    end
    return
end

function on_system_stop()
    lualib:SetDBNum("hxySystem", 0)
    lualib:SetDBNum("tyfSystem",0)
    lualib:SetDBNum("yzaSystem",0)
end

function on_game_guard_check(player)
    lualib:MsgBox(player,"����ʹ����ң�")

    lualib:DelayCall(player,5000,"tiren","")

end

function on_game_guard_hack_rpt(player,report)
    lualib:MsgBox(player,"��⵽�����Ϣ��"..report)
end

function tiren(player)

    lualib:KickByName( lualib:Name(player) , 2, "�������")
end

local wall_table =
{
    ["����"] =
    {
        {"�����ʹ�", 6, "", "��ļ�����ؾ�", 100000, {{"north_wall_guard1", 348, 179}, {"north_wall_guard2", 358, 189}, {"north_wall_guard3", 345, 182}, {"north_wall_guard4", 355, 192}, {"north_wall_guard5", 342, 185}, {"north_wall_guard6", 352, 195}}, "��������2"},
        {"������ǽ", 6, "", "��ļ�����ؾ�", 100000, {{"west_wall_guard1", 288, 152}, {"west_wall_guard2", 299, 141}, {"west_wall_guard3", 284, 156}, {"west_wall_guard4", 303, 137}, {"west_wall_guard5", 280, 160}, {"west_wall_guard6", 307, 133}}, "��������2"},
        {"�ϲ���ǽ", 6, "", "��ļ�ϲ��ؾ�", 100000, {{"south_wall_guard1", 287, 238}, {"south_wall_guard2", 299, 250}, {"south_wall_guard3", 283, 234}, {"south_wall_guard4", 303, 254}, {"south_wall_guard5", 279, 230}, {"south_wall_guard6", 307, 258}}, "��������2"},
        {"������ǽ", 6, "", "��ļ�����ؾ�", 100000, {{"east_wall_guard1", 384, 250}, {"east_wall_guard2", 396, 238}, {"east_wall_guard3", 380, 254}, {"east_wall_guard4", 400, 234}, {"east_wall_guard5", 376, 258}, {"east_wall_guard6", 404, 230}}, "��������2"}
    },
}

function fanhuan()
    for i = 1, table.getn(zhandou) do
        for j = 1, table.getn(zhandou[i]) do
            local data = lualib:IO_GetCustomVarStr(zhandou[i][j][1])
            local data_table = string.split(data, "#")
            if data ~= "" and data ~= nil then
                if i == 1 then
                    lualib:Mail("����������Ա", data_table[1], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[2]), {})
                    if data_table[3] ~= nil and data_table[3] ~= "" then
                        lualib:Mail("����������Ա", data_table[3], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[2]), {})
                    end
                    lualib:IO_SetCustomVarStr(zhandou[i][j][1], "")
                    lualib:IO_SetCustomVarStr(zhandou[i][j][2], "")
                elseif i == 2 then
                    lualib:Mail("����������Ա", data_table[1], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[6]), {})
                    if data_table[7] ~= nil and data_table[7] ~= "" then
                        lualib:Mail("����������Ա", data_table[7], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[6]), {})
                    end
                    lualib:IO_SetCustomVarStr(zhandou[i][j][1], "")
                    lualib:IO_SetCustomVarStr(zhandou[i][j][2], "")
                elseif i == 3 then
                    lualib:Mail("����������Ա", data_table[1], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[11]), {})
                    if data_table[12] ~= nil and data_table[12] ~= "" then
                        lualib:Mail("����������Ա", data_table[12], "��������ľ�����ս�ѹ��ڣ�ϵͳ��������Ԫ����", 0, tonumber(data_table[11]), {})
                    end
                    lualib:IO_SetCustomVarStr(zhandou[i][j][1], "")
                    lualib:IO_SetCustomVarStr(zhandou[i][j][2], "")
                end
            end
        end
    end
end

function on_captcha_result(player, err, err_type)
    if err == 0 then
        lualib:SysMsg_SendTriggerMsg(player, "�ش���ȷ")
    else
        if err_type == 1 then
            lualib:SysMsg_SendTriggerMsg(player, "��ʱ")
        elseif err_type == 2 then
            lualib:SysMsg_SendTriggerMsg(player, "��һ��")
        else
            lualib:SysMsg_SendTriggerMsg(player, "�ش����")
        end
    end
end

function on_hack_check2(player, c1,c2,c3,c4,c5,c6)
    if lualib:GetClientType(player) ~= 0 then
        return;
    end
    if c3 > 5 then
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:SysWarnMsg(player,"��ǰ��;�ͻ��˴���5�����߳���Ϸ!")
        lualib:Player_Kick(player)
    end
end

function init_castle()
    local castle_t = lualib:GetAllCastle()
    if castle_t == nil then return end

    local guard = ""
    for _, v in pairs(castle_t) do
        if wall_table[v] ~= nil then
            for _k, _v in pairs(wall_table[v]) do
                for __k, __v in pairs(_v[6]) do
                    if lualib:GetCastleCustomVarStr(v, __v[1]) ~= "" then
                        guard = lualib:Map_GenSingleMonster(lualib:GetCastleMapGuid(v), __v[2], __v[3], 0, 3, _v[7], false)
                        lualib:SetCastleCustomVarStr(v, __v[1], guard)
                        if guard ~= "" then
                            lualib:AddTrigger(guard,  lua_trigger_post_die, "on_guard_post_die")
                            lualib:Monster_SetCustomVarStr(guard, "castle_name", v)
                            lualib:Monster_SetCustomVarInt(guard, "type", _k)
                            lualib:Monster_SetCustomVarInt(guard, "index", __k)
                        end
                    end
                end
            end
        end
    end
end

function on_guard_post_die(actor, killer)
    local castle_name = lualib:Monster_GetCustomVarStr(actor, "castle_name")
    local type = lualib:Monster_GetCustomVarInt(actor, "type")
    local index = lualib:Monster_GetCustomVarInt(actor, "index")
    if wall_table[castle_name][type][6][index] == nil then return end
    lualib:SetCastleCustomVarStr(castle_name, wall_table[castle_name][type][6][index][1], "")
    lualib:RemoveTrigger(actor,  lua_trigger_post_die, "on_guard_post_die")
end

function on_castle_war_start(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]����ս��ʼ�ˣ�", "ϵͳ֪ͨ")
    if not lualib:Map_ClearDgnItem(dst_map_guid) then
        lualib:Error("�Ǳ���ͼGUID�����ڣ�")
        return
    end

    local add_monster_table = {["����"] = {{"���ǳ���", 292, 247, 5}, {"���ǵ���1", 359, 164, 5},
                                          {"���ǵ���1", 363, 168, 5}, {"���ǵ���1", 367, 172, 5}, {"���ǲ����1", 390, 247, 3}, {"���ǲ����2", 294, 151, 3}}}
    local remove_npc_table = {["����"] = {"����ҩ����", "��������", "���ǲ÷�", "�����ӻ���",
                                         "����������", "��������", "���ǽ̹�", "����ɮ��", "���ǹ�����"}}
    local remove_monster_table = {["����"] = {"��������", "�����̻�", "���Ǿ�Ӫ"}}

    for i = 1, table.getn(add_monster_table[castle_name]) do
        if not lualib:Map_GenSingleMonster(dst_map_guid, add_monster_table[castle_name][i][2], add_monster_table[castle_name][i][3],
                1, add_monster_table[castle_name][i][4], add_monster_table[castle_name][i][1], false) then
            lualib:Print(castle_name.."ˢ��"..add_monster_table[castle_name][i][1].."����")
            return
        end
    end

    for i = 1, table.getn(remove_npc_table[castle_name]) do
        if not lualib:Map_RemoveNpc(dst_map_guid, remove_npc_table[castle_name][i]) then
            lualib:Print(castle_name.."�Ƴ�NPC"..remove_npc_table[castle_name][i].."����")
            return
        end
    end

    for i = 1, table.getn(remove_monster_table[castle_name]) do
        if not lualib:Map_RemoveMonster(dst_map_guid, remove_monster_table[castle_name][i]) then
            lualib:Print(castle_name.."�Ƴ�����"..remove_monster_table[castle_name][i].."����")
            return
        end
    end
end

function on_castle_war_end(castle_name, dst_map_guid, basilica_map_guid)
    local remove_monster_table = {["����"] = {"���ǳ���", "���ǵ���1", "���ǲ����1", "���ǲ����2"}}
    local add_npc_table = {["����"] = {{"���ǹ�����", 335, 203}, {"����ҩ����", 308, 207}, {"��������", 346, 265}, {"���ǲ÷�", 285, 203}, {"�����ӻ���", 322, 234}, {"����������", 289, 181}}}
    local add_monster_table = {["����"] = {{"��������", 330, 154}, {"�����̻�", 319, 198}, {"���Ǿ�Ӫ", 342, 221}}}
    local remove_npc_table = {["����"] = {"�����赲1", "�����赲2", "�����赲3", "�����赲4", "�����赲5", "�����赲6", "�����赲7"}}

    for i = 1, table.getn(remove_monster_table[castle_name]) do
        if not lualib:Map_RemoveMonster(dst_map_guid, remove_monster_table[castle_name][i]) then
            lualib:Print(castle_name.."�Ƴ�����"..remove_monster_table[castle_name][i].."����")
            return
        end
    end

    for i = 1, table.getn(add_npc_table[castle_name]) do
        if not lualib:Map_GenNpc(dst_map_guid, add_npc_table[castle_name][i][1], add_npc_table[castle_name][i][2],
                add_npc_table[castle_name][i][3], 1, 3) then
            lualib:Print(castle_name.."ˢNPC"..add_npc_table[castle_name][i][1].."����")
        end
    end

    for i = 1, table.getn(add_monster_table[castle_name]) do
        if not lualib:Map_GenSingleMonster(dst_map_guid, add_monster_table[castle_name][i][2], add_monster_table[castle_name][i][3],
                1, 3, add_monster_table[castle_name][i][1], false) then
            lualib:Print(castle_name.."ˢ��"..add_monster_table[castle_name][i][1].."����")
            return
        end
    end

    for i = 1, table.getn(remove_npc_table[castle_name]) do
        if not lualib:Map_RemoveNpc(dst_map_guid, remove_npc_table[castle_name][i]) then
            lualib:Print(castle_name.."�Ƴ�NPC"..remove_npc_table[castle_name][i].."����")
            return
        end
    end

    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]����ս�����ˣ�", "ϵͳ֪ͨ")
    local own_family = lualib:GetCastleOwnFamily(castle_name)
    if own_family ~= "" then
        lualib:IO_SetCustomVarInt("castlewar_sgc_flag", 1)          --��Ԫ�ؾ�Ҫʹ��
        lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]��".."["..own_family.."]�л�ռ���ˣ�", "ϵͳ֪ͨ")
    end

    --����л�᳤��ȡ����
    lualib:SetCastleCustomVarInt(castle_name, "award_leader_week_count", 0)

    if castle_name == "����" then
        --�������ʱ��
        local castle_var = "����_atk_familys"
        lualib:IO_SetCustomVarStr(castle_var, "")   --T+Nʱ�����

        --�������������ȡ���
        lualib:IO_SetCustomVarStr("����_leader_weapon", "")
    end
end

function notify_family_war(player)
    if lualib:Player_GetGuidProp(player, lua_role_guild_id) == "" then
        return
    end

    if lualib:GetFamilyName(player) == "" then
        return
    end

    local wars = lualib:GetRunningFamilyWar(player)
    if wars == nil then return end
    for k in pairs(wars) do
        lualib:SysMsg_SendPromptMsg(player, "�л�������"..wars[k].."�л����ս����")
    end

    lualib:NotifyRunningFamilyWar(player)
end

function on_first_in_game(player)
    lualib:AddBuff(player, "���BUFF14", 7200)
    lualib:AddBuff(player, "������300", 7200)

    local playername = lualib:KeyName(player)
    lualib:SysMsg_SendBroadcastMsg("��ҡ���["..playername.."]��������;,������һȺ��Χ�ۣ�������ʶ�˺ö����ѣ���ʼ����;֮�ã�", "ϵͳ����")

    if lualib:Player_GiveItemBind(player, "ľ��", 1, "����Ʒ����һ�ν���Ϸ", player) then
        lualib:SysMsg_SendTriggerMsg(player, "�ѻ����Ʒ��ľ��")
    else
        lualib:SysMsg_SendTriggerMsg(player, "�����Ʒʧ�ܣ�ľ��")
    end

    if lualib:Player_GiveItemBind(player, "����1�����", 1, "����Ʒ����һ�ν���Ϸ", player) then
        lualib:SysMsg_SendTriggerMsg(player, "�ѻ����Ʒ������1�����")
    else
        lualib:SysMsg_SendTriggerMsg(player, "�����Ʒʧ�ܣ�����1�����")
    end


    lualib:Player_AddGold(player, 30000, true, "�ӽ�ң���һ�ν�����Ϸ��Ǯ����", player)
    lualib:Player_AddIngot(player, 0, true, "��Ԫ������һ�ν�����ϷԪ������", player)

    --�������
    local map_guid = lualib:Map_GetMapGuid("��ɽ��")
    local map_int = lualib:GetInt(map_guid, "experience")

    local item = {
        {
            {"����һ�ף���̬��", "����ս�ף��У�", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"�����ȣ�������", "˪�����ۣ��У�", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"��Ӱ", "�������(��)", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������","���������"},
        },
        {
            {"����һ�ף���̬��", "����ս�ף�Ů��", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"�����ȣ�������", "˪�����ۣ�Ů��", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"��Ӱ", "�������(Ů)", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������","���������"},
        },
    }


    --if map_int == 1 then
    local job = lualib:Job(player)
    local gender = lualib:Gender(player)

    lualib:Player_AddGold(player, 1000000, false, "����ǰ����", player)
    lualib:Player_AddIngot(player, 10000, false, "����ǰ����", player)

    for i = 1, #item[gender][job] do
        if lualib:AddItem(player, item[gender][job][i], 1, false, "��������", player) then
            lualib:TakeOn(player, item[gender][job][i])
        end
    end
    lualib:DelayCall(player, 500, "xinshoutao", "")
end

function xinshoutao(player)
    local item = {
        {
            {"����һ�ף���̬��", "����ս�ף��У�", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"�����ȣ�������", "˪�����ۣ��У�", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"��Ӱ", "�������(��)", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������","���������"},
        },
        {
            {"����һ�ף���̬��", "����ս�ף�Ů��", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"�����ȣ�������", "˪�����ۣ�Ů��", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������", },
            {"��Ӱ", "�������(Ů)", "��â��ͷ��", "��â�׻���", "��â������", "��â��ѥ��", "��â������","���������"},
        },
    }
    local gender = lualib:Gender(player)
    local job = lualib:Job(player)
    --�Զ���װ��
    for i = 1, #item[gender][job] do
        --	lualib:AddItem(player, equip_level_up[gender][i][1], 1, true, "���˷��ŵ���", player)

        lualib:TakeOn(player, item[gender][job][i])
    end
end

function active_player(player, request_type, times)

    local role_up_webDB = lualib:GetTempInt(player, "role_up_webDB") + 600
    local cur_times = lualib:GetAllTime()
    if role_up_webDB > cur_times then
        return;
    end
    local accountid = lualib:Player_GetAccountID(player)
    local account_name = lualib:AccountName(player)
    local serverid = lualib:GetZoneId()
    local role_name = lualib:Name(player);
    local level = lualib:Level(player);
    local job = lualib:Job(player);

    local url = string.format("http://api.hzyotoy.com:8800/api/putroleinfo.do?type=%d&zoneid=%d&userid=%d&role_guid=%s&level=%d&role_name=%s&job=%d"
    ,request_type, serverid, accountid, player, level, lualib:UrlEncode(role_name), job);

    lualib:GetURL(url, "do_nothing", player, 30)


    lualib:SetTempInt(player, "role_up_webDB", cur_times)
    if times == 0 then
        lualib:GetURL(url, "do_nothing_retry" .. request_type, player, 30)
    else
        lualib:GetURL(url, "do_nothing", player, 30)
    end
end

function do_nothing_retry2(player, errorcode, result)
    if errorcode ~= 0 then
        active_player(player, 2, 1);  --���Ե�½����
    end
end

function do_nothing_retry3(player, errorcode, result)
    if errorcode ~= 0 then
        active_player(player, 3, 1);--������������
    end
end

function do_nothing(player, errcode, result)
end

function on_msg_dlg_ack(dlg_id, player, button_id, param)
    if button_id ~= 0 then return end
    local x = lualib:X(player)
    if x > 280 then
        lualib:AcceptQuest(player, 1001)
    else
        lualib:AcceptQuest(player, 1101)
    end
end

function on_level_up(player, level)
    --��½��Ϣ����web����������վ���ɫ��Ҫ type=3���� ��������
    active_player(player, 3, 0)
    lualib:DelayCall(player, 1, "ս������:CalculatePower", "") --����ս����
    lualib:DelayCall(player, 1, "���γƺű�:LevelUp", ""..level) --�ȼ��ƺ�
    lualib:DelayCall(player, 1, "�������а��:mainLevel", "") --ȫְҵ�ȼ���
    --����ͽ����������
    process_apprentice_level_up(player, level)
    local playerlevel = lualib:Level(player)
    if playerlevel >= 23 then
        gonglue_xianshi(player) --����
    end
end




function level(player, npc)
    return ""
end

--ÿ��ǩ����ʾ
function on_login(player)
    lualib:DelayCall(player,1,"buff��Ч��Դչʾ:has_buff","")
    lualib:Player_MapMoveXY(player, "������", 100, 166, 3)
    lualib:DelayCall(player, 1, "����ͼ��:main", "")

    if lualib:GetClientType(player) == 2 then
        lualib:DelayCall(player, 1, "�����̳Ǳ�:on_player_login", "")--�̳�ͼ��
    end

    lualib:DelayCall(player, 1, "�������а��:mainLevel_Job", "")
    lualib:DelayCall(player, 1, "�������а��:mainLevel", "")

    --��½��һ��ս�����仯 ����ʾ
    lualib:SetInt(player, "PowerAlterShow", 0)
    lualib:DelayCall(player, 1, "ս������:CalculatePower", "") --��¼ս����
    --����
    local TestServerTime = lualib:GetConstVar("TestServerTime")
    local StartServerTime = lualib:GetConstVar("StartServerTime")
    local QQ = lualib:GetConstVar("QQ")
    local TestServerTime_int = lualib:Str2Time(TestServerTime)
    local StartServerTime_int = lualib:Str2Time(StartServerTime)
    local times = lualib:GetAllTime()
    local timesStr = lualib:Time2Str( "%Y-%m-%d %H:%M:%S", times)


    ------------------------------------ÿ�ձ�������start---------------------------
    if lualib:GetDayInt(player, "isResetVar") == 0 then
        lualib:SetDayInt(player, "isResetVar", 1)
        --������������
        lualib:SetDBNum("QMGift"..lualib:UserID(player), 0)
    end

    if lualib:Player_IsGM(player) ~= true then
        if TestServerTime_int > StartServerTime_int or TestServerTime == "" or TestServerTime == nil then
            TestServerTime_int = 0
        end

        if StartServerTime == "" or StartServerTime == nil then
            StartServerTime_int = 0
        end
        local s = ""
        local s1 = "��������QQȺ��"..QQ.."���˽�������Ϣ��"
        if times < StartServerTime_int and  times > TestServerTime_int then
            s = "���������ڳﱸ�׶Σ��޷���½����Ϸ����"..StartServerTime.."��ʽ�����������ڴ���"
            for i = 1, 2 do
                lualib:SysMsg_SendBroadcastMsg(s, "")
                lualib:SysMsg_SendBroadcastMsg(s1, "")
            end
            lualib:AddTimer(player, 723, 2000, 1, "kaifutiren")
            --lualib:Player_Kick(player)
        elseif times < TestServerTime_int then
            s = "�������ڿ���ǰ������Խ׶Σ�����"..TestServerTime.."�����׶Σ���ʱ��ɾ���������������ݣ���Ϸ����"..StartServerTime.."��ʽ�����������ڴ�������Ҽ���QQȺ��"..QQ.."�˽�������Ϣ��"
            for i = 1, 2 do
                lualib:SysMsg_SendBroadcastMsg(s, "")
                lualib:SysMsg_SendBroadcastMsg(s1, "")
            end
        end
    end

    local playerlevel = lualib:Level(player)
    local reinNum = lualib:GetInt(player,  "reinNum")
    --��½��Ϣ����web����������վ���ɫ��Ҫ type=2���� ��½����
    active_player(player, 2, 0)

    --check_forbid_role(player)
    spirit_on_login(player)
    family_on_login(player)
    check_player_login(player)
    online_gift_login(player)
    marry_load(player)
    check_first_bill(player)
    meiriqiandao_xianshi(player) --ÿ��ǩ��ͼ����ʾ
    QM_Icon_Show(player) --��������ͼ��
    mubiao_xianshi(player) --Ŀ��
    ---------------------------------------------------
    WY_Icon_Show(player)--��һ�ͼ��
    Login_GetWYAward(player)
    HF_on_login(player)
    ---------------------------------------------------

    if playerlevel >= 23 then
        gonglue_xianshi(player) --����
    end

    if lualib:Player_GetCustomVarInt(player, "vip6_suishen_cangku") == 1 then
        lualib:Player_SetCustomVarInt(player, "vip6_suishen_cangku", 0)
    end

    if lualib:Player_GetCustomVarInt(player, "vip7_ssyao") == 1 then
        lualib:Player_SetCustomVarInt(player, "vip7_ssyao", 0)
    end

    notify_family_war(player)

    local offline_times = lualib:GetAllTime() - lualib:Player_GetTimeProp(player,  lua_role_last_logout)
    offline_times = lualib:Player_GetCustomVarInt(player, "player_total_offline_times") + offline_times
    if offline_times > (1 * 24 * 3600) then offline_times = 1 * 24 * 3600 end
    lualib:Player_SetCustomVarInt(player, "player_total_offline_times", offline_times)

    lualib:AddTimer(player, -1, 1000, 1, "on_login_delay_timer")

    local vip_shangxian = lualib:GetVipRemain(player, 13)
    if vip_shangxian ~= 0 then
        local vip_sx = lualib:GetInt(player, "shangxiangonggao")
        local vip_player_name = lualib:Name(player)
        if vip_sx == 1 then
            local s = "����VIP��ҡ�"..vip_player_name.."�������ˣ�"
            lualib:SysMsg_SendBroadcastMsg(s, "")
        end
    end

    lualib:AddTimerEx(player, 116, 900000, -1, "fangchenmi", "")

    --����ʦͽ��¼����
    process_master_apprentice_login(player)
    lualib:AddTrigger(player,lua_trigger_add_exp,"add_exp") --ÿ�����Ӿ���ʱ����ã�vip����̳��е���Ҫ

    lingqujingyan_xianshi(player) --��ȡ����ͼ����ʾ
end

function fangchenmi(player)
    local msg = ""
    local AntiIndulge = lualib:Player_GetAntiIndulge(player)
    print(AntiIndulge)
    if AntiIndulge == 2 then
        return
    elseif AntiIndulge == 1 then
        msg = "�㵱ǰ�Ѿ����������״̬����ľ���������룬�뾡�콫���з�������֤��\n"
        msg = msg.."<@InfoIndulge *01*������>\n"
        msg = msg.."<@VerifyIndulge *01*��������֤>\n"
        lualib:NPCTalk(player, msg)
    elseif AntiIndulge == 0 then
        msg = "�㵱ǰ�Ѿ����������״̬���޾������棬�뾡�콫���з�������֤��"
        msg = msg.."<@InfoIndulge *01*������>\n"
        msg = msg.."<@VerifyIndulge *01*��������֤>\n"
        lualib:NPCTalk(player, msg)
    end
end

function InfoIndulge(player)
    lualib:ShowForm(player, "�����Ա�")
    return ""
end

function VerifyIndulge(player)
    local userid = lualib:Player_GetAccountID(player)
    lualib:SysMsg_SendWebMsg(player, "��������֤", "http://passport.173uu.com/verifygame/index.html?uid="..userid, "")
    return ""
end


------------------------------------��þ���ʱ����------------------------------------
function add_exp(player,exp)
    lualib:SetInt(player,"vip20_jinriexp",lualib:GetInt(player,"vip20_jinriexp")+exp)
end

function notify_spouse(player)
    local player_name = lualib:Player_GetStrProp(player,  lua_role_user_name)
    local spouse = lualib:Player_GetCustomVarStr(player, "��żGUID")

    if lualib:Player_GetIntProp(player,  lua_role_gender) ==  lua_gender_male then
        lualib:SysPromptMsg(spouse, "����ɷ������ˡ�")
    else
        lualib:SysPromptMsg(spouse, "������������ˡ�")
    end

end



function on_login_delay_timer(player, timer_id)
    if lualib:GetBindIngot(player) < 1000000 then
        lualib:AddBindIngot(player,100000,"","")
    end
    if lualib:Player_IsGM(player) then
        lualib:AddBuff(player,"����",86400)
        lualib:Player_SetGhost(player, true)
        lualib:SysMsg_SendWarnMsg(player, "���ѽ�������״̬��")
        lualib:Player_SetInvincible(player, true)
        lualib:SysMsg_SendWarnMsg(player, "���ѽ����޵�״̬��")
    end

    local seconds = lualib:Player_GetCustomVarInt(player, "player_total_offline_times")
    local day = math.floor(seconds / 3600 / 24)
    local hour = math.floor((seconds - day * 24 * 3600) / 3600)
    local minute = math.floor((seconds - math.floor(seconds / 3600) * 3600) / 60)
    local second = math.floor(seconds - math.floor(seconds / 60) * 60)

    if seconds < 3600 then
        lualib:SysMsg_SendWarnMsg(player, "ϵͳ֪ͨ������Ե�������˴���ȡ���ߺ����߾��飡ע������ʱ�䲻�ۼƣ���Ҫ�������ߣ�")
        return
    end

    lualib:SysMsg_SendWarnMsg(player, "ϵͳ֪ͨ������Ե�������˴���ȡ���ߺ����߾��飡ע������ʱ�䲻�ۼƣ���Ҫ�������ߣ�")
    notify_spouse(player)
end

function on_logout(player)
    local npc_guid_cangku = lualib:Player_GetCustomVarStr(player, "yang_cangkuguid_name")
    local npc_guid_shangdian = lualib:Player_GetCustomVarStr(player, "yang_shangdianguid_name")
    --����ʦͽ�ǳ�����
    process_master_apprentice_logout(player)
    if "" ~= npc_guid_cangku then
        lualib:Npc_Remove(npc_guid_cangku)
    end
    if "" ~= npc_guid_shangdian then
        lualib:Npc_Remove(npc_guid_shangdian)
    end

    online_gift_logout(player)
end

function on_timer_ysax_dgwf_call_back_func(guid, timer_id)
    if timer_id ==  lua_ysax_dgwf_timer then
        GenMonster_ysax_dgwf()
    end
end

function GenMonster_ysax_dgwf()
    --�ж��м��ŵ�ͼ�ڱ�GS��
    local map_table = {{"��ɽ��Ѩ1", 0, 181, 59,  "Ѱ��С��1"},
                       {"��ɽ��Ѩ2", 0, 156, 274, "Ѱ��С��2"},
                       {"��ɽ��Ѩ3", 0, 250, 57,  "Ѱ��С��3"},
                       {"��ɽ��Ѩ4", 0, 279, 240, "Ѱ��С��4"},
                       {"��ɽ��Ѩ5", 0, 350, 161, "Ѱ��С��5"}}
    local map_count = 0
    for i = 1, table.getn(map_table) do
        if lualib:Map_IsInGS(map_table[i][1]) == true then
            map_count = map_count + 1
            map_table[i][2] = map_count
        end
    end

    if map_count == 0 then return "" end

    --�Ӵ����ڱ�GS�ĵ�ͼ�����ѡһ��
    lualib:GenRandom(1, map_count)
    local cur_map_index = lualib:GenRandom(1, map_count)
    local cur_map_keyname = ""
    for i = 1, table.getn(map_table) do
        if map_table[i][2] == cur_map_index then
            cur_map_keyname = map_table[i][1]
            cur_map_index = i
            break
        end
    end

    if cur_map_keyname == "" then return "" end

    --��������ĵ�ͼ��ˢ��
    local map = lualib:Map_GetMapGuid(cur_map_keyname)
    if map == "" then return "" end

    local monster = lualib:Map_GenSingleMonster(map, map_table[cur_map_index][3],
            map_table[cur_map_index][4], 16, 3,
            map_table[cur_map_index][5], true)
    if monster == "" then return "" end
    lualib:Print(cur_map_keyname.."��"..map_table[cur_map_index][5].."���ɳɹ������꣺["..map_table[cur_map_index][3].."��"..map_table[cur_map_index][4].."]��")
    return ""
end


function on_gp(player, gp_runtime, gp, diff_avg_tick)
    local content = "�밮����Ϸ������["..lualib:Name(player).."] ʹ����ң��ѱ�ϵͳ��¼�ڰ���"
    lualib:SysMsg_SendWarnMsg(player, content)
    lualib:SetFbdLogin(lualib:Name(player), 2, 600, content)
    lualib:Player_Kick(player)
end

function shijie_boss(guid, timer_id)
    local a = lualib:GenRandom(1, #map_name_table)
    local b = lualib:GenRandom(1, #map_name_table)
    local g = lualib:GenRandom(1, #map_name_table)
    local mon_name = "��ħ�����"
    local map_name = "����"
    local map_guid =  lualib:Map_GetMapGuid(map_name)
    local map_time_zdy = lualib:Map_GetCustomVarInt(map_guid, "map_time_zdy")
    local npc_time_zdy = lualib:Map_GetCustomVarInt(map_guid, "npc_time_zdy")

    local mon_ma_name1 = "��ѪҰ��"
    local mon_ma_name2 = "ϡ������"
    local map_time_ma_zdy = lualib:Map_GetCustomVarInt(map_guid, "map_time_ma_zdy")
    local quxiao_duyu_jc = lualib:Map_GetCustomVarInt(map_guid, "quxiao_duyu_jc")

    --local npc_guid = lualib:Map_GenNpc(map, "����ֿ����Ա", player_x, player_y, 1, 3)

    map_time_zdy = map_time_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "map_time_zdy", map_time_zdy)

    map_time_ma_zdy = map_time_ma_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "map_time_ma_zdy", map_time_ma_zdy)

    npc_time_zdy = npc_time_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "npc_time_zdy", npc_time_zdy)

    for q, r in pairs(npc_timer_table) do
        if npc_time_zdy == r[1] then
            lualib:SysMsg_SendBroadcastMsg("�����������������˽���"..r[2].."������ش�½��", "ϵͳ����")
            lualib:SysMsg_SendBroadcastMsg("�����������������˽���"..r[2].."������ش�½��", "ϵͳ����")
            lualib:SysMsg_SendBroadcastMsg("�����������������˽���"..r[2].."������ش�½��", "ϵͳ����")
        end
    end

    if npc_time_zdy > 3593 then
        for n, m in pairs(map_name_table) do
            if a == n then
                local map = lualib:Map_GetMapGuid(m[1])
                local map_xy_table = lualib:MapRndPos(m[1])
                local map_x = map_xy_table["x"]
                local map_y = map_xy_table["y"]
                local npc_guid = lualib:Map_GenNpc(map, "��������", map_x, map_y, 1, 3)
                lualib:SysMsg_SendBroadcastMsg("�����������������˽�����ش�½����Ե�����߿ɹ��������ֵ�ɽ��������������������ڡ�"..m[2].."���ȴ���Ե�ˣ���", "ϵͳ����")
                lualib:SysMsg_SendBroadcastMsg("�����������������˽�����ش�½����Ե�����߿ɹ��������ֵ�ɽ��������������������ڡ�"..m[2].."���ȴ���Ե�ˣ���", "ϵͳ����")
                lualib:SysMsg_SendBroadcastMsg("�����������������˽�����ش�½����Ե�����߿ɹ��������ֵ�ɽ��������������������ڡ�"..m[2].."���ȴ���Ե�ˣ���", "ϵͳ����")
                lualib:Map_SetCustomVarInt(map_guid, "npc_time_zdy", 0)
            end
        end
    end

    if quxiao_duyu_jc == 0 then
        for i, p in pairs(timer_table) do
            if map_time_zdy == p[1] then
                lualib:SysMsg_SendBroadcastMsg("����BOSS["..mon_name.."]����"..p[2].."���Ӻ�����ش�½������ս����ʿ������׼����", "ϵͳ����")
            end
        end

        if map_time_zdy == 10800 then
            for k, v in pairs(map_name_table) do
                if b == k then
                    local map = lualib:Map_GetMapGuid(v[1])
                    local map_xy_table = lualib:MapRndPos(v[1])
                    local map_x = map_xy_table["x"]
                    local map_y = map_xy_table["y"]
                    lualib:Map_GenSingleMonster(map, map_x, map_y, 1, 1, mon_name, false)
                    lualib:SysMsg_SendBroadcastMsg("����BOSS["..mon_name.."]�����ڵ�ͼ"..v[2].."������ս����ʿ��Ѹ��ǰ����ɱ��", "ϵͳ����")
                    lualib:SysMsg_SendBroadcastMsg("����BOSS["..mon_name.."]�����ڵ�ͼ"..v[2].."������ս����ʿ��Ѹ��ǰ����ɱ��", "ϵͳ����")
                    lualib:SysMsg_SendBroadcastMsg("����BOSS["..mon_name.."]�����ڵ�ͼ"..v[2].."������ս����ʿ��Ѹ��ǰ����ɱ��", "ϵͳ����")
                    lualib:Map_SetCustomVarInt(map_guid, "quxiao_duyu_jc", 1)
                end
            end
        end
    end

    for c, d in pairs(ma_timer_table) do
        if map_time_ma_zdy == d[1] then
            lualib:SysMsg_SendBroadcastMsg("����ϡ�����ｫ��"..d[2].."���Ӻ�����ش�½��ֻ��һֻŶ������ǲ�׽���ĺ�ʱ��Ŷ��", "ϵͳ����")
            lualib:SysMsg_SendBroadcastMsg("����ϡ�����ｫ��"..d[2].."���Ӻ�����ش�½��ֻ��һֻŶ������ǲ�׽���ĺ�ʱ��Ŷ��", "ϵͳ����")
            lualib:SysMsg_SendBroadcastMsg("����ϡ�����ｫ��"..d[2].."���Ӻ�����ش�½��ֻ��һֻŶ������ǲ�׽���ĺ�ʱ��Ŷ��", "ϵͳ����")
        end
    end

    if map_time_ma_zdy > 28798 then	--8Сʱ
        for e, f in pairs(map_name_table) do
            if g == e then
                local map = lualib:Map_GetMapGuid(f[1])
                lualib:Map_BatchGenMonster(map, mon_ma_name1, 5, false)
                lualib:Map_BatchGenMonster(map, mon_ma_name2, 1, false)
                lualib:SysMsg_SendBroadcastMsg("����ϡ�������������ش�½�ġ�"..f[2].."����ֻ��һֻŶ����Ҫ��׽����Ӣ��ץ��ʱ���ˡ�", "ϵͳ����")
                lualib:SysMsg_SendBroadcastMsg("����ϡ�������������ش�½�ġ�"..f[2].."����ֻ��һֻŶ����Ҫ��׽����Ӣ��ץ��ʱ���ˡ�", "ϵͳ����")
                lualib:SysMsg_SendBroadcastMsg("����ϡ�������������ش�½�ġ�"..f[2].."����ֻ��һֻŶ����Ҫ��׽����Ӣ��ץ��ʱ���ˡ�", "ϵͳ����")
                lualib:Map_SetCustomVarInt(map_guid, "map_time_ma_zdy", 0)
            end
        end
    end
end

function on_add_exp(player, exp)
    process_item_add_exp(player, tonumber(exp))
    process_horse_add_exp(player, tonumber(exp))
end

function check_player_login(player)
    local last_login_day = lualib:Player_GetCustomVarInt(player, "last_login_day")

    local now = lualib:GetAllDays(0)

    local off_day = now - last_login_day

    if off_day > 1 then
        --����1�죬���¼���
        lualib:Player_SetCustomVarInt(player, "login_days", 1)
    elseif off_day == 1 then
        --������¼���ۼ�
        local cur_days = lualib:Player_GetCustomVarInt(player, "login_days")
        lualib:Player_SetCustomVarInt(player, "login_days", cur_days + 1)
    end

    lualib:Player_SetCustomVarInt(player, "last_login_day", now)
    lualib:OnGloryTrigger(player, lua_glory_trigger_Login, "", 0, "", "")

    lualib:AddTimer(player, 0, 60000, -1, "CheckOnlineTimer")

    local player_guild = lualib:GuildGuid(player)

    if player_guild ~= "0" and player_guild ~= "" then--��ɫ����ʱ�ж��Ƿ����л�
        lualib:OnGloryTrigger(player, lua_glory_trigger_join_family, "", 0, "", "")
        --lualib:Print("��ҵ��л�"..player_guild.."")
    end

end

function CheckOnlineTimer(player, timer_id)
    lualib:OnGloryTrigger(player, lua_glory_trigger_OnlineTime, "", 0, "", "")
end

function chuandaiqian(player, item, item_id, item_keyname)
    lualib:DelayCall(player, 1, "ս������:updatePower", "")--����ս����
    if lualib:Item_GetSubType(player, item) == 10 then
        if item_keyname == "�����ر����" then
            lualib:AddBuff(player, "����", 0)
        elseif item_keyname == "������������" then
            lualib:AddBuff(player, "����", 0)
        end
    else
        return
    end
end

function tuozhuangbei(player, item, item_id, item_keyname)
    lualib:DelayCall(player, 1, "ս������:updatePower", "")--����ս����
    if lualib:Item_GetSubType(player, item) == 10 then
        if item_keyname == "�����ر����" then
            lualib:DelBuff(player, "����")
        elseif item_keyname == "������������" then
            lualib:DelBuff(player, "����")
        end
    end

    --ͬ��ѫ��
    local xz_table = {"ͬ��ѫ��һ��", "ͬ��ѫ�¶���", "ͬ��ѫ������", "ͬ��ѫ���ļ�", "ͬ��ѫ���弶", "ͬ��ѫ������" }
    for i = 1, #xz_table do
        if item_keyname == xz_table[i] then
            lualib:DelBuff(player, "ͬ������")
            break
        end
    end
    return
end

function starWarTime(guid, id, times)
    local familys = lualib:GetAllFamilys()
    local familys_str = ""
    for _, v in pairs(familys) do
        familys_str = familys_str..v.."&"
    end

    if not lualib:StartCastleWar("����", familys_str, times, 7200) == false then
        return false
    end
end

--------------ɱ�˻ص�------------------
function on_trigger_kill(killer, victim)
    victim_name = lualib:KeyName(victim)

    if lualib:Monster_IsMonster(victim) and lualib:Monster_Type(victim_name) == 2 then
        --Ŀ��ϵͳ����ɱ1ֻ��Ӣ��
        if lualib:GetInt(killer,"mubiao_chumo_1") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 1 then
                lualib:SetInt(killer,"mubiao_chumo_1",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ1ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ1ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ10ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_2") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 10 then
                lualib:SetInt(killer,"mubiao_chumo_2",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ10ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ10ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ100ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_3") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 100 then
                lualib:SetInt(killer,"mubiao_chumo_3",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ100ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ100ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ500ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_4") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 500 then
                lualib:SetInt(killer,"mubiao_chumo_4",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ500ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ500ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ1000ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_5") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 1000 then
                lualib:SetInt(killer,"mubiao_chumo_5",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ1000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ1000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ2000ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_6") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 2000 then
                lualib:SetInt(killer,"mubiao_chumo_6",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ2000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ2000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ5000ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_7") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 5000 then
                lualib:SetInt(killer,"mubiao_chumo_7",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ5000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ5000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ10000ֻ��Ӣ��
        elseif lualib:GetInt(killer,"mubiao_chumo_8") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 10000 then
                lualib:SetInt(killer,"mubiao_chumo_8",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ10000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ10000ֻ��Ӣ�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --��ħ����+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
        end
    end

    if lualib:Monster_IsMonster(victim) and lualib:Monster_Type(victim_name) == 4 then
        --Ŀ��ϵͳ����ɱ1ֻboss��
        if lualib:GetInt(killer,"mubiao_boss_1") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 1 then
                lualib:SetInt(killer,"mubiao_boss_1",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ1ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ1ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ10ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_2") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 10 then
                lualib:SetInt(killer,"mubiao_boss_2",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ10ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ10ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ50ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_3") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 50 then
                lualib:SetInt(killer,"mubiao_boss_3",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ50ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ50ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ100ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_4") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 100 then
                lualib:SetInt(killer,"mubiao_boss_4",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ100ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ100ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ200ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_5") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 200 then
                lualib:SetInt(killer,"mubiao_boss_5",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ200ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ200ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ500ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_6") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 500 then
                lualib:SetInt(killer,"mubiao_boss_6",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ500ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ500ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --Ŀ��ϵͳ����ɱ1000ֻboss��
        elseif lualib:GetInt(killer,"mubiao_boss_7") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 1000 then
                lualib:SetInt(killer,"mubiao_boss_7",1)
                lualib:SysMsg_SendBoardMsg(killer, "Ŀ��׷��", "����ɱ1000ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ1000ֻboss�֡��Ѵ�ɣ����#COLORCOLOR_GREENG#Ŀ�����#COLOREND#��ȡ�����ɣ�")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss����+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
        end
    end
end

--���߹һ�

function on_pre_logout(player, exit_type)
    if tonumber(exit_type) == 1 then
        local guaji_level = lualib:Level(player)
        if	guaji_level < 20 then
            return true
        else
            if		guaji_level >= 20 and guaji_level < 40 then
                local rx = lualib:GenRandom(-8,8)
                local ry = lualib:GenRandom(-8,8)
                local x = 237 + rx
                local y = 303 + ry
                lualib:SetOffline(player, 7200)
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("��ɽ��"), player, x, y, 10)
                return false
            elseif	guaji_level >= 40 and guaji_level < 50 then
                local rx = lualib:GenRandom(-8,8)
                local ry = lualib:GenRandom(-8,8)
                local x = 237 + rx
                local y = 228 + ry
                lualib:SetOffline(player, 7200)
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("����"), player, x, y, 10)
                return false
            elseif	guaji_level >= 50  then
                local rx = lualib:GenRandom(-8,8)
                local ry = lualib:GenRandom(-8,8)
                local x = 327 + rx
                local y = 299 + ry
                lualib:SetOffline(player, 7200)
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("���ٳ�"), player, x, y, 10)
                return false
            end

        end
    else
        return true
    end

end

--���������

-- ����

function on_ride_request(player)
    local buff_table = {"��é�˱���", "ľ���˱���", "��֩�����", "������", "���˱���", "����ս������", "��â����", "аħ��ż����", "��������", "������������", "����๤����", "����๤����", "������������", "��������", "������Գ����", "�޶����", "Ұ�Ǳ���", "���ޱ���", "����ţħ����", "ţħ��������", "���߱���", "��ˮ�߱���", "���Ǳ���", "��ū����", "ɢ������", "ɳʯħ����", "��ħ����", "ҹ��ɮ����", "�ڰ��̿ͱ���", "����ɮ����", "��ԭ��ʿ����", "Ѫ��ʦ����", "����������", "�ɵ����ñ���", "����ս������", "ʬū��ͷ����", "��ʬ����", "�ױ���ʬ����", "Ĺ���������", "��ڤʬ������", "¹����", "ǧ����ħ����", "��é���˱���", "��éа�˱���", "��֩�����", "����֩�����", "�ú����", "�ױ�Գ�����", "Գ�����", "�ɶ����", "�������", "���Ǳ���", "���߱���", "���߱���", "���߱���", "���߱���", "���Ա���", "�Źֵ��ͱ���", "���浶�ֱ���", "˫�������ֱ���", "ħ������", "���ޱ���", "��ɮ����", "�������߱���", "Ӱ�̱���", "����սʿ����", "�������ñ���", "�����ñ���", "��ө����", "ħө����", "а�����", "ʳ�˻�����", "��ԭ��ʿ����", "��ԭ��ʿ����", "����ţħ����", "ţħ��ʿ����", "ţħ��������", "��ʬ����", "ʬ������", "��ʬ����", "���ʬū����", "����ʬū����", "ʬū����", "���ñ�������", "��ĸ�����", "С�����", "�����", "ţ����", "������", "���������", "�綾�����", "ħ�߱���", "ħ�Ǳ���", "ħԳ����", "��ʯ���ܱ���", "ţħ��������", "ħ���������", "ħ��Ы�ӱ���", "ħ��ɳ�����", "��ħ��������", "��ս��ħ����", "��ħū�ͱ���", "ҹ�����", "��ħͳ�����", "��ħ��������", "��ħ��������", "��ħ�ȷ����", "��ħ�����", "������ֱ���", "ʯ�������", "�ؾ���������", "��ǯз����", "��ħ�̴ӱ���", "��ħ��������", "�ؾ���������", "���������", "�����ֱ���", "����ҩ��", "�䶷���鲼����", "�䶷���鲼��Ů", "�䶷������ս����", "�䶷������ս��Ů", "�䶷��Ԫ��������", "�䶷��Ԫ������Ů", "�䶷�����������", "�䶷���������Ů", "�䶷���ƽ�������", "�䶷���ƽ�����Ů", "�䶷�����ս����", "�䶷�����ս��Ů", "�䶷������ս����", "�䶷������ս��Ů", "�䶷������ս����", "�䶷������ս��Ů", "�䶷������ս����", "�䶷������ս��Ů", "�䶷����ϰ��ʦ����", "�䶷����ϰ��ʦ��Ů", "�䶷���ϳ�����", "�䶷���ϳ���Ů", "�䶷��ħ��������", "�䶷��ħ������Ů", "�䶷�����޳�����", "�䶷�����޳���Ů", "�䶷��ʥ�鷨����", "�䶷��ʥ�鷨��Ů", "�䶷�����뷨����", "�䶷�����뷨��Ů", "�䶷�����η�����", "�䶷�����η���Ů", "�䶷��Ǭ��������", "�䶷��Ǭ������Ů", "�䶷�����ĵ�����", "�䶷�����ĵ���Ů", "�䶷����ħ������", "�䶷����ħ����Ů", "�䶷������������", "�䶷����������Ů", "�䶷��̫��������", "�䶷��̫������Ů", "�䶷�����������", "�䶷���������Ů", "�䶷���춦������", "�䶷���춦����Ů", "�䶷������", "��Сҩ��", "����2", "������"}
    local hashorse = lualib:Attr(player, 200)

    if hashorse == 1 then
        lualib:MsgBox(player, "���Ѿ��������״̬�ˣ�")
        return
    end
    for i = 1, #buff_table do
        if lualib:HasBuff(player, buff_table[i]) == true then
            lualib:MsgBox(player, "����״̬�޷��������Ҽ����BUFFͼ��ȡ��BUFF���ٽ��г���")
            return
        end
    end
    lualib:ProgressBarStart(player, 5000, "������", "on_Horse_true", "on_Horse_false", "")
end

function on_Horse_true(player)
    lualib:Ride(player)
    return true
end

function on_Horse_false(player)
    lualib:SysMsg_SendTriggerMsg(player, "�������")
    return true
end

-- ����
function on_unride_request(player)
    local hashorse = lualib:Attr(player, 200)
    if hashorse == 2 then--
        lualib:MsgBox(player, "�㻹û����ˣ���������״̬�ˣ�")
    else
        lualib:UnRide(player)
    end

    return true
end

local rongyaozhuangbei = {
    ["ս��֤֮1"] = 1000,
    ["ս��֤֮2"] = 5000,
    ["ս��֤֮3"] = 15000,
    ["Ѫ��֮ѥ"] = 15000,
    ["ս��֤֮4"] = 32000,
    ["Ѫ�껤��(��)"] = 32000,
    ["Ѫ�껤��(ʥ)"] = 32000,
    ["Ѫ��ͷ��"] = 32000,
    ["ս��֤֮5"] = 55000,
    ["Ѫ������"] = 55000,
    ["Ѫ���ָ(��)"] = 55000,
    ["Ѫ���ָ(ʥ)"] = 55000,
    ["ս��֤֮"] = 88000,
    ["����"] = 88000,
    ["ս�񱦼�(��)"] = 88000,
    ["ս�񱦼�(Ů)"] = 88000,
    ["����֤֮1"] = 1000,
    ["����֤֮2"] = 5000,
    ["����֤֮3"] = 15000,
    ["����֮ѥ"] = 15000,
    ["����֤֮4"] = 32000,
    ["���ǻ���(��)"] = 32000,
    ["���ǻ���(ʥ)"] = 32000,
    ["����ͷ��"] = 32000,
    ["����֤֮5"] = 55000,
    ["��������"] = 55000,
    ["���ǽ�ָ(��)"] = 55000,
    ["���ǽ�ָ(ʥ)"] = 55000,
    ["����֤֮"] = 88000,
    --["ŭ��"] = 88000,
    ["������(��)"] = 88000,
    ["������(Ů)"] = 88000,
    ["����֤֮1"] = 1000,
    ["����֤֮2"] = 5000,
    ["����֤֮3"] = 15000,
    ["����֮ѥ"] = 15000,
    ["����֤֮4"] = 32000,
    ["���令��(��)"] = 32000,
    ["���令��(ʥ)"] = 32000,
    ["����ͷ��"] = 32000,
    ["����֤֮5"] = 55000,
    ["��������"] = 55000,
    ["�����ָ(��)"] = 55000,
    ["�����ָ(ʥ)"] = 55000,
    ["����֤֮"] = 88000,
    ["��ʸ"] = 88000,
    ["������(��)"] = 88000,
    ["������(��)"] = 88000,
}

--------------------------����װ��֮ǰ����-------------------------------------
function on_pre_equip(player,item,item_id,item_key)
    local shizhuang = lualib:KeyName(item)

    if rongyaozhuangbei[shizhuang] ~= nil then
        if lualib:GetInt(player, "jyjjc_rongyao") >= rongyaozhuangbei[shizhuang] then
        else
            lualib:SysMsg_SendWarnMsg(player,"��װ����Ҫ"..rongyaozhuangbei[shizhuang].."��ҫ�ſ�װ����")
            return false
        end
    end

    return true
end

function kaifutiren(player)
    lualib:Player_Kick(player)
    return true
end

function on_post_monster_die(monster, killer)
    if 4 == lualib:Monster_Type(lualib:KeyName(monster)) then
        if QM_isWithinTime() then
            --��ɱBOSS�ʱ���ڵ������
            lualib:Map_GenItemRnd(lualib:MapGuid(killer), lualib:X(monster), lualib:Y(monster), 1, "����", 1, true, 0)
        end
        ------------------------------------------------------------------------------------
        if WY_JudgeTime() then
            local rand = lualib:GenRandom(0, 1)
            if rand == 1 then
                lualib:Map_GenItemRnd(lualib:MapGuid(killer), lualib:X(monster), lualib:Y(monster), 1, "��Һ", 1, true, 0)
            end
        end
        ------------------------------------------------------------------------------------
    end
end

function on_billin(player,dc_yb)
    --�Ϸ����ֵ
    HF_on_bill(player, dc_yb)
    ---------------------------------------------------------------------
    --Billin_RechargeYB(player, dc_yb)
    ---------------------------------------------------------------------
    bill_ranking(player)
end

function bill_ranking(player)
    --��ֵ�ص�
    local bill_max = lualib:GetTotalBill(player)
    local bill_name = lualib:Name(player)
    local bill_account = lualib:AccountName(player)
    local bill_ranking_t = lualib:GetDBStr("bill_ranking_t")

    local bill_name = lualib:Name(player)
    if bill_max > 0 then
        if bill_ranking_t == "" then
            bill_ranking_t = {}
            bill_ranking_t[1] = {bill_max, bill_name, bill_account}
            lualib:SetDBStrEx("bill_ranking_t", serialize(bill_ranking_t), 0)
        else
            bill_ranking_t = deserialize(bill_ranking_t)
            local is_ranking = false
            for i = 1, #bill_ranking_t do
                if bill_account == bill_ranking_t[i][3] then
                    bill_ranking_t[i][1] = bill_max
                    is_ranking = true
                end
            end

            if is_ranking == false then
                if #bill_ranking_t < 10 then
                    bill_ranking_t[#bill_ranking_t + 1] = {bill_max, bill_name, bill_account}
                else
                    bill_ranking_t[11] = {bill_max, bill_name, bill_account}
                end
            end


            table.sort(bill_ranking_t,function(v1,v2) return v1[1] > v2[1] end)
            bill_ranking_t[11] = nil
            lualib:SetDBStrEx("bill_ranking_t", serialize(bill_ranking_t), 0)
        end
    end
end