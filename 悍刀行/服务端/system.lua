local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("include/攻城战玩法")
require("system/自动打怪")
require("system/online_gift")
require("system/充值礼包")
require("system/微信礼包")
require("system/灵丹妙药")
require("system/埋剑山庄")
require("form/日充礼包表单")
require("system/手游下载")


function on_system_start()

    if lualib:GetDBNum("hequbs") == 0 then
        lualib:SetDBNumEx("hequbs", 1, 4)
    end
    lualib:AddTrigger("", lua_trigger_login, "on_player_login");
    lualib:AddTrigger("", lua_trigger_add_exp, "on_player_add_exp");		--经验增加时
    lualib:AddTrigger("", lua_trigger_pre_logout, "on_pre_logout");
    lualib:DelayCall("", 1, "OnFirstCastleWar", "");		--第一次攻城战
    lualib:AddTrigger("0",  lua_trigger_billin, "on_trigger_billin")--充值回调
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")				--升级触发
    lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")				--反外挂触发
    lualib:AddTrigger("0",  363, "on_ride_request")  --上马触发
    lualib:AddTrigger("0",  364, "on_unride_request")  --下马触发
    lualib:AddTrigger("0", 302, "on_post_equip") --穿戴触发
    lualib:AddTrigger("0",  lua_trigger_player_relive, "on_player_relive") --复活前回调
    lualib:AddTrigger("0",  lua_trigger_post_die, "on_post_die") --死亡时回调
    lualib:AddTrigger("0", lua_trigger_hack_check, "on_hack_check");
    lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2");
    lualib:AddTrigger("0",  356, "on_player_pre_die")  --死前触发
    lualib:AddTrigger("0", lua_trigger_post_drop_one, "on_post_drop_one");
    lualib:AddTrigger("",  lua_trigger_item_pickup, "on_item_pickup") --角色拾取道具时回调.
    lualib:AddTrigger("0",  lua_trigger_monster_post_die, "on_post_monster_die")  --死前触发
    lualib:AddTrigger("0",  lua_trigger_family_ntf, "on_family_ntf")  --行会创建
    lualib:AddTrigger("0", lua_trigger_family_member_ntf, "on_family_member_ntf") --行会人员变动
    lualib:AddTrigger("0", lua_trigger_role_pre_harm , "on_pre_harm") --受伤害时
    lualib:AddTrigger("0", lua_trigger_pre_equip, "on_pre_equip") --穿装备之前触发
    lualib:AddTrigger("0", lua_trigger_pre_un_equip, "on_pre_un_equip") --脱装备之前触发
    lualib:AddTrigger("0",  lua_trigger_player_pre_die, "on_pre_player_die")
    lualib:AddTrigger("0",  lua_trigger_kill, "on_kill")--杀手回调
    lualib:AddTrigger("0", lua_trigger_pre_spell, "on_pre_spell"); --使用技能前
    lualib:AddTrigger("0", 307, "on_spell"); --使用技能
    lualib:AddTrigger("0", lua_trigger_item_appear, "on_item_appear");
    lualib:AddTrigger("0", lua_trigger_item_disappear, "on_item_disappear");
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start") --攻城开始
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end") --攻城结束
    lualib:AddTrigger("0", lua_trigger_enter_map, "on_enter_map") --进入地图时
    lualib:AddTrigger("0", 374, "on_pre_harm")-- 374	lua_trigger_role_pre_harm	角色受到伤害时触发，返回固定伤害数值

end


function on_enter_map(player)
    if lualib:GetInt(player, "huishou_10") == 1 then
        lualib:Player_RunScript(player,"自动挂机:baobao","")
    end
end



----------------------------攻城开始
function on_castle_war_start(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SetDBNum("shengeshuxing", 1)
    lualib:SetInt("0", "war_start", 1)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]攻城战开始了！", "系统通知")
    lualib:SetDBNumEx("shengeshuxing", 1, 2)

    if lualib:GetDBNum("diyicishuaxin") == 0 then   -- 第一次攻城记录变量
        lualib:SetDBNumEx("diyicishuaxin", 1, 2)
    end
    return
end



----------------------------攻城关闭

function on_castle_war_end(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SetDBNum("shengeshuxing", 0)
    lualib:SetDBNumEx("shengeshuxing", 0, 2)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]攻城战结束了！", "系统通知")
    lualib:SetInt("0", "war_start", 0)
    local own_family = lualib:GetCastleOwnFamily(castle_name)
    if own_family ~= "" then
        lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]被".."["..own_family.."]行会占领了！", "系统通知")
        lualib:SetDBNumEx(lualib:GetFamilyByName(own_family).."_gongcheng", 1, 6)
        lualib:SysMsg_SendBroadcastMsg("["..own_family.."]行会会长可到【攻沙奖励】处领取钻石奖励！", "系统通知")
        if lualib:GetDBNum("diyicgongcheng") == 0 then
            lualib:SetDBNumEx("diyicgongcheng", 1, 2)
        end
    end

end


function on_pre_spell(player, skill_id, skill_key,x,y,mb,skillkey)

    if lualib:Monster_IsMonster(player) and lualib:Name(player) ~= "跟屁虫" then
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
            if lualib:HasBuff(actor,"剑开天门") then
                lualib:AddIntegral(killer, 50000, "添加绑定金币:原因", "发起者")
                lualib:DelBuff(actor, "剑开天门")
                local level = lualib:Level(actor)
                lualib:SetLevel(actor, level - 5)
                lualib:SysMsg_SendBroadcastColor("【"..lualib:Name(killer).."】击杀了携带“剑开天门”的["..lualib:Name(actor).."]，获得了50000钻石的奖励！", "", 1, 12)
                lualib:SetInt(killer, "ls_zs", lualib:GetInt(killer, "ls_zs") + 1)
            end
        end
    end
end



local wupinsz = {
    ["鞋子2"] = {0, 1},
    ["腰带2"] = {0, 1},
    ["戒指2"] = {0, 1},
    ["手镯2"] = {0, 1},
    ["项链2"] = {0, 1},
    ["头盔2"] = {0, 1},
    ["鞋子3"] = {0, 1},
    ["腰带3"] = {0, 1},
    ["戒指3"] = {0, 1},
    ["手镯3"] = {0, 1},
    ["项链3"] = {0, 1},
    ["头盔3"] = {0, 1},
    ["鞋子4"] = {0, 2},
    ["腰带4"] = {0, 2},
    ["戒指4"] = {0, 2},
    ["手镯4"] = {0, 2},
    ["项链4"] = {0, 2},
    ["头盔4"] = {0, 2},
    ["鞋子5"] = {0, 2},
    ["腰带5"] = {0, 2},
    ["戒指5"] = {0, 2},
    ["手镯5"] = {0, 2},
    ["项链5"] = {0, 2},
    ["头盔5"] = {0, 2},
    ["鞋子6"] = {0, 3},
    ["腰带6"] = {0, 3},
    ["戒指6"] = {0, 3},
    ["手镯6"] = {0, 3},
    ["项链6"] = {0, 3},
    ["头盔6"] = {0, 3},
    ["鞋子7"] = {0, 3},
    ["腰带7"] = {0, 3},
    ["戒指7"] = {0, 3},
    ["手镯7"] = {0, 3},
    ["项链7"] = {0, 3},
    ["头盔7"] = {0, 3},
    ["鞋子8"] = {0, 4},
    ["腰带8"] = {0, 4},
    ["戒指8"] = {0, 4},
    ["手镯8"] = {0, 4},
    ["项链8"] = {0, 4},
    ["头盔8"] = {0, 4},
    ["鞋子9"] = {0, 4},
    ["腰带9"] = {0, 4},
    ["戒指9"] = {0, 4},
    ["手镯9"] = {0, 4},
    ["项链9"] = {0, 4},
    ["头盔9"] = {0, 4},
    ["鞋子10"] = {0, 5},
    ["腰带10"] = {0, 5},
    ["戒指10"] = {0, 5},
    ["手镯10"] = {0, 5},
    ["项链10"] = {0, 5},
    ["头盔10"] = {0, 5},
    ["鞋子11"] = {0, 6},
    ["腰带11"] = {0, 6},
    ["戒指11"] = {0, 6},
    ["手镯11"] = {0, 6},
    ["项链11"] = {0, 6},
    ["头盔11"] = {0, 6},
    ["鞋子12"] = {0, 7},
    ["腰带12"] = {0, 7},
    ["戒指12"] = {0, 7},
    ["手镯12"] = {0, 7},
    ["项链12"] = {0, 7},
    ["头盔12"] = {0, 7},
    ["鞋子13"] = {0, 8},
    ["腰带13"] = {0, 8},
    ["戒指13"] = {0, 8},
    ["手镯13"] = {0, 8},
    ["项链13"] = {0, 8},
    ["头盔13"] = {0, 8},
    ["鞋子14"] = {0, 9},
    ["腰带14"] = {0, 9},
    ["戒指14"] = {0, 9},
    ["手镯14"] = {0, 9},
    ["项链14"] = {0, 9},
    ["头盔14"] = {0, 9},
    ["鞋子15"] = {1, 10},
    ["腰带15"] = {1, 10},
    ["戒指15"] = {1, 10},
    ["手镯15"] = {1, 10},
    ["项链15"] = {1, 10},
    ["头盔15"] = {1, 10},
    ["鞋子16"] = {1, 1},
    ["腰带16"] = {1, 1},
    ["戒指16"] = {1, 1},
    ["手镯16"] = {1, 1},
    ["项链16"] = {1, 1},
    ["头盔16"] = {1, 1},
    ["鞋子17"] = {1, 2},
    ["腰带17"] = {1, 2},
    ["戒指17"] = {1, 2},
    ["手镯17"] = {1, 2},
    ["项链17"] = {1, 2},
    ["头盔17"] = {1, 2},
    ["鞋子18"] = {1, 3},
    ["腰带18"] = {1, 3},
    ["戒指18"] = {1, 3},
    ["手镯18"] = {1, 3},
    ["项链18"] = {1, 3},
    ["头盔18"] = {1, 3},
    ["鞋子19"] = {1, 4},
    ["腰带19"] = {1, 4},
    ["戒指19"] = {1, 4},
    ["手镯19"] = {1, 4},
    ["项链19"] = {1, 4},
    ["头盔19"] = {1, 4},
    ["鞋子20"] = {1, 5},
    ["腰带20"] = {1, 5},
    ["戒指20"] = {1, 5},
    ["手镯20"] = {1, 5},
    ["项链20"] = {1, 5},
    ["头盔20"] = {1, 5},
    ["鞋子21"] = {1, 6},
    ["腰带21"] = {1, 6},
    ["戒指21"] = {1, 6},
    ["手镯21"] = {1, 6},
    ["项链21"] = {1, 6},
    ["头盔21"] = {1, 6},
    ["鞋子22"] = {1, 7},
    ["腰带22"] = {1, 7},
    ["戒指22"] = {1, 7},
    ["手镯22"] = {1, 7},
    ["项链22"] = {1, 7},
    ["头盔22"] = {1, 7},
    ["鞋子23"] = {1, 8},
    ["腰带23"] = {1, 8},
    ["戒指23"] = {1, 8},
    ["手镯23"] = {1, 8},
    ["项链23"] = {1, 8},
    ["头盔23"] = {1, 8},
    ["鞋子24"] = {2, 0},
    ["腰带24"] = {2, 0},
    ["戒指24"] = {2, 0},
    ["手镯24"] = {2, 0},
    ["项链24"] = {2, 0},
    ["头盔24"] = {2, 0},
    ["鞋子25"] = {2, 2},
    ["腰带25"] = {2, 2},
    ["戒指25"] = {2, 2},
    ["手镯25"] = {2, 2},
    ["项链25"] = {2, 2},
    ["头盔25"] = {2, 2},
    ["鞋子26"] = {2, 5},
    ["腰带26"] = {2, 5},
    ["戒指26"] = {2, 5},
    ["手镯26"] = {2, 5},
    ["项链26"] = {2, 5},
    ["头盔26"] = {2, 5},


    ["武器2"] = {0, 2},
    ["武器3"] = {0, 2},
    ["武器4"] = {0, 3},
    ["武器5"] = {0, 3},
    ["武器6"] = {0, 4},
    ["武器7"] = {0, 4},
    ["武器8"] = {0, 5},
    ["武器9"] = {0, 6},
    ["武器10"] = {0, 8},
    ["武器11"] = {0, 9},
    ["武器12"] = {1, 10},
    ["武器13"] = {1, 1},
    ["武器14"] = {1, 2},
    ["武器15"] = {1, 3},
    ["武器16"] = {1, 4},
    ["武器17"] = {1, 5},
    ["武器18"] = {1, 6},
    ["武器19"] = {1, 7},
    ["武器20"] = {1, 8},
    ["武器21"] = {1, 9},
    ["武器22"] = {2, 2},
    ["武器23"] = {2, 2},
    ["武器24"] = {2, 4},
    ["武器25"] = {2, 6},
    ["武器26"] = {2, 8},
    ["武器27"] = {3, 4},
    ["武器28"] = {4, 10},
    ["武器29"] = {5, 10},


    ["衣服2"] = {0, 2},
    ["衣服3"] = {0, 2},
    ["衣服4"] = {0, 3},
    ["衣服5"] = {0, 3},
    ["衣服6"] = {0, 4},
    ["衣服7"] = {0, 4},
    ["衣服8"] = {0, 5},
    ["衣服9"] = {0, 6},
    ["衣服10"] = {0, 8},
    ["衣服11"] = {0, 9},
    ["衣服12"] = {1, 10},
    ["衣服13"] = {1, 1},
    ["衣服14"] = {1, 2},
    ["衣服15"] = {1, 3},
    ["衣服16"] = {1, 4},
    ["衣服17"] = {1, 5},
    ["衣服18"] = {1, 6},
    ["衣服19"] = {1, 7},
    ["衣服20"] = {1, 8},
    ["衣服21"] = {1, 9},
    ["衣服22"] = {2, 2},
    ["衣服23"] = {2, 2},
    ["衣服24"] = {2, 4},
    ["衣服25"] = {2, 6},
    ["衣服26"] = {2, 8},
    ["衣服27"] = {3, 4},
    ["衣服28"] = {4, 10},
    ["衣服29"] = {5, 10},

    ["麻痹1"] = {0, 1},
    ["麻痹2"] = {0, 2},
    ["麻痹3"] = {0, 3},
    ["麻痹4"] = {0, 4},
    ["麻痹5"] = {0, 5},
    ["麻痹6"] = {0, 8},
    ["麻痹7"] = {1, 10},
    ["麻痹8"] = {1, 4},
    ["麻痹9"] = {1, 8},
    ["麻痹10"] = {2, 5},

    ["复活1"] = {0, 1},
    ["复活2"] = {0, 2},
    ["复活3"] = {0, 3},
    ["复活4"] = {0, 4},
    ["复活5"] = {0, 5},
    ["复活6"] = {0, 8},
    ["复活7"] = {1, 10},
    ["复活8"] = {1, 4},
    ["复活9"] = {1, 8},
    ["复活10"] = {2, 5},

    ["卜算子1"] = {0, 10},
    ["卜算子2"] = {0, 10},
    ["卜算子3"] = {0, 10},
    ["卜算子4"] = {0, 10},
    ["卜算子5"] = {0, 10},
    ["卜算子6"] = {0, 1},
    ["卜算子7"] = {0, 2},
    ["卜算子8"] = {0, 3},
    ["卜算子9"] = {0, 4},
    ["卜算子10"] = {0, 5},
    ["卜算子11"] = {0, 6},
    ["卜算子12"] = {0, 8},
    ["卜算子13"] = {1, 10},
    ["卜算子14"] = {1, 2},
    ["卜算子15"] = {1, 5},

    ["太平令1"] = {0, 10},
    ["太平令2"] = {0, 10},
    ["太平令3"] = {0, 10},
    ["太平令4"] = {0, 10},
    ["太平令5"] = {0, 10},
    ["太平令6"] = {0, 1},
    ["太平令7"] = {0, 2},
    ["太平令8"] = {0, 3},
    ["太平令9"] = {0, 4},
    ["太平令10"] = {0, 5},
    ["太平令11"] = {0, 6},
    ["太平令12"] = {0, 8},
    ["太平令13"] = {1, 10},
    ["太平令14"] = {1, 2},
    ["太平令15"] = {1, 5},

    ["传国玺1"] = {0, 10},
    ["传国玺2"] = {0, 10},
    ["传国玺3"] = {0, 10},
    ["传国玺4"] = {0, 10},
    ["传国玺5"] = {0, 10},
    ["传国玺6"] = {0, 1},
    ["传国玺7"] = {0, 2},
    ["传国玺8"] = {0, 3},
    ["传国玺9"] = {0, 4},
    ["传国玺10"] = {0, 5},
    ["传国玺11"] = {0, 6},
    ["传国玺12"] = {0, 8},
    ["传国玺13"] = {1, 10},
    ["传国玺14"] = {1, 2},
    ["传国玺15"] = {1, 5},

    ["长生莲1"] = {0, 10},
    ["长生莲2"] = {0, 10},
    ["长生莲3"] = {0, 10},
    ["长生莲4"] = {0, 10},
    ["长生莲5"] = {0, 10},
    ["长生莲6"] = {0, 1},
    ["长生莲7"] = {0, 2},
    ["长生莲8"] = {0, 3},
    ["长生莲9"] = {0, 4},
    ["长生莲10"] = {0, 5},
    ["长生莲11"] = {0, 6},
    ["长生莲12"] = {0, 8},
    ["长生莲13"] = {1, 10},
    ["长生莲14"] = {1, 2},
    ["长生莲15"] = {1, 5},

    ["菩提1"] = {0, 1},
    ["菩提2"] = {0, 2},
    ["菩提3"] = {0, 3},
    ["菩提4"] = {0, 4},
    ["菩提5"] = {0, 5},
    ["菩提6"] = {0, 8},
    ["菩提7"] = {1, 10},
    ["菩提8"] = {1, 4},
    ["菩提9"] = {1, 8},
    ["菩提10"] = {2, 5},

    ["玉皇1"] = {0, 1},
    ["玉皇2"] = {0, 2},
    ["玉皇3"] = {0, 3},
    ["玉皇4"] = {0, 4},
    ["玉皇5"] = {0, 5},
    ["玉皇6"] = {0, 8},
    ["玉皇7"] = {1, 10},
    ["玉皇8"] = {1, 4},
    ["玉皇9"] = {1, 8},
    ["玉皇10"] = {2, 5},

    ["盾牌1"] = {0, 1},
    ["盾牌2"] = {0, 2},
    ["盾牌3"] = {0, 3},
    ["盾牌4"] = {0, 4},
    ["盾牌5"] = {0, 5},
    ["盾牌6"] = {0, 8},
    ["盾牌7"] = {1, 10},
    ["盾牌8"] = {1, 4},
    ["盾牌9"] = {1, 8},
    ["盾牌10"] = {2, 5},

    ["王妃1"] = {0, 2},
    ["王妃2"] = {0, 5},
    ["王妃3"] = {0, 8},
    ["王妃4"] = {1, 2},
    ["王妃5"] = {1, 6},
    ["王妃6"] = {2, 10},
    ["王妃7"] = {2, 5},
    ["王妃8"] = {3, 10},

}


