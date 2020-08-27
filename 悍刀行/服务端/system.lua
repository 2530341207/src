local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("include/����ս�淨")
require("system/�Զ����")
require("system/online_gift")
require("system/��ֵ���")
require("system/΢�����")
require("system/�鵤��ҩ")
require("system/��ɽׯ")
require("form/�ճ������")
require("system/��������")


function on_system_start()

    if lualib:GetDBNum("hequbs") == 0 then
        lualib:SetDBNumEx("hequbs", 1, 4)
    end
    lualib:AddTrigger("", lua_trigger_login, "on_player_login");
    lualib:AddTrigger("", lua_trigger_add_exp, "on_player_add_exp");		--��������ʱ
    lualib:AddTrigger("", lua_trigger_pre_logout, "on_pre_logout");
    lualib:DelayCall("", 1, "OnFirstCastleWar", "");		--��һ�ι���ս
    lualib:AddTrigger("0",  lua_trigger_billin, "on_trigger_billin")--��ֵ�ص�
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")				--��������
    lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")				--����Ҵ���
    lualib:AddTrigger("0",  363, "on_ride_request")  --������
    lualib:AddTrigger("0",  364, "on_unride_request")  --������
    lualib:AddTrigger("0", 302, "on_post_equip") --��������
    lualib:AddTrigger("0",  lua_trigger_player_relive, "on_player_relive") --����ǰ�ص�
    lualib:AddTrigger("0",  lua_trigger_post_die, "on_post_die") --����ʱ�ص�
    lualib:AddTrigger("0", lua_trigger_hack_check, "on_hack_check");
    lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2");
    lualib:AddTrigger("0",  356, "on_player_pre_die")  --��ǰ����
    lualib:AddTrigger("0", lua_trigger_post_drop_one, "on_post_drop_one");
    lualib:AddTrigger("",  lua_trigger_item_pickup, "on_item_pickup") --��ɫʰȡ����ʱ�ص�.
    lualib:AddTrigger("0",  lua_trigger_monster_post_die, "on_post_monster_die")  --��ǰ����
    lualib:AddTrigger("0",  lua_trigger_family_ntf, "on_family_ntf")  --�лᴴ��
    lualib:AddTrigger("0", lua_trigger_family_member_ntf, "on_family_member_ntf") --�л���Ա�䶯
    lualib:AddTrigger("0", lua_trigger_role_pre_harm , "on_pre_harm") --���˺�ʱ
    lualib:AddTrigger("0", lua_trigger_pre_equip, "on_pre_equip") --��װ��֮ǰ����
    lualib:AddTrigger("0", lua_trigger_pre_un_equip, "on_pre_un_equip") --��װ��֮ǰ����
    lualib:AddTrigger("0",  lua_trigger_player_pre_die, "on_pre_player_die")
    lualib:AddTrigger("0",  lua_trigger_kill, "on_kill")--ɱ�ֻص�
    lualib:AddTrigger("0", lua_trigger_pre_spell, "on_pre_spell"); --ʹ�ü���ǰ
    lualib:AddTrigger("0", 307, "on_spell"); --ʹ�ü���
    lualib:AddTrigger("0", lua_trigger_item_appear, "on_item_appear");
    lualib:AddTrigger("0", lua_trigger_item_disappear, "on_item_disappear");
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start") --���ǿ�ʼ
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end") --���ǽ���
    lualib:AddTrigger("0", lua_trigger_enter_map, "on_enter_map") --�����ͼʱ
    lualib:AddTrigger("0", 374, "on_pre_harm")-- 374	lua_trigger_role_pre_harm	��ɫ�ܵ��˺�ʱ���������ع̶��˺���ֵ

end


function on_enter_map(player)
    if lualib:GetInt(player, "huishou_10") == 1 then
        lualib:Player_RunScript(player,"�Զ��һ�:baobao","")
    end
end



----------------------------���ǿ�ʼ
function on_castle_war_start(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SetDBNum("shengeshuxing", 1)
    lualib:SetInt("0", "war_start", 1)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]����ս��ʼ�ˣ�", "ϵͳ֪ͨ")
    lualib:SetDBNumEx("shengeshuxing", 1, 2)

    if lualib:GetDBNum("diyicishuaxin") == 0 then   -- ��һ�ι��Ǽ�¼����
        lualib:SetDBNumEx("diyicishuaxin", 1, 2)
    end
    return
end



----------------------------���ǹر�

function on_castle_war_end(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SetDBNum("shengeshuxing", 0)
    lualib:SetDBNumEx("shengeshuxing", 0, 2)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]����ս�����ˣ�", "ϵͳ֪ͨ")
    lualib:SetInt("0", "war_start", 0)
    local own_family = lualib:GetCastleOwnFamily(castle_name)
    if own_family ~= "" then
        lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]��".."["..own_family.."]�л�ռ���ˣ�", "ϵͳ֪ͨ")
        lualib:SetDBNumEx(lualib:GetFamilyByName(own_family).."_gongcheng", 1, 6)
        lualib:SysMsg_SendBroadcastMsg("["..own_family.."]�л�᳤�ɵ�����ɳ����������ȡ��ʯ������", "ϵͳ֪ͨ")
        if lualib:GetDBNum("diyicgongcheng") == 0 then
            lualib:SetDBNumEx("diyicgongcheng", 1, 2)
        end
    end

end


function on_pre_spell(player, skill_id, skill_key,x,y,mb,skillkey)

    if lualib:Monster_IsMonster(player) and lualib:Name(player) ~= "��ƨ��" then
        local mubiao_guid = lualib:Monster_GetCurTarget(player)
        if mubiao_guid ~= "" then
            if lualib:Monster_IsMonster(mubiao_guid) then
                local name = lualib:Monster_GetMaster(mubiao_guid)
                if name ~= "" then
                    local target_Guid = lualib:Name2Guid(name)
                    if target_Guid ~= "" then
                        lualib:Monster_SetAttackTarget(player, target_Guid)
                    end
                end
            end
        end
    end

    return true
end




function on_kill(killer, actor)
    if lualib:Player_IsPlayer(killer) then
        if lualib:Player_IsPlayer(actor) then
            if lualib:HasBuff(actor,"��������") then
                lualib:AddIntegral(killer, 50000, "��Ӱ󶨽��:ԭ��", "������")
                lualib:DelBuff(actor, "��������")
                local level = lualib:Level(actor)
                lualib:SetLevel(actor, level - 5)
                lualib:SysMsg_SendBroadcastColor("��"..lualib:Name(killer).."����ɱ��Я�����������š���["..lualib:Name(actor).."]�������50000��ʯ�Ľ�����", "", 1, 12)
                lualib:SetInt(killer, "ls_zs", lualib:GetInt(killer, "ls_zs") + 1)
            end
        end
    end
end



local wupinsz = {
    ["Ь��2"] = {0, 1},
    ["����2"] = {0, 1},
    ["��ָ2"] = {0, 1},
    ["����2"] = {0, 1},
    ["����2"] = {0, 1},
    ["ͷ��2"] = {0, 1},
    ["Ь��3"] = {0, 1},
    ["����3"] = {0, 1},
    ["��ָ3"] = {0, 1},
    ["����3"] = {0, 1},
    ["����3"] = {0, 1},
    ["ͷ��3"] = {0, 1},
    ["Ь��4"] = {0, 2},
    ["����4"] = {0, 2},
    ["��ָ4"] = {0, 2},
    ["����4"] = {0, 2},
    ["����4"] = {0, 2},
    ["ͷ��4"] = {0, 2},
    ["Ь��5"] = {0, 2},
    ["����5"] = {0, 2},
    ["��ָ5"] = {0, 2},
    ["����5"] = {0, 2},
    ["����5"] = {0, 2},
    ["ͷ��5"] = {0, 2},
    ["Ь��6"] = {0, 3},
    ["����6"] = {0, 3},
    ["��ָ6"] = {0, 3},
    ["����6"] = {0, 3},
    ["����6"] = {0, 3},
    ["ͷ��6"] = {0, 3},
    ["Ь��7"] = {0, 3},
    ["����7"] = {0, 3},
    ["��ָ7"] = {0, 3},
    ["����7"] = {0, 3},
    ["����7"] = {0, 3},
    ["ͷ��7"] = {0, 3},
    ["Ь��8"] = {0, 4},
    ["����8"] = {0, 4},
    ["��ָ8"] = {0, 4},
    ["����8"] = {0, 4},
    ["����8"] = {0, 4},
    ["ͷ��8"] = {0, 4},
    ["Ь��9"] = {0, 4},
    ["����9"] = {0, 4},
    ["��ָ9"] = {0, 4},
    ["����9"] = {0, 4},
    ["����9"] = {0, 4},
    ["ͷ��9"] = {0, 4},
    ["Ь��10"] = {0, 5},
    ["����10"] = {0, 5},
    ["��ָ10"] = {0, 5},
    ["����10"] = {0, 5},
    ["����10"] = {0, 5},
    ["ͷ��10"] = {0, 5},
    ["Ь��11"] = {0, 6},
    ["����11"] = {0, 6},
    ["��ָ11"] = {0, 6},
    ["����11"] = {0, 6},
    ["����11"] = {0, 6},
    ["ͷ��11"] = {0, 6},
    ["Ь��12"] = {0, 7},
    ["����12"] = {0, 7},
    ["��ָ12"] = {0, 7},
    ["����12"] = {0, 7},
    ["����12"] = {0, 7},
    ["ͷ��12"] = {0, 7},
    ["Ь��13"] = {0, 8},
    ["����13"] = {0, 8},
    ["��ָ13"] = {0, 8},
    ["����13"] = {0, 8},
    ["����13"] = {0, 8},
    ["ͷ��13"] = {0, 8},
    ["Ь��14"] = {0, 9},
    ["����14"] = {0, 9},
    ["��ָ14"] = {0, 9},
    ["����14"] = {0, 9},
    ["����14"] = {0, 9},
    ["ͷ��14"] = {0, 9},
    ["Ь��15"] = {1, 10},
    ["����15"] = {1, 10},
    ["��ָ15"] = {1, 10},
    ["����15"] = {1, 10},
    ["����15"] = {1, 10},
    ["ͷ��15"] = {1, 10},
    ["Ь��16"] = {1, 1},
    ["����16"] = {1, 1},
    ["��ָ16"] = {1, 1},
    ["����16"] = {1, 1},
    ["����16"] = {1, 1},
    ["ͷ��16"] = {1, 1},
    ["Ь��17"] = {1, 2},
    ["����17"] = {1, 2},
    ["��ָ17"] = {1, 2},
    ["����17"] = {1, 2},
    ["����17"] = {1, 2},
    ["ͷ��17"] = {1, 2},
    ["Ь��18"] = {1, 3},
    ["����18"] = {1, 3},
    ["��ָ18"] = {1, 3},
    ["����18"] = {1, 3},
    ["����18"] = {1, 3},
    ["ͷ��18"] = {1, 3},
    ["Ь��19"] = {1, 4},
    ["����19"] = {1, 4},
    ["��ָ19"] = {1, 4},
    ["����19"] = {1, 4},
    ["����19"] = {1, 4},
    ["ͷ��19"] = {1, 4},
    ["Ь��20"] = {1, 5},
    ["����20"] = {1, 5},
    ["��ָ20"] = {1, 5},
    ["����20"] = {1, 5},
    ["����20"] = {1, 5},
    ["ͷ��20"] = {1, 5},
    ["Ь��21"] = {1, 6},
    ["����21"] = {1, 6},
    ["��ָ21"] = {1, 6},
    ["����21"] = {1, 6},
    ["����21"] = {1, 6},
    ["ͷ��21"] = {1, 6},
    ["Ь��22"] = {1, 7},
    ["����22"] = {1, 7},
    ["��ָ22"] = {1, 7},
    ["����22"] = {1, 7},
    ["����22"] = {1, 7},
    ["ͷ��22"] = {1, 7},
    ["Ь��23"] = {1, 8},
    ["����23"] = {1, 8},
    ["��ָ23"] = {1, 8},
    ["����23"] = {1, 8},
    ["����23"] = {1, 8},
    ["ͷ��23"] = {1, 8},
    ["Ь��24"] = {2, 0},
    ["����24"] = {2, 0},
    ["��ָ24"] = {2, 0},
    ["����24"] = {2, 0},
    ["����24"] = {2, 0},
    ["ͷ��24"] = {2, 0},
    ["Ь��25"] = {2, 2},
    ["����25"] = {2, 2},
    ["��ָ25"] = {2, 2},
    ["����25"] = {2, 2},
    ["����25"] = {2, 2},
    ["ͷ��25"] = {2, 2},
    ["Ь��26"] = {2, 5},
    ["����26"] = {2, 5},
    ["��ָ26"] = {2, 5},
    ["����26"] = {2, 5},
    ["����26"] = {2, 5},
    ["ͷ��26"] = {2, 5},


    ["����2"] = {0, 2},
    ["����3"] = {0, 2},
    ["����4"] = {0, 3},
    ["����5"] = {0, 3},
    ["����6"] = {0, 4},
    ["����7"] = {0, 4},
    ["����8"] = {0, 5},
    ["����9"] = {0, 6},
    ["����10"] = {0, 8},
    ["����11"] = {0, 9},
    ["����12"] = {1, 10},
    ["����13"] = {1, 1},
    ["����14"] = {1, 2},
    ["����15"] = {1, 3},
    ["����16"] = {1, 4},
    ["����17"] = {1, 5},
    ["����18"] = {1, 6},
    ["����19"] = {1, 7},
    ["����20"] = {1, 8},
    ["����21"] = {1, 9},
    ["����22"] = {2, 2},
    ["����23"] = {2, 2},
    ["����24"] = {2, 4},
    ["����25"] = {2, 6},
    ["����26"] = {2, 8},
    ["����27"] = {3, 4},
    ["����28"] = {4, 10},
    ["����29"] = {5, 10},


    ["�·�2"] = {0, 2},
    ["�·�3"] = {0, 2},
    ["�·�4"] = {0, 3},
    ["�·�5"] = {0, 3},
    ["�·�6"] = {0, 4},
    ["�·�7"] = {0, 4},
    ["�·�8"] = {0, 5},
    ["�·�9"] = {0, 6},
    ["�·�10"] = {0, 8},
    ["�·�11"] = {0, 9},
    ["�·�12"] = {1, 10},
    ["�·�13"] = {1, 1},
    ["�·�14"] = {1, 2},
    ["�·�15"] = {1, 3},
    ["�·�16"] = {1, 4},
    ["�·�17"] = {1, 5},
    ["�·�18"] = {1, 6},
    ["�·�19"] = {1, 7},
    ["�·�20"] = {1, 8},
    ["�·�21"] = {1, 9},
    ["�·�22"] = {2, 2},
    ["�·�23"] = {2, 2},
    ["�·�24"] = {2, 4},
    ["�·�25"] = {2, 6},
    ["�·�26"] = {2, 8},
    ["�·�27"] = {3, 4},
    ["�·�28"] = {4, 10},
    ["�·�29"] = {5, 10},

    ["���1"] = {0, 1},
    ["���2"] = {0, 2},
    ["���3"] = {0, 3},
    ["���4"] = {0, 4},
    ["���5"] = {0, 5},
    ["���6"] = {0, 8},
    ["���7"] = {1, 10},
    ["���8"] = {1, 4},
    ["���9"] = {1, 8},
    ["���10"] = {2, 5},

    ["����1"] = {0, 1},
    ["����2"] = {0, 2},
    ["����3"] = {0, 3},
    ["����4"] = {0, 4},
    ["����5"] = {0, 5},
    ["����6"] = {0, 8},
    ["����7"] = {1, 10},
    ["����8"] = {1, 4},
    ["����9"] = {1, 8},
    ["����10"] = {2, 5},

    ["������1"] = {0, 10},
    ["������2"] = {0, 10},
    ["������3"] = {0, 10},
    ["������4"] = {0, 10},
    ["������5"] = {0, 10},
    ["������6"] = {0, 1},
    ["������7"] = {0, 2},
    ["������8"] = {0, 3},
    ["������9"] = {0, 4},
    ["������10"] = {0, 5},
    ["������11"] = {0, 6},
    ["������12"] = {0, 8},
    ["������13"] = {1, 10},
    ["������14"] = {1, 2},
    ["������15"] = {1, 5},

    ["̫ƽ��1"] = {0, 10},
    ["̫ƽ��2"] = {0, 10},
    ["̫ƽ��3"] = {0, 10},
    ["̫ƽ��4"] = {0, 10},
    ["̫ƽ��5"] = {0, 10},
    ["̫ƽ��6"] = {0, 1},
    ["̫ƽ��7"] = {0, 2},
    ["̫ƽ��8"] = {0, 3},
    ["̫ƽ��9"] = {0, 4},
    ["̫ƽ��10"] = {0, 5},
    ["̫ƽ��11"] = {0, 6},
    ["̫ƽ��12"] = {0, 8},
    ["̫ƽ��13"] = {1, 10},
    ["̫ƽ��14"] = {1, 2},
    ["̫ƽ��15"] = {1, 5},

    ["������1"] = {0, 10},
    ["������2"] = {0, 10},
    ["������3"] = {0, 10},
    ["������4"] = {0, 10},
    ["������5"] = {0, 10},
    ["������6"] = {0, 1},
    ["������7"] = {0, 2},
    ["������8"] = {0, 3},
    ["������9"] = {0, 4},
    ["������10"] = {0, 5},
    ["������11"] = {0, 6},
    ["������12"] = {0, 8},
    ["������13"] = {1, 10},
    ["������14"] = {1, 2},
    ["������15"] = {1, 5},

    ["������1"] = {0, 10},
    ["������2"] = {0, 10},
    ["������3"] = {0, 10},
    ["������4"] = {0, 10},
    ["������5"] = {0, 10},
    ["������6"] = {0, 1},
    ["������7"] = {0, 2},
    ["������8"] = {0, 3},
    ["������9"] = {0, 4},
    ["������10"] = {0, 5},
    ["������11"] = {0, 6},
    ["������12"] = {0, 8},
    ["������13"] = {1, 10},
    ["������14"] = {1, 2},
    ["������15"] = {1, 5},

    ["����1"] = {0, 1},
    ["����2"] = {0, 2},
    ["����3"] = {0, 3},
    ["����4"] = {0, 4},
    ["����5"] = {0, 5},
    ["����6"] = {0, 8},
    ["����7"] = {1, 10},
    ["����8"] = {1, 4},
    ["����9"] = {1, 8},
    ["����10"] = {2, 5},

    ["���1"] = {0, 1},
    ["���2"] = {0, 2},
    ["���3"] = {0, 3},
    ["���4"] = {0, 4},
    ["���5"] = {0, 5},
    ["���6"] = {0, 8},
    ["���7"] = {1, 10},
    ["���8"] = {1, 4},
    ["���9"] = {1, 8},
    ["���10"] = {2, 5},

    ["����1"] = {0, 1},
    ["����2"] = {0, 2},
    ["����3"] = {0, 3},
    ["����4"] = {0, 4},
    ["����5"] = {0, 5},
    ["����6"] = {0, 8},
    ["����7"] = {1, 10},
    ["����8"] = {1, 4},
    ["����9"] = {1, 8},
    ["����10"] = {2, 5},

    ["����1"] = {0, 2},
    ["����2"] = {0, 5},
    ["����3"] = {0, 8},
    ["����4"] = {1, 2},
    ["����5"] = {1, 6},
    ["����6"] = {2, 10},
    ["����7"] = {2, 5},
    ["����8"] = {3, 10},

}


