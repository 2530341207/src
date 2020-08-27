local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

require("system/logic_def_lua")
--require("system/forbid_role")
require("system/魂力系统")
require("system/master")
require("system/family")
require("system/item_exp")
require("system/horse")
require("system/online_gift")
require("system/marry")
require("npc/竞技场管理员")
require("system/充值礼包")
require("system/领取经验")
require("system/每日签到")
require("campaign/精英竞技场个人赛玩法")
require("campaign/精英竞技场组队赛玩法")
require("system/龙穴探宝")
require("system/目标系统")
require("system/攻略")
require("system/转生")
require("form/清明活动")
require("form/五一活动")
require("form/运营活动")
require("form/端午活动")
require("form/合服活动")
require("form/战斗力表单")

local map_name_table = {{"将军冢1", "将军冢一层"}, {"将军冢2", "将军冢二层"}, {"将军冢3", "将军冢三层"}, {"妖山暗穴1", "妖山暗穴一层"}, {"妖山暗穴2", "妖山暗穴二层"}, {"妖山暗穴3", "妖山暗穴三层"}, {"妖山暗穴4", "妖山暗穴四层"}, {"妖山暗穴5", "妖山暗穴五层"}, {"邪庙1", "天荒邪庙一层"}, {"邪庙2", "天荒邪庙二层"}, {"邪庙3", "天荒邪庙三层"}, {"邪庙4", "天荒邪庙四层"}, {"天荒阵1", "天荒阵一层"}, {"天荒阵2", "天荒阵二层"}, {"天荒阵3", "天荒阵三层"}, {"天荒阵4", "天荒阵四层"}, {"天荒阵5", "天荒阵五层"}, {"天荒阵6", "天荒阵六层"}, {"绝路城1", "绝路城东部"}, {"绝路城2", "绝路城南部"}, {"绝路城3", "绝路城西部"}, {"废弃矿洞1", "矿洞入口"}, {"废弃矿洞2", "南部矿区"}, {"废弃矿洞3", "北部矿区"}, {"废弃矿洞4", "北部采集场"}, {"废弃矿洞5", "南部采集场"}}
local timer_table = {{9900, "15分钟"}, {10200, "10分钟"}, {10500, "5分钟"}, {10620, "3分钟"}, {10680, "2分钟"}, {10740, "1分钟"}}
local ma_timer_table = {{6300, "15分钟"}, {6600, "10分钟"}, {6900, "5分钟"}, {7020, "3分钟"}, {7080, "2分钟"}, {7140, "1分钟"}}
local npc_timer_table = {{3420, "3分钟"}, {3480, "2分钟"}, {3540, "1分钟"}}


local ysax_dgwf_call_back_func = "on_timer_ysax_dgwf_call_back_func"
function on_system_start()
    --服务器第一次启动执行
    if lualib:IO_GetCustomVarInt("fuwuqishushihua") == 0 then
        lualib:IO_SetCustomVarInt("fuwuqishushihua",1)

        --冲级比赛相关数据初始化
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
    ltszuduiqingli() --清理组队竞技场数据
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
    lualib:AddTrigger("0",  lua_trigger_post_equip, "chuandaiqian")   --穿装备之后触发
    lualib:AddTrigger("0",  lua_trigger_post_un_equip, "tuozhuangbei")   --脱装备之后触发
    lualib:AddTrigger("0",  lua_trigger_kill, "on_trigger_kill")
    lualib:AddTrigger("0",  362, "on_pre_logout")  --离线挂机触发器
    lualib:AddTrigger("0",  363, "on_ride_request")  --上马触发
    lualib:AddTrigger("0",  364, "on_unride_request")  --下马触发
    lualib:AddTrigger("0", lua_trigger_pre_equip, "on_pre_equip") --穿装备之前触发
    lualib:AddTrigger("0", lua_trigger_post_un_equip, "on_post_un_equip")
    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die") --怪物死亡触发
    --lualib:AddTrigger("0", lua_trigger_game_guard_check, "on_game_guard_check") --
    --lualib:AddTrigger("0", lua_trigger_game_guard_hack_rpt, "on_game_guard_hack_rpt") --
    --lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2")


    --合服活动 服务器启动时执行
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
    lualib:MsgBox(player,"请勿使用外挂！")

    lualib:DelayCall(player,5000,"tiren","")

end

function on_game_guard_hack_rpt(player,report)
    lualib:MsgBox(player,"检测到外挂信息："..report)
end

function tiren(player)

    lualib:KickByName( lualib:Name(player) , 2, "外挂踢人")
end

local wall_table =
{
    ["神歌城"] =
    {
        {"北部皇宫", 6, "", "招募北部守军", 100000, {{"north_wall_guard1", 348, 179}, {"north_wall_guard2", 358, 189}, {"north_wall_guard3", 345, 182}, {"north_wall_guard4", 355, 192}, {"north_wall_guard5", 342, 185}, {"north_wall_guard6", 352, 195}}, "弓箭守卫2"},
        {"西部城墙", 6, "", "招募西部守军", 100000, {{"west_wall_guard1", 288, 152}, {"west_wall_guard2", 299, 141}, {"west_wall_guard3", 284, 156}, {"west_wall_guard4", 303, 137}, {"west_wall_guard5", 280, 160}, {"west_wall_guard6", 307, 133}}, "弓箭守卫2"},
        {"南部城墙", 6, "", "招募南部守军", 100000, {{"south_wall_guard1", 287, 238}, {"south_wall_guard2", 299, 250}, {"south_wall_guard3", 283, 234}, {"south_wall_guard4", 303, 254}, {"south_wall_guard5", 279, 230}, {"south_wall_guard6", 307, 258}}, "弓箭守卫2"},
        {"东部城墙", 6, "", "招募东部守军", 100000, {{"east_wall_guard1", 384, 250}, {"east_wall_guard2", 396, 238}, {"east_wall_guard3", 380, 254}, {"east_wall_guard4", 400, 234}, {"east_wall_guard5", 376, 258}, {"east_wall_guard6", 404, 230}}, "弓箭守卫2"}
    },
}