local fydu = {
    ["飞剑青1"] = 1,
    ["飞剑青2"] = 1,
    ["飞剑青3"] = 1,
    ["飞剑青4"] = 1,
    ["飞剑青5"] = 1,
    ["飞剑青6"] = 1,
    ["飞剑青7"] = 1,
    ["飞剑青8"] = 1,
    ["飞剑青9"] = 1,
    ["飞剑青10"] = 1,
    ["飞剑青11"] = 1,
    ["飞剑青12"] = 1,
    ["飞剑蓝1"] = 2,
    ["飞剑蓝2"] = 2,
    ["飞剑蓝3"] = 2,
    ["飞剑蓝4"] = 2,
    ["飞剑蓝5"] = 2,
    ["飞剑蓝6"] = 2,
    ["飞剑蓝7"] = 2,
    ["飞剑蓝8"] = 2,
    ["飞剑蓝9"] = 2,
    ["飞剑蓝10"] = 2,
    ["飞剑蓝11"] = 2,
    ["飞剑蓝12"] = 2,

    ["飞剑紫1"] = 4,
    ["飞剑紫2"] = 4,
    ["飞剑紫3"] = 4,
    ["飞剑紫4"] = 4,
    ["飞剑紫5"] = 4,
    ["飞剑紫6"] = 4,
    ["飞剑紫7"] = 4,
    ["飞剑紫8"] = 4,
    ["飞剑紫9"] = 4,
    ["飞剑紫10"] = 4,
    ["飞剑紫11"] = 4,
    ["飞剑紫12"] = 4,

    ["飞剑橙1"] = 9,
    ["飞剑橙2"] = 9,
    ["飞剑橙3"] = 9,
    ["飞剑橙4"] = 9,
    ["飞剑橙5"] = 9,
    ["飞剑橙6"] = 9,
    ["飞剑橙7"] = 9,
    ["飞剑橙8"] = 9,
    ["飞剑橙9"] = 9,
    ["飞剑橙10"] = 9,
    ["飞剑橙11"] = 9,
    ["飞剑橙12"] = 9,

}


function on_pre_equip(player, item, item_id, item_key)   -------- 穿装备
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



function on_pre_un_equip(player, item,item_id,item_key)   ----------- 脱装备
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
    ["麻痹1"] = {10, 2},
    ["麻痹2"] = {10, 2},
    ["麻痹3"] = {10, 2},
    ["麻痹4"] = {10, 2},
    ["麻痹5"] = {12, 2},
    ["麻痹6"] = {13, 2},
    ["麻痹7"] = {14, 2},
    ["麻痹8"] = {15, 2},
    ["麻痹9"] = {18, 2},
    ["麻痹10"] = {20, 3},
}


dpfmbi = {
    ["盾牌1"] = {5},
    ["盾牌2"] = {8},
    ["盾牌3"] = {11},
    ["盾牌4"] = {15},
    ["盾牌5"] = {20},
    ["盾牌6"] = {25},
    ["盾牌7"] = {32},
    ["盾牌8"] = {45},
    ["盾牌9"] = {60},
    ["盾牌10"] = {100},
}

jnsz = {
    ["攻杀剑术4级"] = 1,
    ["刺杀剑术4级"] = 2,
    ["烈火剑法4级"] = 3,
    ["逐日剑法4级"] = 4,
    ["开天斩4级"] = 5,
    ["半月弯刀4级"] = 6,
}
local bossFilterToCut = {
    ["烂陀山高爆BOOS1"] = 1,
    ["烂陀山秘境BOSS1"] = 1,
    ["观音宗高爆BOOS1"] = 1,
    ["观音宗秘境BOSS1"] = 1,
    ["两禅寺高爆BOOS1"] = 1,
    ["两禅寺宗秘境BOSS1"] = 1,
    ["提兵山高爆BOOS1"] = 1,
    ["提兵山秘境BOSS1"] = 1,
    ["道德宗高爆BOOS1"] = 1,
    ["道德宗秘境BOSS1"] = 1,
    ["公主坟高爆BOOS1"] = 1,
    ["公主坟秘境BOSS1"] = 1,
    ["胭脂郡高爆BOOS1"] = 1,
    ["胭脂郡秘境BOSS1"] = 1,
    ["听潮亭高爆BOOS1"] = 1,
    ["听潮亭秘境BOSS1"] = 1,
    ["洗象池高爆BOOS1"] = 1,
    ["洗象池秘境BOSS1"] = 1,
    ["龙虎山高爆BOOS1"] = 1,
    ["龙虎山秘境BOSS1"] = 1,
    ["青阳宫高爆BOOS1"] = 1,
    ["青阳宫秘境BOSS1"] = 1,
    ["武帝城高爆BOOS1"] = 1,
    ["武帝城秘境BOSS1"] = 1,
    ["南诏龙宫高爆BOOS1"] = 1,
    ["南诏龙宫秘境BOSS1"] = 1,
    ["东越剑池高爆BOOS1"] = 1,
    ["东越剑池秘境BOSS1"] = 1,
    ["吴家剑冢高爆BOOS1"] = 1,
    ["吴家剑冢秘境BOSS1"] = 1,
    ["牯牛大岗高爆BOOS1"] = 1,
    ["牯牛大岗秘境BOSS1"] = 1,
    ["酆都荒古高爆BOOS1"] = 1,
    ["酆都荒古秘境BOSS1"] = 1,
    ["上阴学宫高爆BOOS1"] = 1,
    ["上阴学宫秘境BOSS1"] = 1,
    ["春帖草堂高爆BOOS1"] = 1,
    ["春帖草堂秘境BOSS1"] = 1,
    ["柔然山脉高爆BOOS1"] = 1,
    ["柔然山脉秘境BOSS1"] = 1,
    ["棋剑乐府高爆BOOS1"] = 1,
    ["棋剑乐府秘境BOSS1"] = 1,
    ["徽山大雪坪高爆BOOS1"] = 1,
    ["徽山大雪坪秘境BOSS1"] = 1,
    ["大秦皇陵高爆BOOS1"] = 1,
    ["大秦皇陵秘境BOSS1"] = 1,
    ["北莽帝王庭高爆BOOS1"] = 1,
    ["北莽帝王庭秘境BOSS1"] = 1,
    ["离阳太安城高爆BOOS1"] = 1,
    ["离阳太安城秘境BOSS1"] = 1,
    ["道教根骨地高爆BOOS1"] = 1,
    ["道教根骨地秘境BOSS1"] = 1,
    ["道教根骨地高爆2-BOOS1"] = 1,
    ["道教根骨地秘境2-BOSS1"] = 1,
    ["佛门机缘地高爆BOOS1"] = 1,
    ["佛门机缘地秘境BOSS1"] = 1,
    ["佛门机缘地高爆2-BOOS1"] = 1,
    ["佛门机缘地秘境2-BOSS1"] = 1,
    ["儒家气运地高爆BOOS1"] = 1,
    ["儒家气运地秘境BOSS1"] = 1,
    ["儒家气运地高爆2-BOOS1"] = 1,
    ["儒家气运地秘境2-BOSS1"] = 1,
    ["洞天福地高爆BOOS1"] = 1,
    ["洞天福地秘境BOSS1"] = 1,
    ["洞天技能高爆BOOS1"] = 1,
    ["洞天剑甲高爆BOOS1"] = 1,
    ["洞天特殊高爆BOOS1"] = 1,
    ["洞天首饰高爆BOOS1"] = 1,
    ["剑六专属「高爆BOSS」"] = 1,
    ["剑六专属『秘境BOSS』"] = 1,
    ["剑七专属「高爆BOSS」"] = 1,
    ["剑七专属『秘境BOSS』"] = 1,
    ["剑八专属「高爆BOSS」"] = 1,
    ["剑八专属『秘境BOSS』"] = 1,
    ["剑九专属「高爆BOSS」"] = 1,
    ["剑九专属『秘境BOSS』"] = 1,
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

        if lualib:HasSkill(killer, "天下无禅", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 then
                if lualib:ItemCount(player, "北凉城传送石") > 0 then
                    lualib:DelItem(player, "北凉城传送石", lualib:ItemCount(player, "北凉城传送石"), 2, "烟花", "烟花")
                    lualib:SysMsg_SendTriggerMsg(killer, "你触发了天下无禅技能,对方的回城已被盗取一空!")
                end
            end
        end

        if lualib:HasSkill(killer, "一指断江", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 then
                local pk = lualib:Pk(player) + 200
                lualib:SetPk(player, pk)
                lualib:SysMsg_SendTriggerMsg(killer, "你触发了一指断江技能,对方瞬间变为了红名状态!")
            end
        end

        if lualib:HasSkill(killer, "仙人抚顶", false) == true and lualib:Player_IsPlayer(player) then
            if lualib:GenRandom(1, 100) <= 10 and lualib:GetInt(killer, "xianren") <= 0 then
                local cur_hp = lualib:Hp(player, false) * 0.5
                hp = hp - cur_hp
                lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#玩家#COLORCOLOR_WHITE#["..lualib:KeyName(killer).."] #COLORCOLOR_PURPLE#触发了仙人抚顶技能,瞬间斩杀了#COLORCOLOR_WHITE#["..lualib:KeyName(player).."]#COLORCOLOR_YELLOW#当前50%的HP!打人是恩怨,打脸是死仇!", "", 1, 12);

                --lualib:SysMsg_SendTriggerMsg(killer, "你触发了仙人抚顶技能,瞬间斩杀了对方当前50%的HP!")
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
                    lualib:SysMsg_SendTriggerMsg(killer, "你的麻痹效果被对方防掉了!")
                    lualib:SysMsg_SendTriggerMsg(player, "你防御了对方的麻痹效果!")
                else
                    lualib:AddBuff(player, "脚本麻痹", mbijz[KeyName][2]);
                end
            end
        else
            local hat = lualib:Player_GetItemGuid(killer, 11)
            if hat ~= "" then
                local KeyName = lualib:KeyName(hat);
                if mbijz[KeyName] ~= nil then
                    if lualib:GenRandom(1, 100) <= mbijz[KeyName][1] then
                        if lualib:GenRandom(1, 100) <= fangmbi then
                            lualib:SysMsg_SendTriggerMsg(killer, "你的麻痹效果被对方防掉了!")
                            lualib:SysMsg_SendTriggerMsg(player, "你防御了对方的麻痹效果!")
                        else
                            lualib:AddBuff(player, "脚本麻痹", mbijz[KeyName][2]);
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
                            lualib:SysMsg_SendTriggerMsg(killer, "你的麻痹效果被对方防掉了!")
                            lualib:SysMsg_SendTriggerMsg(player, "你防御了对方的麻痹效果!")
                        else
                            lualib:AddBuff(player, "脚本麻痹", mbijz[KeyName][2]);
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
            ["武评榜单1"] = 10000,
            ["武评榜单2"] = 6000,
            ["武评榜单3"] = 4000,
            ["武评榜单4"] = 3000,
            ["武评榜单5"] = 2500,
            ["武评榜单6"] = 2000,
            ["武评榜单7"] = 1000,
            ["武评榜单8"] = 800,
            ["武评榜单9"] = 600,
            ["武评榜单10"] = 400,
        }
        for i = 1, 10 do
            if lualib:HasBuff(killer,"武评榜单"..i) then
                hp = hp - wpszbd["武评榜单"..i]
            end
        end
        if lualib:HasBuff(killer,"剑开天门") then
            hp = hp - 3888
        end
        if lualib:HasBuff(killer,"佛门金刚") then
            hp = hp - 1000
        end
        if lualib:HasBuff(killer,"道教指玄") then
            hp = hp - 3000
        end
        if lualib:HasBuff(killer,"儒家天象") then
            hp = hp - 5000
        end
        if lualib:HasBuff(killer,"陆地仙人") then
            hp = hp - 8000
        end
        -- 五行对怪伤害增加
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
            ["菩提1"] = 300,
            ["菩提2"] = 400,
            ["菩提3"] = 700,
            ["菩提4"] = 1000,
            ["菩提5"] = 1600,
            ["菩提6"] = 2400,
            ["菩提7"] = 3000,
            ["菩提8"] = 3600,
            ["菩提9"] = 4400,
            ["菩提10"] = 6000,
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
            if lualib:KeyName(yifu) == "赠送衣服" then
                hp = hp - 666
            end
        end
        local wuqi = lualib:Weapon(killer)
        if wuqi ~= "" then
            if lualib:KeyName(wuqi) == "赠送武器" then
                hp = hp - 1288
            end
        end
    end

    local qg = 0
    if lualib:Player_IsPlayer(killer) and lualib:Monster_IsMonster(player) then
        if lualib:HasBuff(killer, "佛门金刚") == true then
            if lualib:GenRandom(1, 100) <= 10 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "切割怪物,造成最大生命值的"..subHp.."点额外伤害！！", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "道教指玄") == true then
            if lualib:GenRandom(1, 100) <= 20 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "切割怪物,造成最大生命值的"..subHp.."点额外伤害！！", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "儒家天象") == true then
            if lualib:GenRandom(1, 100) <= 50 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "切割怪物,造成最大生命值的"..subHp.."点额外伤害！！", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        if lualib:HasBuff(killer, "陆地仙人") == true then
            if lualib:GenRandom(1, 100) <= 100 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * 0.01
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "切割怪物,造成最大生命值的"..subHp.."点额外伤害！！", killer);
                hp = hp - subHp;
                qg = 1
            end
        end
        -- 五行切割
        local mobCut = lualib:GetInt(player, "fiveELementcutPercent")
        if mobCut > 0 then
            if bossFilterToCut[lualib:KeyName(player)] ~= 1 then
                local max_hp = lualib:Hp(player, true);
                local subHp = max_hp * mobCut / 100
                subHp = math.ceil(subHp);
                lualib:SysCenterMsg(0, "五行切割怪物,造成最大生命值的"..subHp.."点额外伤害！！", killer);
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
    lualib:DelayCall(family_guid, 1, "行会:on_family_member_ntf", family_name.."#"..player_guid.."#"..opt_type)