local fydu = {
    ["�ɽ���1"] = 1,
    ["�ɽ���2"] = 1,
    ["�ɽ���3"] = 1,
    ["�ɽ���4"] = 1,
    ["�ɽ���5"] = 1,
    ["�ɽ���6"] = 1,
    ["�ɽ���7"] = 1,
    ["�ɽ���8"] = 1,
    ["�ɽ���9"] = 1,
    ["�ɽ���10"] = 1,
    ["�ɽ���11"] = 1,
    ["�ɽ���12"] = 1,
    ["�ɽ���1"] = 2,
    ["�ɽ���2"] = 2,
    ["�ɽ���3"] = 2,
    ["�ɽ���4"] = 2,
    ["�ɽ���5"] = 2,
    ["�ɽ���6"] = 2,
    ["�ɽ���7"] = 2,
    ["�ɽ���8"] = 2,
    ["�ɽ���9"] = 2,
    ["�ɽ���10"] = 2,
    ["�ɽ���11"] = 2,
    ["�ɽ���12"] = 2,

    ["�ɽ���1"] = 4,
    ["�ɽ���2"] = 4,
    ["�ɽ���3"] = 4,
    ["�ɽ���4"] = 4,
    ["�ɽ���5"] = 4,
    ["�ɽ���6"] = 4,
    ["�ɽ���7"] = 4,
    ["�ɽ���8"] = 4,
    ["�ɽ���9"] = 4,
    ["�ɽ���10"] = 4,
    ["�ɽ���11"] = 4,
    ["�ɽ���12"] = 4,

    ["�ɽ���1"] = 9,
    ["�ɽ���2"] = 9,
    ["�ɽ���3"] = 9,
    ["�ɽ���4"] = 9,
    ["�ɽ���5"] = 9,
    ["�ɽ���6"] = 9,
    ["�ɽ���7"] = 9,
    ["�ɽ���8"] = 9,
    ["�ɽ���9"] = 9,
    ["�ɽ���10"] = 9,
    ["�ɽ���11"] = 9,
    ["�ɽ���12"] = 9,

}


function on_pre_equip(player, item, item_id, item_key)   -------- ��װ��
if fydu[item_key] ~= nil then
    lualib:SetInt(player, "fangdu", lualib:GetInt(player, "fangdu") + fydu[item_key])
end
    local level = lualib:Level(player)
    local dj = 0
    local dj1 = 0
    local dj2 = 0
    local cur_hp = lualib:Hp(player, false)
    if wupinsz[item_key] ~= nil then
        dj1 = wupinsz[item_key][1] * 10
        dj2 = wupinsz[item_key][2]
        if dj2 >= 10 then
            dj2 = 0
        end
        local fsdj = lualib:GetInt(item, "fsdj")
        dj = dj1 + dj2 + fsdj
        lualib:SetLevel(player, level + dj)
        local zong_hp = lualib:Hp(player, true)
        if cur_hp > zong_hp then
            lualib:SetHp(player, zong_hp, false)
        else
            lualib:SetHp(player, cur_hp, false)
        end
    end
    return true
end



function on_pre_un_equip(player, item,item_id,item_key)   ----------- ��װ��
if fydu[item_key] ~= nil then
    if lualib:GetInt(player, "fangdu") > 0 then
        lualib:SetInt(player, "fangdu", lualib:GetInt(player, "fangdu") - fydu[item_key])
    end
end
    local level = lualib:Level(player)
    local dj = 0
    local dj1 = 0
    local dj2 = 0
    local cur_hp = lualib:Hp(player, false)
    if wupinsz[item_key] ~= nil then
        dj1 = wupinsz[item_key][1] * 10
        dj2 = wupinsz[item_key][2]
        if dj2 >= 10 then
            dj2 = 0
        end
        local fsdj = lualib:GetInt(item, "fsdj")
        dj = dj1 + dj2 + fsdj
        lualib:SetLevel(player, level - dj)
        local zong_hp = lualib:Hp(player, true)
        if cur_hp > zong_hp then
            lualib:SetHp(player, zong_hp, false)
        else
            lualib:SetHp(player, cur_hp, false)
        end
    end
    return true
end







mbijz = {
    ["���1"] = {10, 2},
    ["���2"] = {10, 2},
    ["���3"] = {10, 2},
    ["���4"] = {10, 2},
    ["���5"] = {12, 2},
    ["���6"] = {13, 2},
    ["���7"] = {14, 2},
    ["���8"] = {15, 2},
    ["���9"] = {18, 2},
    ["���10"] = {20, 3},
}


dpfmbi = {
    ["����1"] = {5},
    ["����2"] = {8},
    ["����3"] = {11},
    ["����4"] = {15},
    ["����5"] = {20},
    ["����6"] = {25},
    ["����7"] = {32},
    ["����8"] = {45},
    ["����9"] = {60},
    ["����10"] = {100},
}

jnsz = {
    ["��ɱ����4��"] = 1,
    ["��ɱ����4��"] = 2,
    ["�һ𽣷�4��"] = 3,
    ["���ս���4��"] = 4,
    ["����ն4��"] = 5,
    ["�����䵶4��"] = 6,
}
local bossFilterToCut = {
    ["����ɽ�߱�BOOS1"] = 1,
    ["����ɽ�ؾ�BOSS1"] = 1,
    ["�����ڸ߱�BOOS1"] = 1,
    ["�������ؾ�BOSS1"] = 1,
    ["�����¸߱�BOOS1"] = 1,
    ["���������ؾ�BOSS1"] = 1,
    ["���ɽ�߱�BOOS1"] = 1,
    ["���ɽ�ؾ�BOSS1"] = 1,
    ["�����ڸ߱�BOOS1"] = 1,
    ["�������ؾ�BOSS1"] = 1,
    ["�����ظ߱�BOOS1"] = 1,
    ["�������ؾ�BOSS1"] = 1,
    ["��֬���߱�BOOS1"] = 1,
    ["��֬���ؾ�BOSS1"] = 1,
    ["����ͤ�߱�BOOS1"] = 1,
    ["����ͤ�ؾ�BOSS1"] = 1,
    ["ϴ��ظ߱�BOOS1"] = 1,
    ["ϴ����ؾ�BOSS1"] = 1,
    ["����ɽ�߱�BOOS1"] = 1,
    ["����ɽ�ؾ�BOSS1"] = 1,
    ["�������߱�BOOS1"] = 1,
    ["�������ؾ�BOSS1"] = 1,
    ["��۳Ǹ߱�BOOS1"] = 1,
    ["��۳��ؾ�BOSS1"] = 1,
    ["��گ�����߱�BOOS1"] = 1,
    ["��گ�����ؾ�BOSS1"] = 1,
    ["��Խ���ظ߱�BOOS1"] = 1,
    ["��Խ�����ؾ�BOSS1"] = 1,
    ["��ҽ�ڣ�߱�BOOS1"] = 1,
    ["��ҽ�ڣ�ؾ�BOSS1"] = 1,
    ["��ţ��ڸ߱�BOOS1"] = 1,
    ["��ţ����ؾ�BOSS1"] = 1,
    ["ۺ���ĹŸ߱�BOOS1"] = 1,
    ["ۺ���Ĺ��ؾ�BOSS1"] = 1,
    ["����ѧ���߱�BOOS1"] = 1,
    ["����ѧ���ؾ�BOSS1"] = 1,
    ["�������ø߱�BOOS1"] = 1,
    ["���������ؾ�BOSS1"] = 1,
    ["��Ȼɽ���߱�BOOS1"] = 1,
    ["��Ȼɽ���ؾ�BOSS1"] = 1,
    ["�彣�ָ��߱�BOOS1"] = 1,
    ["�彣�ָ��ؾ�BOSS1"] = 1,
    ["��ɽ��ѩƺ�߱�BOOS1"] = 1,
    ["��ɽ��ѩƺ�ؾ�BOSS1"] = 1,
    ["���ػ���߱�BOOS1"] = 1,
    ["���ػ����ؾ�BOSS1"] = 1,
    ["��ç����ͥ�߱�BOOS1"] = 1,
    ["��ç����ͥ�ؾ�BOSS1"] = 1,
    ["����̫���Ǹ߱�BOOS1"] = 1,
    ["����̫�����ؾ�BOSS1"] = 1,
    ["���̸��ǵظ߱�BOOS1"] = 1,
    ["���̸��ǵ��ؾ�BOSS1"] = 1,
    ["���̸��ǵظ߱�2-BOOS1"] = 1,
    ["���̸��ǵ��ؾ�2-BOSS1"] = 1,
    ["���Ż�Ե�ظ߱�BOOS1"] = 1,
    ["���Ż�Ե���ؾ�BOSS1"] = 1,
    ["���Ż�Ե�ظ߱�2-BOOS1"] = 1,
    ["���Ż�Ե���ؾ�2-BOSS1"] = 1,
    ["������˵ظ߱�BOOS1"] = 1,
    ["������˵��ؾ�BOSS1"] = 1,
    ["������˵ظ߱�2-BOOS1"] = 1,
    ["������˵��ؾ�2-BOSS1"] = 1,
    ["���츣�ظ߱�BOOS1"] = 1,
    ["���츣���ؾ�BOSS1"] = 1,
    ["���켼�ܸ߱�BOOS1"] = 1,
    ["���콣�׸߱�BOOS1"] = 1,
    ["��������߱�BOOS1"] = 1,
    ["�������θ߱�BOOS1"] = 1,
    ["����ר�����߱�BOSS��"] = 1,
    ["����ר�����ؾ�BOSS��"] = 1,
    ["����ר�����߱�BOSS��"] = 1,
    ["����ר�����ؾ�BOSS��"] = 1,
    ["����ר�����߱�BOSS��"] = 1,
    ["����ר�����ؾ�BOSS��"] = 1,
    ["����ר�����߱�BOSS��"] = 1,
    ["����ר�����ؾ�BOSS��"] = 1,
}

local htshs = {
    {500000, 20, 160, 2, 1, 1.01},
    {800000, 40, 300, 2, 2, 1.02},
    {1100000, 60, 500, 2, 3, 1.03},
    {1200000, 80, 700, 2, 4, 1.04},
    {1300000, 120, 1000, 2, 6, 1.05},
    {1500000, 160, 1300, 3, 8, 1.06},
    {2000000, 200, 1600, 3, 10, 1.07},
    {3000000, 240, 2000, 3, 12, 1.08},
    {5000000, 300, 2400, 3, 14, 1.09},
    {8000000, 400, 3000, 4, 16, 1.10},
    {12000000, 500, 3600, 4, 18, 1.12},
    {30000000, 600, 4400, 4, 20, 1.14},
    {80000000, 800, 5600, 4, 22, 1.16},
    {100000000, 1000, 7000, 4, 24, 1.18},
    {150000000, 1200, 9000, 4, 26, 1.20},
    {200000000, 1600, 12000, 4, 28, 1.22},
    {300000000, 2200, 16000, 5, 31, 1.25},
    {500000000, 3000, 24000, 6, 35, 1.30},
}
function on_pre_harm(player, killer, hp, defense, skill_key)


    if lualib:Player_IsPlayer(killer)  then
        local dht = lualib:GetInt(killer,"dht")
        if dht > 0 then
            hp = hp * htshs[dht][6]
        end
    end

    if lualib:Player_IsPlayer(killer) and lualib:Player_IsPlayer(player) then
        lualib:SetInt(killer, "autoattack", 0)
    end

    if lualib:Player_IsPlayer(killer) and lualib:Player_IsPlayer(player) then

        if lualib:HasSkill(killer, "��������", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 then
                if lualib:ItemCount(player, "�����Ǵ���ʯ") > 0 then
                    lualib:DelItem(player, "�����Ǵ���ʯ", lualib:ItemCount(player, "�����Ǵ���ʯ"), 2, "�̻�", "�̻�")
                    lualib:SysMsg_SendTriggerMsg(killer, "�㴥����������������,�Է��Ļس��ѱ���ȡһ��!")
                end
            end
        end

        if lualib:HasSkill(killer, "һָ�Ͻ�", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 then
                local pk = lualib:Pk(player) + 200
                lualib:SetPk(player, pk)
                lualib:SysMsg_SendTriggerMsg(killer, "�㴥����һָ�Ͻ�����,�Է�˲���Ϊ�˺���״̬!")
            end
        end

        if lualib:HasSkill(killer, "���˸���", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 and lualib:GetInt(killer, "xianren") <= 0 then
                local cur_hp = lualib:Hp(player, false) * 0.5
                hp = hp - cur_hp
                lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#���#COLORCOLOR_WHITE#["..lualib:KeyName(killer).."] #COLORCOLOR_PURPLE#���������˸�������,˲��նɱ��#COLORCOLOR_WHITE#["..lualib:KeyName(player).."]#COLORCOLOR_YELLOW#��ǰ50%��HP!�����Ƕ�Թ,����������!", "", 1, 12);

                --lualib:SysMsg_SendTriggerMsg(killer, "�㴥�������˸�������,˲��նɱ�˶Է���ǰ50%��HP!")
                lualib:SetInt(killer, "xianren", 60)
            end
        end

    end

    local fangmbi = 0
    if  lualib:Player_IsPlayer(player) then
        local dnpai = lualib:Player_GetItemGuid(player, 17)
        if dnpai ~= "" then
            local KeyName = lualib:KeyName(dnpai);
            if dpfmbi[KeyName] ~= nil then
                fangmbi = dpfmbi[KeyName][1]
            end
        end
    end

    local hat = lualib:Player_GetItemGuid(killer, 10)
    if hat ~= "" then
        local KeyName = lualib:KeyName(hat);
        if mbijz[KeyName] ~= nil then
            if lualib:GenRandom(1, 100) <= mbijz[KeyName][1] then
                if lualib:GenRandom(1, 100) <= fangmbi then
                    lualib:SysMsg_SendTriggerMsg(killer, "������Ч�����Է�������!")
                    lualib:SysMsg_SendTriggerMsg(player, "������˶Է������Ч��!")
                else
                    lualib:AddBuff(player, "�ű����", mbijz[KeyName][2]);
                end
            end
        else
            local hat = lualib:Player_GetItemGuid(killer, 11)
            if hat ~= "" then
                local KeyName = lualib:KeyName(hat);
                if mbijz[KeyName] ~= nil then
                    if lualib:GenRandom(1, 100) <= mbijz[KeyName][1] then
                        if lualib:GenRandom(1, 100) <= fangmbi then
                            lualib:SysMsg_SendTriggerMsg(killer, "������Ч�����Է�������!")
                            lualib:SysMsg_SendTriggerMsg(player, "������˶Է������Ч��!")
                        else
                            lualib:AddBuff(player, "�ű����", mbijz[KeyName][2]);
                        end
                    end
                end
            end
        end
    else
        local hat = lualib:Player_GetItemGuid(killer, 11)
        if hat ~= "" then
            local KeyName = lualib:KeyName(hat);
            if mbijz[KeyName] ~= nil then
                if lualib:GenRandom(1, 100) <= mbijz[KeyName][1] then
                    if lualib:GenRandom(1, 100) <= mbijz[KeyName][1] then
                        if lualib:GenRandom(1, 100) <= fangmbi then
                            lualib:SysMsg_SendTriggerMsg(killer, "������Ч�����Է�������!")
                            lualib:SysMsg_SendTriggerMsg(player, "������˶Է������Ч��!")
                        else
                            lualib:AddBuff(player, "�ű����", mbijz[KeyName][2]);
                        end
                    end
                end
            end
        end
    end

    if jnsz[skill_key] ~= nil then
        local lv = lualib:GetInt(killer, "jineng_"..jnsz[skill_key])
        if lv > 0 then
            local sh = {1.02, 1.04, 1.06, 1.08, 1.10, 1.12, 1.14, 1.16, 1.20}
            hp = hp * sh[lv]
        end
    end



    if lualib:Player_IsPlayer(killer) and lualib:Monster_IsMonster(player) then

        local wpszbd = {
            ["������1"] = 10000,
            ["������2"] = 6000,
            ["������3"] = 4000,
            ["������4"] = 3000,
            ["������5"] = 2500,
            ["������6"] = 2000,
            ["������7"] = 1000,
            ["������8"] = 800,
            ["������9"] = 600,
            ["������10"] = 400,
        }
        for i = 1, 10 do
            if lualib:HasBuff(killer,"������"..i) then
                hp = hp - wpszbd["������"..i]
            end
        end
        if lualib:HasBuff(killer,"��������") then
            hp = hp - 3888
        end
        if lualib:HasBuff(killer,"���Ž��") then
            hp = hp - 1000
        end
        if lualib:HasBuff(killer,"����ָ��") then
            hp = hp - 3000
        end
        if lualib:HasBuff(killer,"�������") then
            hp = hp - 5000
        end
        if lualib:HasBuff(killer,"½������") then
            hp = hp - 8000
        end
        -- ���жԹ��˺�����
        local attackM = lualib:GetInt(killer, "fiveElementAttackToMonster")
        if attackM > 0 then
            hp = hp - attackM
        end

        local rtcswk = {600, 1000, 1600, 2200, 3000, 3600, 5000, 6400, 9000, 12000, 15000, 18000}
        local tcwk_dj = lualib:GetInt(killer,"tcwk_dj")
        if tcwk_dj > 0 then
            hp = hp - rtcswk[tcwk_dj]
        end


        local yhuisz = {
            ["����1"] = 300,
            ["����2"] = 400,
            ["����3"] = 700,
            ["����4"] = 1000,
            ["����5"] = 1600,
            ["����6"] = 2400,
            ["����7"] = 3000,
            ["����8"] = 3600,
            ["����9"] = 4400,
            ["����10"] = 6000,
        }
        local dnpai = lualib:JuJu(killer)
        if dnpai ~= "" then
            local KeyName = lualib:KeyName(dnpai);
            if yhuisz[KeyName] ~= nil then
                hp = hp - yhuisz[KeyName]
            end
        end
        local yifu = lualib:Armor(killer)
        if yifu ~= "" then
            if lualib:KeyName(yifu) == "�����·�" then
                hp = hp - 666
            end
        end
        local wuqi = lualib:Weapon(killer)
        if wuqi ~= "" then
            if lualib:KeyName(wuqi) == "��������" then
                hp = hp - 1288
            end
        end
    end

    local qg = 0
    if lualib:Player_IsPlayer(killer) and lualib:Monster_IsMonster(player) then
        if lualib:HasBuff(killer, "���Ž��") == true then
            if lualib:GenRandom(1, 100) <= 10 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "�и����,����������ֵ��"..subHp.."������˺�����", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "����ָ��") == true then
            if lualib:GenRandom(1, 100) <= 20 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "�и����,����������ֵ��"..subHp.."������˺�����", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "�������") == true then
            if lualib:GenRandom(1, 100) <= 50 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "�и����,����������ֵ��"..subHp.."������˺�����", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "½������") == true then
            if lualib:GenRandom(1, 100) <= 100 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "�и����,����������ֵ��"..subHp.."������˺�����", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        -- �����и�
        local mobCut = lualib:GetInt(player, "fiveELementcutPercent")
        if mobCut > 0 then
            if bossFilterToCut[lualib:KeyName(player)] ~= 1 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * mobCut / 100
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "�����и����,����������ֵ��"..subHp.."������˺�����", killer);
                hp = hp - subHp
            end
        end
    end
    if qg == 1 then
        lualib:ShowRoleHPRefEx("", player, hp,  3)
    end

    return hp
end


function on_family_member_ntf(family_guid, family_name, player_guid, opt_type)
    lualib:DelayCall(family_guid, 1, "�л�:on_family_member_ntf", family_name.."#"..player_guid.."#"..opt_type)
end

