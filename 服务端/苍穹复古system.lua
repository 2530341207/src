local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("include/����ս�淨")
require("system/����#ʰȡ�ص�")
--require("system/��ֵ���")
require("system/horse")
require("system/marry")
require("system/master")
require("system/����ϵͳ")
--require("system/����ϵͳ")
require("system/װ����BUFF")
--require("system/װ���Լ��ܼӳ�")
require("system/�����л�����")
--require("npc/ɳ�Ϳ���������")
require("system/Ӣ�۰�")
require("form/VIP��")
require("form/���׳������")
require("form/��ֵ��")
require("form/΢�����")
require("form/�¼����������")
require("item/������Ϣ")
require("form/�����ʦ")
require("form/���߽���")
require("form/�ؽ�")
require("form/�����а�")
require("form/Amark��Ϸ����")
require("form/Amark��Ծʹ��")
require("form/Amark��սBoss")
require("system/Amark�����ؼ�Data")
require("form/Amark�һ���ʹ")
require("system/Amark֣����Ҫ��ˢ��")
require("system/Amark���Խ���")
require("form/Amarkװ����������")
require("system/Amark�ͻ��˵���")
require("form/Amark��ֵ���")

function on_system_start()
    lualib:AddTrigger("0", lua_trigger_item_appear, "on_item_appear");					--��Ʒ�����ڵ�ͼ�ϻص�
    lualib:AddTrigger("0", lua_trigger_item_disappear, "on_item_disappear");			--��Ʒ�ڵ�ͼ����ʧ�ص�
    if lualib:GetDBNum("map_lock") == 0 then
        lualib:AddTimer("0", 10218, 1000, -1, "send_system_msg")
    end
    lualib:AddTrigger("0",  lua_trigger_post_drop_one , "on_post_drop_one")
    lualib:AddTrigger("0",  lua_trigger_pre_enter_jump, "on_pre_jump")
    lualib:DelayCall("0", 1, "��ʱˢ��ϵͳ:check", "");
    lualib:AddTrigger("", lua_trigger_login, "on_player_login");
    lualib:AddTrigger("", lua_trigger_add_exp, "on_player_add_exp");		   --��������ʱ
    lualib:AddTrigger("", lua_trigger_logout, "on_player_logout");
    lualib:DelayCall("", 1, "OnFirstCastleWar", "");		                   --��һ�ι���ս
    lualib:AddTrigger("0",  lua_trigger_billin, "on_trigger_billin")                   --��ֵ�ص�
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")			   --��������
    lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")				   --����Ҵ���
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start")       --���ǿ�ʼ
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end")           --���ǽ���
    lualib:AddTrigger("0",  lua_trigger_player_relive, "on_player_relive")             --����ʱ�ص�
    lualib:AddTrigger("0",  lua_trigger_post_die, "on_post_die")                       --����ʱ�ص�
    lualib:DelayCall("0", 1, "���˵�С��:check", "")
    lualib:DelayCall("0", 1, "��Ĵ�����:check", "")
    lualib:AddTrigger("0",  lua_trigger_attack_ex, "on_attack_ex")  --�ܹ�������
    lualib:AddTrigger("0",  lua_trigger_post_equip, "chuandaiqian")
    lualib:AddTrigger("0",  lua_trigger_post_un_equip, "tuozhuangbei")
    lualib:AddTrigger("0", lua_trigger_hack_check, "on_hack_check");
    lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2");
    lualib:AddTrigger("0", lua_trigger_pre_process_pk, "on_pre_process_pk");
    lualib:AddTrigger("0", lua_trigger_pre_stall_buy, "on_pre_stall_buy")		--��̯��Ʒ���򴥷�
    lualib:AddTrigger("",  lua_trigger_pre_die, "pre_player_die") --����ǰ
    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die")	   --���������ص�
    lualib:AddTrigger("0",  363, "on_ride_request")                                    --������
    lualib:AddTrigger("0",  364, "on_unride_request")                                  --������
    lualib:AddTrigger("0", lua_trigger_post_equip, "on_post_equip")
    lualib:AddTrigger("0", 304, "on_post_un_equip") 	                           --��װ������
    lualib:AddTrigger("0", lua_trigger_role_pre_harm, "on_pre_harm")
    lualib:AddTrigger("0", lua_trigger_family_ntf, "on_family_ntf")
    lualib:AddTrigger("0", lua_trigger_kill, "on_trigger_kill")
    lualib:AddTrigger("0",  lua_trigger_post_drop_one, "post_drop_one")
    lualib:AddTrigger("0",  lua_trigger_pre_logout, "on_pre_logout")  --���߹һ�������
    lualib:AddTrigger("0",  lua_trigger_pre_stall, "on_pre_stall")--��̯����
    lualib:AddTrigger("0",  lua_trigger_catch, "on_catch")--��������
    lualib:AddTrigger("0", lua_trigger_item_pickup, "on_item_pickup")		         	--ʰȡ����֮��ص�
    lualib:AddTrigger("0", lua_trigger_pre_item_pickup, "on_pre_item_pickup")			--ʰȡ����֮ǰ�ص�
    lualib:AddTrigger("0",  lua_trigger_pre_spell, "on_pre_spell")--�ͷż���ǰ����
    lualib:AddTrigger("0", lua_trigger_spell, "on_spell")--�ͷż��ܺ󴥷�
    --����ֵ=333 ������=��ĳ��������Ʒ֮ǰ�ص�.
    lualib:AddTrigger("0",333,"on_pre_drop_one")
    on_setfamily_people()
    local StartServerTime = lualib:GetConstVar("StartServerTime")
    local StartServerTime_int = lualib:Str2Time(StartServerTime)
    local times = lualib:GetAllTime()
    AmarkBaoJsonSet()
    AmarkBossTiaoZhan()
    MonsterInit()
    lualib:AddTimerEx("0",2020118,1000,-1,"listTime","")
end

function listTime()
    local contrastTime = lualib:Str2Time("2020-1-1 22:00:00")
    local nowTime = lualib:GetAllTime()
    if (nowTime - contrastTime) % (24*60*60) ==  0 then
        lualib:DelayCall("0",1,"������:updateList","")
    end
end

function on_item_pickup(player, item, itemid, itemkeyname)
    AmarkEquipYd(player, item)
end

function on_pre_item_pickup(player, Item, ItemId, ItemKeyName)
    if lualib:GetInt(Item, "ʰȡ��ȴ") > 0 then
        if lualib:GetAllTime() < lualib:GetInt(Item, "ʰȡ��ȴ") then
            lualib:SysMsg_SendPromptMsg(player, "����Ʒ��ʱ�޷�ʰȡ��["..((lualib:GetInt(Item, "ʰȡ��ȴ") - lualib:GetAllTime()) * -1).."]���ָ�ʰȡ��")
            return false
        end
    end
    return true
end




local dl_item_table = {["ʥħ����"] = 1,["ʥħ֮��"] = 1,["ʥħ�ػ�"] = 1,["ʥħ��ʯ"] = 1,["ʥħ����"] = 1,["ʥħѫ��"] = 1,["ʥħѥ��"] = 1,["ʥħ��ָ"] = 1,["ʥħ����"] = 1,["ʥħͷ��"] = 1,["ʥħ����(Ů)"] = 1,["ʥħ����(��)"] = 1,["����"] = 1,["ս��ͷ��"] = 1,["ս��ѫ��"] = 1,["ս���ػ�"] = 1,["ս��֮��"] = 1,["ս������"] = 1,["ս������"] = 1,["ս��ս��(Ů)"] = 1,["ս��ս��(��)"] = 1,["ս������"] = 1,["ս��ʥѥ"] = 1,["ս���ָ"] = 1,["ս��ʯ"] = 1,["����"] = 1,["����ػ�"] = 1,["���֮��"] = 1,["���ѫ��"] = 1,["���ͷ��"] = 1,["������(Ů)"] = 1,["�������"] = 1,["�������"] = 1,["�������"] = 1,["����ָ"] = 1,["��걦ʯ"] = 1,["������(��)"] = 1,["����ѥ"] = 1,["����"] = 1,["����ѫ��"] = 1,["��������"] = 1,["����֮��"] = 1,["�����ػ�"] = 1,["����ͷ��"] = 1,["��������"] = 1,["����ѥ��"] = 1,["����ħ��(Ů)"] = 1,["����ħ��(��)"] = 1,["���滤��"] = 1,["���汦ʯ"] = 1,["�����ָ"] = 1,["�Ȼ귨��"] = 1,["��âѫ��"] = 1,["��âͷ��"] = 1,["��â�ػ�"] = 1,["��â��ʯ"] = 1,["��â֮��"] = 1,["��â����(Ů)"] = 1,["��â����(��)"] = 1,["��â����"] = 1,["��âѥ��"] = 1,["��â��ָ"] = 1,["��â����"] = 1,["��â����"] = 1,["��ң��"] = 1,["����ͷ��"] = 1,["����֮��"] = 1,["�����ػ�"] = 1,["������ʯ"] = 1,["��������"] = 1,["����ѫ��"] = 1,["����սѥ"] = 1,["����ս��(Ů)"] = 1,["����ս��(��)"] = 1,["����ս��"] = 1,["��������"] = 1,["��������"] = 1,["ŭն"] = 1,["ǿ��ս��ս��(Ů)"] = 1,["ǿ��ս��ս��(��)"] = 1,["ǿ��ս��ѥ��"] = 1,["ǿ��ս������"] = 1,["ǿ��ս����"] = 1,["ǿ��ս���ָ"] = 1,["ǿ��ս��ѫ��"] = 1,["ǿ��ս������"] = 1,["ǿ��ս��ͷ��"] = 1,["ǿ��ս��֮��"] = 1,["ǿ��ս���ػ�"] = 1,["ǿ��ս��ʯ"] = 1,["ǿ������"] = 1,["ǿ��ʥħ֮��"] = 1,["ǿ��ʥħ����(Ů)"] = 1,["ǿ��ʥħ����(��)"] = 1,["ǿ��ʥħѥ��"] = 1,["ǿ��ʥħ����"] = 1,["ǿ��ʥħ����"] = 1,["ǿ��ʥħ��ָ"] = 1,["ǿ��ʥħѫ��"] = 1,["ǿ��ʥħ����"] = 1,["ǿ��ʥħͷ��"] = 1,["ǿ��ʥħ�ػ�"] = 1,["ǿ��ʥħ��ʯ"] = 1,["ǿ������"] = 1,["ǿ��������(Ů)"] = 1,["ǿ��������(��)"] = 1,["ǿ�����ѥ��"] = 1,["ǿ���������"] = 1,["ǿ����껤��"] = 1,["ǿ������ָ"] = 1,["ǿ�����ѫ��"] = 1,["ǿ���������"] = 1,["ǿ�����ͷ��"] = 1,["ǿ�����֮��"] = 1,["ǿ������ػ�"] = 1,["ǿ����걦ʯ"] = 1,["ǿ������"] = 1,["ս���񽣡ﾫ[��ӡ]"] = 1,["ս��ս�סﾫ[��ӡ]"] = 1,["ս��ѥ�ӡﾫ[��ӡ]"] = 1,["ս�������ﾫ[��ӡ]"] = 1,["ս������ﾫ[��ӡ]"] = 1,["ս����ָ�ﾫ[��ӡ]"] = 1,["ս��ѫ�¡ﾫ[��ӡ]"] = 1,["ս�������ﾫ[��ӡ]"] = 1,["ս��ͷ���ﾫ[��ӡ]"] = 1,["ս��֮��ﾫ[��ӡ]"] = 1,["ս���ػ��ﾫ[��ӡ]"] = 1,["ս����ʯ�ﾫ[��ӡ]"] = 1,["ս��ս�¡ﾫ[��ӡ]"] = 1,["����ħ�¡ﾫ[��ӡ]"] = 1,["����ħ�¡ﾫ[��ӡ]"] = 1,["����ħ���ﾫ[��ӡ]"] = 1,["������ʯ�ﾫ[��ӡ]"] = 1,["�����ػ��ﾫ[��ӡ]"] = 1,["����֮��ﾫ[��ӡ]"] = 1,["����ħ���ﾫ[��ӡ]"] = 1,["����ѫ�¡ﾫ[��ӡ]"] = 1,["����ħ��ﾫ[��ӡ]"] = 1,["��������ﾫ[��ӡ]"] = 1,["����ħ���ﾫ[��ӡ]"] = 1,["����ѥ�ӡﾫ[��ӡ]"] = 1,["����ħ�סﾫ[��ӡ]"] = 1,["����ħ�ȡﾫ[��ӡ]"] = 1,["�������¡ﾫ[��ӡ]"] = 1,["�����ػ��ﾫ[��ӡ]"] = 1,["������ʯ�ﾫ[��ӡ]"] = 1,["����֮��ﾫ[��ӡ]"] = 1,["���������ﾫ[��ӡ]"] = 1,["���������ﾫ[��ӡ]"] = 1,["����ѫ�¡ﾫ[��ӡ]"] = 1,["��������ﾫ[��ӡ]"] = 1,["��������ﾫ[��ӡ]"] = 1,["���������ﾫ[��ӡ]"] = 1,["������ѥ�ﾫ[��ӡ]"] = 1,["�������סﾫ[��ӡ]"] = 1,["���������ﾫ[��ӡ]"] = 1,["ս��ս�¡ﾫ"] = 1,["ս����ʯ�ﾫ"] = 1,["ս���ػ��ﾫ"] = 1,["ս��֮��ﾫ"] = 1,["999��õ�廨"] = 1,["ս��ͷ���ﾫ"] = 1,["ս�������ﾫ"] = 1,["ս��ѫ�¡ﾫ"] = 1,["ս����ָ�ﾫ"] = 1,["ս������ﾫ"] = 1,["ս�������ﾫ"] = 1,["ս��ѥ�ӡﾫ"] = 1,["ս��ս�סﾫ"] = 1,["ս���񽣡ﾫ"] = 1,["����ħ�¡ﾫ"] = 1,["����ħ���ﾫ"] = 1,["������ʯ�ﾫ"] = 1,["�����ػ��ﾫ"] = 1,["����֮��ﾫ"] = 1,["����ħ���ﾫ"] = 1,["����ѫ�¡ﾫ"] = 1,["����ħ��ﾫ"] = 1,["��������ﾫ"] = 1,["����ħ���ﾫ"] = 1,["�������¡ﾫ"] = 1,["�����ػ��ﾫ"] = 1,["������ʯ�ﾫ"] = 1,["����֮��ﾫ"] = 1,["���������ﾫ"] = 1,["���������ﾫ"] = 1,["����ѫ�¡ﾫ"] = 1,["��������ﾫ"] = 1,["��������ﾫ"] = 1,["����ħ���ﾫ"] = 1,["���������ﾫ"] = 1,["����ѥ�ӡﾫ"] = 1,["������ѥ�ﾫ"] = 1,["����ħ�סﾫ"] = 1,["�������סﾫ"] = 1,["����ħ�ȡﾫ"] = 1,["���������ﾫ"] = 1,["ս������"] = 1,["����ħ��"] = 1,["��������"] = 1,["ս����ʯ"] = 1,["����ͷ��"] = 1,["�����ػ�"] = 1,["ս���ػ�"] = 1,["�����ػ�"] = 1,["����֮��"] = 1,["ս��ͷ��"] = 1,["����֮��"] = 1,["��������"] = 1,["ս������"] = 1,["��������"] = 1,["��������"] = 1,["ս��ѫ��"] = 1,["����ѫ��"] = 1,["��������"] = 1,["ս����ָ"] = 1,["������ָ"] = 1,["��������"] = 1,["ս������"] = 1,["��������"] = 1,["��������"] = 1,["ս������"] = 1,["��������"] = 1,["��������"] = 1,["ս��ѥ��"] = 1,["����ѥ��"] = 1,["������ѥ"] = 1,["ս�����"] = 1,["����ħ��"] = 1,["��������"] = 1,["ս����"] = 1,["����ħ��"] = 1,["������"] = 1,["���ɷ��"] = 1,["���ɷ��Lv3"] = 1,["���ɷ��Lv2"] = 1,["���ɷ��Lv1"] = 1,["���ɷ��Lv4"] = 1,["���ɷ��Lv5"] = 1,["���ɷ��Lv6"] = 1,["���ɷ��Lv7"] = 1,["���ɷ��Lv8"] = 1,["4�������"] = 1,["4��ħ����"] = 1,["ͨ��֮��"] = 1,["4���һ𽣷�"] = 1,["4�������"] = 1,["��������"] = 1,["����ն"] = 1,	["��Ѫ��"] = 1,["����ʯ"] = 1,["����ʯ(����)"] = 1,["����ʯ(ʷʫ)"] = 1,["����ʯ"] = 1,["����ʯ(����)"] = 1,["����ʯ(ʷʫ)"] = 1,["��ȸʯ(����)"] = 1,["��ȸʯ(ʷʫ)"] = 1,["��ȸʯ"] = 1,["�׻�ʯ(����)"] = 1,["�׻�ʯ(ʷʫ)"] = 1,["�׻�ʯ"] = 1,["����ʯ(����)"] = 1,["����ʯ(ʷʫ)"] = 1,["����ʯ"] = 1,["�Ա�"] = 1,["�ڱ�"] = 1,["��ɫʨ��"] = 1,["��ɫʨ��"] = 1,["����"] = 1,["��β���"] = 1,["��β����"] = 1,["����"] = 1,["����"] = 1,["�������ߡ�������"] = 1,["��������"] = 1,["ʥ������"] = 1,["����������"] = 1,["�����ն��[����]"] = 1,}