end

function on_family_ntf(guid, mc, opt_type, player)
    if opt_type == 1 then
        if lualib:GetDBNum("hequbs") > 1 then
            lualib:SetFamilyMaxMember(guid, 200)
        else
            lualib:SetFamilyMaxMember(guid, 20)
        end
    end
    lualib:DelayCall(guid, 1, "行会:on_family_ntf", name.."#"..type.."#"..player)
end

----------------------------------首爆
local sb_wp = {
    {"头盔2", 500, 3},
    {"项链2", 500, 3},
    {"戒指2", 500, 3},
    {"手镯2", 500, 3},
    {"鞋子2", 500, 3},
    {"腰带2", 500, 3},
    {"头盔3", 1000, 3},
    {"项链3", 1000, 3},
    {"戒指3", 1000, 3},
    {"手镯3", 1000, 3},
    {"鞋子3", 1000, 3},
    {"腰带3", 1000, 3},
    {"头盔4", 1500, 3},
    {"项链4", 1500, 3},
    {"戒指4", 1500, 3},
    {"手镯4", 1500, 3},
    {"鞋子4", 1500, 3},
    {"腰带4", 1500, 3},
    {"头盔5", 2000, 3},
    {"项链5", 2000, 3},
    {"戒指5", 2000, 3},
    {"手镯5", 2000, 3},
    {"鞋子5", 2000, 3},
    {"腰带5", 2000, 3},
    {"头盔6", 2500, 3},
    {"项链6", 2500, 3},
    {"戒指6", 2500, 3},
    {"手镯6", 2500, 3},
    {"鞋子6", 2500, 3},
    {"腰带6", 2500, 3},
    {"头盔7", 3000, 3},
    {"项链7", 3000, 3},
    {"戒指7", 3000, 3},
    {"手镯7", 3000, 3},
    {"鞋子7", 3000, 3},
    {"腰带7", 3000, 3},
    {"头盔8", 3500, 3},
    {"项链8", 3500, 3},
    {"戒指8", 3500, 3},
    {"手镯8", 3500, 3},
    {"鞋子8", 3500, 3},
    {"腰带8", 3500, 3},
    {"头盔9", 4000, 3},
    {"项链9", 4000, 3},
    {"戒指9", 4000, 3},
    {"手镯9", 4000, 3},
    {"鞋子9", 4000, 3},
    {"腰带9", 4000, 3},
    {"头盔10", 4500, 3},
    {"项链10", 4500, 3},
    {"戒指10", 4500, 3},
    {"手镯10", 4500, 3},
    {"鞋子10", 4500, 3},
    {"腰带10", 4500, 3},
    {"头盔11", 5000, 3},
    {"项链11", 5000, 3},
    {"戒指11", 5000, 3},
    {"手镯11", 5000, 3},
    {"鞋子11", 5000, 3},
    {"腰带11", 5000, 3},
    {"头盔12", 6000, 3},
    {"项链12", 6000, 3},
    {"戒指12", 6000, 3},
    {"手镯12", 6000, 3},
    {"鞋子12", 6000, 3},
    {"腰带12", 6000, 3},
    {"头盔13", 7000, 3},
    {"项链13", 7000, 3},
    {"戒指13", 7000, 3},
    {"手镯13", 7000, 3},
    {"鞋子13", 7000, 3},
    {"腰带13", 7000, 3},
    {"头盔14", 8000, 3},
    {"项链14", 8000, 3},
    {"戒指14", 8000, 3},
    {"手镯14", 8000, 3},
    {"鞋子14", 8000, 3},
    {"腰带14", 8000, 3},
    {"头盔15", 9000, 3},
    {"项链15", 9000, 3},
    {"戒指15", 9000, 3},
    {"手镯15", 9000, 3},
    {"鞋子15", 9000, 3},
    {"腰带15", 9000, 3},
    {"头盔16", 10000, 3},
    {"项链16", 10000, 3},
    {"戒指16", 10000, 3},
    {"手镯16", 10000, 3},
    {"鞋子16", 10000, 3},
    {"腰带16", 10000, 3},
    {"头盔17", 20000, 2},
    {"项链17", 20000, 2},
    {"戒指17", 20000, 2},
    {"手镯17", 20000, 2},
    {"鞋子17", 20000, 2},
    {"腰带17", 20000, 2},
    {"头盔18", 30000, 2},
    {"项链18", 30000, 2},
    {"戒指18", 30000, 2},
    {"手镯18", 30000, 2},
    {"鞋子18", 30000, 2},
    {"腰带18", 30000, 2},
    {"头盔19", 40000, 2},
    {"项链19", 40000, 2},
    {"戒指19", 40000, 2},
    {"手镯19", 40000, 2},
    {"鞋子19", 40000, 2},
    {"腰带19", 40000, 2},
    {"头盔20", 50000, 2},
    {"项链20", 50000, 2},
    {"戒指20", 50000, 2},
    {"手镯20", 50000, 2},
    {"鞋子20", 50000, 2},
    {"腰带20", 50000, 2},
    {"头盔21", 60000, 2},
    {"项链21", 60000, 2},
    {"戒指21", 60000, 2},
    {"手镯21", 60000, 2},
    {"鞋子21", 60000, 2},
    {"腰带21", 60000, 2},
    {"头盔22", 80000, 2},
    {"项链22", 80000, 2},
    {"戒指22", 80000, 2},
    {"手镯22", 80000, 2},
    {"鞋子22", 80000, 2},
    {"腰带22", 80000, 2},
    {"头盔23", 100000, 2},
    {"项链23", 100000, 2},
    {"戒指23", 100000, 2},
    {"手镯23", 100000, 2},
    {"鞋子23", 100000, 2},
    {"腰带23", 100000, 2},
    {"头盔24", 188888, 2},
    {"项链24", 188888, 2},
    {"戒指24", 188888, 2},
    {"手镯24", 188888, 2},
    {"鞋子24", 188888, 2},
    {"腰带24", 188888, 2},
    {"头盔25", 388888, 2},
    {"项链25", 388888, 2},
    {"戒指25", 388888, 2},
    {"手镯25", 388888, 2},
    {"鞋子25", 388888, 2},
    {"腰带25", 388888, 2},
    {"头盔26", 888888, 2},
    {"项链26", 888888, 2},
    {"戒指26", 888888, 2},
    {"手镯26", 888888, 2},
    {"鞋子26", 888888, 2},
    {"腰带26", 888888, 2},
    {"武器2", 1000, 3},
    {"武器3", 2000, 3},
    {"武器4", 3000, 3},
    {"武器5", 4000, 3},
    {"武器6", 5000, 3},
    {"武器7", 6000, 3},
    {"武器8", 8000, 3},
    {"武器9", 10000, 3},
    {"武器10", 15000, 3},
    {"武器11", 20000, 3},
    {"武器12", 25000, 3},
    {"武器13", 30000, 3},
    {"武器14", 35000, 3},
    {"武器15", 40000, 3},
    {"武器16", 50000, 3},
    {"武器17", 60000, 2},
    {"武器18", 80000, 2},
    {"武器19", 100000, 2},
    {"武器20", 120000, 2},
    {"武器21", 140000, 2},
    {"武器22", 160000, 2},
    {"武器23", 180000, 2},
    {"武器24", 200000, 2},
    {"武器25", 300000, 2},
    {"武器26", 588888, 2},
    {"武器27", 888888, 2},
    {"武器28", 1888888, 2},
    {"武器29", 3888888, 2},
    {"衣服2", 1000, 3},
    {"衣服3", 2000, 3},
    {"衣服4", 3000, 3},
    {"衣服5", 4000, 3},
    {"衣服6", 5000, 3},
    {"衣服7", 6000, 3},
    {"衣服8", 8000, 3},
    {"衣服9", 10000, 3},
    {"衣服10", 15000, 3},
    {"衣服11", 20000, 3},
    {"衣服12", 25000, 3},
    {"衣服13", 30000, 3},
    {"衣服14", 35000, 3},
    {"衣服15", 40000, 3},
    {"衣服16", 50000, 3},
    {"衣服17", 60000, 2},
    {"衣服18", 80000, 2},
    {"衣服19", 100000, 2},
    {"衣服20", 120000, 2},
    {"衣服21", 140000, 2},
    {"衣服22", 160000, 2},
    {"衣服23", 180000, 2},
    {"衣服24", 200000, 2},
    {"衣服25", 300000, 2},
    {"衣服26", 588888, 2},
    {"衣服27", 888888, 2},
    {"衣服28", 1888888, 2},
    {"衣服29", 3888888, 2},
    {"麻痹1", 1200, 3},
    {"麻痹2", 5000, 3},
    {"麻痹3", 10000, 3},
    {"麻痹4", 20000, 3},
    {"麻痹5", 40000, 3},
    {"麻痹6", 60000, 3},
    {"麻痹7", 80000, 3},
    {"麻痹8", 100000, 2},
    {"麻痹9", 150000, 2},
    {"麻痹10", 300000, 2},
    {"复活1", 1200, 3},
    {"复活2", 5000, 3},
    {"复活3", 10000, 3},
    {"复活4", 20000, 3},
    {"复活5", 40000, 3},
    {"复活6", 60000, 3},
    {"复活7", 80000, 3},
    {"复活8", 100000, 2},
    {"复活9", 150000, 2},
    {"复活10", 300000, 2},
    {"卜算子1", 1000, 3},
    {"传国玺1", 1000, 3},
    {"长生莲1", 1000, 3},
    {"太平令1", 1000, 3},
    {"卜算子2", 1000, 3},
    {"传国玺2", 2000, 3},
    {"长生莲2", 2000, 3},
    {"太平令2", 2000, 3},
    {"卜算子3", 3000, 3},
    {"传国玺3", 3000, 3},
    {"长生莲3", 3000, 3},
    {"太平令3", 3000, 3},
    {"卜算子4", 5000, 3},
    {"传国玺4", 5000, 3},
    {"长生莲4", 5000, 3},
    {"太平令4", 5000, 3},
    {"卜算子5", 10000, 3},
    {"传国玺5", 10000, 3},
    {"长生莲5", 10000, 3},
    {"太平令5", 10000, 3},
    {"卜算子6", 20000, 3},
    {"传国玺6", 20000, 3},
    {"长生莲6", 20000, 3},
    {"太平令6", 20000, 3},
    {"卜算子7", 40000, 3},
    {"传国玺7", 40000, 3},
    {"长生莲7", 40000, 3},
    {"太平令7", 40000, 3},
    {"卜算子8", 60000, 3},
    {"传国玺8", 60000, 3},
    {"长生莲8", 60000, 3},
    {"太平令8", 60000, 3},
    {"卜算子9", 80000, 3},
    {"传国玺9", 80000, 3},
    {"长生莲9", 80000, 3},
    {"太平令9", 80000, 3},
    {"卜算子10", 100000, 3},
    {"传国玺10", 100000, 3},
    {"长生莲10", 100000, 3},
    {"太平令10", 100000, 3},
    {"卜算子11", 120000, 2},
    {"传国玺11", 120000, 2},
    {"长生莲11", 120000, 2},
    {"太平令11", 120000, 2},
    {"卜算子12", 150000, 2},
    {"传国玺12", 150000, 2},
    {"长生莲12", 150000, 2},
    {"太平令12", 150000, 2},
    {"卜算子13", 200000, 2},
    {"传国玺13", 200000, 2},
    {"长生莲13", 200000, 2},
    {"太平令13", 200000, 2},
    {"卜算子14", 250000, 2},
    {"传国玺14", 250000, 2},
    {"长生莲14", 250000, 2},
    {"太平令14", 250000, 2},
    {"卜算子15", 300000, 2},
    {"传国玺15", 300000, 2},
    {"长生莲15", 300000, 2},
    {"太平令15", 300000, 2},
    {"飞剑青1", 10000, 3},
    {"飞剑青2", 10000, 3},
    {"飞剑青3", 10000, 3},
    {"飞剑青4", 10000, 3},
    {"飞剑青5", 10000, 3},
    {"飞剑青6", 10000, 3},
    {"飞剑青7", 10000, 3},
    {"飞剑青8", 10000, 3},
    {"飞剑青9", 10000, 3},
    {"飞剑青10", 10000, 3},
    {"飞剑青11", 10000, 3},
    {"飞剑青12", 10000, 3},
    {"飞剑蓝1", 50000, 2},
    {"飞剑蓝2", 50000, 2},
    {"飞剑蓝3", 50000, 2},
    {"飞剑蓝4", 50000, 2},
    {"飞剑蓝5", 50000, 2},
    {"飞剑蓝6", 50000, 2},
    {"飞剑蓝7", 50000, 2},
    {"飞剑蓝8", 50000, 2},
    {"飞剑蓝9", 50000, 2},
    {"飞剑蓝10", 50000, 2},
    {"飞剑蓝11", 50000, 2},
    {"飞剑蓝12", 50000, 2},
    {"飞剑紫1", 100000, 2},
    {"飞剑紫2", 100000, 2},
    {"飞剑紫3", 100000, 2},
    {"飞剑紫4", 100000, 2},
    {"飞剑紫5", 100000, 2},
    {"飞剑紫6", 100000, 2},
    {"飞剑紫7", 100000, 2},
    {"飞剑紫8", 100000, 2},
    {"飞剑紫9", 100000, 2},
    {"飞剑紫10", 100000, 2},
    {"飞剑紫11", 100000, 2},
    {"飞剑紫12", 100000, 2},
}