function on_family_ntf(guid, mc, opt_type, player)
    if opt_type == 1 then
        if lualib:GetDBNum("hequbs") > 1 then
            lualib:SetFamilyMaxMember(guid, 200)
        else
            lualib:SetFamilyMaxMember(guid, 20)
        end
    end
    lualib:DelayCall(guid, 1, "�л�:on_family_ntf", name.."#"..type.."#"..player)
end

----------------------------------�ױ�
local sb_wp = {
    {"ͷ��2", 500, 3},
    {"����2", 500, 3},
    {"��ָ2", 500, 3},
    {"����2", 500, 3},
    {"Ь��2", 500, 3},
    {"����2", 500, 3},
    {"ͷ��3", 1000, 3},
    {"����3", 1000, 3},
    {"��ָ3", 1000, 3},
    {"����3", 1000, 3},
    {"Ь��3", 1000, 3},
    {"����3", 1000, 3},
    {"ͷ��4", 1500, 3},
    {"����4", 1500, 3},
    {"��ָ4", 1500, 3},
    {"����4", 1500, 3},
    {"Ь��4", 1500, 3},
    {"����4", 1500, 3},
    {"ͷ��5", 2000, 3},
    {"����5", 2000, 3},
    {"��ָ5", 2000, 3},
    {"����5", 2000, 3},
    {"Ь��5", 2000, 3},
    {"����5", 2000, 3},
    {"ͷ��6", 2500, 3},
    {"����6", 2500, 3},
    {"��ָ6", 2500, 3},
    {"����6", 2500, 3},
    {"Ь��6", 2500, 3},
    {"����6", 2500, 3},
    {"ͷ��7", 3000, 3},
    {"����7", 3000, 3},
    {"��ָ7", 3000, 3},
    {"����7", 3000, 3},
    {"Ь��7", 3000, 3},
    {"����7", 3000, 3},
    {"ͷ��8", 3500, 3},
    {"����8", 3500, 3},
    {"��ָ8", 3500, 3},
    {"����8", 3500, 3},
    {"Ь��8", 3500, 3},
    {"����8", 3500, 3},
    {"ͷ��9", 4000, 3},
    {"����9", 4000, 3},
    {"��ָ9", 4000, 3},
    {"����9", 4000, 3},
    {"Ь��9", 4000, 3},
    {"����9", 4000, 3},
    {"ͷ��10", 4500, 3},
    {"����10", 4500, 3},
    {"��ָ10", 4500, 3},
    {"����10", 4500, 3},
    {"Ь��10", 4500, 3},
    {"����10", 4500, 3},
    {"ͷ��11", 5000, 3},
    {"����11", 5000, 3},
    {"��ָ11", 5000, 3},
    {"����11", 5000, 3},
    {"Ь��11", 5000, 3},
    {"����11", 5000, 3},
    {"ͷ��12", 6000, 3},
    {"����12", 6000, 3},
    {"��ָ12", 6000, 3},
    {"����12", 6000, 3},
    {"Ь��12", 6000, 3},
    {"����12", 6000, 3},
    {"ͷ��13", 7000, 3},
    {"����13", 7000, 3},
    {"��ָ13", 7000, 3},
    {"����13", 7000, 3},
    {"Ь��13", 7000, 3},
    {"����13", 7000, 3},
    {"ͷ��14", 8000, 3},
    {"����14", 8000, 3},
    {"��ָ14", 8000, 3},
    {"����14", 8000, 3},
    {"Ь��14", 8000, 3},
    {"����14", 8000, 3},
    {"ͷ��15", 9000, 3},
    {"����15", 9000, 3},
    {"��ָ15", 9000, 3},
    {"����15", 9000, 3},
    {"Ь��15", 9000, 3},
    {"����15", 9000, 3},
    {"ͷ��16", 10000, 3},
    {"����16", 10000, 3},
    {"��ָ16", 10000, 3},
    {"����16", 10000, 3},
    {"Ь��16", 10000, 3},
    {"����16", 10000, 3},
    {"ͷ��17", 20000, 2},
    {"����17", 20000, 2},
    {"��ָ17", 20000, 2},
    {"����17", 20000, 2},
    {"Ь��17", 20000, 2},
    {"����17", 20000, 2},
    {"ͷ��18", 30000, 2},
    {"����18", 30000, 2},
    {"��ָ18", 30000, 2},
    {"����18", 30000, 2},
    {"Ь��18", 30000, 2},
    {"����18", 30000, 2},
    {"ͷ��19", 40000, 2},
    {"����19", 40000, 2},
    {"��ָ19", 40000, 2},
    {"����19", 40000, 2},
    {"Ь��19", 40000, 2},
    {"����19", 40000, 2},
    {"ͷ��20", 50000, 2},
    {"����20", 50000, 2},
    {"��ָ20", 50000, 2},
    {"����20", 50000, 2},
    {"Ь��20", 50000, 2},
    {"����20", 50000, 2},
    {"ͷ��21", 60000, 2},
    {"����21", 60000, 2},
    {"��ָ21", 60000, 2},
    {"����21", 60000, 2},
    {"Ь��21", 60000, 2},
    {"����21", 60000, 2},
    {"ͷ��22", 80000, 2},
    {"����22", 80000, 2},
    {"��ָ22", 80000, 2},
    {"����22", 80000, 2},
    {"Ь��22", 80000, 2},
    {"����22", 80000, 2},
    {"ͷ��23", 100000, 2},
    {"����23", 100000, 2},
    {"��ָ23", 100000, 2},
    {"����23", 100000, 2},
    {"Ь��23", 100000, 2},
    {"����23", 100000, 2},
    {"ͷ��24", 188888, 2},
    {"����24", 188888, 2},
    {"��ָ24", 188888, 2},
    {"����24", 188888, 2},
    {"Ь��24", 188888, 2},
    {"����24", 188888, 2},
    {"ͷ��25", 388888, 2},
    {"����25", 388888, 2},
    {"��ָ25", 388888, 2},
    {"����25", 388888, 2},
    {"Ь��25", 388888, 2},
    {"����25", 388888, 2},
    {"ͷ��26", 888888, 2},
    {"����26", 888888, 2},
    {"��ָ26", 888888, 2},
    {"����26", 888888, 2},
    {"Ь��26", 888888, 2},
    {"����26", 888888, 2},
    {"����2", 1000, 3},
    {"����3", 2000, 3},
    {"����4", 3000, 3},
    {"����5", 4000, 3},
    {"����6", 5000, 3},
    {"����7", 6000, 3},
    {"����8", 8000, 3},
    {"����9", 10000, 3},
    {"����10", 15000, 3},
    {"����11", 20000, 3},
    {"����12", 25000, 3},
    {"����13", 30000, 3},
    {"����14", 35000, 3},
    {"����15", 40000, 3},
    {"����16", 50000, 3},
    {"����17", 60000, 2},
    {"����18", 80000, 2},
    {"����19", 100000, 2},
    {"����20", 120000, 2},
    {"����21", 140000, 2},
    {"����22", 160000, 2},
    {"����23", 180000, 2},
    {"����24", 200000, 2},
    {"����25", 300000, 2},
    {"����26", 588888, 2},
    {"����27", 888888, 2},
    {"����28", 1888888, 2},
    {"����29", 3888888, 2},
    {"�·�2", 1000, 3},
    {"�·�3", 2000, 3},
    {"�·�4", 3000, 3},
    {"�·�5", 4000, 3},
    {"�·�6", 5000, 3},
    {"�·�7", 6000, 3},
    {"�·�8", 8000, 3},
    {"�·�9", 10000, 3},
    {"�·�10", 15000, 3},
    {"�·�11", 20000, 3},
    {"�·�12", 25000, 3},
    {"�·�13", 30000, 3},
    {"�·�14", 35000, 3},
    {"�·�15", 40000, 3},
    {"�·�16", 50000, 3},
    {"�·�17", 60000, 2},
    {"�·�18", 80000, 2},
    {"�·�19", 100000, 2},
    {"�·�20", 120000, 2},
    {"�·�21", 140000, 2},
    {"�·�22", 160000, 2},
    {"�·�23", 180000, 2},
    {"�·�24", 200000, 2},
    {"�·�25", 300000, 2},
    {"�·�26", 588888, 2},
    {"�·�27", 888888, 2},
    {"�·�28", 1888888, 2},
    {"�·�29", 3888888, 2},
    {"���1", 1200, 3},
    {"���2", 5000, 3},
    {"���3", 10000, 3},
    {"���4", 20000, 3},
    {"���5", 40000, 3},
    {"���6", 60000, 3},
    {"���7", 80000, 3},
    {"���8", 100000, 2},
    {"���9", 150000, 2},
    {"���10", 300000, 2},
    {"����1", 1200, 3},
    {"����2", 5000, 3},
    {"����3", 10000, 3},
    {"����4", 20000, 3},
    {"����5", 40000, 3},
    {"����6", 60000, 3},
    {"����7", 80000, 3},
    {"����8", 100000, 2},
    {"����9", 150000, 2},
    {"����10", 300000, 2},
    {"������1", 1000, 3},
    {"������1", 1000, 3},
    {"������1", 1000, 3},
    {"̫ƽ��1", 1000, 3},
    {"������2", 1000, 3},
    {"������2", 2000, 3},
    {"������2", 2000, 3},
    {"̫ƽ��2", 2000, 3},
    {"������3", 3000, 3},
    {"������3", 3000, 3},
    {"������3", 3000, 3},
    {"̫ƽ��3", 3000, 3},
    {"������4", 5000, 3},
    {"������4", 5000, 3},
    {"������4", 5000, 3},
    {"̫ƽ��4", 5000, 3},
    {"������5", 10000, 3},
    {"������5", 10000, 3},
    {"������5", 10000, 3},
    {"̫ƽ��5", 10000, 3},
    {"������6", 20000, 3},
    {"������6", 20000, 3},
    {"������6", 20000, 3},
    {"̫ƽ��6", 20000, 3},
    {"������7", 40000, 3},
    {"������7", 40000, 3},
    {"������7", 40000, 3},
    {"̫ƽ��7", 40000, 3},
    {"������8", 60000, 3},
    {"������8", 60000, 3},
    {"������8", 60000, 3},
    {"̫ƽ��8", 60000, 3},
    {"������9", 80000, 3},
    {"������9", 80000, 3},
    {"������9", 80000, 3},
    {"̫ƽ��9", 80000, 3},
    {"������10", 100000, 3},
    {"������10", 100000, 3},
    {"������10", 100000, 3},
    {"̫ƽ��10", 100000, 3},
    {"������11", 120000, 2},
    {"������11", 120000, 2},
    {"������11", 120000, 2},
    {"̫ƽ��11", 120000, 2},
    {"������12", 150000, 2},
    {"������12", 150000, 2},
    {"������12", 150000, 2},
    {"̫ƽ��12", 150000, 2},
    {"������13", 200000, 2},
    {"������13", 200000, 2},
    {"������13", 200000, 2},
    {"̫ƽ��13", 200000, 2},
    {"������14", 250000, 2},
    {"������14", 250000, 2},
    {"������14", 250000, 2},
    {"̫ƽ��14", 250000, 2},
    {"������15", 300000, 2},
    {"������15", 300000, 2},
    {"������15", 300000, 2},
    {"̫ƽ��15", 300000, 2},
    {"�ɽ���1", 10000, 3},
    {"�ɽ���2", 10000, 3},
    {"�ɽ���3", 10000, 3},
    {"�ɽ���4", 10000, 3},
    {"�ɽ���5", 10000, 3},
    {"�ɽ���6", 10000, 3},
    {"�ɽ���7", 10000, 3},
    {"�ɽ���8", 10000, 3},
    {"�ɽ���9", 10000, 3},
    {"�ɽ���10", 10000, 3},
    {"�ɽ���11", 10000, 3},
    {"�ɽ���12", 10000, 3},
    {"�ɽ���1", 50000, 2},
    {"�ɽ���2", 50000, 2},
    {"�ɽ���3", 50000, 2},
    {"�ɽ���4", 50000, 2},
    {"�ɽ���5", 50000, 2},
    {"�ɽ���6", 50000, 2},
    {"�ɽ���7", 50000, 2},
    {"�ɽ���8", 50000, 2},
    {"�ɽ���9", 50000, 2},
    {"�ɽ���10", 50000, 2},
    {"�ɽ���11", 50000, 2},
    {"�ɽ���12", 50000, 2},
    {"�ɽ���1", 100000, 2},
    {"�ɽ���2", 100000, 2},
    {"�ɽ���3", 100000, 2},
    {"�ɽ���4", 100000, 2},
    {"�ɽ���5", 100000, 2},
    {"�ɽ���6", 100000, 2},
    {"�ɽ���7", 100000, 2},
    {"�ɽ���8", 100000, 2},
    {"�ɽ���9", 100000, 2},
    {"�ɽ���10", 100000, 2},
    {"�ɽ���11", 100000, 2},
    {"�ɽ���12", 100000, 2},
}


tstishi = {
    ["����17"] = { 10000, 12000},
    ["��ָ17"] = { 10000, 12000},
    ["ͷ��17"] = { 10000, 12000},
    ["����17"] = { 10000, 12000},
    ["����17"] = { 10000, 12000},
    ["Ь��17"] = { 10000, 12000},
    ["�·�17"] = { 30000, 36000},
    ["����17"] = { 30000, 36000},
    ["����18"] = { 20000, 24000},
    ["��ָ18"] = { 20000, 24000},
    ["ͷ��18"] = { 20000, 24000},
    ["����18"] = { 20000, 24000},
    ["����18"] = { 20000, 24000},
    ["Ь��18"] = { 20000, 24000},
    ["�·�18"] = { 50000, 60000},
    ["����18"] = { 50000, 60000},
    ["����19"] = { 30000, 36000},
    ["��ָ19"] = { 30000, 36000},
    ["ͷ��19"] = { 30000, 36000},
    ["����19"] = { 30000, 36000},
    ["����19"] = { 30000, 36000},
    ["Ь��19"] = { 30000, 36000},
    ["�·�19"] = { 80000, 96000},
    ["����19"] = { 80000, 96000},
    ["����20"] = { 50000, 60000},
    ["��ָ20"] = { 50000, 60000},
    ["ͷ��20"] = { 50000, 60000},
    ["����20"] = { 50000, 60000},
    ["����20"] = { 50000, 60000},
    ["Ь��20"] = { 50000, 60000},
    ["�·�20"] = { 120000, 144000},
    ["����20"] = { 120000, 144000},
    ["����21"] = { 80000, 96000},
    ["��ָ21"] = { 80000, 96000},
    ["ͷ��21"] = { 80000, 96000},
    ["����21"] = { 80000, 96000},
    ["����21"] = { 80000, 96000},
    ["Ь��21"] = { 80000, 96000},
    ["�·�21"] = { 180000, 216000},
    ["����21"] = { 180000, 216000},
    ["����22"] = { 120000, 144000},
    ["��ָ22"] = { 120000, 144000},
    ["ͷ��22"] = { 120000, 144000},
    ["����22"] = { 120000, 144000},
    ["����22"] = { 120000, 144000},
    ["Ь��22"] = { 120000, 144000},
    ["�·�22"] = { 250000, 300000},
    ["����22"] = { 250000, 308000},
    ["����23"] = { 180000, 216000},
    ["��ָ23"] = { 180000, 216000},
    ["ͷ��23"] = { 180000, 216000},
    ["����23"] = { 180000, 216000},
    ["����23"] = { 180000, 216000},
    ["Ь��23"] = { 180000, 216000},
    ["�·�23"] = { 350000, 420000},
    ["����23"] = { 350000, 420000},
    ["����24"] = { 380000, 456000},
    ["��ָ24"] = { 380000, 456000},
    ["ͷ��24"] = { 380000, 456000},
    ["����24"] = { 380000, 456000},
    ["����24"] = { 380000, 456000},
    ["Ь��24"] = { 380000, 456000},
    ["�·�24"] = { 500000, 600000},
    ["����24"] = { 500000, 600000},
    ["����25"] = { 880000, 1056000},
    ["��ָ25"] = { 880000, 1056000},
    ["ͷ��25"] = { 880000, 1056000},
    ["����25"] = { 880000, 1056000},
    ["����25"] = { 880000, 1056000},
    ["Ь��25"] = { 880000, 1056000},
    ["�·�25"] = { 880000, 1056000},
    ["����25"] = { 880000, 1056000},
    ["����26"] = { 1880000, 2256000},
    ["��ָ26"] = { 1880000, 2256000},
    ["ͷ��26"] = { 1880000, 2256000},
    ["����26"] = { 1880000, 2256000},
    ["����26"] = { 1880000, 2256000},
    ["Ь��26"] = { 1880000, 2256000},
    ["�·�26"] = { 1880000, 2256000},
    ["����26"] = { 1880000, 2256000},
    ["�·�27"] = { 3880000, 4656000},
    ["����27"] = { 3880000, 4656000},
    ["�·�28"] = { 8880000, 10656000},
    ["����28"] = { 8880000, 10656000},
    ["�·�29"] = { 18880000, 22656000},
    ["����29"] = { 18880000, 22656000},
    ["���8"] = { 50000, 60000},
    ["����8"] = { 50000, 60000},
    ["���9"] = { 100000, 120000},
    ["����9"] = { 100000, 120000},
    ["���10"] = { 200000, 240000},
    ["����10"] = { 200000, 240000},
    ["������11"] = { 50000, 60000},
    ["������12"] = { 80000, 96000},
    ["������13"] = { 120000, 144000},
    ["������14"] = { 160000, 192000},
    ["������15"] = { 200000, 240000},
    ["������11"] = { 50000, 60000},
    ["������12"] = { 80000, 96000},
    ["������13"] = { 120000, 144000},
    ["������14"] = { 160000, 192000},
    ["������15"] = { 200000, 240000},
    ["������11"] = { 50000, 60000},
    ["������12"] = { 80000, 96000},
    ["������13"] = { 120000, 144000},
    ["������14"] = { 160000, 192000},
    ["������15"] = { 200000, 240000},
    ["̫ƽ��11"] = { 50000, 60000},
    ["̫ƽ��12"] = { 80000, 96000},
    ["̫ƽ��13"] = { 120000, 144000},
    ["̫ƽ��14"] = { 160000, 192000},
    ["̫ƽ��15"] = { 200000, 240000},
    ["�ɽ���1"] = { 200000, 240000},
    ["�ɽ���2"] = { 200000, 240000},
    ["�ɽ���3"] = { 200000, 240000},
    ["�ɽ���4"] = { 200000, 240000},
    ["�ɽ���5"] = { 200000, 240000},
    ["�ɽ���6"] = { 200000, 240000},
    ["�ɽ���7"] = { 200000, 240000},
    ["�ɽ���8"] = { 200000, 240000},
    ["�ɽ���9"] = { 200000, 240000},
    ["�ɽ���10"] = { 200000, 240000},
    ["�ɽ���11"] = { 200000, 240000},
    ["�ɽ���12"] = { 200000, 240000},
    ["ʮ��һɱ"] = { 200000, 240000},
    ["ħ����"] = { 200000, 240000},

    ["���Ͼ�"] = { 200000, 240000},
    ["�Ͻ���"] = { 200000, 240000},
    ["�����"] = { 200000, 240000},
    ["�¾��쾵"] = { 200000, 240000},
    ["������Ƥ"] = { 200000, 240000},
    ["������ȸ"] = { 200000, 240000},
    ["�ĵ�������"] = { 200000, 240000},
    ["½�س���ͼ"] = { 200000, 240000},
    ["ѩ�к�����"] = { 200000, 240000},
    ["ɽ�����"] = { 200000, 240000},
}