function post_drop_one(map, player, item, item_id)

    if lualib:Player_IsPlayer(player) and dl_item_table[lualib:Name(item)] == 1 then
        lualib:SysMsg_SendBroadcastColor("��Ʒ��"..lualib:Name(item).."������ҡ�"..lualib:Name(player).."�����ϵ����ڵ�ͼ��"..lualib:Name(map).."�����꣨"..lualib:X(player).."��"..lualib:Y(player).."������", "", 7, 3)
    end
    return true

end



local skills = {
    ["����ʹ�߅d�ռ�"] = "�ٻ�����4��",
}

local skill_item_g = {
    ["����ʹ��LV1"] = {
        ["�һ�"] = 1,
        ["������"] = 1,
        ["��ɱ��"] = 1,
        ["�׵���"] = 1,
        ["������"] = 1,
        ["����"] = 1,
        ["ħ����"] = 1,
        ["ʩ����"]	= 1,
        ["�����"]	= 1,
        ["��ʥս"]	= 1,
    },
    ["����ʹ��LV2"] = {
        ["�һ�"] = 2,
        ["������"] = 2,
        ["��ɱ��"] = 2,
        ["�׵���"] = 2,
        ["������"] = 2,
        ["����"] = 2,
        ["ħ����"] = 2,
        ["ʩ����"]	= 2,
        ["�����"]	= 2,
        ["��ʥս"]	= 2,
    },
    ["����ʹ��LV3"] = {
        ["�һ�"] = 3,
        ["������"] = 3,
        ["��ɱ��"] = 3,
        ["�׵���"] = 3,
        ["������"] = 3,
        ["����"] = 3,
        ["ħ����"] = 3,
        ["ʩ����"]	= 3,
        ["�����"]	= 3,
        ["��ʥս"]	= 3,
    },
    ["����ʹ��LV4"] = {
        ["�һ�"] = 4,
        ["������"] = 4,
        ["��ɱ��"] = 4,
        ["�׵���"] = 4,
        ["������"] = 4,
        ["����"] = 4,
        ["ħ����"] = 4,
        ["ʩ����"]	= 4,
        ["�����"]	= 4,
        ["��ʥս"]	= 4,
    },
    ["����ʹ��LV5"] = {
        ["�һ�"] = 5,
        ["������"] = 5,
        ["��ɱ��"] = 5,
        ["�׵���"] = 5,
        ["������"] = 5,
        ["����"] = 5,
        ["ħ����"] = 5,
        ["ʩ����"]	= 5,
        ["�����"]	= 5,
        ["��ʥս"]	= 5,
    },
    ["����ʹ��LV6"] = {
        ["�һ�"] = 6,
        ["������"] = 6,
        ["��ɱ��"] = 6,
        ["�׵���"] = 6,
        ["������"] = 6,
        ["����"] = 6,
        ["ħ����"] = 6,
        ["ʩ����"]	= 6,
        ["�����"]	= 6,
        ["��ʥս"]	= 6,
    },
    ["����ʹ��LV7"] = {
        ["�һ�"] = 7,
        ["������"] = 7,
        ["��ɱ��"] = 7,
        ["�׵���"] = 7,
        ["������"] = 7,
        ["����"] = 7,
        ["ʩ����"]	= 7,
        ["�����"]	= 7,
        ["��ʥս"]	= 7,
    },
    ["����ʹ��LV8"] = {
        ["�һ�"] = 8,
        ["������"] = 8,
        ["��ɱ��"] = 8,
        ["�׵���"] = 8,
        ["������"] = 8,
        ["����"] = 8,
        ["ħ����"] = 8,
        ["ʩ����"]	= 8,
        ["�����"]	= 8,
        ["��ʥս"]	= 8,
    },
    ["����ʹ��LV9"] = {
        ["�һ�"] = 9,
        ["������"] = 9,
        ["��ɱ��"] = 9,
        ["�׵���"] = 9,
        ["������"] = 9,
        ["����"] = 9,
        ["ħ����"] = 9,
        ["ʩ����"]	= 9,
        ["�����"]	= 9,
        ["��ʥս"]	= 9,
    },
    ["����ʹ��LV10"] = {
        ["�һ�"] = 10,
        ["������"] = 10,
        ["��ɱ��"] = 10,
        ["�׵���"] = 10,
        ["������"] = 10,
        ["����"] = 10,
        ["ħ����"] = 10,
        ["ʩ����"]	= 10,
        ["�����"]	= 10,
        ["��ʥս"]	= 10,
    },
    ["����ʹ��LV11"] = {
        ["�һ�"] = 11,
        ["������"] = 11,
        ["��ɱ��"] = 11,
        ["�׵���"] = 11,
        ["������"] = 11,
        ["����"] = 11,
        ["ħ����"] = 11,
        ["ʩ����"]	= 11,
        ["�����"]	= 11,
        ["��ʥս"]	= 11,
    },
    ["����ʹ�߅d�ռ�"] = {
        ["�һ�"] = 15,
        ["������"] = 15,
        ["��ɱ��"] = 15,
        ["�׵���"] = 15,
        ["������"] = 15,
        ["����"] = 15,
        ["ħ����"] = 15,
        ["ʩ����"]	= 15,
        ["�����"]	= 15,
        ["��ʥս"]	= 15,
    },
}

local item_miao = { --jilv=�������ʣ� miao=��Ѫ���ٷֱȣ�1Ϊ100%����mubiao=(0��������Ч,1�Թ�����Ч,2���˹���Ч)
    {item_name={"����ʯ","����ʯ","��ȸʯ","����ʯ","�׻�ʯ"},jilv = 5, miao = 0.05, mubiao = 1,},
    {item_name={"����ʯ(ʷʫ)","����ʯ(ʷʫ)","��ȸʯ(ʷʫ)","����ʯ(ʷʫ)","�׻�ʯ(ʷʫ)"},jilv = 10, miao = 0.08, mubiao = 1,},
    {item_name={"����ʯ(����)","����ʯ(����)","��ȸʯ(����)","����ʯ(����)","�׻�ʯ(����)"},jilv = 15, miao = 0.15, mubiao = 1,},
}



local pklvlimit = 10--�����ټ�������PKֵ

local distace = {1, 6, "���鱶��"}--��ߵȼ�������ڶ��ټ����������͸���BUFF(���������ķ���)


local baobao_t = {6*3600, 12*3600}--�����ж�ʱ�� + ����ʱ��(��λ��)

local ServerNewtime = "2015-05-04 09:00:00"                 ---��������汾��(Ԥ��)
local Servertime = lualib:GetGSVer()                       ---��ǰ����汾��(���ٸ��µ�֧��GetGSVer�ӿڵİ汾)
local ServerNewtime_int = lualib:Str2Time(ServerNewtime)   ---��������汾��(Ԥ��)---��ֵ��
local Servertime_int = lualib:Str2Time(Servertime)         ---��ǰ����汾��(���ٸ��µ�֧��GetGSVer�ӿڵİ汾)---��ֵ��

local StartServerTime = lualib:GetConstVar("StartServerTime")
local StartServerTime_int = lualib:Str2Time(StartServerTime)   ---��������ʽ����ʱ��

local md5_list = {
    "A9B3E76445BDA32665B362618D40FD19", --�˴�Ϊ��Ϸ��ȫ��Ϣ�鿴�����У�������ҵ�md5��
    "74FCEF15A04C745D94AF60C34F3D90CD",
    "C49EB512D415DDA878205DCB1EB30B40",
    "E3B41C88B266B96AEEB8EB4387E14212",
    "242F5CF699FE4CC24980BD1089B4963C",
    "BEDD229ABBB3584BF2E2D73EEE6796C5",
    "23B268EC2E0C26993DF767432E68EB8B",
    "0C08CDA04B4442403DC8DED30D2C8205",
    "A3B038C1CE09F8D5BE1649632093CA6D",
    "6F9DBD7CBBBE4F140127031C049A167B",
    "143B9ED91994E699BFB462A0E04E656D",
    "6776DBF11354EB0F99FFB6232269F1A8",	----������430��Ұ汾��MD5��ϣ����Ҷ๲������MD5��
}

local petskill = {--�ͷż�����Ҫ�Ƴ���ұ���(ע���Ǽ���������) = 1
    ["���ޣ��޻�ӡ��"] = 1,

}


local tz_map = {--��ͼ������ = ����ʱ�䣨���뿪��ʱ�䵥λ�룩
    ["������ͼ"] = 18000,
    ["������ͼ"] = 18000,
}

local ss_msg = {
    --[1295700] = {"������㣬ţħ�����������5���ӿ�������������׼����", false},
    --[1296000] = {"������㣬ţħ��������Ѿ���������������ף�����Ϸ��죡", false},
    --[1295700] = {"������㣬ţħ�����������5���ӿ�������������׼����", false},
    --[1296000] = {"������㣬ţħ��������Ѿ���������������ף�����Ϸ��죡", true},
}



