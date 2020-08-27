local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("include/攻城战玩法")
require("system/触发#拾取回调")
--require("system/充值礼包")
require("system/horse")
require("system/marry")
require("system/master")
require("system/征服系统")
--require("system/奇遇系统")
require("system/装备加BUFF")
--require("system/装备对技能加成")
require("system/设置行会人数")
--require("npc/沙巴克武器升级")
require("system/英雄榜")
require("form/VIP表单")
require("form/新首充礼包表单")
require("form/充值表单")
require("form/微信礼包")
require("form/新激活码礼包表单")
require("item/发送消息")
require("form/开光大师")
require("form/在线奖励")
require("form/特戒")
require("form/新排行榜")
require("form/Amark游戏攻略")
require("form/Amark活跃使者")
require("form/Amark挑战Boss")
require("system/Amark佩饰特技Data")
require("form/Amark兑换大使")
require("system/Amark郑总需要的刷怪")
require("system/Amark测试奖励")
require("form/Amark装备穿戴引导")
require("system/Amark客户端弹窗")
require("form/Amark充值礼包")

function on_system_start()
    lualib:AddTrigger("0", lua_trigger_item_appear, "on_item_appear");					--物品出现在地图上回调
    lualib:AddTrigger("0", lua_trigger_item_disappear, "on_item_disappear");			--物品在地图上消失回调
    if lualib:GetDBNum("map_lock") == 0 then
        lualib:AddTimer("0", 10218, 1000, -1, "send_system_msg")
    end
    lualib:AddTrigger("0",  lua_trigger_post_drop_one , "on_post_drop_one")
    lualib:AddTrigger("0",  lua_trigger_pre_enter_jump, "on_pre_jump")
    lualib:DelayCall("0", 1, "定时刷怪系统:check", "");
    lualib:AddTrigger("", lua_trigger_login, "on_player_login");
    lualib:AddTrigger("", lua_trigger_add_exp, "on_player_add_exp");		   --经验增加时
    lualib:AddTrigger("", lua_trigger_logout, "on_player_logout");
    lualib:DelayCall("", 1, "OnFirstCastleWar", "");		                   --第一次攻城战
    lualib:AddTrigger("0",  lua_trigger_billin, "on_trigger_billin")                   --充值回调
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")			   --升级触发
    lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")				   --反外挂触发
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start")       --攻城开始
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end")           --攻城结束
    lualib:AddTrigger("0",  lua_trigger_player_relive, "on_player_relive")             --复活时回调
    lualib:AddTrigger("0",  lua_trigger_post_die, "on_post_die")                       --死亡时回调
    lualib:DelayCall("0", 1, "幸运的小猪:check", "")
    lualib:DelayCall("0", 1, "猪的传送门:check", "")
    lualib:AddTrigger("0",  lua_trigger_attack_ex, "on_attack_ex")  --受攻击触发
    lualib:AddTrigger("0",  lua_trigger_post_equip, "chuandaiqian")
    lualib:AddTrigger("0",  lua_trigger_post_un_equip, "tuozhuangbei")
    lualib:AddTrigger("0", lua_trigger_hack_check, "on_hack_check");
    lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2");
    lualib:AddTrigger("0", lua_trigger_pre_process_pk, "on_pre_process_pk");
    lualib:AddTrigger("0", lua_trigger_pre_stall_buy, "on_pre_stall_buy")		--摆摊物品购买触发
    lualib:AddTrigger("",  lua_trigger_pre_die, "pre_player_die") --死亡前
    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die")	   --怪物死亡回调
    lualib:AddTrigger("0",  363, "on_ride_request")                                    --上马触发
    lualib:AddTrigger("0",  364, "on_unride_request")                                  --下马触发
    lualib:AddTrigger("0", lua_trigger_post_equip, "on_post_equip")
    lualib:AddTrigger("0", 304, "on_post_un_equip") 	                           --脱装备触发
    lualib:AddTrigger("0", lua_trigger_role_pre_harm, "on_pre_harm")
    lualib:AddTrigger("0", lua_trigger_family_ntf, "on_family_ntf")
    lualib:AddTrigger("0", lua_trigger_kill, "on_trigger_kill")
    lualib:AddTrigger("0",  lua_trigger_post_drop_one, "post_drop_one")
    lualib:AddTrigger("0",  lua_trigger_pre_logout, "on_pre_logout")  --离线挂机触发器
    lualib:AddTrigger("0",  lua_trigger_pre_stall, "on_pre_stall")--摆摊触发
    lualib:AddTrigger("0",  lua_trigger_catch, "on_catch")--宝宝触发
    lualib:AddTrigger("0", lua_trigger_item_pickup, "on_item_pickup")		         	--拾取东西之后回调
    lualib:AddTrigger("0", lua_trigger_pre_item_pickup, "on_pre_item_pickup")			--拾取东西之前回调
    lualib:AddTrigger("0",  lua_trigger_pre_spell, "on_pre_spell")--释放技能前触发
    lualib:AddTrigger("0", lua_trigger_spell, "on_spell")--释放技能后触发
    --类型值=333 类型名=爆某个具体物品之前回调.
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
        lualib:DelayCall("0",1,"三国表单:updateList","")
    end
end

function on_item_pickup(player, item, itemid, itemkeyname)
    AmarkEquipYd(player, item)
end

function on_pre_item_pickup(player, Item, ItemId, ItemKeyName)
    if lualib:GetInt(Item, "拾取冷却") > 0 then
        if lualib:GetAllTime() < lualib:GetInt(Item, "拾取冷却") then
            lualib:SysMsg_SendPromptMsg(player, "该物品暂时无法拾取，["..((lualib:GetInt(Item, "拾取冷却") - lualib:GetAllTime()) * -1).."]秒后恢复拾取。")
            return false
        end
    end
    return true
end




local dl_item_table = {["圣魔护腕"] = 1,["圣魔之翼"] = 1,["圣魔守护"] = 1,["圣魔宝石"] = 1,["圣魔腰带"] = 1,["圣魔勋章"] = 1,["圣魔靴子"] = 1,["圣魔戒指"] = 1,["圣魔项链"] = 1,["圣魔头盔"] = 1,["圣魔法袍(女)"] = 1,["圣魔法袍(男)"] = 1,["镇天"] = 1,["战神头盔"] = 1,["战神勋章"] = 1,["战神守护"] = 1,["战神之翼"] = 1,["战神腰带"] = 1,["战神项链"] = 1,["战神战甲(女)"] = 1,["战神战甲(男)"] = 1,["战神手镯"] = 1,["战神圣靴"] = 1,["战神戒指"] = 1,["战神宝石"] = 1,["开天"] = 1,["真魂守护"] = 1,["真魂之翼"] = 1,["真魂勋章"] = 1,["真魂头盔"] = 1,["真魂道衣(女)"] = 1,["真魂腰带"] = 1,["真魂项链"] = 1,["真魂手镯"] = 1,["真魂戒指"] = 1,["真魂宝石"] = 1,["真魂道衣(男)"] = 1,["真魂道靴"] = 1,["玄天"] = 1,["烈焰勋章"] = 1,["烈焰腰带"] = 1,["烈焰之翼"] = 1,["烈焰守护"] = 1,["烈焰头盔"] = 1,["烈焰项链"] = 1,["烈焰靴子"] = 1,["烈焰魔衣(女)"] = 1,["烈焰魔衣(男)"] = 1,["烈焰护腕"] = 1,["烈焰宝石"] = 1,["烈焰戒指"] = 1,["嗜魂法杖"] = 1,["光芒勋章"] = 1,["光芒头盔"] = 1,["光芒守护"] = 1,["光芒宝石"] = 1,["光芒之翼"] = 1,["光芒道袍(女)"] = 1,["光芒道袍(男)"] = 1,["光芒腰带"] = 1,["光芒靴子"] = 1,["光芒戒指"] = 1,["光芒护腕"] = 1,["光芒项链"] = 1,["逍遥扇"] = 1,["雷霆头盔"] = 1,["雷霆之翼"] = 1,["雷霆守护"] = 1,["雷霆宝石"] = 1,["雷霆腰带"] = 1,["雷霆勋章"] = 1,["雷霆战靴"] = 1,["雷霆战甲(女)"] = 1,["雷霆战甲(男)"] = 1,["雷霆战戒"] = 1,["雷霆项链"] = 1,["雷霆护腕"] = 1,["怒斩"] = 1,["强化战神战甲(女)"] = 1,["强化战神战甲(男)"] = 1,["强化战神靴子"] = 1,["强化战神项链"] = 1,["强化战神护腕"] = 1,["强化战神戒指"] = 1,["强化战神勋章"] = 1,["强化战神腰带"] = 1,["强化战神头盔"] = 1,["强化战神之翼"] = 1,["强化战神守护"] = 1,["强化战神宝石"] = 1,["强化开天"] = 1,["强化圣魔之翼"] = 1,["强化圣魔法袍(女)"] = 1,["强化圣魔法袍(男)"] = 1,["强化圣魔靴子"] = 1,["强化圣魔项链"] = 1,["强化圣魔护腕"] = 1,["强化圣魔戒指"] = 1,["强化圣魔勋章"] = 1,["强化圣魔腰带"] = 1,["强化圣魔头盔"] = 1,["强化圣魔守护"] = 1,["强化圣魔宝石"] = 1,["强化镇天"] = 1,["强化真魂道衣(女)"] = 1,["强化真魂道衣(男)"] = 1,["强化真魂靴子"] = 1,["强化真魂项链"] = 1,["强化真魂护腕"] = 1,["强化真魂戒指"] = 1,["强化真魂勋章"] = 1,["强化真魂腰带"] = 1,["强化真魂头盔"] = 1,["强化真魂之翼"] = 1,["强化真魂守护"] = 1,["强化真魂宝石"] = 1,["强化玄天"] = 1,["战龍神剑★精[封印]"] = 1,["战龍战甲★精[封印]"] = 1,["战龍靴子★精[封印]"] = 1,["战龍项链★精[封印]"] = 1,["战龍手腕★精[封印]"] = 1,["战龍戒指★精[封印]"] = 1,["战龍勋章★精[封印]"] = 1,["战龍腰带★精[封印]"] = 1,["战龍头盔★精[封印]"] = 1,["战龍之翼★精[封印]"] = 1,["战龍守护★精[封印]"] = 1,["战龍宝石★精[封印]"] = 1,["战龍战衣★精[封印]"] = 1,["火龍魔衣★精[封印]"] = 1,["火龍魔衣★精[封印]"] = 1,["火龍魔盔★精[封印]"] = 1,["火龍宝石★精[封印]"] = 1,["火龍守护★精[封印]"] = 1,["火龍之翼★精[封印]"] = 1,["火龍魔带★精[封印]"] = 1,["火龍勋章★精[封印]"] = 1,["火龍魔戒★精[封印]"] = 1,["火龍护腕★精[封印]"] = 1,["火龍魔链★精[封印]"] = 1,["火龍靴子★精[封印]"] = 1,["火龍魔甲★精[封印]"] = 1,["火龍魔杖★精[封印]"] = 1,["青龍道衣★精[封印]"] = 1,["青龍守护★精[封印]"] = 1,["青龍宝石★精[封印]"] = 1,["青龍之翼★精[封印]"] = 1,["青龍道盔★精[封印]"] = 1,["青龍道带★精[封印]"] = 1,["青龍勋章★精[封印]"] = 1,["青龍道戒★精[封印]"] = 1,["青龍道腕★精[封印]"] = 1,["青龍道链★精[封印]"] = 1,["青龍道靴★精[封印]"] = 1,["青龍道甲★精[封印]"] = 1,["青龍道剑★精[封印]"] = 1,["战龍战衣★精"] = 1,["战龍宝石★精"] = 1,["战龍守护★精"] = 1,["战龍之翼★精"] = 1,["999朵玫瑰花"] = 1,["战龍头盔★精"] = 1,["战龍腰带★精"] = 1,["战龍勋章★精"] = 1,["战龍戒指★精"] = 1,["战龍手腕★精"] = 1,["战龍项链★精"] = 1,["战龍靴子★精"] = 1,["战龍战甲★精"] = 1,["战龍神剑★精"] = 1,["火龍魔衣★精"] = 1,["火龍魔盔★精"] = 1,["火龍宝石★精"] = 1,["火龍守护★精"] = 1,["火龍之翼★精"] = 1,["火龍魔带★精"] = 1,["火龍勋章★精"] = 1,["火龍魔戒★精"] = 1,["火龍护腕★精"] = 1,["火龍魔链★精"] = 1,["青龍道衣★精"] = 1,["青龍守护★精"] = 1,["青龍宝石★精"] = 1,["青龍之翼★精"] = 1,["青龍道盔★精"] = 1,["青龍道带★精"] = 1,["青龍勋章★精"] = 1,["青龍道戒★精"] = 1,["青龍道腕★精"] = 1,["火龍魔链★精"] = 1,["青龍道链★精"] = 1,["火龍靴子★精"] = 1,["青龍道靴★精"] = 1,["火龍魔甲★精"] = 1,["青龍道甲★精"] = 1,["火龍魔杖★精"] = 1,["青龍道剑★精"] = 1,["战龍神衣"] = 1,["火龍魔衣"] = 1,["青龍道衣"] = 1,["战龍宝石"] = 1,["火龍头盔"] = 1,["青龍守护"] = 1,["战龍守护"] = 1,["火龍守护"] = 1,["青龍之翼"] = 1,["战龍头盔"] = 1,["火龍之翼"] = 1,["青龍道盔"] = 1,["战龍腰佩"] = 1,["火龍腰佩"] = 1,["青龍道带"] = 1,["战龍勋章"] = 1,["火龍勋章"] = 1,["青龍道章"] = 1,["战龍戒指"] = 1,["火龍戒指"] = 1,["青龍道戒"] = 1,["战龍护腕"] = 1,["火龍护腕"] = 1,["青龍道腕"] = 1,["战龍项链"] = 1,["火龍项链"] = 1,["青龍道链"] = 1,["战龍靴子"] = 1,["火龍靴子"] = 1,["青龍道靴"] = 1,["战龍神甲"] = 1,["火龍魔甲"] = 1,["青龍道甲"] = 1,["战龍神剑"] = 1,["火龍魔剑"] = 1,["青龍神剑"] = 1,["天罡地煞盾"] = 1,["天罡地煞盾Lv3"] = 1,["天罡地煞盾Lv2"] = 1,["天罡地煞盾Lv1"] = 1,["天罡地煞盾Lv4"] = 1,["天罡地煞盾Lv5"] = 1,["天罡地煞盾Lv6"] = 1,["天罡地煞盾Lv7"] = 1,["天罡地煞盾Lv8"] = 1,["4级灵魂火符"] = 1,["4级魔法盾"] = 1,["通幽之术"] = 1,["4级烈火剑法"] = 1,["4级灵魂火符"] = 1,["陨星灭世"] = 1,["开天斩"] = 1,	["噬血术"] = 1,["玄武石"] = 1,["麒麟石(完美)"] = 1,["麒麟石(史诗)"] = 1,["麒麟石"] = 1,["玄武石(完美)"] = 1,["玄武石(史诗)"] = 1,["朱雀石(完美)"] = 1,["朱雀石(史诗)"] = 1,["朱雀石"] = 1,["白虎石(完美)"] = 1,["白虎石(史诗)"] = 1,["白虎石"] = 1,["青龙石(完美)"] = 1,["青龙石(史诗)"] = 1,["青龙石"] = 1,["猎豹"] = 1,["黑豹"] = 1,["黄色狮鹫"] = 1,["蓝色狮鹫"] = 1,["骨龙"] = 1,["九尾火狐"] = 1,["九尾冰狐"] = 1,["冰龙"] = 1,["火龙"] = 1,["仙尊护卫者【超凡】"] = 1,["武神护卫者"] = 1,["圣尊护卫者"] = 1,["帝王护卫者"] = 1,["金戈神斩★[神器]"] = 1,}