function on_post_drop_one(map, role, item)

    local Name = lualib:Name(item);
    local item_key = lualib:KeyName(item);
    local killer = lualib:ItemRole(item)
    if killer ~= "" then
        if lualib:Monster_IsMonster(role) then
            for i = 1, #sb_wp do
                if sb_wp[i][1] == item_key then
                    if sb_wp[i][3] - lualib:GetDBNum("�ױ��ۻ�"..item_key) > 0 then
                        lualib:SetDBNumEx("�ױ��ۻ�"..item_key, lualib:GetDBNum("�ױ��ۻ�"..item_key) + 1, 4)
                        lualib:AddIntegral(killer, sb_wp[i][2], "��Ӱ󶨽��:ԭ��", "������")
                        lualib:SysMsg_SendBroadcastMsg("���["..lualib:Name(killer).."]������ױ���Ʒ����"..Name.."������������"..sb_wp[i][2].."��ʯ��", "ϵͳ��Ϣ")

                        lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]������ױ���Ʒ����"..Name.."������������"..sb_wp[i][2].."��ʯ��","")
                        lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]������ױ���Ʒ����"..Name.."������������"..sb_wp[i][2].."��ʯ��","")
                        lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]������ױ���Ʒ����"..Name.."������������"..sb_wp[i][2].."��ʯ��","")
                        lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]������ױ���Ʒ����"..Name.."������������"..sb_wp[i][2].."��ʯ��","")


                        if lualib:GetDBNum("�ױ��ۻ�"..item_key) == 1 then
                            lualib:SetDBStrEx("�ױ�����"..sb_wp[i][1], lualib:Name(killer), 1)
                        elseif lualib:GetDBNum("�ױ��ۻ�"..item_key) <= 3 then
                            lualib:SetDBStrEx("�ױ�����"..sb_wp[i][1], lualib:GetDBStr("�ױ�����"..sb_wp[i][1]).."��"..lualib:Name(killer), 1)
                        end

                    end
                end
            end
        end
    end

    local data = lualib:Item_DataRow(item_key);
    local isTip = data.TipDrop;
    if isTip == 1 then
        local map_name = lualib:Name(map);
        local item_name = lualib:Name(item);
        local item_x = lualib:X(item);
        local item_y = lualib:Y(item);
        if item_x < 10000 and item_y < 10000 then
            --if tstishi[item_key] ~= nil then
            lualib:SysMsg_SendBroadcastColorByClientType("#COLORCOLOR_PURPLE#["..item_name.."] #COLORCOLOR_YELLOW#������#COLORCOLOR_BROWN#["..map_name.."]#COLORCOLOR_BLUE#��["..item_x..","..item_y.."]������", "", 1, 12, 1);
            --end

            --lualib:SysMsg_SendBroadcastColor("#IMAGE1900300001##COLORCOLOR_BROWN#["..item_name.."] #COLORCOLOR_YELLOW#������#COLORCOLOR_BROWN#["..map_name.."]#COLORCOLOR_YELLOW#��["..item_x..","..item_y.."]������", "", 1, 12);
        end
    end

    local map_name = lualib:Name(map);
    local item_name = lualib:Name(item);
    local item_x = lualib:X(item);
    local item_y = lualib:Y(item);
    if tstishi[item_key] ~= nil then
        lualib:SysMsg_SendCenterMsg(1, "["..item_name.."] ������["..map_name.."]��["..item_x..","..item_y.."]������",  "")
    end


end


----------------------------------��ɱ
local ss_gw = {
    {"����ɽС��1", 1000, 3},
    {"����ɽС��2", 1000, 3},
    {"����ɽС��3", 1000, 3},
    {"����ɽС��4", 1000, 3},
    {"����ɽ��Ӣ1", 2000, 3},
    {"����ɽ��Ӣ2", 2000, 3},
    {"����ɽ��Ӣ3", 2000, 3},
    {"����ɽ�߱�BOOS1", 5000, 3},
    {"����ɽ�ؾ�BOSS1", 10000, 3},
    {"������С��1", 1200, 3},
    {"������С��2", 1200, 3},
    {"������С��3", 1200, 3},
    {"������С��4", 1200, 3},
    {"�����ھ�Ӣ1", 2400, 3},
    {"�����ھ�Ӣ2", 2400, 3},
    {"�����ھ�Ӣ3", 2400, 3},
    {"�����ڸ߱�BOOS1", 6000, 3},
    {"�������ؾ�BOSS1", 12000, 3},
    {"������С��1", 1800, 3},
    {"������С��2", 1800, 3},
    {"������С��3", 1800, 3},
    {"������С��4", 1800, 3},
    {"�����¾�Ӣ1", 3600, 3},
    {"�����¾�Ӣ2", 3600, 3},
    {"�����¾�Ӣ3", 3600, 3},
    {"�����¸߱�BOOS1", 9000, 3},
    {"���������ؾ�BOSS1", 18000, 3},
    {"���ɽС��1", 2400, 3},
    {"���ɽС��2", 2400, 3},
    {"���ɽС��3", 2400, 3},
    {"���ɽС��4", 2400, 3},
    {"���ɽ��Ӣ1", 4800, 3},
    {"���ɽ��Ӣ2", 4800, 3},
    {"���ɽ��Ӣ3", 4800, 3},
    {"���ɽ�߱�BOOS1", 12000, 3},
    {"���ɽ�ؾ�BOSS1", 24000, 3},
    {"������С��1", 3000, 3},
    {"������С��2", 3000, 3},
    {"������С��3", 3000, 3},
    {"������С��4", 3000, 3},
    {"�����ھ�Ӣ1", 6000, 3},
    {"�����ھ�Ӣ2", 6000, 3},
    {"�����ھ�Ӣ3", 6000, 3},
    {"�����ڸ߱�BOOS1", 15000, 3},
    {"�������ؾ�BOSS1", 30000, 3},
    {"������С��1", 3600, 3},
    {"������С��2", 3600, 3},
    {"������С��3", 3600, 3},
    {"������С��4", 3600, 3},
    {"�����ؾ�Ӣ1", 7200, 3},
    {"�����ؾ�Ӣ2", 7200, 3},
    {"�����ؾ�Ӣ3", 7200, 3},
    {"�����ظ߱�BOOS1", 18000, 3},
    {"�������ؾ�BOSS1", 36000, 3},
    {"��֬��С��1", 4200, 3},
    {"��֬��С��2", 4200, 3},
    {"��֬��С��3", 4200, 3},
    {"��֬��С��4", 4200, 3},
    {"��֬����Ӣ1", 8400, 3},
    {"��֬����Ӣ2", 8400, 3},
    {"��֬����Ӣ3", 8400, 3},
    {"��֬���߱�BOOS1", 21000, 3},
    {"��֬���ؾ�BOSS1", 42000, 3},
    {"����ͤС��1", 4800, 3},
    {"����ͤС��2", 4800, 3},
    {"����ͤС��3", 4800, 3},
    {"����ͤС��4", 4800, 3},
    {"����ͤ��Ӣ1", 9600, 3},
    {"����ͤ��Ӣ2", 9600, 3},
    {"����ͤ��Ӣ3", 9600, 3},
    {"����ͤ�߱�BOOS1", 24000, 3},
    {"����ͤ�ؾ�BOSS1", 48000, 3},
    {"ϴ���С��1", 5400, 3},
    {"ϴ���С��2", 5400, 3},
    {"ϴ���С��3", 5400, 3},
    {"ϴ���С��4", 5400, 3},
    {"ϴ��ؾ�Ӣ1", 10800, 3},
    {"ϴ��ؾ�Ӣ2", 10800, 3},
    {"ϴ��ؾ�Ӣ3", 10800, 3},
    {"ϴ��ظ߱�BOOS1", 27000, 3},
    {"ϴ����ؾ�BOSS1", 54000, 3},
    {"����ɽС��1", 6000, 3},
    {"����ɽС��2", 6000, 3},
    {"����ɽС��3", 6000, 3},
    {"����ɽС��4", 6000, 3},
    {"����ɽ��Ӣ1", 12000, 3},
    {"����ɽ��Ӣ2", 12000, 3},
    {"����ɽ��Ӣ3", 12000, 3},
    {"����ɽ�߱�BOOS1", 30000, 3},
    {"����ɽ�ؾ�BOSS1", 60000, 3},
    {"������С��1", 6600, 3},
    {"������С��2", 6600, 3},
    {"������С��3", 6600, 3},
    {"������С��4", 6600, 3},
    {"��������Ӣ1", 13200, 3},
    {"��������Ӣ2", 13200, 3},
    {"��������Ӣ3", 13200, 3},
    {"�������߱�BOOS1", 33000, 3},
    {"�������ؾ�BOSS1", 66000, 3},
    {"��۳�С��1", 7200, 3},
    {"��۳�С��2", 7200, 3},
    {"��۳�С��3", 7200, 3},
    {"��۳�С��4", 7200, 3},
    {"��۳Ǿ�Ӣ1", 14400, 3},
    {"��۳Ǿ�Ӣ2", 14400, 3},
    {"��۳Ǿ�Ӣ3", 14400, 3},
    {"��۳Ǹ߱�BOOS1", 36000, 3},
    {"��۳��ؾ�BOSS1", 72000, 3},
    {"��گ����С��1", 8000, 3},
    {"��گ����С��2", 8000, 3},
    {"��گ����С��3", 8000, 3},
    {"��گ����С��4", 8000, 3},
    {"��گ������Ӣ1", 16000, 3},
    {"��گ������Ӣ2", 16000, 3},
    {"��گ������Ӣ3", 16000, 3},
    {"��گ�����߱�BOOS1", 40000, 3},
    {"��گ�����ؾ�BOSS1", 80000, 3},
    {"��Խ����С��1", 10000, 3},
    {"��Խ����С��2", 10000, 3},
    {"��Խ����С��3", 10000, 3},
    {"��Խ����С��4", 10000, 3},
    {"��Խ���ؾ�Ӣ1", 20000, 3},
    {"��Խ���ؾ�Ӣ2", 20000, 3},
    {"��Խ���ؾ�Ӣ3", 20000, 3},
    {"��Խ���ظ߱�BOOS1", 50000, 3},
    {"��Խ�����ؾ�BOSS1", 100000, 3},
    {"��ҽ�ڣС��1", 12000, 3},
    {"��ҽ�ڣС��2", 12000, 3},
    {"��ҽ�ڣС��3", 12000, 3},
    {"��ҽ�ڣС��4", 12000, 3},
    {"��ҽ�ڣ��Ӣ1", 24000, 3},
    {"��ҽ�ڣ��Ӣ2", 24000, 3},
    {"��ҽ�ڣ��Ӣ3", 24000, 3},
    {"��ҽ�ڣ�߱�BOOS1", 60000, 3},
    {"��ҽ�ڣ�ؾ�BOSS1", 120000, 3},
    {"��ţ���С��1", 14000, 2},
    {"��ţ���С��2", 14000, 2},
    {"��ţ���С��3", 14000, 2},
    {"��ţ���С��4", 14000, 2},
    {"��ţ��ھ�Ӣ1", 28000, 2},
    {"��ţ��ھ�Ӣ2", 28000, 2},
    {"��ţ��ھ�Ӣ3", 28000, 2},
    {"��ţ��ڸ߱�BOOS1", 70000, 2},
    {"��ţ����ؾ�BOSS1", 140000, 2},
    {"ۺ���Ĺ�С��1", 16000, 2},
    {"ۺ���Ĺ�С��2", 16000, 2},
    {"ۺ���Ĺ�С��3", 16000, 2},
    {"ۺ���Ĺ�С��4", 16000, 2},
    {"ۺ���Ĺž�Ӣ1", 32000, 2},
    {"ۺ���Ĺž�Ӣ2", 32000, 2},
    {"ۺ���Ĺž�Ӣ3", 32000, 2},
    {"ۺ���ĹŸ߱�BOOS1", 80000, 2},
    {"ۺ���Ĺ��ؾ�BOSS1", 160000, 2},
    {"����ѧ��С��1", 18000, 2},
    {"����ѧ��С��2", 18000, 2},
    {"����ѧ��С��3", 18000, 2},
    {"����ѧ��С��4", 18000, 2},
    {"����ѧ����Ӣ1", 36000, 2},
    {"����ѧ����Ӣ2", 36000, 2},
    {"����ѧ����Ӣ3", 36000, 2},
    {"����ѧ���߱�BOOS1", 90000, 2},
    {"����ѧ���ؾ�BOSS1", 180000, 2},
    {"��������С��1", 20000, 2},
    {"��������С��2", 20000, 2},
    {"��������С��3", 20000, 2},
    {"��������С��4", 20000, 2},
    {"�������þ�Ӣ1", 40000, 2},
    {"�������þ�Ӣ2", 40000, 2},
    {"�������þ�Ӣ3", 40000, 2},
    {"�������ø߱�BOOS1", 100000, 2},
    {"���������ؾ�BOSS1", 200000, 2},
    {"��Ȼɽ��С��1", 22000, 2},
    {"��Ȼɽ��С��2", 22000, 2},
    {"��Ȼɽ��С��3", 22000, 2},
    {"��Ȼɽ��С��4", 22000, 2},
    {"��Ȼɽ����Ӣ1", 44000, 2},
    {"��Ȼɽ����Ӣ2", 44000, 2},
    {"��Ȼɽ����Ӣ3", 44000, 2},
    {"��Ȼɽ���߱�BOOS1", 110000, 2},
    {"��Ȼɽ���ؾ�BOSS1", 220000, 2},
    {"�彣�ָ�С��1", 24000, 2},
    {"�彣�ָ�С��2", 24000, 2},
    {"�彣�ָ�С��3", 24000, 2},
    {"�彣�ָ�С��4", 24000, 2},
    {"�彣�ָ���Ӣ1", 48000, 2},
    {"�彣�ָ���Ӣ2", 48000, 2},
    {"�彣�ָ���Ӣ3", 48000, 2},
    {"�彣�ָ��߱�BOOS1", 120000, 2},
    {"�彣�ָ��ؾ�BOSS1", 240000, 2},
    {"��ɽ��ѩƺС��1", 24000, 2},
    {"��ɽ��ѩƺС��2", 24000, 2},
    {"��ɽ��ѩƺС��3", 24000, 2},
    {"��ɽ��ѩƺС��4", 24000, 2},
    {"��ɽ��ѩƺ��Ӣ1", 48000, 2},
    {"��ɽ��ѩƺ��Ӣ2", 48000, 2},
    {"��ɽ��ѩƺ��Ӣ3", 48000, 2},
    {"��ɽ��ѩƺ�߱�BOOS1", 120000, 2},
    {"��ɽ��ѩƺ�ؾ�BOSS1", 240000, 2},
    {"���ػ���С��1", 30000, 2},
    {"���ػ���С��2", 30000, 2},
    {"���ػ���С��3", 30000, 2},
    {"���ػ���С��4", 30000, 2},
    {"���ػ��꾫Ӣ1", 60000, 2},
    {"���ػ��꾫Ӣ2", 60000, 2},
    {"���ػ��꾫Ӣ3", 60000, 2},
    {"���ػ���߱�BOOS1", 150000, 2},
    {"���ػ����ؾ�BOSS1", 300000, 2},
    {"��ç����ͥС��1", 40000, 2},
    {"��ç����ͥС��2", 40000, 2},
    {"��ç����ͥС��3", 40000, 2},
    {"��ç����ͥС��4", 40000, 2},
    {"��ç����ͥ��Ӣ1", 80000, 2},
    {"��ç����ͥ��Ӣ2", 80000, 2},
    {"��ç����ͥ��Ӣ3", 80000, 2},
    {"��ç����ͥ�߱�BOOS1", 200000, 2},
    {"��ç����ͥ�ؾ�BOSS1", 400000, 2},
    {"����̫����С��1", 50000, 2},
    {"����̫����С��2", 50000, 2},
    {"����̫����С��3", 50000, 2},
    {"����̫����С��4", 50000, 2},
    {"����̫���Ǿ�Ӣ1", 100000, 2},
    {"����̫���Ǿ�Ӣ2", 100000, 2},
    {"����̫���Ǿ�Ӣ3", 100000, 2},
    {"����̫���Ǹ߱�BOOS1", 250000, 2},
    {"����̫�����ؾ�BOSS1", 500000, 2},
    {"���̸��ǵ�С��1", 20000, 2},
    {"���̸��ǵ�С��2", 20000, 2},
    {"���̸��ǵؾ�Ӣ1", 40000, 2},
    {"���̸��ǵظ߱�BOOS1", 100000, 2},
    {"���̸��ǵ��ؾ�BOSS1", 200000, 2},
    {"���̸��ǵ�С��2-1", 20000, 2},
    {"���̸��ǵ�С��2-2", 20000, 2},
    {"���̸��ǵؾ�Ӣ2-1", 40000, 2},
    {"���̸��ǵظ߱�2-BOOS1", 100000, 2},
    {"���̸��ǵ��ؾ�2-BOSS1", 200000, 2},
    {"���Ż�Ե��С��1", 50000, 2},
    {"���Ż�Ե��С��2", 50000, 2},
    {"���Ż�Ե�ؾ�Ӣ1", 100000, 2},
    {"���Ż�Ե�ظ߱�BOOS1", 250000, 2},
    {"���Ż�Ե���ؾ�BOSS1", 500000, 2},
    {"���Ż�Ե��С��2-1", 50000, 2},
    {"���Ż�Ե��С��2-2", 50000, 2},
    {"���Ż�Ե�ؾ�Ӣ2-1", 100000, 2},
    {"���Ż�Ե�ظ߱�2-BOOS1", 250000, 2},
    {"���Ż�Ե���ؾ�2-BOSS1", 500000, 2},
    {"������˵�С��1", 100000, 2},
    {"������˵�С��2", 100000, 2},
    {"������˵ؾ�Ӣ1", 200000, 2},
    {"������˵ظ߱�BOOS1", 500000, 2},
    {"������˵��ؾ�BOSS1", 1000000, 2},
    {"������˵�С��2-1", 100000, 2},
    {"������˵�С��2-2", 100000, 2},
    {"������˵ؾ�Ӣ2-1", 200000, 2},
    {"������˵ظ߱�2-BOOS1", 500000, 2},
    {"������˵��ؾ�2-BOSS1", 1000000, 2},
    {"���츣��С��1", 10000, 2},
    {"���츣��С��2", 10000, 2},
    {"���츣��С��3", 10000, 2},
    {"���츣��С��4", 20000, 2},
    {"���츣�ؾ�Ӣ1", 20000, 2},
    {"���츣�ظ߱�BOOS1", 50000, 2},
    {"���츣���ؾ�BOSS1", 100000, 2},
    {"���켼�ܸ߱�BOOS1", 50000, 2},
    {"���콣�׸߱�BOOS1", 50000, 2},
    {"��������߱�BOOS1", 50000, 2},
    {"�������θ߱�BOOS1", 50000, 2},
    {"����ר��������", 30000, 2},
    {"����ר������ʥ�ˡ�", 30000, 2},
    {"����ר������Ӣ��", 60000, 2},
    {"����ר�����߱�BOSS��", 150000, 2},
    {"����ר�����ؾ�BOSS��", 300000, 2},
    {"����ר��������", 50000, 2},
    {"����ר������ʥ�ˡ�", 50000, 2},
    {"����ר������Ӣ��", 100000, 2},
    {"����ר�����߱�BOSS��", 250000, 2},
    {"����ר�����ؾ�BOSS��", 500000, 2},
    {"����ר��������", 80000, 2},
    {"����ר������ʥ�ˡ�", 80000, 2},
    {"����ר������Ӣ��", 160000, 2},
    {"����ר�����߱�BOSS��", 400000, 2},
    {"����ר�����ؾ�BOSS��", 800000, 2},
    {"����ר��������", 100000, 2},
    {"����ר������ʥ�ˡ�", 100000, 2},
    {"����ר������Ӣ��", 200000, 2},
    {"����ר�����߱�BOSS��", 500000, 2},
    {"����ר�����ؾ�BOSS��", 1000000, 2},
}