function on_pre_jump(player, from_map, to_map)
    local x = lualib:X(player)
    local y = lualib:Y(player)
    local now = lualib:GetAllTime()
    local start = lualib:GetConstVar("StartServerTime")
    local ser = lualib:Str2Time(start)
    local fromKey = lualib:KeyName(from_map)
    local toMap = lualib:KeyName(to_map)
    if tz_map[toMap] ~= nil then
        if now - ser < tz_map[toMap] then
            local second = tz_map[toMap] - (now - ser)
            local str = string.format("%d��%d��", second / 60, second % 60)
            lualib:SysTriggerMsg(player, "��ǰ��ͼ����"..str.."���ţ���ע��ϵͳ���棡")
            return false
        else
            return true
        end
    end
    return true
end

function send_system_msg(obj, id)
    local now = lualib:GetAllTime()
    local start = lualib:GetConstVar("StartServerTime")
    local ser = lualib:Str2Time(start)
    local dis = now - ser
    if ss_msg[dis] ~= nil then
        lualib:SysMsg_SendCenterMsg(1, ss_msg[dis][1], "")
        lualib:SysMsg_SendCenterMsg(1, ss_msg[dis][1], "")
        lualib:SysMsg_SendCenterMsg(1, ss_msg[dis][1], "")
        lualib:SysMsg_SendCenterMsg(1, ss_msg[dis][1], "")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "��ϵͳ��")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "��ϵͳ��")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "��ϵͳ��")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "��ϵͳ��")
        if ss_msg[dis][2] then
            lualib:DisableTimer(obj, id)
            lualib:SetDBNumEx("map_lock", 1, 2)
        end
    end
end

local AmarkItemTsT = {
    ["��ɫ����"] = 1,
    ["��ħ����"] = 1,
    ["�������"] = 1,
    ["��ʿ����"] = 1,
    ["��֮����"] = 1,
    ["��������"] = 1,
    ["������ָ"] = 1,
    ["�ϱ���"] = 1,
    ["̩̹��ָ"] = 1,
    ["����ͷ��"] = 1,
    ["ʥսͷ��"] = 1,
    ["����ͷ��"] = 1,
    ["����ͷ��"] = 1,
    ["ʥս����"] = 1,
    ["��������"] = 1,
    ["��������"] = 1,
    ["ʥս����"] = 1,
    ["��������"] = 1,
    ["��������"] = 1,
    ["ʥս��ָ"] = 1,
    ["�����ָ"] = 1,
    ["�����ָ"] = 1,
    ["ħѪ����"] = 1,
    ["ħѪ����"] = 1,
    ["ħѪ��ָ"] = 1,
    ["����ͷ��"] = 1,
    ["��������"] = 1,
    ["��������"] = 1,
    ["�����ָ"] = 1,
    ["��ͷ��"] = 1,
    ["������"] = 1,
    ["������"] = 1,
    ["����ָ"] = 1,
    ["��ħ����"] = 1,
    ["��ħ����"] = 1,
    ["��ħ��ָ"] = 1,
    ["��ħѫ��"] = 1,
    ["��ħ����"] = 1,
    ["��ħѥ��"] = 1,
    ["�������"] = 1,
    ["����ָ"] = 1,
    ["����ͷ��"] = 1,
    ["��������"] = 1,
    ["���ؽ�ָ"] = 1,
    ["����"] = 1,
    ["Ѫ��"] = 1,
    ["����Ȩ��"] = 1,
    ["����"] = 1,
    ["�Ȼ귨��"] = 1,
    ["����"] = 1,
    ["�޼���"] = 1,
    ["���ƽ�"] = 1,
    ["��ң��"] = 1,
    ["����"] = 1,
    ["������"] = 1,
    ["�þ�֮��"] = 1,
    ["ŭն"] = 1,
    ["����"] = 1,
    ["����2"] = 1,
    ["����3"] = 1,
    ["����֮��"] = 1,
    ["����֮��ս25"] = 1,
    ["����֮��ս30"] = 1,
    ["����֮��ս35"] = 1,
    ["����֮��ս40"] = 1,
    ["����֮��ս45"] = 1,
    ["����֮�з�25"] = 1,
    ["����֮�з�30"] = 1,
    ["����֮�з�35"] = 1,
    ["����֮�з�40"] = 1,
    ["����֮�з�45"] = 1,
    ["����֮�е�25"] = 1,
    ["����֮�е�30"] = 1,
    ["����֮�е�35"] = 1,
    ["����֮�е�40"] = 1,
    ["����֮�е�45"] = 1,
    ["��֮��"] = 1,
    ["����İ���֮��"] = 1,
    ["�����ŭն"] = 1,
    ["���������"] = 1,
    ["������Ȼ귨��"] = 1,
    ["���������"] = 1,
    ["�������ң��"] = 1,
    ["����Ĳþ�"] = 1,
    ["���������"] = 1,
    ["����Ĺ���Ȩ��"] = 1,
    ["ս�����(��)"] = 1,
    ["ս�����(Ů)"] = 1,
    ["��ħ����(��)"] = 1,
    ["��ħ����(Ů)"] = 1,
    ["����ս��(��)"] = 1,
    ["����ս��(Ů)"] = 1,
    ["��������"] = 1,
    ["��������"] = 1,
    ["��ħ���"] = 1,
    ["ʥս����"] = 1,
    ["�������"] = 1,
    ["��ʦ����"] = 1,
}


local ShiJieBossT = {
    ["����BOSS1"] = {1000, 1, 3},
    ["����BOSS2"] = {1000, 1, 3},
    ["����BOSS3"] = {1000, 1, 3},
    ["����BOSS4"] = {1000, 1, 3},
    ["����BOSS5"] = {1000, 1, 3},
    ["����BOSS6"] = {1000, 1, 3},
    ["����BOSS7"] = {1000, 1, 3},
}

function on_post_drop_one(map, player, item, id)
    if lualib:Monster_IsMonster(player) then
        if ShiJieBossT[lualib:Name(player)] ~= nil then
            lualib:SetInt(item, "ʰȡ��ȴ", lualib:GetAllTime() + 180)
        end
    end
    local KeyName = lualib:KeyName(item)
    if AmarkItemTsT[KeyName] ~= nil then
        local item_role = lualib:ItemRole(item)
        local player_name = lualib:Name(item_role)
        if player_name == "" then
            local s = "��"..lualib:Name(item).."��������"..lualib:Name(map).."["..lualib:X(item)..":"..lualib:Y(item).."]��"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        else
            local s = "��"..player_name.."����"..lualib:Name(map).."��ɱ"..lualib:Name(player).."�����ˡ�"..lualib:Name(item).."����"
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        end
    end
end