function post_drop_one(map, player, item, item_id)

    if lualib:Player_IsPlayer(player) and dl_item_table[lualib:Name(item)] == 1 then
        lualib:SysMsg_SendBroadcastColor("物品【"..lualib:Name(item).."】从玩家【"..lualib:Name(player).."】身上掉落在地图【"..lualib:Name(map).."】坐标（"..lualib:X(player).."，"..lualib:Y(player).."）处！", "", 7, 3)
    end
    return true

end



local skills = {
    ["神武使者卍终极"] = "召唤月灵4级",
}

local skill_item_g = {
    ["神武使者LV1"] = {
        ["烈火剑"] = 1,
        ["半月弯"] = 1,
        ["刺杀剑"] = 1,
        ["雷电术"] = 1,
        ["冰咆哮"] = 1,
        ["灵魂火"] = 1,
        ["魔法盾"] = 1,
        ["施毒术"]	= 1,
        ["幽灵盾"]	= 1,
        ["神圣战"]	= 1,
    },
    ["神武使者LV2"] = {
        ["烈火剑"] = 2,
        ["半月弯"] = 2,
        ["刺杀剑"] = 2,
        ["雷电术"] = 2,
        ["冰咆哮"] = 2,
        ["灵魂火"] = 2,
        ["魔法盾"] = 2,
        ["施毒术"]	= 2,
        ["幽灵盾"]	= 2,
        ["神圣战"]	= 2,
    },
    ["神武使者LV3"] = {
        ["烈火剑"] = 3,
        ["半月弯"] = 3,
        ["刺杀剑"] = 3,
        ["雷电术"] = 3,
        ["冰咆哮"] = 3,
        ["灵魂火"] = 3,
        ["魔法盾"] = 3,
        ["施毒术"]	= 3,
        ["幽灵盾"]	= 3,
        ["神圣战"]	= 3,
    },
    ["神武使者LV4"] = {
        ["烈火剑"] = 4,
        ["半月弯"] = 4,
        ["刺杀剑"] = 4,
        ["雷电术"] = 4,
        ["冰咆哮"] = 4,
        ["灵魂火"] = 4,
        ["魔法盾"] = 4,
        ["施毒术"]	= 4,
        ["幽灵盾"]	= 4,
        ["神圣战"]	= 4,
    },
    ["神武使者LV5"] = {
        ["烈火剑"] = 5,
        ["半月弯"] = 5,
        ["刺杀剑"] = 5,
        ["雷电术"] = 5,
        ["冰咆哮"] = 5,
        ["灵魂火"] = 5,
        ["魔法盾"] = 5,
        ["施毒术"]	= 5,
        ["幽灵盾"]	= 5,
        ["神圣战"]	= 5,
    },
    ["神武使者LV6"] = {
        ["烈火剑"] = 6,
        ["半月弯"] = 6,
        ["刺杀剑"] = 6,
        ["雷电术"] = 6,
        ["冰咆哮"] = 6,
        ["灵魂火"] = 6,
        ["魔法盾"] = 6,
        ["施毒术"]	= 6,
        ["幽灵盾"]	= 6,
        ["神圣战"]	= 6,
    },
    ["神武使者LV7"] = {
        ["烈火剑"] = 7,
        ["半月弯"] = 7,
        ["刺杀剑"] = 7,
        ["雷电术"] = 7,
        ["冰咆哮"] = 7,
        ["灵魂火"] = 7,
        ["施毒术"]	= 7,
        ["幽灵盾"]	= 7,
        ["神圣战"]	= 7,
    },
    ["神武使者LV8"] = {
        ["烈火剑"] = 8,
        ["半月弯"] = 8,
        ["刺杀剑"] = 8,
        ["雷电术"] = 8,
        ["冰咆哮"] = 8,
        ["灵魂火"] = 8,
        ["魔法盾"] = 8,
        ["施毒术"]	= 8,
        ["幽灵盾"]	= 8,
        ["神圣战"]	= 8,
    },
    ["神武使者LV9"] = {
        ["烈火剑"] = 9,
        ["半月弯"] = 9,
        ["刺杀剑"] = 9,
        ["雷电术"] = 9,
        ["冰咆哮"] = 9,
        ["灵魂火"] = 9,
        ["魔法盾"] = 9,
        ["施毒术"]	= 9,
        ["幽灵盾"]	= 9,
        ["神圣战"]	= 9,
    },
    ["神武使者LV10"] = {
        ["烈火剑"] = 10,
        ["半月弯"] = 10,
        ["刺杀剑"] = 10,
        ["雷电术"] = 10,
        ["冰咆哮"] = 10,
        ["灵魂火"] = 10,
        ["魔法盾"] = 10,
        ["施毒术"]	= 10,
        ["幽灵盾"]	= 10,
        ["神圣战"]	= 10,
    },
    ["神武使者LV11"] = {
        ["烈火剑"] = 11,
        ["半月弯"] = 11,
        ["刺杀剑"] = 11,
        ["雷电术"] = 11,
        ["冰咆哮"] = 11,
        ["灵魂火"] = 11,
        ["魔法盾"] = 11,
        ["施毒术"]	= 11,
        ["幽灵盾"]	= 11,
        ["神圣战"]	= 11,
    },
    ["神武使者卍终极"] = {
        ["烈火剑"] = 15,
        ["半月弯"] = 15,
        ["刺杀剑"] = 15,
        ["雷电术"] = 15,
        ["冰咆哮"] = 15,
        ["灵魂火"] = 15,
        ["魔法盾"] = 15,
        ["施毒术"]	= 15,
        ["幽灵盾"]	= 15,
        ["神圣战"]	= 15,
    },
}

local item_miao = { --jilv=触发机率， miao=秒血量百分比（1为100%），mubiao=(0对人物有效,1对怪物有效,2对人怪有效)
    {item_name={"青龙石","玄武石","朱雀石","麒麟石","白虎石"},jilv = 5, miao = 0.05, mubiao = 1,},
    {item_name={"青龙石(史诗)","玄武石(史诗)","朱雀石(史诗)","麒麟石(史诗)","白虎石(史诗)"},jilv = 10, miao = 0.08, mubiao = 1,},
    {item_name={"青龙石(完美)","玄武石(完美)","朱雀石(完美)","麒麟石(完美)","白虎石(完美)"},jilv = 15, miao = 0.15, mubiao = 1,},
}



local pklvlimit = 10--相差多少级不增加PK值