function on_post_monster_die(monster,  killer)
    local mapguid = lualib:Map_GetMapGuid("����")
    local dgn = lualib:GetStr(mapguid, "dgn_3")


    local keyName = lualib:KeyName(monster)
    local Name = lualib:Name(monster)
    if lualib:Player_IsPlayer(killer) then

        if keyName == "���" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 8)
            lualib:SysTriggerMsg(killer, "��ɱ�������8����֣���ǰ����Ϊ"..lualib:GetInt(killer, "wu_"..dgn).."�㣡")
        end
        if keyName == "ӥ��" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 30)
            lualib:SysTriggerMsg(killer, "��ɱӥ�������30����֣���ǰ����Ϊ"..lualib:GetInt(killer, "wu_"..dgn).."�㣡")
        end
        if keyName == "�ܵ�" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 200)
            lualib:SysTriggerMsg(killer, "��ɱ�ܵ������200����֣���ǰ����Ϊ"..lualib:GetInt(killer, "wu_"..dgn).."�㣡")
        end
        if keyName == "���" or keyName == "ӥ��" or keyName == "�ܵ�" then
            local mc = ""
            local diyi = ""
            local glamour_ranking_t = lualib:GetDBStr("wu_ranking_t")
            if glamour_ranking_t ~= "" then
                glamour_ranking_t = json.decode(glamour_ranking_t)
            end
            local Client_glamour_ranking_t = {}
            for i = 1, #glamour_ranking_t do
                if glamour_ranking_t == "" then
                else
                    if glamour_ranking_t[i] == nil then
                    else
                        if i == 1 then
                            diyi = "��1��Ϊ:"..glamour_ranking_t[i][2].."�����!"
                        end
                        if glamour_ranking_t[i][1] == lualib:Name(killer) then
                            mc = "��ǰ������"..i.."��!"
                        end

                    end
                end
            end
            lualib:SysTriggerMsg(killer, ""..mc..diyi)
        end

        if keyName == "�ʳ�֮ҹBOSS1" then
            --local zssl = lualib:GenRandom(880000, 1100000)
            --lualib:AddIntegral(killer, zssl, "��Ӱ󶨽��:ԭ��", "������")
            --lualib:SysMsg_SendBroadcastMsg("���["..lualib:Name(killer).."]�����Ļ�ɱ�ˡ���"..Name.."�����������"..zssl.."��ʯ��", "ϵͳ��Ϣ")
        end
        for i = 1, #ss_gw do
            if ss_gw[i][1] == keyName then
                if ss_gw[i][3] - lualib:GetDBNum("��ɱ�ۻ�"..keyName) > 0 then
                    lualib:SetDBNumEx("��ɱ�ۻ�"..keyName, lualib:GetDBNum("��ɱ�ۻ�"..keyName) + 1, 4)
                    lualib:AddIntegral(killer, ss_gw[i][2], "��Ӱ󶨽��:ԭ��", "������")
                    lualib:SysMsg_SendBroadcastMsg("���["..lualib:Name(killer).."]�����Ļ�ɱ����ɱ�����"..Name.."�����������"..ss_gw[i][2].."��ʯ��", "ϵͳ��Ϣ")

                    lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]�����Ļ�ɱ����ɱ�����"..Name.."�����������"..ss_gw[i][2].."��ʯ��","")
                    lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]�����Ļ�ɱ����ɱ�����"..Name.."�����������"..ss_gw[i][2].."��ʯ��","")
                    lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]�����Ļ�ɱ����ɱ�����"..Name.."�����������"..ss_gw[i][2].."��ʯ��","")
                    lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(killer).."]�����Ļ�ɱ����ɱ�����"..Name.."�����������"..ss_gw[i][2].."��ʯ��","")


                    if lualib:GetDBNum("��ɱ�ۻ�"..keyName) == 1 then
                        lualib:SetDBStrEx("��ɱ����"..ss_gw[i][1], lualib:Name(killer), 1)
                    elseif lualib:GetDBNum("��ɱ�ۻ�"..keyName) <= 3 then
                        lualib:SetDBStrEx("��ɱ����"..ss_gw[i][1], lualib:GetDBStr("��ɱ����"..ss_gw[i][1]).."��"..lualib:Name(killer), 1)
                    end
                end
            end
        end
    end

end

----------------------------------------