function txdyql()
    local djph_table1 = {}
    local djph_str1 = lualib:GetDBStr("na11")
    if djph_str1 ~= "" then
        djph_table1 = json.decode(djph_str1)
        target_Guid = lualib:Name2Guid(djph_table1[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һսʿ")
        end
        lualib:SetDBStr("na11","")
    end

    local djph_table2 = {}
    local djph_str2 = lualib:GetDBStr("na12")
    if djph_str2 ~= "" then
        djph_table2 = json.decode(djph_str2)
        target_Guid = lualib:Name2Guid(djph_table2[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һսʿ")
        end
        lualib:SetDBStr("na12","")
    end

    local djph_table3 = {}
    local djph_str3 = lualib:GetDBStr("na21")
    if djph_str3 ~= "" then
        djph_table3 = json.decode(djph_str3)
        target_Guid = lualib:Name2Guid(djph_table3[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һ��ʦ")
        end
        lualib:SetDBStr("na21","")
    end

    local djph_table4 = {}
    local djph_str4 = lualib:GetDBStr("na22")
    if djph_str4 ~= "" then
        djph_table4 = json.decode(djph_str4)
        target_Guid = lualib:Name2Guid(djph_table4[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һ��ʦ")
        end
        lualib:SetDBStr("na22","")
    end

    local djph_table5 = {}
    local djph_str5 = lualib:GetDBStr("na31")
    if djph_str5 ~= "" then
        djph_table5 = json.decode(djph_str5)
        target_Guid = lualib:Name2Guid(djph_table5[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һ��ʿ")
        end
        lualib:SetDBStr("na31","")
    end

    local djph_table6 = {}
    local djph_str6 = lualib:GetDBStr("na32")
    if djph_str6 ~= "" then
        djph_table6 = json.decode(djph_str6)
        target_Guid = lualib:Name2Guid(djph_table6[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"���µ�һ��ʿ")
        end
        lualib:SetDBStr("na32","")
    end
    lualib:SysMsg_SendBroadcastColor("ϵͳ��ʾ:���µ�һְҵ���������,�µ�һ���ѿ���", "", 2, 13)
    lualib:SysMsg_SendBroadcastColor("ϵͳ��ʾ:���µ�һְҵ���������,�µ�һ���ѿ���", "", 2, 13)
    lualib:SysMsg_SendBroadcastColor("ϵͳ��ʾ:���µ�һְҵ���������,�µ�һ���ѿ���", "", 2, 13)
end


function on_pre_stall_buy(buy, sell, item, total, num, types)
    lualib:DelayCall(sell, 8, "��̯��˰:set_total_value", total.."#"..types)
    return total
end

function on_pre_process_pk(killer, player)

    return true
end


function on_catch(player, pet, skill_id)
    lualib:AddTimer(pet, 11, baobao_t[1]*1000, 1, "panbian")
    lualib:AddTimer(pet, 12, baobao_t[2]*1000, 1, "siwang")
end


function panbian(pet, id)
    if lualib:Monster_IsExist(pet) then
        local master = lualib:Monster_GetMaster(pet)
        if master ~= "" then
            local player = lualib:Name2Guid(master)
            if player ~= "" then
                lualib:ServantBetry(player, pet)
            end
        end
    end
end

function siwang(pet, id)
    if lualib:Monster_IsExist(pet) then
        lualib:Monster_Remove(pet)
    end
end


function kaiquchuansong()
end

function on_post_die(role, killer)
    --lualib:SetInt(player, "die_flag", 1)
    --�����ʦ


    if lualib:GUIDType(role) == 0 and lualib:GUIDType(killer) == 0 then
        lualib:DelayCall(role, 1, "�����ʦ:on_die", killer);
    end


    --�����ʦ

    --��ն
    if lualib:GUIDType(role) == 2 then
        if lualib:GUIDType(killer) == 2 then
            local master = lualib:Monster_GetMaster(killer)
            if master ~= "" then
                killer = lualib:Name2Guid(master)
            end
        elseif lualib:GUIDType(killer) == 1 then
            killer = lualib:GetHeroLord(killer)
        end
        if lualib:GUIDType(killer) == 0 then

        end
    end
    --��ն
end

--����
function on_ride_request(player)
    local buff_table = {"������", "�������"}
    local hashorse = lualib:Attr(player, 200)

    if hashorse == 1 then
        lualib:MsgBox(player, "���Ѿ��������״̬�ˣ�")
        return
    end
    --ӵ�б���BUFF�޷�����
    for i = 1, #buff_table do
        if lualib:HasBuff(player, buff_table[i]) == true then
            lualib:MsgBox(player, "����״̬�޷��������Ҽ����BUFFͼ��ȡ��BUFF���ٽ��г���")
            return
        end
    end
    --�������
    lualib:ProgressBarStart(player, 5000, "������", "on_Horse_true", "on_Horse_false", "")
end

--����
function on_Horse_true(player)
    lualib:Ride(player)
    return true
end

--�������
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


function on_castle_war_start()
    lualib:SysMsg_SendBroadcastColor("���ǹ���ս��ʼ��", "", 1, 12)
    lualib:SetDBNum(lualib:GetAllDays(0).."�Ƿ񹥳�",1)
end

function on_castle_war_end()
    lualib:SetInt("0", "war_start", 0)
end

function on_player_relive(player)
    if lualib:Level(player) > 14 and lualib:Level(player) < 35 then
        for i=1, 5 do
            local Eq = lualib:Player_Summon(player, "��ɫ����", 3)
            lualib:AddBuff(Eq, "�޵�", 0)
        end
    end


    lualib:SetInt(player, "die_flag", 0)
    local map = lualib:Map_GetMapGuid("����")
    if lualib:GetInt("0", "war_start") == 1 then
        local own_family = lualib:GetCastleOwnFamily("����")
        local my_family = lualib:GuildGuid(player)

        if own_family == "" or my_family == "" then
            return true
        else
            if lualib:GetCastleOwnFamily("����")== lualib:Name(my_family) or lualib:GetCastleTempFamily("����") == lualib:Name(my_family) then
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

local countryName = {
    "���",
    "���",
    "κ��"
}
local countryPosition  = {
    "����",
    "ة��",
    "�󽫾�",
    "��˾��",
    "�󶼶�",
}

local sponsor = {
    {1.02,"����1"},
    {1.04,"����2"},
    {1.06,"����3"},
    {1.08,"����4"},
    {1.11,"����5"},
    {1.20,"����6"},
}

local DIETIMECONSTANT = 30
function on_player_login(player)
    local vip = lualib:GetVipLevel(player)
    if vip > 0 then
        lualib:AddBuff(player,sponsor[vip][2],0)
    end
    -- ���ߴ�������֮��
    local PrismaticJewelGUID = lualib:GetStr(player, "PrismaticJewelGUID")
    if PrismaticJewelGUID == "" then
        if lualib:GetBagFree(player) > 0 then
            local prismaticJewelGUID = lualib:GiveOneBindItem(player, "����֮��", 1, "��������֮��", "��������֮��")
            lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
            lualib:ApplyEquipEx(player, "����֮��")
        else
            local items = lualib:BagItemList(player, true, false, false)
            local item_guid = items[1]
            local item_json = lualib:Item2Json(item_guid)
            lualib:Item_Destroy("", item_guid, "�滻����֮��", "�滻����֮��")

            local prismaticJewelGUID = lualib:GiveOneBindItem(player, "����֮��", 1, "��������֮��", "��������֮��")
            lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
            lualib:ApplyEquipEx(player, "����֮��")
            lualib:Json2ItemEx(player, item_json, false)
        end
    else
        if not lualib:InEquip(player, PrismaticJewelGUID) then
            if lualib:GetBagFree(player) > 0 then
                local item_GUID = lualib:Player_GetEquipGuid(player, 414)
                lualib:Item_Destroy("", item_GUID, "����������֮���滻", "����������֮���滻")
                local prismaticJewelGUID = lualib:GiveOneBindItem(player, "����֮��", 1, "��������֮��", "��������֮��")
                lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
                lualib:ApplyEquipEx(player, "����֮��")
            else
                local items = lualib:BagItemList(player, true, false, false)
                local item_guid = items[1]
                local item_json = lualib:Item2Json(item_guid)
                lualib:Item_Destroy("", item_guid, "�滻����֮��", "�滻����֮��")
                local item_GUID = lualib:Player_GetEquipGuid(player, 414)
                lualib:Item_Destroy("", item_GUID, "����������֮���滻", "����������֮���滻")
                local prismaticJewelGUID = lualib:GiveOneBindItem(player, "����֮��", 1, "��������֮��", "��������֮��")
                lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
                lualib:ApplyEquipEx(player, "����֮��")
                lualib:Json2ItemEx(player, item_json, false)
            end
        end
    end

    -- ���߼����︴��ʱ��
    local jsonData = lualib:GetStr(player, "heroJsonData")
    local country = lualib:GetStr(player, "countryName")
    if jsonData ~= "" and country ~= "" then
        local warGodData = json.decode(jsonData)


        for index, value in pairs(warGodData[country]) do
            -- ÿ��һ�����1�����ڱ�ʾ����ʱ��
            local tempValue = lualib:GetInt(player, value[1].."DieTimeFlag")
            if tempValue > 0 then
                if lualib:HasTimer(player, 73032804) then
                    lualib:DisableTimer(player, 73072804)
                    lualib:AddTimer(player, 73032804, 1000, DIETIMECONSTANT, "warGodForm:BBRecoverTimer")
                else
                    lualib:AddTimer(player, 73032804, 1000, DIETIMECONSTANT, "warGodForm:BBRecoverTimer")
                end

            end
        end
    end



    -- �򿪺��Ӻ���С����
    lualib:ShowFormWithContent(player, "form�ļ���", "hzhUtil")

    if not lualib:HasTimer(player, 201785) then
        --	lualib:AddTimer(player, 201785, 60*1000, -1, "���µ�һ:udon")
    end
    if lualib:Level(player) > 14 and lualib:Level(player) < 35 then
        for i=1, 5 do
            local Eq = lualib:Player_Summon(player, "��ɫ����", 3)
            lualib:AddBuff(Eq, "�޵�", 0)
        end
    end

    --ÿ������ȷ���Ƿ��м�����ң�δ���뵯�����
    local count = 0
    local nameList = lualib:Name(player)            --�������
    local country = lualib:GetStr(player,"countryName")     --��������

    if country ~= "" then
        if lualib:HasBuff(player,country) == false then
            lualib:AddBuff(player,country,0)
        end

        local countryList = lualib:GetDBStr(country.."updateRanking")
        local listTable = lualib:StrSplit(countryList,"#")
        for j=2,#listTable do


            if #listTable < 6 then                                           --С�ڵ���5ʱֱ�����buff
                if nameList == listTable[j] then
                    lualib:AddBuff(player,countryPosition[j-1],0)
                    lualib:SysMsg_SendBroadcastMsg("��ӭ��"..country..countryPosition[j-1].."��***"..nameList.."***������Ϸ����������","ϵͳ")
                    lualib:SysMsg_SendBroadcastMsg("��ӭ��"..country..countryPosition[j-1].."��***"..nameList.."***������Ϸ����������","ϵͳ")
                    if lualib:GetDBNum(country..countryPosition[j-1].."Reward") == 1 then
                        lualib:DelayCall(player,1,"������:receiveIngots",tostring(j-1))
                        lualib:SetDBNum(country..countryPosition[j-1].."Reward",0)
                    end
                    break
                end
            else
                if nameList == listTable[j] then
                    lualib:AddBuff(player,countryPosition[j-1],0)
                    lualib:SysMsg_SendBroadcastMsg("��ӭ��"..country..countryPosition[j-1].."��***"..nameList.."***������Ϸ����������","ϵͳ")
                    lualib:SysMsg_SendBroadcastMsg("��ӭ��"..country..countryPosition[j-1].."��***"..nameList.."***������Ϸ����������","ϵͳ")
                    if lualib:GetDBNum(country..countryPosition[j-1].."Reward") == 1 then
                        lualib:DelayCall(player,1,"������:receiveIngots",tostring(j-1))
                        lualib:SetDBNum(country..countryPosition[j-1].."Reward",0)
                    end
                    break
                end

                if j==6 then                                                --���������buff ����ѭ��
                    break
                end
            end
        end
    end
    lualib:AddTimerEx(player,20200326,1000,-1,"������:levelUpAddBuff","")
    if  country == "" then
        lualib:DelayCall(player,1,"country:main","")
    end

    lualib:DelayCall(player, 1, "�л�����:check", "");
    lualib:DelayCall(player, 1, "Ӣ�۰�:check", "");
    local level = lualib:Level(player)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)
    if time > lualib:GetAllTime() then
        lualib:ShowFormWithContent(player,"form�ļ���","Amarkϵͳ����")
    end
    lualib:DelayCall(player, 1, "��½�ű�:main", "");
    lualib:DelayCall(player, 1, "ħ��Ѫʯ:on_login", "");
    active_player(player, 2, 0)	--��¼ʱ����վ���ͽ�ɫ������Ϣ����Ҫɾ������Ӱ��ͳ�ƹ���
    lualib:ShowFormWithContent(player, "form�ļ���", "������ʱ���#"..lualib:GetAllTime())

    --��������
    local die_flag = lualib:GetInt(player, "die_flag")
    if lualib:GetInt("0", "war_start") == 1 and die_flag == 1 then
        local own_family = lualib:GetCastleOwnFamily("����")
        local my_family = lualib:GuildGuid(player)
        if own_family == "" or own_family ~= lualib:Name(my_family) then
        else
            lualib:Player_MapMoveXY(player, "����", 586, 283, 5)
            lualib:SetInt(player, "die_flag", 0)
        end
    end

    --GM��½
    if lualib:Player_IsGM(player) then
        lualib:Player_SetGhost(player, true)
        lualib:SysMsg_SendTriggerMsg(player, "���ѽ�������״̬��")
        lualib:Player_SetInvincible(player, true)
        lualib:SysMsg_SendTriggerMsg(player, "���ѽ����޵�״̬��")
        lualib:AddBuff(player, "����", 60*60*24)
        lualib:SysMsg_SendTriggerMsg(player, "���ѽ��뼲��״̬��")
    end

    --���Ͻ�ͼ����ʾ
    CountPlyaerGold(player)
    chongzhi_libao(player)
    wanjiajisuan(player)
    check_days_bill(player)
    weixin_xianshi(player)--΢��
    Amark_huodong(player)
    jihuoma_xianshi(player)--������
    AmarkBossTiaoZhanMain(player)--AmarkBossTiaoZhan
    lualib:DelayCall(player, 1, "������:chongzhi_paihang", "")
    --���ܵ���
    marry_load(player)			--�����Ƿ����/����۳����ܶ�
    process_master_apprentice_login(player)	--����ʦͽ��¼����
    local types = lualib:GetClientType(player)  ----��ȡ��ҽ�����Ϸ��ʽ������0����ͨ���ͻ��ˣ�1��ҳ�ζˣ�2�����ζ�
    if types == 0 then      ----------��������ͨ���ͻ��˽�����Ϸ��ִ�����¼��
    local NowTime = lualib:GetAllTime()
        local subtimer = NowTime - StartServerTime_int
        if subtimer > 86400 then     ----��ǰʱ����ڿ���ʱ��24Сʱ��ִ�����¼�⣬���������������ϲ����ʧ�����о����Ƿ���Ҫ����ж�
        if lualib:Player_IsGM(player) == false then
        end
            if Servertime_int >= ServerNewtime_int then   -----�����ǰ����汾 >= Ԥ�����������汾��ִ��MD5���
            lualib:AddTimer(player,20150501,lualib:GenRandom(300, 600) * 1000,-1,"md5_check")
                ---���ͬʱ���MD5�Ῠ��������������5--10���Ӽ��һ�Σ�ͬʱ�������ù̶�ʱ��������ҵ�����
            end
            lualib:DelayCall(player, 3000, "client_ver", "")  ------ ���ͻ��˰汾delaycall �ص�
        end
    end
    Creat_tage_mei(player)
    Creat_tage_dj(player)
    Creat_tage_blee(player)
    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--�洢�������а�
    end
    if lualib:Level(player) <= 35 then
        if not lualib:HasBuff(player,"���뽭��") then
            lualib:AddBuff(player,"���뽭��")
        end
    end
    --	lualib:DelayCall(player, 2000, "AmarkSetSkillBarSkill", "")
end

function AmarkSetSkillBarSkill(player)
    lualib:ShowFormWithContent(player,"�ű���", "AmarkYdFormSkillSet()")
end

function on_login_delay_timer(player, timer_id)
    local caller = (lualib:Gender(player) == 1) and "�ɷ�" or "����"
    local spouse = lualib:Player_GetCustomVarStr(player, "��żGUID")
    lualib:SysPromptMsg(spouse, "���"..caller.."�����ˡ�")
end

function client_ver(player)
    lualib:RequestClientVer(player);
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "");
end

function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player);
    if (ver < 3003) or (ver <  3011 ) then
        lualib:SysMsg_SendTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysMsg_SendTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysMsg_SendTriggerMsg(player, "�ͻ���̫����ر�������Ϸ���ڲ�Ҫ˫�������´򿪵�¼�����£�")
        lualib:SysMsg_SendTriggerMsg(player, "���������������¼������Դ�޸������޸���ſ���������Ϸ��")
        lualib:SysMsg_SendTriggerMsg(player, "���������������¼������Դ�޸������޸���ſ���������Ϸ��")
        lualib:DelayCall(player, 3000, "kick_player", "");
    end
end

function kick_player(player)
    lualib:Player_Kick(player)
end

function on_player_logout(player)
    lualib:DelayCall(player, 1, "�˳��ű�:main", "");
    CountPlyaerGold(player)
    --online_gift_logout(player)						--��������˳�
end

function on_player_add_exp(player, expv)
    local Lsd = lualib:GetStr(player, "Amark_Lsd_Guid")
    if lualib:HasItem(player, Lsd) then
        lualib:SetInt(Lsd, "Amark_Exp", lualib:GetInt(Lsd, "Amark_Exp") + 1)
        lualib:NotifyVar(Lsd, "Amark_Exp")
    end
    lualib:DelayCall(player, 1, "����ű�:main", tostring(expv));
    --process_horse_add_exp(player, tonumber(expv))
end

local AmarkLevelUpEquipT = {
    [15] = {
        [1] = {--սʿ
            {--��
                {"�˻�", 0, 0},--������+����+������[0��1��]
                {"���Ϳ���(��)", 0, 0},
            },
            {--Ů
                {"�˻�", 0, 1},--������+����+������[0��1��]
                {"���Ϳ���(Ů)", 0, 1},
            },
        },

        [2] = {--��ʦ
            {--��
                {"����", 0, 1},--������+����+������[0��1��]
                {"���Ϳ���(��)", 0, 1},
            },
            {--Ů
                {"����", 0, 1},--������+����+������[0��1��]
                {"���Ϳ���(Ů)", 0, 1},
            },
        },

        [3] = {--��ʿ
            {--��
                {"����", 0, 1},--������+����+������[0��1��]
                {"���Ϳ���(��)", 0, 1},
            },
            {--Ů
                {"����", 0, 1},--������+����+������[0��1��]
                {"���Ϳ���(Ů)", 0, 1},
            },
        },
    },

    [25] = {--սʿ
        [1] = {
            {--��
                {"����", 0, 1},--������+����+������[0��1��]
                {"�ؿ���(��)", 0, 1},
                {"��ɫˮ����ָ", 10, 1},
                {"��ɫˮ����ָ", 11, 1},
                {"��������", 3, 1},
                {"��������", 4, 1},
                {"���������", 1, 1},
                {"��ʿͷ��", 1, 1},
            },
            {--Ů
                {"����", 1, 1},--������+����+������[0��1��]
                {"�ؿ���(Ů)", 1, 1},
                {"��ɫˮ����ָ", 10, 1},
                {"��ɫˮ����ָ", 11, 1},
                {"��������", 3, 1},
                {"��������", 4, 1},
                {"���������", 1, 1},
                {"��ʿͷ��", 1, 1},
            },
        },

        [2] = {--��ʦ
            {--��
                {"����", 1, 1},--������+����+������[0��1��]
                {"ħ������(��)", 1, 1},
                {"�Ŵ�", 1, 1},
                {"���۽�ָ", 10, 1},
                {"���۽�ָ", 11, 1},
                {"��̴����", 3, 1},
                {"��̴����", 4, 1},
                {"��ʿͷ��", 1, 1},
            },
            {--Ů
                {"����", 1, 1},--������+����+������[0��1��]
                {"ħ������(Ů)", 1, 1},
                {"�Ŵ�", 1, 1},
                {"���۽�ָ", 10, 1},
                {"���۽�ָ", 11, 1},
                {"��̴����", 3, 1},
                {"��̴����", 4, 1},
                {"��ʿͷ��", 1, 1},
            },
        },

        [3] = {--��ʿ
            {--��
                {"��ħ", 1, 1},--������+����+������[0��1��]
                {"���ս��(��)", 1, 1},
                {"�����ָ", 10, 1},
                {"�����ָ", 11, 1},
                {"���", 1, 1},
                {"��ʿ����", 3, 1},
                {"��ʿ����", 4, 1},
                {"��ʿͷ��", 1, 1},
            },
            {--Ů
                {"��ħ", 1, 1},--������+����+������[0��1��]
                {"���ս��(Ů)", 1, 1},
                {"���", 1, 1},
                {"�����ָ", 10, 1},
                {"�����ָ", 11, 1},
                {"��ʿ����", 3, 1},
                {"��ʿ����", 4, 1},
                {"��ʿͷ��", 1, 1},
            },
        },
    },
}

local LevelUpT = {
    [32] = 1,
    [35] = 1,
    [37] = 1,
    [38] = 1,
    [40] = 1,
    [42] = 1,
    [45] = 1,
}


function on_level_up(player, level)
    if level == 15 then
        for i=1, 5 do
            local Eq = lualib:Player_Summon(player, "��ɫ����", 3)
            lualib:AddBuff(Eq, "�޵�", 0)
        end
        if lualib:ItemCount(player, "���������(5��)") > 0 then
            lualib:ApplyItem(player, "���������(5��)", false)
        end
        lualib:Player_MapMove(player,"��������3")
        lualib:MsgBox(player,"#COLORCOLOR_YELLOW#\n��ϲ����#COLORCOLOR_GREENG#��15����#COLORCOLOR_YELLOW#ϵͳΪ��׼����\n���߼���ѵ������ ")
    end
    if level == 20 then
        lualib:MsgBox(player,"#COLORCOLOR_YELLOW#\n��ϲ����#COLORCOLOR_GREENG#��20����#COLORCOLOR_YELLOW#�����ڿ���ȥ\n�涴̽�� ")
        lualib:Player_MapMove(player,"����1�㶫")
        lualib:AcceptQuest(player, 10001)
        if lualib:ItemCount(player, "���������(15��)") > 0 then
            lualib:ApplyItem(player, "���������(15��)", false)
        end
    end
    if level == 35 then
        local BabyList = lualib:Player_GetServantList(player)
        for i=1, #BabyList do
            local KeyName = lualib:KeyName(BabyList[i])
            if KeyName == "��ɫ����" then
                lualib:Monster_Remove(BabyList[i])
            end
        end
        lualib:DelBuff(player,"���뽭��")
    end

    if LevelUpT[level] ~= nil then
        lualib:Player_RunScript(player, "�弶������:Ukxeuqdd", "")
    end

    if AmarkLevelUpEquipT[level] ~= nil then
        local Job = lualib:Job(player)
        local Gender = lualib:Gender(player)
        if AmarkLevelUpEquipT[level][Job][Gender] ~= nil then
            for i=1, #AmarkLevelUpEquipT[level][Job][Gender] do
                lualib:AddItem(player, AmarkLevelUpEquipT[level][Job][Gender][i][1], 1, true, "����װ��", "����װ��")
                lualib:TakeOnEx(player, AmarkLevelUpEquipT[level][Job][Gender][i][1], AmarkLevelUpEquipT[level][Job][Gender][i][2])
            end
        end
    end



    --��¼���Խ���[��ӵ���������]
    level = tonumber(level)
    local testtime = lualib:GetConstVar("TestServerTime")
    local testtimes = lualib:Str2Time(testtime)
    local nowtime = lualib:GetAllTime()
    if nowtime < testtimes then
        --local leveluptb = {
        --[35] = "levelup42.txt",--�ȼ���Ӧ�Ĵ洢�ĵ���
        -- }
        if leveluptb[level] ~= nil then
            local account = lualib:AccountName(player)
            if not lualib:IO_FileExists(leveluptb[level]) then
                lualib:IO_CreateTextFile(leveluptb[level], false)
            end
            if not lualib:IO_TextFileInsertLine(leveluptb[level], 1, account) then
                lualib:Error("��ӹ��⽱���ʺ�"..account.."ʧ�ܣ�")
            else
                lualib:SysTriggerMsg(player, "��ϲ�����ڲ�������"..level.."������ʽ���������ȡ���⽱����")
            end
        end
    end
    Creat_tage_dj(player)
    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--�洢�������а�
    end
    active_player(player, 3, 0)	--����ʱ����վ���ͽ�ɫ������Ϣ����Ҫɾ������Ӱ��ͳ�ƹ���
    process_apprentice_level_up(player, level)			--����ͽ����������
end



--------[[��ҵ�һ�ν�����Ϸ]]
function on_first_in_game(player)

    lualib:SysMsg_SendBroadcastMsg("#COLORCOLOR_WHITE#����Ӣ�۳��ұ�#COLOREND##COLORCOLOR_YELLOW#��"..lualib:Name(player).."��#COLOREND##COLORCOLOR_WHITE#�����˱���Ϸ,����է��,���Ҷ�����","")
    --�������߸�����
    local job = lualib:Job(player)
    if job == 1 then
        lualib:Player_AddSkill(player, "��������3��")
        lualib:Player_AddSkill(player, "��ɱ����3��")
        lualib:Player_AddSkill(player, "��ɱ����3��")
        lualib:Player_AddSkill(player, "�����䵶3��")
        lualib:Player_AddSkill(player, "Ұ����ײ3��")

    elseif job == 2 then
        lualib:Player_AddSkill(player, "������3��")
        lualib:Player_AddSkill(player, "���ܻ�3��")
        lualib:Player_AddSkill(player, "�ջ�֮��3��")
        lualib:Player_AddSkill(player, "�׵���3��")
        lualib:Player_AddSkill(player, "��ǽ3��")
        lualib:Player_AddSkill(player, "˲Ϣ�ƶ�3��")
        lualib:Player_AddSkill(player, "���ѻ���3��")
        lualib:Player_AddSkill(player, "�����Ӱ3��")
        lualib:Player_AddSkill(player, "�����׹�3��")
        lualib:Player_AddSkill(player, "ʥ����3��")
        lualib:Player_AddSkill(player, "ħ����3��")

    elseif job == 3 then
        lualib:Player_AddSkill(player, "������3��")
        lualib:Player_AddSkill(player, "������ս��3��")
        lualib:Player_AddSkill(player, "ʩ����3��")
        lualib:Player_AddSkill(player, "������3��")
        lualib:Player_AddSkill(player, "�����3��")
        lualib:Player_AddSkill(player, "�ٻ�����3��")
        lualib:Player_AddSkill(player, "����������3��")
        lualib:Player_AddSkill(player, "�����3��")
        lualib:Player_AddSkill(player, "��ʥս����3��")
        lualib:Player_AddSkill(player, "��ħ��3��")
        lualib:Player_AddSkill(player, "Ⱥ��������3��")
    end



    --�������߸�����
    --lualib:ForceAcceptQuest(player, 3006)
    local item_k = {"��ľ��","���������(5��)","���������","����ָ��","��ɽ�Ǵ���ʯ","�����(20��)",}
    local item_n = {1,1,1,1,1,1,}
    local item_b = {1,1,1,1,1,1,}
    local item_o = {0,0,0,0,0,0,}

    if not lualib:Player_ItemRequest(player, item_k, item_n, item_b, item_o, "����Ʒ����һ�ν���Ϸ", "") then
        lualib:SysMsg_SendTriggerMsg(player, "������Ʒ����ʧ�ܣ�")
    end

    lualib:ApplyEquipEx(player,"��ľ��")
    lualib:ApplyEquipEx(player,"���������")
    local Gender = lualib:Gender(player)
    local award_item = {"����(��)", "����(Ů)"}
    if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
        lualib:SysMsg_SendTriggerMsg(player, "���ͽ���·�ʧ�ܣ�")
    end
    lualib:ApplyEquipEx(player, "����(��)")
    lualib:ApplyEquipEx(player, "����(Ů)")
    local level = lualib:Level(player)

    local player_name = lualib:Name(player)
    lualib:DelayCall(player, 2000, "AmarkSetSkillBarSkill", "")
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

    local url = string.format("http://api.hzyotoy.com:8800/api/putroleinfo.do?type=%d&zoneid=%d&userid=%d&role_guid=%s&level=%d&role_name=%s&job=%d",request_type, serverid, accountid, player, level, lualib:UrlEncode(role_name), job);

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
end


function on_hack_check(player, a, b)
    if b > 10 then
        lualib:SysWarnMsg(player, "�벻Ҫʹ�����,���Ѿ���ϵͳ��¼�����������ֱ�ӷ�ţ�");
        lualib:Error(lualib:Name(player) .. "����ʹ�ùһ����");
    end
end


------------------�����һص�--------------------
function on_hack_check2(player, C1, C2, C3, C4, C5, C6)
    local types = lualib:GetClientType(player)  ----��ȡ��ҽ�����Ϸ��ʽ������0����ͨ���ͻ��ˣ�1��ҳ�ζˣ�2�����ζ�
    if types ~= 0 then      ----------�������ͨ���ͻ��˽�����Ϸ���Ͳ�ִ�м��
    return
    end

    local PreTime = lualib:GetTempInt(player, "HackCheckTime")
    local NowTime = lualib:GetAllTime()
    if NowTime - PreTime < 60 then  ----�����ǰʱ����ϴμ��ʱ��С��60�룬��ִ���ж�
    return;
    end
    lualib:SetTempInt(player, "HackCheckTime", NowTime)

    -- if C1 >= 1 or C6 >= 1 then    -----C6������LOL���ӣ����ã���
    if C1 >= 1 then
        lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
        lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
        lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
        lualib:DelayCall(player, 3000, "kick_player", "")
    end
end

function on_trigger_billin(player, yb)
    yb = tonumber(yb)

    local name = lualib:Name(player)
    lualib:SysMsg_SendWarnMsg(player, "���ֵ��"..yb.."Ԫ��")
    lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..name.."�����߳�ֵ���" .. yb ..  "Ԫ��","[��ֵ��ʾ]", 2, 11)
    Creat_tage_blee(player)
    lualib:DelayCall(player, 1, "������:chongzhi_paihang", "")

end

function on_trigger_kill(killer, victim)
    local victim_name = lualib:KeyName(victim)
    local player_guid = ""

    if lualib:Player_IsPlayer(killer) == true then
        if lualib:Player_HasTeam(killer) then
            local ZuDuiT = lualib:Player_GetTeamList(killer)
            for i=1, #ZuDuiT do
                if lualib:Distance(ZuDuiT[i], killer) < 10 then
                    renwuchufa(ZuDuiT[i],victim) --����ɱ��ִ��
                end
            end
        else
            renwuchufa(killer,victim) --����ɱ��ִ��
        end
    elseif lualib:Monster_IsMonster(killer) == true then
        local player_name = lualib:Monster_GetMaster(killer)
        if player_name ~= "" then
            local player_guild = lualib:Name2Guid(player_name)
            if lualib:Player_HasTeam(player_guild) then
                local ZuDuiT = lualib:Player_GetTeamList(player_guild)
                for i=1, #ZuDuiT do
                    if lualib:Distance(ZuDuiT[i], player_guild) < 10 then
                        renwuchufa(ZuDuiT[i],victim) --����ɱ��ִ��
                    end
                end
            else
                renwuchufa(player_guild,victim) --����ɱ��ִ��
            end
        end
    end

    if lualib:Player_IsPlayer(victim) then
        local map = lualib:MapGuid(victim)
        local s = "#COLORCOLOR_GREENG#������#COLORCOLOR_RED#["..lualib:Name(killer).."]#COLORCOLOR_GREENG#��#COLORCOLOR_PURPLE#["..lualib:Name(map).."]#COLORCOLOR_GREENG#���ɽ�����#COLORCOLOR_SKYBLUE#["..lualib:Name(victim).."]#COLORCOLOR_GREENG#�̵��ڽ���-_-|||��ǿ��Χ���С���"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
    end

    if lualib:Monster_IsMonster(victim) == true and lualib:Monster_IsMonster(killer) then
        if not lualib:Player_IsPlayer(killer) then
            local names = lualib:Monster_GetMaster(killer)
            player_guid = lualib:Name2Guid(names)
        else
            player_guid = killer
        end
        --if fmcj[victim_name] ~= nil then
        --local num_n = fmcj[victim_name]
        --lualib:DelayCall(player_guid, 1, "��ħ��:add_fmd", tostring(num_n))
        --lualib:SysMsg_SendPromptMsg(player_guid, "���ɱ��һֻ��ħ�ɾ͹����ý��շ�ħ�㣺"..fmcj[victim_name].."��")
        --end
        --if Tx_richangmubiao[victim_name] ~= nil then
        --local num_e = Tx_richangmubiao[victim_name]
        --lualib:DelayCall(player_guid, 1, "�ճ�Ŀ��:add_goalpoint", tostring(num_e))
        --end
    end
end

----------------���ͻ��˰汾------------
function client_ver(player)
    lualib:RequestClientVer(player)  ----����ͻ��˰汾�ţ���Ҹ����߿ͻ��˿���û���ϱ��汾�ţ�������Ҫ��������һ�Σ�
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "")
end


function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player) ----�����ҿͻ��˰汾��

    --if ver < lualib:GetGSClientVer()  then  ----  ��õĿͻ��˰汾�ź� �����Զ�ѧϰ�������°汾�� ���Ƚ� �����Լ�OSS������Դ����Ҫͬ���¹ٷ�5��13����Դ��
    if ver < 3011  then
        lualib:SysMsg_SendTriggerMsg(player, "��Ŀͻ��˹��ϣ���ر���Ϸ���´򿪵�¼�����[��Դ�޸�]�������¿ͻ��ˣ�")
        lualib:SysMsg_SendTriggerMsg(player, "��Ŀͻ��˹��ϣ���ر���Ϸ���´򿪵�¼�����[��Դ�޸�]�������¿ͻ��ˣ�")
        lualib:SysMsg_SendTriggerMsg(player, "��Ŀͻ��˹��ϣ���ر���Ϸ���´򿪵�¼�����[��Դ�޸�]�������¿ͻ��ˣ�")
        lualib:SysMsg_SendTriggerMsg(player, "��Ŀͻ��˹��ϣ���ر���Ϸ���´򿪵�¼�����[��Դ�޸�]�������¿ͻ��ˣ�")
        lualib:SysMsg_SendTriggerMsg(player, "��Ŀͻ��˹��ϣ���ر���Ϸ���´򿪵�¼�����[��Դ�޸�]�������¿ͻ��ˣ�")
        lualib:DelayCall(player, 3000, "kick_player", "")
    end
end


--------------���࿪----------------------
function Client_info(player, param, info_table, is_timeout)

end

----------------������MD5�ص�------------

function md5_check(player,timer_id)
    lualib:SetMD5CheckList(player, md5_list, "on_md5_check", "�����Ѳ�������Ƥ���־�˼�ܴ��;�󷨺ã�", 300000)
end

function on_md5_check(player, param, md5_num_list, is_timeout)
    --[[
            if is_timeout == true then
                    lualib:SysMsg_SendTriggerMsg(player, "�����ҳ���ʱ�������´򿪵�¼�������[��Դ�޸�]�����µ�¼")
                    lualib:SysMsg_SendTriggerMsg(player, "�����ҳ���ʱ�������´򿪵�¼�������[��Դ�޸�]�����µ�¼")
                    lualib:SysMsg_SendTriggerMsg(player, "�����ҳ���ʱ�������´򿪵�¼�������[��Դ�޸�]�����µ�¼")
                    lualib:SysMsg_SendTriggerMsg(player, "�����ҳ���ʱ�������´򿪵�¼�������[��Դ�޸�]�����µ�¼")
                    lualib:SysMsg_SendTriggerMsg(player, "�����ҳ���ʱ�������´򿪵�¼�������[��Դ�޸�]�����µ�¼")
                    --lualib:DelayCall(player, 3000, "kick_player", "")
            else
                    for i = 1,#md5_num_list do
                            if md5_num_list[i] > 0 then
                                    lualib:DelayCall(player, 1, "��Ҵ���:fwg", "")
                                    lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
                                    lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
                                    lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
                                    lualib:SysMsg_SendWarnMsg(player, "���棺ϵͳ�����������ʹ�÷Ƿ���ҳ��򣬽��������ߣ�")
                                    lualib:Error(lualib:Name(player) .. "����ʹ�ùһ����")
                            end
                    end
            end
            ]]
end


-------------����---------------------
function kick_player(player)
    lualib:Player_Kick(player)
end

--���߹һ�

function on_pre_logout(player, type)
    --����
    lualib:SetInt(player, "last_logout", lualib:GetAllTime())
    if not lualib:HasTimer(player, 112568) then
        lualib:DisableTimer(player, 112568)
    end
    local map = lualib:Map_GetMapGuid("����")

    if lualib:Level(player) < 35 then
        local MonsterT = lualib:Player_GetServantList(player)
        for i=1, #MonsterT do
            lualib:Monster_Remove(MonsterT[i])
        end
        return true
    end
    lualib:ShowFormWithContent(player, "�ű���", "fgxewkry.uduf()")
    if tonumber(type) == 1 then
        local rx = lualib:GenRandom(-9,9)
        local ry = lualib:GenRandom(-9,9)
        lualib:SetOffline(player, 1440000)--�һ�400Сʱ����λ����
        local x = 293 + rx
        local y = 362 + ry
        lualib:Map_JumpXY(map, player, x, y, 10)
        lualib:Player_SetInvincible(player,true)
        return false
    end
    --����
    return true;
end

function kouchusx(player)
    lualib:SetDynamicAttr(player,77,0,0)
    lualib:SetDynamicAttr(player,78,0,0)
    lualib:SetDynamicAttr(player,79,0,0)
end



-------------��������---------------------
function on_spell(player, id, name, x, y, target, key)--�˴��Ǽ�������
    local neck = "��������"	--��������������
    local skills = {
        ["��ͨ������"] = 1,--ʲô���ܲ���Ҫ����������
    }
    if lualib:GUIDType(player) == 0 and skills[key] == nil then
        local item = lualib:Necklace(player)
        if item ~= "" then
            if lualib:KeyName(item) == neck then
                lualib:DelayCall(player, 100, "set_skill_exp", key)
            end
        end
    end
    if lualib:GUIDType(player) == 0 and petskill[key] ~= nil then
        local list = lualib:Player_GetServantList(player)
        if #list > 0 then
            for _, v in ipairs(list) do
                lualib:Monster_Remove(v)
            end
        end
    end


end

function set_skill_exp(player, key)--���������ص�����
    local exps = 5	--������������������Ӷ��ٵ�������
    local shulian = lualib:GetSkillExp(player, key)
    lualib:SetSkillExp(player, key, shulian + exps)
end

-------------�����ſɰ�̯---------------------
function on_pre_stall(player)
    local Level = lualib:Level(player)
    if Level < 10 then
        lualib:SysMsg_SendTriggerMsg(player,"25���ſɰ�̯")
        return false
    end
    return true
end






function pre_player_die(player, killer)
    if lualib:GetInt(player, "Amark_Horse_Skill_Id_13") > 0 then
        local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}
        if lualib:GetInt(player, "Amark_Horse_SKill_Cd_13") < lualib:GetAllTime() then
            if lualib:GenRandom(1, 1) > SkillJv[lualib:GetInt(player, "Amark_Horse_Skill_Id_13")]then
            else
                lualib:SetHp(player, math.floor(lualib:Hp(player, true) * 0.2), false)
                lualib:SendRoleHPNtf(player)
                lualib:SetInt(player, "Amark_Horse_SKill_Cd_13", lualib:GetAllTime() + 300)
                lualib:AddBuff(player, "�ػ���", 3)
                return false
            end
        end
    end
    if Tjit(player) then
        return false
    end


    return true
end

local skillTb1 = {--����,����
    ["���֮Դ1"] = {10,30},
    ["���֮Դ2"] = {20,40},
    ["���֮Դ3"] = {30,50},
    ["���֮Դ4"] = {40,60},
}

function on_attack_ex(role, tacker, hp, skill_key)
    local name = lualib:KeyName(role)
    if string.match(name,"�ػ���") == "�ػ���" then
        --lualib:SysMsg_SendCenterMsg(0,tostring(name), attacker)
        local player =  lualib:Name2Guid(lualib:Monster_GetMaster(role))
        --lualib:SysMsg_SendCenterMsg(0,tostring(lualib:Name(player)), attacker)
        for i,v in pairs(skillTb1) do
            if lualib:HasBuff(player,i) then
                local Hp = lualib:Hp(tacker,false)
                local num = lualib:GenRandom(1,100)
                if num <= v[1] then
                    local delHp = math.floor(hp * (v[2]/100))
                    if delHp >= Hp then
                        lualib:KillEx(tacker,player)
                    else
                        lualib:SetHp(tacker,Hp-delHp,false)
                        lualib:ShowRoleHPRefEx("",tacker,delHp,3)
                    end
                end
                --lualib:SysMsg_SendCenterMsg(0,tostring(name), attacker)
            end
        end
    end

    --��Ѫ
    local jyjn = {"��ǽ1��","��ǽ2��","��ǽ3��","��ǽ4��","��������1��","��������2��","��������3��","��������4��","��������5��","��ǽ5��"}  --����KeyName
    for i = 1,#jyjn do
        if skill_key == jyjn[i] then
            return ""
        end
    end

    if lualib:Player_IsPlayer(tacker) then
        for k,v in pairs(item_miao) do
            local tongguo = true
            for k1,v1 in pairs(v.item_name) do
                if lualib:ItemCountEx(tacker,v1,2,true,false,false,false) > 0 then
                else
                    tongguo = false
                    break
                end
            end

            if tongguo then
                local cgl = lualib:GenRandom(1, 100)
                if cgl <= item_miao[k].jilv then
                    --lualib:SysMsg_SendWarnMsg(tacker,"������"..k.."�����ԣ�")
                    if item_miao[k].mubiao == 0 and lualib:GUIDType(role) == 0 then
                        lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[k].miao), false)
                        lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[k].miao, 3)
                    elseif item_miao[k].mubiao == 1 and lualib:GUIDType(role) == 2 then
                        lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[k].miao), false)
                        lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[k].miao, 3)
                    elseif item_miao[k].mubiao == 2 then
                        lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[k].miao), false)
                        lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[k].miao, 3)
                    end

                end
            end
        end
    end
    --��Ѫ
    --lualib:DelayCall(role, 300, "������װ����:Qentdduf", tacker.."#"..skill_key)
    lualib:DelayCall(role, 100, "�ؽ�:Atfm", "")
    return ""