tstishi = {
    ["手镯17"] = { 10000, 12000},
    ["戒指17"] = { 10000, 12000},
    ["头盔17"] = { 10000, 12000},
    ["项链17"] = { 10000, 12000},
    ["腰带17"] = { 10000, 12000},
    ["鞋子17"] = { 10000, 12000},
    ["衣服17"] = { 30000, 36000},
    ["武器17"] = { 30000, 36000},
    ["手镯18"] = { 20000, 24000},
    ["戒指18"] = { 20000, 24000},
    ["头盔18"] = { 20000, 24000},
    ["项链18"] = { 20000, 24000},
    ["腰带18"] = { 20000, 24000},
    ["鞋子18"] = { 20000, 24000},
    ["衣服18"] = { 50000, 60000},
    ["武器18"] = { 50000, 60000},
    ["手镯19"] = { 30000, 36000},
    ["戒指19"] = { 30000, 36000},
    ["头盔19"] = { 30000, 36000},
    ["项链19"] = { 30000, 36000},
    ["腰带19"] = { 30000, 36000},
    ["鞋子19"] = { 30000, 36000},
    ["衣服19"] = { 80000, 96000},
    ["武器19"] = { 80000, 96000},
    ["手镯20"] = { 50000, 60000},
    ["戒指20"] = { 50000, 60000},
    ["头盔20"] = { 50000, 60000},
    ["项链20"] = { 50000, 60000},
    ["腰带20"] = { 50000, 60000},
    ["鞋子20"] = { 50000, 60000},
    ["衣服20"] = { 120000, 144000},
    ["武器20"] = { 120000, 144000},
    ["手镯21"] = { 80000, 96000},
    ["戒指21"] = { 80000, 96000},
    ["头盔21"] = { 80000, 96000},
    ["项链21"] = { 80000, 96000},
    ["腰带21"] = { 80000, 96000},
    ["鞋子21"] = { 80000, 96000},
    ["衣服21"] = { 180000, 216000},
    ["武器21"] = { 180000, 216000},
    ["手镯22"] = { 120000, 144000},
    ["戒指22"] = { 120000, 144000},
    ["头盔22"] = { 120000, 144000},
    ["项链22"] = { 120000, 144000},
    ["腰带22"] = { 120000, 144000},
    ["鞋子22"] = { 120000, 144000},
    ["衣服22"] = { 250000, 300000},
    ["武器22"] = { 250000, 308000},
    ["手镯23"] = { 180000, 216000},
    ["戒指23"] = { 180000, 216000},
    ["头盔23"] = { 180000, 216000},
    ["项链23"] = { 180000, 216000},
    ["腰带23"] = { 180000, 216000},
    ["鞋子23"] = { 180000, 216000},
    ["衣服23"] = { 350000, 420000},
    ["武器23"] = { 350000, 420000},
    ["手镯24"] = { 380000, 456000},
    ["戒指24"] = { 380000, 456000},
    ["头盔24"] = { 380000, 456000},
    ["项链24"] = { 380000, 456000},
    ["腰带24"] = { 380000, 456000},
    ["鞋子24"] = { 380000, 456000},
    ["衣服24"] = { 500000, 600000},
    ["武器24"] = { 500000, 600000},
    ["手镯25"] = { 880000, 1056000},
    ["戒指25"] = { 880000, 1056000},
    ["头盔25"] = { 880000, 1056000},
    ["项链25"] = { 880000, 1056000},
    ["腰带25"] = { 880000, 1056000},
    ["鞋子25"] = { 880000, 1056000},
    ["衣服25"] = { 880000, 1056000},
    ["武器25"] = { 880000, 1056000},
    ["手镯26"] = { 1880000, 2256000},
    ["戒指26"] = { 1880000, 2256000},
    ["头盔26"] = { 1880000, 2256000},
    ["项链26"] = { 1880000, 2256000},
    ["腰带26"] = { 1880000, 2256000},
    ["鞋子26"] = { 1880000, 2256000},
    ["衣服26"] = { 1880000, 2256000},
    ["武器26"] = { 1880000, 2256000},
    ["衣服27"] = { 3880000, 4656000},
    ["武器27"] = { 3880000, 4656000},
    ["衣服28"] = { 8880000, 10656000},
    ["武器28"] = { 8880000, 10656000},
    ["衣服29"] = { 18880000, 22656000},
    ["武器29"] = { 18880000, 22656000},
    ["麻痹8"] = { 50000, 60000},
    ["复活8"] = { 50000, 60000},
    ["麻痹9"] = { 100000, 120000},
    ["复活9"] = { 100000, 120000},
    ["麻痹10"] = { 200000, 240000},
    ["复活10"] = { 200000, 240000},
    ["卜算子11"] = { 50000, 60000},
    ["卜算子12"] = { 80000, 96000},
    ["卜算子13"] = { 120000, 144000},
    ["卜算子14"] = { 160000, 192000},
    ["卜算子15"] = { 200000, 240000},
    ["长生莲11"] = { 50000, 60000},
    ["长生莲12"] = { 80000, 96000},
    ["长生莲13"] = { 120000, 144000},
    ["长生莲14"] = { 160000, 192000},
    ["长生莲15"] = { 200000, 240000},
    ["传国玺11"] = { 50000, 60000},
    ["传国玺12"] = { 80000, 96000},
    ["传国玺13"] = { 120000, 144000},
    ["传国玺14"] = { 160000, 192000},
    ["传国玺15"] = { 200000, 240000},
    ["太平令11"] = { 50000, 60000},
    ["太平令12"] = { 80000, 96000},
    ["太平令13"] = { 120000, 144000},
    ["太平令14"] = { 160000, 192000},
    ["太平令15"] = { 200000, 240000},
    ["飞剑橙1"] = { 200000, 240000},
    ["飞剑橙2"] = { 200000, 240000},
    ["飞剑橙3"] = { 200000, 240000},
    ["飞剑橙4"] = { 200000, 240000},
    ["飞剑橙5"] = { 200000, 240000},
    ["飞剑橙6"] = { 200000, 240000},
    ["飞剑橙7"] = { 200000, 240000},
    ["飞剑橙8"] = { 200000, 240000},
    ["飞剑橙9"] = { 200000, 240000},
    ["飞剑橙10"] = { 200000, 240000},
    ["飞剑橙11"] = { 200000, 240000},
    ["飞剑橙12"] = { 200000, 240000},
    ["十步一杀"] = { 200000, 240000},
    ["魔法盾"] = { 200000, 240000},

    ["绿蚁酒"] = { 200000, 240000},
    ["紫金莲"] = { 200000, 240000},
    ["六年凤"] = { 200000, 240000},
    ["月井天镜"] = { 200000, 240000},
    ["入神面皮"] = { 200000, 240000},
    ["大凉龙雀"] = { 200000, 240000},
    ["荒诞不经年"] = { 200000, 240000},
    ["陆地朝仙图"] = { 200000, 240000},
    ["雪中悍刀行"] = { 200000, 240000},
    ["山河社稷"] = { 200000, 240000},
}

function on_post_drop_one(map, role, item)

    local Name = lualib:Name(item);
    local item_key = lualib:KeyName(item);
    local killer = lualib:ItemRole(item)
    if killer ~= "" then
        if lualib:Monster_IsMonster(role) then
            for i = 1, #sb_wp do
                if sb_wp[i][1] == item_key then
                    if sb_wp[i][3] - lualib:GetDBNum("首爆累积"..item_key) > 0 then
                        lualib:SetDBNumEx("首爆累积"..item_key, lualib:GetDBNum("首爆累积"..item_key) + 1, 4)
                        lualib:AddIntegral(killer, sb_wp[i][2], "添加绑定金币:原因", "发起者")
                        lualib:SysMsg_SendBroadcastMsg("玩家["..lualib:Name(killer).."]获得了首爆物品【“"..Name.."”】！奖励了"..sb_wp[i][2].."钻石！", "系统消息")

                        lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]获得了首爆物品【“"..Name.."”】！奖励了"..sb_wp[i][2].."钻石！","")
                        lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]获得了首爆物品【“"..Name.."”】！奖励了"..sb_wp[i][2].."钻石！","")
                        lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]获得了首爆物品【“"..Name.."”】！奖励了"..sb_wp[i][2].."钻石！","")
                        lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]获得了首爆物品【“"..Name.."”】！奖励了"..sb_wp[i][2].."钻石！","")


                        if lualib:GetDBNum("首爆累积"..item_key) == 1 then
                            lualib:SetDBStrEx("首爆名称"..sb_wp[i][1], lualib:Name(killer), 1)
                        elseif lualib:GetDBNum("首爆累积"..item_key) <= 3 then
                            lualib:SetDBStrEx("首爆名称"..sb_wp[i][1], lualib:GetDBStr("首爆名称"..sb_wp[i][1]).."‖"..lualib:Name(killer), 1)
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
            lualib:SysMsg_SendBroadcastColorByClientType("#COLORCOLOR_PURPLE#["..item_name.."] #COLORCOLOR_YELLOW#掉落在#COLORCOLOR_BROWN#["..map_name.."]#COLORCOLOR_BLUE#的["..item_x..","..item_y.."]！！！", "", 1, 12, 1);
            --end

            --lualib:SysMsg_SendBroadcastColor("#IMAGE1900300001##COLORCOLOR_BROWN#["..item_name.."] #COLORCOLOR_YELLOW#掉落在#COLORCOLOR_BROWN#["..map_name.."]#COLORCOLOR_YELLOW#的["..item_x..","..item_y.."]！！！", "", 1, 12);
        end
    end

    local map_name = lualib:Name(map);
    local item_name = lualib:Name(item);
    local item_x = lualib:X(item);
    local item_y = lualib:Y(item);
    if tstishi[item_key] ~= nil then
        lualib:SysMsg_SendCenterMsg(1, "["..item_name.."] 掉落在["..map_name.."]的["..item_x..","..item_y.."]！！！",  "")
    end


end