local distace = {1, 6, "经验倍数"}--最高等级必须大于多少级，相差几级，就给予BUFF(做个独立的分组)


local baobao_t = {6*3600, 12*3600}--宝宝判断时间 + 死亡时间(单位秒)

local ServerNewtime = "2015-05-04 09:00:00"                 ---最新引擎版本号(预设)
local Servertime = lualib:GetGSVer()                       ---当前引擎版本号(至少更新到支持GetGSVer接口的版本)
local ServerNewtime_int = lualib:Str2Time(ServerNewtime)   ---最新引擎版本号(预设)---数值型
local Servertime_int = lualib:Str2Time(Servertime)         ---当前引擎版本号(至少更新到支持GetGSVer接口的版本)---数值型

local StartServerTime = lualib:GetConstVar("StartServerTime")
local StartServerTime_int = lualib:Str2Time(StartServerTime)   ---常量表正式开区时间

local md5_list = {
    "A9B3E76445BDA32665B362618D40FD19", --此处为游戏安全信息查看工具中，疑似外挂的md5码
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
    "6776DBF11354EB0F99FFB6232269F1A8",	----更新至430外挂版本的MD5，希望大家多共享最新MD5！
}

local petskill = {--释放技能需要移除玩家宝宝(注意是技能索引名) = 1
    ["神兽（兽化印）"] = 1,

}


local tz_map = {--地图索引名 = 开启时间（距离开区时间单位秒）
    ["担保地图"] = 18000,
    ["担保地图"] = 18000,
}

local ss_msg = {
    --[1295700] = {"赤月深层，牛魔寺庙大厅还有5分钟开启，请大家做好准备！", false},
    --[1296000] = {"赤月深层，牛魔寺庙大厅已经开启，冰封网络祝大家游戏愉快！", false},
    --[1295700] = {"赤月深层，牛魔寺庙大厅还有5分钟开启，请大家做好准备！", false},
    --[1296000] = {"赤月深层，牛魔寺庙大厅已经开启，冰封网络祝大家游戏愉快！", true},
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
            local str = string.format("%d分%d秒", second / 60, second % 60)
            lualib:SysTriggerMsg(player, "当前地图还有"..str.."开放，请注意系统公告！")
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
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "【系统】")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "【系统】")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "【系统】")
        lualib:SysMsg_SendBroadcastMsg(ss_msg[dis][1], "【系统】")
        if ss_msg[dis][2] then
            lualib:DisableTimer(obj, id)
            lualib:SetDBNumEx("map_lock", 1, 2)
        end
    end
end

local AmarkItemTsT = {
    ["绿色项链"] = 1,
    ["恶魔铃铛"] = 1,
    ["灵魂项链"] = 1,
    ["骑士手镯"] = 1,
    ["龙之手镯"] = 1,
    ["三眼手镯"] = 1,
    ["力量戒指"] = 1,
    ["紫碧螺"] = 1,
    ["泰坦戒指"] = 1,
    ["黑铁头盔"] = 1,
    ["圣战头盔"] = 1,
    ["法神头盔"] = 1,
    ["天尊头盔"] = 1,
    ["圣战项链"] = 1,
    ["法神项链"] = 1,
    ["天尊项链"] = 1,
    ["圣战手镯"] = 1,
    ["法神手镯"] = 1,
    ["天尊手镯"] = 1,
    ["圣战戒指"] = 1,
    ["法神戒指"] = 1,
    ["天尊戒指"] = 1,
    ["魔血项链"] = 1,
    ["魔血手镯"] = 1,
    ["魔血戒指"] = 1,
    ["记忆头盔"] = 1,
    ["记忆项链"] = 1,
    ["记忆手镯"] = 1,
    ["记忆戒指"] = 1,
    ["祈祷头盔"] = 1,
    ["祈祷项链"] = 1,
    ["祈祷手镯"] = 1,
    ["祈祷戒指"] = 1,
    ["虹魔项链"] = 1,
    ["虹魔手镯"] = 1,
    ["虹魔戒指"] = 1,
    ["虹魔勋章"] = 1,
    ["虹魔腰带"] = 1,
    ["虹魔靴子"] = 1,
    ["狂风项链"] = 1,
    ["狂风戒指"] = 1,
    ["神秘头盔"] = 1,
    ["神秘项链"] = 1,
    ["神秘戒指"] = 1,
    ["法杖"] = 1,
    ["血饮"] = 1,
    ["骨玉权杖"] = 1,
    ["龙牙"] = 1,
    ["嗜魂法杖"] = 1,
    ["银蛇"] = 1,
    ["无极棍"] = 1,
    ["龙纹剑"] = 1,
    ["逍遥扇"] = 1,
    ["炼狱"] = 1,
    ["井中月"] = 1,
    ["裁决之杖"] = 1,
    ["怒斩"] = 1,
    ["屠龙"] = 1,
    ["屠龙2"] = 1,
    ["屠龙3"] = 1,
    ["命运之刃"] = 1,
    ["命运之刃战25"] = 1,
    ["命运之刃战30"] = 1,
    ["命运之刃战35"] = 1,
    ["命运之刃战40"] = 1,
    ["命运之刃战45"] = 1,
    ["命运之刃法25"] = 1,
    ["命运之刃法30"] = 1,
    ["命运之刃法35"] = 1,
    ["命运之刃法40"] = 1,
    ["命运之刃法45"] = 1,
    ["命运之刃道25"] = 1,
    ["命运之刃道30"] = 1,
    ["命运之刃道35"] = 1,
    ["命运之刃道40"] = 1,
    ["命运之刃道45"] = 1,
    ["祈祷之刃"] = 1,
    ["破损的霸者之刃"] = 1,
    ["破损的怒斩"] = 1,
    ["破损的龍牙"] = 1,
    ["破损的嗜魂法杖"] = 1,
    ["破损的龙纹"] = 1,
    ["破损的逍遥扇"] = 1,
    ["破损的裁决"] = 1,
    ["破损的屠龙"] = 1,
    ["破损的骨玉权杖"] = 1,
    ["战神盔甲(男)"] = 1,
    ["战神盔甲(女)"] = 1,
    ["恶魔长袍(男)"] = 1,
    ["恶魔长袍(女)"] = 1,
    ["幽灵战衣(男)"] = 1,
    ["幽灵战衣(女)"] = 1,
    ["法神披风"] = 1,
    ["霓裳羽衣"] = 1,
    ["天魔神甲"] = 1,
    ["圣战宝甲"] = 1,
    ["天尊道袍"] = 1,
    ["天师长袍"] = 1,
}


local ShiJieBossT = {
    ["世界BOSS1"] = {1000, 1, 3},
    ["世界BOSS2"] = {1000, 1, 3},
    ["世界BOSS3"] = {1000, 1, 3},
    ["世界BOSS4"] = {1000, 1, 3},
    ["世界BOSS5"] = {1000, 1, 3},
    ["世界BOSS6"] = {1000, 1, 3},
    ["世界BOSS7"] = {1000, 1, 3},
}