end


-- local P_tx = 0
-- local item_k = ""
-- for k , v in pairs(item_miao) do
-- for i = 1, 30 do
-- if lualib:KeyName(lualib:Player_GetItemGuid(tacker, i)) == k then
-- item_k = lualib:KeyName(lualib:Player_GetItemGuid(tacker, i))
-- P_tx = 1
-- end
-- end

-- end

-- if P_tx < 1 or item_k == "" then
-- return ""
-- end

-- local cgl = lualib:GenRandom(1, 100)
-- if cgl <= item_miao[item_k].jilv then
-- if item_miao[item_k].mubiao == 0 and lualib:GUIDType(role) == 0 then
-- lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[item_k].miao), false)
-- lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[item_k].miao, 3)
-- elseif item_miao[item_k].mubiao == 1 and lualib:GUIDType(role) == 2 then
-- lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[item_k].miao), false)
-- lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[item_k].miao, 3)
-- elseif item_miao[item_k].mubiao == 2 then
-- lualib:SetHp(role, lualib:Hp(role, false) - (lualib:Hp(role, true) * item_miao[item_k].miao), false)
-- lualib:ShowRoleHPRefEx("", role, - lualib:Hp(role, true) * item_miao[item_k].miao, 3)
-- end

-- end



--����װ�����ʧȥ����
function chuandaiqian(player, item, item_id, item_keyname)



    if lualib:Job(player) == 3 then
        if skills[item_keyname] ~= nil then
            if not lualib:HasSkill(player, skills[item_keyname], false) then
                lualib:AddSkill(player, skills[item_keyname])
                lualib:SysWarnMsg(player, "����ʷʫװ�����������ԣ���ϲ�������ˡ�".. lualib:KeyName2Name(skills[item_keyname], 17) .."�����ܡ�")
            end
        end
    end