function on_item_pickup(player, item, item_id, item_name)
    local sz = {
        [1] = {1, 0, 0},
        [2] = {2, 0, 0},
        [3] = {3, 4, 0},
        [4] = {5, 0, 0},
        [5] = {6, 0, 0},
        [6] = {7, 0, 0},
        [7] = {8, 0, 0},
        [8] = {9, 0, 0},
        [9] = {10, 11, 0},
        [10] = {12, 0, 0},
        [11] = {13, 0, 0},
        [12] = {14, 0, 0},
        [13] = {15, 0, 0},
        [14] = {16, 0, 0},
        [15] = {17, 0, 0},
        [17] = {19, 0, 0},
        [18] = {20, 0, 0},
        [19] = {21, 0, 0},
        [20] = {411, 0, 0},




        [34] = {426, 0, 0},
        [35] = {427, 0, 0},
        [36] = {428, 0, 0},
        [37] = {429, 0, 0},
        [38] = {430, 0, 0},
        [39] = {431, 0, 0},
        [40] = {432, 0, 0},
        [41] = {433, 0, 0},

        [42] = {434, 0, 0},
        [43] = {435, 0, 0},
        [44] = {436, 0, 0},
        [45] = {437, 0, 0},
        [46] = {438, 0, 0},
        [47] = {439, 0, 0},
        [48] = {440, 0, 0},
        [49] = {441, 0, 0},


        [22] = {414, 0, 0},
        [23] = {415, 0, 0},
        [24] = {416, 0, 0},
        [25] = {417, 0, 0},
        [26] = {418, 0, 0},

        [27] = {419, 0, 0},
        [28] = {420, 0, 0},
        [29] = {421, 0, 0},
        [30] = {422, 0, 0},
        [31] = {423, 0, 0},
        [32] = {424, 0, 0},
        [33] = {425, 0, 0},
    }

    local item_type = lualib:Item_GetType(player, item)
    local item_subtype = lualib:Item_GetSubType(player, item)
    local lever = lualib:Item_GetLevel(item)
    local item_nameqqq = lualib:Name(item)

    if lualib:GetInt(player, "huishou_11") == 0 then

        if item_type == 1 then
            local item_site_1 = lualib:Player_GetItemGuid(player, sz[item_subtype][1])
            local item_site_2 = ""
            if sz[item_subtype][2] > 0 then
                item_site_2 = lualib:Player_GetItemGuid(player, sz[item_subtype][2])
            end
            if item_subtype == 3 then

                if item_site_1 == "" then
                    local wuguid = {item, item_name, 3, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                if item_site_2 == "" then
                    local wuguid = {item, item_name, 4, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                local leverss_1 = lualib:Item_GetLevel(item_site_1)
                local leverss_2 = lualib:Item_GetLevel(item_site_2)
                if leverss_1 < lever then
                    local wuguid = {item, item_name, 3, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                if leverss_2 < lever then
                    local wuguid = {item, item_name, 4, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end


            elseif item_subtype == 9 then

                if item_site_1 == "" then
                    local wuguid = {item, item_name, 10, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                if item_site_2 == "" then
                    local wuguid = {item, item_name, 11, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                local leverss_1 = lualib:Item_GetLevel(item_site_1)
                local leverss_2 = lualib:Item_GetLevel(item_site_2)
                if leverss_1 < lever then
                    local wuguid = {item, item_name, 10, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end
                if leverss_2 < lever then
                    local wuguid = {item, item_name, 11, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                end


            else

                local item_site = lualib:Player_GetItemGuid(player, sz[item_subtype][1])
                if item_site == "" then
                    local wuguid = {item, item_name, 0, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "�ű���", script)
                    lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                    return ""
                else
                    local leverss = lualib:Item_GetLevel(item_site)
                    if leverss < lever then
                        local wuguid = {item, item_name, 0, item_nameqqq}
                        local script = "wuguid = "..serialize(wuguid)
                        lualib:ShowFormWithContent(player, "�ű���", script)
                        lualib:ShowFormWithContent(player,"form�ļ���","װ���滻")
                        return ""
                    end
                end
            end
        end
    end




end


function on_post_die(player, killer)
    if lualib:Player_IsPlayer(player) and lualib:Player_IsPlayer(killer) then
        lualib:SetInt(player, "siwang", lualib:GetInt(player, "siwang") + 1)
        lualib:SetInt(killer, "zhansha", lualib:GetInt(killer, "zhansha") + 1)

        local mapguid = lualib:Map_GetMapGuid("����")
        local map_guid = lualib:MapGuid(killer)
        local dgn = lualib:GetStr(mapguid, "dgn_3")
        if dgn ~= "" and dgn == map_guid then
            local glamour = lualib:GetInt(player, "wu_"..dgn) * 0.1
            glamour = math.floor(glamour)
            lualib:SetInt(player, "wu_"..dgn, lualib:GetInt(player, "wu_"..dgn) - glamour)
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + glamour)
            lualib:SysTriggerMsg(player, "�㱻["..lualib:Name(killer).."]��ɱ,��ʧ��"..glamour.."����֣��㵱ǰ����Ϊ"..lualib:GetInt(player, "wu_"..dgn).."��")
            lualib:SysTriggerMsg(killer, "���ɱ��["..lualib:Name(player).."],�����"..glamour.."����֣��㵱ǰ����Ϊ"..lualib:GetInt(killer, "wu_"..dgn).."��")
            local mc = ""
            local diyi = ""
            local glamour_ranking_t = lualib:GetDBStr("wu_ranking_t")
            if glamour_ranking_t ~= "" then
                glamour_ranking_t = json.decode(glamour_ranking_t)
            end
            local Client_glamour_ranking_t = {}
            for i = 1, #glamour_ranking_t do
                if glamour_ranking_t == "" then
                else
                    if glamour_ranking_t[i] == nil then
                    else
                        if i == 1 then
                            diyi = "��1��Ϊ:"..glamour_ranking_t[i][2].."�����!"
                        end
                        if glamour_ranking_t[i][1] == lualib:Name(killer) then
                            mc = "��ǰ������"..i.."��!"
                        end

                    end
                end
            end
            lualib:SysTriggerMsg(killer, ""..mc..diyi)
        end
    end
    lualib:SetInt(player, "die_flag", 1)
end

function on_ride_request(player)
    local hashorse = lualib:Attr(player, 200)
    if hashorse == 1 then
        lualib:MsgBox(player, "���Ѿ��������״̬�ˣ�")
        return
    end

    --�������
    lualib:ProgressBarStart(player, 1000, "������", "on_Horse_true", "on_Horse_false", "")
end

--����
function on_Horse_true(player)
    lualib:Ride(player)
end

--�������
function on_Horse_false(player)
    lualib:SysTriggerMsg(player, "�������")
end

-- ����
function on_unride_request(player)
    local hashorse = lualib:Attr(player, 200)
    if hashorse == 2 then
        lualib:MsgBox(player, "�㻹û����ˣ���������״̬�ˣ�")
    else
        lualib:UnRide(player)
    end
end

function on_player_relive(player)
    lualib:SetInt(player, "die_flag", 0)
    local map = lualib:Map_GetMapGuid("����")
    if lualib:IsCastleWarStart("����") then
        local own_family = lualib:GetCastleOwnFamily("����")
        local my_family = lualib:GetFamilyName(player)

        if own_family == "" or my_family == "" then
            return true
        else
            if lualib:GetCastleOwnFamily("����")== my_family or lualib:GetCastleTempFamily("����") == my_family then
                lualib:Player_Relive(player, map, 532, 243, 5, 20)
                return false
            else
                return true
            end
        end
    else
        return true
    end
end

function compare(a, b)
    return a[3] > b[3]
end


ditukoufei = {
    ["��گ����1��"] = 50,
    ["��گ����2��"] = 50,
    ["��Խ����1��"] = 100,
    ["��Խ����2��"] = 100,
    ["��ҽ�ڣ1��"] = 150,
    ["��ҽ�ڣ2��"] = 150,
    ["��ţ���1��"] = 200,
    ["��ţ���2��"] = 200,
    ["ۺ���Ĺ�1��"] = 250,
    ["ۺ���Ĺ�2��"] = 250,
    ["����ѧ��1��"] = 300,
    ["����ѧ��2��"] = 300,
    ["��������1��"] = 350,
    ["��������2��"] = 350,
    ["��Ȼɽ��1��"] = 400,
    ["��Ȼɽ��2��"] = 400,
    ["�彣�ָ�1��"] = 450,
    ["�彣�ָ�2��"] = 450,
    ["��ɽ��ѩƺ1��"] = 500,
    ["��ɽ��ѩƺ2��"] = 500,
    ["���ػ���1��"] = 550,
    ["���ػ���2��"] = 550,
    ["��ç����ͥ1��"] = 400,
    ["��ç����ͥ2��"] = 400,
    ["����̫����1��"] = 500,
    ["����̫����2��"] = 500,
    ["������ͼ"] = 200,
    ["���ߵ�ͼ"] = 200,
    ["���˵�ͼ"] = 500,
    ["���ŵ�ͼ"] = 500,
    ["���̸��ǵ�1��"] = 200,
    ["���̸��ǵ�2��"] = 200,
    ["���Ż�Ե��1��"] = 500,
    ["���Ż�Ե��2��"] = 500,
    ["������˵�1��"] = 800,
    ["������˵�2��"] = 800,
}

function dakai(bResult,dwError,strError,iResultNum,tRecordSets,player)
    local msg_error = ""
    if bResult == false then
        msg_error = msg_error .. "�����룺"..dwError.."\n"
        msg_error = msg_error .. "������Ϣ��"..strError.."\n"
        lualib:NPCTalk(player, msg_error)
        return
    end
    local id = tostring(lualib:UserID(player))
    local day_num = 0
    for k,v in pairs(tRecordSets) do
        day_num = day_num + tonumber(v[2])
    end
    lualib:SetDBNum("bill_ingot_dongtian_"..id, day_num)				--�洢��ֵԪ������
    day_num = day_num  + lualib:GetDayInt(player, "richong1")
end


function comparea(a, b)
    return a[2] > b[2]
end


local dhtlb = {
    {50000, 20, 160, 2, 1, 1.01},
    {80000, 40, 300, 2, 2, 1.02},
    {110000, 60, 500, 2, 3, 1.03},
    {120000, 80, 700, 2, 4, 1.04},
    {130000, 120, 1000, 2, 6, 1.05},
    {150000, 160, 1300, 3, 8, 1.06},
    {200000, 200, 1600, 3, 10, 1.07},
    {300000, 240, 2000, 3, 12, 1.08},
    {500000, 300, 2400, 3, 14, 1.09},
    {800000, 400, 3000, 4, 16, 1.10},
    {1200000, 500, 3600, 4, 18, 1.12},
    {3000000, 600, 4400, 4, 20, 1.14},
    {8000000, 800, 5600, 4, 22, 1.16},
    {10000000, 1000, 7000, 4, 24, 1.18},
    {15000000, 1200, 9000, 4, 26, 1.20},
    {20000000, 1600, 12000, 4, 28, 1.22},
    {30000000, 2200, 16000, 5, 31, 1.25},
    {50000000, 3000, 24000, 6, 35, 1.30},
    {"�ѷⶥ����", 3000, 24000, 6, 35, 1.35},
    {"�ѷⶥ����", 3000, 24000, 6, 35, 1.35},
}

function compare(a, b)
    return a[2] > b[2]
end

---------------------------------------------1�붨ʱ��



local dituxianshi = {
    ["������1��"] = {480},
    ["������1��"] = {2040},
    ["���ɽ1��"] = {1320},
    ["������1��"] = {600},
    ["����ɽ1��"] = {360},
    ["������2��"] = {480},
    ["������2��"] = {2040},
    ["���ɽ2��"] = {1320},
    ["������2��"] = {600},
    ["����ɽ2��"] = {360},
}


local wudi_map = {  --�����޵йһ���ͼ ����ʽ���
    ["����ɽ1��"] = 1,
    ["����ɽ2��"] = 1,
    ["������1��"] = 1,
    ["������2��"] = 1,
    ["������1��"] = 1,
    ["������2��"] = 1,
    ["���ɽ1��"] = 1,
    ["���ɽ2��"] = 1,
    ["������1��"] = 1,
    ["������2��"] = 1,
    ["������1��"] = 1,
    ["������2��"] = 1,
    ["��֬��"] = 1,
    ["����ͤ"] = 1,
    ["ϴ���"] = 1,
    ["����ɽ1��"] = 1,
    ["������1��"] = 1,
    ["��۳�1��"] = 1,
    ["����ɽ2��"] = 1,
    ["������2��"] = 1,
    ["��۳�2��"] = 1,
}

function dingshi(player, time_id)
    local item_map_guid = lualib:MapGuid(player)
    local item_map_name = lualib:Name(item_map_guid)

    if lualib:GetAllDays(0) - lualib:GetInt(player,"wdgj_gengxin") >= 1 then
        if lualib:GetInt(player, "zz_4") == 1 then
            lualib:SetInt(player,"wudiguaji", 64800)
        elseif lualib:GetInt(player, "zz_3") == 1 then
            lualib:SetInt(player,"wudiguaji", 43200)
        elseif lualib:GetInt(player, "zz_2") == 1 then
            lualib:SetInt(player,"wudiguaji", 21600)
        elseif lualib:GetInt(player, "zz_1") == 1 then
            lualib:SetInt(player,"wudiguaji", 10800)
        end
        lualib:SetInt(player,"wdgj_gengxin", lualib:GetAllDays(0))
    end

    if lualib:GetInt(player, "wudiguaji") <= 0 then
        if lualib:HasBuff(player,"�޵йһ�") then
            lualib:DelBuff(player, "�޵йһ�")
        end
    end


    if item_map_name == "������" then
        lualib:SetInt(player, "autoattack", 0)
        if lualib:HasBuff(player,"�Զ��һ�") then
            lualib:DelBuff(player, "�Զ��һ�")
        end
        if lualib:HasBuff(player,"�޵йһ�") then
            lualib:DelBuff(player, "�޵йһ�")
        end
    end



    if lualib:GetInt(player, "autoattack") == 1 then
        if lualib:GetInt(player, "huishou_12") == 1 then
            if lualib:GetInt(player,"wudiguaji") > 0 then
                if lualib:HasBuff(player,"�޵йһ�") then
                else
                    lualib:AddBuff(player, "�޵йһ�", 0)
                end
            end
        end
        if lualib:GetInt(player,"wudiguaji") <= 0 then
            lualib:SetInt(player,"wudiguaji", 0)
            if lualib:HasBuff(player,"�޵йһ�") then
                lualib:DelBuff(player, "�޵йһ�")
            end
        end
    else
        if lualib:HasBuff(player,"�޵йһ�") then
            lualib:DelBuff(player, "�޵йһ�")
        end
    end

    if dituxianshi[item_map_name] ~= nil then
        if dituxianshi[item_map_name][1] - lualib:GetDBNum("����ʱ��") <= 0 then
            lualib:Player_MapMoveXY(player, "����", 255, 270, 3)
        end
    end

    local now = lualib:Now()
    local Start = lualib:GetConstVar("StartServerTime")
    local Test = lualib:GetConstVar("TestServerTime")
    local time1 = lualib:Str2Time(now)
    local time2 = lualib:Str2Time(Start)
    local time3 = lualib:Str2Time(Test)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)
    if time1 < time2 and time1 > time3 then

        if item_map_name ~= "���ֽӴ���" then
            lualib:Player_MapMove(player, "���ֽӴ���")
            -- lualib:Player_MapMoveXY(player, "����", 255, 270, 3)
        end

    end


    local wfsxs = {
        ["����1"] = 1,
        ["����2"] = 2,
        ["����3"] = 3,
        ["����4"] = 4,
        ["����5"] = 6,
        ["����6"] = 8,
        ["����7"] = 11,
        ["����8"] = 15,
    }
    local item_site = lualib:Player_GetItemGuid(player, 411)
    if item_site ~= "" then
        local keyname = lualib:KeyName(item_site)
        if wfsxs[keyname] ~= nil then
            lualib:SetDynamicAttr(player, 45, 81, wfsxs[keyname])
            lualib:SetDynamicAttr(player, 46, 87, wfsxs[keyname])
        end
    else
        lualib:SetDynamicAttr(player, 45, 81, 0)
        lualib:SetDynamicAttr(player, 46, 87, 0)
    end





    if item_map_name == "���ֽӴ���" then
        -- lualib:Player_MapMoveXY(player, "����", 255, 270, 3)
    end

    if item_map_name == "������" then
        if lualib:HasBuff(player,"�Զ��һ�") then
            lualib:DelBuff(player, "�Զ��һ�")
        end
    end

    local sh = lualib:Attr(player, 87)
    local jm = lualib:Attr(player, 124)
    local hs = lualib:Attr(player, 215)
    local tili = lualib:Attr(player, 81)
    local daguai = 0

    local wpszbd = {
        ["������1"] = 10000,
        ["������2"] = 6000,
        ["������3"] = 4000,
        ["������4"] = 3000,
        ["������5"] = 2500,
        ["������6"] = 2000,
        ["������7"] = 1000,
        ["������8"] = 800,
        ["������9"] = 600,
        ["������10"] = 400,
    }
    for i = 1, 10 do
        if lualib:HasBuff(player,"������"..i) then
            daguai = daguai + wpszbd["������"..i]
        end
    end
    if lualib:HasBuff(player,"��������") then
        daguai = daguai + 3888
    end
    if lualib:HasBuff(player,"���Ž��") then
        daguai = daguai + 1000
    end
    if lualib:HasBuff(player,"����ָ��") then
        daguai = daguai + 3000
    end
    if lualib:HasBuff(player,"�������") then
        daguai = daguai + 5000
    end
    if lualib:HasBuff(player,"½������") then
        daguai = daguai + 8000
    end

    local rtcswk = {600, 1000, 1600, 2200, 3000, 3600, 5000, 6400, 9000, 12000, 15000, 18000}
    local tcwk_dj = lualib:GetInt(player,"tcwk_dj")
    if tcwk_dj > 0 then
        daguai = daguai + rtcswk[tcwk_dj]
    end


    local yhuisz = {
        ["����1"] = 300,
        ["����2"] = 400,
        ["����3"] = 700,
        ["����4"] = 1000,
        ["����5"] = 1600,
        ["����6"] = 2400,
        ["����7"] = 3000,
        ["����8"] = 3600,
        ["����9"] = 4400,
        ["����10"] = 6000,
    }
    local dnpai = lualib:JuJu(player)
    if dnpai ~= "" then
        local KeyName = lualib:KeyName(dnpai);
        if yhuisz[KeyName] ~= nil then
            daguai = daguai + yhuisz[KeyName]
        end
    end
    local yifu = lualib:Armor(player)
    if yifu ~= "" then
        if lualib:KeyName(yifu) == "�����·�" then
            daguai = daguai + 666
        end
    end
    local wuqi = lualib:Weapon(player)
    if wuqi ~= "" then
        if lualib:KeyName(wuqi) == "��������" then
            daguai = daguai + 1288
        end
    end


    --[[  if lualib:GetClientType(player) == 2 then
                 lualib:ShowFormWithContent(player, "�ű���", "RoleTitle.gengxin("..sh..", "..jm..", "..hs..", "..tili..", "..daguai..")");
              else
                 lualib:ShowFormWithContent(player, "�ű���", "RoleAtt.gengxin("..sh..", "..jm..", "..hs..", "..tili..", "..daguai..")");
              end

]]

    local fuhjz = {
        ["����1"] = 1,
        ["����2"] = 1,
        ["����3"] = 1,
        ["����4"] = 1,
        ["����5"] = 1,
        ["����6"] = 1,
        ["����7"] = 1,
        ["����8"] = 1,
        ["����9"] = 1,
        ["����10"] = 1,
    }
    local youfuhuo = ""
    local gem0 = lualib:Player_GetItemGuid(player, 10)
    if gem0 ~= "" then
        if fuhjz[lualib:KeyName(gem0)] ~= nil then
            youfuhuo = "�и���װ��"
        end
    end
    local gem1 = lualib:Player_GetItemGuid(player, 11)
    if gem1 ~= "" then
        if fuhjz[lualib:KeyName(gem1)] ~= nil then
            youfuhuo = "�и���װ��"
        end
    end
    local gold = lualib:GetGold(player)
    local integral = lualib:GetIntegral(player)
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player, "�ű���", "GameMall.gengxin("..gold..")");
        lualib:ShowFormWithContent(player, "�ű���", "Package.gengxin("..integral..")");
    else
        lualib:ShowFormWithContent(player, "�ű���", "Package.gengxin("..integral..")");
    end

    --[[   local ingot = lualib:GetIngot(player)
              if lualib:GetClientType(player) == 2 then
                 lualib:ShowFormWithContent(player, "�ű���", "Package.gengxins("..ingot..")");
              end
]]



    if youfuhuo ~= "" then
        if lualib:HasBuff(player, "����ʯ����") then
            if lualib:GetClientType(player) == 2 then
                lualib:ShowFormWithContent(player, "�ű���", "PlayerHeaderInfo.fuhuo(0)");
            else
                lualib:ShowFormWithContent(player, "�ű���", "GameMainBar.fuhuo(0)");
            end
        else
            if lualib:GetClientType(player) == 2 then
                lualib:ShowFormWithContent(player, "�ű���", "PlayerHeaderInfo.fuhuo(1)");
            else
                lualib:ShowFormWithContent(player, "�ű���", "GameMainBar.fuhuo(1)");
            end
        end
    else
        if lualib:GetClientType(player) == 2 then
            lualib:ShowFormWithContent(player, "�ű���", "PlayerHeaderInfo.fuhuo(0)");
        else
            lualib:ShowFormWithContent(player, "�ű���", "GameMainBar.fuhuo(0)");
        end
    end


    local phyatk_hei = lualib:PhyAtk(player, true)    --ȡ����
    local name = lualib:Name(player)
    local level = lualib:Level(player)
    local dht = lualib:GetInt(player,"dht")
    local hhmc = lualib:GetFamilyName(player)
    if hhmc == "" then
        hhmc = "��"
    end
    local glamour = phyatk_hei

    if glamour > 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("zhanlis_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if player == v[6] and v[2] > 0 then
                table.remove(ranking, k)
            end
        end
        table.insert(ranking, {name, glamour, level, hhmc, dht, player})
        table.sort(ranking, compare)
        if #ranking > 20 then
            table.remove(ranking, #ranking)
        end
        lualib:SetDBStrEx("zhanlis_ranking_t", json.encode(ranking), 6)
    end





    local level = lualib:Level(player)
    local dht = lualib:GetInt(player,"dht") + 1
    local dq = lualib:GetInt(player,"dht_dq")
    if dht <= 18 and lualib:Level(player) >= 50 then
        local xuqiu = dhtlb[dht][1]
        if dq >= xuqiu then
            lualib:SetInt(player,"dht_dq", lualib:GetInt(player,"dht_dq") - xuqiu)
            lualib:SetInt(player,"dht", lualib:GetInt(player,"dht") + 1)
            lualib:SetDynamicAttr(player, 20, 3, dhtlb[dht][3])
            lualib:SetDynamicAttr(player, 21, 6, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 22, 7, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 23, 8, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 24, 9, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 25, 10, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 26, 11, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 27, 12, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 28, 13, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 29, 14, dhtlb[dht][2])
            lualib:SetDynamicAttr(player, 30, 15, dhtlb[dht][2])
            lualib:SetInt(player,"tili", dhtlb[dht][5])
            lualib:SetInt(player,"shenli", dhtlb[dht][5])
            lualib:SetLevel(player, level + dhtlb[dht][4])
            lualib:SysTriggerMsg(player, "��ɹ������ͥ������["..lualib:GetInt(player,"dht").."]��!")
            local msg = "���["..lualib:Name(player).."]�����ͥ������["..lualib:GetInt(player,"dht").."]��!,����˴������Լӳɣ���"
            lualib:SysMsg_SendCenterMsg(1, "���["..lualib:Name(player).."]�����ͥ������["..lualib:GetInt(player,"dht").."]��!,����˴������Լӳɣ���",  "")
            lualib:SysMsg_SendBroadcastMsg(msg, "�����鱨")
        end
    end


    if lualib:GetInt(player, "fangdu_cd") <= 0 then
        if lualib:HasBuff(player,"ʩ������Ѫ4��") then
            if lualib:GenRandom(1, 100) <= lualib:GetInt(player, "fangdu") then
                lualib:DelBuff(player, "ʩ������Ѫ4��")
                lualib:SysTriggerMsg(player, "��ķɽ�������ʩ�������ж�Ч��!")
                lualib:SetInt(player, "fangdu_cd", 5)
            end
        end
        if lualib:HasBuff(player,"ʩ��������4��") then
            if lualib:GenRandom(1, 100) <= lualib:GetInt(player, "fangdu") then
                lualib:DelBuff(player, "ʩ��������4��")
                lualib:SysTriggerMsg(player, "��ķɽ�������ʩ�������ж�Ч��!")
                lualib:SetInt(player, "fangdu_cd", 5)
            end
        end
    else
        lualib:SetInt(player, "fangdu_cd", lualib:GetInt(player, "fangdu_cd") - 1)
    end

    --lualib:SetInt(player, "zlsc", lualib:GetInt(player, "zlsc") + 1)
    --if lualib:GetInt(player, "zlsc") >= 20 then
    --lualib:Player_FixEquip(player, true)
    --lualib:ShowFormWithContent(player,"�ű���","TaskWindow.zhengli(111)")
    --end


    if lualib:GetInt(player, "autoattack") == 1 then

        if lualib:HasBuff(player,"�Զ��һ�") then
        elseif item_map_name ~= "������" then
            lualib:AddBuff(player, "�Զ��һ�", 0)
        end

        lualib:Player_FixEquip(player, true)
        if lualib:Player_GetBagFree(player) < lualib:GetInt(player, "huishou_16") then
            lualib:Player_FixEquip(player, true)
            lualib:ShowFormWithContent(player,"�ű���","TaskWindow.zhengli(111)")
            for i = 1, 27 do
                if lualib:GetInt(player, "jilu_"..i) == 1 then
                    lualib:DelayCall(player, 1, "���ձ�:huishou", ""..i);
                end
            end
            if lualib:GetInt(player, "zz_2") == 1 then
                for i = 1, 9 do
                    if lualib:GetInt(player, "huishou_"..i) == 1 then
                        lualib:DelayCall(player, 1, "�Զ��һ�:xianhs", ""..i);
                    end
                end
            end

        end
    else
        if lualib:HasBuff(player,"�Զ��һ�") then
            lualib:DelBuff(player, "�Զ��һ�")
        end
    end






    if lualib:GetInt(player, "xianren") > 0 then
        lualib:SetInt(player, "xianren", lualib:GetInt(player, "xianren") - 1)
    end


    local id = lualib:UserID(player)		--ȡ����ҵ��ʺ�ID.
    local today = lualib:GetAllDays(0)
    local starttime = lualib:Str2Time(lualib:Time2Str("%Y-%m-%d", lualib:GetAllTime()))
    lualib:PostDBEvt("select order_id,billin from tblbilllog where user_id=" .. id .. " and billin >= 0 and time > " .. starttime , "dakai", player)


    local bill_ingot = lualib:GetDBNum("bill_ingot_dongtian_"..id)  +  lualib:GetDayInt(player, "richong1")
    if bill_ingot >= 10000 then
        if lualib:HasBuff(player,"���츣��") then
        else
            lualib:AddBuff(player, "���츣��", 0)
        end
    else
        if lualib:HasBuff(player,"���츣��") then
            lualib:DelBuff(player, "���츣��")
        end
    end

    local map_guid = lualib:MapGuid(player)
    local map_name = lualib:Name(map_guid)
    if map_name == "���츣��" then
        if lualib:HasBuff(player,"��������") == false then
            lualib:Player_MapMoveXY(player, "����", 255, 270, 5)
        end
        if lualib:HasBuff(player,"���츣��") == false then
            lualib:Player_MapMoveXY(player, "����", 255, 270, 5)
        end
    end


    lualib:SetInt(player, "lj_huixue", lualib:GetInt(player, "lj_huixue") + 1)
    if lualib:GetInt(player, "lj_huixue") >= 3 then
        lualib:SetInt(player, "lj_huixue", 0)

        if lualib:GetInt(player, "xz_huixue") == 0 then
            lualib:SetInt(player, "xz_huixue", 1)
        end
        local xue = lualib:GetInt(player, "huixue")
        local lmt_hp = lualib:Hp(player, true) * xue / 100
        local cur_hp = lualib:Hp(player, false)
        local gold = lualib:GetGold(player)
        local xz_huixue = lualib:GetInt(player, "xz_huixue")
        if xz_huixue == 1 then
            if cur_hp < lmt_hp then
                local hp = lmt_hp * 0.02
                lualib:SetHp(player, cur_hp + hp, false)
                lualib:ShowRoleHPRef(player, player, hp)
            end
        elseif xz_huixue == 2 then
            if cur_hp < lmt_hp then
                if gold < 300 then
                    lualib:SysTriggerMsg(player, "��������300�������Զ��л�Ϊ��ѻ�Ѫ!")
                    lualib:SetInt(player, "xz_huixue", 1)
                    return ""
                end
                lualib:SubGold(player, 300, "�۳�����ԭ��", lualib:Name(player));
                local hp = lmt_hp * 0.03
                lualib:SetHp(player, cur_hp + hp, false)
                lualib:ShowRoleHPRef(player, player, hp)
            end
        elseif xz_huixue == 3 then
            if cur_hp < lmt_hp then
                if lualib:ItemCount(player, "��ɽѩ��") < 30 then
                    lualib:SysTriggerMsg(player, "��ɽѩ������30�������Զ��л�Ϊ��ѻ�Ѫ!")
                    lualib:SetInt(player, "xz_huixue", 1)
                    return ""
                end
                lualib:DelItem(player, "��ɽѩ��", 30, 2, "�̻�", "�̻�")
                local hp = lmt_hp * 0.05
                lualib:SetHp(player, cur_hp + hp, false)
                lualib:ShowRoleHPRef(player, player, hp)
            end
        end
    end




    --lualib:Player_RunScript(player,"״̬ˢ�±�:main","")

    local name = lualib:Name(player)

    local mapguid = lualib:Map_GetMapGuid("����")
    local dgn = lualib:GetStr(mapguid, "dgn_3")
    if dgn ~= "" then
        local glamour = lualib:GetInt(player, "wu_"..dgn)
        if glamour > 0 then
            local ranking = {}
            local rankstr = lualib:GetDBStr("wu_ranking_t")
            if rankstr ~= "" then
                ranking = json.decode(rankstr)
            end
            for k, v in ipairs(ranking) do
                if player == v[3] and v[2] > 0 then
                    table.remove(ranking, k)
                end
            end
            table.insert(ranking, {name, glamour, player})
            table.sort(ranking, comparea)
            if #ranking > 100000 then
                table.remove(ranking, #ranking)
            end
            lualib:SetDBStrEx("wu_ranking_t", json.encode(ranking), 6)
        end
    end



    if lualib:GetAllDays(0) - lualib:GetInt(player,"zs_gengxin") >= 1 then
        lualib:SetInt(player, "ls_zs", 0)
        lualib:SetInt(player,"zs_gengxin", lualib:GetAllDays(0))
    end

    if lualib:GetAllDays(0) - lualib:GetDBNum("zs_paihang") >= 1 then
        local glamour_ranking_t = lualib:GetDBStr("zhansha_ranking_t")
        if glamour_ranking_t ~= "" then
            glamour_ranking_t = json.decode(glamour_ranking_t)
        end
        local Client_glamour_ranking_t = {}
        for i = 1, #glamour_ranking_t do
            if glamour_ranking_t == "" then
            else
                if glamour_ranking_t[i] == nil then
                else
                    if i == 1 then
                        lualib:Mail("նɱ��", glamour_ranking_t[i][1], "���ڽ���նɱ���л���˵�1��,�����300000��ʯ������", 0, 0, {"100000��ʯ",3,1})
                    elseif i == 2 then
                        lualib:Mail("նɱ��", glamour_ranking_t[i][1], "���ڽ���նɱ���л���˵�2��,�����200000��ʯ������", 0, 0, {"100000��ʯ",2,1})
                    elseif i == 3 then
                        lualib:Mail("նɱ��", glamour_ranking_t[i][1], "���ڽ���նɱ���л���˵�3��,�����100000��ʯ������", 0, 0, {"100000��ʯ",1,1})
                    end

                end
            end
        end
        lualib:SetDBStrEx("zhansha_ranking_t", "", 6)
        lualib:SetDBNumEx("zs_paihang", lualib:GetAllDays(0), 6)
    end

    local glamour = lualib:GetInt(player, "ls_zs")
    if glamour > 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("zhansha_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if player == v[3] and v[2] > 0 then
                table.remove(ranking, k)
            end
        end
        table.insert(ranking, {name, glamour, player})
        table.sort(ranking, comparea)
        if #ranking > 100000 then
            table.remove(ranking, #ranking)
        end
        lualib:SetDBStrEx("zhansha_ranking_t", json.encode(ranking), 6)
    end





    local zhansha = lualib:GetInt(player, "zhansha")
    local siwang = lualib:GetInt(player, "siwang")
    lualib:SetStr(player, "_na_", "նɱ:"..zhansha.." ����:"..siwang)
    lualib:NotifyVar(player, "_na_")


    local map_guid = lualib:MapGuid(player)
    local dtkey = lualib:KeyName(map_guid)
    if ditukoufei[dtkey] ~= nil then
        local gold = lualib:GetGold(player)
        if gold < ditukoufei[dtkey] then
            lualib:MsgBox(player, "�õ�ͼÿ����۳�����"..ditukoufei[dtkey].."��,����������,�ѱ����ͻسǡ�")
            lualib:Player_MapMoveXY(player, "����", 255, 270, 3)
            return ""
        else
            if lualib:GetClientType(player) == 2 then
                lualib:SysTipsMsg(player, "�۳�����"..ditukoufei[dtkey])
            end
            lualib:SubGold(player, ditukoufei[dtkey], "�۳�����ԭ��", lualib:Name(player));
        end
    end


    local level = lualib:Level(player)
    if level < 50 then
        lualib:AddExp(player, 1888, "��Ӿ���:ԭ��", "������")
    end

    if lualib:GetInt(player, "yysq") >= 30 then
        if lualib:HasSkill(player, "��������", false) == false then
            lualib:Player_AddSkill(player, "��������")
        end
    end
    if lualib:GetInt(player, "yysq") >= 60 then
        if lualib:HasSkill(player, "һָ�Ͻ�", false) == false then
            lualib:Player_AddSkill(player, "һָ�Ͻ�")
        end
    end

    if lualib:GetInt(player, "yysq") >= 90 then
        if lualib:HasSkill(player, "���˸���", false) == false then
            lualib:Player_AddSkill(player, "���˸���")
        end
    end

    if lualib:HasBuff(player,"��������") then
        if lualib:HasSkill(player, "�����䵶4��", false) == false then
            lualib:Player_AddSkill(player, "�����䵶4��")
        end
    else
        if lualib:HasSkill(player, "�����䵶4��", false) == true then
            lualib:DelSkill(player, "�����䵶4��")
        end
    end



    if lualib:ItemCount(player, "50����") > 0 then
        lualib:ApplyItem(player, "50����", false);
    end
    if lualib:ItemCount(player, "100����") > 0 then
        lualib:ApplyItem(player, "100����", false);
    end
    if lualib:ItemCount(player, "200����") > 0 then
        lualib:ApplyItem(player, "200����", false);
    end
    if lualib:ItemCount(player, "500����") > 0 then
        lualib:ApplyItem(player, "500����", false);
    end
    if lualib:ItemCount(player, "1000����") > 0 then
        lualib:ApplyItem(player, "1000����", false);
    end
    if lualib:ItemCount(player, "2000����") > 0 then
        lualib:ApplyItem(player, "2000����", false);
    end
    if lualib:ItemCount(player, "100��ʯ") > 0 then
        lualib:ApplyItem(player, "100��ʯ", false);
    end
    if lualib:ItemCount(player, "200��ʯ") > 0 then
        lualib:ApplyItem(player, "200��ʯ", false);
    end
    if lualib:ItemCount(player, "200��ͥ��") > 0 then
        lualib:ApplyItem(player, "200��ͥ��", false);
    end
    if lualib:ItemCount(player, "500��ͥ��") > 0 then
        lualib:ApplyItem(player, "500��ͥ��", false);
    end
    if lualib:ItemCount(player, "100��ͥ��") > 0 then
        lualib:ApplyItem(player, "100��ͥ��", false);
    end

    if lualib:GetInt(player, "yysq") >= 90 then
        if lualib:GetDBStr("����1") == "" then
            lualib:SetDBStrEx("����1", lualib:Name(player), 1)

        elseif lualib:GetDBStr("����2") == "" then
            if lualib:GetDBStr("����1") ~= lualib:Name(player) then
                lualib:SetDBStrEx("����2", lualib:Name(player), 1)
            end

        elseif lualib:GetDBStr("����3") == "" then
            if lualib:GetDBStr("����1") ~= lualib:Name(player) and lualib:GetDBStr("����2") ~= lualib:Name(player) then
                lualib:SetDBStrEx("����3", lualib:Name(player), 1)
            end

        end
    end



    local glamour = 0
    local glamour_ranking_t = lualib:GetDBStr("jz_ranking_t")
    if glamour_ranking_t ~= "" then
        glamour_ranking_t = json.decode(glamour_ranking_t)
    end
    local mc = 0
    for i = 1, #glamour_ranking_t do
        if glamour_ranking_t == "" then
        else
            if glamour_ranking_t[i] == nil then
            else
                if glamour_ranking_t[i][2] == player then
                    glamour = glamour_ranking_t[i][3]
                    mc = i
                end
            end
        end
    end
    if mc ~= 0 and mc <= 10 then
        if lualib:HasBuff(player,"������"..mc) then
        else
            lualib:AddBuff(player, "������"..mc, 0)
        end
    elseif glamour >= 100000 then
        if lualib:HasBuff(player,"������10") then
        else
            lualib:AddBuff(player, "������10", 0)
        end
    else
        for i = 1 , 10 do
            if lualib:HasBuff(player,"������"..i) then
                lualib:DelBuff(player, "������"..i)
            end
        end
    end





    local guid = lualib:GuildGuid(player)
    if guid ~= "" then
        if lualib:GetDBNum("hequbs") > 1 then
            lualib:SetFamilyMaxMember(guid, 200)
        else
            lualib:SetFamilyMaxMember(guid, 15)
        end
    end



    if wudi_map[item_map_name] == nil then
        if lualib:HasBuff(player,"�޵йһ�") then
            lualib:DelBuff(player, "�޵йһ�")
        end
    end
    if item_map_name == "������" then
        if lualib:HasBuff(player,"�Զ��һ�") then
            lualib:DelBuff(player, "�Զ��һ�")
        end
    end
    if lualib:HasBuff(player,"�޵йһ�") then
        lualib:SetInt(player,"wudiguaji", lualib:GetInt(player,"wudiguaji") - 1)
    end
end

local zhansha_tb = {
    {"[1��]С��","նɱ[lv1]������Ѫ������1%ʱ��ֱ����ɱ����","նɱ[lv2]������Ѫ������2%ʱ��ֱ����ɱ����","նɱ[lv2]�������������ס�[2��]�ݼ���ʱ����"},
    {"[2��]�ݼ�","նɱ[lv2]������Ѫ������2%ʱ��ֱ����ɱ����","նɱ[lv3]������Ѫ������3%ʱ��ֱ����ɱ����","նɱ[lv3]�������������ס�[3��]�꼧��ʱ����"},
    {"[3��]�꼧","նɱ[lv3]������Ѫ������3%ʱ��ֱ����ɱ����","նɱ[lv4]������Ѫ������4%ʱ��ֱ����ɱ����","նɱ[lv4]�������������ס�[4��]��榡�ʱ����"},
    {"[4��]���","նɱ[lv4]������Ѫ������4%ʱ��ֱ����ɱ����","նɱ[lv5]������Ѫ������6%ʱ��ֱ����ɱ����","նɱ[lv5]�������������ס�[5��]��嵡�ʱ����"},
    {"[5��]���","նɱ[lv5]������Ѫ������6%ʱ��ֱ����ɱ����","նɱ[lv6]������Ѫ������8%ʱ��ֱ����ɱ����","նɱ[lv6]�������������ס�[6��]���ǡ�ʱ����"},
    {"[6��]����","նɱ[lv6]������Ѫ������8%ʱ��ֱ����ɱ����","նɱ[lv7]������Ѫ������10%ʱ��ֱ����ɱ����","նɱ[lv7]�������������ס�[7��]��СС��ʱ����"},
    {"[7��]��СС","նɱ[lv7]������Ѫ������10%ʱ��ֱ����ɱ����","նɱ[lv8]������Ѫ������12%ʱ��ֱ����ɱ����","նɱ[lv8]�������������ס�[8��]�����ǡ�ʱ����"},
    {"[8��]������","նɱ[lv8]������Ѫ������12%ʱ��ֱ����ɱ����","նɱ[lv9]������Ѫ������14%ʱ��ֱ����ɱ����","նɱ[lv9]�������������ס�[9��]��С����ʱ����"},
    {"[9��]��С��","նɱ[lv9]������Ѫ������14%ʱ��ֱ����ɱ����","նɱ[lv10]������Ѫ������16%ʱ��ֱ����ɱ����","նɱ[lv10]�������������ס�[10��]�϶�ʱ����"},
    {"[10��]�϶�","նɱ[lv10]������Ѫ������16%ʱ��ֱ����ɱ����","�Ѵ�����","�Ѵ�����"},
}

local skill_cd = {
    300,290,280,270,260,250,240,230,220,200
}


function on_player_login(player)
    if not lualib:HasTimer(player,7787) then
        lualib:AddTimer(player,7787,1000,-1,"mnCoolDown")
    end
    if lualib:GetInt(player,"�ٻ���Ů") == 1 then
        lualib:SetInt(player,"�ٻ���Ů",0)
    end
    local mv_level = lualib:GetInt(player,"mvlevel")
    local str = " zhansha_tb = "..serialize(zhansha_tb).."; mv_level = "..serialize(mv_level).."; skill_cd = "..serialize(skill_cd)
    lualib:ShowFormWithContent(player, "�ű���", str)
    lualib:ShowFormWithContent(player, "�ű���", [[GameMainBar.zhansha()]])
    lualib:ShowFormWithContent(player, "�ű���", [[GameMainBar.heji()]])
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player, "�ű���", [[DownLoadWnd.zhansha()]])
    end
    lualib:ShowFormWithContent(player, "form�ļ���", "TaskWindow2")
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "dingshi")
    end

    lualib:ShowFormWithContent(player, "form�ļ���", "������ʱ���#"..lualib:GetAllTime());
    for i = 10, 11 do
        local item = lualib:Player_GetItemGuid(player, i)
        if item ~= "" then
            on_post_equip(player, item)
        end
    end
    lualib:DelayCall(player, 1, "��½�ű�:main", "");
    lualib:DelayCall(player, 1, "ħ��Ѫʯ:on_login", "");
    active_player(player, 2, 0)	--��¼ʱ����վ���ͽ�ɫ������Ϣ����Ҫɾ������Ӱ��ͳ�ƹ���
    --lualib:DelayCall(player, 2000, "client_ver", "");	--���ͻ��˰汾

    --����ս��������
    local die_flag = lualib:GetInt(player, "die_flag")
    if lualib:IsCastleWarStart("����") and die_flag == 1 then
        local own_family = lualib:GetCastleOwnFamily("����")
        local my_family = lualib:GetFamilyName(player)

        if own_family ~= "" and own_family == my_family then
            lualib:Player_MapMoveXY(player, "����", 532, 243, 5)
            lualib:SetInt(player, "die_flag", 0)
        end
    end

    --GM��½
    if lualib:Player_IsGM(player) then
        lualib:Player_SetGhost(player, true)
        lualib:SysTriggerMsg(player, "���ѽ�������״̬��")
        lualib:Player_SetInvincible(player, true)
        lualib:SysTriggerMsg(player, "���ѽ����޵�״̬��")
        lualib:AddBuff(player, "����", 60*60*24)
        lualib:SysTriggerMsg(player, "���ѽ��뼲��״̬��")
    end

    --���Ͻ�ͼ����ʾ
    --online_gift_login(player)	--�������
    guaji_xianshi(player)		--�Զ����
    --check_first_bill(player)	--�׳����ֵ���
    weixin_xianshi(player) --΢�����
    lualib:DelayCall(player, 1, "QQȺ���:show", "");
    lualib:DelayCall(player, 1, "������:show", "");
    lualib:DelayCall(player, 1, "��Ϸ����:show", "");
    ling_xianshi(player)   --�鵤��ҩ
    maijian_xianshi(player)   --��ɽׯ
    richong_xianshi(player)	--�ճ�
    shouyou_xianshi(player) --��������

    local spouse = lualib:GetStr(player, "��żGUID")
    if spouse ~= "" then
        local caller = (lualib:Gender(player) == 1) and "�ɷ�" or "����"
        lualib:SysPromptMsg(spouse, "���"..caller.."�����ˡ�")
    end
end

function client_ver(player)
    lualib:RequestClientVer(player);
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "");
end

function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player);

    if (ver < 3003) or (ver <  lualib:GetGSClientVer()) then
        lualib:SysTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysTriggerMsg(player, "���������������¼������Դ�޸������޸���ſ���������Ϸ��")
        lualib:SysTriggerMsg(player, "���������������¼������Դ�޸������޸���ſ���������Ϸ��")
        lualib:DelayCall(player, 3000, "kick_player", "");
    end
end

function kick_player(player)
    lualib:Player_Kick(player)
end

function on_pre_logout(player, type)
    lualib:DelayCall(player, 1, "master:process_master_apprentice_logout", ""); --ʦͽ�˳�����
    lualib:DelayCall(player, 1, "online_gift:online_gift_logout", ""); --��������˳�
    if lualib:GetInt(player,"�ٻ���Ů") == 1 then
        lualib:SetInt(player,"�ٻ���Ů",0)
    end
    if lualib:HasBuff(player,"��̯") then
        lualib:SetOffline(player, 1296000)
        lualib:ClearTimer(player)
        return false
    end

    if lualib:Player_IsGM(player) then
        return true
    end

    local x = lualib:X(player)
    local y = lualib:Y(player)
    local ranges = {0, 255, 270, 11, 11}
    local mapguid = lualib:Map_GetMapGuid("����")
    local players = lualib:Map_GetRegionPlayersEx(mapguid, ranges, true)
    local item_map_guid = lualib:MapGuid(player)
    local item_map_name = lualib:Name(item_map_guid)
    if item_map_name ~= "���ֽӴ���" then
        local sjx = lualib:GenRandom(1, 19)
        local sjy = lualib:GenRandom(1, 19)
        lualib:Player_MapMoveXY(player,"����", 244 + sjx , 259 + sjy , 1)
        lualib:SetOffline(player, 1296000)
        lualib:ClearTimer(player)
        if lualib:HasTimer(player, 996688) == false then
            --lualib:AddTimer(player, 996688, 2000, -1, "lixian")
        end
        return false
    end

    return true;
end

function on_player_add_exp(player, expv)
    lualib:DelayCall(player, 1, "����ű�:main", tostring(expv));
end

function on_level_up(player, level)
    active_player(player, 3, 0)	--����ʱ����վ���ͽ�ɫ������Ϣ����Ҫɾ������Ӱ��ͳ�ƹ���
    lualib:DelayCall(player, 1, "master:process_apprentice_level_up", tostring(level))  --����ͽ����������
end

--------[[��ҵ�һ�ν�����Ϸ]]
function on_first_in_game(player)
    lualib:SetInt(player,"mvlevel",1)
    lualib:SetInt(player,"��ɱ����",1)
    lualib:SetInt(player,"�ϻ���ȴ",300)
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "dingshi")
    end
    --lualib:AddIngot(player, 150000, "���Ԫ��:ԭ��", "������")

    lualib:AddBuff(player, "���ֻ���", 3600);


    local Gender = lualib:Gender(player)
    local award_item = {"����(��)", "����(Ů)"}
    if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
        lualib:SysTriggerMsg(player, "���Ͳ���ʧ�ܣ�")
    end
    --local first_skill = {"��������4��", "��ɱ����4��", "��ɱ����4��", "�����䵶4��", "Ұ����ײ4��", "�һ𽣷�4��", "����ն4��", "���ս���4��"}
    --local first_skill = {"��������4��", "��ɱ����4��", "��ɱ����4��", "Ұ����ײ4��", "�һ𽣷�4��", "����ն4��", "���ս���4��"}
    local first_skill = {"��������4��", "��ɱ����4��", "��ɱ����4��", "Ұ����ײ4��", "�һ𽣷�4��"}
    for i = 1, #first_skill do
        lualib:AddSkill(player, first_skill[i])
    end
    local item_k = {"����1", "ͷ��1", "�·�1", "����1","��ָ1","Ь��1","����1", "����1", "�����Ǵ���ʯ", "�������ʯ"}
    local item_n = {1, 1, 1, 2, 2, 1, 1, 1, 1, 1}
    local item_b = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    local item_o = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    if not lualib:Player_ItemRequest(player, item_k, item_n, item_b, item_o, "����Ʒ����һ�ν���Ϸ", "") then
        lualib:SysTriggerMsg(player, "������Ʒ����ʧ�ܣ�")
    end
    for i = 1, #item_k do
        lualib:ApplyEquipEx(player, item_k[i])
    end


    local player_name = lualib:Name(player)
    lualib:SysMsg_SendBroadcastMsg("�������ˡ�"..player_name.."�������˾�����;,�����������ý�����Ϊ���ĵ�������һ���ȷ�Ѫ��", "[ϵͳ��ʾ]")
end





function on_gp(player, gp_runtime, gp, diff_avg_tick)
    local count = lualib:GetTempInt(player, "SetNetCheck");
    if count <= 0  then
        --��һ�δ���, ����Ҽ����ϸ�ģʽ
        lualib:SetTempInt(player, "SetNetCheck", 1);
        lualib:SetNetCheckEx(player, true, true);
        lualib:DelayCall(player, 1200 * 1000, "CancelCheck", "");
    elseif count == 1 then
        --�ϸ�ģʽ��, �ڶ��δ���, ����ҷ��;���
        lualib:SetTempInt(player, "SetNetCheck", 2);
        lualib:SysWarnMsg(player, "ϵͳ��⵽��ʹ�÷Ƿ���ң�������ֹͣʹ�ã����򽫶����ȡ�ͷ���ʩ��");
    else
        --�ϸ�ģʽ��, �����δ���, ֱ��T����
        lualib:KickByName(lualib:Name(player), 2, "ʹ�����");
    end
end

function CancelCheck(player)
    lualib:SetTempInt(player, "SetNetCheck", 0)
    lualib:SetNetCheck(player, false)
end

--�ϱ���ɫ��Ϣ
function active_player(player, request_type, times)
    if times >= 3 then
        return;
    end

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

    if request_type == nil  or account_name == "" or serverid == 0 then
        return
    else
        if request_type == 3 and level < 20 then
            return
        end
        lualib:SetTempInt(player, "role_up_webDB", cur_times)
        if request_type == 2 then
            if times == 0 then
                lualib:GetURL(url, "do_nothing", player.."#".."0"..request_type, 30)
            elseif times == 1 then
                lualib:GetURL(url, "do_nothing", player.."#".. times ..request_type, 30)
            end
        elseif request_type == 3 then
            if times == 0 then
                lualib:GetURL(url, "do_nothing", player.."#".."0"..request_type, 30)
            elseif times == 1 then
                lualib:GetURL(url, "do_nothing", player.."#".. times ..request_type, 30)
            end
        end
    end
end

--�ϱ���ɫ��Ϣ�ص�
function do_nothing(param, errcode, result)
    local param_t = string.split(param, "#")
    local player = param_t[1]
    local times = tonumber(param_t[2])
    local request_type = tonumber(param_t[3])

    if tonumber(errcode) ~= 0 or result == nil then
        active_player(player, request_type, times + 1)
        return
    end

    local result_find1, result_find2 = string.find(result,"%d|%d|%d|%d|%d")

    if result_find1 ~= nil and result_find2 ~= nil then
        local s = string.sub(result, result_find1, result_find2)
        local t = string.split(s, "|")
        local s1 = {"������ڼ�", "�ܱ���Ϣδ����", "�����Ϣδ��֤", "��ȫ�ֻ�δ��֤", "��ȫ����δ��֤"}

        local tip = [[                                    #COLORCOLOR_GREENG#�� �� �� ȫ#COLOREND#
				     �𾴵���ң������˺Ŵ��ڰ�ȫ������Ϊ��������Ϸ�Ʋ���ȫ���벹������]]
        local tip2 = [[
				        ]]
        local req = false

        for i = 1, #t do
            if t[i] == "1" then
                req = true
            end
        end

        if req then
            --lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#�X�������������T�������������T�������������T�������������T�������������[#COLOREND#", 7, 11)
            --lualib:SysMsg_SendBottomColor(player, tip, 7, 11)

            local num = 0
            for i = 1, #t do
                if t[i] == "1" then
                    num = num + 1
                    if num == 1 then
                        tip2 = tip2..s1[i]
                    else
                        tip2 = tip2.."   "..s1[i]
                    end
                end
            end

            --lualib:SysMsg_SendBottomColor(player, tip2, 2, 11)
            --lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#�^�������������T�������������T�������������T�������������T�������������a#COLOREND#", 7, 11)

            --lualib:SysMsg_SendBoardMsg(player, "���䰲ȫ����",  "\n#COLORCOLOR_GREENG##UILINK<WND:�ύ��,PARAM:С��ʿ;web;player,STR:����ҽ�����վ�����˺Ű�ȫ����##COLOREND#", 10000)
        end
    end
end

function on_hack_check(player, a, b)
    if b > 10 then
        lualib:SysWarnMsg(player, "�벻Ҫʹ�����,���Ѿ���ϵͳ��¼�����������ֱ�ӷ�ţ�");
        lualib:Error(lualib:Name(player) .. "����ʹ�ùһ����");
    end
end

function on_hack_check2(player, param1)
    local PreTime = lualib:GetTempInt(player, "HackCheckTime");
    local NowTime = lualib:GetAllTime();
    if NowTime - PreTime < 600 then
        return;
    end
    lualib:SetTempInt(player, "HackCheckTime", NowTime);
    if param1 >= 1 then
        --���ʹ�����֤(���"��;��֤�빦��"),��ֱ��������
    end
end

function on_player_pre_die(self,target)
    local times = lualib:GetAllTime()
    local revive_times = lualib:GetInt(self,"revive_times")
    local timeCount = tonumber(times) - tonumber(revive_times)
    if timeCount < 10 then
        return true
    end

    local revive = true
    --if math.random(1, 100) > 80 then
    for i = 10, 11 do
        local guid = lualib:Player_GetItemGuid(self, i)
        if guid ~= "" and guid ~= nil then
            local name = lualib:KeyName(guid)
            if name == "�����ָ" then
                revive = false
                local Durabilit = lualib:Item_GetDurability("", guid)
                if Durabilit < 1000 then
                    lualib:Item_Destroy(self, guid, "", "")
                else
                    lualib:Item_SetDurability("", guid, Durabilit - 1000)
                end
            end
        end
    end



    if revive == false then
        local self_Hp = lualib:Hp(self, true)
        --lualib:SysMsg_SendWarnMsg(self, "ʱ��"..self_Hp)
        local set_hp = self_Hp
        lualib:SetHp(self, set_hp, false)

        lualib:SetInt(self, "revive_times", times)
        lualib:SysMsg_SendWarnMsg(self, "��غƵ�����Ʒ�������ָ�����㵲������һ�٣�")

        lualib:DelayCall(self,800, "on_player_pre_dietx", "");

        --lualib:SysMsg_SendWarnMsg(self, "��Ϊ�㣡")
        return false
    else
        return true
    end
    --else return	true
    --end
end
function on_player_pre_dietx(self)

    lualib:SendRoleHPNtf(self)

end
local is_skill_t = {
    [1010] = 1,
    [1011] = 1,
    [1012] = 1,
    [1013] = 1,
    [1020] = 1,
    [1021] = 1,
    [1022] = 1,
    [1023] = 1,
    [1030] = 1,
    [1031] = 1,
    [1032] = 1,
    [1033] = 1,
    [1040] = 1,
    [1041] = 1,
    [1042] = 1,
    [1043] = 1,
    [1050] = 1,
    [1051] = 1,
    [1052] = 1,
    [1053] = 1,
    [1060] = 1,
    [1061] = 1,
    [1062] = 1,
    [1063] = 1,
    [25] = 1,
}

local GEM_KEYNAME = {
    ["����1"] 	={	1.00 	,   180},
    ["����2"]	={	1.00 	,   170},
    ["����3"]	={	1.00 	,   160},
    ["����4"]	={	1.00 	,   150},
    ["����5"]	={	1.00	,   140},
    ["����6"]	={	1.00	,   130},
    ["����7"]	={	1.00	,   120},
    ["����8"]	={	1.00	,   110},
    ["����9"]	={	1.00	,   100},
    ["����10"]	={	1.00	,   80},
}

function on_post_equip(player, item, id, KeyName)
    if GEM_KEYNAME[KeyName] then
        local second = GEM_KEYNAME[KeyName][2];
        lualib:AddBuff(player, "����ʯ����", second);
        lualib:ShowFormWithContent(player, "�ű���", "PlayerHeaderInfo:ReliveCD("..second..")");
    end

    local itemName = lualib:KeyName(item)
    if itemName == "��Խ�ָ" then
        lualib:AddTrigger(player, lua_trigger_damage_process, "damage_process")
    elseif itemName == "�����ָ" then
        lualib:AddBuff(player, "�����ָ", 20000000)
    end
    return true
end

function on_pre_player_die(player, killer)


    local gem0 = lualib:Player_GetItemGuid(player, 10)
    local gem_KeyName0 = lualib:KeyName(gem0);
    local gem1 = lualib:Player_GetItemGuid(player, 11)
    local gem_KeyName1 = lualib:KeyName(gem1);
    local gem = ""
    local gem_KeyName = ""
    if not GEM_KEYNAME[gem_KeyName0] then
        if not GEM_KEYNAME[gem_KeyName1] then
            return true
        else
            gem = gem1
            gem_KeyName = gem_KeyName1
        end
    else
        gem = gem0
        gem_KeyName = gem_KeyName0
    end


    if lualib:HasBuff(player, "����ʯ����") then
        return true
    end
    if lualib:Player_IsPlayer(killer) then
        local jilv = 0
        local num = lualib:GetEquipSuitCount(killer, "", 0, 114);
        if num == 2 then
            jilv = 2
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 115);
        if num == 2 then
            jilv = 4
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 116);
        if num == 2 then
            jilv = 6
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 117);
        if num == 2 then
            jilv = 8
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 118);
        if num == 2 then
            jilv = 10
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 119);
        if num == 2 then
            jilv = 20
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 120);
        if num == 2 then
            jilv = 30
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 121);
        if num == 2 then
            jilv = 40
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 122);
        if num == 2 then
            jilv = 60
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 123);
        if num == 2 then
            jilv = 80
        end
        local num = lualib:GetEquipSuitCount(killer, "", 0, 124);
        if num == 2 then
            jilv = 100
        end
        if lualib:GenRandom(1, 100) <= jilv then
            lualib:SysMsg_SendPromptMsg(killer, "���Ƴ��˶Է��ĸ�����������");
            lualib:SysMsg_SendPromptMsg(player, "��ĸ����������Է�������·��������Ƴ��ˣ���");
            return true
        end
    end
    local max_hp = lualib:Hp(player, true);
    local hp = max_hp * GEM_KEYNAME[gem_KeyName][1];
    lualib:SetHp(player, hp, false)     --���õ�ǰHP
    local second = GEM_KEYNAME[gem_KeyName][2];
    lualib:AddBuff(player, "����ʯ����", second);
    lualib:SysCenterMsg(0, ""..lualib:Name(gem).."����֮��,ԭ�ظ����", player);
    lualib:SysMsg_SendPromptMsg(player, "#COLORCOLOR_GREENG#����#COLORCOLOR_YELLOW#"..lualib:Name(gem).."#COLORCOLOR_GREENG#����֮��,#COLORCOLOR_MAGENTA#ԭ�ظ����");
    lualib:ShowFormWithContent(player, "�ű���", "PlayerHeaderInfo:ReliveCD("..second..")");
    return false