function fanhuan()
    for i = 1, table.getn(zhandou) do
        for j = 1, table.getn(zhandou[i]) do
            local data = lualib:IO_GetCustomVarStr(zhandou[i][j][1])
            local data_table = string.split(data, "#")
            if data ~= "" and data ~= nil then
                if i == 1 then
                    lualib:Mail("竞技场管理员", data_table[1], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[2]), {})
                    if data_table[3] ~= nil and data_table[3] ~= "" then
                        lualib:Mail("竞技场管理员", data_table[3], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[2]), {})
                    end
                    lualib:IO_SetCustomVarStr(zhandou[i][j][1], "")
                    lualib:IO_SetCustomVarStr(zhandou[i][j][2], "")
                elseif i == 2 then
                    lualib:Mail("竞技场管理员", data_table[1], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[6]), {})
                    if data_table[7] ~= nil and data_table[7] ~= "" then
                        lualib:Mail("竞技场管理员", data_table[7], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[6]), {})
                    end
                    lualib:IO_SetCustomVarStr(zhandou[i][j][1], "")
                    lualib:IO_SetCustomVarStr(zhandou[i][j][2], "")
                elseif i == 3 then
                    lualib:Mail("竞技场管理员", data_table[1], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[11]), {})
                    if data_table[12] ~= nil and data_table[12] ~= "" then
                        lualib:Mail("竞技场管理员", data_table[12], "你所申请的竞技挑战已过期，系统返还您的元宝！", 0, tonumber(data_table[11]), {})
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
        lualib:SysMsg_SendTriggerMsg(player, "回答正确")
    else
        if err_type == 1 then
            lualib:SysMsg_SendTriggerMsg(player, "超时")
        elseif err_type == 2 then
            lualib:SysMsg_SendTriggerMsg(player, "换一种")
        else
            lualib:SysMsg_SendTriggerMsg(player, "回答错误")
        end
    end
end

function on_hack_check2(player, c1,c2,c3,c4,c5,c6)
    if lualib:GetClientType(player) ~= 0 then
        return;
    end
    if c3 > 5 then
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
        lualib:SysWarnMsg(player,"当前神途客户端大于5个，踢出游戏!")
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
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]攻城战开始了！", "系统通知")
    if not lualib:Map_ClearDgnItem(dst_map_guid) then
        lualib:Error("城堡地图GUID不存在！")
        return
    end

    local add_monster_table = {["神歌城"] = {{"神歌城城门", 292, 247, 5}, {"神歌城殿门1", 359, 164, 5},
                                          {"神歌城殿门1", 363, 168, 5}, {"神歌城殿门1", 367, 172, 5}, {"神歌城侧城门1", 390, 247, 3}, {"神歌城侧城门2", 294, 151, 3}}}
    local remove_npc_table = {["神歌城"] = {"神歌城药材商", "神歌城铁匠", "神歌城裁缝", "神歌城杂货商",
                                         "神歌城首饰商", "神歌城商人", "神歌城教官", "神歌城僧侣", "神歌城管理人"}}
    local remove_monster_table = {["神歌城"] = {"神歌城寺庙", "神歌城商会", "神歌城军营"}}

    for i = 1, table.getn(add_monster_table[castle_name]) do
        if not lualib:Map_GenSingleMonster(dst_map_guid, add_monster_table[castle_name][i][2], add_monster_table[castle_name][i][3],
                1, add_monster_table[castle_name][i][4], add_monster_table[castle_name][i][1], false) then
            lualib:Print(castle_name.."刷怪"..add_monster_table[castle_name][i][1].."出错！")
            return
        end
    end

    for i = 1, table.getn(remove_npc_table[castle_name]) do
        if not lualib:Map_RemoveNpc(dst_map_guid, remove_npc_table[castle_name][i]) then
            lualib:Print(castle_name.."移除NPC"..remove_npc_table[castle_name][i].."出错！")
            return
        end
    end

    for i = 1, table.getn(remove_monster_table[castle_name]) do
        if not lualib:Map_RemoveMonster(dst_map_guid, remove_monster_table[castle_name][i]) then
            lualib:Print(castle_name.."移除怪物"..remove_monster_table[castle_name][i].."出错！")
            return
        end
    end
end

function on_castle_war_end(castle_name, dst_map_guid, basilica_map_guid)
    local remove_monster_table = {["神歌城"] = {"神歌城城门", "神歌城殿门1", "神歌城侧城门1", "神歌城侧城门2"}}
    local add_npc_table = {["神歌城"] = {{"神歌城管理人", 335, 203}, {"神歌城药材商", 308, 207}, {"神歌城铁匠", 346, 265}, {"神歌城裁缝", 285, 203}, {"神歌城杂货商", 322, 234}, {"神歌城首饰商", 289, 181}}}
    local add_monster_table = {["神歌城"] = {{"神歌城寺庙", 330, 154}, {"神歌城商会", 319, 198}, {"神歌城军营", 342, 221}}}
    local remove_npc_table = {["神歌城"] = {"城门阻挡1", "城门阻挡2", "城门阻挡3", "城门阻挡4", "城门阻挡5", "城门阻挡6", "城门阻挡7"}}

    for i = 1, table.getn(remove_monster_table[castle_name]) do
        if not lualib:Map_RemoveMonster(dst_map_guid, remove_monster_table[castle_name][i]) then
            lualib:Print(castle_name.."移除怪物"..remove_monster_table[castle_name][i].."出错！")
            return
        end
    end

    for i = 1, table.getn(add_npc_table[castle_name]) do
        if not lualib:Map_GenNpc(dst_map_guid, add_npc_table[castle_name][i][1], add_npc_table[castle_name][i][2],
                add_npc_table[castle_name][i][3], 1, 3) then
            lualib:Print(castle_name.."刷NPC"..add_npc_table[castle_name][i][1].."出错！")
        end
    end

    for i = 1, table.getn(add_monster_table[castle_name]) do
        if not lualib:Map_GenSingleMonster(dst_map_guid, add_monster_table[castle_name][i][2], add_monster_table[castle_name][i][3],
                1, 3, add_monster_table[castle_name][i][1], false) then
            lualib:Print(castle_name.."刷怪"..add_monster_table[castle_name][i][1].."出错！")
            return
        end
    end

    for i = 1, table.getn(remove_npc_table[castle_name]) do
        if not lualib:Map_RemoveNpc(dst_map_guid, remove_npc_table[castle_name][i]) then
            lualib:Print(castle_name.."移除NPC"..remove_npc_table[castle_name][i].."出错！")
            return
        end
    end

    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]攻城战结束了！", "系统通知")
    local own_family = lualib:GetCastleOwnFamily(castle_name)
    if own_family ~= "" then
        lualib:IO_SetCustomVarInt("castlewar_sgc_flag", 1)          --灵元秘境要使用
        lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]被".."["..own_family.."]行会占领了！", "系统通知")
    end

    --清除行会会长领取变量
    lualib:SetCastleCustomVarInt(castle_name, "award_leader_week_count", 0)

    if castle_name == "神歌城" then
        --清除攻城时间
        local castle_var = "神歌城_atk_familys"
        lualib:IO_SetCustomVarStr(castle_var, "")   --T+N时间清除

        --消除武器神歌领取标记
        lualib:IO_SetCustomVarStr("神歌城_leader_weapon", "")
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
        lualib:SysMsg_SendPromptMsg(player, "行会正在与"..wars[k].."行会进行战争！")
    end

    lualib:NotifyRunningFamilyWar(player)