end

function tuozhuangbei(player, item, item_id, item_keyname)



    if lualib:Job(player) == 3 then
        if skills[item_keyname] ~= nil then
            if lualib:HasSkill(player, skills[item_keyname], false) then
                lualib:DelSkill(player, skills[item_keyname])
                lualib:SysWarnMsg(player, "ʷʫװ������������ʧ����ʧȥ�ˡ�".. lualib:KeyName2Name(skills[item_keyname], 17) .."�����ܡ�")
            end
        end
    end
end
--����װ�����ʧȥ����




local renwu_guai = {
    ["������"] = {1,20},
    ["���"] = {2,20},
    ["�������"] = {3,20},
    ["ǯ��"] = {4,10},

    ["��Ұ��"] = {5,60},
    ["��Ұ��"] = {6,50},
    ["��ɫ����"] = {7,40},
    ["��Ұ��"] = {8,10},


    ["����ս��"] = {9,60},
    ["������ʿ"] = {10,50},
    ["�������"] = {11,40},
    ["�������"] = {12,1},

    ["���﹭����"] = {13,50},
    ["�������"] = {14,50},
    ["������ʿ"] = {15,40},
    ["�������"] = {16,1},

    ["ţħ��ʿ"] = {17,50},
    ["ţħսʿ"] = {18,50},
    ["ţħ��ʦ"] = {19,30},
    ["ţħ��"] = {20,1},

    ["ħ�ǵ���"] = {21,50},
    ["ħ����ʿ"] = {22,40},
    ["ħ�Ǹ���"] = {23,30},
    ["ħ��ս��"] = {24,5},

    ["Ѫħ��ʬ"] = {25,50},
    ["а��ʬ"] = {26,40},
    ["ħʬū��"] = {27,30},
    ["��������"] = {28,5},


}