end














function damage_process(self, target, skill_id)
    local ringGuid1, ringGuid2 = lualib:Player_GetItemGuid(self, 10), lualib:Player_GetItemGuid(self, 11)
    local ringName1, ringName2 = "", ""
    if ringGuid1 ~= "" then
        ringName1 = lualib:KeyName(ringGuid1)
    end

    if ringGuid2 ~= "" then
        ringName2 = lualib:KeyName(ringGuid2)
    end
    --�жϽ�ָλ���Ƿ�����ԣ�����������̣�û����ɾ��������
    if ringName1 == "��Խ�ָ" or ringName2 == "��Խ�ָ" then
        --�������buff���ʼ���
        if is_skill_t[skill_id] == 1 then
            if math.random(1, 100) > 70 then
                lualib:AddBuff(target, "�������3��", 0)
            end
        end
    else
        lualib:RemoveTrigger(self, lua_trigger_damage_process, "")
    end

    return true
end

function on_trigger_billin(player, yb)
    local name = lualib:Name(player)
    lualib:SysWarnMsg(player, "���ֵ��"..yb.."Ԫ��")
    lualib:SysMsg_SendBroadcastMsg("��ϲ"..name.."���߳�ֵ���" .. yb ..  "Ԫ���������Ҳ��Ҫ������Ļ���½����̽��г�ֵ","[��ֵ��ʾ]")