function on_post_drop_one(map, player, item, id)
    if lualib:Monster_IsMonster(player) then
        if ShiJieBossT[lualib:Name(player)] ~= nil then
            lualib:SetInt(item, "拾取冷却", lualib:GetAllTime() + 180)
        end
    end
    local KeyName = lualib:KeyName(item)
    if AmarkItemTsT[KeyName] ~= nil then
        local item_role = lualib:ItemRole(item)
        local player_name = lualib:Name(item_role)
        if player_name == "" then
            local s = "【"..lualib:Name(item).."】掉落在"..lualib:Name(map).."["..lualib:X(item)..":"..lualib:Y(item).."]！"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        else
            local s = "【"..player_name.."】在"..lualib:Name(map).."击杀"..lualib:Name(player).."爆出了【"..lualib:Name(item).."】！"
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
            lualib:DelBuff(target_Guid,"天下第一战士")
        end
        lualib:SetDBStr("na11","")
    end

    local djph_table2 = {}
    local djph_str2 = lualib:GetDBStr("na12")
    if djph_str2 ~= "" then
        djph_table2 = json.decode(djph_str2)
        target_Guid = lualib:Name2Guid(djph_table2[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"天下第一战士")
        end
        lualib:SetDBStr("na12","")
    end

    local djph_table3 = {}
    local djph_str3 = lualib:GetDBStr("na21")
    if djph_str3 ~= "" then
        djph_table3 = json.decode(djph_str3)
        target_Guid = lualib:Name2Guid(djph_table3[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"天下第一法师")
        end
        lualib:SetDBStr("na21","")
    end

    local djph_table4 = {}
    local djph_str4 = lualib:GetDBStr("na22")
    if djph_str4 ~= "" then
        djph_table4 = json.decode(djph_str4)
        target_Guid = lualib:Name2Guid(djph_table4[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"天下第一法师")
        end
        lualib:SetDBStr("na22","")
    end

    local djph_table5 = {}
    local djph_str5 = lualib:GetDBStr("na31")
    if djph_str5 ~= "" then
        djph_table5 = json.decode(djph_str5)
        target_Guid = lualib:Name2Guid(djph_table5[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"天下第一道士")
        end
        lualib:SetDBStr("na31","")
    end

    local djph_table6 = {}
    local djph_str6 = lualib:GetDBStr("na32")
    if djph_str6 ~= "" then
        djph_table6 = json.decode(djph_str6)
        target_Guid = lualib:Name2Guid(djph_table6[1])
        if target_Guid ~= "" then
            lualib:DelBuff(target_Guid,"天下第一道士")
        end
        lualib:SetDBStr("na32","")
    end
    lualib:SysMsg_SendBroadcastColor("系统提示:天下第一职业排行已清空,新的一轮已开启", "", 2, 13)
    lualib:SysMsg_SendBroadcastColor("系统提示:天下第一职业排行已清空,新的一轮已开启", "", 2, 13)
    lualib:SysMsg_SendBroadcastColor("系统提示:天下第一职业排行已清空,新的一轮已开启", "", 2, 13)
end


function on_pre_stall_buy(buy, sell, item, total, num, types)
    lualib:DelayCall(sell, 8, "摆摊收税:set_total_value", total.."#"..types)
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
    --开光大师


    if lualib:GUIDType(role) == 0 and lualib:GUIDType(killer) == 0 then
        lualib:DelayCall(role, 1, "开光大师:on_die", killer);
    end


    --开光大师

    --连斩
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
    --连斩
end

--上马
function on_ride_request(player)
    local buff_table = {"变猪术", "变怪显名"}
    local hashorse = lualib:Attr(player, 200)

    if hashorse == 1 then
        lualib:MsgBox(player, "你已经处于骑乘状态了！")
        return
    end
    --拥有变身BUFF无法骑马
    for i = 1, #buff_table do
        if lualib:HasBuff(player, buff_table[i]) == true then
            lualib:MsgBox(player, "变身状态无法骑马，请右键点击BUFF图标取消BUFF后再进行尝试")
            return
        end
    end
    --上马读条
    lualib:ProgressBarStart(player, 5000, "上马中", "on_Horse_true", "on_Horse_false", "")
end

--上马
function on_Horse_true(player)
    lualib:Ride(player)
    return true
end

--上马被打断
function on_Horse_false(player)
    lualib:SysMsg_SendTriggerMsg(player, "上马被打断")
    return true
end


-- 下马
function on_unride_request(player)
    local hashorse = lualib:Attr(player, 200)
    if hashorse == 2 then--
        lualib:MsgBox(player, "你还没有骑乘，不能下马状态了！")
    else
        lualib:UnRide(player)
    end

    return true
end


function on_castle_war_start()
    lualib:SysMsg_SendBroadcastColor("神歌城攻城战开始了", "", 1, 12)
    lualib:SetDBNum(lualib:GetAllDays(0).."是否攻城",1)
end

function on_castle_war_end()
    lualib:SetInt("0", "war_start", 0)
end

function on_player_relive(player)
    if lualib:Level(player) > 14 and lualib:Level(player) < 35 then
        for i=1, 5 do
            local Eq = lualib:Player_Summon(player, "黑色恶蛆", 3)
            lualib:AddBuff(Eq, "无敌", 0)
        end
    end


    lualib:SetInt(player, "die_flag", 0)
    local map = lualib:Map_GetMapGuid("龙城")
    if lualib:GetInt("0", "war_start") == 1 then
        local own_family = lualib:GetCastleOwnFamily("神歌城")
        local my_family = lualib:GuildGuid(player)

        if own_family == "" or my_family == "" then
            return true
        else
            if lualib:GetCastleOwnFamily("神歌城")== lualib:Name(my_family) or lualib:GetCastleTempFamily("神歌城") == lualib:Name(my_family) then
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
    "蜀国",
    "吴国",
    "魏国"
}
local countryPosition  = {
    "国王",
    "丞相",
    "大将军",
    "大司马",
    "大都督",
}

local sponsor = {
    {1.02,"赞助1"},
    {1.04,"赞助2"},
    {1.06,"赞助3"},
    {1.08,"赞助4"},
    {1.11,"赞助5"},
    {1.20,"赞助6"},
}

local DIETIMECONSTANT = 30
function on_player_login(player)
    local vip = lualib:GetVipLevel(player)
    if vip > 0 then
        lualib:AddBuff(player,sponsor[vip][2],0)
    end
    -- 上线穿戴三相之力
    local PrismaticJewelGUID = lualib:GetStr(player, "PrismaticJewelGUID")
    if PrismaticJewelGUID == "" then
        if lualib:GetBagFree(player) > 0 then
            local prismaticJewelGUID = lualib:GiveOneBindItem(player, "三相之力", 1, "给予三相之力", "给予三相之力")
            lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
            lualib:ApplyEquipEx(player, "三相之力")
        else
            local items = lualib:BagItemList(player, true, false, false)
            local item_guid = items[1]
            local item_json = lualib:Item2Json(item_guid)
            lualib:Item_Destroy("", item_guid, "替换三相之力", "替换三相之力")

            local prismaticJewelGUID = lualib:GiveOneBindItem(player, "三相之力", 1, "更换三相之力", "更换三相之力")
            lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
            lualib:ApplyEquipEx(player, "三相之力")
            lualib:Json2ItemEx(player, item_json, false)
        end
    else
        if not lualib:InEquip(player, PrismaticJewelGUID) then
            if lualib:GetBagFree(player) > 0 then
                local item_GUID = lualib:Player_GetEquipGuid(player, 414)
                lualib:Item_Destroy("", item_GUID, "合区后三相之力替换", "合区后三相之力替换")
                local prismaticJewelGUID = lualib:GiveOneBindItem(player, "三相之力", 1, "给予三相之力", "给予三相之力")
                lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
                lualib:ApplyEquipEx(player, "三相之力")
            else
                local items = lualib:BagItemList(player, true, false, false)
                local item_guid = items[1]
                local item_json = lualib:Item2Json(item_guid)
                lualib:Item_Destroy("", item_guid, "替换三相之力", "替换三相之力")
                local item_GUID = lualib:Player_GetEquipGuid(player, 414)
                lualib:Item_Destroy("", item_GUID, "合区后三相之力替换", "合区后三相之力替换")
                local prismaticJewelGUID = lualib:GiveOneBindItem(player, "三相之力", 1, "给予三相之力", "给予三相之力")
                lualib:SetStr(player, "PrismaticJewelGUID", prismaticJewelGUID)
                lualib:ApplyEquipEx(player, "三相之力")
                lualib:Json2ItemEx(player, item_json, false)
            end
        end
    end

    -- 上线检查宠物复活时间
    local jsonData = lualib:GetStr(player, "heroJsonData")
    local country = lualib:GetStr(player, "countryName")
    if jsonData ~= "" and country ~= "" then
        local warGodData = json.decode(jsonData)


        for index, value in pairs(warGodData[country]) do
            -- 每隔一秒减少1，用于表示复活时间
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



    -- 打开洪子涵的小工具
    lualib:ShowFormWithContent(player, "form文件表单", "hzhUtil")

    if not lualib:HasTimer(player, 201785) then
        --	lualib:AddTimer(player, 201785, 60*1000, -1, "天下第一:udon")
    end
    if lualib:Level(player) > 14 and lualib:Level(player) < 35 then
        for i=1, 5 do
            local Eq = lualib:Player_Summon(player, "黑色恶蛆", 3)
            lualib:AddBuff(Eq, "无敌", 0)
        end
    end

    --每次上线确认是否有加入国家，未加入弹出面板
    local count = 0
    local nameList = lualib:Name(player)            --玩家名字
    local country = lualib:GetStr(player,"countryName")     --国家名字

    if country ~= "" then
        if lualib:HasBuff(player,country) == false then
            lualib:AddBuff(player,country,0)
        end

        local countryList = lualib:GetDBStr(country.."updateRanking")
        local listTable = lualib:StrSplit(countryList,"#")
        for j=2,#listTable do


            if #listTable < 6 then                                           --小于等于5时直接添加buff
                if nameList == listTable[j] then
                    lualib:AddBuff(player,countryPosition[j-1],0)
                    lualib:SysMsg_SendBroadcastMsg("欢迎【"..country..countryPosition[j-1].."】***"..nameList.."***进入游戏！！！！！","系统")
                    lualib:SysMsg_SendBroadcastMsg("欢迎【"..country..countryPosition[j-1].."】***"..nameList.."***进入游戏！！！！！","系统")
                    if lualib:GetDBNum(country..countryPosition[j-1].."Reward") == 1 then
                        lualib:DelayCall(player,1,"三国表单:receiveIngots",tostring(j-1))
                        lualib:SetDBNum(country..countryPosition[j-1].."Reward",0)
                    end
                    break
                end
            else
                if nameList == listTable[j] then
                    lualib:AddBuff(player,countryPosition[j-1],0)
                    lualib:SysMsg_SendBroadcastMsg("欢迎【"..country..countryPosition[j-1].."】***"..nameList.."***进入游戏！！！！！","系统")
                    lualib:SysMsg_SendBroadcastMsg("欢迎【"..country..countryPosition[j-1].."】***"..nameList.."***进入游戏！！！！！","系统")
                    if lualib:GetDBNum(country..countryPosition[j-1].."Reward") == 1 then
                        lualib:DelayCall(player,1,"三国表单:receiveIngots",tostring(j-1))
                        lualib:SetDBNum(country..countryPosition[j-1].."Reward",0)
                    end
                    break
                end

                if j==6 then                                                --添加完第五个buff 结束循环
                    break
                end
            end
        end
    end
    lualib:AddTimerEx(player,20200326,1000,-1,"三国表单:levelUpAddBuff","")
    if  country == "" then
        lualib:DelayCall(player,1,"country:main","")
    end

    lualib:DelayCall(player, 1, "行会争霸:check", "");
    lualib:DelayCall(player, 1, "英雄榜:check", "");
    local level = lualib:Level(player)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)
    if time > lualib:GetAllTime() then
        lualib:ShowFormWithContent(player,"form文件表单","Amark系统公告")
    end
    lualib:DelayCall(player, 1, "登陆脚本:main", "");
    lualib:DelayCall(player, 1, "魔气血石:on_login", "");
    active_player(player, 2, 0)	--登录时向网站发送角色最新信息，不要删除否则影响统计功能
    lualib:ShowFormWithContent(player, "form文件表单", "服务器时间表单#"..lualib:GetAllTime())

    --死亡上线
    local die_flag = lualib:GetInt(player, "die_flag")
    if lualib:GetInt("0", "war_start") == 1 and die_flag == 1 then
        local own_family = lualib:GetCastleOwnFamily("神歌城")
        local my_family = lualib:GuildGuid(player)
        if own_family == "" or own_family ~= lualib:Name(my_family) then
        else
            lualib:Player_MapMoveXY(player, "龙城", 586, 283, 5)
            lualib:SetInt(player, "die_flag", 0)
        end
    end

    --GM登陆
    if lualib:Player_IsGM(player) then
        lualib:Player_SetGhost(player, true)
        lualib:SysMsg_SendTriggerMsg(player, "你已进入隐身状态！")
        lualib:Player_SetInvincible(player, true)
        lualib:SysMsg_SendTriggerMsg(player, "你已进入无敌状态！")
        lualib:AddBuff(player, "疾驰", 60*60*24)
        lualib:SysMsg_SendTriggerMsg(player, "你已进入疾驰状态！")
    end

    --右上角图标显示
    CountPlyaerGold(player)
    chongzhi_libao(player)
    wanjiajisuan(player)
    check_days_bill(player)
    weixin_xianshi(player)--微信
    Amark_huodong(player)
    jihuoma_xianshi(player)--激活码
    AmarkBossTiaoZhanMain(player)--AmarkBossTiaoZhan
    lualib:DelayCall(player, 1, "公告牌:chongzhi_paihang", "")
    --功能导入
    marry_load(player)			--夫妻是否组队/跨天扣除亲密度
    process_master_apprentice_login(player)	--调用师徒登录触发
    local types = lualib:GetClientType(player)  ----获取玩家进入游戏方式，返回0就是通过客户端，1是页游端，2是手游端
    if types == 0 then      ----------如果玩家是通过客户端进入游戏才执行以下检测
    local NowTime = lualib:GetAllTime()
        local subtimer = NowTime - StartServerTime_int
        if subtimer > 86400 then     ----当前时间大于开区时间24小时才执行以下检测，避免新区玩家体验较差导致流失，自行决定是否需要这个判断
        if lualib:Player_IsGM(player) == false then
        end
            if Servertime_int >= ServerNewtime_int then   -----如果当前引擎版本 >= 预设的最新引擎版本才执行MD5检测
            lualib:AddTimer(player,20150501,lualib:GenRandom(300, 600) * 1000,-1,"md5_check")
                ---玩家同时检测MD5会卡，建议设置上线5--10分钟检测一次，同时避免设置固定时间让外挂找到规律
            end
            lualib:DelayCall(player, 3000, "client_ver", "")  ------ 检测客户端版本delaycall 回调
        end
    end
    Creat_tage_mei(player)
    Creat_tage_dj(player)
    Creat_tage_blee(player)
    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--存储攻击排行榜
    end
    if lualib:Level(player) <= 35 then
        if not lualib:HasBuff(player,"初入江湖") then
            lualib:AddBuff(player,"初入江湖")
        end
    end
    --	lualib:DelayCall(player, 2000, "AmarkSetSkillBarSkill", "")
end

function AmarkSetSkillBarSkill(player)
    lualib:ShowFormWithContent(player,"脚本表单", "AmarkYdFormSkillSet()")
end

function on_login_delay_timer(player, timer_id)
    local caller = (lualib:Gender(player) == 1) and "丈夫" or "妻子"
    local spouse = lualib:Player_GetCustomVarStr(player, "配偶GUID")
    lualib:SysPromptMsg(spouse, "你的"..caller.."上线了。")
end

function client_ver(player)
    lualib:RequestClientVer(player);
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "");
end

function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player);
    if (ver < 3003) or (ver <  3011 ) then
        lualib:SysMsg_SendTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysMsg_SendTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysMsg_SendTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysMsg_SendTriggerMsg(player, "如果不更新请点击登录器上资源修复完整修复后才可以正常游戏！")
        lualib:SysMsg_SendTriggerMsg(player, "如果不更新请点击登录器上资源修复完整修复后才可以正常游戏！")
        lualib:DelayCall(player, 3000, "kick_player", "");
    end