function renwuchufa(killer,victim)
    local victim_name = lualib:Name(victim) --����keyname
    local kill_ren_name = lualib:Name(killer)
    local victim_ren_name = lualib:Name(victim)
    if lualib:Monster_IsMonster(victim) and renwu_guai[victim_name] ~= nil then
        if lualib:GetDayInt(killer,"meirirenwu_wanchen_"..renwu_guai[victim_name][1]) == 0 then
            local shuliang = lualib:GetDayInt(killer,"renwu_shaguai_"..renwu_guai[victim_name][1]) + 1
            lualib:SetDayInt(killer, "renwu_shaguai_"..renwu_guai[victim_name][1], shuliang)
            if shuliang >= renwu_guai[victim_name][2] then
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ"..renwu_guai[victim_name][2].."ֻ"..victim_ren_name.."���Ѵ�ɣ���쵽����ʹ�ߴ���ȡ�����ɣ�")
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ"..renwu_guai[victim_name][2].."ֻ"..victim_ren_name.."���Ѵ�ɣ���쵽����ʹ�ߴ���ȡ�����ɣ�")
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ"..renwu_guai[victim_name][2].."ֻ"..victim_ren_name.."���Ѵ�ɣ���쵽����ʹ�ߴ���ȡ�����ɣ�")
                if lualib:HasQuest(killer, 10001) then
                    lualib:ForceQuestReady(killer, 10001)
                    if lualib:GetInt(killer, "AmarkZ") == 0 then
                        Amark_MsgBoxEx(killer, "ÿ�������Ѵ��һ��Ƿ�س���ȡ������", "�ύ����", "һ����˵", 60, "Amark��սBoss", "MoveEx", "", "")
                        lualib:SetInt(killer, "AmarkZ", 1)
                    end
                end
            else
                lualib:SysMsg_SendWarnMsg(killer,"����ɱ"..renwu_guai[victim_name][2].."ֻ"..victim_ren_name.."�����ȣ�"..shuliang.."/"..renwu_guai[victim_name][2].."")
            end
        end
    end
end






-------------------------------------------
--װ����������BUFF
local zhuangbei_buff = {
    ["��������"] = {{"ѣ��1��",2},{"����1��",2},}, --BUFF���֡���������(�ٷֱ�)
    ["����������"] = {{"ѣ��2��",6}, {"����3��",4},},
    ["ʥ������"] = {{"ѣ��3��",8}, {"����4��",6}, },
    ["�������ߡ�������"] = {{"ѣ��3��",10},{"����4��",8},},

}

local item_name_buff = {"�������ߡ�������",}--��������װ����������zhuangbei_buff�������


local skill_t = {--��������[��������] = ������(�����ܿ�Ƭ�Ķ�Ӧ)

    ["����ն"] = "lieyanzhan",
    ["��ɱ����"] = "gongshajianshu",
    ["�ѵ�ն"] = "liedizhan",
    ["��ɱ����"] = "cishajianshu",
    ["˲ն"] = "shunzhan",


    ["�׵���"] = "leidianshu",
    ["��������"] = "bingpaoxiao",
    ["����ħ��"] = "yinjingmohong",
    ["��������"] = "liuxinghuoyu",
    ["��ǽ"] = "huoqiang",
    ["����һ��"] = "zhimingyiji",
    ["�����⻷"] = "hanbingguanghuan",

    ["�����"] = "linghunhuofu",
    ["��Ѫ��"] = "potianyijian",
    ["�ҷ�����"] = "huifeiminmie",
    ["쫷�Ѫ��"] = "jufengxuepo",



}

local site = {--��Ҫ����װ��λ[��Ҫ������ɾ��]
    1,	--����
    2,	--ͷ��
    3,	--����0
    4,	--����1
    5,	--�·�
    --6,	--����[һ������ǲ��ܼ����Ե�,����Ҫ����ȥ��]
    7,	--Ь��
    8,	--����
    9,	--����
    10,	--��ָ0
    11,	--��ָ1
    12,	--ѫ��
    13,	--��ʯ
    14,	--���
    15,	--�ػ�
    16,	--����
    17,	--����
    18,	--ʱװ
    19,	--����
    20,	--����
    21,	--�鱦
}



local fs_skill_item = {"�����1��","�����2��","�����3��","�����4��","�����5��"}

local Amark_Skill_Dps_T = {
    ["ʩ����1��"] = 2,
    ["ʩ����2��"] = 2,
    ["ʩ����3��"] = 2,
    ["ʩ����4��"] = 2,
    ["ʩ����5��"] = 2,

    ["������1��"] = 3,
    ["������2��"] = 3,
    ["������3��"] = 3,
    ["������4��"] = 3,

    ["Ⱥ��������1��"] = 3,
    ["Ⱥ��������2��"] = 3,
    ["Ⱥ��������3��"] = 3,
    ["Ⱥ��������4��"] = 3,
}

function on_pre_spell(player, id, name, x, y, target, key)
    if Amark_Skill_Dps_T[key] ~= nil then
        local Num = lualib:GetInt(player, "AmarkEquipUp_Att"..Amark_Skill_Dps_T[key].."_4")
        if Num > 0 then
            lualib:SetDynamicAttr(player,78,196, Num)
            lualib:DelayCall(player, 650, "kouchusx", "")
        end
        local Bj = lualib:GetInt(player, "AmarkEquipUp_Att"..Amark_Skill_Dps_T[key].."_7") + lualib:GetInt(player, "AmarkEquipUp_Att"..Amark_Skill_Dps_T[key].."__7")
        if lualib:GenRandom(1, 100) > Bj then
        else
            local BjNum = 150 + lualib:GetInt(player, "AmarkEquipUp_Att"..Amark_Skill_Dps_T[key].."_8") + lualib:GetInt(player, "AmarkEquipUp_Att"..Amark_Skill_Dps_T[key].."__8")
            lualib:SetDynamicAttr(player,79,196, BjNum)
            lualib:ShowRoleHPRefEx("", target,0 - 1, 2)
        end
    end
    local baoshi = lualib:Player_GetItemGuid(player,13)
    if baoshi ~= "" then
        skill_item_key = lualib:KeyName(baoshi)
        if skill_item_g[skill_item_key] ~= nil then
            st = string.left(key, 6)
            if skill_item_g[skill_item_key][st] ~= nil then
                lualib:SetDynamicAttr(player,77,196,skill_item_g[skill_item_key][st])
                lualib:DelayCall(player, 650, "kouchusx", "")
            end
        end
    end
    return true
end


local XqScAmarkMonsterT = {
    ["�����ͽ��"] = {100, 1},
}

local EquipUpAttSkill = {
    ["��ɱ����1��"] = 1,
    ["��ɱ����2��"] = 1,
    ["��ɱ����3��"] = 1,
    ["��ɱ����4��"] = 1,
    ["��ɱ����5��"] = 1,

    ["�����䵶1��"] = 2,
    ["�����䵶2��"] = 2,
    ["�����䵶3��"] = 2,
    ["�����䵶4��"] = 2,
    ["�����䵶5��"] = 2,

    ["�һ𽣷�1��"] = 3,
    ["�һ𽣷�2��"] = 3,
    ["�һ𽣷�3��"] = 3,
    ["�һ𽣷�4��"] = 3,
    ["�һ𽣷�6��"] = 3,
    ["�һ𽣷�5��"] = 3,

    ["�׵���1��"] = 2,
    ["�׵���2��"] = 2,
    ["�׵���3��"] = 2,
    ["�׵���4��"] = 2,

    ["������1��"] = 1,
    ["������2��"] = 1,
    ["������3��"] = 1,
    ["������4��"] = 1,

    ["������1��"] = 3,
    ["������2��"] = 3,
    ["������3��"] = 3,
    ["������4��"] = 3,
    ["������5��"] = 3,

    ["�����1��"] = 1,
    ["�����2��"] = 1,
    ["�����3��"] = 1,
    ["�����4��"] = 1,
    ["�����5��"] = 1,
    ["�����6��"] = 1,
}

local skillTb2 = {--���˼���,�ػ�������
    ["ͬ������1"] = {10,10},
    ["ͬ������2"] = {15,15},
    ["ͬ������3"] = {20,20},
    ["ͬ������4"] = {25,25},
}

local rulai = {
    [480] = {"��������1",20},
    [512] = {"��������2",40},
    [513] = {"��������3",60},
    [514] = {"��������4",80},

}

local dadi = {
    [537] = {"��ظ���1",0.2},
    [538] = {"��ظ���2",0.3},
    [539] = {"��ظ���3",0.4},
    [540] = {"��ظ���4",0.5},

}