end



local shuztys = {
    ["���10"] = 500000008,
    ["����10"] = 500000008,
    ["������15"] = 500000008,
    ["������15"] = 500000008,
    ["������15"] = 500000008,
    ["̫ƽ��15"] = 500000008,
    ["����8"] = 500000008,
    ["���10"] = 500000008,
    ["����10"] = 500000008,
    ["����10"] = 500000008,
    ["�ɽ���1"] = 500000008,
    ["�ɽ���2"] = 500000008,
    ["�ɽ���3"] = 500000008,
    ["�ɽ���4"] = 500000008,
    ["�ɽ���5"] = 500000008,
    ["�ɽ���6"] = 500000008,
    ["�ɽ���7"] = 500000008,
    ["�ɽ���8"] = 500000008,
    ["�ɽ���9"] = 500000008,
    ["�ɽ���10"] = 500000008,
    ["�ɽ���11"] = 500000008,
    ["�ɽ���12"] = 500000008,
    ["ʮ��һɱ"] = 500000007,
    ["ħ����"] = 500000008,


    ["1000��ʯ"] = 500000009,
    ["2000��ʯ"] = 500000009,
    ["5000��ʯ"] = 500000009,
    ["10000��ʯ"] = 500000009,
    ["20000��ʯ"] = 500000009,
    ["50000��ʯ"] = 500000010,
    ["100000��ʯ"] = 500000010,
    ["200000��ʯ"] = 500000010,
    ["500000��ʯ"] = 500000010,
    ["880000��ʯ"] = 500000010,
    ["1080000��ʯ"] = 500000010,
    ["1180000��ʯ"] = 500000010,
    ["1280000��ʯ"] = 500000010,
    ["1380000��ʯ"] = 500000010,
    ["�������ž���"] = 500000006,
    ["���5"] = 500000009,
    ["���6"] = 500000009,
    ["���7"] = 500000009,
    ["����5"] = 500000009,
    ["����6"] = 500000009,
    ["����7"] = 500000009,
    ["������6"] = 500000009,
    ["������6"] = 500000009,
    ["������6"] = 500000009,
    ["̫ƽ��6"] = 500000009,
    ["������7"] = 500000009,
    ["������7"] = 500000009,
    ["������7"] = 500000009,
    ["̫ƽ��7"] = 500000009,
    ["������8"] = 500000009,
    ["������8"] = 500000009,
    ["������8"] = 500000009,
    ["̫ƽ��8"] = 500000009,
    ["������9"] = 500000009,
    ["������9"] = 500000009,
    ["������9"] = 500000009,
    ["̫ƽ��9"] = 500000009,
    ["������10"] = 500000009,
    ["������10"] = 500000009,
    ["������10"] = 500000009,
    ["̫ƽ��10"] = 500000009,
    ["���Ͼ�"] = 500000010,
    ["�Ͻ���"] = 500000010,
    ["�����"] = 500000010,
    ["�¾��쾵"] = 500000010,
    ["����1"] = 500000009,
    ["����2"] = 500000009,
    ["����3"] = 500000009,
    ["����4"] = 500000009,
    ["���1"] = 500000009,
    ["���2"] = 500000009,
    ["���3"] = 500000009,
    ["���4"] = 500000009,
    ["���5"] = 500000009,
    ["����1"] = 500000009,
    ["����2"] = 500000009,
    ["����3"] = 500000009,
    ["����4"] = 500000009,
    ["����5"] = 500000009,
    ["����1"] = 500000009,
    ["����2"] = 500000009,
    ["����3"] = 500000009,
    ["����4"] = 500000009,
    ["����5"] = 500000009,
    ["�ɽ���1"] = 500000009,
    ["�ɽ���2"] = 500000009,
    ["�ɽ���3"] = 500000009,
    ["�ɽ���4"] = 500000009,
    ["�ɽ���5"] = 500000009,
    ["�ɽ���6"] = 500000009,
    ["�ɽ���7"] = 500000009,
    ["�ɽ���8"] = 500000009,
    ["�ɽ���9"] = 500000009,
    ["�ɽ���10"] = 500000009,
    ["�ɽ���11"] = 500000009,
    ["�ɽ���12"] = 500000009,
    ["�ɽ���1"] = 500000009,
    ["�ɽ���2"] = 500000009,
    ["�ɽ���3"] = 500000009,
    ["�ɽ���4"] = 500000009,
    ["�ɽ���5"] = 500000009,
    ["�ɽ���6"] = 500000009,
    ["�ɽ���7"] = 500000009,
    ["�ɽ���8"] = 500000009,
    ["�ɽ���9"] = 500000009,
    ["�ɽ���10"] = 500000009,
    ["�ɽ���11"] = 500000009,
    ["�ɽ���12"] = 500000009,


    ["�ɽ���1"] = 500000010,
    ["�ɽ���2"] = 500000010,
    ["�ɽ���3"] = 500000010,
    ["�ɽ���4"] = 500000010,
    ["�ɽ���5"] = 500000010,
    ["�ɽ���6"] = 500000010,
    ["�ɽ���7"] = 500000010,
    ["�ɽ���8"] = 500000010,
    ["�ɽ���9"] = 500000010,
    ["�ɽ���10"] = 500000010,
    ["�ɽ���11"] = 500000010,
    ["�ɽ���12"] = 500000010,
    ["����5"] = 500000010,
    ["����6"] = 500000010,
    ["����7"] = 500000010,
    ["���6"] = 500000010,
    ["���7"] = 500000010,
    ["���8"] = 500000010,
    ["���9"] = 500000010,
    ["����6"] = 500000010,
    ["����7"] = 500000010,
    ["����8"] = 500000010,
    ["����9"] = 500000010,
    ["����6"] = 500000010,
    ["����7"] = 500000010,
    ["����8"] = 500000010,
    ["����9"] = 500000010,
    ["������Ƥ"] = 500000010,
    ["������ȸ"] = 500000010,
    ["�ĵ�������"] = 500000010,
    ["½�س���ͼ"] = 500000010,
    ["ѩ�к�����"] = 500000010,
    ["ɽ�����"] = 500000010,
    ["���8"] = 500000010,
    ["���9"] = 500000010,
    ["����8"] = 500000010,
    ["����9"] = 500000010,
    ["������11"] = 500000010,
    ["������11"] = 500000010,
    ["������11"] = 500000010,
    ["̫ƽ��11"] = 500000010,
    ["������12"] = 500000010,
    ["������12"] = 500000010,
    ["������12"] = 500000010,
    ["̫ƽ��12"] = 500000010,
    ["������13"] = 500000010,
    ["������13"] = 500000010,
    ["������13"] = 500000010,
    ["̫ƽ��13"] = 500000010,
    ["������14"] = 500000010,
    ["������14"] = 500000010,
    ["������14"] = 500000010,
    ["̫ƽ��14"] = 500000010,
}

function on_item_appear(map, item, item_id, item_key, x, y)
    local lever = lualib:Item_GetLevel(item)
    if lever >= 16 and lever <= 20 then
        lualib:RunClientScript(map, "ItemEffect", "texiao", "500000006#"..x.."#"..y.."#0#99999999");
    end
    if lever >= 21 and lever <= 24 then
        lualib:RunClientScript(map, "ItemEffect", "texiao", "500000007#"..x.."#"..y.."#0#99999999");
    end
    if lever >= 25 and lever <= 28 then
        lualib:RunClientScript(map, "ItemEffect", "texiao", "500000008#"..x.."#"..y.."#0#99999999");
    end
    if shuztys[item_key] ~= nil then
        lualib:RunClientScript(map, "ItemEffect", "texiao", shuztys[item_key].."#"..x.."#"..y.."#0#99999999");
    end

end

function on_item_disappear(map, item, item_id, item_key, x, y)
    local lever = lualib:Item_GetLevel(item)
    if lever >= 16 and lever <= 20 then
        lualib:RunClientScript(map, "ItemEffect", "del_texiao", "500000006#"..x.."#"..y);
    end
    if lever >= 21 and lever <= 24 then
        lualib:RunClientScript(map, "ItemEffect", "del_texiao", "500000007#"..x.."#"..y);
    end
    if lever >= 25 and lever <= 28 then
        lualib:RunClientScript(map, "ItemEffect", "del_texiao", "500000008#"..x.."#"..y);
    end
    if shuztys[item_key] ~= nil then
        lualib:RunClientScript(map, "ItemEffect", "del_texiao", shuztys[item_key].."#"..x.."#"..y);
    end

end
local skillhj = {
    ["ŭ������1"]=5,
    ["��ľ�괺1"]=10,
    ["��ʯ����1"]=15,
    ["�̺�����1"]=20,
    ["�򽣳���1"]=25,
    ["ŭ������2"]=30,
    ["��ľ�괺2"]=35,
    ["��ʯ����2"]=40,
    ["�̺�����2"]=45,
    ["�򽣳���2"]=50,

}
function on_pre_harm(role,attacker,hp,defense,skillkeyname,isBurst)
    local roletype = lualib:GUIDType(role)
    local attackertype = lualib:GUIDType(attacker)
    --lualib:SysMsg_SendBroadcastMsg(tostring(skillkeyname), "sk")

    if skillhj[skillkeyname] ~= nil and attackertype==0 then
        local phyatk_low = lualib:PhyAtk(attacker, false)    --ȡ����
        local phyatk_hei = lualib:PhyAtk(attacker, true)    --ȡ����
        local PhyDef_low = lualib:PhyDef(role, false)    --ȡ����
        local PhyDef_hei = lualib:PhyDef(role, true)    --ȡ����
        local phyatk = math.floor((phyatk_low+phyatk_hei)/3)
        local phyDef = math.floor((PhyDef_low+PhyDef_hei)/2)
        if phyDef >= phyatk then
            hp = -1000*skillhj[skillkeyname]

        else
            hp = 0-(phyatk-phyDef)*skillhj[skillkeyname]
        end
        lualib:ShowRoleHPRefEx("",role,hp,4)
    end
    if roletype == 2 and attackertype == 0 then
        local Girlslevel = lualib:GetInt(attacker,"��ɱ����")
        if Girlslevel == 0 then
            hp=hp
        else
            local miaosha = lualib:GetInt(attacker,"��ɱ����")
            local mshp = miaosha * lualib:Hp(role,true)
            mshp = math.floor(mshp/100)
            --lualib:SysMsg_SendBroadcastMsg(tostring(mshp), "mshp")
            --lualib:SysMsg_SendBroadcastMsg(tostring(lualib:Hp(role,false)), "dangqian")
            if lualib:Hp(role,false) <= mshp then
                hp = 0 - lualib:Hp(role,false)
                --lualib:SysMsg_SendBroadcastMsg(tostring(hp), "hp")
                --return hp
            end
        end
    end
    return hp
end

function mnCoolDown(player,id)
    local num = lualib:GetInt(player,"�ϻ�ʱ��")-1
    local nums = (lualib:GetInt(player,"�ϻ���ȴ") - num) / lualib:GetInt(player,"�ϻ���ȴ")
    if nums >= 1 then
        lualib:ShowFormWithContent(player, "�ű���", [[GameMainBar.coolDown(1)]])
        lualib:SetInt(player,"�ϻ�ʱ��",0)
    else
        lualib:ShowFormWithContent(player, "�ű���", [[GameMainBar.coolDown(]]..nums..[[)]])
        lualib:SetInt(player,"�ϻ�ʱ��",num)
    end
end

function on_spell(player, skill_id, skill_name,x,y,target,skillkeyname)
    if lualib:GetInt(player,"�ϻ�ʱ��") <= 0 then
        --lualib:SysMsg_SendBroadcastMsg(tostring("�ͷż���"), "ţ")
        lualib:SetInt(player,"�ϻ�ʱ��",lualib:GetInt(player,"�ϻ���ȴ"))
    end
end