----------------------------------首杀
local ss_gw = {
    {"烂陀山小怪1", 1000, 3},
    {"烂陀山小怪2", 1000, 3},
    {"烂陀山小怪3", 1000, 3},
    {"烂陀山小怪4", 1000, 3},
    {"烂陀山精英1", 2000, 3},
    {"烂陀山精英2", 2000, 3},
    {"烂陀山精英3", 2000, 3},
    {"烂陀山高爆BOOS1", 5000, 3},
    {"烂陀山秘境BOSS1", 10000, 3},
    {"观音宗小怪1", 1200, 3},
    {"观音宗小怪2", 1200, 3},
    {"观音宗小怪3", 1200, 3},
    {"观音宗小怪4", 1200, 3},
    {"观音宗精英1", 2400, 3},
    {"观音宗精英2", 2400, 3},
    {"观音宗精英3", 2400, 3},
    {"观音宗高爆BOOS1", 6000, 3},
    {"观音宗秘境BOSS1", 12000, 3},
    {"两禅寺小怪1", 1800, 3},
    {"两禅寺小怪2", 1800, 3},
    {"两禅寺小怪3", 1800, 3},
    {"两禅寺小怪4", 1800, 3},
    {"两禅寺精英1", 3600, 3},
    {"两禅寺精英2", 3600, 3},
    {"两禅寺精英3", 3600, 3},
    {"两禅寺高爆BOOS1", 9000, 3},
    {"两禅寺宗秘境BOSS1", 18000, 3},
    {"提兵山小怪1", 2400, 3},
    {"提兵山小怪2", 2400, 3},
    {"提兵山小怪3", 2400, 3},
    {"提兵山小怪4", 2400, 3},
    {"提兵山精英1", 4800, 3},
    {"提兵山精英2", 4800, 3},
    {"提兵山精英3", 4800, 3},
    {"提兵山高爆BOOS1", 12000, 3},
    {"提兵山秘境BOSS1", 24000, 3},
    {"道德宗小怪1", 3000, 3},
    {"道德宗小怪2", 3000, 3},
    {"道德宗小怪3", 3000, 3},
    {"道德宗小怪4", 3000, 3},
    {"道德宗精英1", 6000, 3},
    {"道德宗精英2", 6000, 3},
    {"道德宗精英3", 6000, 3},
    {"道德宗高爆BOOS1", 15000, 3},
    {"道德宗秘境BOSS1", 30000, 3},
    {"公主坟小怪1", 3600, 3},
    {"公主坟小怪2", 3600, 3},
    {"公主坟小怪3", 3600, 3},
    {"公主坟小怪4", 3600, 3},
    {"公主坟精英1", 7200, 3},
    {"公主坟精英2", 7200, 3},
    {"公主坟精英3", 7200, 3},
    {"公主坟高爆BOOS1", 18000, 3},
    {"公主坟秘境BOSS1", 36000, 3},
    {"胭脂郡小怪1", 4200, 3},
    {"胭脂郡小怪2", 4200, 3},
    {"胭脂郡小怪3", 4200, 3},
    {"胭脂郡小怪4", 4200, 3},
    {"胭脂郡精英1", 8400, 3},
    {"胭脂郡精英2", 8400, 3},
    {"胭脂郡精英3", 8400, 3},
    {"胭脂郡高爆BOOS1", 21000, 3},
    {"胭脂郡秘境BOSS1", 42000, 3},
    {"听潮亭小怪1", 4800, 3},
    {"听潮亭小怪2", 4800, 3},
    {"听潮亭小怪3", 4800, 3},
    {"听潮亭小怪4", 4800, 3},
    {"听潮亭精英1", 9600, 3},
    {"听潮亭精英2", 9600, 3},
    {"听潮亭精英3", 9600, 3},
    {"听潮亭高爆BOOS1", 24000, 3},
    {"听潮亭秘境BOSS1", 48000, 3},
    {"洗象池小怪1", 5400, 3},
    {"洗象池小怪2", 5400, 3},
    {"洗象池小怪3", 5400, 3},
    {"洗象池小怪4", 5400, 3},
    {"洗象池精英1", 10800, 3},
    {"洗象池精英2", 10800, 3},
    {"洗象池精英3", 10800, 3},
    {"洗象池高爆BOOS1", 27000, 3},
    {"洗象池秘境BOSS1", 54000, 3},
    {"龙虎山小怪1", 6000, 3},
    {"龙虎山小怪2", 6000, 3},
    {"龙虎山小怪3", 6000, 3},
    {"龙虎山小怪4", 6000, 3},
    {"龙虎山精英1", 12000, 3},
    {"龙虎山精英2", 12000, 3},
    {"龙虎山精英3", 12000, 3},
    {"龙虎山高爆BOOS1", 30000, 3},
    {"龙虎山秘境BOSS1", 60000, 3},
    {"青阳宫小怪1", 6600, 3},
    {"青阳宫小怪2", 6600, 3},
    {"青阳宫小怪3", 6600, 3},
    {"青阳宫小怪4", 6600, 3},
    {"青阳宫精英1", 13200, 3},
    {"青阳宫精英2", 13200, 3},
    {"青阳宫精英3", 13200, 3},
    {"青阳宫高爆BOOS1", 33000, 3},
    {"青阳宫秘境BOSS1", 66000, 3},
    {"武帝城小怪1", 7200, 3},
    {"武帝城小怪2", 7200, 3},
    {"武帝城小怪3", 7200, 3},
    {"武帝城小怪4", 7200, 3},
    {"武帝城精英1", 14400, 3},
    {"武帝城精英2", 14400, 3},
    {"武帝城精英3", 14400, 3},
    {"武帝城高爆BOOS1", 36000, 3},
    {"武帝城秘境BOSS1", 72000, 3},
    {"南诏龙宫小怪1", 8000, 3},
    {"南诏龙宫小怪2", 8000, 3},
    {"南诏龙宫小怪3", 8000, 3},
    {"南诏龙宫小怪4", 8000, 3},
    {"南诏龙宫精英1", 16000, 3},
    {"南诏龙宫精英2", 16000, 3},
    {"南诏龙宫精英3", 16000, 3},
    {"南诏龙宫高爆BOOS1", 40000, 3},
    {"南诏龙宫秘境BOSS1", 80000, 3},
    {"东越剑池小怪1", 10000, 3},
    {"东越剑池小怪2", 10000, 3},
    {"东越剑池小怪3", 10000, 3},
    {"东越剑池小怪4", 10000, 3},
    {"东越剑池精英1", 20000, 3},
    {"东越剑池精英2", 20000, 3},
    {"东越剑池精英3", 20000, 3},
    {"东越剑池高爆BOOS1", 50000, 3},
    {"东越剑池秘境BOSS1", 100000, 3},
    {"吴家剑冢小怪1", 12000, 3},
    {"吴家剑冢小怪2", 12000, 3},
    {"吴家剑冢小怪3", 12000, 3},
    {"吴家剑冢小怪4", 12000, 3},
    {"吴家剑冢精英1", 24000, 3},
    {"吴家剑冢精英2", 24000, 3},
    {"吴家剑冢精英3", 24000, 3},
    {"吴家剑冢高爆BOOS1", 60000, 3},
    {"吴家剑冢秘境BOSS1", 120000, 3},
    {"牯牛大岗小怪1", 14000, 2},
    {"牯牛大岗小怪2", 14000, 2},
    {"牯牛大岗小怪3", 14000, 2},
    {"牯牛大岗小怪4", 14000, 2},
    {"牯牛大岗精英1", 28000, 2},
    {"牯牛大岗精英2", 28000, 2},
    {"牯牛大岗精英3", 28000, 2},
    {"牯牛大岗高爆BOOS1", 70000, 2},
    {"牯牛大岗秘境BOSS1", 140000, 2},
    {"酆都荒古小怪1", 16000, 2},
    {"酆都荒古小怪2", 16000, 2},
    {"酆都荒古小怪3", 16000, 2},
    {"酆都荒古小怪4", 16000, 2},
    {"酆都荒古精英1", 32000, 2},
    {"酆都荒古精英2", 32000, 2},
    {"酆都荒古精英3", 32000, 2},
    {"酆都荒古高爆BOOS1", 80000, 2},
    {"酆都荒古秘境BOSS1", 160000, 2},
    {"上阴学宫小怪1", 18000, 2},
    {"上阴学宫小怪2", 18000, 2},
    {"上阴学宫小怪3", 18000, 2},
    {"上阴学宫小怪4", 18000, 2},
    {"上阴学宫精英1", 36000, 2},
    {"上阴学宫精英2", 36000, 2},
    {"上阴学宫精英3", 36000, 2},
    {"上阴学宫高爆BOOS1", 90000, 2},
    {"上阴学宫秘境BOSS1", 180000, 2},
    {"春帖草堂小怪1", 20000, 2},
    {"春帖草堂小怪2", 20000, 2},
    {"春帖草堂小怪3", 20000, 2},
    {"春帖草堂小怪4", 20000, 2},
    {"春帖草堂精英1", 40000, 2},
    {"春帖草堂精英2", 40000, 2},
    {"春帖草堂精英3", 40000, 2},
    {"春帖草堂高爆BOOS1", 100000, 2},
    {"春帖草堂秘境BOSS1", 200000, 2},
    {"柔然山脉小怪1", 22000, 2},
    {"柔然山脉小怪2", 22000, 2},
    {"柔然山脉小怪3", 22000, 2},
    {"柔然山脉小怪4", 22000, 2},
    {"柔然山脉精英1", 44000, 2},
    {"柔然山脉精英2", 44000, 2},
    {"柔然山脉精英3", 44000, 2},
    {"柔然山脉高爆BOOS1", 110000, 2},
    {"柔然山脉秘境BOSS1", 220000, 2},
    {"棋剑乐府小怪1", 24000, 2},
    {"棋剑乐府小怪2", 24000, 2},
    {"棋剑乐府小怪3", 24000, 2},
    {"棋剑乐府小怪4", 24000, 2},
    {"棋剑乐府精英1", 48000, 2},
    {"棋剑乐府精英2", 48000, 2},
    {"棋剑乐府精英3", 48000, 2},
    {"棋剑乐府高爆BOOS1", 120000, 2},
    {"棋剑乐府秘境BOSS1", 240000, 2},
    {"徽山大雪坪小怪1", 24000, 2},
    {"徽山大雪坪小怪2", 24000, 2},
    {"徽山大雪坪小怪3", 24000, 2},
    {"徽山大雪坪小怪4", 24000, 2},
    {"徽山大雪坪精英1", 48000, 2},
    {"徽山大雪坪精英2", 48000, 2},
    {"徽山大雪坪精英3", 48000, 2},
    {"徽山大雪坪高爆BOOS1", 120000, 2},
    {"徽山大雪坪秘境BOSS1", 240000, 2},
    {"大秦皇陵小怪1", 30000, 2},
    {"大秦皇陵小怪2", 30000, 2},
    {"大秦皇陵小怪3", 30000, 2},
    {"大秦皇陵小怪4", 30000, 2},
    {"大秦皇陵精英1", 60000, 2},
    {"大秦皇陵精英2", 60000, 2},
    {"大秦皇陵精英3", 60000, 2},
    {"大秦皇陵高爆BOOS1", 150000, 2},
    {"大秦皇陵秘境BOSS1", 300000, 2},
    {"北莽帝王庭小怪1", 40000, 2},
    {"北莽帝王庭小怪2", 40000, 2},
    {"北莽帝王庭小怪3", 40000, 2},
    {"北莽帝王庭小怪4", 40000, 2},
    {"北莽帝王庭精英1", 80000, 2},
    {"北莽帝王庭精英2", 80000, 2},
    {"北莽帝王庭精英3", 80000, 2},
    {"北莽帝王庭高爆BOOS1", 200000, 2},
    {"北莽帝王庭秘境BOSS1", 400000, 2},
    {"离阳太安城小怪1", 50000, 2},
    {"离阳太安城小怪2", 50000, 2},
    {"离阳太安城小怪3", 50000, 2},
    {"离阳太安城小怪4", 50000, 2},
    {"离阳太安城精英1", 100000, 2},
    {"离阳太安城精英2", 100000, 2},
    {"离阳太安城精英3", 100000, 2},
    {"离阳太安城高爆BOOS1", 250000, 2},
    {"离阳太安城秘境BOSS1", 500000, 2},
    {"道教根骨地小怪1", 20000, 2},
    {"道教根骨地小怪2", 20000, 2},
    {"道教根骨地精英1", 40000, 2},
    {"道教根骨地高爆BOOS1", 100000, 2},
    {"道教根骨地秘境BOSS1", 200000, 2},
    {"道教根骨地小怪2-1", 20000, 2},
    {"道教根骨地小怪2-2", 20000, 2},
    {"道教根骨地精英2-1", 40000, 2},
    {"道教根骨地高爆2-BOOS1", 100000, 2},
    {"道教根骨地秘境2-BOSS1", 200000, 2},
    {"佛门机缘地小怪1", 50000, 2},
    {"佛门机缘地小怪2", 50000, 2},
    {"佛门机缘地精英1", 100000, 2},
    {"佛门机缘地高爆BOOS1", 250000, 2},
    {"佛门机缘地秘境BOSS1", 500000, 2},
    {"佛门机缘地小怪2-1", 50000, 2},
    {"佛门机缘地小怪2-2", 50000, 2},
    {"佛门机缘地精英2-1", 100000, 2},
    {"佛门机缘地高爆2-BOOS1", 250000, 2},
    {"佛门机缘地秘境2-BOSS1", 500000, 2},
    {"儒家气运地小怪1", 100000, 2},
    {"儒家气运地小怪2", 100000, 2},
    {"儒家气运地精英1", 200000, 2},
    {"儒家气运地高爆BOOS1", 500000, 2},
    {"儒家气运地秘境BOSS1", 1000000, 2},
    {"儒家气运地小怪2-1", 100000, 2},
    {"儒家气运地小怪2-2", 100000, 2},
    {"儒家气运地精英2-1", 200000, 2},
    {"儒家气运地高爆2-BOOS1", 500000, 2},
    {"儒家气运地秘境2-BOSS1", 1000000, 2},
    {"洞天福地小怪1", 10000, 2},
    {"洞天福地小怪2", 10000, 2},
    {"洞天福地小怪3", 10000, 2},
    {"洞天福地小怪4", 20000, 2},
    {"洞天福地精英1", 20000, 2},
    {"洞天福地高爆BOOS1", 50000, 2},
    {"洞天福地秘境BOSS1", 100000, 2},
    {"洞天技能高爆BOOS1", 50000, 2},
    {"洞天剑甲高爆BOOS1", 50000, 2},
    {"洞天特殊高爆BOOS1", 50000, 2},
    {"洞天首饰高爆BOOS1", 50000, 2},
    {"剑六专属·翰林", 30000, 2},
    {"剑六专属·「圣人」", 30000, 2},
    {"剑六专属【精英】", 60000, 2},
    {"剑六专属「高爆BOSS」", 150000, 2},
    {"剑六专属『秘境BOSS』", 300000, 2},
    {"剑七专属·翰林", 50000, 2},
    {"剑七专属·「圣人」", 50000, 2},
    {"剑七专属【精英】", 100000, 2},
    {"剑七专属「高爆BOSS」", 250000, 2},
    {"剑七专属『秘境BOSS』", 500000, 2},
    {"剑八专属·翰林", 80000, 2},
    {"剑八专属·「圣人」", 80000, 2},
    {"剑八专属【精英】", 160000, 2},
    {"剑八专属「高爆BOSS」", 400000, 2},
    {"剑八专属『秘境BOSS』", 800000, 2},
    {"剑九专属·翰林", 100000, 2},
    {"剑九专属·「圣人」", 100000, 2},
    {"剑九专属【精英】", 200000, 2},
    {"剑九专属「高爆BOSS」", 500000, 2},
    {"剑九专属『秘境BOSS』", 1000000, 2},
}