end

function on_first_in_game(player)
    lualib:AddBuff(player, "随机BUFF14", 7200)
    lualib:AddBuff(player, "大力丸300", 7200)

    local playername = lualib:KeyName(player)
    lualib:SysMsg_SendBroadcastMsg("玩家→→["..playername.."]加入了神途,引来了一群人围观，立刻认识了好多朋友，开始了神途之旅！", "系统公告")

    if lualib:Player_GiveItemBind(player, "木棍", 1, "给物品：第一次进游戏", player) then
        lualib:SysMsg_SendTriggerMsg(player, "已获得物品：木棍")
    else
        lualib:SysMsg_SendTriggerMsg(player, "获得物品失败：木棍")
    end

    if lualib:Player_GiveItemBind(player, "新手1级礼包", 1, "给物品：第一次进游戏", player) then
        lualib:SysMsg_SendTriggerMsg(player, "已获得物品：新手1级礼包")
    else
        lualib:SysMsg_SendTriggerMsg(player, "获得物品失败：新手1级礼包")
    end


    lualib:Player_AddGold(player, 30000, true, "加金币：第一次进入游戏金钱奖励", player)
    lualib:Player_AddIngot(player, 0, true, "加元宝：第一次进入游戏元宝奖励", player)

    --体验测试
    local map_guid = lualib:Map_GetMapGuid("巫山城")
    local map_int = lualib:GetInt(map_guid, "experience")

    local item = {
        {
            {"天罪一阶（动态）", "真武战甲（男）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"角龙杖（动画）", "霜晓法袍（男）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"葬影", "傲天道袍(男)", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链","超级护身符"},
        },
        {
            {"天罪一阶（动态）", "真武战甲（女）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"角龙杖（动画）", "霜晓法袍（女）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"葬影", "傲天道袍(女)", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链","超级护身符"},
        },
    }


    --if map_int == 1 then
    local job = lualib:Job(player)
    local gender = lualib:Gender(player)

    lualib:Player_AddGold(player, 1000000, false, "开服前体验", player)
    lualib:Player_AddIngot(player, 10000, false, "开服前体验", player)

    for i = 1, #item[gender][job] do
        if lualib:AddItem(player, item[gender][job][i], 1, false, "测试体验", player) then
            lualib:TakeOn(player, item[gender][job][i])
        end
    end
    lualib:DelayCall(player, 500, "xinshoutao", "")
end

function xinshoutao(player)
    local item = {
        {
            {"天罪一阶（动态）", "真武战甲（男）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"角龙杖（动画）", "霜晓法袍（男）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"葬影", "傲天道袍(男)", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链","超级护身符"},
        },
        {
            {"天罪一阶（动态）", "真武战甲（女）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"角龙杖（动画）", "霜晓法袍（女）", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链", },
            {"葬影", "傲天道袍(女)", "混芒套头盔", "混芒套护腕", "混芒套腰带", "混芒套靴子", "混芒套项链","超级护身符"},
        },
    }
    local gender = lualib:Gender(player)
    local job = lualib:Job(player)
    --自动穿装备
    for i = 1, #item[gender][job] do
        --	lualib:AddItem(player, equip_level_up[gender][i][1], 1, true, "新人发放道具", player)

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
        active_player(player, 2, 1);  --重试登陆请求
    end
end

function do_nothing_retry3(player, errorcode, result)
    if errorcode ~= 0 then
        active_player(player, 3, 1);--重试升级请求
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
    --登陆信息发给web服务器，网站查角色需要 type=3代表 升级请求
    active_player(player, 3, 0)
    lualib:DelayCall(player, 1, "战斗力表单:CalculatePower", "") --更新战斗力
    lualib:DelayCall(player, 1, "手游称号表单:LevelUp", ""..level) --等级称号
    lualib:DelayCall(player, 1, "手游排行榜表单:mainLevel", "") --全职业等级榜
    --调用徒弟升级触发
    process_apprentice_level_up(player, level)
    local playerlevel = lualib:Level(player)
    if playerlevel >= 23 then
        gonglue_xianshi(player) --攻略
    end
end




function level(player, npc)
    return ""
end

--每日签到提示
function on_login(player)
    lualib:DelayCall(player,1,"buff特效资源展示:has_buff","")
    lualib:Player_MapMoveXY(player, "新西域", 100, 166, 3)
    lualib:DelayCall(player, 1, "右上图标:main", "")

    if lualib:GetClientType(player) == 2 then
        lualib:DelayCall(player, 1, "手游商城表单:on_player_login", "")--商城图标
    end

    lualib:DelayCall(player, 1, "手游排行榜表单:mainLevel_Job", "")
    lualib:DelayCall(player, 1, "手游排行榜表单:mainLevel", "")

    --登陆第一次战斗力变化 不显示
    lualib:SetInt(player, "PowerAlterShow", 0)
    lualib:DelayCall(player, 1, "战斗力表单:CalculatePower", "") --记录战斗力
    --测试
    local TestServerTime = lualib:GetConstVar("TestServerTime")
    local StartServerTime = lualib:GetConstVar("StartServerTime")
    local QQ = lualib:GetConstVar("QQ")
    local TestServerTime_int = lualib:Str2Time(TestServerTime)
    local StartServerTime_int = lualib:Str2Time(StartServerTime)
    local times = lualib:GetAllTime()
    local timesStr = lualib:Time2Str( "%Y-%m-%d %H:%M:%S", times)


    ------------------------------------每日变量清零start---------------------------
    if lualib:GetDayInt(player, "isResetVar") == 0 then
        lualib:SetDayInt(player, "isResetVar", 1)
        --清明变量重置
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
        local s1 = "请您加入QQ群："..QQ.."，了解最新消息！"
        if times < StartServerTime_int and  times > TestServerTime_int then
            s = "服务器正在筹备阶段，无法登陆，游戏将于"..StartServerTime.."正式开启，敬请期待！"
            for i = 1, 2 do
                lualib:SysMsg_SendBroadcastMsg(s, "")
                lualib:SysMsg_SendBroadcastMsg(s1, "")
            end
            lualib:AddTimer(player, 723, 2000, 1, "kaifutiren")
            --lualib:Player_Kick(player)
        elseif times < TestServerTime_int then
            s = "服务正在开服前常规测试阶段，将于"..TestServerTime.."结束阶段，介时将删除服务器所有数据，游戏将于"..StartServerTime.."正式开启，敬请期待！请玩家加入QQ群："..QQ.."了解最新消息！"
            for i = 1, 2 do
                lualib:SysMsg_SendBroadcastMsg(s, "")
                lualib:SysMsg_SendBroadcastMsg(s1, "")
            end
        end
    end

    local playerlevel = lualib:Level(player)
    local reinNum = lualib:GetInt(player,  "reinNum")
    --登陆信息发给web服务器，网站查角色需要 type=2代表 登陆请求
    active_player(player, 2, 0)

    --check_forbid_role(player)
    spirit_on_login(player)
    family_on_login(player)
    check_player_login(player)
    online_gift_login(player)
    marry_load(player)
    check_first_bill(player)
    meiriqiandao_xianshi(player) --每日签到图标显示
    QM_Icon_Show(player) --添加清明活动图标
    mubiao_xianshi(player) --目标
    ---------------------------------------------------
    WY_Icon_Show(player)--五一活动图标
    Login_GetWYAward(player)
    HF_on_login(player)
    ---------------------------------------------------

    if playerlevel >= 23 then
        gonglue_xianshi(player) --攻略
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
            local s = "尊贵的VIP玩家【"..vip_player_name.."】上线了！"
            lualib:SysMsg_SendBroadcastMsg(s, "")
        end
    end

    lualib:AddTimerEx(player, 116, 900000, -1, "fangchenmi", "")

    --调用师徒登录触发
    process_master_apprentice_login(player)
    lualib:AddTrigger(player,lua_trigger_add_exp,"add_exp") --每次增加经验时候调用，vip经验继承中的需要

    lingqujingyan_xianshi(player) --领取经验图标显示
end

function fangchenmi(player)
    local msg = ""
    local AntiIndulge = lualib:Player_GetAntiIndulge(player)
    print(AntiIndulge)
    if AntiIndulge == 2 then
        return
    elseif AntiIndulge == 1 then
        msg = "你当前已经进入防沉迷状态，你的经验收益减半，请尽快将进行防沉迷验证！\n"
        msg = msg.."<@InfoIndulge *01*防沉迷>\n"
        msg = msg.."<@VerifyIndulge *01*防沉迷验证>\n"
        lualib:NPCTalk(player, msg)
    elseif AntiIndulge == 0 then
        msg = "你当前已经进入防沉迷状态，无经验收益，请尽快将进行防沉迷验证！"
        msg = msg.."<@InfoIndulge *01*防沉迷>\n"
        msg = msg.."<@VerifyIndulge *01*防沉迷验证>\n"
        lualib:NPCTalk(player, msg)
    end
end

function InfoIndulge(player)
    lualib:ShowForm(player, "防沉迷表单")
    return ""
end

function VerifyIndulge(player)
    local userid = lualib:Player_GetAccountID(player)
    lualib:SysMsg_SendWebMsg(player, "防沉迷验证", "http://passport.173uu.com/verifygame/index.html?uid="..userid, "")
    return ""
end


------------------------------------获得经验时触发------------------------------------
function add_exp(player,exp)
    lualib:SetInt(player,"vip20_jinriexp",lualib:GetInt(player,"vip20_jinriexp")+exp)
end

function notify_spouse(player)
    local player_name = lualib:Player_GetStrProp(player,  lua_role_user_name)
    local spouse = lualib:Player_GetCustomVarStr(player, "配偶GUID")

    if lualib:Player_GetIntProp(player,  lua_role_gender) ==  lua_gender_male then
        lualib:SysPromptMsg(spouse, "你的丈夫上线了。")
    else
        lualib:SysPromptMsg(spouse, "你的妻子上线了。")
    end

end



function on_login_delay_timer(player, timer_id)
    if lualib:GetBindIngot(player) < 1000000 then
        lualib:AddBindIngot(player,100000,"","")
    end
    if lualib:Player_IsGM(player) then
        lualib:AddBuff(player,"疾驰",86400)
        lualib:Player_SetGhost(player, true)
        lualib:SysMsg_SendWarnMsg(player, "你已进入隐身状态！")
        lualib:Player_SetInvincible(player, true)
        lualib:SysMsg_SendWarnMsg(player, "你已进入无敌状态！")
    end

    local seconds = lualib:Player_GetCustomVarInt(player, "player_total_offline_times")
    local day = math.floor(seconds / 3600 / 24)
    local hour = math.floor((seconds - day * 24 * 3600) / 3600)
    local minute = math.floor((seconds - math.floor(seconds / 3600) * 3600) / 60)
    local second = math.floor(seconds - math.floor(seconds / 60) * 60)

    if seconds < 3600 then
        lualib:SysMsg_SendWarnMsg(player, "系统通知：你可以到天机老人处领取在线和离线经验！注意在线时间不累计，需要连续在线！")
        return
    end

    lualib:SysMsg_SendWarnMsg(player, "系统通知：你可以到天机老人处领取在线和离线经验！注意在线时间不累计，需要连续在线！")
    notify_spouse(player)
end

function on_logout(player)
    local npc_guid_cangku = lualib:Player_GetCustomVarStr(player, "yang_cangkuguid_name")
    local npc_guid_shangdian = lualib:Player_GetCustomVarStr(player, "yang_shangdianguid_name")
    --调用师徒登出触发
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
    --判断有几张地图在本GS上
    local map_table = {{"妖山暗穴1", 0, 181, 59,  "寻宝小妖1"},
                       {"妖山暗穴2", 0, 156, 274, "寻宝小妖2"},
                       {"妖山暗穴3", 0, 250, 57,  "寻宝小妖3"},
                       {"妖山暗穴4", 0, 279, 240, "寻宝小妖4"},
                       {"妖山暗穴5", 0, 350, 161, "寻宝小妖5"}}
    local map_count = 0
    for i = 1, table.getn(map_table) do
        if lualib:Map_IsInGS(map_table[i][1]) == true then
            map_count = map_count + 1
            map_table[i][2] = map_count
        end
    end

    if map_count == 0 then return "" end

    --从存在于本GS的地图中随机选一张
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

    --在随机到的地图上刷怪
    local map = lualib:Map_GetMapGuid(cur_map_keyname)
    if map == "" then return "" end

    local monster = lualib:Map_GenSingleMonster(map, map_table[cur_map_index][3],
            map_table[cur_map_index][4], 16, 3,
            map_table[cur_map_index][5], true)
    if monster == "" then return "" end
    lualib:Print(cur_map_keyname.."："..map_table[cur_map_index][5].."生成成功！坐标：["..map_table[cur_map_index][3].."，"..map_table[cur_map_index][4].."]。")
    return ""
end


function on_gp(player, gp_runtime, gp, diff_avg_tick)
    local content = "请爱护游戏环境！["..lualib:Name(player).."] 使用外挂，已被系统记录在案。"
    lualib:SysMsg_SendWarnMsg(player, content)
    lualib:SetFbdLogin(lualib:Name(player), 2, 600, content)
    lualib:Player_Kick(player)
end

function shijie_boss(guid, timer_id)
    local a = lualib:GenRandom(1, #map_name_table)
    local b = lualib:GenRandom(1, #map_name_table)
    local g = lualib:GenRandom(1, #map_name_table)
    local mon_name = "天魔神幻像"
    local map_name = "龙城"
    local map_guid =  lualib:Map_GetMapGuid(map_name)
    local map_time_zdy = lualib:Map_GetCustomVarInt(map_guid, "map_time_zdy")
    local npc_time_zdy = lualib:Map_GetCustomVarInt(map_guid, "npc_time_zdy")

    local mon_ma_name1 = "汗血野马"
    local mon_ma_name2 = "稀有坐骑"
    local map_time_ma_zdy = lualib:Map_GetCustomVarInt(map_guid, "map_time_ma_zdy")
    local quxiao_duyu_jc = lualib:Map_GetCustomVarInt(map_guid, "quxiao_duyu_jc")

    --local npc_guid = lualib:Map_GenNpc(map, "随身仓库服务员", player_x, player_y, 1, 3)

    map_time_zdy = map_time_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "map_time_zdy", map_time_zdy)

    map_time_ma_zdy = map_time_ma_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "map_time_ma_zdy", map_time_ma_zdy)

    npc_time_zdy = npc_time_zdy + 60
    lualib:Map_SetCustomVarInt(map_guid, "npc_time_zdy", npc_time_zdy)

    for q, r in pairs(npc_timer_table) do
        if npc_time_zdy == r[1] then
            lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人将在"..r[2].."后降临天藏大陆。", "系统公告")
            lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人将在"..r[2].."后降临天藏大陆。", "系统公告")
            lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人将在"..r[2].."后降临天藏大陆。", "系统公告")
        end
    end

    if npc_time_zdy > 3593 then
        for n, m in pairs(map_name_table) do
            if a == n then
                local map = lualib:Map_GetMapGuid(m[1])
                local map_xy_table = lualib:MapRndPos(m[1])
                local map_x = map_xy_table["x"]
                local map_y = map_xy_table["y"]
                local npc_guid = lualib:Map_GenNpc(map, "神秘商人", map_x, map_y, 1, 3)
                lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人降临天藏大陆，有缘邂逅者可购买大量超值仙界至宝，神秘商人现在在【"..m[2].."】等待有缘人！。", "系统公告")
                lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人降临天藏大陆，有缘邂逅者可购买大量超值仙界至宝，神秘商人现在在【"..m[2].."】等待有缘人！。", "系统公告")
                lualib:SysMsg_SendBroadcastMsg("紫气东来，神秘商人降临天藏大陆，有缘邂逅者可购买大量超值仙界至宝，神秘商人现在在【"..m[2].."】等待有缘人！。", "系统公告")
                lualib:Map_SetCustomVarInt(map_guid, "npc_time_zdy", 0)
            end
        end
    end

    if quxiao_duyu_jc == 0 then
        for i, p in pairs(timer_table) do
            if map_time_zdy == p[1] then
                lualib:SysMsg_SendBroadcastMsg("世界BOSS["..mon_name.."]将在"..p[2].."分钟后降临天藏大陆，想挑战的勇士请做好准备。", "系统公告")
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
                    lualib:SysMsg_SendBroadcastMsg("世界BOSS["..mon_name.."]出现在地图"..v[2].."，想挑战的勇士请迅速前往击杀。", "系统公告")
                    lualib:SysMsg_SendBroadcastMsg("世界BOSS["..mon_name.."]出现在地图"..v[2].."，想挑战的勇士请迅速前往击杀。", "系统公告")
                    lualib:SysMsg_SendBroadcastMsg("世界BOSS["..mon_name.."]出现在地图"..v[2].."，想挑战的勇士请迅速前往击杀。", "系统公告")
                    lualib:Map_SetCustomVarInt(map_guid, "quxiao_duyu_jc", 1)
                end
            end
        end
    end

    for c, d in pairs(ma_timer_table) do
        if map_time_ma_zdy == d[1] then
            lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑将在"..d[2].."分钟后降临天藏大陆，只有一只哦！这可是捕捉它的好时机哦。", "系统公告")
            lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑将在"..d[2].."分钟后降临天藏大陆，只有一只哦！这可是捕捉它的好时机哦。", "系统公告")
            lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑将在"..d[2].."分钟后降临天藏大陆，只有一只哦！这可是捕捉它的好时机哦。", "系统公告")
        end
    end

    if map_time_ma_zdy > 28798 then	--8小时
        for e, f in pairs(map_name_table) do
            if g == e then
                local map = lualib:Map_GetMapGuid(f[1])
                lualib:Map_BatchGenMonster(map, mon_ma_name1, 5, false)
                lualib:Map_BatchGenMonster(map, mon_ma_name2, 1, false)
                lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑出现在天藏大陆的【"..f[2].."】，只有一只哦！想要捕捉它的英雄抓紧时间了。", "系统公告")
                lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑出现在天藏大陆的【"..f[2].."】，只有一只哦！想要捕捉它的英雄抓紧时间了。", "系统公告")
                lualib:SysMsg_SendBroadcastMsg("珍贵的稀有坐骑出现在天藏大陆的【"..f[2].."】，只有一只哦！想要捕捉它的英雄抓紧时间了。", "系统公告")
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
        --超出1天，重新计数
        lualib:Player_SetCustomVarInt(player, "login_days", 1)
    elseif off_day == 1 then
        --连续登录，累加
        local cur_days = lualib:Player_GetCustomVarInt(player, "login_days")
        lualib:Player_SetCustomVarInt(player, "login_days", cur_days + 1)
    end

    lualib:Player_SetCustomVarInt(player, "last_login_day", now)
    lualib:OnGloryTrigger(player, lua_glory_trigger_Login, "", 0, "", "")

    lualib:AddTimer(player, 0, 60000, -1, "CheckOnlineTimer")

    local player_guild = lualib:GuildGuid(player)

    if player_guild ~= "0" and player_guild ~= "" then--角色上线时判断是否有行会
        lualib:OnGloryTrigger(player, lua_glory_trigger_join_family, "", 0, "", "")
        --lualib:Print("玩家的行会"..player_guild.."")
    end

end

function CheckOnlineTimer(player, timer_id)
    lualib:OnGloryTrigger(player, lua_glory_trigger_OnlineTime, "", 0, "", "")
end

function chuandaiqian(player, item, item_id, item_keyname)
    lualib:DelayCall(player, 1, "战斗力表单:updatePower", "")--更新战斗力
    if lualib:Item_GetSubType(player, item) == 10 then
        if item_keyname == "国庆特别徽章" then
            lualib:AddBuff(player, "中秋", 0)
        elseif item_keyname == "建国荣誉徽章" then
            lualib:AddBuff(player, "国庆", 0)
        end
    else
        return
    end
end

function tuozhuangbei(player, item, item_id, item_keyname)
    lualib:DelayCall(player, 1, "战斗力表单:updatePower", "")--更新战斗力
    if lualib:Item_GetSubType(player, item) == 10 then
        if item_keyname == "国庆特别徽章" then
            lualib:DelBuff(player, "中秋")
        elseif item_keyname == "建国荣誉徽章" then
            lualib:DelBuff(player, "国庆")
        end
    end

    --同心勋章
    local xz_table = {"同心勋章一级", "同心勋章二级", "同心勋章三级", "同心勋章四级", "同心勋章五级", "同心勋章六级" }
    for i = 1, #xz_table do
        if item_keyname == xz_table[i] then
            lualib:DelBuff(player, "同心连理")
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

    if not lualib:StartCastleWar("神歌城", familys_str, times, 7200) == false then
        return false
    end
end

--------------杀人回调------------------
function on_trigger_kill(killer, victim)
    victim_name = lualib:KeyName(victim)

    if lualib:Monster_IsMonster(victim) and lualib:Monster_Type(victim_name) == 2 then
        --目标系统：猎杀1只精英怪
        if lualib:GetInt(killer,"mubiao_chumo_1") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 1 then
                lualib:SetInt(killer,"mubiao_chumo_1",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀1只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀1只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀10只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_2") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 10 then
                lualib:SetInt(killer,"mubiao_chumo_2",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀10只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀10只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀100只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_3") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 100 then
                lualib:SetInt(killer,"mubiao_chumo_3",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀100只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀100只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀500只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_4") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 500 then
                lualib:SetInt(killer,"mubiao_chumo_4",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀500只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀500只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀1000只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_5") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 1000 then
                lualib:SetInt(killer,"mubiao_chumo_5",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀1000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀1000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀2000只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_6") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 2000 then
                lualib:SetInt(killer,"mubiao_chumo_6",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀2000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀2000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀5000只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_7") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 5000 then
                lualib:SetInt(killer,"mubiao_chumo_7",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀5000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀5000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
            --目标系统：猎杀10000只精英怪
        elseif lualib:GetInt(killer,"mubiao_chumo_8") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_chumo_shuliang") + 1

            if shuliang >= 10000 then
                lualib:SetInt(killer,"mubiao_chumo_8",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀10000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀10000只精英怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_chumo",lualib:GetInt(killer,"mubiao_chumo")+1) --除魔进度+1
            end
            lualib:SetInt(killer,"mubiao_chumo_shuliang",shuliang)
        end
    end

    if lualib:Monster_IsMonster(victim) and lualib:Monster_Type(victim_name) == 4 then
        --目标系统：猎杀1只boss怪
        if lualib:GetInt(killer,"mubiao_boss_1") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 1 then
                lualib:SetInt(killer,"mubiao_boss_1",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀1只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀1只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀10只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_2") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 10 then
                lualib:SetInt(killer,"mubiao_boss_2",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀10只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀10只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀50只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_3") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 50 then
                lualib:SetInt(killer,"mubiao_boss_3",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀50只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀50只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀100只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_4") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 100 then
                lualib:SetInt(killer,"mubiao_boss_4",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀100只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀100只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀200只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_5") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 200 then
                lualib:SetInt(killer,"mubiao_boss_5",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀200只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀200只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀500只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_6") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 500 then
                lualib:SetInt(killer,"mubiao_boss_6",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀500只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀500只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
            --目标系统：猎杀1000只boss怪
        elseif lualib:GetInt(killer,"mubiao_boss_7") == 0 then
            local shuliang = lualib:GetInt(killer,"mubiao_boss_shuliang") + 1

            if shuliang >= 1000 then
                lualib:SetInt(killer,"mubiao_boss_7",1)
                lualib:SysMsg_SendBoardMsg(killer, "目标追求", "”猎杀1000只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！", 15000)
                lualib:SysMsg_SendWarnMsg(killer,"“猎杀1000只boss怪“已达成，请打开#COLORCOLOR_GREENG#目标面板#COLOREND#领取奖励吧！")
                lualib:SetInt(killer,"mubiao_boss",lualib:GetInt(killer,"mubiao_boss")+1) --boss进度+1
            end
            lualib:SetInt(killer,"mubiao_boss_shuliang",shuliang)
        end
    end
end

--离线挂机

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
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("巫山城"), player, x, y, 10)
                return false
            elseif	guaji_level >= 40 and guaji_level < 50 then
                local rx = lualib:GenRandom(-8,8)
                local ry = lualib:GenRandom(-8,8)
                local x = 237 + rx
                local y = 228 + ry
                lualib:SetOffline(player, 7200)
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("龙城"), player, x, y, 10)
                return false
            elseif	guaji_level >= 50  then
                local rx = lualib:GenRandom(-8,8)
                local ry = lualib:GenRandom(-8,8)
                local x = 327 + rx
                local y = 299 + ry
                lualib:SetOffline(player, 7200)
                lualib:Map_JumpXY(lualib:Map_GetMapGuid("东临城"), player, x, y, 10)
                return false
            end

        end
    else
        return true
    end

end

--骑马和下马

-- 上马

function on_ride_request(player)
    local buff_table = {"白茅人变身卡", "木器人变身卡", "花蜘蛛变身卡", "顽猴变身卡", "蛟人变身卡", "铁齿战将变身卡", "飞芒变身卡", "邪魔人偶变身卡", "树妖变身卡", "噬灵妖花变身卡", "妖面监工变身卡", "鬼面监工变身卡", "妖刀侍卫变身卡", "赤面猴变身卡", "绝道白猿变身卡", "巨蛾变身卡", "野狼变身卡", "神兽变身卡", "红面牛魔变身卡", "牛魔将军变身卡", "巨蛇变身卡", "黑水蛇变身卡", "白狼变身卡", "刀奴变身卡", "散兵变身卡", "沙石魔变身卡", "风魔变身卡", "夜行僧变身卡", "黑暗刺客变身卡", "梵天僧变身卡", "天原死士变身卡", "血禅师变身卡", "骷髅王变身卡", "飞刀骷髅变身卡", "骷髅战将变身卡", "尸奴工头变身卡", "僵尸变身卡", "雷暴僵尸变身卡", "墓地蛆虫变身卡", "幽冥尸王变身卡", "鹿变身卡", "千年树魔变身卡", "白茅怪人变身卡", "白茅邪人变身卡", "毒蜘蛛变身卡", "天狼蜘蛛变身卡", "泼猴变身卡", "凶暴猿猴变身卡", "猿猴变身卡", "飞蛾变身卡", "毒蛾变身卡", "苍狼变身卡", "青蛇变身卡", "红蛇变身卡", "白蛇变身卡", "蟒蛇变身卡", "蛇蛟变身卡", "古怪刀客变身卡", "鬼面刀手变身卡", "双刀侩子手变身卡", "魔兵变身卡", "蓝兽变身卡", "妖僧变身卡", "鬼面武者变身卡", "影刺变身卡", "骷髅战士变身卡", "单刀骷髅变身卡", "大斧骷髅变身卡", "飞萤变身卡", "魔萤变身卡", "邪翅变身卡", "食人花变身卡", "天原勇士变身卡", "天原猛士变身卡", "黑面牛魔变身卡", "牛魔勇士变身卡", "牛魔守卫变身卡", "爬尸变身卡", "尸卫变身卡", "腐尸变身卡", "掘铲尸奴变身卡", "铁镐尸奴变身卡", "尸奴变身卡", "骷髅宝宝变身卡", "老母猪变身卡", "小猪变身卡", "羊变身卡", "牛变身卡", "鸡变身卡", "饿鬼蛛变身卡", "剧毒蛛变身卡", "魔蛇变身卡", "魔狼变身卡", "魔猿变身卡", "巨石傀儡变身卡", "牛魔侍卫变身卡", "魔化蜥蜴变身卡", "魔化蝎子变身卡", "魔化沙虫变身卡", "天魔妖蟒变身卡", "恶战天魔变身卡", "天魔奴仆变身卡", "夜灵变身卡", "天魔统领变身卡", "天魔守卫变身卡", "天魔妖道变身卡", "天魔先锋变身卡", "天魔神变身卡", "深海巨螯怪变身卡", "石甲鱼变身卡", "秘境海妖变身卡", "巨钳蟹变身卡", "海魔侍从变身卡", "海魔护卫变身卡", "秘境歌妖变身卡", "铁棘鱼变身卡", "铁螯怪变身卡", "巨人药剂", "武斗场麻布衣男", "武斗场麻布衣女", "武斗场轻型战衣男", "武斗场轻型战衣女", "武斗场元灵铠甲男", "武斗场元灵铠甲女", "武斗场轻便铠甲男", "武斗场轻便铠甲女", "武斗场黄金铠甲男", "武斗场黄金铠甲女", "武斗场赤峰战甲男", "武斗场赤峰战甲女", "武斗场百裂战甲男", "武斗场百裂战甲女", "武斗场熔岩战甲男", "武斗场熔岩战甲女", "武斗场龙鳞战甲男", "武斗场龙鳞战甲女", "武斗场见习法师袍男", "武斗场见习法师袍女", "武斗场紫绸长袍男", "武斗场紫绸长袍女", "武斗场魔力法袍男", "武斗场魔力法袍女", "武斗场阎罗长袍男", "武斗场阎罗长袍女", "武斗场圣灵法衣男", "武斗场圣灵法衣女", "武斗场火麟法袍男", "武斗场火麟法袍女", "武斗场璃梦法袍男", "武斗场璃梦法袍女", "武斗场乾坤道衣男", "武斗场乾坤道衣女", "武斗场天心道衣男", "武斗场天心道衣女", "武斗场降魔道衣男", "武斗场降魔道衣女", "武斗场光明道袍男", "武斗场光明道袍女", "武斗场太玄道袍男", "武斗场太玄道袍女", "武斗场玄清道衣男", "武斗场玄清道衣女", "武斗场天鼎道袍男", "武斗场天鼎道袍女", "武斗场变身", "缩小药剂", "变身2", "变猪术"}
    local hashorse = lualib:Attr(player, 200)

    if hashorse == 1 then
        lualib:MsgBox(player, "你已经处于骑乘状态了！")
        return
    end
    for i = 1, #buff_table do
        if lualib:HasBuff(player, buff_table[i]) == true then
            lualib:MsgBox(player, "变身状态无法骑马，请右键点击BUFF图标取消BUFF后再进行尝试")
            return
        end
    end
    lualib:ProgressBarStart(player, 5000, "上马中", "on_Horse_true", "on_Horse_false", "")
end

function on_Horse_true(player)
    lualib:Ride(player)
    return true
end

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

local rongyaozhuangbei = {
    ["战神之证1"] = 1000,
    ["战神之证2"] = 5000,
    ["战神之证3"] = 15000,
    ["血魂之靴"] = 15000,
    ["战神之证4"] = 32000,
    ["血魂护腕(神)"] = 32000,
    ["血魂护腕(圣)"] = 32000,
    ["血魂头盔"] = 32000,
    ["战神之证5"] = 55000,
    ["血魂项链"] = 55000,
    ["血魂戒指(神)"] = 55000,
    ["血魂戒指(圣)"] = 55000,
    ["战神之证"] = 88000,
    ["狼牙"] = 88000,
    ["战神宝甲(男)"] = 88000,
    ["战神宝甲(女)"] = 88000,
    ["法神之证1"] = 1000,
    ["法神之证2"] = 5000,
    ["法神之证3"] = 15000,
    ["冰魄之靴"] = 15000,
    ["法神之证4"] = 32000,
    ["冰魄护腕(神)"] = 32000,
    ["冰魄护腕(圣)"] = 32000,
    ["冰魄头盔"] = 32000,
    ["法神之证5"] = 55000,
    ["冰魄项链"] = 55000,
    ["冰魄戒指(神)"] = 55000,
    ["冰魄戒指(圣)"] = 55000,
    ["法神之证"] = 88000,
    --["怒海"] = 88000,
    ["法神长袍(男)"] = 88000,
    ["法神长袍(女)"] = 88000,
    ["道尊之证1"] = 1000,
    ["道尊之证2"] = 5000,
    ["道尊之证3"] = 15000,
    ["月殇之靴"] = 15000,
    ["道尊之证4"] = 32000,
    ["月殇护腕(神)"] = 32000,
    ["月殇护腕(圣)"] = 32000,
    ["月殇头盔"] = 32000,
    ["道尊之证5"] = 55000,
    ["月殇项链"] = 55000,
    ["月殇戒指(神)"] = 55000,
    ["月殇戒指(圣)"] = 55000,
    ["道尊之证"] = 88000,
    ["星矢"] = 88000,
    ["道神宝衣(男)"] = 88000,
    ["道神宝衣(男)"] = 88000,
}

--------------------------穿上装备之前触发-------------------------------------
function on_pre_equip(player,item,item_id,item_key)
    local shizhuang = lualib:KeyName(item)

    if rongyaozhuangbei[shizhuang] ~= nil then
        if lualib:GetInt(player, "jyjjc_rongyao") >= rongyaozhuangbei[shizhuang] then
        else
            lualib:SysMsg_SendWarnMsg(player,"此装备需要"..rongyaozhuangbei[shizhuang].."荣耀才可装备！")
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
            --击杀BOSS活动时间内掉落金筝
            lualib:Map_GenItemRnd(lualib:MapGuid(killer), lualib:X(monster), lualib:Y(monster), 1, "金筝", 1, true, 0)
        end
        ------------------------------------------------------------------------------------
        if WY_JudgeTime() then
            local rand = lualib:GenRandom(0, 1)
            if rand == 1 then
                lualib:Map_GenItemRnd(lualib:MapGuid(killer), lualib:X(monster), lualib:Y(monster), 1, "灵液", 1, true, 0)
            end
        end
        ------------------------------------------------------------------------------------
    end
end

function on_billin(player,dc_yb)
    --合服活动充值
    HF_on_bill(player, dc_yb)
    ---------------------------------------------------------------------
    --Billin_RechargeYB(player, dc_yb)
    ---------------------------------------------------------------------
    bill_ranking(player)
end

function bill_ranking(player)
    --充值回调
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