function on_pre_harm(role, attacker, hp, defense, skill, bj)
    local r = math.random(0,100)
    local skills = lualib:GetAllSkills(attacker)
    local cur_hp = lualib:Hp(attacker, false)  --��ǰHP
    local max_hp = lualib:Hp(attacker, true)  --HP����
    local cur_hp1 = lualib:Hp(role, false)  --�������ߵ�ǰHP
    local max_hp1 = lualib:Hp(role, true)  --��������HP����
    local hp1 = 0
    for i,v in ipairs(skills) do
        local sName = lualib:Id2KeyName(v,17)
        -- ��������
        if string.find(sName,"��������") ~= nil then
            for j,k in pairs(rulai) do
                if j == v and r <= k[2] and skill == k[1] then
                    hp = hp * 1.5
                    lualib:SetIsBrust(attacker,true)
                end
            end
        end
        -- ��ظ���
        if string.find(sName,"��ظ���") ~= nil then
            for j,k in pairs(dadi) do
                if j == v and skill == k[1] then
                    hp1 = hp * k[2]
                    if cur_hp < max_hp then
                        lualib:SetHp(attacker, cur_hp-hp1, false)     --���õ�ǰHP
                        lualib:ShowRoleHPRefEx("",attacker,-hp1,0)
                    else
                        lualib:SetHp(attacker, max_hp, false)     --���õ�ǰHP
                        lualib:ShowRoleHPRefEx("",attacker,-hp1,0)
                    end
                end
            end
        end
    end

    local name = lualib:KeyName(role)
    if string.match(name,"�ػ���") == "�ػ���" then
        local player =  lualib:Name2Guid(lualib:Monster_GetMaster(role))
        for i,v in pairs(skillTb2) do
            if lualib:HasBuff(player,i) then
                hp = math.floor(hp * (1 + (v[2]/100)))
                lualib:SysMsg_SendCenterMsg(0,tostring(hp), attacker)
            end
        end
    end

    if lualib:Monster_IsMonster(role) then
        local MonsterKeyName = lualib:KeyName(role)
        local MonsterName = lualib:Name(role)
        if ShiJieBossT[MonsterKeyName] ~= nil then
            if lualib:Player_IsPlayer(attacker) then
                lualib:SetInt(attacker, "Amark����Boss����", lualib:GetInt(attacker, "Amark����Boss����") + ShiJieBossT[MonsterKeyName][2])
                lualib:SysMsg_SendPromptMsg(attacker, "��á�"..MonsterName.."���֡�"..ShiJieBossT[MonsterKeyName][2].."�㣬���л���"..lualib:GetInt(attacker,"Amark����Boss����").."�㡣")
                return 0 - ShiJieBossT[MonsterKeyName][1]
            else
                local ZrName = lualib:Monster_GetMaster(attacker)
                if ZrName ~= "" then
                    local ZrGuid = lualib:Name2Guid(ZrName)
                    if ZrGuid ~= "" then
                        lualib:SetInt(ZrGuid, "Amark����Boss����", lualib:GetInt(ZrGuid, "Amark����Boss����") + ShiJieBossT[MonsterKeyName][2])
                        lualib:SysMsg_SendPromptMsg(ZrGuid, "��á�"..MonsterName.."���֡�"..ShiJieBossT[MonsterKeyName][2].."�㣬���л���"..lualib:GetInt(ZrGuid, "Amark����Boss����").."�㡣")
                        return 0 - ShiJieBossT[MonsterKeyName][1]
                    end
                end
            end
        end
        if XqScAmarkMonsterT[MonsterKeyName] ~= nil then
            return 0 - XqScAmarkMonsterT[MonsterKeyName][1]
        end
    end

    if lualib:Monster_IsMonster(attacker) then
        local MonsterKeyName = lualib:KeyName(attacker)
        if ShiJieBossT[MonsterKeyName] ~= nil then
            local Hp = lualib:Hp(role, true) / 100 * ShiJieBossT[MonsterKeyName][3]
            return 0 - Hp
        end
        if XqScAmarkMonsterT[MonsterKeyName] ~= nil then
            local Hp = lualib:Hp(role, true) / 100 * XqScAmarkMonsterT[MonsterKeyName][2]
            return 0 - Hp
        end
    end
    if 1 == 1 then
        if lualib:Player_IsPlayer(role) == true and lualib:Player_IsPlayer(attacker) == true then
            local SkillId = lualib:GetInt(role, "Amark_��ǰ����_SkillId")
            local SkillLevel = lualib:GetInt(role, "Amark_��ǰ����_SkillLevel")
            if lualib:GetInt(role, "Amark_Horse_Skill_Id_3") > 0 then
                local TimeCd = {120, 115, 110, 105, 100, 95, 90, 85, 80, 75}
                if lualib:GetInt(role, "Amark_Horse_SKill_Cd_3") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(attacker, "�ĺ���ƽ", 5)
                        lualib:SetInt(role, "Amark_Horse_SKill_Cd_3", lualib:GetAllTime() + TimeCd[lualib:GetInt(role, "Amark_Horse_Skill_Id_3")])
                        lualib:SysMsg_SendPromptMsg(role, "�ɹ��������＼�ܡ��ĺ���ƽ����")
                        lualib:SysMsg_SendPromptMsg(attacker, "���棡���з���"..lualib:Name(role).."�����＼�ܡ��ĺ���ƽ�����У������˺�����20%����5�롣")
                    end
                end
            end
            if lualib:HasBuff(role, "�ĺ���ƽ") then
                hp = math.floor(hp * 0.8)
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_4") > 0 then
                local SkillJv = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_4") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 1000) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_4")] then
                    else
                        lualib:AddBuff(role, "����֮��", 10)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_4", lualib:GetAllTime() + 120)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ�����֮�ˡ���")
                        lualib:SysMsg_SendPromptMsg(role, "���棡���з���"..lualib:Name(attacker).."�����＼�ܡ�����֮�ˡ����У�����+ 10��")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_5") > 0 then
                local SkillJv = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_5") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 1) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_5")] then
                    else
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_5", lualib:GetAllTime() + 150)

                        local Hp = math.floor(lualib:Hp(role, true) * 0.2)
                        lualib:SetHp(role, lualib:Hp(role, false) - Hp, false)
                        lualib:ShowRoleHPRefEx("", role, 0 - Hp, 3)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ�Ц��ص�����")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_6") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_6") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_6")] then
                    else
                        lualib:AddBuff(role, "����ħ��", 5)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_6", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ�����ħ������")
                        lualib:SysMsg_SendPromptMsg(role, "���棡���з���"..lualib:Name(attacker).."�����＼�ܡ�����ħ�������У��ѱ���е��")
                    end
                end
            end
            if lualib:HasBuff(role, "����ħ��") then
                return 0
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_7") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_7") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_7")] then
                    else
                        lualib:AddBuff(attacker, "���֮��", 10)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_7", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ����֮�ס���")
                    end
                end
            end

            if lualib:GetInt(role, "Amark_Horse_Skill_Id_7") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(role, "Amark_Horse_SKill_Cd_7") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(role, "Amark_Horse_Skill_Id_7")] then
                    else
                        lualib:AddBuff(role, "���֮��", 10)
                        lualib:SetInt(role, "Amark_Horse_SKill_Cd_7", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(role, "�ɹ��������＼�ܡ����֮�ס���")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_9") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_9") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(role, "��������", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_9")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_9", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ�������������")
                        lualib:SysMsg_SendPromptMsg(role, "���棡���з���"..lualib:Name(attacker).."�����＼�ܡ���������������,������������")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_10") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuffEx(role, "�Ƽ���", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10")], lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10"))
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_10", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ��Ƽ�������")
                        lualib:SysMsg_SendPromptMsg(role, "���棡���з���"..lualib:Name(attacker).."�����＼�ܡ��Ƽ���������,����������"..lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10").."��,����"..SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10")].."�롣")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_11") > 0 then
                local SkillJv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_11") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuffEx(attacker, "��Ѫ��",10, SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_11")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_11", lualib:GetAllTime() + 300)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ���Ѫ�񹥡���")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_12") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_12") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(attacker, "����֮��", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_12")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_12", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "�ɹ��������＼�ܡ�����֮�С���")
                    end
                end
            end
        end
    end

    if 1 == 1 then
        if lualib:Player_IsPlayer(role) == true and lualib:Player_IsPlayer(attacker) == true then
            local Job = lualib:Job(role)
            if Job == 1 then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att1_1")
                if Num > 0 then
                    --Amark_Msg("��Att_1#"..Job.."����������ҡ�"..lualib:Name(role).."������������ҡ�"..lualib:Name(attacker).."������ֵ��"..Num.."���������˺���"..hp.."���������˺���"..math.floor(hp * Num / 100).."��")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if Job == 2 then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att2_1")
                if Num > 0 then
                    --Amark_Msg("��Att_2#"..Job.."��������ҡ�"..lualib:Name(role).."������������ҡ�"..lualib:Name(attacker).."������ֵ��"..Num.."���������˺���"..hp.."���������˺���"..math.floor(hp * Num / 100).."��")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if Job == 3 then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att3_1")
                if Num > 0 then
                    --Amark_Msg("��Att_3#"..Job.."����������ҡ�"..lualib:Name(role).."������������ҡ�"..lualib:Name(attacker).."������ֵ��"..Num.."���������˺���"..hp.."���������˺���"..math.floor(hp * Num / 100).."��")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if 1 == 1 then
                local JobEx = lualib:Job(attacker)
                local Num = lualib:GetInt(role, "AmarkEquipUp_Att"..JobEx.."_2")
                if Num > 0 then
                    --Amark_Msg("������ְҵ:"..JobEx.."��������ֵ:"..Num.."�������˺�"..hp.."�������˺�"..math.floor(hp * Num / 100).."�������˺�"..(hp - math.floor(hp * Num / 100)))
                    hp = hp - math.floor(hp * Num / 100)
                end
            end
        end
        if lualib:Player_IsPlayer(attacker) then
            local Job = lualib:Job(attacker)
            local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att"..Job.."_5")
            if Num > 0 then
                --Amark_Msg("��ɫ�˺�����:"..Num.."�����빫ʽǰ�˺�"..hp.."���빫ʽ���˺�"..(hp + math.floor(hp * Num / 100)))
                hp = hp + math.floor(hp * Num / 100)
            end
            if EquipUpAttSkill[skill] ~= nil then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."_4")
                if Num > 0 then
                    --Amark_Msg("��ǰ����["..skill.."] ��ֵ:"..Num.."1�������˺�"..hp.."�������˺�"..math.floor(hp * Num / 100))
                    hp = hp + math.floor(hp * Num / 100)
                end

                local Bj = lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."_7") + lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."__7")
                --Amark_Msg(skill.."#"..Bj)
                if Bj > 0 then
                    if lualib:GenRandom(1, 100) > Bj then
                    else
                        local Bjbl = 150 + lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."_8") + lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."__8")
                        local Hp = math.floor(hp * Bjbl / 100)
                        lualib:SetHp(role, lualib:Hp(role, false) + Hp, false)
                        lualib:ShowRoleHPRefEx("", role, 0 + Hp, 2)
                    end
                end
            end
        end
    end

    if lualib:GUIDType(attacker) == 0 then
        local buff_t = {}
        for k,v in pairs(zhuangbei_buff) do
            if lualib:ItemCountEx(attacker,k,2,true,false,false,false) > 0 then
                for k1,v1 in pairs(v) do
                    if lualib:GenRandom(1,100) <= v1[2] then
                        buff_t[#buff_t+1] = v1[1]
                    end
                end
            end
        end

        local tongguo = false
        if lualib:GUIDType(role) == 0 then
            for i = 1,#item_name_buff do
                if lualib:ItemCountEx(role,item_name_buff[i],2,true,false,false,false) > 0 then
                    tongguo = true
                    break
                end
            end
        end

        if tongguo == false then
            for k,v in pairs(buff_t) do
                lualib:AddBuff(role,v,0)
            end
        end

        local pct = 0
        local name = lualib:KeyName2Name(skill, 17)
        if skill_t[name] ~= nil then
            for _, v in ipairs(site) do
                local item = lualib:Player_GetItemGuid(attacker, v)
                if item ~= "" then
                    pct = pct + lualib:GetInt(item, skill_t[name])
                end
            end
        end
        if pct > 0 then
            local newhp = math.ceil((pct / 100) * hp)
            lualib:SysMsg_SendWarnMsg(attacker, "����"..name.."�˺��ӳɣ�"..math.abs(newhp).."��ԭ�˺���"..hp)
            return newhp + hp
        end
    end
    if lualib:Player_IsPlayer(attacker)  then local baoshi = lualib:Player_GetItemGuid(attacker,13) if baoshi ~= "" then skill_item_key = lualib:KeyName(baoshi)
        if skill_item_g[skill_item_key] ~= nil then st = string.left(skill, 6)	if skill_item_g[skill_item_key][st] ~= nil then
            hp = math.floor(hp+(hp*(skill_item_g[skill_item_key][st]/100))) end end end end

    if lualib:Player_IsPlayer(role) then local fsbaoshi = lualib:Player_GetItemGuid(role,13) if fsbaoshi ~= "" then asp = lualib:KeyName(fsbaoshi)
        local a = 0 for i=1,#fs_skill_item do if lualib:HasBuff(role,fs_skill_item[i]) == true then a = 1 break	end  end if a > 0 then
            if skill_item_g[asp] ~= nil then if skill_item_g[asp]["ħ����"] ~= nil then  hp = math.floor(hp-(hp*(skill_item_g[asp]["ħ����"]/100))) end	end end end end

    hp = AmarkPsSkillAttFun(role, attacker, hp, defense, skill, bj)
    local attackerVip = lualib:GetVipLevel(attacker)
    local roleVip = lualib:GetVipLevel(role)


    if attackerVip > 0 then
        hp = hp * sponsor[attackerVip][1]
    end

    if roleVip > 0 then
        hp = math.floor(hp-(sponsor[roleVip][1]*defense))
    end

    return hp
end

function on_post_equip(player, item)

    local key =  lualib:KeyName(item)
    if skill_item_g[key] ~= nil then
        lualib:SetInt(item,"lbjob",lualib:Job(player))
        lualib:Item_NotifyUpdate(player, item)
    end


    if lualib:LuckCurse(player) >= 9 and lualib:Equip_GetLuckCurse("", item) > 0 then
        lualib:SysPromptMsg(player, "��ȫ������+9���Ѵ�����������")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:Name(player).."��ȫ��װ�������Ѵ�+"..lualib:LuckCurse(player).."�Ѵ���������߹���","��Σ�����")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:Name(player).."��ȫ��װ�������Ѵ�+"..lualib:LuckCurse(player).."�Ѵ���������߹���","��Σ�����")
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:Name(player).."��ȫ��װ�������Ѵ�+"..lualib:LuckCurse(player).."�Ѵ���������߹���","��Σ�����")
    end

    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--�洢�������а�
    end
    lualib:Player_RunScript(player, "Amark��ɫ���Ի���:Amark_CountEquipAtt", "")
end

function on_post_un_equip(player, item,id,key)

    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--�洢�������а�
    end
    lualib:Player_RunScript(player, "Amark��ɫ���Ի���:Amark_CountEquipAtt", "")
    lualib:SetStr(item, "AmarkEquipUpInof", "")
    lualib:NotifyVar(item, "AmarkEquipUpInof")
end

local tilizj ={
    ["��Ұ��"] = 1,
    ["��Ұ��"] = 2,
}


function on_post_monster_die(monster, killer)
    MonsterInitExEx(monster)
    local name = lualib:Name(monster)
    if tilizj[name] ~= nil  then
        if lualib:Player_IsPlayer(killer) then
            lualib:SetInt(killer,"tilizhi",lualib:GetInt(killer,"tilizhi")+tilizj[name])
        else
            player_name = lualib:Monster_GetMaster(killer)
            if player_name ~= "" then
                player = lualib:Name2Guid(player_name)
                if player ~= "" then
                    lualib:SetInt(player,"tilizhi",lualib:GetInt(player,"tilizhi")+tilizj[name])
                end
            end
        end
    end
end

local dropJiuBiNums_1 = 1000 --1�ñ�����/��
local dropJiuBiNums_10 = 500 --10�ñ�����/��
local dropJiuBiRandom_1 = 33 --1�ñҵ��伸�� ����10000
local dropJiuBiRandom_10 = 10 --10�ñҵ��伸�� ����10000
function on_pre_drop_one(map,player,item,itemid)
    local keyname = lualib:KeyName(item)
    local day = lualib:GetAllDays(0)
    --lualib:SysMsg_SendBroadcastMsg(tostring(day), "day")
    if lualib:GetDBNum("dropDay") == 0 then
        lualib:SetDBNumEx("dropDay",day,6)
        lualib:SetDBNumEx("dropJiuBiNums_1",dropJiuBiNums_1,6)
        lualib:SetDBNumEx("dropJiuBiNums_10",dropJiuBiNums_10,6)
    end
    if day - lualib:GetDBNum("dropDay") > 0 then
        lualib:SetDBNumEx("dropJiuBiNums_1",dropJiuBiNums_1,6)
        lualib:SetDBNumEx("dropJiuBiNums_10",dropJiuBiNums_10,6)
        lualib:SetDBNumEx("dropDay",day,6)
    end
    local num1 = lualib:GetDBNum("dropJiuBiNums_1")
    local num10 = lualib:GetDBNum("dropJiuBiNums_10")
    local rnd1 = lualib:GenRandom(1,10000)
    local rnd10 = lualib:GenRandom(1,10000)
    --lualib:SysMsg_SendBroadcastMsg(tostring(rnd1), "rnd1")
    --lualib:SysMsg_SendBroadcastMsg(tostring(rnd10), "rnd10")
    if keyname == "����ȯ1" then
        if rnd1 <= dropJiuBiRandom_1 then
            if num1 > 0 then
                lualib:SetDBNumEx("dropJiuBiNums_1",num1-1,6)
                return true
            else
                return false
            end
        else
            return false
        end
    elseif keyname == "����ȯ10" then
        if rnd10 <= dropJiuBiRandom_10 then
            if num10 > 0 then
                lualib:SetDBNumEx("dropJiuBiNums_10",num10-1,6)
                return true
            else
                return false
            end
        else
            return false
        end
    end
    return true
end