function on_post_monster_die(monster,  killer)
    local mapguid = lualib:Map_GetMapGuid("龙城")
    local dgn = lualib:GetStr(mapguid, "dgn_3")


    local keyName = lualib:KeyName(monster)
    local Name = lualib:Name(monster)
    if lualib:Player_IsPlayer(killer) then

        if keyName == "斥候" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 8)
            lualib:SysTriggerMsg(killer, "击杀斥候获得了8点积分！当前积分为"..lualib:GetInt(killer, "wu_"..dgn).."点！")
        end
        if keyName == "鹰隼" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 30)
            lualib:SysTriggerMsg(killer, "击杀鹰隼获得了30点积分！当前积分为"..lualib:GetInt(killer, "wu_"..dgn).."点！")
        end
        if keyName == "密谍" then
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + 200)
            lualib:SysTriggerMsg(killer, "击杀密谍获得了200点积分！当前积分为"..lualib:GetInt(killer, "wu_"..dgn).."点！")
        end
        if keyName == "斥候" or keyName == "鹰隼" or keyName == "密谍" then
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
                            diyi = "第1名为:"..glamour_ranking_t[i][2].."点积分!"
                        end
                        if glamour_ranking_t[i][1] == lualib:Name(killer) then
                            mc = "当前排名第"..i.."名!"
                        end

                    end
                end
            end
            lualib:SysTriggerMsg(killer, ""..mc..diyi)
        end

        if keyName == "皇城之夜BOSS1" then
            --local zssl = lualib:GenRandom(880000, 1100000)
            --lualib:AddIntegral(killer, zssl, "添加绑定金币:原因", "发起者")
            --lualib:SysMsg_SendBroadcastMsg("玩家["..lualib:Name(killer).."]完美的击杀了【“"..Name.."”】！获得了"..zssl.."钻石！", "系统消息")
        end
        for i = 1, #ss_gw do
            if ss_gw[i][1] == keyName then
                if ss_gw[i][3] - lualib:GetDBNum("首杀累积"..keyName) > 0 then
                    lualib:SetDBNumEx("首杀累积"..keyName, lualib:GetDBNum("首杀累积"..keyName) + 1, 4)
                    lualib:AddIntegral(killer, ss_gw[i][2], "添加绑定金币:原因", "发起者")
                    lualib:SysMsg_SendBroadcastMsg("玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..Name.."”】！获得了"..ss_gw[i][2].."钻石！", "系统消息")

                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..Name.."”】！获得了"..ss_gw[i][2].."钻石！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..Name.."”】！获得了"..ss_gw[i][2].."钻石！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..Name.."”】！获得了"..ss_gw[i][2].."钻石！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..Name.."”】！获得了"..ss_gw[i][2].."钻石！","")


                    if lualib:GetDBNum("首杀累积"..keyName) == 1 then
                        lualib:SetDBStrEx("击杀名称"..ss_gw[i][1], lualib:Name(killer), 1)
                    elseif lualib:GetDBNum("首杀累积"..keyName) <= 3 then
                        lualib:SetDBStrEx("击杀名称"..ss_gw[i][1], lualib:GetDBStr("击杀名称"..ss_gw[i][1]).."‖"..lualib:Name(killer), 1)
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
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                if item_site_2 == "" then
                    local wuguid = {item, item_name, 4, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                local leverss_1 = lualib:Item_GetLevel(item_site_1)
                local leverss_2 = lualib:Item_GetLevel(item_site_2)
                if leverss_1 < lever then
                    local wuguid = {item, item_name, 3, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                if leverss_2 < lever then
                    local wuguid = {item, item_name, 4, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end


            elseif item_subtype == 9 then

                if item_site_1 == "" then
                    local wuguid = {item, item_name, 10, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                if item_site_2 == "" then
                    local wuguid = {item, item_name, 11, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                local leverss_1 = lualib:Item_GetLevel(item_site_1)
                local leverss_2 = lualib:Item_GetLevel(item_site_2)
                if leverss_1 < lever then
                    local wuguid = {item, item_name, 10, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end
                if leverss_2 < lever then
                    local wuguid = {item, item_name, 11, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                end


            else

                local item_site = lualib:Player_GetItemGuid(player, sz[item_subtype][1])
                if item_site == "" then
                    local wuguid = {item, item_name, 0, item_nameqqq}
                    local script = "wuguid = "..serialize(wuguid)
                    lualib:ShowFormWithContent(player, "脚本表单", script)
                    lualib:ShowFormWithContent(player,"form文件表单","装备替换")
                    return ""
                else
                    local leverss = lualib:Item_GetLevel(item_site)
                    if leverss < lever then
                        local wuguid = {item, item_name, 0, item_nameqqq}
                        local script = "wuguid = "..serialize(wuguid)
                        lualib:ShowFormWithContent(player, "脚本表单", script)
                        lualib:ShowFormWithContent(player,"form文件表单","装备替换")
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

        local mapguid = lualib:Map_GetMapGuid("龙城")
        local map_guid = lualib:MapGuid(killer)
        local dgn = lualib:GetStr(mapguid, "dgn_3")
        if dgn ~= "" and dgn == map_guid then
            local glamour = lualib:GetInt(player, "wu_"..dgn) * 0.1
            glamour = math.floor(glamour)
            lualib:SetInt(player, "wu_"..dgn, lualib:GetInt(player, "wu_"..dgn) - glamour)
            lualib:SetInt(killer, "wu_"..dgn, lualib:GetInt(killer, "wu_"..dgn) + glamour)
            lualib:SysTriggerMsg(player, "你被["..lualib:Name(killer).."]击杀,损失了"..glamour.."点积分！你当前积分为"..lualib:GetInt(player, "wu_"..dgn).."点")
            lualib:SysTriggerMsg(killer, "你击杀了["..lualib:Name(player).."],获得了"..glamour.."点积分！你当前积分为"..lualib:GetInt(killer, "wu_"..dgn).."点")
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
                            diyi = "第1名为:"..glamour_ranking_t[i][2].."点积分!"
                        end
                        if glamour_ranking_t[i][1] == lualib:Name(killer) then
                            mc = "当前排名第"..i.."名!"
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
        lualib:MsgBox(player, "你已经处于骑乘状态了！")
        return
    end

    --上马读条
    lualib:ProgressBarStart(player, 1000, "上马中", "on_Horse_true", "on_Horse_false", "")
end

--上马
function on_Horse_true(player)
    lualib:Ride(player)
end

--上马被打断
function on_Horse_false(player)
    lualib:SysTriggerMsg(player, "上马被打断")
end

-- 下马
function on_unride_request(player)
    local hashorse = lualib:Attr(player, 200)
    if hashorse == 2 then
        lualib:MsgBox(player, "你还没有骑乘，不能下马状态了！")
    else
        lualib:UnRide(player)
    end
end

function on_player_relive(player)
    lualib:SetInt(player, "die_flag", 0)
    local map = lualib:Map_GetMapGuid("龙城")
    if lualib:IsCastleWarStart("神歌城") then
        local own_family = lualib:GetCastleOwnFamily("神歌城")
        local my_family = lualib:GetFamilyName(player)

        if own_family == "" or my_family == "" then
            return true
        else
            if lualib:GetCastleOwnFamily("神歌城")== my_family or lualib:GetCastleTempFamily("神歌城") == my_family then
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
    ["南诏龙宫1层"] = 50,
    ["南诏龙宫2层"] = 50,
    ["东越剑池1层"] = 100,
    ["东越剑池2层"] = 100,
    ["吴家剑冢1层"] = 150,
    ["吴家剑冢2层"] = 150,
    ["牯牛大岗1层"] = 200,
    ["牯牛大岗2层"] = 200,
    ["酆都荒古1层"] = 250,
    ["酆都荒古2层"] = 250,
    ["上阴学宫1层"] = 300,
    ["上阴学宫2层"] = 300,
    ["春帖草堂1层"] = 350,
    ["春帖草堂2层"] = 350,
    ["柔然山脉1层"] = 400,
    ["柔然山脉2层"] = 400,
    ["棋剑乐府1层"] = 450,
    ["棋剑乐府2层"] = 450,
    ["徽山大雪坪1层"] = 500,
    ["徽山大雪坪2层"] = 500,
    ["大秦皇陵1层"] = 550,
    ["大秦皇陵2层"] = 550,
    ["北莽帝王庭1层"] = 400,
    ["北莽帝王庭2层"] = 400,
    ["离阳太安城1层"] = 500,
    ["离阳太安城2层"] = 500,
    ["剑六地图"] = 200,
    ["剑七地图"] = 200,
    ["剑八地图"] = 500,
    ["剑九地图"] = 500,
    ["道教根骨地1层"] = 200,
    ["道教根骨地2层"] = 200,
    ["佛门机缘地1层"] = 500,
    ["佛门机缘地2层"] = 500,
    ["儒家气运地1层"] = 800,
    ["儒家气运地2层"] = 800,
}

function dakai(bResult,dwError,strError,iResultNum,tRecordSets,player)
    local msg_error = ""
    if bResult == false then
        msg_error = msg_error .. "错误码："..dwError.."\n"
        msg_error = msg_error .. "错误信息："..strError.."\n"
        lualib:NPCTalk(player, msg_error)
        return
    end
    local id = tostring(lualib:UserID(player))
    local day_num = 0
    for k,v in pairs(tRecordSets) do
        day_num = day_num + tonumber(v[2])
    end
    lualib:SetDBNum("bill_ingot_dongtian_"..id, day_num)				--存储充值元宝数量
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
    {"已封顶满级", 3000, 24000, 6, 35, 1.35},
    {"已封顶满级", 3000, 24000, 6, 35, 1.35},
}

function compare(a, b)
    return a[2] > b[2]
end

---------------------------------------------1秒定时器



local dituxianshi = {
    ["观音宗1层"] = {480},
    ["道德宗1层"] = {2040},
    ["提兵山1层"] = {1320},
    ["两禅寺1层"] = {600},
    ["烂陀山1层"] = {360},
    ["观音宗2层"] = {480},
    ["道德宗2层"] = {2040},
    ["提兵山2层"] = {1320},
    ["两禅寺2层"] = {600},
    ["烂陀山2层"] = {360},
}


local wudi_map = {  --允许无敌挂机地图 按格式添加
    ["烂陀山1层"] = 1,
    ["烂陀山2层"] = 1,
    ["观音宗1层"] = 1,
    ["观音宗2层"] = 1,
    ["两禅寺1层"] = 1,
    ["两禅寺2层"] = 1,
    ["提兵山1层"] = 1,
    ["提兵山2层"] = 1,
    ["道德宗1层"] = 1,
    ["道德宗2层"] = 1,
    ["公主坟1层"] = 1,
    ["公主坟2层"] = 1,
    ["胭脂郡"] = 1,
    ["听潮亭"] = 1,
    ["洗象池"] = 1,
    ["龙虎山1层"] = 1,
    ["青阳宫1层"] = 1,
    ["武帝城1层"] = 1,
    ["龙虎山2层"] = 1,
    ["青阳宫2层"] = 1,
    ["武帝城2层"] = 1,
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
        if lualib:HasBuff(player,"无敌挂机") then
            lualib:DelBuff(player, "无敌挂机")
        end
    end


    if item_map_name == "北凉城" then
        lualib:SetInt(player, "autoattack", 0)
        if lualib:HasBuff(player,"自动挂机") then
            lualib:DelBuff(player, "自动挂机")
        end
        if lualib:HasBuff(player,"无敌挂机") then
            lualib:DelBuff(player, "无敌挂机")
        end
    end



    if lualib:GetInt(player, "autoattack") == 1 then
        if lualib:GetInt(player, "huishou_12") == 1 then
            if lualib:GetInt(player,"wudiguaji") > 0 then
                if lualib:HasBuff(player,"无敌挂机") then
                else
                    lualib:AddBuff(player, "无敌挂机", 0)
                end
            end
        end
        if lualib:GetInt(player,"wudiguaji") <= 0 then
            lualib:SetInt(player,"wudiguaji", 0)
            if lualib:HasBuff(player,"无敌挂机") then
                lualib:DelBuff(player, "无敌挂机")
            end
        end
    else
        if lualib:HasBuff(player,"无敌挂机") then
            lualib:DelBuff(player, "无敌挂机")
        end
    end

    if dituxianshi[item_map_name] ~= nil then
        if dituxianshi[item_map_name][1] - lualib:GetDBNum("开放时间") <= 0 then
            lualib:Player_MapMoveXY(player, "龙城", 255, 270, 3)
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

        if item_map_name ~= "新手接待室" then
            lualib:Player_MapMove(player, "新手接待室")
            -- lualib:Player_MapMoveXY(player, "龙城", 255, 270, 3)
        end

    end


    local wfsxs = {
        ["王妃1"] = 1,
        ["王妃2"] = 2,
        ["王妃3"] = 3,
        ["王妃4"] = 4,
        ["王妃5"] = 6,
        ["王妃6"] = 8,
        ["王妃7"] = 11,
        ["王妃8"] = 15,
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





    if item_map_name == "新手接待室" then
        -- lualib:Player_MapMoveXY(player, "龙城", 255, 270, 3)
    end

    if item_map_name == "北凉城" then
        if lualib:HasBuff(player,"自动挂机") then
            lualib:DelBuff(player, "自动挂机")
        end
    end

    local sh = lualib:Attr(player, 87)
    local jm = lualib:Attr(player, 124)
    local hs = lualib:Attr(player, 215)
    local tili = lualib:Attr(player, 81)
    local daguai = 0

    local wpszbd = {
        ["武评榜单1"] = 10000,
        ["武评榜单2"] = 6000,
        ["武评榜单3"] = 4000,
        ["武评榜单4"] = 3000,
        ["武评榜单5"] = 2500,
        ["武评榜单6"] = 2000,
        ["武评榜单7"] = 1000,
        ["武评榜单8"] = 800,
        ["武评榜单9"] = 600,
        ["武评榜单10"] = 400,
    }
    for i = 1, 10 do
        if lualib:HasBuff(player,"武评榜单"..i) then
            daguai = daguai + wpszbd["武评榜单"..i]
        end
    end
    if lualib:HasBuff(player,"剑开天门") then
        daguai = daguai + 3888
    end
    if lualib:HasBuff(player,"佛门金刚") then
        daguai = daguai + 1000
    end
    if lualib:HasBuff(player,"道教指玄") then
        daguai = daguai + 3000
    end
    if lualib:HasBuff(player,"儒家天象") then
        daguai = daguai + 5000
    end
    if lualib:HasBuff(player,"陆地仙人") then
        daguai = daguai + 8000
    end

    local rtcswk = {600, 1000, 1600, 2200, 3000, 3600, 5000, 6400, 9000, 12000, 15000, 18000}
    local tcwk_dj = lualib:GetInt(player,"tcwk_dj")
    if tcwk_dj > 0 then
        daguai = daguai + rtcswk[tcwk_dj]
    end


    local yhuisz = {
        ["菩提1"] = 300,
        ["菩提2"] = 400,
        ["菩提3"] = 700,
        ["菩提4"] = 1000,
        ["菩提5"] = 1600,
        ["菩提6"] = 2400,
        ["菩提7"] = 3000,
        ["菩提8"] = 3600,
        ["菩提9"] = 4400,
        ["菩提10"] = 6000,
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
        if lualib:KeyName(yifu) == "赠送衣服" then
            daguai = daguai + 666
        end
    end
    local wuqi = lualib:Weapon(player)
    if wuqi ~= "" then
        if lualib:KeyName(wuqi) == "赠送武器" then
            daguai = daguai + 1288
        end
    end


    --[[  if lualib:GetClientType(player) == 2 then
                 lualib:ShowFormWithContent(player, "脚本表单", "RoleTitle.gengxin("..sh..", "..jm..", "..hs..", "..tili..", "..daguai..")");
              else
                 lualib:ShowFormWithContent(player, "脚本表单", "RoleAtt.gengxin("..sh..", "..jm..", "..hs..", "..tili..", "..daguai..")");
              end

]]

    local fuhjz = {
        ["复活1"] = 1,
        ["复活2"] = 1,
        ["复活3"] = 1,
        ["复活4"] = 1,
        ["复活5"] = 1,
        ["复活6"] = 1,
        ["复活7"] = 1,
        ["复活8"] = 1,
        ["复活9"] = 1,
        ["复活10"] = 1,
    }
    local youfuhuo = ""
    local gem0 = lualib:Player_GetItemGuid(player, 10)
    if gem0 ~= "" then
        if fuhjz[lualib:KeyName(gem0)] ~= nil then
            youfuhuo = "有复活装备"
        end
    end
    local gem1 = lualib:Player_GetItemGuid(player, 11)
    if gem1 ~= "" then
        if fuhjz[lualib:KeyName(gem1)] ~= nil then
            youfuhuo = "有复活装备"
        end
    end
    local gold = lualib:GetGold(player)
    local integral = lualib:GetIntegral(player)
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player, "脚本表单", "GameMall.gengxin("..gold..")");
        lualib:ShowFormWithContent(player, "脚本表单", "Package.gengxin("..integral..")");
    else
        lualib:ShowFormWithContent(player, "脚本表单", "Package.gengxin("..integral..")");
    end

    --[[   local ingot = lualib:GetIngot(player)
              if lualib:GetClientType(player) == 2 then
                 lualib:ShowFormWithContent(player, "脚本表单", "Package.gengxins("..ingot..")");
              end
]]



    if youfuhuo ~= "" then
        if lualib:HasBuff(player, "长生石复活") then
            if lualib:GetClientType(player) == 2 then
                lualib:ShowFormWithContent(player, "脚本表单", "PlayerHeaderInfo.fuhuo(0)");
            else
                lualib:ShowFormWithContent(player, "脚本表单", "GameMainBar.fuhuo(0)");
            end
        else
            if lualib:GetClientType(player) == 2 then
                lualib:ShowFormWithContent(player, "脚本表单", "PlayerHeaderInfo.fuhuo(1)");
            else
                lualib:ShowFormWithContent(player, "脚本表单", "GameMainBar.fuhuo(1)");
            end
        end
    else
        if lualib:GetClientType(player) == 2 then
            lualib:ShowFormWithContent(player, "脚本表单", "PlayerHeaderInfo.fuhuo(0)");
        else
            lualib:ShowFormWithContent(player, "脚本表单", "GameMainBar.fuhuo(0)");
        end
    end


    local phyatk_hei = lualib:PhyAtk(player, true)    --取上限
    local name = lualib:Name(player)
    local level = lualib:Level(player)
    local dht = lualib:GetInt(player,"dht")
    local hhmc = lualib:GetFamilyName(player)
    if hhmc == "" then
        hhmc = "无"
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
            lualib:SysTriggerMsg(player, "你成功将大黄庭提升至["..lualib:GetInt(player,"dht").."]级!")
            local msg = "玩家["..lualib:Name(player).."]将大黄庭提升至["..lualib:GetInt(player,"dht").."]级!,获得了大量属性加成！！"
            lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(player).."]将大黄庭提升至["..lualib:GetInt(player,"dht").."]级!,获得了大量属性加成！！",  "")
            lualib:SysMsg_SendBroadcastMsg(msg, "最新情报")
        end
    end


    if lualib:GetInt(player, "fangdu_cd") <= 0 then
        if lualib:HasBuff(player,"施毒术减血4级") then
            if lualib:GenRandom(1, 100) <= lualib:GetInt(player, "fangdu") then
                lualib:DelBuff(player, "施毒术减血4级")
                lualib:SysTriggerMsg(player, "你的飞剑防御了施毒术的中毒效果!")
                lualib:SetInt(player, "fangdu_cd", 5)
            end
        end
        if lualib:HasBuff(player,"施毒术减防4级") then
            if lualib:GenRandom(1, 100) <= lualib:GetInt(player, "fangdu") then
                lualib:DelBuff(player, "施毒术减防4级")
                lualib:SysTriggerMsg(player, "你的飞剑防御了施毒术的中毒效果!")
                lualib:SetInt(player, "fangdu_cd", 5)
            end
        end
    else
        lualib:SetInt(player, "fangdu_cd", lualib:GetInt(player, "fangdu_cd") - 1)
    end

    --lualib:SetInt(player, "zlsc", lualib:GetInt(player, "zlsc") + 1)
    --if lualib:GetInt(player, "zlsc") >= 20 then
    --lualib:Player_FixEquip(player, true)
    --lualib:ShowFormWithContent(player,"脚本表单","TaskWindow.zhengli(111)")
    --end


    if lualib:GetInt(player, "autoattack") == 1 then

        if lualib:HasBuff(player,"自动挂机") then
        elseif item_map_name ~= "北凉城" then
            lualib:AddBuff(player, "自动挂机", 0)
        end

        lualib:Player_FixEquip(player, true)
        if lualib:Player_GetBagFree(player) < lualib:GetInt(player, "huishou_16") then
            lualib:Player_FixEquip(player, true)
            lualib:ShowFormWithContent(player,"脚本表单","TaskWindow.zhengli(111)")
            for i = 1, 27 do
                if lualib:GetInt(player, "jilu_"..i) == 1 then
                    lualib:DelayCall(player, 1, "回收表单:huishou", ""..i);
                end
            end
            if lualib:GetInt(player, "zz_2") == 1 then
                for i = 1, 9 do
                    if lualib:GetInt(player, "huishou_"..i) == 1 then
                        lualib:DelayCall(player, 1, "自动挂机:xianhs", ""..i);
                    end
                end
            end

        end
    else
        if lualib:HasBuff(player,"自动挂机") then
            lualib:DelBuff(player, "自动挂机")
        end
    end






    if lualib:GetInt(player, "xianren") > 0 then
        lualib:SetInt(player, "xianren", lualib:GetInt(player, "xianren") - 1)
    end


    local id = lualib:UserID(player)		--取得玩家的帐号ID.
    local today = lualib:GetAllDays(0)
    local starttime = lualib:Str2Time(lualib:Time2Str("%Y-%m-%d", lualib:GetAllTime()))
    lualib:PostDBEvt("select order_id,billin from tblbilllog where user_id=" .. id .. " and billin >= 0 and time > " .. starttime , "dakai", player)


    local bill_ingot = lualib:GetDBNum("bill_ingot_dongtian_"..id)  +  lualib:GetDayInt(player, "richong1")
    if bill_ingot >= 10000 then
        if lualib:HasBuff(player,"洞天福地") then
        else
            lualib:AddBuff(player, "洞天福地", 0)
        end
    else
        if lualib:HasBuff(player,"洞天福地") then
            lualib:DelBuff(player, "洞天福地")
        end
    end

    local map_guid = lualib:MapGuid(player)
    local map_name = lualib:Name(map_guid)
    if map_name == "洞天福地" then
        if lualib:HasBuff(player,"剑开天门") == false then
            lualib:Player_MapMoveXY(player, "龙城", 255, 270, 5)
        end
        if lualib:HasBuff(player,"洞天福地") == false then
            lualib:Player_MapMoveXY(player, "龙城", 255, 270, 5)
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
                    lualib:SysTriggerMsg(player, "银锭不足300个，已自动切换为免费回血!")
                    lualib:SetInt(player, "xz_huixue", 1)
                    return ""
                end
                lualib:SubGold(player, 300, "扣除银锭原因", lualib:Name(player));
                local hp = lmt_hp * 0.03
                lualib:SetHp(player, cur_hp + hp, false)
                lualib:ShowRoleHPRef(player, player, hp)
            end
        elseif xz_huixue == 3 then
            if cur_hp < lmt_hp then
                if lualib:ItemCount(player, "天山雪莲") < 30 then
                    lualib:SysTriggerMsg(player, "天山雪莲不足30个，已自动切换为免费回血!")
                    lualib:SetInt(player, "xz_huixue", 1)
                    return ""
                end
                lualib:DelItem(player, "天山雪莲", 30, 2, "烟花", "烟花")
                local hp = lmt_hp * 0.05
                lualib:SetHp(player, cur_hp + hp, false)
                lualib:ShowRoleHPRef(player, player, hp)
            end
        end
    end




    --lualib:Player_RunScript(player,"状态刷新表单:main","")

    local name = lualib:Name(player)

    local mapguid = lualib:Map_GetMapGuid("龙城")
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
                        lualib:Mail("斩杀榜", glamour_ranking_t[i][1], "你在今日斩杀榜中获得了第1名,获得了300000钻石奖励！", 0, 0, {"100000钻石",3,1})
                    elseif i == 2 then
                        lualib:Mail("斩杀榜", glamour_ranking_t[i][1], "你在今日斩杀榜中获得了第2名,获得了200000钻石奖励！", 0, 0, {"100000钻石",2,1})
                    elseif i == 3 then
                        lualib:Mail("斩杀榜", glamour_ranking_t[i][1], "你在今日斩杀榜中获得了第3名,获得了100000钻石奖励！", 0, 0, {"100000钻石",1,1})
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
    lualib:SetStr(player, "_na_", "斩杀:"..zhansha.." 遇刺:"..siwang)
    lualib:NotifyVar(player, "_na_")


    local map_guid = lualib:MapGuid(player)
    local dtkey = lualib:KeyName(map_guid)
    if ditukoufei[dtkey] ~= nil then
        local gold = lualib:GetGold(player)
        if gold < ditukoufei[dtkey] then
            lualib:MsgBox(player, "该地图每秒需扣除银锭"..ditukoufei[dtkey].."个,你银锭不足,已被传送回城。")
            lualib:Player_MapMoveXY(player, "龙城", 255, 270, 3)
            return ""
        else
            if lualib:GetClientType(player) == 2 then
                lualib:SysTipsMsg(player, "扣除银锭"..ditukoufei[dtkey])
            end
            lualib:SubGold(player, ditukoufei[dtkey], "扣除银锭原因", lualib:Name(player));
        end
    end


    local level = lualib:Level(player)
    if level < 50 then
        lualib:AddExp(player, 1888, "添加经验:原因", "发起者")
    end

    if lualib:GetInt(player, "yysq") >= 30 then
        if lualib:HasSkill(player, "天下无禅", false) == false then
            lualib:Player_AddSkill(player, "天下无禅")
        end
    end
    if lualib:GetInt(player, "yysq") >= 60 then
        if lualib:HasSkill(player, "一指断江", false) == false then
            lualib:Player_AddSkill(player, "一指断江")
        end
    end

    if lualib:GetInt(player, "yysq") >= 90 then
        if lualib:HasSkill(player, "仙人抚顶", false) == false then
            lualib:Player_AddSkill(player, "仙人抚顶")
        end
    end

    if lualib:HasBuff(player,"剑开天门") then
        if lualib:HasSkill(player, "半月弯刀4级", false) == false then
            lualib:Player_AddSkill(player, "半月弯刀4级")
        end
    else
        if lualib:HasSkill(player, "半月弯刀4级", false) == true then
            lualib:DelSkill(player, "半月弯刀4级")
        end
    end



    if lualib:ItemCount(player, "50银锭") > 0 then
        lualib:ApplyItem(player, "50银锭", false);
    end
    if lualib:ItemCount(player, "100银锭") > 0 then
        lualib:ApplyItem(player, "100银锭", false);
    end
    if lualib:ItemCount(player, "200银锭") > 0 then
        lualib:ApplyItem(player, "200银锭", false);
    end
    if lualib:ItemCount(player, "500银锭") > 0 then
        lualib:ApplyItem(player, "500银锭", false);
    end
    if lualib:ItemCount(player, "1000银锭") > 0 then
        lualib:ApplyItem(player, "1000银锭", false);
    end
    if lualib:ItemCount(player, "2000银锭") > 0 then
        lualib:ApplyItem(player, "2000银锭", false);
    end
    if lualib:ItemCount(player, "100钻石") > 0 then
        lualib:ApplyItem(player, "100钻石", false);
    end
    if lualib:ItemCount(player, "200钻石") > 0 then
        lualib:ApplyItem(player, "200钻石", false);
    end
    if lualib:ItemCount(player, "200黄庭丹") > 0 then
        lualib:ApplyItem(player, "200黄庭丹", false);
    end
    if lualib:ItemCount(player, "500黄庭丹") > 0 then
        lualib:ApplyItem(player, "500黄庭丹", false);
    end
    if lualib:ItemCount(player, "100黄庭丹") > 0 then
        lualib:ApplyItem(player, "100黄庭丹", false);
    end

    if lualib:GetInt(player, "yysq") >= 90 then
        if lualib:GetDBStr("三清1") == "" then
            lualib:SetDBStrEx("三清1", lualib:Name(player), 1)

        elseif lualib:GetDBStr("三清2") == "" then
            if lualib:GetDBStr("三清1") ~= lualib:Name(player) then
                lualib:SetDBStrEx("三清2", lualib:Name(player), 1)
            end

        elseif lualib:GetDBStr("三清3") == "" then
            if lualib:GetDBStr("三清1") ~= lualib:Name(player) and lualib:GetDBStr("三清2") ~= lualib:Name(player) then
                lualib:SetDBStrEx("三清3", lualib:Name(player), 1)
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
        if lualib:HasBuff(player,"武评榜单"..mc) then
        else
            lualib:AddBuff(player, "武评榜单"..mc, 0)
        end
    elseif glamour >= 100000 then
        if lualib:HasBuff(player,"武评榜单10") then
        else
            lualib:AddBuff(player, "武评榜单10", 0)
        end
    else
        for i = 1 , 10 do
            if lualib:HasBuff(player,"武评榜单"..i) then
                lualib:DelBuff(player, "武评榜单"..i)
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
        if lualib:HasBuff(player,"无敌挂机") then
            lualib:DelBuff(player, "无敌挂机")
        end
    end
    if item_map_name == "北凉城" then
        if lualib:HasBuff(player,"自动挂机") then
            lualib:DelBuff(player, "自动挂机")
        end
    end
    if lualib:HasBuff(player,"无敌挂机") then
        lualib:SetInt(player,"wudiguaji", lualib:GetInt(player,"wudiguaji") - 1)
    end
end

local zhansha_tb = {
    {"[1阶]小乔","斩杀[lv1]：怪物血量低于1%时，直接秒杀怪物","斩杀[lv2]：怪物血量低于2%时，直接秒杀怪物","斩杀[lv2]：美人升级进阶《[2阶]虞姬》时激活"},
    {"[2阶]虞姬","斩杀[lv2]：怪物血量低于2%时，直接秒杀怪物","斩杀[lv3]：怪物血量低于3%时，直接秒杀怪物","斩杀[lv3]：美人升级进阶《[3阶]骊姬》时激活"},
    {"[3阶]骊姬","斩杀[lv3]：怪物血量低于3%时，直接秒杀怪物","斩杀[lv4]：怪物血量低于4%时，直接秒杀怪物","斩杀[lv4]：美人升级进阶《[4阶]褒姒》时激活"},
    {"[4阶]褒姒","斩杀[lv4]：怪物血量低于4%时，直接秒杀怪物","斩杀[lv5]：怪物血量低于6%时，直接秒杀怪物","斩杀[lv5]：美人升级进阶《[5阶]甄宓》时激活"},
    {"[5阶]甄宓","斩杀[lv5]：怪物血量低于6%时，直接秒杀怪物","斩杀[lv6]：怪物血量低于8%时，直接秒杀怪物","斩杀[lv6]：美人升级进阶《[6阶]大乔》时激活"},
    {"[6阶]大乔","斩杀[lv6]：怪物血量低于8%时，直接秒杀怪物","斩杀[lv7]：怪物血量低于10%时，直接秒杀怪物","斩杀[lv7]：美人升级进阶《[7阶]苏小小》时激活"},
    {"[7阶]苏小小","斩杀[lv7]：怪物血量低于10%时，直接秒杀怪物","斩杀[lv8]：怪物血量低于12%时，直接秒杀怪物","斩杀[lv8]：美人升级进阶《[8阶]柳如是》时激活"},
    {"[8阶]柳如是","斩杀[lv8]：怪物血量低于12%时，直接秒杀怪物","斩杀[lv9]：怪物血量低于14%时，直接秒杀怪物","斩杀[lv9]：美人升级进阶《[9阶]冯小怜》时激活"},
    {"[9阶]冯小怜","斩杀[lv9]：怪物血量低于14%时，直接秒杀怪物","斩杀[lv10]：怪物血量低于16%时，直接秒杀怪物","斩杀[lv10]：美人升级进阶《[10阶]嫦娥》时激活"},
    {"[10阶]嫦娥","斩杀[lv10]：怪物血量低于16%时，直接秒杀怪物","已达上限","已达上限"},
}

local skill_cd = {
    300,290,280,270,260,250,240,230,220,200
}


function on_player_login(player)
    if not lualib:HasTimer(player,7787) then
        lualib:AddTimer(player,7787,1000,-1,"mnCoolDown")
    end
    if lualib:GetInt(player,"召唤美女") == 1 then
        lualib:SetInt(player,"召唤美女",0)
    end
    local mv_level = lualib:GetInt(player,"mvlevel")
    local str = " zhansha_tb = "..serialize(zhansha_tb).."; mv_level = "..serialize(mv_level).."; skill_cd = "..serialize(skill_cd)
    lualib:ShowFormWithContent(player, "脚本表单", str)
    lualib:ShowFormWithContent(player, "脚本表单", [[GameMainBar.zhansha()]])
    lualib:ShowFormWithContent(player, "脚本表单", [[GameMainBar.heji()]])
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player, "脚本表单", [[DownLoadWnd.zhansha()]])
    end
    lualib:ShowFormWithContent(player, "form文件表单", "TaskWindow2")
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "dingshi")
    end

    lualib:ShowFormWithContent(player, "form文件表单", "服务器时间表单#"..lualib:GetAllTime());
    for i = 10, 11 do
        local item = lualib:Player_GetItemGuid(player, i)
        if item ~= "" then
            on_post_equip(player, item)
        end
    end
    lualib:DelayCall(player, 1, "登陆脚本:main", "");
    lualib:DelayCall(player, 1, "魔气血石:on_login", "");
    active_player(player, 2, 0)	--登录时向网站发送角色最新信息，不要删除否则影响统计功能
    --lualib:DelayCall(player, 2000, "client_ver", "");	--检测客户端版本

    --攻城战死亡上线
    local die_flag = lualib:GetInt(player, "die_flag")
    if lualib:IsCastleWarStart("神歌城") and die_flag == 1 then
        local own_family = lualib:GetCastleOwnFamily("神歌城")
        local my_family = lualib:GetFamilyName(player)

        if own_family ~= "" and own_family == my_family then
            lualib:Player_MapMoveXY(player, "龙城", 532, 243, 5)
            lualib:SetInt(player, "die_flag", 0)
        end
    end

    --GM登陆
    if lualib:Player_IsGM(player) then
        lualib:Player_SetGhost(player, true)
        lualib:SysTriggerMsg(player, "你已进入隐身状态！")
        lualib:Player_SetInvincible(player, true)
        lualib:SysTriggerMsg(player, "你已进入无敌状态！")
        lualib:AddBuff(player, "疾驰", 60*60*24)
        lualib:SysTriggerMsg(player, "你已进入疾驰状态！")
    end

    --右上角图标显示
    --online_gift_login(player)	--在线礼包
    guaji_xianshi(player)		--自动打怪
    --check_first_bill(player)	--首充与充值礼包
    weixin_xianshi(player) --微信礼包
    lualib:DelayCall(player, 1, "QQ群礼包:show", "");
    lualib:DelayCall(player, 1, "百万福利:show", "");
    lualib:DelayCall(player, 1, "游戏攻略:show", "");
    ling_xianshi(player)   --灵丹妙药
    maijian_xianshi(player)   --埋剑山庄
    richong_xianshi(player)	--日充
    shouyou_xianshi(player) --手游下载

    local spouse = lualib:GetStr(player, "配偶GUID")
    if spouse ~= "" then
        local caller = (lualib:Gender(player) == 1) and "丈夫" or "妻子"
        lualib:SysPromptMsg(spouse, "你的"..caller.."上线了。")
    end
end

function client_ver(player)
    lualib:RequestClientVer(player);
    lualib:DelayCall(player, lualib:GenRandom(2, 5) * 1000, "client_ver_ex", "");
end

function client_ver_ex(player)
    local ver = lualib:GetClientVerEx(player);

    if (ver < 3003) or (ver <  lualib:GetGSClientVer()) then
        lualib:SysTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysTriggerMsg(player, "客户端太老请关闭所有游戏窗口不要双开，重新打开登录器更新！")
        lualib:SysTriggerMsg(player, "如果不更新请点击登录器上资源修复完整修复后才可以正常游戏！")
        lualib:SysTriggerMsg(player, "如果不更新请点击登录器上资源修复完整修复后才可以正常游戏！")
        lualib:DelayCall(player, 3000, "kick_player", "");
    end
end

function kick_player(player)
    lualib:Player_Kick(player)
end

function on_pre_logout(player, type)
    lualib:DelayCall(player, 1, "master:process_master_apprentice_logout", ""); --师徒退出处理
    lualib:DelayCall(player, 1, "online_gift:online_gift_logout", ""); --在线礼包退出
    if lualib:GetInt(player,"召唤美女") == 1 then
        lualib:SetInt(player,"召唤美女",0)
    end
    if lualib:HasBuff(player,"摆摊") then
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
    local mapguid = lualib:Map_GetMapGuid("龙城")
    local players = lualib:Map_GetRegionPlayersEx(mapguid, ranges, true)
    local item_map_guid = lualib:MapGuid(player)
    local item_map_name = lualib:Name(item_map_guid)
    if item_map_name ~= "新手接待室" then
        local sjx = lualib:GenRandom(1, 19)
        local sjy = lualib:GenRandom(1, 19)
        lualib:Player_MapMoveXY(player,"龙城", 244 + sjx , 259 + sjy , 1)
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
    lualib:DelayCall(player, 1, "经验脚本:main", tostring(expv));
end

function on_level_up(player, level)
    active_player(player, 3, 0)	--升级时向网站发送角色最新信息，不要删除否则影响统计功能
    lualib:DelayCall(player, 1, "master:process_apprentice_level_up", tostring(level))  --调用徒弟升级触发
end

--------[[玩家第一次进入游戏]]
function on_first_in_game(player)
    lualib:SetInt(player,"mvlevel",1)
    lualib:SetInt(player,"秒杀几率",1)
    lualib:SetInt(player,"合击冷却",300)
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "dingshi")
    end
    --lualib:AddIngot(player, 150000, "添加元宝:原因", "发起者")

    lualib:AddBuff(player, "新手护佑", 3600);


    local Gender = lualib:Gender(player)
    local award_item = {"布衣(男)", "布衣(女)"}
    if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
        lualib:SysTriggerMsg(player, "赠送布衣失败！")
    end
    --local first_skill = {"基本剑术4级", "攻杀剑术4级", "刺杀剑术4级", "半月弯刀4级", "野蛮冲撞4级", "烈火剑法4级", "开天斩4级", "逐日剑法4级"}
    --local first_skill = {"基本剑术4级", "攻杀剑术4级", "刺杀剑术4级", "野蛮冲撞4级", "烈火剑法4级", "开天斩4级", "逐日剑法4级"}
    local first_skill = {"基本剑术4级", "攻杀剑术4级", "刺杀剑术4级", "野蛮冲撞4级", "烈火剑法4级"}
    for i = 1, #first_skill do
        lualib:AddSkill(player, first_skill[i])
    end
    local item_k = {"武器1", "头盔1", "衣服1", "手镯1","戒指1","鞋子1","腰带1", "项链1", "北凉城传送石", "随机传送石"}
    local item_n = {1, 1, 1, 2, 2, 1, 1, 1, 1, 1}
    local item_b = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
    local item_o = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    if not lualib:Player_ItemRequest(player, item_k, item_n, item_b, item_o, "给物品：第一次进游戏", "") then
        lualib:SysTriggerMsg(player, "新手物品赠送失败！")
    end
    for i = 1, #item_k do
        lualib:ApplyEquipEx(player, item_k[i])
    end


    local player_name = lualib:Name(player)
    lualib:SysMsg_SendBroadcastMsg("江湖新人【"..player_name.."】加入了久玩神途,整个江湖庙堂将会因为他的到来掀起一阵腥风血雨", "[系统提示]")
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

    local result_find1, result_find2 = string.find(result,"%d|%d|%d|%d|%d")

    if result_find1 ~= nil and result_find2 ~= nil then
        local s = string.sub(result, result_find1, result_find2)
        local t = string.split(s, "|")
        local s1 = {"密码过于简单", "密保信息未设置", "身份信息未认证", "安全手机未认证", "安全邮箱未认证"}

        local tip = [[                                    #COLORCOLOR_GREENG#账 号 安 全#COLOREND#
				     尊敬的玩家，您的账号存在安全隐患，为了您的游戏财产安全，请补充资料]]
        local tip2 = [[
				        ]]
        local req = false

        for i = 1, #t do
            if t[i] == "1" then
                req = true
            end
        end

        if req then
            --lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#╔──────═──────═──────═──────═──────╗#COLOREND#", 7, 11)
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
            --lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#╚──────═──────═──────═──────═──────╝#COLOREND#", 7, 11)

            --lualib:SysMsg_SendBoardMsg(player, "补充安全资料",  "\n#COLORCOLOR_GREENG##UILINK<WND:提交表单,PARAM:小贴士;web;player,STR:请点我进入网站补充账号安全资料##COLOREND#", 10000)
        end
    end
end

function on_hack_check(player, a, b)
    if b > 10 then
        lualib:SysWarnMsg(player, "请不要使用外挂,你已经被系统记录，情节严重者直接封号！");
        lualib:Error(lualib:Name(player) .. "可能使用挂机外挂");
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
        --发送答题验证(详见"神途验证码功能"),或直接踢下线
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
            if name == "复活戒指" then
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
        --lualib:SysMsg_SendWarnMsg(self, "时间差："..self_Hp)
        local set_hp = self_Hp
        lualib:SetHp(self, set_hp, false)

        lualib:SetInt(self, "revive_times", times)
        lualib:SysMsg_SendWarnMsg(self, "天藏浩荡，神品【复活戒指】替你挡下破灭一劫！")

        lualib:DelayCall(self,800, "on_player_pre_dietx", "");

        --lualib:SysMsg_SendWarnMsg(self, "因为你！")
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
    ["复活1"] 	={	1.00 	,   180},
    ["复活2"]	={	1.00 	,   170},
    ["复活3"]	={	1.00 	,   160},
    ["复活4"]	={	1.00 	,   150},
    ["复活5"]	={	1.00	,   140},
    ["复活6"]	={	1.00	,   130},
    ["复活7"]	={	1.00	,   120},
    ["复活8"]	={	1.00	,   110},
    ["复活9"]	={	1.00	,   100},
    ["复活10"]	={	1.00	,   80},
}

function on_post_equip(player, item, id, KeyName)
    if GEM_KEYNAME[KeyName] then
        local second = GEM_KEYNAME[KeyName][2];
        lualib:AddBuff(player, "长生石复活", second);
        lualib:ShowFormWithContent(player, "脚本表单", "PlayerHeaderInfo:ReliveCD("..second..")");
    end

    local itemName = lualib:KeyName(item)
    if itemName == "麻痹戒指" then
        lualib:AddTrigger(player, lua_trigger_damage_process, "damage_process")
    elseif itemName == "隐身戒指" then
        lualib:AddBuff(player, "隐身戒指", 20000000)
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


    if lualib:HasBuff(player, "长生石复活") then
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
            lualib:SysMsg_SendPromptMsg(killer, "你破除了对方的复活能力！！");
            lualib:SysMsg_SendPromptMsg(player, "你的复活能力被对方佩戴的衣服武器套破除了！！");
            return true
        end
    end
    local max_hp = lualib:Hp(player, true);
    local hp = max_hp * GEM_KEYNAME[gem_KeyName][1];
    lualib:SetHp(player, hp, false)     --设置当前HP
    local second = GEM_KEYNAME[gem_KeyName][2];
    lualib:AddBuff(player, "长生石复活", second);
    lualib:SysCenterMsg(0, ""..lualib:Name(gem).."长生之力,原地复活！！", player);
    lualib:SysMsg_SendPromptMsg(player, "#COLORCOLOR_GREENG#触发#COLORCOLOR_YELLOW#"..lualib:Name(gem).."#COLORCOLOR_GREENG#长生之力,#COLORCOLOR_MAGENTA#原地复活！！");
    lualib:ShowFormWithContent(player, "脚本表单", "PlayerHeaderInfo:ReliveCD("..second..")");
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
    --判断戒指位置是否有麻痹，有走麻痹流程，没有则删除触发器
    if ringName1 == "麻痹戒指" or ringName2 == "麻痹戒指" then
        --增加麻痹buff几率计算
        if is_skill_t[skill_id] == 1 then
            if math.random(1, 100) > 70 then
                lualib:AddBuff(target, "怪物麻痹3秒", 0)
            end
        end
    else
        lualib:RemoveTrigger(self, lua_trigger_damage_process, "")
    end

    return true
end

function on_trigger_billin(player, yb)
    local name = lualib:Name(player)
    lualib:SysWarnMsg(player, "你充值了"..yb.."元宝")
    lualib:SysMsg_SendBroadcastMsg("恭喜"..name.."在线充值获得" .. yb ..  "元宝，如果你也想要请点击屏幕右下角商铺进行充值","[充值提示]")
end



local shuztys = {
    ["麻痹10"] = 500000008,
    ["复活10"] = 500000008,
    ["卜算子15"] = 500000008,
    ["长生莲15"] = 500000008,
    ["传国玺15"] = 500000008,
    ["太平令15"] = 500000008,
    ["王妃8"] = 500000008,
    ["玉皇10"] = 500000008,
    ["菩提10"] = 500000008,
    ["盾牌10"] = 500000008,
    ["飞剑橙1"] = 500000008,
    ["飞剑橙2"] = 500000008,
    ["飞剑橙3"] = 500000008,
    ["飞剑橙4"] = 500000008,
    ["飞剑橙5"] = 500000008,
    ["飞剑橙6"] = 500000008,
    ["飞剑橙7"] = 500000008,
    ["飞剑橙8"] = 500000008,
    ["飞剑橙9"] = 500000008,
    ["飞剑橙10"] = 500000008,
    ["飞剑橙11"] = 500000008,
    ["飞剑橙12"] = 500000008,
    ["十步一杀"] = 500000007,
    ["魔法盾"] = 500000008,


    ["1000钻石"] = 500000009,
    ["2000钻石"] = 500000009,
    ["5000钻石"] = 500000009,
    ["10000钻石"] = 500000009,
    ["20000钻石"] = 500000009,
    ["50000钻石"] = 500000010,
    ["100000钻石"] = 500000010,
    ["200000钻石"] = 500000010,
    ["500000钻石"] = 500000010,
    ["880000钻石"] = 500000010,
    ["1080000钻石"] = 500000010,
    ["1180000钻石"] = 500000010,
    ["1280000钻石"] = 500000010,
    ["1380000钻石"] = 500000010,
    ["剑开天门卷轴"] = 500000006,
    ["麻痹5"] = 500000009,
    ["麻痹6"] = 500000009,
    ["麻痹7"] = 500000009,
    ["复活5"] = 500000009,
    ["复活6"] = 500000009,
    ["复活7"] = 500000009,
    ["卜算子6"] = 500000009,
    ["长生莲6"] = 500000009,
    ["传国玺6"] = 500000009,
    ["太平令6"] = 500000009,
    ["卜算子7"] = 500000009,
    ["长生莲7"] = 500000009,
    ["传国玺7"] = 500000009,
    ["太平令7"] = 500000009,
    ["卜算子8"] = 500000009,
    ["长生莲8"] = 500000009,
    ["传国玺8"] = 500000009,
    ["太平令8"] = 500000009,
    ["卜算子9"] = 500000009,
    ["长生莲9"] = 500000009,
    ["传国玺9"] = 500000009,
    ["太平令9"] = 500000009,
    ["卜算子10"] = 500000009,
    ["长生莲10"] = 500000009,
    ["传国玺10"] = 500000009,
    ["太平令10"] = 500000009,
    ["绿蚁酒"] = 500000010,
    ["紫金莲"] = 500000010,
    ["六年凤"] = 500000010,
    ["月井天镜"] = 500000010,
    ["王妃1"] = 500000009,
    ["王妃2"] = 500000009,
    ["王妃3"] = 500000009,
    ["王妃4"] = 500000009,
    ["玉皇1"] = 500000009,
    ["玉皇2"] = 500000009,
    ["玉皇3"] = 500000009,
    ["玉皇4"] = 500000009,
    ["玉皇5"] = 500000009,
    ["菩提1"] = 500000009,
    ["菩提2"] = 500000009,
    ["菩提3"] = 500000009,
    ["菩提4"] = 500000009,
    ["菩提5"] = 500000009,
    ["盾牌1"] = 500000009,
    ["盾牌2"] = 500000009,
    ["盾牌3"] = 500000009,
    ["盾牌4"] = 500000009,
    ["盾牌5"] = 500000009,
    ["飞剑青1"] = 500000009,
    ["飞剑青2"] = 500000009,
    ["飞剑青3"] = 500000009,
    ["飞剑青4"] = 500000009,
    ["飞剑青5"] = 500000009,
    ["飞剑青6"] = 500000009,
    ["飞剑青7"] = 500000009,
    ["飞剑青8"] = 500000009,
    ["飞剑青9"] = 500000009,
    ["飞剑青10"] = 500000009,
    ["飞剑青11"] = 500000009,
    ["飞剑青12"] = 500000009,
    ["飞剑蓝1"] = 500000009,
    ["飞剑蓝2"] = 500000009,
    ["飞剑蓝3"] = 500000009,
    ["飞剑蓝4"] = 500000009,
    ["飞剑蓝5"] = 500000009,
    ["飞剑蓝6"] = 500000009,
    ["飞剑蓝7"] = 500000009,
    ["飞剑蓝8"] = 500000009,
    ["飞剑蓝9"] = 500000009,
    ["飞剑蓝10"] = 500000009,
    ["飞剑蓝11"] = 500000009,
    ["飞剑蓝12"] = 500000009,


    ["飞剑紫1"] = 500000010,
    ["飞剑紫2"] = 500000010,
    ["飞剑紫3"] = 500000010,
    ["飞剑紫4"] = 500000010,
    ["飞剑紫5"] = 500000010,
    ["飞剑紫6"] = 500000010,
    ["飞剑紫7"] = 500000010,
    ["飞剑紫8"] = 500000010,
    ["飞剑紫9"] = 500000010,
    ["飞剑紫10"] = 500000010,
    ["飞剑紫11"] = 500000010,
    ["飞剑紫12"] = 500000010,
    ["王妃5"] = 500000010,
    ["王妃6"] = 500000010,
    ["王妃7"] = 500000010,
    ["玉皇6"] = 500000010,
    ["玉皇7"] = 500000010,
    ["玉皇8"] = 500000010,
    ["玉皇9"] = 500000010,
    ["菩提6"] = 500000010,
    ["菩提7"] = 500000010,
    ["菩提8"] = 500000010,
    ["菩提9"] = 500000010,
    ["盾牌6"] = 500000010,
    ["盾牌7"] = 500000010,
    ["盾牌8"] = 500000010,
    ["盾牌9"] = 500000010,
    ["入神面皮"] = 500000010,
    ["大凉龙雀"] = 500000010,
    ["荒诞不经年"] = 500000010,
    ["陆地朝仙图"] = 500000010,
    ["雪中悍刀行"] = 500000010,
    ["山河社稷"] = 500000010,
    ["麻痹8"] = 500000010,
    ["麻痹9"] = 500000010,
    ["复活8"] = 500000010,
    ["复活9"] = 500000010,
    ["卜算子11"] = 500000010,
    ["长生莲11"] = 500000010,
    ["传国玺11"] = 500000010,
    ["太平令11"] = 500000010,
    ["卜算子12"] = 500000010,
    ["长生莲12"] = 500000010,
    ["传国玺12"] = 500000010,
    ["太平令12"] = 500000010,
    ["卜算子13"] = 500000010,
    ["长生莲13"] = 500000010,
    ["传国玺13"] = 500000010,
    ["太平令13"] = 500000010,
    ["卜算子14"] = 500000010,
    ["长生莲14"] = 500000010,
    ["传国玺14"] = 500000010,
    ["太平令14"] = 500000010,
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
    ["怒海狂涛1"]=5,
    ["枯木逢春1"]=10,
    ["巨石火轮1"]=15,
    ["碧海潮生1"]=20,
    ["万剑朝宗1"]=25,
    ["怒海狂涛2"]=30,
    ["枯木逢春2"]=35,
    ["巨石火轮2"]=40,
    ["碧海潮生2"]=45,
    ["万剑朝宗2"]=50,

}
function on_pre_harm(role,attacker,hp,defense,skillkeyname,isBurst)
    local roletype = lualib:GUIDType(role)
    local attackertype = lualib:GUIDType(attacker)
    --lualib:SysMsg_SendBroadcastMsg(tostring(skillkeyname), "sk")

    if skillhj[skillkeyname] ~= nil and attackertype==0 then
        local phyatk_low = lualib:PhyAtk(attacker, false)    --取下限
        local phyatk_hei = lualib:PhyAtk(attacker, true)    --取上限
        local PhyDef_low = lualib:PhyDef(role, false)    --取下限
        local PhyDef_hei = lualib:PhyDef(role, true)    --取上限
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
        local Girlslevel = lualib:GetInt(attacker,"秒杀几率")
        if Girlslevel == 0 then
            hp=hp
        else
            local miaosha = lualib:GetInt(attacker,"秒杀几率")
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
    local num = lualib:GetInt(player,"合击时间")-1
    local nums = (lualib:GetInt(player,"合击冷却") - num) / lualib:GetInt(player,"合击冷却")
    if nums >= 1 then
        lualib:ShowFormWithContent(player, "脚本表单", [[GameMainBar.coolDown(1)]])
        lualib:SetInt(player,"合击时间",0)
    else
        lualib:ShowFormWithContent(player, "脚本表单", [[GameMainBar.coolDown(]]..nums..[[)]])
        lualib:SetInt(player,"合击时间",num)
    end
end

function on_spell(player, skill_id, skill_name,x,y,target,skillkeyname)
    if lualib:GetInt(player,"合击时间") <= 0 then
        --lualib:SysMsg_SendBroadcastMsg(tostring("释放技能"), "牛")
        lualib:SetInt(player,"合击时间",lualib:GetInt(player,"合击冷却"))
    end
end