end

function kick_player(player)
    lualib:Player_Kick(player)
end

function on_player_logout(player)
    lualib:DelayCall(player, 1, "退出脚本:main", "");
    CountPlyaerGold(player)
    --online_gift_logout(player)						--在线礼包退出
end

function on_player_add_exp(player, expv)
    local Lsd = lualib:GetStr(player, "Amark_Lsd_Guid")
    if lualib:HasItem(player, Lsd) then
        lualib:SetInt(Lsd, "Amark_Exp", lualib:GetInt(Lsd, "Amark_Exp") + 1)
        lualib:NotifyVar(Lsd, "Amark_Exp")
    end
    lualib:DelayCall(player, 1, "经验脚本:main", tostring(expv));
    --process_horse_add_exp(player, tonumber(expv))
end

local AmarkLevelUpEquipT = {
    [15] = {
        [1] = {--战士
            {--男
                {"八荒", 0, 0},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(男)", 0, 0},
            },
            {--女
                {"八荒", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(女)", 0, 1},
            },
        },

        [2] = {--法师
            {--男
                {"海魂", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(男)", 0, 1},
            },
            {--女
                {"海魂", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(女)", 0, 1},
            },
        },

        [3] = {--道士
            {--男
                {"半月", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(男)", 0, 1},
            },
            {--女
                {"半月", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"轻型盔甲(女)", 0, 1},
            },
        },
    },

    [25] = {--战士
        [1] = {
            {--男
                {"修罗", 0, 1},--索引名+数量+绑定类型[0不1绑]
                {"重盔甲(男)", 0, 1},
                {"黑色水晶戒指", 10, 1},
                {"黑色水晶戒指", 11, 1},
                {"死神手套", 3, 1},
                {"死神手套", 4, 1},
                {"蓝翡翠项链", 1, 1},
                {"道士头盔", 1, 1},
            },
            {--女
                {"修罗", 1, 1},--索引名+数量+绑定类型[0不1绑]
                {"重盔甲(女)", 1, 1},
                {"黑色水晶戒指", 10, 1},
                {"黑色水晶戒指", 11, 1},
                {"死神手套", 3, 1},
                {"死神手套", 4, 1},
                {"蓝翡翠项链", 1, 1},
                {"道士头盔", 1, 1},
            },
        },

        [2] = {--法师
            {--男
                {"偃月", 1, 1},--索引名+数量+绑定类型[0不1绑]
                {"魔法长袍(男)", 1, 1},
                {"放大镜", 1, 1},
                {"蛇眼戒指", 10, 1},
                {"蛇眼戒指", 11, 1},
                {"黑檀手镯", 3, 1},
                {"黑檀手镯", 4, 1},
                {"道士头盔", 1, 1},
            },
            {--女
                {"偃月", 1, 1},--索引名+数量+绑定类型[0不1绑]
                {"魔法长袍(女)", 1, 1},
                {"放大镜", 1, 1},
                {"蛇眼戒指", 10, 1},
                {"蛇眼戒指", 11, 1},
                {"黑檀手镯", 3, 1},
                {"黑檀手镯", 4, 1},
                {"道士头盔", 1, 1},
            },
        },

        [3] = {--道士
            {--男
                {"降魔", 1, 1},--索引名+数量+绑定类型[0不1绑]
                {"灵魂战衣(男)", 1, 1},
                {"珍珠戒指", 10, 1},
                {"珍珠戒指", 11, 1},
                {"竹笛", 1, 1},
                {"道士手镯", 3, 1},
                {"道士手镯", 4, 1},
                {"道士头盔", 1, 1},
            },
            {--女
                {"降魔", 1, 1},--索引名+数量+绑定类型[0不1绑]
                {"灵魂战衣(女)", 1, 1},
                {"竹笛", 1, 1},
                {"珍珠戒指", 10, 1},
                {"珍珠戒指", 11, 1},
                {"道士手镯", 3, 1},
                {"道士手镯", 4, 1},
                {"道士头盔", 1, 1},
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
            local Eq = lualib:Player_Summon(player, "黑色恶蛆", 3)
            lualib:AddBuff(Eq, "无敌", 0)
        end
        if lualib:ItemCount(player, "嘟嘟新手礼包(5级)") > 0 then
            lualib:ApplyItem(player, "嘟嘟新手礼包(5级)", false)
        end
        lualib:Player_MapMove(player,"新手练级3")
        lualib:MsgBox(player,"#COLORCOLOR_YELLOW#\n恭喜你打的#COLORCOLOR_GREENG#【15级】#COLORCOLOR_YELLOW#系统为您准备了\n更高级的训练场地 ")
    end
    if level == 20 then
        lualib:MsgBox(player,"#COLORCOLOR_YELLOW#\n恭喜你打的#COLORCOLOR_GREENG#【20级】#COLORCOLOR_YELLOW#您现在可以去\n虫洞探宝 ")
        lualib:Player_MapMove(player,"地牢1层东")
        lualib:AcceptQuest(player, 10001)
        if lualib:ItemCount(player, "嘟嘟新手礼包(15级)") > 0 then
            lualib:ApplyItem(player, "嘟嘟新手礼包(15级)", false)
        end
    end
    if level == 35 then
        local BabyList = lualib:Player_GetServantList(player)
        for i=1, #BabyList do
            local KeyName = lualib:KeyName(BabyList[i])
            if KeyName == "黑色恶蛆" then
                lualib:Monster_Remove(BabyList[i])
            end
        end
        lualib:DelBuff(player,"初入江湖")
    end

    if LevelUpT[level] ~= nil then
        lualib:Player_RunScript(player, "冲级奖励新:Ukxeuqdd", "")
    end

    if AmarkLevelUpEquipT[level] ~= nil then
        local Job = lualib:Job(player)
        local Gender = lualib:Gender(player)
        if AmarkLevelUpEquipT[level][Job][Gender] ~= nil then
            for i=1, #AmarkLevelUpEquipT[level][Job][Gender] do
                lualib:AddItem(player, AmarkLevelUpEquipT[level][Job][Gender][i][1], 1, true, "新手装备", "新手装备")
                lualib:TakeOnEx(player, AmarkLevelUpEquipT[level][Job][Gender][i][1], AmarkLevelUpEquipT[level][Job][Gender][i][2])
            end
        end
    end



    --记录测试奖励[添加到升级触发]
    level = tonumber(level)
    local testtime = lualib:GetConstVar("TestServerTime")
    local testtimes = lualib:Str2Time(testtime)
    local nowtime = lualib:GetAllTime()
    if nowtime < testtimes then
        --local leveluptb = {
        --[35] = "levelup42.txt",--等级对应的存储文档名
        -- }
        if leveluptb[level] ~= nil then
            local account = lualib:AccountName(player)
            if not lualib:IO_FileExists(leveluptb[level]) then
                lualib:IO_CreateTextFile(leveluptb[level], false)
            end
            if not lualib:IO_TextFileInsertLine(leveluptb[level], 1, account) then
                lualib:Error("添加公测奖励帐号"..account.."失败！")
            else
                lualib:SysTriggerMsg(player, "恭喜您在内测区升到"..level.."级，正式开区后可领取公测奖励！")
            end
        end
    end
    Creat_tage_dj(player)
    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--存储攻击排行榜
    end
    active_player(player, 3, 0)	--升级时向网站发送角色最新信息，不要删除否则影响统计功能
    process_apprentice_level_up(player, level)			--调用徒弟升级触发
end



--------[[玩家第一次进入游戏]]
function on_first_in_game(player)

    lualib:SysMsg_SendBroadcastMsg("#COLORCOLOR_WHITE#天下英雄出我辈#COLOREND##COLORCOLOR_YELLOW#【"..lualib:Name(player).."】#COLOREND##COLORCOLOR_WHITE#来到了本游戏,初来乍到,请大家多多关照","")
    --新手上线给技能
    local job = lualib:Job(player)
    if job == 1 then
        lualib:Player_AddSkill(player, "基本剑术3级")
        lualib:Player_AddSkill(player, "攻杀剑术3级")
        lualib:Player_AddSkill(player, "刺杀剑术3级")
        lualib:Player_AddSkill(player, "半月弯刀3级")
        lualib:Player_AddSkill(player, "野蛮冲撞3级")

    elseif job == 2 then
        lualib:Player_AddSkill(player, "火球术3级")
        lualib:Player_AddSkill(player, "抗拒火环3级")
        lualib:Player_AddSkill(player, "诱惑之光3级")
        lualib:Player_AddSkill(player, "雷电术3级")
        lualib:Player_AddSkill(player, "火墙3级")
        lualib:Player_AddSkill(player, "瞬息移动3级")
        lualib:Player_AddSkill(player, "爆裂火焰3级")
        lualib:Player_AddSkill(player, "疾光电影3级")
        lualib:Player_AddSkill(player, "地狱雷光3级")
        lualib:Player_AddSkill(player, "圣言术3级")
        lualib:Player_AddSkill(player, "魔法盾3级")

    elseif job == 3 then
        lualib:Player_AddSkill(player, "治愈术3级")
        lualib:Player_AddSkill(player, "精神力战法3级")
        lualib:Player_AddSkill(player, "施毒术3级")
        lualib:Player_AddSkill(player, "隐身术3级")
        lualib:Player_AddSkill(player, "灵魂火符3级")
        lualib:Player_AddSkill(player, "召唤骷髅3级")
        lualib:Player_AddSkill(player, "集体隐身术3级")
        lualib:Player_AddSkill(player, "幽灵盾3级")
        lualib:Player_AddSkill(player, "神圣战甲术3级")
        lualib:Player_AddSkill(player, "困魔咒3级")
        lualib:Player_AddSkill(player, "群体治愈术3级")
    end



    --新手上线给技能
    --lualib:ForceAcceptQuest(player, 3006)
    local item_k = {"乌木剑","嘟嘟新手礼包(5级)","超级护身符","新手指南","巫山城传送石","随机卷(20次)",}
    local item_n = {1,1,1,1,1,1,}
    local item_b = {1,1,1,1,1,1,}
    local item_o = {0,0,0,0,0,0,}

    if not lualib:Player_ItemRequest(player, item_k, item_n, item_b, item_o, "给物品：第一次进游戏", "") then
        lualib:SysMsg_SendTriggerMsg(player, "新手物品赠送失败！")
    end

    lualib:ApplyEquipEx(player,"乌木剑")
    lualib:ApplyEquipEx(player,"超级护身符")
    local Gender = lualib:Gender(player)
    local award_item = {"布衣(男)", "布衣(女)"}
    if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
        lualib:SysMsg_SendTriggerMsg(player, "赠送金戈衣服失败！")
    end
    lualib:ApplyEquipEx(player, "布衣(男)")
    lualib:ApplyEquipEx(player, "布衣(女)")
    local level = lualib:Level(player)

    local player_name = lualib:Name(player)
    lualib:DelayCall(player, 2000, "AmarkSetSkillBarSkill", "")
end


function on_gp(player, gp_runtime, gp, diff_avg_tick)
    local count = lualib:GetTempInt(player, "SetNetCheck");
    if count <= 0  then
        --第一次触发, 给玩家加上严格模式
        lualib:SetTempInt(player, "SetNetCheck", 1);
        lualib:SetNetCheckEx(player, true, true);
        lualib:DelayCall(player, 1200 * 1000, "CancelCheck", "");
    elseif count == 1 then
        --严格模式下, 第二次触发, 给玩家发送警告
        lualib:SetTempInt(player, "SetNetCheck", 2);
        lualib:SysWarnMsg(player, "系统检测到你使用非法外挂，请立即停止使用，否则将对你采取惩罚措施！");
    else
        --严格模式下, 第三次触发, 直接T下线
        lualib:KickByName(lualib:Name(player), 2, "使用外挂");
    end
end

function CancelCheck(player)
    lualib:SetTempInt(player, "SetNetCheck", 0)
    lualib:SetNetCheck(player, false)
end

--上报角色信息
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

--上报角色信息回调
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
        lualib:SysWarnMsg(player, "请不要使用外挂,你已经被系统记录，情节严重者直接封号！");
        lualib:Error(lualib:Name(player) .. "可能使用挂机外挂");
    end
end


------------------检测外挂回调--------------------
function on_hack_check2(player, C1, C2, C3, C4, C5, C6)
    local types = lualib:GetClientType(player)  ----获取玩家进入游戏方式，返回0就是通过客户端，1是页游端，2是手游端
    if types ~= 0 then      ----------如果不是通过客户端进入游戏，就不执行检测
    return
    end

    local PreTime = lualib:GetTempInt(player, "HackCheckTime")
    local NowTime = lualib:GetAllTime()
    if NowTime - PreTime < 60 then  ----如果当前时间和上次检测时间小于60秒，不执行判断
    return;
    end
    lualib:SetTempInt(player, "HackCheckTime", NowTime)

    -- if C1 >= 1 or C6 >= 1 then    -----C6会误判LOL盒子，慎用！！
    if C1 >= 1 then
        lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
        lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
        lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
        lualib:DelayCall(player, 3000, "kick_player", "")
    end
end

function on_trigger_billin(player, yb)
    yb = tonumber(yb)

    local name = lualib:Name(player)
    lualib:SysMsg_SendWarnMsg(player, "你充值了"..yb.."元宝")
    lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..name.."”在线充值获得" .. yb ..  "元宝","[充值提示]", 2, 11)
    Creat_tage_blee(player)
    lualib:DelayCall(player, 1, "公告牌:chongzhi_paihang", "")

end

function on_trigger_kill(killer, victim)
    local victim_name = lualib:KeyName(victim)
    local player_guid = ""

    if lualib:Player_IsPlayer(killer) == true then
        if lualib:Player_HasTeam(killer) then
            local ZuDuiT = lualib:Player_GetTeamList(killer)
            for i=1, #ZuDuiT do
                if lualib:Distance(ZuDuiT[i], killer) < 10 then
                    renwuchufa(ZuDuiT[i],victim) --人物杀怪执行
                end
            end
        else
            renwuchufa(killer,victim) --人物杀怪执行
        end
    elseif lualib:Monster_IsMonster(killer) == true then
        local player_name = lualib:Monster_GetMaster(killer)
        if player_name ~= "" then
            local player_guild = lualib:Name2Guid(player_name)
            if lualib:Player_HasTeam(player_guild) then
                local ZuDuiT = lualib:Player_GetTeamList(player_guild)
                for i=1, #ZuDuiT do
                    if lualib:Distance(ZuDuiT[i], player_guild) < 10 then
                        renwuchufa(ZuDuiT[i],victim) --宝宝杀怪执行
                    end
                end
            else
                renwuchufa(player_guild,victim) --宝宝杀怪执行
            end
        end
    end

    if lualib:Player_IsPlayer(victim) then
        local map = lualib:MapGuid(victim)
        local s = "#COLORCOLOR_GREENG#☆号外☆#COLORCOLOR_RED#["..lualib:Name(killer).."]#COLORCOLOR_GREENG#在#COLORCOLOR_PURPLE#["..lualib:Name(map).."]#COLORCOLOR_GREENG#轻松将→→#COLORCOLOR_SKYBLUE#["..lualib:Name(victim).."]#COLORCOLOR_GREENG#撂倒在脚下-_-|||！强势围观中……"
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
        --lualib:DelayCall(player_guid, 1, "伏魔点:add_fmd", tostring(num_n))
        --lualib:SysMsg_SendPromptMsg(player_guid, "你击杀了一只伏魔成就怪物，获得今日伏魔点："..fmcj[victim_name].."！")
        --end
        --if Tx_richangmubiao[victim_name] ~= nil then
        --local num_e = Tx_richangmubiao[victim_name]
        --lualib:DelayCall(player_guid, 1, "日常目标:add_goalpoint", tostring(num_e))
        --end
    end
end

----------------检查客户端版本------------
function client_ver(player)
    lualib:RequestClientVer(player)  ----请求客户端版本号（玩家刚上线客户端可能没有上报版本号，所以需要主动请求一次）
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "")
end


function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player) ----获得玩家客户端版本号

    --if ver < lualib:GetGSClientVer()  then  ----  获得的客户端版本号和 引擎自动学习到的最新版本号 做比较 （用自己OSS更新资源的需要同步下官方5月13日资源）
    if ver < 3011  then
        lualib:SysMsg_SendTriggerMsg(player, "你的客户端过老，请关闭游戏重新打开登录器点击[资源修复]更新最新客户端！")
        lualib:SysMsg_SendTriggerMsg(player, "你的客户端过老，请关闭游戏重新打开登录器点击[资源修复]更新最新客户端！")
        lualib:SysMsg_SendTriggerMsg(player, "你的客户端过老，请关闭游戏重新打开登录器点击[资源修复]更新最新客户端！")
        lualib:SysMsg_SendTriggerMsg(player, "你的客户端过老，请关闭游戏重新打开登录器点击[资源修复]更新最新客户端！")
        lualib:SysMsg_SendTriggerMsg(player, "你的客户端过老，请关闭游戏重新打开登录器点击[资源修复]更新最新客户端！")
        lualib:DelayCall(player, 3000, "kick_player", "")
    end
end


--------------检测多开----------------------
function Client_info(player, param, info_table, is_timeout)

end

----------------检查外挂MD5回调------------

function md5_check(player,timer_id)
    lualib:SetMD5CheckList(player, md5_list, "on_md5_check", "吃葡萄不吐葡萄皮，仓井思密达，神途大法好！", 300000)
end

function on_md5_check(player, param, md5_num_list, is_timeout)
    --[[
            if is_timeout == true then
                    lualib:SysMsg_SendTriggerMsg(player, "检测外挂程序超时，请重新打开登录器，点击[资源修复]后重新登录")
                    lualib:SysMsg_SendTriggerMsg(player, "检测外挂程序超时，请重新打开登录器，点击[资源修复]后重新登录")
                    lualib:SysMsg_SendTriggerMsg(player, "检测外挂程序超时，请重新打开登录器，点击[资源修复]后重新登录")
                    lualib:SysMsg_SendTriggerMsg(player, "检测外挂程序超时，请重新打开登录器，点击[资源修复]后重新登录")
                    lualib:SysMsg_SendTriggerMsg(player, "检测外挂程序超时，请重新打开登录器，点击[资源修复]后重新登录")
                    --lualib:DelayCall(player, 3000, "kick_player", "")
            else
                    for i = 1,#md5_num_list do
                            if md5_num_list[i] > 0 then
                                    lualib:DelayCall(player, 1, "外挂传送:fwg", "")
                                    lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
                                    lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
                                    lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
                                    lualib:SysMsg_SendWarnMsg(player, "警告：系统怀疑你可能在使用非法外挂程序，将被踢下线！")
                                    lualib:Error(lualib:Name(player) .. "可能使用挂机外挂")
                            end
                    end
            end
            ]]
end


-------------踢人---------------------
function kick_player(player)
    lualib:Player_Kick(player)
end

--离线挂机

function on_pre_logout(player, type)
    --离线
    lualib:SetInt(player, "last_logout", lualib:GetAllTime())
    if not lualib:HasTimer(player, 112568) then
        lualib:DisableTimer(player, 112568)
    end
    local map = lualib:Map_GetMapGuid("龙城")

    if lualib:Level(player) < 35 then
        local MonsterT = lualib:Player_GetServantList(player)
        for i=1, #MonsterT do
            lualib:Monster_Remove(MonsterT[i])
        end
        return true
    end
    lualib:ShowFormWithContent(player, "脚本表单", "fgxewkry.uduf()")
    if tonumber(type) == 1 then
        local rx = lualib:GenRandom(-9,9)
        local ry = lualib:GenRandom(-9,9)
        lualib:SetOffline(player, 1440000)--挂机400小时，单位：秒
        local x = 293 + rx
        local y = 362 + ry
        lualib:Map_JumpXY(map, player, x, y, 10)
        lualib:Player_SetInvincible(player,true)
        return false
    end
    --离线
    return true;
end

function kouchusx(player)
    lualib:SetDynamicAttr(player,77,0,0)
    lualib:SetDynamicAttr(player,78,0,0)
    lualib:SetDynamicAttr(player,79,0,0)
end



-------------技巧项链---------------------
function on_spell(player, id, name, x, y, target, key)--此处是技巧项链
    local neck = "技巧项链"	--技巧项链索引名
    local skills = {
        ["普通物理攻击"] = 1,--什么技能不需要设置熟练度
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

function set_skill_exp(player, key)--技巧项链回调函数
    local exps = 5	--佩戴技巧项链额外增加多少点熟练度
    local shulian = lualib:GetSkillExp(player, key)
    lualib:SetSkillExp(player, key, shulian + exps)
end

-------------几级才可摆摊---------------------
function on_pre_stall(player)
    local Level = lualib:Level(player)
    if Level < 10 then
        lualib:SysMsg_SendTriggerMsg(player,"25级才可摆摊")
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
                lualib:AddBuff(player, "回魂咒", 3)
                return false
            end
        end
    end
    if Tjit(player) then
        return false
    end


    return true
end

local skillTb1 = {--几率,反射
    ["万恶之源1"] = {10,30},
    ["万恶之源2"] = {20,40},
    ["万恶之源3"] = {30,50},
    ["万恶之源4"] = {40,60},
}

function on_attack_ex(role, tacker, hp, skill_key)
    local name = lualib:KeyName(role)
    if string.match(name,"守护灵") == "守护灵" then
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

    --秒血
    local jyjn = {"火墙1级","火墙2级","火墙3级","火墙4级","陨星灭世1级","陨星灭世2级","陨星灭世3级","陨星灭世4级","陨星灭世5级","火墙5级"}  --技能KeyName
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
                    --lualib:SysMsg_SendWarnMsg(tacker,"触发第"..k.."套属性！")
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
    --秒血
    --lualib:DelayCall(role, 300, "触发套装属性:Qentdduf", tacker.."#"..skill_key)
    lualib:DelayCall(role, 100, "特戒:Atfm", "")
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



--穿脱装备获得失去技能
function chuandaiqian(player, item, item_id, item_keyname)



    if lualib:Job(player) == 3 then
        if skills[item_keyname] ~= nil then
            if not lualib:HasSkill(player, skills[item_keyname], false) then
                lualib:AddSkill(player, skills[item_keyname])
                lualib:SysWarnMsg(player, "由于史诗装备的特有属性，恭喜您领悟了“".. lualib:KeyName2Name(skills[item_keyname], 17) .."”技能。")
            end
        end
    end
end

function tuozhuangbei(player, item, item_id, item_keyname)



    if lualib:Job(player) == 3 then
        if skills[item_keyname] ~= nil then
            if lualib:HasSkill(player, skills[item_keyname], false) then
                lualib:DelSkill(player, skills[item_keyname])
                lualib:SysWarnMsg(player, "史诗装备特有属性消失，您失去了“".. lualib:KeyName2Name(skills[item_keyname], 17) .."”技能。")
            end
        end
    end
end
--穿脱装备获得失去技能




local renwu_guai = {
    ["跳跳蜂"] = {1,20},
    ["蜈蚣"] = {2,20},
    ["巨型蠕虫"] = {3,20},
    ["钳虫"] = {4,10},

    ["黑野猪"] = {5,60},
    ["红野猪"] = {6,50},
    ["黑色恶蛆"] = {7,40},
    ["白野猪"] = {8,10},


    ["奥玛战将"] = {9,60},
    ["奥玛勇士"] = {10,50},
    ["火焰奥玛"] = {11,40},
    ["奥玛教主"] = {12,1},

    ["祖犸弓箭手"] = {13,50},
    ["祖犸雕像"] = {14,50},
    ["祖犸卫士"] = {15,40},
    ["祖犸教主"] = {16,1},

    ["牛魔斗士"] = {17,50},
    ["牛魔战士"] = {18,50},
    ["牛魔法师"] = {19,30},
    ["牛魔王"] = {20,1},

    ["魔骨刀兵"] = {21,50},
    ["魔骨卫士"] = {22,40},
    ["魔骨斧兵"] = {23,30},
    ["魔骨战将"] = {24,5},

    ["血魔僵尸"] = {25,50},
    ["邪恶僵尸"] = {26,40},
    ["魔尸奴隶"] = {27,30},
    ["铁锤巨人"] = {28,5},


}

function renwuchufa(killer,victim)
    local victim_name = lualib:Name(victim) --怪物keyname
    local kill_ren_name = lualib:Name(killer)
    local victim_ren_name = lualib:Name(victim)
    if lualib:Monster_IsMonster(victim) and renwu_guai[victim_name] ~= nil then
        if lualib:GetDayInt(killer,"meirirenwu_wanchen_"..renwu_guai[victim_name][1]) == 0 then
            local shuliang = lualib:GetDayInt(killer,"renwu_shaguai_"..renwu_guai[victim_name][1]) + 1
            lualib:SetDayInt(killer, "renwu_shaguai_"..renwu_guai[victim_name][1], shuliang)
            if shuliang >= renwu_guai[victim_name][2] then
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀"..renwu_guai[victim_name][2].."只"..victim_ren_name.."”已达成，请快到任务使者处领取奖励吧！")
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀"..renwu_guai[victim_name][2].."只"..victim_ren_name.."”已达成，请快到任务使者处领取奖励吧！")
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀"..renwu_guai[victim_name][2].."只"..victim_ren_name.."”已达成，请快到任务使者处领取奖励吧！")
                if lualib:HasQuest(killer, 10001) then
                    lualib:ForceQuestReady(killer, 10001)
                    if lualib:GetInt(killer, "AmarkZ") == 0 then
                        Amark_MsgBoxEx(killer, "每日任务已达成一项，是否回城领取奖励？", "提交任务", "一会再说", 60, "Amark挑战Boss", "MoveEx", "", "")
                        lualib:SetInt(killer, "AmarkZ", 1)
                    end
                end
            else
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀"..renwu_guai[victim_name][2].."只"..victim_ren_name.."”进度："..shuliang.."/"..renwu_guai[victim_name][2].."")
            end
        end
    end
end






-------------------------------------------
--装备攻击触发BUFF
local zhuangbei_buff = {
    ["武神护卫者"] = {{"眩晕1秒",2},{"减速1秒",2},}, --BUFF名字、触发几率(百分比)
    ["帝王护卫者"] = {{"眩晕2秒",6}, {"减速3秒",4},},
    ["圣尊护卫者"] = {{"眩晕3秒",8}, {"减速4秒",6}, },
    ["仙尊护卫者【超凡】"] = {{"眩晕3秒",10},{"减速4秒",8},},

}

local item_name_buff = {"仙尊护卫者【超凡】",}--穿戴哪种装备，不触发zhuangbei_buff里的内容


local skill_t = {--技能名称[非索引名] = 变量名(跟技能卡片的对应)

    ["烈焰斩"] = "lieyanzhan",
    ["攻杀剑术"] = "gongshajianshu",
    ["裂地斩"] = "liedizhan",
    ["刺杀剑术"] = "cishajianshu",
    ["瞬斩"] = "shunzhan",


    ["雷电术"] = "leidianshu",
    ["冰爆漩涡"] = "bingpaoxiao",
    ["引经魔轰"] = "yinjingmohong",
    ["陨星灭世"] = "liuxinghuoyu",
    ["火墙"] = "huoqiang",
    ["致命一击"] = "zhimingyiji",
    ["寒冰光环"] = "hanbingguanghuan",

    ["神魂火符"] = "linghunhuofu",
    ["噬血术"] = "potianyijian",
    ["灰飞湮灭"] = "huifeiminmie",
    ["飓风血破"] = "jufengxuepo",



}

local site = {--需要检测的装备位[不要的自行删掉]
    1,	--武器
    2,	--头盔
    3,	--护腕0
    4,	--护腕1
    5,	--衣服
    --6,	--符咒[一般符咒是不能加属性的,不需要自行去掉]
    7,	--鞋子
    8,	--护肩
    9,	--项链
    10,	--戒指0
    11,	--戒指1
    12,	--勋章
    13,	--宝石
    14,	--翅膀
    15,	--守护
    16,	--坐骑
    17,	--盾牌
    18,	--时装
    19,	--斗笠
    20,	--手套
    21,	--珠宝
}



local fs_skill_item = {"减免盾1级","减免盾2级","减免盾3级","减免盾4级","减免盾5级"}

local Amark_Skill_Dps_T = {
    ["施毒术1级"] = 2,
    ["施毒术2级"] = 2,
    ["施毒术3级"] = 2,
    ["施毒术4级"] = 2,
    ["施毒术5级"] = 2,

    ["治愈术1级"] = 3,
    ["治愈术2级"] = 3,
    ["治愈术3级"] = 3,
    ["治愈术4级"] = 3,

    ["群体治愈术1级"] = 3,
    ["群体治愈术2级"] = 3,
    ["群体治愈术3级"] = 3,
    ["群体治愈术4级"] = 3,
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
    ["新区送金币"] = {100, 1},
}

local EquipUpAttSkill = {
    ["刺杀剑术1级"] = 1,
    ["刺杀剑术2级"] = 1,
    ["刺杀剑术3级"] = 1,
    ["刺杀剑术4级"] = 1,
    ["刺杀剑术5级"] = 1,

    ["半月弯刀1级"] = 2,
    ["半月弯刀2级"] = 2,
    ["半月弯刀3级"] = 2,
    ["半月弯刀4级"] = 2,
    ["半月弯刀5级"] = 2,

    ["烈火剑法1级"] = 3,
    ["烈火剑法2级"] = 3,
    ["烈火剑法3级"] = 3,
    ["烈火剑法4级"] = 3,
    ["烈火剑法6级"] = 3,
    ["烈火剑法5级"] = 3,

    ["雷电术1级"] = 2,
    ["雷电术2级"] = 2,
    ["雷电术3级"] = 2,
    ["雷电术4级"] = 2,

    ["火球术1级"] = 1,
    ["火球术2级"] = 1,
    ["火球术3级"] = 1,
    ["火球术4级"] = 1,

    ["冰咆哮1级"] = 3,
    ["冰咆哮2级"] = 3,
    ["冰咆哮3级"] = 3,
    ["冰咆哮4级"] = 3,
    ["冰咆哮5级"] = 3,

    ["灵魂火符1级"] = 1,
    ["灵魂火符2级"] = 1,
    ["灵魂火符3级"] = 1,
    ["灵魂火符4级"] = 1,
    ["灵魂火符5级"] = 1,
    ["灵魂火符6级"] = 1,
}

local skillTb2 = {--主人减伤,守护灵增伤
    ["同生共死1"] = {10,10},
    ["同生共死2"] = {15,15},
    ["同生共死3"] = {20,20},
    ["同生共死4"] = {25,25},
}

local rulai = {
    [480] = {"如来神掌1",20},
    [512] = {"如来神掌2",40},
    [513] = {"如来神掌3",60},
    [514] = {"如来神掌4",80},

}

local dadi = {
    [537] = {"大地复苏1",0.2},
    [538] = {"大地复苏2",0.3},
    [539] = {"大地复苏3",0.4},
    [540] = {"大地复苏4",0.5},

}



function on_pre_harm(role, attacker, hp, defense, skill, bj)
    local r = math.random(0,100)
    local skills = lualib:GetAllSkills(attacker)
    local cur_hp = lualib:Hp(attacker, false)  --当前HP
    local max_hp = lualib:Hp(attacker, true)  --HP上限
    local cur_hp1 = lualib:Hp(role, false)  --被攻击者当前HP
    local max_hp1 = lualib:Hp(role, true)  --被攻击者HP上限
    local hp1 = 0
    for i,v in ipairs(skills) do
        local sName = lualib:Id2KeyName(v,17)
        -- 如来神掌
        if string.find(sName,"如来神掌") ~= nil then
            for j,k in pairs(rulai) do
                if j == v and r <= k[2] and skill == k[1] then
                    hp = hp * 1.5
                    lualib:SetIsBrust(attacker,true)
                end
            end
        end
        -- 大地复苏
        if string.find(sName,"大地复苏") ~= nil then
            for j,k in pairs(dadi) do
                if j == v and skill == k[1] then
                    hp1 = hp * k[2]
                    if cur_hp < max_hp then
                        lualib:SetHp(attacker, cur_hp-hp1, false)     --设置当前HP
                        lualib:ShowRoleHPRefEx("",attacker,-hp1,0)
                    else
                        lualib:SetHp(attacker, max_hp, false)     --设置当前HP
                        lualib:ShowRoleHPRefEx("",attacker,-hp1,0)
                    end
                end
            end
        end
    end

    local name = lualib:KeyName(role)
    if string.match(name,"守护灵") == "守护灵" then
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
                lualib:SetInt(attacker, "Amark世界Boss积分", lualib:GetInt(attacker, "Amark世界Boss积分") + ShiJieBossT[MonsterKeyName][2])
                lualib:SysMsg_SendPromptMsg(attacker, "获得【"..MonsterName.."积分】"..ShiJieBossT[MonsterKeyName][2].."点，共有积分"..lualib:GetInt(attacker,"Amark世界Boss积分").."点。")
                return 0 - ShiJieBossT[MonsterKeyName][1]
            else
                local ZrName = lualib:Monster_GetMaster(attacker)
                if ZrName ~= "" then
                    local ZrGuid = lualib:Name2Guid(ZrName)
                    if ZrGuid ~= "" then
                        lualib:SetInt(ZrGuid, "Amark世界Boss积分", lualib:GetInt(ZrGuid, "Amark世界Boss积分") + ShiJieBossT[MonsterKeyName][2])
                        lualib:SysMsg_SendPromptMsg(ZrGuid, "获得【"..MonsterName.."积分】"..ShiJieBossT[MonsterKeyName][2].."点，共有积分"..lualib:GetInt(ZrGuid, "Amark世界Boss积分").."点。")
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
            local SkillId = lualib:GetInt(role, "Amark_当前坐骑_SkillId")
            local SkillLevel = lualib:GetInt(role, "Amark_当前坐骑_SkillLevel")
            if lualib:GetInt(role, "Amark_Horse_Skill_Id_3") > 0 then
                local TimeCd = {120, 115, 110, 105, 100, 95, 90, 85, 80, 75}
                if lualib:GetInt(role, "Amark_Horse_SKill_Cd_3") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(attacker, "四海升平", 5)
                        lualib:SetInt(role, "Amark_Horse_SKill_Cd_3", lualib:GetAllTime() + TimeCd[lualib:GetInt(role, "Amark_Horse_Skill_Id_3")])
                        lualib:SysMsg_SendPromptMsg(role, "成功触发坐骑技能“四海升平”。")
                        lualib:SysMsg_SendPromptMsg(attacker, "警告！被敌方【"..lualib:Name(role).."】坐骑技能“四海升平”击中，攻击伤害减少20%持续5秒。")
                    end
                end
            end
            if lualib:HasBuff(role, "四海升平") then
                hp = math.floor(hp * 0.8)
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_4") > 0 then
                local SkillJv = {10, 15, 20, 25, 30, 35, 40, 45, 50, 55}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_4") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 1000) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_4")] then
                    else
                        lualib:AddBuff(role, "诅咒之伤", 10)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_4", lualib:GetAllTime() + 120)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“诅咒之伤”。")
                        lualib:SysMsg_SendPromptMsg(role, "警告！被敌方【"..lualib:Name(attacker).."】坐骑技能“诅咒之伤”击中，诅咒+ 10。")
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
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“笑里藏刀”。")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_6") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_6") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_6")] then
                    else
                        lualib:AddBuff(role, "绝幻魔音", 5)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_6", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“绝幻魔音”。")
                        lualib:SysMsg_SendPromptMsg(role, "警告！被敌方【"..lualib:Name(attacker).."】坐骑技能“绝幻魔音”击中，已被缴械。")
                    end
                end
            end
            if lualib:HasBuff(role, "绝幻魔音") then
                return 0
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_7") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_7") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_7")] then
                    else
                        lualib:AddBuff(attacker, "光辉之甲", 10)
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_7", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“光辉之甲”。")
                    end
                end
            end

            if lualib:GetInt(role, "Amark_Horse_Skill_Id_7") > 0 then
                local SkillJv = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
                if lualib:GetInt(role, "Amark_Horse_SKill_Cd_7") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > SkillJv[lualib:GetInt(role, "Amark_Horse_Skill_Id_7")] then
                    else
                        lualib:AddBuff(role, "光辉之甲", 10)
                        lualib:SetInt(role, "Amark_Horse_SKill_Cd_7", lualib:GetAllTime() + 100)
                        lualib:SysMsg_SendPromptMsg(role, "成功触发坐骑技能“光辉之甲”。")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_9") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_9") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(role, "放下屠刀", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_9")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_9", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“放下屠刀”。")
                        lualib:SysMsg_SendPromptMsg(role, "警告！被敌方【"..lualib:Name(attacker).."】坐骑技能“放下屠刀”击中,防御力降低了")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_10") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuffEx(role, "破甲术", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10")], lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10"))
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_10", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“破甲术”。")
                        lualib:SysMsg_SendPromptMsg(role, "警告！被敌方【"..lualib:Name(attacker).."】坐骑技能“破甲术”击中,防御力减少"..lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10").."点,持续"..SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_10")].."秒。")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_11") > 0 then
                local SkillJv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_11") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuffEx(attacker, "破血狂攻",10, SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_11")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_11", lualib:GetAllTime() + 300)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“破血狂攻”。")
                    end
                end
            end

            if lualib:GetInt(attacker, "Amark_Horse_Skill_Id_12") > 0 then
                local SkillJv = {10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
                if lualib:GetInt(attacker, "Amark_Horse_SKill_Cd_12") < lualib:GetAllTime() then
                    if lualib:GenRandom(1, 100) > 10 then
                    else
                        lualib:AddBuff(attacker, "亡灵之刃", SkillJv[lualib:GetInt(attacker, "Amark_Horse_Skill_Id_12")])
                        lualib:SetInt(attacker, "Amark_Horse_SKill_Cd_12", lualib:GetAllTime() + 180)
                        lualib:SysMsg_SendPromptMsg(attacker, "成功触发坐骑技能“亡灵之刃”。")
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
                    --Amark_Msg("【Att_1#"..Job.."】】受伤玩家【"..lualib:Name(role).."】　攻击方玩家【"..lualib:Name(attacker).."】　数值【"..Num.."】　本次伤害【"..hp.."】　额外伤害【"..math.floor(hp * Num / 100).."】")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if Job == 2 then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att2_1")
                if Num > 0 then
                    --Amark_Msg("【Att_2#"..Job.."】受伤玩家【"..lualib:Name(role).."】　攻击方玩家【"..lualib:Name(attacker).."】　数值【"..Num.."】　本次伤害【"..hp.."】　额外伤害【"..math.floor(hp * Num / 100).."】")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if Job == 3 then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att3_1")
                if Num > 0 then
                    --Amark_Msg("【Att_3#"..Job.."】】受伤玩家【"..lualib:Name(role).."】　攻击方玩家【"..lualib:Name(attacker).."】　数值【"..Num.."】　本次伤害【"..hp.."】　额外伤害【"..math.floor(hp * Num / 100).."】")
                    hp = hp + math.floor(hp * Num / 100)
                end
            end
            if 1 == 1 then
                local JobEx = lualib:Job(attacker)
                local Num = lualib:GetInt(role, "AmarkEquipUp_Att"..JobEx.."_2")
                if Num > 0 then
                    --Amark_Msg("攻击方职业:"..JobEx.."　防御数值:"..Num.."　本次伤害"..hp.."　减少伤害"..math.floor(hp * Num / 100).."　最终伤害"..(hp - math.floor(hp * Num / 100)))
                    hp = hp - math.floor(hp * Num / 100)
                end
            end
        end
        if lualib:Player_IsPlayer(attacker) then
            local Job = lualib:Job(attacker)
            local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att"..Job.."_5")
            if Num > 0 then
                --Amark_Msg("角色伤害提升:"..Num.."　进入公式前伤害"..hp.."进入公式后伤害"..(hp + math.floor(hp * Num / 100)))
                hp = hp + math.floor(hp * Num / 100)
            end
            if EquipUpAttSkill[skill] ~= nil then
                local Num = lualib:GetInt(attacker, "AmarkEquipUp_Att"..EquipUpAttSkill[skill].."_4")
                if Num > 0 then
                    --Amark_Msg("当前技能["..skill.."] 数值:"..Num.."1　本次伤害"..hp.."　额外伤害"..math.floor(hp * Num / 100))
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
            lualib:SysMsg_SendWarnMsg(attacker, "本次"..name.."伤害加成："..math.abs(newhp).."，原伤害："..hp)
            return newhp + hp
        end
    end
    if lualib:Player_IsPlayer(attacker)  then local baoshi = lualib:Player_GetItemGuid(attacker,13) if baoshi ~= "" then skill_item_key = lualib:KeyName(baoshi)
        if skill_item_g[skill_item_key] ~= nil then st = string.left(skill, 6)	if skill_item_g[skill_item_key][st] ~= nil then
            hp = math.floor(hp+(hp*(skill_item_g[skill_item_key][st]/100))) end end end end

    if lualib:Player_IsPlayer(role) then local fsbaoshi = lualib:Player_GetItemGuid(role,13) if fsbaoshi ~= "" then asp = lualib:KeyName(fsbaoshi)
        local a = 0 for i=1,#fs_skill_item do if lualib:HasBuff(role,fs_skill_item[i]) == true then a = 1 break	end  end if a > 0 then
            if skill_item_g[asp] ~= nil then if skill_item_g[asp]["魔法盾"] ~= nil then  hp = math.floor(hp-(hp*(skill_item_g[asp]["魔法盾"]/100))) end	end end end end

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
        lualib:SysPromptMsg(player, "您全身幸运+9，已触发攻击上限")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:Name(player).."】全身装备幸运已达+"..lualib:LuckCurse(player).."已触发刀刀最高攻击","【危险人物】")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:Name(player).."】全身装备幸运已达+"..lualib:LuckCurse(player).."已触发刀刀最高攻击","【危险人物】")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:Name(player).."】全身装备幸运已达+"..lualib:LuckCurse(player).."已触发刀刀最高攻击","【危险人物】")
    end

    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--存储攻击排行榜
    end
    lualib:Player_RunScript(player, "Amark角色属性绘制:Amark_CountEquipAtt", "")
end

function on_post_un_equip(player, item,id,key)

    local job = lualib:Job(player)
    if lualib:Level(player) >= 35 then
        Creat_Attr_Table(player, job)	--存储攻击排行榜
    end
    lualib:Player_RunScript(player, "Amark角色属性绘制:Amark_CountEquipAtt", "")
    lualib:SetStr(item, "AmarkEquipUpInof", "")
    lualib:NotifyVar(item, "AmarkEquipUpInof")
end

local tilizj ={
    ["红野猪"] = 1,
    ["白野猪"] = 2,
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

local dropJiuBiNums_1 = 1000 --1久币数量/天
local dropJiuBiNums_10 = 500 --10久币数量/天
local dropJiuBiRandom_1 = 33 --1久币掉落几率 除以10000
local dropJiuBiRandom_10 = 10 --10久币掉落几率 除以10000
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
    if keyname == "积分券1" then
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
    elseif keyname == "积分券10" then
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