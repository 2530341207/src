local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("include/攻城战玩法")
require("system/自动打怪")
require("system/online_gift")
require("system/充值礼包")
require("form/新充值礼包表单")
require("form/日充礼包表单")
require("system/首冲礼包")
require("system/游戏攻略")
require("system/微信礼包")
require("system/手游下载")
require("system/探宝")
require("item/发送消息")
require("system/悬赏任务")
require("system/首杀奖励")
require("system/杀神膜拜")
require("system/活动大全")
require("include/消息提示")
require("form/转盘系统")
require("include/Harry排行")
require("system/世界BOSS图标")


function on_system_start()
    if lualib:GetDBNum("hequshachu") == 0 then
        lualib:SetDBNumEx("hequshachu", 1, 6)
        ---捐赠
        local curTime = lualib:GetAllTime()
        lualib:SetDBNumEx("juanzlb", curTime, 6)
        --lualib:SetDBStr("ybjx_ranking_t", "")

        local curTime = lualib:GetAllTime()
        lualib:SetDBNumEx("meilib", curTime, 6)
        lualib:SetDBStr("meigui_ranking_t", "")

        local curTime = lualib:GetAllTime()
        lualib:SetDBNumEx("jisha", curTime, 6)
    end

    if not lualib:HasTimer("0", 20170711) then
        lualib:AddTimer("0", 20170711, 1000, -1, "转盘系统:Lfte_cz")
    end
    lualib:AddTimer("0", 20201, 1000, -1, "flush_phb")
    if lualib:IO_GetCustomVarInt("fuwuqishushihua_xinde1") == 0 then
        lualib:IO_SetCustomVarInt("fuwuqishushihua_xinde1",1)
        --冲级比赛相关数据初始化
        lualib:SetDBNumEx("xy_jiangchi", 15000, 4)
        lualib:SetDBNumEx("chongji_jiangli_1", 200,  2)
        lualib:SetDBNumEx("chongji_jiangli_2", 150,  2)
        lualib:SetDBNumEx("chongji_jiangli_3", 100,  2)
        lualib:SetDBNumEx("chongji_jiangli_4", 50,  2)
        lualib:SetDBNumEx("chongji_jiangli_5", 50,  2)
        lualib:SetDBNumEx("chongji_jiangli_6", 50,  2)
        lualib:SetDBNumEx("chongji_jiangli_7", 30,  2)
        lualib:SetDBNumEx("chongji_jiangli_8", 10,  2)
        lualib:SetDBNumEx("chongji_jiangli_9", 10,  2)
        lualib:SetDBNumEx("chongji_jiangli_10", 5, 2)
        lualib:SetDBNumEx("chongji_jiangli_11", 5, 2)
        lualib:SetDBNumEx("chongji_jiangli_12", 5, 2)
        lualib:SetDBNumEx("chongji_jiangli_13", 3, 2)
        lualib:SetDBNumEx("chongji_jiangli_14", 2,  2)
        lualib:SetDBNumEx("chongji_jiangli_15", 2,  2)
    end


    lualib:AddTrigger("", lua_trigger_login, "on_player_login");
    lualib:AddTrigger("", lua_trigger_add_exp, "on_player_add_exp");		--经验增加时
    lualib:AddTrigger("", lua_trigger_pre_logout, "on_pre_logout");
    lualib:DelayCall("", 1, "OnFirstCastleWar", "");		--第一次攻城战
    --lualib:AddTrigger("0",  lua_trigger_billin, "on_trigger_billin")--充值回调
    lualib:AddTrigger("0",  lua_trigger_billin_ex, "on_billinex")   --充值回调
    lualib:AddTrigger("0",  lua_trigger_first_in_game, "on_first_in_game")
    lualib:AddTrigger("0",  lua_trigger_level_up, "on_level_up")				--升级触发
    lualib:AddTrigger("0",  lua_trigger_gp, "on_gp")				--反外挂触发
    lualib:AddTrigger("0",  363, "on_ride_request")  --上马触发
    lualib:AddTrigger("0",  364, "on_unride_request")  --下马触发
    lualib:AddTrigger("0", 302, "on_post_equip") --穿戴触发
    lualib:AddTrigger("0", 301, "on_pre_equip") --穿戴触发
    lualib:AddTrigger("0",  lua_trigger_player_relive, "on_player_relive") --复活前回调
    lualib:AddTrigger("0",  lua_trigger_post_die, "on_post_die") --死亡时回调
    lualib:AddTrigger("0", lua_trigger_hack_check, "on_hack_check");
    lualib:AddTrigger("0", lua_trigger_hack_check2, "on_hack_check2");
    lualib:AddTrigger("0",  356, "on_player_pre_die")  --死前触发
    lualib:AddTrigger("0", lua_trigger_post_drop_one, "on_post_drop_one");
    lualib:AddTrigger("0",  lua_trigger_castle_war_start, "on_castle_war_start") --攻城开始
    lualib:AddTrigger("0",  lua_trigger_castle_war_end, "on_castle_war_end") --攻城结束
    lualib:AddTrigger("0",  lua_trigger_kill, "on_trigger_kill")	--死亡触发XXX
    lualib:AddTrigger("0",  lua_trigger_player_change_name, "on_change_name_result")
    lualib:AddTrigger("0",  lua_trigger_pre_stall_buy, "on_pre_stall_buy") 		--摆摊购买物品触发
    lualib:AddTrigger("0", lua_trigger_family_ntf, "on_family_ntf") --行会的创建和销毁触发
    lualib:AddTrigger("0", lua_trigger_family_member_ntf, "on_family_member_ntf") --行会人员变动
    lualib:AddTrigger("0",  lua_trigger_servant_betry , "on_servant_betry")
    lualib:AddTrigger("0",  lua_trigger_mining , "on_mining")
    lualib:AddTrigger("0", lua_trigger_pre_spell, "on_pre_spell"); --使用技能前
    lualib:AddTrigger("0", lua_trigger_spell, "on_spell"); --使用技能时
    lualib:AddTrigger("0",  lua_trigger_summon, "on_summon")
    lualib:AddTrigger("0",  lua_trigger_monster_post_die, "pre_monster_die")
    lualib:AddTrigger("0", lua_trigger_pre_catch, "on_pre_catch")
    lualib:AddTrigger("0", lua_trigger_pre_mall, "on_pre_mall")
    lualib:AddTrigger("0",  lua_trigger_monster_post_die, "on_post_monster_die")  --死前触发
    lualib:AddTrigger("0",	lua_trigger_role_pre_harm, "on_pre_harm")    --被攻击者受到伤害即将损血前回调
    --313	lua_trigger_item_pickup	拾取物品之后回调
    lualib:AddTrigger("0", 313,"on_item_pickup")

    lualib:SetStr("0","shashen_mingzi",lualib:IO_GetCustomVarStr("shashen_mingzi"))		--杀神名字
    lualib:SetInt("0","shashen_shalu",lualib:IO_GetCustomVarInt("shashen_shalu"))		--杀神杀戮值
    lualib:SetInt("0","shashen_rongyao",lualib:IO_GetCustomVarInt("shashen_rongyao"))	--杀神存放荣耀
    lualib:SetInt("0","shashen_job",lualib:IO_GetCustomVarInt("shashen_job"))			--杀神职业
    lualib:SetInt("0","shashen_xing",lualib:IO_GetCustomVarInt("shashen_xing"))			--杀神性别
    local shashentime = lualib:GenTimerId("0")
    lualib:AddTimer("", shashentime, 1000 * 60 * 10, -1, "quanjumeifenchufa") --全局每10分钟检测杀神杀戮值
    lualib:AddTrigger("0", lua_trigger_pre_drop_one , "on_pre_drop_one"); --爆出东西时投保
    lualib:AddTrigger("0", lua_trigger_captcha_result , "on_captcha_result"); --验证结果回调
    lualib:AddTrigger("0", lua_trigger_add_buff , "on_add_buff"); --增加buff时
    lualib:AddTrigger("0", lua_trigger_monster_born , "on_monster_born"); --怪物出生时回调
    lualib:AddTrigger("0", lua_trigger_player_post_die	 , "on_post_player_die"); --玩家死亡之后
    lualib:AddTrigger("0", lua_trigger_add_exp,"on_add_exp")  --杀怪得到经验时回调
    lualib:AddTrigger("0",  lua_trigger_pre_level_up, "on_pre_level_up")		--升级前触发

    local shashentime = lualib:GenTimerId("0")
    lualib:AddTimer("", shashentime, 1000 * 60 * 60 * 2, -1, "shuamij") --全局每120分钟刷秘境
    if lualib:GetDBNum("合区") == 0 then
        lualib:SetDBNumEx("合区",1,4)
    end

end


function on_pre_mall(player, item, num, price, bind)


    if item == "首充礼包" then
        if lualib:GetInt(player, "sclba") == 1 then
            lualib:MsgBox(player,"此礼包只能购买1次，无法购买")
            return false;
        elseif num>1 then
            lualib:MsgBox(player,"此礼包只能购买1个")
            return false;
        else
            lualib:SetInt(player, "sclba", 1)
        end
    end
    return true;
end









---------------------------全局每10分钟检测杀神杀戮值----------------------------------
function shuamij()

    local item_map_guid = lualib:Map_GetMapGuid("龙城")

    local npc = lualib:Map_GenNpc(item_map_guid, "秘境",  279, 276, 0, 4)
    local dgn = lualib:Map_CreateDgn("秘境", true, 2400)
    lualib:SetStr(npc, "dgn", dgn)
    lualib:Map_GenNpc(dgn, "返回",  44, 45, 0, 4)
    lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#秘境:#COLORCOLOR_WHITE#在[龙城地图的266,276]处打开秘境通道!#COLORCOLOR_PURPLE#通道入口只存在5分钟!", "", 1, 12);
end





function on_pre_drop_one(map, player, item, item_id)
    local x = lualib:X(player) + 1
    local y = lualib:Y(player) + 1
    local mapguid = lualib:MapGuid(player)

    if lualib:Monster_IsMonster(player) then
        local mkey = lualib:KeyName(player)
        if mkey == "新触龙神" or mkey == "秘境怪物1" or mkey == "秘境怪物2" or mkey == "秘境怪物3" or mkey == "秘境怪物4" or mkey == "秘境怪物5" then
            local guid = lualib:Map_GenItemRnd(map,lualib:X(player)+lualib:GenRandom(-4, 4),lualib:Y(player)+lualib:GenRandom(-4, 4),1,lualib:KeyName(item),1,false,120)
            return false
        end
    end

    return true
end




---------------------------全局每10分钟检测杀神杀戮值----------------------------------
function quanjumeifenchufa()

    --每日初始化
    if lualib:GetAllDays(0) - lualib:IO_GetCustomVarInt("meirichushihua") >= 1 then --记录开启计时的当前天数
        lualib:IO_SetCustomVarInt("meirichushihua",lualib:GetAllDays(0))
        lualib:SetInt("0","shashen_shalu",0) --杀神杀戮值临时变量清零
        lualib:IO_SetCustomVarInt("shashen_shalu",0) --杀神杀戮值IO变量清零
    end
end



function on_pre_catch(player, target, skill_id)
    local servant_t = lualib:Player_GetServantList(player)
    if #servant_t >= 5 then
        return false
    end
    return true
end


function pre_monster_die(actor, killer)
    local sjsz = lualib:GenRandom(1, 1000)
    local map_guid = lualib:MapGuid(actor)
    local map_name = lualib:KeyName(map_guid)
    local digsz = {
        ["龙城"] = 1,
        ["巫山城"] = 1,
        ["祖玛寺庙一层"] = 1,
        ["祖玛寺庙二层"] = 1,
        ["祖玛寺庙三层"] = 1,
        ["祖玛寺庙四层"] = 1,
        ["祖玛寺庙五层"] = 1,
        ["祖玛之家"] = 1,
        ["废弃矿洞1"] = 1,
        ["废弃矿洞2"] = 1,
        ["废弃矿洞3"] = 1,
        ["猪洞1"] = 1,
        ["猪洞2"] = 1,
        ["猪洞3"] = 1,
        ["魔王禁地1层"] = 1,
        ["魔王禁地2层"] = 1,
        ["魔王禁地"] = 1,
        ["蛮荒废墟1层"] = 1,
        ["蛮荒废墟2层"] = 1,
        ["蛮荒废墟3层"] = 1,
        ["蛮荒废墟"] = 1,
        ["训练场"] = 1,

    }

    if digsz[map_name] == nil then

        if lualib:Monster_IsMonster(actor) then
            local name = lualib:Monster_GetMaster(actor)
            if name == "" then
                if killer ~= "" then
                    if sjsz <= 10 then  --几率1%召唤秘境
                        --[[
                          local item_map_guid = lualib:MapGuid(actor)
                          local item_map_name = lualib:Name(item_map_guid)
                          local item_map_x = lualib:X(actor)
                          local item_map_y = lualib:Y(actor)
                          local ranges = {0, item_map_x, item_map_y, 10, 10}
                          local grids = lualib:GetRegionFreeRndEx(item_map_guid, ranges, 1)
                          if #grids ~= 0 then
                             for _, v in ipairs(grids) do
                                local x = v.X
                                local y = v.Y
                                local npc = lualib:Map_GenNpc(item_map_guid, "秘境",  x, y, 0, 4)
                                local dgn = lualib:Map_CreateDgn("秘境", true, 3600)
                                lualib:SetStr(dgn, "dt_mc", item_map_name)
                                lualib:SetInt(dgn, "dt_x", item_map_x)
                                lualib:SetInt(dgn, "dt_y", item_map_y)
                                lualib:SetStr(npc, "dgn", dgn)
                                lualib:Map_GenNpc(dgn, "返回",  44, 45, 0, 4)
                                lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#秘境:玩家#COLORCOLOR_WHITE#["..lualib:Name(killer).."]在["..item_map_name.."地图的"..x..","..y.."]处打开秘境通道!#COLORCOLOR_PURPLE#通道入口只存在5分钟!", "", 1, 12);
                             end
                          end
                        --]]
                    elseif sjsz <= 10 then  --几率2%召唤奇遇宝箱
                        local item_map_guid = lualib:MapGuid(actor)
                        local item_map_name = lualib:Name(item_map_guid)
                        local item_map_x = lualib:X(actor)
                        local item_map_y = lualib:Y(actor)
                        local ranges = {0, item_map_x, item_map_y, 10, 10}
                        local grids = lualib:GetRegionFreeRndEx(item_map_guid, ranges, 1)
                        if #grids ~= 0 then
                            for _, v in ipairs(grids) do
                                local x = v.X
                                local y = v.Y
                                local npc = lualib:Map_GenNpc(item_map_guid, "奇遇宝箱",  x, y, 0, 4)
                                lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#奇遇宝箱:玩家#COLORCOLOR_WHITE#["..lualib:Name(killer).."]在["..item_map_name.."地图的"..x..","..y.."]处击杀出#COLORCOLOR_PURPLE#[奇遇宝箱]", "", 1, 12);
                            end
                        end

                    elseif sjsz <= 30 then  --几率3%召唤经验柱
                        local item_map_guid = lualib:MapGuid(actor)
                        local item_map_name = lualib:Name(item_map_guid)
                        local item_map_x = lualib:X(actor)
                        local item_map_y = lualib:Y(actor)
                        local ranges = {0, item_map_x, item_map_y, 10, 10}
                        local grids = lualib:GetRegionFreeRndEx(item_map_guid, ranges, 1)
                        if #grids ~= 0 then
                            for _, v in ipairs(grids) do
                                local x = v.X
                                local y = v.Y
                                local npc = lualib:Map_GenNpc(item_map_guid, "经验柱",  x, y, 0, 4)
                                lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#经验柱:玩家#COLORCOLOR_WHITE#["..lualib:Name(killer).."]在["..item_map_name.."地图的"..x..","..y.."]处击杀出#COLORCOLOR_PURPLE#[经验柱]", "", 1, 12);
                            end
                        end


                    end
                end
            end
        end
    end
end





function on_pre_spell(player, skill_id, skill_key,x,y,mb,skillkey)

    if skill_key == "挖矿技能" then
        local sj = lualib:GenRandom(1, 100)
        if sj <= 100 then
            lualib:AddExp(player, 10, "添加经验:原因", "发起者")
        end
    end
    if skill_key == "地府之唤" or skill_key == "通幽之术" or skill_key == "天庭之唤" or skill_key == "天庭之唤" then
        local servant_t = lualib:Player_GetServantList(player)
        if #servant_t >= 1 then
            return false
        end
    end
    if skill_key == "死灵战将" then
        local servant_t = lualib:Player_GetServantList(player)
        if #servant_t >= 2 then
            return false
        end
    end
    return true
end

local mfdBuff = {
    "减免盾1级",
    "减免盾2级",
    "减免盾3级",
    "减免盾4级",
    "减免盾5级"
}

function on_spell(player, skill_id, skill_key,x,y,target,skillkey)
    if skillkey== "破盾风刺" then
        for i=1,#mfdBuff do
            if lualib:HasBuff(target,mfdBuff[i]) then
                if lualib:GenRandom(1, 10) > 9 then
                    lualib:DelBuff(target,mfdBuff[i])
                end
            end
        end
    end
end

function on_summon(role, monster_id, level)
    if monster_id == 386 then
        local servant_t = lualib:Player_GetServantList(role)
        if #servant_t < 2 then

        end
    end
end



function on_mining(player, KeyName)

    local sj = lualib:GenRandom(1, 100)
    if sj <= 100 then
        --lualib:AddExp(player, 2000, "添加经验:原因", "发起者")
    end

end

function on_servant_betry(guid)
    return false
end



function on_family_ntf(guid, name, type, player)
    lualib:DelayCall(guid, 1, "行会:on_family_ntf", name.."#"..type.."#"..player)
end

function on_family_member_ntf(family_guid, family_name, player_guid, opt_type)
    lualib:DelayCall(family_guid, 1, "行会:on_family_member_ntf", family_name.."#"..player_guid.."#"..opt_type)
end


function on_pre_stall_buy(buyplayer,sellplayer,item_guid,money,num,tpye)
    local addmoney = money * 0.05
    if lualib:GetBagFree(buyplayer) < 1 then
        lualib:MsgBox(buyplayer,"包裹空位不足，无法购买")
        return -1
    end
    if tpye == 0 then
        lualib:SubGold(sellplayer,addmoney,"摆摊扣税","")
    end
    if tpye == 1 then
        lualib:SubIngot(sellplayer,addmoney,"摆摊扣税","")
    end
    return money
end



function on_change_name_result(player, result, new_name)
    if 0 == result then
        if lualib:GetInt(player,"gaiming") == 1 then
            lualib:SetInt(player,"gaiming", 0)
            lualib:DelItem(player, "改名卡", 1, 2, "烟花", "烟花")
            lualib:KickByName(lualib:Name(player), 2, "测试踢人")
        end
    else
        lualib:SetInt(player,"gaiming", 0)
        lualib:SysPromptMsg(player, "改名失败，可能是重名或者名字包含屏蔽字")
    end
end




--------------杀人回调------------------
function on_trigger_kill(killer, victim)

    local victim_name = lualib:KeyName(victim)
    local kill_ren_name = lualib:Name(killer)
    local victim_ren_name = lualib:Name(victim)
    local victim_lv = lualib:Level(victim)
    local mapname = lualib:KeyName(lualib:MapGuid(killer))
    local job = lualib:Job(killer)

    if lualib:Player_IsPlayer(victim) == true and victim_lv >= 45 then
        local victim_family_name = lualib:GetFamilyName(victim)
        --杀戮值增加
        renwushujuchushihua(killer) --数据刷新

        local sha = {}
        local sha_str = lualib:GetStr(killer,"meiri_sharen")

        if sha_str ~= "" then
            sha = json.decode(sha_str) --取得每日杀人table
        end

        if sha[victim] == nil then
            sha[victim] = 1
        else
            sha[victim] = sha[victim] + 1
        end

        if sha[victim] == 1 then
            lualib:SetInt(killer,"shaluzhi",lualib:GetInt(killer,"shaluzhi")+1)	--杀戮值增加
            lualib:SetInt(killer,"ch_sharenshu",lualib:GetInt(killer,"ch_sharenshu")+1)	--铁血积分增加
            lualib:SysMsg_SendTriggerMsg(killer,"杀戮值增加1点")
            lualib:SysMsg_SendTriggerMsg(killer,"铁血积分增加1点")
            lualib:SysMsg_SendTipsMsg(killer, "杀戮值增加：1")
            lualib:SysMsg_SendTipsMsg(killer, "铁血积分增加：1")
            if mapname == "武斗场" then
                lualib:SetInt(killer,"shaluzhi",lualib:GetInt(killer,"shaluzhi")+1)	--杀戮值增加
                lualib:SetInt(killer,"ch_sharenshu",lualib:GetInt(killer,"ch_sharenshu")+1)	--铁血积分增加
                lualib:SysMsg_SendTriggerMsg(killer,"武斗场杀戮值额外增加1点")
                lualib:SysMsg_SendTriggerMsg(killer,"武斗场铁血积分额外增加1点")
                lualib:SysMsg_SendTipsMsg(killer, "杀戮值增加：1")
                lualib:SysMsg_SendTipsMsg(killer, "铁血积分增加：1")
            end
        end

        lualib:SetStr(killer,"meiri_sharen",json.encode(sha))
    end

    local map_name = lualib:Name(lualib:MapGuid(killer))
    local kill_ren_name = lualib:Name(killer)
    local victim_ren_name = lualib:Name(victim)
    local x = lualib:X(killer)
    local y = lualib:Y(killer)


    if lualib:GetDBNum("juanzlb") == 0 then
        local curTime = lualib:GetAllTime()
        lualib:SetDBNumEx("juanzlb", curTime, 6)
    end
    local jilu = lualib:GetDBNum("juanzlb")

    if lualib:Player_IsPlayer(victim) and lualib:Player_IsPlayer(killer) then
        --[[        if lualib:GetInt(victim, "glamour"..jilu) > 0 then
                    local jbs = lualib:GetInt(victim, "glamour"..jilu) * 0.5
                    lualib:AddGold(killer, jbs, "添加金币:原因", "发起者")
                    lualib:SetInt(victim, "glamour"..jilu, 0)
                    lualib:SysMsg_SendBroadcastColor("玩家["..lualib:Name(killer).."]在【"..map_name.."("..x..":"..y..")】干掉元宝捐献的玩家『"..victim_ren_name.."』后获得捐献元宝的50%赏金！", "", 1, 12)
                end

                local jisha = lualib:GetDBNum("jisha")
                local glamour =  lualib:GetInt(killer, jisha.."js_sl")
                lualib:SetInt(killer, jisha.."js_sl", glamour + 1)--]]


        if lualib:HasBuff(victim,"精英光环1") then
            if lualib:HasBuff(killer,"精英光环1")  then
                lualib:AddIngot(killer, 1500, "添加元宝:原因", "发起者")
                lualib:DelBuff(victim, "精英光环1")
                lualib:SysMsg_SendBroadcastColor("玩家["..lualib:Name(killer).."]在【"..map_name.."("..x..":"..y..")】干掉携带精英光环玩家『"..victim_ren_name.."』后获得1500元宝赏金！", "", 1, 12)
            else
                lualib:AddIngot(killer, 1000, "添加元宝:原因", "发起者")
                lualib:DelBuff(victim, "精英光环1")
                lualib:SysMsg_SendBroadcastColor("玩家["..lualib:Name(killer).."]在【"..map_name.."("..x..":"..y..")】干掉携带精英光环玩家『"..victim_ren_name.."』后获得1000元宝赏金！", "", 1, 12)
            end
        end

        if lualib:GenRandom(1, 2) == 1 then
            local killnotice = "#COLORCOLOR_GREENG#[王者快报]:【"..kill_ren_name.."】在【"..map_name.."("..x..":"..y..")】●●●把年轻气盛的『"..victim_ren_name.."』干掉了！#COLOREND#"
            lualib:SysMsg_SendBroadcastColor(killnotice, "", 11, 12)
        else
            local killnotice = "#COLORCOLOR_GREENG#[王者快报]:年轻气盛的【"..kill_ren_name.."】在【"..map_name.."("..x..":"..y..")】●●●把玩家『"..victim_ren_name.."』撂倒了！#COLOREND#"
            lualib:SysMsg_SendBroadcastColor(killnotice, "", 11, 12)
        end

    end

    if lualib:Player_IsPlayer(victim) and lualib:Player_IsPlayer(killer) == false then
        if lualib:GenRandom(1, 2) == 1 then
            local killnotice = "#COLORCOLOR_GREENG#[王者快报]:玩家『"..victim_ren_name.."』倒在【"..map_name.."("..x..":"..y..")】处气愤的对『"..kill_ren_name.."』说：奥利给！#COLOREND#"
            lualib:SysMsg_SendBroadcastColor(killnotice, "", 11, 12)
        else
            local killnotice = "#COLORCOLOR_GREENG#[王者快报]:玩家『"..victim_ren_name.."』被野怪『"..kill_ren_name.."』在【"..map_name.."("..x..":"..y..")】抢了BUFF了！#COLOREND#"
            lualib:SysMsg_SendBroadcastColor(killnotice, "", 11, 12)
        end
    end




    ---------------------------------------------日常任务 开始
    if lualib:GetAllDays(0) - lualib:GetInt(killer,"richang_leiji") >= 1 then
        lualib:SetInt(killer,"richang_cishu", 0)
        lualib:SetInt(killer,"jp_lingqu1", 0)
        lualib:SetInt(killer,"jp_lingqu2", 0)
        lualib:SetInt(killer,"jp_lingqu3", 0)
        lualib:SetInt(killer,"jp_lingqu4", 0)
        lualib:SetInt(killer,"jp_lingqu5", 0)
        lualib:SetInt(killer,"jp_lingqu6", 0)


        lualib:SetDayInt(killer,"richang_1",0)
        lualib:SetDayInt(killer,"richang_2",0)
        lualib:SetDayInt(killer,"richang_3",0)
        lualib:SetDayInt(killer,"richang_4",0)
        lualib:SetDayInt(killer,"richang_5",0)
        lualib:SetDayInt(killer,"richang_6",0)
        lualib:SetDayInt(killer,"richang_7",0)
        lualib:SetDayInt(killer,"richang_8",0)
        lualib:SetDayInt(killer,"richang_9",0)
        lualib:SetDayInt(killer,"richang_10",0)
        lualib:SetDayInt(killer,"richang_11",0)
        lualib:SetDayInt(killer,"richang_12",0)
        lualib:SetDayInt(killer,"richang_13",0)
        lualib:SetDayInt(killer,"richang_14",0)
        lualib:SetDayInt(killer,"richang_15",0)
        lualib:SetDayInt(killer,"richang_16",0)
        lualib:SetDayInt(killer,"richang_17",0)
        lualib:SetDayInt(killer,"richang_18",0)
        lualib:SetDayInt(killer,"richang_19",0)
        lualib:SetDayInt(killer,"richang_20",0)

        lualib:SetInt(killer,"richangguaiwu_1", 0)
        lualib:SetInt(killer,"richangguaiwu_2", 0)
        lualib:SetInt(killer,"richangguaiwu_3", 0)
        lualib:SetInt(killer,"richangguaiwu_4", 0)
        lualib:SetInt(killer,"richangguaiwu_5", 0)
        lualib:SetInt(killer,"richangguaiwu_6", 0)
        lualib:SetInt(killer,"richangguaiwu_7", 0)
        lualib:SetInt(killer,"richangguaiwu_8", 0)
        lualib:SetInt(killer,"richangguaiwu_9", 0)
        lualib:SetInt(killer,"richangguaiwu_10", 0)
        lualib:SetInt(killer,"richangguaiwu_11", 0)
        lualib:SetInt(killer,"richangguaiwu_12", 0)
        lualib:SetInt(killer,"richangguaiwu_13", 0)
        lualib:SetInt(killer,"richangguaiwu_14", 0)
        lualib:SetInt(killer,"richangguaiwu_15", 0)
        lualib:SetInt(killer,"richangguaiwu_16", 0)
        lualib:SetInt(killer,"richangguaiwu_17", 0)
        lualib:SetInt(killer,"richangguaiwu_18", 0)
        lualib:SetInt(killer,"richangguaiwu_19", 0)
        lualib:SetInt(killer,"richangguaiwu_20", 0)
        lualib:SetInt(killer,"richang_leiji",lualib:GetAllDays(0))
    end



    if lualib:Player_IsPlayer(victim) ~= true then
        if lualib:Player_IsPlayer(killer) == true  then
            local monster_type = lualib:Monster_Type(victim_name)  --怪物类型
            if monster_type == 2 then
                if  lualib:GetDayInt(killer,"mr_rw1") < 20 then
                    lualib:SetDayInt(killer,"mr_rw1", lualib:GetDayInt(killer,"mr_rw1") + 1)
                end
            elseif monster_type == 3 then
                if  lualib:GetDayInt(killer,"mr_rw2") < 5 then
                    lualib:SetDayInt(killer,"mr_rw2", lualib:GetDayInt(killer,"mr_rw2") + 1)
                end
            elseif monster_type == 4 then
                if  lualib:GetDayInt(killer,"mr_rw3") < 1 then
                    lualib:SetDayInt(killer,"mr_rw3", lualib:GetDayInt(killer,"mr_rw3") + 1)
                end
            end

            if victim_ren_name ~= "修炼兽人" then
                lualib:SetInt(killer,"chenghao_yi", lualib:GetInt(killer,"chenghao_yi") + 1) --累积称号杀怪
            end
        else
            local name = lualib:Monster_GetMaster(killer)
            local target_Guid = lualib:Name2Guid(name)
            if target_Guid ~= "" then
                local monster_type = lualib:Monster_Type(victim_name)  --怪物类型
                if monster_type == 2 then
                    if  lualib:GetDayInt(target_Guid,"mr_rw1") < 20 then
                        lualib:SetDayInt(target_Guid,"mr_rw1", lualib:GetDayInt(target_Guid,"mr_rw1") + 1)
                    end
                elseif monster_type == 3 then
                    if  lualib:GetDayInt(target_Guid,"mr_rw2") < 5 then
                        lualib:SetDayInt(target_Guid,"mr_rw2", lualib:GetDayInt(target_Guid,"mr_rw2") + 1)
                    end
                elseif monster_type == 4 then
                    if  lualib:GetDayInt(target_Guid,"mr_rw3") < 1 then
                        lualib:SetDayInt(target_Guid,"mr_rw3", lualib:GetDayInt(target_Guid,"mr_rw3") + 1)
                    end
                end

                if victim_ren_name ~= "修炼兽人" then
                    lualib:SetInt(target_Guid,"chenghao_yi", lualib:GetInt(target_Guid,"chenghao_yi") + 1) --累积称号杀怪
                end

            end
        end
    end




    ---------------------------------------------日常任务 结束



end

----------------------------攻城开始

function on_castle_war_start(castle_name, dst_map_guid, basilica_map_guid)
    lualib:SetDBNum("shengeshuxing", 1)
    lualib:SetInt("0", "war_start", 1)
    lualib:SysMsg_SendBroadcastMsg("["..castle_name.."]攻城战开始了！", "系统通知")
    lualib:SetDBNumEx("shengeshuxing", 1, 2)
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
        lualib:SysMsg_SendBroadcastMsg("["..own_family.."]行会会长可到【神歌城管理员】处领取神歌城元宝奖励！", "系统通知")
        if lualib:GetDBNum("diyicgongcheng") == 0 then
            lualib:SetDBNumEx("diyicgongcheng", 1, 2)
        end
    end

end



----------------------------------首杀
local ss_gw = {
    {"魔王禁地牛魔王", 1000, 3},
    {"蛮荒废墟魔龙教主", 1000, 3},
    {"妖魔教主", 1000, 3},
    {"尸魔教主", 1000, 3},
    {"古魔妖后", 2000, 3},
    {"天魔魔皇", 2000, 3},
    {"雪域魔王", 4000, 3},
    {"玄武树妖", 4000, 3},
    {"星空狂魔", 6000, 3},
    {"火龙巨兽", 6000, 3},

    {"魔谷之王", 8000, 3},
    {"神殿天皇", 8000, 3},
    {"寒晶雪妖", 8000, 3},
    {"远古天尊", 8000, 3},

    {"转生之魔", 5000, 3},
    {"盾牌之魔", 5000, 3},
    {"坐骑之魔", 5000, 3},
    {"翅膀之魔", 5000, 3},
    {"法宝之魔", 5000, 3},
    {"宝石之魔", 5000, 3},
    {"斗笠之魔", 5000, 3},
    {"玉佩之魔", 5000, 3},
}

function on_post_monster_die(monster,  killer)
    local keyName = lualib:KeyName(monster)
    for i = 1, #ss_gw do
        if ss_gw[i][1] == keyName then
            if ss_gw[i][3] - lualib:GetDBNum("首杀累积"..keyName) > 0 and lualib:GetInt(killer, "首杀_"..keyName) == 0 then

                lualib:SetInt(killer, "首杀_"..keyName, 1)
                lualib:SetDBNumEx("首杀累积"..keyName, lualib:GetDBNum("首杀累积"..keyName) + 1, 4)
                lualib:AddIngot(killer, ss_gw[i][2], "添加元宝:原因", "发起者")
                lualib:SysMsg_SendBroadcastMsg("玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..lualib:Name(monster).."”】！获得了"..ss_gw[i][2].."元宝！", "系统消息")

                lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..lualib:Name(monster).."”】！获得了"..ss_gw[i][2].."元宝！","")
                lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..lualib:Name(monster).."”】！获得了"..ss_gw[i][2].."元宝！","")
                lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..lualib:Name(monster).."”】！获得了"..ss_gw[i][2].."元宝！","")
                lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(killer).."]完美的击杀了首杀怪物【“"..lualib:Name(monster).."”】！获得了"..ss_gw[i][2].."元宝！","")


                if lualib:GetDBNum("首杀累积"..keyName) == 1 then
                    lualib:SetDBStrEx("击杀名称"..ss_gw[i][1], lualib:Name(killer), 1)
                elseif lualib:GetDBNum("首杀累积"..keyName) <= 3 then
                    lualib:SetDBStrEx("击杀名称"..ss_gw[i][1], lualib:GetDBStr("击杀名称"..ss_gw[i][1]).."‖"..lualib:Name(killer), 1)
                end
            end
        end
    end

end


function on_post_die(player)
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
    return a[2] > b[2]
end



---------------------------------------------1秒定时器
function hecheng(player, time_id)

    local vip_lv = lualib:GetVipLevel(player)
    if vip_lv > 0 then
        if lualib:HasBuff(player, "会员护佑") then
        else
            lualib:AddBuff(player, "会员护佑", 0)
        end
    else
        if lualib:HasBuff(player, "会员护佑") then
            lualib:DelBuff(player, "会员护佑")
        end
    end

    if lualib:GetAllDays(0) - lualib:GetInt(player,"hy_gengxin") >= 1 then
        lualib:SetInt(player, "huiyuansj", lualib:GetInt(player, "huiyuansj") - 1)
        if lualib:GetInt(player, "huiyuansj") < 0 then
            lualib:SetInt(player, "huiyuansj", 0)
        end
        lualib:SetInt(player,"hy_gengxin", lualib:GetAllDays(0))
    end
    if lualib:GetInt(player, "huiyuansj") <= 0 then
        local vip_lv = lualib:GetVipLevel(player)
        if vip_lv > 0 then
            lualib:SetVipLevel(player, 0)
        end
    end





    local integral = lualib:GetIntegral(player)
    lualib:SetInt(player,"jjc_rongyao",integral)
    local level = lualib:Level(player)
    local max = lualib:GetDBNum("NOL1")
    if level > max then
        lualib:SetDBNum("NOL1", level)
    end
    --if  max - level >= 5 then
    --    if lualib:HasBuff(player, "新手经验补偿") then
    --    else
    --        lualib:AddBuff(player, "新手经验补偿", 0)
    --    end
    --else
    --    if lualib:HasBuff(player, "新手经验补偿") then
    --        lualib:DelBuff(player, "新手经验补偿")
    --    end
    --end


    local zhid = lualib:UserID(player)
    local ybsl = lualib:GetDBNum("lixian_chongzhi_"..zhid)
    if ybsl > 0 then
        if lualib:GetDBStr(zhid.."_jilu") == "" then
            lualib:SetDBStr(zhid.."_jilu", player)
        end
        if player == lualib:GetDBStr(zhid.."_jilu") then
            lualib:SetDBNumEx("lixian_chongzhi_"..zhid, 0, 4)
            local yb = ybsl
            local name = lualib:Name(player)
            lualib:SysWarnMsg(player, "你充值了"..yb.."元宝")
            lualib:SysMsg_SendBroadcastMsg("恭喜"..name.."在线充值获得"..yb.."元宝，如果你也想要快人一步请点击屏幕右下角商铺进行充值","[充值提示]")
            lualib:SetInt(player,"chongzhi", lualib:GetInt(player,"chongzhi") + tonumber(yb))
            lualib:SetDayInt(player, "richong1", lualib:GetDayInt(player, "richong1") + tonumber(yb))
        end
    end
    --[[
          local vip_lv = lualib:GetVipLevel(player)

          local cz = lualib:GetInt(player, "chongzhi") + lualib:GetInt(player, "czjuan") + lualib:GetInt(player,"chongzhi1")
          if cz >= 9900 then
             if vip_lv ~= 2 then
                lualib:SetVipLevel(player, 2)
                lualib:SysMsg_SendBroadcastColor("玩家“".. lualib:Name(player) .."”获得了饕餮神途尊贵的[终身赞助会员]!!", "系统信息", 1, 3)
             end

          elseif cz >= 3000 then
             if vip_lv ~= 1 then
                lualib:SetVipLevel(player, 1)
                lualib:SysMsg_SendBroadcastColor("玩家“".. lualib:Name(player) .."”获得了饕餮神途尊贵的[初级赞助会员]!!", "系统信息", 1, 3)
             end
          end
    --]]



    local name = lualib:Name(player)
    local level = lualib:Level(player)
    local hhguid = lualib:GuildGuid(player)
    local hhmc = "暂无"
    if hhguid ~= "" then
        hhmc = lualib:Name(hhguid)
    end

    local glamour = level
    if glamour > 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("dengji_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if name == v[1] and v[2] > 0 then
                table.remove(ranking, k)
            end
        end
        table.insert(ranking, {name, glamour, hhmc})
        table.sort(ranking, compare)
        if #ranking > 20 then
            table.remove(ranking, #ranking)
        end
        lualib:SetDBStr("dengji_ranking_t", json.encode(ranking))
    end


    local glamour = lualib:GetInt(player,"chongzhi") / 100
    if glamour > 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("czph_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if name == v[1] and v[2] > 0 then
                table.remove(ranking, k)
            end
        end
        table.insert(ranking, {name, glamour, hhmc})
        table.sort(ranking, compare)
        if #ranking > 20 then
            table.remove(ranking, #ranking)
        end
        lualib:SetDBStr("czph_ranking_t", json.encode(ranking))
    end









    local jisha = lualib:GetDBNum("jisha")
    local glamour =  lualib:GetInt(player, jisha.."js_sl")
    if glamour > 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("zhanlis_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if name == v[1] and v[2] > 0 then
                table.remove(ranking, k)
            end
        end
        table.insert(ranking, {name, glamour, level})
        table.sort(ranking, compare)
        if #ranking > 20 then
            table.remove(ranking, #ranking)
        end
        lualib:SetDBStr("zhanlis_ranking_t", json.encode(ranking))
    end



    local luck = lualib:LuckCurse(player)
    if luck >= 11 then
        if lualib:HasBuff(player, "幸运"..luck) then
        else
            lualib:AddBuff(player, "幸运"..luck, 0)
        end
    else
        if lualib:HasBuff(player, "幸运11") then
            lualib:DelBuff(player, "幸运11")
        end
        if lualib:HasBuff(player, "幸运12") then
            lualib:DelBuff(player, "幸运12")
        end
        if lualib:HasBuff(player, "幸运13") then
            lualib:DelBuff(player, "幸运13")
        end
    end
    --[[
            local job = lualib:Job(player)
            local mount = lualib:Mount(player)
            if mount ~= "" then
               local z_name = lualib:KeyName(mount)
               if z_name == "坐骑10" then
                  if job == 1 then
                     if lualib:HasSkill(player, "逐日剑法4级", false) == true then
                     else
                        lualib:Player_AddSkill(player, "逐日剑法4级")
                     end
                  elseif job == 2 then
                     if lualib:HasSkill(player, "陨星灭世4级", false) == true then
                     else
                        lualib:Player_AddSkill(player, "陨星灭世4级")
                     end
                  elseif job == 3 then
                     if lualib:HasSkill(player, "嗜血术4级", false) == true then
                     else
                        lualib:Player_AddSkill(player, "嗜血术4级")
                     end
                  end
               else
                     if lualib:HasSkill(player, "逐日剑法4级", false) == true then
                        lualib:DelSkill(player, "逐日剑法4级")
                     end
                     if lualib:HasSkill(player, "嗜血术4级", false) == true then
                        lualib:DelSkill(player, "嗜血术4级")
                     end
                     if lualib:HasSkill(player, "陨星灭世4级", false) == true then
                        lualib:DelSkill(player, "陨星灭世4级")
                     end
               end
            else
                     if lualib:HasSkill(player, "逐日剑法4级", false) == true then
                        lualib:DelSkill(player, "逐日剑法4级")
                     end
                     if lualib:HasSkill(player, "嗜血术4级", false) == true then
                        lualib:DelSkill(player, "嗜血术4级")
                     end
                     if lualib:HasSkill(player, "陨星灭世4级", false) == true then
                        lualib:DelSkill(player, "陨星灭世4级")
                     end
            end
    --]]

    if lualib:GetDBNum("juanzlb") == 0 then
        local curTime = lualib:GetAllTime()
        lualib:SetDBNumEx("juanzlb", curTime, 6)
    end
    local jilu = lualib:GetDBNum("juanzlb")

    local level = lualib:Level(player)
    local name = lualib:Name(player)
    local glamour = lualib:GetInt(player, "glamour"..jilu)


    if glamour <= 0 then
        local ranking = {}
        local rankstr = lualib:GetDBStr("ybjx_ranking_t")
        if rankstr ~= "" then
            ranking = json.decode(rankstr)
        end
        for k, v in ipairs(ranking) do
            if name == v[1]  then
                table.remove(ranking, k)
            end
        end
        lualib:SetDBStrEx("ybjx_ranking_t", json.encode(ranking),6)
    end

    local chongzhi_ranking_t = lualib:GetDBStr("czph_ranking_t")
    if chongzhi_ranking_t ~= "" then
        chongzhi_ranking_t = json.decode(chongzhi_ranking_t)
    end
    local cz = 0
    for i = 1, #chongzhi_ranking_t do
        if chongzhi_ranking_t == "" then
        else
            if chongzhi_ranking_t[i] == nil then
            else
                if chongzhi_ranking_t[i][1] == lualib:Name(player) then
                    cz = i
                end
            end
        end
    end

    local fenghaos = {
        34,33,32,31,30,22,20,19,17,16
    }


    if cz >= 1 and cz <= 10  then
        if lualib:HasBuff(player,"减免"..cz) then
        else
            lualib:AddBuff(player, "减免"..cz, 0)
            lualib:AddTitle(player,fenghaos[cz])
        end


    else
        for i = 1 , 10 do
            if lualib:HasBuff(player,"减免"..i) then
                lualib:DelBuff(player, "减免"..i)
                lualib:RemoveTitle(player,fenghaos[i])
            end
        end
    end





    local chongzhi_ranking_t = lualib:GetDBStr("meigui_ranking_t")
    if chongzhi_ranking_t ~= "" then
        chongzhi_ranking_t = json.decode(chongzhi_ranking_t)
    end
    local cz = 0
    for i = 1, #chongzhi_ranking_t do
        if chongzhi_ranking_t == "" then
        else
            if chongzhi_ranking_t[i] == nil then
            else
                if chongzhi_ranking_t[i][1] == lualib:Name(player) then
                    cz = i
                end
            end
        end
    end
    if cz >= 1 and cz <= 3  then
        if lualib:HasBuff(player,"经验"..cz) then
        else
            lualib:AddBuff(player, "经验"..cz, 0)
        end
    else
        for i = 1 , 3 do
            if lualib:HasBuff(player,"经验"..i) then
                lualib:DelBuff(player, "经验"..i)
            end
        end
    end




    local chongzhi_ranking_t = lualib:GetDBStr("ybjx_ranking_t")
    if chongzhi_ranking_t ~= "" then
        chongzhi_ranking_t = json.decode(chongzhi_ranking_t)
    end
    local cz = 0
    for i = 1, #chongzhi_ranking_t do
        if chongzhi_ranking_t == "" then
        else
            if chongzhi_ranking_t[i] == nil then
            else
                if chongzhi_ranking_t[i][1] == lualib:Name(player) then
                    cz = i
                end
            end
        end
    end
    if cz ~= 0 and cz <= 3 then
        if lualib:HasBuff(player,"元宝捐赠"..cz) then
        else
            lualib:AddBuff(player, "元宝捐赠"..cz, 0)
        end
    elseif cz ~= 0 and cz <= 10 then
        if lualib:HasBuff(player,"元宝捐赠4") then
        else
            lualib:AddBuff(player, "元宝捐赠4", 0)
        end
    else
        for i = 1 , 4 do
            if lualib:HasBuff(player,"元宝捐赠"..i) then
                lualib:DelBuff(player, "元宝捐赠"..i)
            end
        end
    end

    local vip_lv = lualib:GetVipLevel(player)
    if vip_lv > 0 then
        local item_map_guid = lualib:MapGuid(player)
        local item_map_name = lualib:Name(item_map_guid)
        lualib:Player_FixEquip(player, true)
        if lualib:GetInt(player, "autoattack") == 1 and item_map_name ~= "龙城1" then
            local gold = lualib:GetGold(player)
            if lualib:ItemCount(player, "强效金创药") < 1 and lualib:GetInt(player, "huishou_8") == 1 then
                if gold >= 600 and lualib:Player_GetBagFree(player) >= 1 then
                    lualib:SubGold(player, 600, "扣除金币原因", lualib:Name(player));
                    lualib:GiveItem(player, "强效金创药", 1, "给予道具:原因", "发起人")
                end
            end

            if lualib:ItemCount(player, "强效魔法药") < 1 and lualib:GetInt(player, "huishou_9") == 1 then
                if gold >= 600 and lualib:Player_GetBagFree(player) >= 1 then
                    lualib:SubGold(player, 600, "扣除金币原因", lualib:Name(player));
                    lualib:GiveItem(player, "强效魔法药", 1, "给予道具:原因", "发起人")
                end
            end

            lualib:Player_FixEquip(player, true)
            if lualib:Player_GetBagFree(player) <= lualib:GetInt(player, "huishou_16") then
                lualib:Player_FixEquip(player, true)
                lualib:ShowFormWithContent(player,"脚本表单","TaskWindow.zhengli(111)")
                for i = 1, 4 do
                    if lualib:GetInt(player, "huishou_"..i) == 1 then
                        lualib:DelayCall(player, 1, "自动回收表单:zidong", ""..i);
                    end
                end
            end
        end
    else
        --if lualib:HasBuff(player,"自动战斗") then
        --lualib:DelBuff(player, "自动战斗")
        --end
    end
end

-------------------人物数据初始化----------------
function renwushujuchushihua(player) --人物数据初始化
    --每日初始化
    if lualib:GetAllDays(0) - lualib:GetInt(player,"meiri_chushihua") >= 1 then
        lualib:SetInt(player,"meiri_chushihua",lualib:GetAllDays(0)) --记录开启计时的当前天数
        lualib:SetStr(player,"meiri_sharen","") --每日杀人次数记录
        lualib:SetInt(player,"shaluzhi", 0) --杀戮值清零
    end
end

local time_tb = {
    {0,60*60*24*1,50},
    {60*60*24*1,60*60*24*2,55},
    {60*60*24*2,60*60*24*3,60},
    {60*60*24*3,60*60*24*4,65},
    {60*60*24*4,60*60*24*5,70},
    {60*60*24*5,60*60*24*6,75},
    {60*60*24*6,60*60*24*7,80},

}

function on_player_login(player)
    Lfte(player)
    lualib:ShowFormWithContent(player, "脚本表单", [[myif_Lfte.Gb()]])

    local start_time = lualib:GetConstVar("StartServerTime")
    local kaiqu_time = lualib:Str2Time(start_time)
    local now_time = lualib:Now()
    local xianzai_time = lualib:Str2Time(now_time)
    local level = lualib:Level(player)
    for i=1,#time_tb do
        if (xianzai_time - kaiqu_time) >= time_tb[i][1] and (xianzai_time - kaiqu_time) < time_tb[i][2] then
            lualib:MsgBox(player,"当前封印等级"..time_tb[i][3].."级")
        end
    end
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "hecheng")
    end
    lualib:AddTimer(player, 20202, 1000, -1, "changeFamilyTitle")

    --[[
        local player_name = lualib:Player_GetStrProp(player, lua_role_user_name)
        if lualib:GetDBStr("Mrrp_YBJZ_Na01") == player_name then
            lualib:AddBuff(player, "金币捐献第一名", 100000)
            lualib:SysMsg_SendTriggerMsg(player, "您是金币捐赠第一名!")
            lualib:SysMsg_SendBroadcastColor("金币捐赠第一名【"..player_name.."】上线了!","",7,2)
        end
        if lualib:GetDBStr("Mrrp_YBJZ_Na02") == player_name then
            lualib:AddBuff(player, "金币捐献第二名", 100000)
            lualib:SysMsg_SendTriggerMsg(player, "您是金币捐赠第二名!.")
            lualib:SysMsg_SendBroadcastColor("金币捐赠第二名【"..player_name.."】上线了!","",7,2)
        end
        if lualib:GetDBStr("Mrrp_YBJZ_Na03") == player_name then
            lualib:AddBuff(player, "金币捐献第三名", 100000)
            lualib:SysMsg_SendTriggerMsg(player, "您是金币捐赠第三名!")
            lualib:SysMsg_SendBroadcastColor("金币捐赠第三名【"..player_name.."】上线了!","",7,2)
        end



        if lualib:GetDBStr("Mrrp_YBJZ_Na01") ~= player_name and lualib:GetDBStr("Mrrp_YBJZ_Na02") ~= player_name and lualib:GetDBStr("Mrrp_YBJZ_Na03") ~= player_name  and lualib:GetDBStr("Mrrp_YBJZ_Na04") ~= player_name  and lualib:GetDBStr("Mrrp_YBJZ_Na05") ~= player_name then
            if lualib:HasBuff(player, "金币捐献第一名") then
                lualib:DelBuff(player, "金币捐献第一名")
            end
            if lualib:HasBuff(player, "金币捐献第二名") then
                lualib:DelBuff(player, "金币捐献第二名")
            end
            if lualib:HasBuff(player, "金币捐献第三名") then
                lualib:DelBuff(player, "金币捐献第三名")
            end
            if lualib:HasBuff(player, "金币捐献第四名") then
                lualib:DelBuff(player, "金币捐献第四名")
            end
            if lualib:HasBuff(player, "金币捐献第五名") then
                lualib:DelBuff(player, "金币捐献第五名")
            end
        end


    --]]

    if lualib:GetInt(player,"记录种族") == 0 then
        lualib:SetDBNumEx(lualib:GetStr(player,"countryName").."人数",lualib:GetDBNum(lualib:GetStr(player,"countryName").."人数")+1,6)
        lualib:SetInt(player,"记录种族",1)
    end
    local lc_map_guid = lualib:Map_GetMapGuid("龙城")
    local npc = lualib:Map_GetMapNpc(lc_map_guid, "元宝捐献")
    local tishi_tb = {
        "元宝捐献第一名",
        "元宝捐献第二名",
        "元宝捐献第三名",
        "元宝捐献第四名",
        "元宝捐献第五名",
        "元宝捐献第六名",
    }
    if npc ~= "" then
        local name = lualib:Name(player)
        for i = 1, #tishi_tb do
            if lualib:HasBuff(player, tishi_tb[i]) then
                if lualib:GetStr(npc, "yuanbao_juanxian_"..i) ~= name then
                    lualib:DelBuff(player, tishi_tb[i])
                end
            else
                if lualib:GetStr(npc, "yuanbao_juanxian_"..i) == name then
                    lualib:AddBuff(player, tishi_tb[i], 0)
                end
            end
        end
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
    if lualib:HasBuff(player,"自动战斗") then
        lualib:DelBuff(player, "自动战斗")
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
    renwushujuchushihua(player) -- 杀戮值检测
    --右上角图标显示
    --online_gift_login(player)	--在线礼包
    guaji_xianshi(player)		--自动打怪
    huodong_xianshi(player)		--自动打怪
    sha_xianshi(player)		--自动打怪
    shou_xianshi(player)		--自动打怪
    shijieboss(player)  --世界BOSS
    callback_paihang(player)--读取充值

    --check_first_bill(player)	--首充与充值礼包
    richong_xianshi(player)	--日充
    xinchongzhi_xianshi(player)	--累计
    shouchonglibao(player) --首冲礼包

    weixin_xianshi(player) --微信礼包
    shouyou_xianshi(player) --手游下载
    richang_xianshi(player) --悬赏任务
    lualib:DelayCall(player, 1, "QQ群礼包:show", "");
    yxgonglue(player)	--游戏攻略
    tanbao_xianshi(player)	--探宝

    if lualib:GetDBNum("合区") > 1 then
        local family = lualib:GetFamilyName(player)

        if family ~= "魔族" and string.match(family,"魔族") == "魔族" then
            --lualib:DelFamilyMember(player,family,"hequhanghui","蜀国")
            --lualib:AddFamilyMember(player,"蜀国","","")
            --lualib:Player_RunGMCmd(player,"gmbox","fd "..family.." "..lualib:Name(player))
            --lualib:Player_RunGMCmd(player,"gmbox","fa 蜀国 "..lualib:Name(player))
            lualib:DestroyFamily(family)
            lualib:AddFamilyMember(player,"魔族","","")
        elseif family ~= "神族" and string.match(family,"神族") == "神族" then
            --lualib:DelFamilyMember(player,family,"hequhanghui","蜀国")
            --lualib:AddFamilyMember(player,"吴国","","")
            --lualib:Player_RunGMCmd(player,"gmbox","fd "..family.." "..lualib:Name(player))
            --lualib:Player_RunGMCmd(player,"gmbox","fa 吴国 "..lualib:Name(player))
            lualib:DestroyFamily(family)
            lualib:AddFamilyMember(player,"神族","","")
        end
    end
    lualib:AddTimer(player,208131,1000,-1,"countryBuff_CallBack")

    local spouse = lualib:GetStr(player, "配偶GUID")
    if spouse ~= "" then
        local caller = (lualib:Gender(player) == 1) and "丈夫" or "妻子"
        lualib:SysPromptMsg(spouse, "你的"..caller.."上线了。")
    end
    --每次上线确认是否有加入国家，未加入弹出面板
    local count = 0
    local nameList = lualib:Name(player)            --玩家名字
    local country = lualib:GetStr(player,"countryName")     --国家名字
    if  country == "" then
        lualib:DelayCall(player,1,"country:main","")
    end
    if lualib:GetInt(player,"newSummonTimes") == 0 then
        lualib:SetInt(player,"newSummonTimes",lualib:GetAllTime()+3600)
    end
    if lualib:GetInt(player,"newSummonIsHour") == 0 then
        local Eq = lualib:Player_Summon(player, "美女护卫", 7)
        lualib:AddBuff(Eq, "无敌", 0)
    end
    lualib:AddTimer(player,208132,1000,-1,"newSummonIsHour_CallBack")
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
    local ranges = {0, 255, 270, 11, 11}
    local mapguid = lualib:Map_GetMapGuid("龙城")
    local players = lualib:Map_GetRegionPlayersEx(mapguid, ranges, true)
    local item_map_guid = lualib:MapGuid(player)
    local item_map_name = lualib:Name(item_map_guid)
    if item_map_name == "豪杰聚义厅" then
        lualib:ClearTimer(player)
        return true
    end
    if type == 1 then
        if lualib:HasBuff(player,"摆摊") then
            lualib:SetOffline(player, 1296000)
            lualib:ClearTimer(player)
            return false
        end
        if item_map_name == "闭关修炼" then
            lualib:SetOffline(player, 28800)
            lualib:ClearTimer(player)
            return false
        end


        if #players < 100 then
            local sjx = lualib:GenRandom(1, 19)
            local sjy = lualib:GenRandom(1, 19)
            lualib:Player_MapMoveXY(player,"龙城", 244 + sjx , 259 + sjy , 1)
            lualib:SetOffline(player, 1296000)
            lualib:ClearTimer(player)
            return false
        end
    end


    lualib:DelayCall(player, 1, "master:process_master_apprentice_logout", ""); --师徒退出处理
    lualib:DelayCall(player, 1, "online_gift:online_gift_logout", ""); --在线礼包退出

    return true;
end

function on_player_add_exp(player, expv)
    lualib:DelayCall(player, 1, "经验脚本:main", tostring(expv));
end

local time_tb = {
    {0,60*60*24*1,50},
    {60*60*24*1,60*60*24*2,55},
    {60*60*24*2,60*60*24*3,60},
    {60*60*24*3,60*60*24*4,65},
    {60*60*24*4,60*60*24*5,70},
    {60*60*24*5,60*60*24*6,75},
    {60*60*24*6,60*60*24*7,80},

}

function on_level_up(player, level)

    local start_time = lualib:GetConstVar("StartServerTime")
    local kaiqu_time = lualib:Str2Time(start_time)
    local now_time = lualib:Now()
    local xianzai_time = lualib:Str2Time(now_time)
    for i=1,#time_tb do
        if (xianzai_time - kaiqu_time) >= time_tb[i][1] and (xianzai_time - kaiqu_time) < time_tb[i][2] and level == time_tb[i][3] then
            return false
        end
    end


    if level == 60 then
        lualib:MsgBox(player, "您达到了60级,可以去进行转生操作!\n转生后可获得各种属性加成!\n 打开#COLORCOLOR_PURPLE#“成长礼包”#COLOREND#内赠送转生石！")
    end
    if level == 50 then
        lualib:MsgBox(player, "目前您可通过<便捷传送门>到中级地图历练! ")
    end
    if level == 48 then
        lualib:MsgBox(player, "目前您可通过<便捷传送门>到材料地图历练! ")
    end



    if level == 45 then
        lualib:MsgBox(player, "您达到了45级,可以去合成雷霆系列装备!\n合成需要对应未开光的雷霆系列装备！")
    end
    if level == 50 then
        lualib:MsgBox(player, "您达到了50级,可以去合成战神系列装备!\n合成需要对应未开光的战神系列装备！")
    end
    if level == 55 then
        lualib:MsgBox(player, "您达到了55级,可以去合成星王系列装备!\n合成需要对应未开光的星王系列装备！")
    end
    if level == 65 then
        lualib:MsgBox(player,  "您达到了65级,可以去合成狂雷系列装备!\n合成需要对应未开光的狂雷系列装备！")
    end
    if level == 70 then
        lualib:MsgBox(player, "您达到了70级,可以去合成火龙系列装备!\n合成需要对应未开光的火龙系列装备！")
    end



    active_player(player, 3, 0)	--升级时向网站发送角色最新信息，不要删除否则影响统计功能
    lualib:DelayCall(player, 1, "master:process_apprentice_level_up", tostring(level))  --调用徒弟升级触发
end

function csnpc(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 263, 263, 3)
end
function csnpc1(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 246, 261, 3)
end
function csnpc2(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 247, 267, 3)
end
function csnpc3(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 249, 277, 3)
end
function csnpc4(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 247, 275, 3)
end
function csnpc5(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 247, 271, 3)
end
function csnpc6(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 247, 263, 3)
end
function csnpc7(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 261, 278, 3)
end
function csnpc8(dlg_id, player)
    lualib:Player_MapMoveXY(player, "龙城", 255, 273, 3)
end



--------[[玩家第一次进入游戏]]
function on_first_in_game(player)
    if lualib:HasTimer(player, 41674) == false then
        lualib:AddTimer(player, 41674, 1000, -1, "hecheng")
    end


    lualib:AddBuff(player, "新手护佑", 3600);
    local item_k = {"木剑"}
    local item_n = {1, 1}
    local item_b = {1, 1}
    local item_o = {0, 0}
    --lualib:GiveBindItem(player, "龙城传送石", 1, "给予道具:原因", "发起人")
    --lualib:GiveBindItem(player, "随机传送石", 1, "给予道具:原因", "发起人")

    if not lualib:Player_ItemRequest(player, item_k, item_n, item_b, item_o, "给物品：第一次进游戏", "") then
        lualib:SysTriggerMsg(player, "新手物品赠送失败！")
    end

    local Gender = lualib:Gender(player)
    --local award_item = {"布衣(男)", "布衣(女)"}
    --if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
    --lualib:SysTriggerMsg(player, "赠送布衣失败！")
    --end

    --[[
    lualib:GiveBindItem(player, "聚义新手头盔", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手项链", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手护腕", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手戒指", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手护腕", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手戒指", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手腰带", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手靴子", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手之刃", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手盔甲", 1, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手铠衣", 1, "给予道具:原因", "发起人")

                    if Gender == 1 then
    lualib:GiveBindItem(player, "聚义新手盔甲", 0, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手铠衣", 0, "给予道具:原因", "发起人")
                    lualib:ApplyEquipEx(player, "聚义新手盔甲")
                    else
    lualib:GiveBindItem(player, "聚义新手铠衣", 0, "给予道具:原因", "发起人")
    lualib:GiveBindItem(player, "聚义新手盔甲", 0, "给予道具:原因", "发起人")
                    lualib:ApplyEquipEx(player, "聚义新手铠衣")
                    end

                    lualib:ApplyEquipEx(player, "聚义新手头盔")
                    lualib:ApplyEquipEx(player, "聚义新手项链")
                    lualib:ApplyEquipEx(player, "聚义新手护腕")
                    lualib:ApplyEquipEx(player, "聚义新手戒指")
                    lualib:ApplyEquipEx(player, "聚义新手护腕")
                    lualib:ApplyEquipEx(player, "聚义新手戒指")
                    lualib:ApplyEquipEx(player, "聚义新手腰带")
                    lualib:ApplyEquipEx(player, "聚义新手靴子")
                    lualib:ApplyEquipEx(player, "聚义新手之刃")

    --]]
    local role_gender = lualib:Job(player)  --获取职业
    if role_gender == 1 then  -- 战
        lualib:Player_AddSkill(player, "基本剑术1级")
        lualib:Player_AddSkill(player, "攻杀剑术1级")
        lualib:Player_AddSkill(player, "半月弯刀1级")
        lualib:Player_AddSkill(player, "野蛮冲撞1级")
        lualib:Player_AddSkill(player, "烈火剑法1级")
        lualib:Player_AddSkill(player, "刺杀剑术1级")

    elseif role_gender == 2 then  -- 法
        lualib:Player_AddSkill(player, "抗拒火环1级")
        lualib:Player_AddSkill(player, "诱惑之光1级")
        lualib:Player_AddSkill(player, "冰咆哮1级")
        lualib:Player_AddSkill(player, "魔法盾1级")
        lualib:Player_AddSkill(player, "火墙1级")
        lualib:Player_AddSkill(player, "雷电术1级")

    elseif role_gender == 3 then  -- 道
        -- lualib:GiveBindItem(player, "超级护身符", 1, "给予道具:原因", "发起人")
        --lualib:GiveBindItem(player, "超级黄色药粉", 1, "给予道具:原因", "发起人")
        --lualib:GiveBindItem(player, "超级灰色药粉", 1, "给予道具:原因", "发起人")
        lualib:Player_AddSkill(player, "治愈术1级")
        lualib:Player_AddSkill(player, "施毒术1级")
        lualib:Player_AddSkill(player, "隐身术1级")
        lualib:Player_AddSkill(player, "幽灵盾1级")
        lualib:Player_AddSkill(player, "神圣战甲术1级")
        lualib:Player_AddSkill(player, "群体治愈术1级")
        lualib:Player_AddSkill(player, "精神力战法1级")
        lualib:Player_AddSkill(player, "集体隐身术1级")
        lualib:Player_AddSkill(player, "灵魂火符1级")
        lualib:Player_AddSkill(player, "召唤神兽1级")
    end

    local Gender = lualib:Gender(player)
    local award_item = {"布衣(男)", "布衣(女)"}
    if not lualib:AddItem(player, award_item[Gender], 1, true, "", "") then
        lualib:SysTriggerMsg(player, "赠送布衣失败！")
    end
    lualib:ApplyEquipEx(player,"木剑")
    lualib:ApplyEquipEx(player,award_item[Gender])
    local player_name = lualib:Name(player)
    lualib:SysMsg_SendBroadcastMsg("玩家【"..player_name.."】加入游戏,为饕餮神途新添了一份力量", "[系统提示]")
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
            lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#╔──────═──────═──────═──────═──────╗#COLOREND#", 7, 11)
            lualib:SysMsg_SendBottomColor(player, tip, 7, 11)

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

            lualib:SysMsg_SendBottomColor(player, tip2, 2, 11)
            lualib:SysMsg_SendBottomColor(player, "     #COLORCOLOR_ORANGE#╚──────═──────═──────═──────═──────╝#COLOREND#", 7, 11)

            lualib:SysMsg_SendBoardMsg(player, "补充安全资料",  "\n#COLORCOLOR_GREENG##UILINK<WND:提交表单,PARAM:小贴士;web;player,STR:请点我进入网站补充账号安全资料##COLOREND#", 10000)
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

function on_post_equip(player, item)
    local itemName = lualib:KeyName(item)
    if itemName == "麻痹戒指" then
        lualib:AddTrigger(player, lua_trigger_damage_process, "damage_process")
    elseif itemName == "隐身戒指" then
        lualib:AddBuff(player, "隐身戒指", 20000000)
    end
    return true
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

function on_billinex(id, yb, qita)
    lualib:SetDBNumEx("lixian_chongzhi_"..id,  lualib:GetDBNum("lixian_chongzhi_"..id) + yb, 4)
    lualib:SetDBNumEx("define_bill"..id,  lualib:GetDBNum("define_bill"..id) + yb, 4)

end


function on_trigger_billin(player, yb)
    local name = lualib:Name(player)
    lualib:SysWarnMsg(player, "你充值了"..yb.."元宝")
    lualib:SysMsg_SendBroadcastMsg("恭喜"..name.."在线充值获得" .. yb ..  "元宝，如果你也想要请点击屏幕右下角商铺进行充值","[充值提示]")
end


buxuisz = {
    --沃玛
    ["红宝石戒指"] = {200, 0, 200,  0,  1},
    ["思贝儿手镯"] = {200, 0, 200,  0,  1},
    ["心灵手镯"] = {200, 0, 200,  0,  1},
    ["阎罗手套"] = {200, 0, 200,  0,  1},
    ["生命项链"] = {200, 0, 200,  0,  1},
    ["天珠项链"] = {200, 0, 200,  0,  1},
    ["幽灵项链"] = {200, 0, 200,  0,  1},
    ["龙之戒指"] = {200, 0, 200,  0,  1},
    ["铂金戒指"] = {200, 0, 200,  0,  1},
    ["井中月"] = {200, 0, 200,  0,  1},
    ["无极棍"] = {200, 0, 200,  0,  1},
    ["魔杖"] = {200, 0, 200,  0,  1},


    --祖玛
    ["恶魔铃铛"] = {2000, 0, 500,  2,  2},
    ["龙之手镯"] = {2000, 0, 500,  2,  2},
    ["紫碧螺"] = {2000, 0, 500,  2,  2},
    ["力量戒指"] = {2000, 0, 500,  2,  2},
    ["骑士手镯"] = {2000, 0, 500,  2,  2},
    ["绿色项链"] = {2000, 0, 500,  2,  2},
    ["灵魂项链"] = {2000, 0, 500,  2,  2},
    ["泰坦戒指"] = {2000, 0, 500,  2,  2},
    ["黑铁头盔"] = {2000, 0, 500,  2,  2},
    ["三眼手镯"] = {2000, 0, 500,  2,  2},
    ["裁决之杖"] = {2000, 0, 500,  2,  2},
    ["龙纹剑"] = {2000, 0, 500,  2,  2},
    ["骨玉权杖"] = {2000, 0, 500,  2,  2},
    ["战神盔甲(男)"] = {2000, 0, 500,  2,  2},
    ["战神盔甲(女)"] = {2000, 0, 500,  2,  2},
    ["恶魔长袍(男)"] = {2000, 0, 500,  2,  2},
    ["恶魔长袍(女)"] = {2000, 0, 500,  2,  2},
    ["幽灵战衣(男)"] = {2000, 0, 500,  2,  2},
    ["幽灵战衣(女)"] = {2000, 0, 500,  2,  2},


    --赤月

    ["圣战头盔"] = {10000, 0, 2000,  20,  3},
    ["圣战项链"] = {10000, 0, 2000,  20,  3},
    ["圣战手镯"] = {10000, 0, 2000,  20,  3},
    ["圣战戒指"] = {10000, 0, 2000,  20,  3},
    ["圣战之靴"] = {10000, 0, 2000,  20,  3},
    ["圣战腰带"] = {10000, 0, 2000,  20,  3},
    ["天尊头盔"] = {10000, 0, 2000,  20,  3},
    ["天尊项链"] = {10000, 0, 2000,  20,  3},
    ["天尊手镯"] = {10000, 0, 2000,  20,  3},
    ["天尊戒指"] = {10000, 0, 2000,  20,  3},
    ["天尊之靴"] = {10000, 0, 2000,  20,  3},
    ["天尊腰带"] = {10000, 0, 2000,  20,  3},
    ["法神头盔"] = {10000, 0, 2000,  20,  3},
    ["法神项链"] = {10000, 0, 2000,  20,  3},
    ["法神手镯"] = {10000, 0, 2000,  20,  3},
    ["法神戒指"] = {10000, 0, 2000,  20,  3},
    ["法神之靴"] = {10000, 0, 2000,  20,  3},
    ["法神腰带"] = {10000, 0, 2000,  20,  3},
    ["天魔神甲"] = {10000, 0, 2000,  20,  3},
    ["圣战宝甲"] = {10000, 0, 2000,  20,  3},
    ["怒斩"] = {10000, 0, 2000,  20,  3},
    ["天尊道袍"] = {10000, 0, 2000,  20,  3},
    ["天师长袍"] = {10000, 0, 2000,  20,  3},
    ["龙牙"] = {10000, 0, 2000,  20,  3},
    ["法神披风"] = {10000, 0, 2000,  20,  3},
    ["霓裳羽衣"] = {10000, 0, 2000,  20,  3},
    ["霸者之刃"] = {10000, 0, 2000,  20,  3},
    ["未开光的天师圣袍"] = {200, 0, 200,  0,  1},
    ["未开光的圣尊道袍"] = {200, 0, 200,  0,  1},
    ["未开光的霸王之刃"] = {200, 0, 200,  0,  1},
    ["未开光的天尊之盔"] = {200, 0, 200,  0,  1},
    ["未开光的天尊之链"] = {200, 0, 200,  0,  1},
    ["未开光的天尊之镯"] = {200, 0, 200,  0,  1},
    ["未开光的天尊之戒"] = {200, 0, 200,  0,  1},
    ["未开光的天尊之靴"] = {200, 0, 200,  0,  1},
    ["未开光的天尊腰带"] = {200, 0, 200,  0,  1},
    ["未开光的霓裳衣"] = {200, 0, 200,  0,  1},
    ["未开光的法圣魔袍"] = {200, 0, 200,  0,  1},
    ["未开光的龙魄"] = {200, 0, 200,  0,  1},
    ["未开光的法神之盔"] = {200, 0, 200,  0,  1},
    ["未开光的法神之链"] = {200, 0, 200,  0,  1},
    ["未开光的法神之镯"] = {200, 0, 200,  0,  1},
    ["未开光的法神之戒"] = {200, 0, 200,  0,  1},
    ["未开光的法神之靴"] = {200, 0, 200,  0,  1},
    ["未开光的法神腰带"] = {200, 0, 200,  0,  1},
    ["未开光的邪魔神甲"] = {200, 0, 200,  0,  1},
    ["未开光的圣武宝甲"] = {200, 0, 200,  0,  1},
    ["未开光的狂斩"] = {200, 0, 200,  0,  1},
    ["未开光的圣战之盔"] = {200, 0, 200,  0,  1},
    ["未开光的圣战之链"] = {200, 0, 200,  0,  1},
    ["未开光的圣战之镯"] = {200, 0, 200,  0,  1},
    ["未开光的圣战之戒"] = {200, 0, 200,  0,  1},
    ["未开光的圣战之靴"] = {200, 0, 200,  0,  1},
    ["未开光的圣战腰带"] = {200, 0, 200,  0,  1},

    --雷霆
    ["烈焰护腕"] = {50000, 0, 5000,  200,  4},
    ["烈焰头盔"] = {50000, 0, 5000,  200,  4},
    ["烈焰魔戒"] = {50000, 0, 5000,  200,  4},
    ["烈焰项链"] = {50000, 0, 5000,  200,  4},
    ["烈焰魔靴"] = {50000, 0, 5000,  200,  4},
    ["烈焰腰带"] = {50000, 0, 5000,  200,  4},
    ["光芒护腕"] = {50000, 0, 5000,  200,  4},
    ["光芒头盔"] = {50000, 0, 5000,  200,  4},
    ["光芒道戒"] = {50000, 0, 5000,  200,  4},
    ["光芒项链"] = {50000, 0, 5000,  200,  4},
    ["光芒道靴"] = {50000, 0, 5000,  200,  4},
    ["光芒腰带"] = {50000, 0, 5000,  200,  4},
    ["雷霆战靴"] = {50000, 0, 5000,  200,  4},
    ["雷霆护腕"] = {50000, 0, 5000,  200,  4},
    ["雷霆头盔"] = {50000, 0, 5000,  200,  4},
    ["雷霆战戒"] = {50000, 0, 5000,  200,  4},
    ["雷霆项链"] = {50000, 0, 5000,  200,  4},
    ["雷霆腰带"] = {50000, 0, 5000,  200,  4},
    ["烈焰魔衣(男)"] = {50000, 0, 5000,  200,  4},
    ["烈焰魔衣(女)"] = {50000, 0, 5000,  200,  4},
    ["光芒道袍(男)"] = {50000, 0, 5000,  200,  4},
    ["光芒道袍(女)"] = {50000, 0, 5000,  200,  4},
    ["雷霆战甲(男)"] = {50000, 0, 5000,  200,  4},
    ["雷霆战甲(女)"] = {50000, 0, 5000,  200,  4},
    ["屠龙"] = {50000, 0, 5000,  200,  4},
    ["嗜魂法杖"] = {50000, 0, 5000,  200,  4},
    ["逍遥扇"] = {50000, 0, 5000,  200,  4},
    ["未开光的光芒头盔"] = {200, 0, 200,  0,  1},
    ["未开光的光芒之链"] = {200, 0, 200,  0,  1},
    ["未开光的光芒之腕"] = {200, 0, 200,  0,  1},
    ["未开光的光芒之戒"] = {200, 0, 200,  0,  1},
    ["未开光的光芒靴子"] = {200, 0, 200,  0,  1},
    ["未开光的光芒之带"] = {200, 0, 200,  0,  1},
    ["未开光的光芒斗袍(男)"] = {200, 0, 200,  0,  1},
    ["未开光的光芒斗袍(女)"] = {200, 0, 200,  0,  1},
    ["未开光的逍遥道扇"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰之链"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰之腕"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰之戒"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰头盔"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰之靴"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰之带"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰斗衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的烈焰斗衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的嗜魂魔杖"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆之腰"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆头盔"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆之链"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆之腕"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆之戒"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆之靴"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆斗甲(男)"] = {200, 0, 200,  0,  1},
    ["未开光的雷霆斗甲(女)"] = {200, 0, 200,  0,  1},
    ["未开光的霸天"] = {200, 0, 200,  0,  1},

    --战神
    ["玄天"] = {100000, 0, 10000,  600,  5},
    ["真魂头盔"] = {100000, 0, 10000,  600,  5},
    ["真魂项链"] = {100000, 0, 10000,  600,  5},
    ["真魂护腕"] = {100000, 0, 10000,  600,  5},
    ["真魂道戒"] = {100000, 0, 10000,  600,  5},
    ["真魂道靴"] = {100000, 0, 10000,  600,  5},
    ["真魂腰带"] = {100000, 0, 10000,  600,  5},
    ["真魂道袍(男)"] = {100000, 0, 10000,  600,  5},
    ["真魂道袍(女)"] = {100000, 0, 10000,  600,  5},
    ["镇天"] = {100000, 0, 10000,  600,  5},
    ["圣魔头盔"] = {100000, 0, 10000,  600,  5},
    ["圣魔项链"] = {100000, 0, 10000,  600,  5},
    ["圣魔护腕"] = {100000, 0, 10000,  600,  5},
    ["圣魔魔戒"] = {100000, 0, 10000,  600,  5},
    ["圣魔腰带"] = {100000, 0, 10000,  600,  5},
    ["圣魔魔靴"] = {100000, 0, 10000,  600,  5},
    ["圣魔魔衣(男)"] = {100000, 0, 10000,  600,  5},
    ["圣魔魔衣(女)"] = {100000, 0, 10000,  600,  5},
    ["开天"] = {100000, 0, 10000,  600,  5},
    ["战神头盔"] = {100000, 0, 10000,  600,  5},
    ["战神腰带"] = {100000, 0, 10000,  600,  5},
    ["战神项链"] = {100000, 0, 10000,  600,  5},
    ["战神护腕"] = {100000, 0, 10000,  600,  5},
    ["战神战戒"] = {100000, 0, 10000,  600,  5},
    ["战神战靴"] = {100000, 0, 10000,  600,  5},
    ["战神战甲(男)"] = {100000, 0, 10000,  600,  5},
    ["战神战甲(女)"] = {100000, 0, 10000,  600,  5},
    ["未开光的真魂道服(女)"] = {200, 0, 200,  0,  1},
    ["未开光的真魂道服(男)"] = {200, 0, 200,  0,  1},
    ["未开光的真魂之带"] = {200, 0, 200,  0,  1},
    ["未开光的真魂靴子"] = {200, 0, 200,  0,  1},
    ["未开光的真魂道戒"] = {200, 0, 200,  0,  1},
    ["未开光的真魂护腕"] = {200, 0, 200,  0,  1},
    ["未开光的真魂之链"] = {200, 0, 200,  0,  1},
    ["未开光的真魂头盔"] = {200, 0, 200,  0,  1},
    ["未开光的泫天"] = {200, 0, 200,  0,  1},
    ["未开光的震天"] = {200, 0, 200,  0,  1},
    ["未开光的斩天"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔法衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔法衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔头盔"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔之带"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔靴子"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔魔戒"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔护腕"] = {200, 0, 200,  0,  1},
    ["未开光的圣魔之链"] = {200, 0, 200,  0,  1},
    ["未开光的战神战袍(女)"] = {200, 0, 200,  0,  1},
    ["未开光的战神战袍(男)"] = {200, 0, 200,  0,  1},
    ["未开光的战神靴子"] = {200, 0, 200,  0,  1},
    ["未开光的战神战戒"] = {200, 0, 200,  0,  1},
    ["未开光的战神护腕"] = {200, 0, 200,  0,  1},
    ["未开光的战神之链"] = {200, 0, 200,  0,  1},
    ["未开光的战神之带"] = {200, 0, 200,  0,  1},
    ["未开光的战神头盔"] = {200, 0, 200,  0,  1},

    --星王：
    ["星王道剑"] = {200000, 0, 20000,  800,  6},
    ["星王道靴"] = {200000, 0, 20000,  800,  6},
    ["星王道腰"] = {200000, 0, 20000,  800,  6},
    ["星王道链"] = {200000, 0, 20000,  800,  6},
    ["星王道镯"] = {200000, 0, 20000,  800,  6},
    ["星王道戒"] = {200000, 0, 20000,  800,  6},
    ["星王道盔"] = {200000, 0, 20000,  800,  6},
    ["星王道衣(女)"] = {200000, 0, 20000,  800,  6},
    ["星王道衣(男)"] = {200000, 0, 20000,  800,  6},
    ["星王法杖"] = {200000, 0, 20000,  800,  6},
    ["星王法腰"] = {200000, 0, 20000,  800,  6},
    ["星王法靴"] = {200000, 0, 20000,  800,  6},
    ["星王法链"] = {200000, 0, 20000,  800,  6},
    ["星王法镯"] = {200000, 0, 20000,  800,  6},
    ["星王法戒"] = {200000, 0, 20000,  800,  6},
    ["星王法盔"] = {200000, 0, 20000,  800,  6},
    ["星王魔袍(女)"] = {200000, 0, 20000,  800,  6},
    ["星王魔袍(男)"] = {200000, 0, 20000,  800,  6},
    ["星王战刃"] = {200000, 0, 20000,  800,  6},
    ["星王战靴"] = {200000, 0, 20000,  800,  6},
    ["星王战盔"] = {200000, 0, 20000,  800,  6},
    ["星王战腰"] = {200000, 0, 20000,  800,  6},
    ["星王战链"] = {200000, 0, 20000,  800,  6},
    ["星王战镯"] = {200000, 0, 20000,  800,  6},
    ["星王战戒"] = {200000, 0, 20000,  800,  6},
    ["星王战衣(女)"] = {200000, 0, 20000,  800,  6},
    ["星王战衣(男)"] = {200000, 0, 20000,  800,  6},
    ["未开光的星王战甲(男)"] = {200, 0, 200,  0,  1},
    ["未开光的星王战衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的星王战戒"] = {200, 0, 200,  0,  1},
    ["未开光的星王战镯"] = {200, 0, 200,  0,  1},
    ["未开光的星王战链"] = {200, 0, 200,  0,  1},
    ["未开光的星王战腰"] = {200, 0, 200,  0,  1},
    ["未开光的星王战盔"] = {200, 0, 200,  0,  1},
    ["未开光的星王战靴"] = {200, 0, 200,  0,  1},
    ["未开光的星王战刃"] = {200, 0, 200,  0,  1},
    ["未开光的星王魔袍(男)"] = {200, 0, 200,  0,  1},
    ["未开光的星王魔袍(女)"] = {200, 0, 200,  0,  1},
    ["未开光的星王法盔"] = {200, 0, 200,  0,  1},
    ["未开光的星王法戒"] = {200, 0, 200,  0,  1},
    ["未开光的星王法镯"] = {200, 0, 200,  0,  1},
    ["未开光的星王法链"] = {200, 0, 200,  0,  1},
    ["未开光的星王法靴"] = {200, 0, 200,  0,  1},
    ["未开光的星王法腰"] = {200, 0, 200,  0,  1},
    ["未开光的星王法杖"] = {200, 0, 200,  0,  1},
    ["未开光的星王道衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的星王道衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的星王道盔"] = {200, 0, 200,  0,  1},
    ["未开光的星王道戒"] = {200, 0, 200,  0,  1},
    ["未开光的星王道镯"] = {200, 0, 200,  0,  1},
    ["未开光的星王道链"] = {200, 0, 200,  0,  1},
    ["未开光的星王道腰"] = {200, 0, 200,  0,  1},
    ["未开光的星王道靴"] = {200, 0, 200,  0,  1},
    ["未开光的星王道剑"] = {200, 0, 200,  0,  1},

    --狂雷：
    ["未开光的狂雷战衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战戒"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战镯"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战链"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战腰"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战盔"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战靴"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷战刃"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷魔袍(男)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷魔袍(女)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法盔"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法戒"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法镯"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法链"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法靴"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法腰"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷法杖"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道盔"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道戒"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道镯"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道链"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道腰"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道靴"] = {200, 0, 200,  0,  1},
    ["未开光的狂雷道剑"] = {200, 0, 200,  0,  1},

    --火龙：
    ["未开光的火龙战衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战戒"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战镯"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战链"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战腰"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战盔"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战靴"] = {200, 0, 200,  0,  1},
    ["未开光的火龙战刃"] = {200, 0, 200,  0,  1},
    ["未开光的火龙魔袍(男)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙魔袍(女)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法盔"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法戒"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法镯"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法链"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法靴"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法腰"] = {200, 0, 200,  0,  1},
    ["未开光的火龙法杖"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道衣(男)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道衣(女)"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道盔"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道戒"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道镯"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道链"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道腰"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道靴"] = {200, 0, 200,  0,  1},
    ["未开光的火龙道剑"] = {200, 0, 200,  0,  1},
}

--装备首爆
local zb_shoubao = {
    {"雷霆腰带", 1000, 2},  --道具索引  元宝数  首爆次数
    {"雷霆头盔", 1000, 2},
    {"雷霆项链", 1000, 2},
    {"雷霆护腕", 1000, 2},
    {"雷霆战戒", 2000, 2},
    {"雷霆战靴", 2000, 2},
}

function on_post_drop_one(map, role, item,id)
    local item_key = lualib:KeyName(item);
    local data = lualib:Item_DataRow(item_key);
    local player = lualib:ItemRole(item)
    for i = 1, #zb_shoubao do
        if zb_shoubao[i][1] == item_key then
            if zb_shoubao[i][3] - lualib:GetDBNum("首爆累积"..item_key) > 0 and lualib:GetInt(player, "首爆_"..item_key) == 0 then
                if lualib:Monster_IsMonster(role) then
                    lualib:SetInt(player, "首爆_"..item_key, 1)
                    lualib:SetDBNumEx("首爆累积"..item_key, lualib:GetDBNum("首爆累积"..item_key) + 1, 4)
                    lualib:AddIngot(player, zb_shoubao[i][2], "添加元宝:原因", "发起者")
                    lualib:SysMsg_SendBroadcastMsg("玩家["..lualib:Name(player).."]首爆出【“"..lualib:Name(item).."”】！获得了"..zb_shoubao[i][2].."元宝！", "系统消息")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(player).."]首爆出【“"..lualib:Name(item).."”】！获得了"..zb_shoubao[i][2].."元宝！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(player).."]首爆出【“"..lualib:Name(item).."”】！获得了"..zb_shoubao[i][2].."元宝！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(player).."]首爆出【“"..lualib:Name(item).."”】！获得了"..zb_shoubao[i][2].."元宝！","")
                    lualib:SysMsg_SendCenterMsg(1, "玩家["..lualib:Name(player).."]首爆出【“"..lualib:Name(item).."”】！获得了"..zb_shoubao[i][2].."元宝！","")
                    if lualib:GetDBNum("首爆累积"..item_key) == 1 then
                        lualib:SetDBStrEx("首爆名称"..zb_shoubao[i][1], lualib:Name(player), 1)
                    elseif lualib:GetDBNum("首爆累积"..item_key) <= 2 then
                        lualib:SetDBStrEx("首爆名称"..zb_shoubao[i][1], lualib:GetDBStr("首爆名称"..zb_shoubao[i][1]).."‖"..lualib:Name(player), 1)
                    end
                end
            end
        end
    end




    --local isTip = data.TipDrop;
    local isTip = data.Type;
    if isTip == 1 then
        local map_name = lualib:Name(map);
        local item_name = lualib:Name(item);
        local item_x = lualib:X(item);
        local item_y = lualib:Y(item);
        if item_x < 10000 and item_y < 10000 and buxuisz[item_key] ~= nil then
            --lualib:SysMsg_SendBroadcastColor("#IMAGE1900300001##COLORCOLOR_BROWN#["..item_name.."] #COLORCOLOR_YELLOW#掉落在#COLORCOLOR_BROWN#["..map_name.."]#COLORCOLOR_YELLOW#的["..item_x..","..item_y.."]附近！", "", 1, 12);
            local color = "WHITE";
            local drophost = lualib:ItemDropHost(item)
            if lualib:Monster_IsMonster(drophost) then

                local s = "["..item_name.."]掉在["..map_name.."]（"..item_x..":"..item_y.."）处！"
                --local s = "@COLORCOLOR_PINK@【提示】@COLORCOLOR_BLUE@物品@COLORCOLOR_RED@["..item_name.."]@COLORCOLOR_BLUE@掉落在@COLORCOLOR_YELLOW@["..map_name.."]@COLORCOLOR_ORANGE@的["..item_x..","..item_y.."]！"
                发送全区消息(s, "GREENG","YELLOW" )

                --local s = "@COLORCOLOR_RED@【提示】@COLORCOLOR_BROWN@["..item_name.."]@COLORCOLOR_YELLOW@从怪物@COLORCOLOR_MAGENTA@["..lualib:Name(drophost).."]@COLORCOLOR_YELLOW@身上掉落在@COLORCOLOR_BROWN@["..map_name.."]@COLORCOLOR_YELLOW@的["..item_x..","..item_y.."]附近！"
                --发送全区消息(s, color)



            elseif lualib:Player_IsPlayer(drophost) then

                local s = "["..item_name.."]掉在["..map_name.."]（"..item_x..":"..item_y.."）处！"
                发送全区消息(s, "GREENG","YELLOW" )

                --local s = "@COLORCOLOR_RED@【提示】@COLORCOLOR_BROWN@["..item_name.."]@COLORCOLOR_YELLOW@从玩家@COLORCOLOR_MAGENTA@["..lualib:Name(drophost).."]@COLORCOLOR_YELLOW@身上掉落在@COLORCOLOR_BROWN@["..map_name.."]@COLORCOLOR_YELLOW@的["..item_x..","..item_y.."]附近！"
                --发送全区消息(s, color)

            end


            --local str = "GameMainBar.SendMsg(\""..s.."\", \""..color.."\")";
            --lualib:ShowFormWithContent(player, "脚本表单", str);
        end
    end




end


function on_captcha_result(Player,result,reason)
    if result==0 then
        lualib:ProgressBarStart(Player, 3000, "正在打开宝箱", "dakai_true", "dakai_false", lualib:GetDayStr(Player,"qiyubaoxiang"))
    end
end
function dakai_true(player, npc)
    local item = {
        {"100元宝",10000, 1},
        {"200元宝",6000, 1},
        {"500元宝",1000, 1},
        {"1000元宝",5000, 1},
        {"3000元宝",200, 1},
        {"5000元宝",50, 1},
        {"10000元宝",20, 1},
        {"30000元宝",10, 1},
        {"50000元宝",5, 1},
    }
    local distance = lualib:Map_GetDistance(lualib:Player_GetPosX(player), lualib:Player_GetPosY(player), lualib:Npc_GetPosX(npc), lualib:Npc_GetPosY(npc))
    if distance > 2 then
        return ""
    end
    local max, pr_y = 0, 0
    for i=1,#item do
        max = max + item[i][2]
    end
    local r = lualib:GenRandom(1, max)
    for _, v in pairs(item) do
        pr_y = pr_y + v[2]
        if r <= pr_y then
            local item_k = v[1]
            lualib:GiveItem(player, item_k,  v[3], "给予道具:神秘宝盒给予", "发起人")
            lualib:SysMsg_SendBroadcastColor(lualib:Name(player).."打开了奇遇宝箱，获得了"..item_k.."！", "系统公告", 2, 7)
            lualib:Npc_Remove(npc)
            return ""
        end
    end
    lualib:SetDayStr(player,"qiyubaoxiang","")
end



--被打断
function dakai_false(player, npc)
    lualib:SetDayStr(player,"qiyubaoxiang","")
    lualib:SysMsg_SendBottomColor(player, "打开宝箱被打断。", 2, 7)
end
local T_Buff={
    [93]="怪物麻痹3秒",
    [1018]="狮子吼",
    [94]="怪物眩晕3秒",
}
function on_add_buff(role,id,strHost)
    if lualib:Monster_IsMonster(role) then
        if lualib:Monster_Type(lualib:KeyName(role))==4 then
            if T_Buff[id]~=nil then
                lualib:DelBuff(role,T_Buff[id])
            end
        end
    end
end
function on_monster_born(monster)
    if lualib:Monster_Type(lualib:KeyName(monster))==4 then
        lualib:AddTimer(monster,345,10000,-1,"Blame_blood")
    end
end
function Blame_blood(monster,id)
    if lualib:Monster_GetAttackTarget(monster)=="" then
        lualib:SetHp(monster,lualib:Hp(monster,true),false)
    end
end
function on_post_player_die(Player,Killer)
    local Killer_player=""
    if lualib:Player_IsPlayer(Killer) then
        Killer_player=Killer
    else
        if lualib:Monster_GetMaster(Killer)~="" then
            Killer_player=lualib:Name2Guid(lualib:Monster_GetMaster(Killer))
        end
    end
    if Killer_player~="" then
        lualib:SetInt(Killer_player,"Kill_player",lualib:GetInt(Killer_player,"Kill_player")+1)
        lualib:SetInt(Player,"Was_killed",lualib:GetInt(Player,"Was_killed")+1)
        lualib:SetStr(Player,"_na_","杀人"..lualib:GetInt(Player,"Kill_player").."次,被杀"..lualib:GetInt(Player,"Was_killed").."次")
        lualib:SetStr(Killer_player,"_na_","杀人"..lualib:GetInt(Killer_player,"Kill_player").."次,被杀"..lualib:GetInt(Killer_player,"Was_killed").."次")
        lualib:NotifyVar(Player,"_na_")
        lualib:NotifyVar(Killer_player,"_na_")
    end
end

function flush_phb(id, timer_id)
    local flush_time1 = "00:01:00"
    local flush_time2 = "00:05:00"
    local now_time = lualib:Now()
    local time_s = lualib:Str2Time(now_time)
    local time_string = lualib:Time2Str("%H:%M:%S",time_s)
    --lualib:SysMsg_SendBroadcastMsg(tostring(time_string),"s" )

    if flush_time1 ~= time_string and flush_time2 ~= time_string then
        return true
    end
    lualib:SetDBStrEx("魔族排行榜JSON1",lualib:GetDBStr("魔族排行榜JSON"),6)
    lualib:SetDBStrEx("神族排行榜JSON1",lualib:GetDBStr("神族排行榜JSON"),6)
    return ""
end

function changeFamilyTitle(player,timer_id)
    local country = lualib:GetStr(player,"countryName")
    local jsonStr = lualib:GetDBStr(country.."排行榜JSON1")
    local tb = {}
    if jsonStr == "" then
        tb = {}
    else
        tb = json.decode(jsonStr)
    end
    for i,v in pairs(tb) do
        if v.name == player then
            local str = lualib:GetFamilyTitle(player)
            --lualib:SysMsg_SendBroadcastMsg(tostring(str), "se")
            lualib:ChangeFamilyTitle(player,country,i,"","")
        end
    end
    return ""
end

local equip_weizhi = {[1]={1},[2]={2},[3]={3,4},[4]={5},[5]={6},[6]={7},[7]={8},[8]={9},[9]={10,11},[10]={12},[11]={13},[12]={14},[13]={15},[14]={16},[15]={17},[16]={18},[18]={20},[28]={420},[29]={421},[30]={422},[31]={423}}
--角色拾取道具时回调
function on_item_pickup(player, item, item_id, item_name)
    local type = lualib:Item_GetType("",item)
    local sub_type = lualib:Item_GetSubType("",item)
    local gender = lualib:Gender(player)
    local job = lualib:Job(player)
    local country = lualib:GetStr(player,"countryName")
    --lualib:SysMsg_SendBroadcastMsg(tostring(item_name..":"..type), "type")
    --lualib:SysMsg_SendBroadcastMsg(tostring(item_name..":"..sub_type), "item")
    if type == 1 then
        if equip_weizhi[sub_type] ~= nil then

            if string.match(item_name,"魔族") == "魔族" and country ~= "魔族" then
                return ""
            end
            if string.match(item_name,"神族") == "神族" and country ~= "神族" then
                return ""
            end
            local peizhi_t1 = lualib:Item_DataRow(item_name)
            local item_gender = peizhi_t1["Gender"]
            --lualib:SysMsg_SendBroadcastMsg(tostring(item_gender.."---"..gender), "item_gender")

            local item_job = peizhi_t1["Job"]
            --lualib:SysMsg_SendBroadcastMsg(tostring(item_job.."---"..job), "Job")
            if item_gender ~= 0 and item_gender ~= gender then
                return ""
            end
            if item_job ~= 0 and item_job ~= job then
                return ""
            end
            -- local date = "%d"
            --local new_pinzhi = tonumber(string.sub(item_name, string.find(item_name, date)))
            local new_pinzhi = peizhi_t1["Quality"]
            --lualib:SysMsg_SendBroadcastMsg(tostring(item_name..":"..new_pinzhi), "品质")

            for k, v in pairs(equip_weizhi[sub_type]) do
                local old_guid = lualib:Player_GetItemGuid(player,v)
                if old_guid ~= "" and old_guid ~= nil then
                    local old_nane = lualib:KeyName(old_guid)
                    --lualib:SysMsg_SendBroadcastMsg(tostring(old_nane), "oldname")
                    local peizhi_t2 = lualib:Item_DataRow(old_nane)
                    --local date = "%d"
                    --local old_pinzhi = tonumber(string.sub(old_nane, string.find(old_nane, date)))
                    local old_pinzhi = peizhi_t2["Quality"]
                    --lualib:SysMsg_SendBroadcastMsg(tostring(old_pinzhi), "old_pinzhi")
                    if new_pinzhi > old_pinzhi then
                        --传递
                        lualib:Player_RunScript(player,"装备替换提示表单:zhuangbeitihaun",item.."&"..v)
                        --lualib:DelayCall("0", 60000, "攻城奖励:SmartCastleWar", "")
                        break
                    end
                else
                    lualib:Player_RunScript(player,"装备替换提示表单:zhuangbeitihaun",item.."&"..v)
                end
            end

        end
    end
end

function on_pre_equip(player,item,item_id,item_key)
    local country = lualib:GetStr(player,"countryName")
    if string.match(item_key,"魔族") == "魔族" and country ~= "魔族" then
        return false
    end
    if string.match(item_key,"神族") == "神族" and country ~= "神族" then
        return false
    end
    return true
end



function on_pre_harm(player, killer, hp, defense, skill_key,isBurst)  --被11攻击者，攻击者，血量（正加负扣），防御值，技能，暴击)

    if skill_key == "野火燎原1重" or skill_key == "野火燎原2重" or skill_key == "野火燎原3重" or skill_key == "野火燎原4重" or skill_key == "野火燎原5重" or skill_key == "野火燎原6重" or skill_key == "野火燎原7重" or skill_key == "野火燎原8重" or skill_key == "野火燎原9重" or skill_key == "野火燎原10重" or skill_key == "野火燎原11重" or skill_key == "野火燎原12重" then
        local cishujishu = yehuoliaoyuanbiaodan[skill_key][1]
        local hashorse = lualib:Attr(killer, 12)

        local cishu = math.ceil(hashorse / cishujishu)

        local hashorse1 = tostring(hashorse)
        if lualib:Player_IsPlayer(player) then
            lualib:AddTimerEx(player,201192,500,cishu,"yehuoliaoyuan",hashorse1.."#"..killer)
            return false
        end
        lualib:AddTimerEx(player,20119,500,cishu,"yehuoliaoyuan1",hashorse1.."#"..killer)

    end

    if skill_key == "暴雨梨花1重" or skill_key == "暴雨梨花2重" or skill_key == "暴雨梨花3重" or skill_key == "暴雨梨花4重" or skill_key == "暴雨梨花5重" or skill_key == "暴雨梨花6重" or skill_key == "暴雨梨花7重" or skill_key == "暴雨梨花8重" or skill_key == "暴雨梨花9重" or skill_key == "暴雨梨花10重" or skill_key == "暴雨梨花11重" or skill_key == "暴雨梨花12重" then

        local daoshu = lualib:Attr(killer, 14)
        local daoshu1 = tostring(daoshu)
        if lualib:Player_IsPlayer(player) then
            lualib:AddTimerEx(player,92623111,800,3,"baoyuwanjia",daoshu1.."#"..skill_key.."#"..killer)
            return false
        end
        lualib:AddTimerEx(player,92622332,800,3,"baoyuguaiwu",daoshu1.."#"..killer)
    end

    local kill_tab = {"天神附体1","天神附体2","天神附体3","天神附体4","天神附体5","天神附体6","天神附体7","天神附体8","天神附体9","天神附体10","天神附体11","天神附体12"}
    if lualib:HasBuff(player,"聚怒冲锋debuff") then
        lualib:SetIsBrust(player,true)
    end

    for i=1,#kill_tab do
        local kill_key = kill_tab[i]
        if lualib:HasBuff(killer,kill_key)  then

            local gailv =  lualib:GenRandom(1, 100)
            if gailv <= 30 then
                local gongji = lualib:Attr(killer,10)
                local shanghai = gongji * 1.5

                local cur_hp = lualib:Hp(player, false)
                if shanghai > cur_hp then
                    lualib:AddBuff(player, "死亡", 2)
                    return false
                end

                lualib:AddBuff(player, "天神压顶", 3)

                lualib:SetHp(player, cur_hp - shanghai, false)
                lualib:ShowRoleHPRefEx("",player,-shanghai,3)
            end

        end
    end
    return hp
end

local yehuoliaoyuanbiaodan = {
    ["野火燎原1重"] = {70},
    ["野火燎原2重"] = {68},
    ["野火燎原3重"] = {66},
    ["野火燎原4重"] = {64},
    ["野火燎原5重"] = {62},
    ["野火燎原6重"] = {60},
    ["野火燎原7重"] = {58},
    ["野火燎原8重"] = {56},
    ["野火燎原9重"] = {54},
    ["野火燎原10重"] = {52},
    ["野火燎原11重"] = {50},
    ["野火燎原12重"] = {48},
}


function yehuoliaoyuan(player,id,hashorse1,skill_key,killer)

    if lualib:HasBuff(player,"冰封炸裂") == true then
        lualib:SysWarnMsg(player,"冰冻状态无法收到额外伤害")
        lualib:DisableTimer(player,201192)
        return false

    end


    local hashorse = tonumber(hashorse1)
    local cur_hp = lualib:Hp(player, false)
    local mofang = lualib:Attr(player, 8)  -- 魔防
    local momian = lualib:Attr(player, 122)  -- 魔免
    local mianshang = 100 - momian
    local momianxishu = mianshang / 100
    local mofang2 = mofang / 2
    local zuizhongshanghai = hashorse  - mofang2
    local wanmeishanghai = math.ceil(zuizhongshanghai * momianxishu)
    if wanmeishanghai > cur_hp then
        lualib:Kill(player)
        lualib:SysWarnMsg(player,tostring(cur_hp))
        local current_pk = lualib:Pk(killer)
        local kill_pk = lualib:SetPk(killer, current_pk+90)
        lualib:SysWarnMsg(killer, "PK值上升")
        local killnotice1 = "千里传音玩家：#COLORCOLOR_BROWN#["..lualib:KeyName(killer).."]#COLORCOLOR_YELLOW#将→→#COLORCOLOR_BROWN#["..lualib:KeyName(player).."]#COLORCOLOR_YELLOW#击杀，强力围观中！！！"
        lualib:SysMsg_SendBroadcastColor(killnotice1, "", 1, 12)
        lualib:DisableTimer(player,201192)
        return false
    end
    lualib:AddBuff(player, "野火燎原", 1)
    lualib:SetHp(player, cur_hp - wanmeishanghai, false)
    lualib:ShowRoleHPRefEx("",player,-wanmeishanghai,3)


end



function yehuoliaoyuan1(player,id,hashorse1,killer)
    local hashorse = tonumber(hashorse1)
    local cur_hp1 = lualib:Hp(player, false)

    if hashorse > cur_hp1 then
        lualib:AddBuff(player, "死亡", 2)
        lualib:DisableTimer(player,20119)
        return false
    end
    lualib:AddBuff(player, "野火燎原", 2)
    lualib:SetHp(player, cur_hp1 - hashorse, false)
    lualib:ShowRoleHPRefEx("",player,-hashorse,3)
end



local baoyuliehua = {
    ["暴雨梨花1重"] = {1},
    ["暴雨梨花2重"] = {1.1},
    ["暴雨梨花3重"] = {1.2},
    ["暴雨梨花4重"] = {1.3},
    ["暴雨梨花5重"] = {1.4},
    ["暴雨梨花6重"] = {1.5},
    ["暴雨梨花7重"] = {1.6},
    ["暴雨梨花8重"] = {1.7},
    ["暴雨梨花9重"] = {1.8},
    ["暴雨梨花10重"] = {1.9},
    ["暴雨梨花11重"] = {2.0},
    ["暴雨梨花12重"] = {2.2},
}

function baoyuwanjia(player,id,daoshu1,skill_key,killer)

    if lualib:HasBuff(player,"冰封炸裂") == true then
        lualib:SysWarnMsg(player,"冰冻状态无法收到额外伤害")
        lualib:DisableTimer(player,92623111)
        return false

    end

    local daoshu = tonumber(daoshu1)
    lualib:AddBuff(player, "梨花中毒特效", 1)
    local xishu = baoyuliehua[skill_key][1]
    local cur_hp = lualib:Hp(player, false)
    local mofang = lualib:Attr(player, 8)  -- 魔防
    local momian = lualib:Attr(player, 122)  -- 魔免
    local mianshang = 100 - momian
    local momianxishu = mianshang / 100
    local mofang2 = mofang / 2
    local zuizhongshanghai = daoshu * xishu - mofang2
    local wanmeishanghai = math.ceil(zuizhongshanghai * momianxishu)
    if wanmeishanghai > cur_hp  then
        lualib:Kill(player)
        lualib:SysWarnMsg(player,tostring(cur_hp))
        local current_pk = lualib:Pk(killer)
        local kill_pk = lualib:SetPk(killer, current_pk+90)
        lualib:SysWarnMsg(killer, "PK值上升")
        local killnotice1 = "千里传音玩家：#COLORCOLOR_BROWN#["..lualib:KeyName(killer).."]#COLORCOLOR_YELLOW#将→→#COLORCOLOR_BROWN#["..lualib:KeyName(player).."]#COLORCOLOR_YELLOW#击杀，强力围观中！！！"
        lualib:SysMsg_SendBroadcastColor(killnotice1, "", 1, 12)
        lualib:DisableTimer(player,92623111)
        return false
    end
    lualib:SetHp(player, cur_hp - wanmeishanghai, false)
    lualib:ShowRoleHPRefEx("",player,-wanmeishanghai,3)

end



function baoyuguaiwu(player,id,daoshu1)

    local daoshu = tonumber(daoshu1)

    local cur_hp1 = lualib:Hp(player, false)

    if daoshu > cur_hp1 then
        lualib:AddBuff(player, "死亡", 2)
        return false
    end
    lualib:AddBuff(player, "梨花中毒特效", 1)
    lualib:SetHp(player, cur_hp1 - daoshu, false)
    lualib:ShowRoleHPRefEx("",player,-daoshu,3)


end

function countryBuff_CallBack(player,timer_id)
    local mo = lualib:GetDBNum("魔族人数")
    local shen = lualib:GetDBNum("神族人数")


    if lualib:GetStr(player,"countryName") == "" then
        return ""
    end
    if mo > shen then
        if lualib:HasBuff(player,"新手经验补偿") then
            if lualib:GetStr(player,"countryName") == "魔族" then
                lualib:DelBuff(player,"新手经验补偿")
            end
        else
            if lualib:GetStr(player,"countryName") == "神族" then
                lualib:AddBuff(player,"新手经验补偿",0)
            end
        end
    elseif mo < shen then
        if lualib:HasBuff(player,"新手经验补偿") then
            if lualib:GetStr(player,"countryName") == "神族" then
                lualib:DelBuff(player,"新手经验补偿")
            end
        else
            if lualib:GetStr(player,"countryName") == "魔族" then
                lualib:AddBuff(player,"新手经验补偿",0)
            end
        end
    end
    return ""
end

function newSummonIsHour_CallBack(player,id)
    local times = lualib:GetAllTime()
    if times == lualib:GetInt(player,"newSummonTimes") then
        lualib:SetInt(player,"newSummonIsHour",1)
        local BabyList = lualib:Player_GetServantList(player)
        for i=1, #BabyList do
            local KeyName = lualib:KeyName(BabyList[i])
            if KeyName == "美女守卫" then
                lualib:Monster_Remove(BabyList[i])
            end
        end
    end
    return ""
end


----升级前
function on_pre_level_up(player, level)

    local start_time = lualib:GetConstVar("StartServerTime")
    local kaiqu_time = lualib:Str2Time(start_time)
    local now_time = lualib:Now()
    local xianzai_time = lualib:Str2Time(now_time)
    for i=1,#time_tb do
        if (xianzai_time - kaiqu_time) >= time_tb[i][1] and (xianzai_time - kaiqu_time) < time_tb[i][2] and level == time_tb[i][3] then
            return false
        end
    end
end


--杀怪得经验时
function on_add_exp(player, exp)
    local start_time = lualib:GetConstVar("StartServerTime")
    local kaiqu_time = lualib:Str2Time(start_time)
    local now_time = lualib:Now()
    local xianzai_time = lualib:Str2Time(now_time)
    local level = lualib:Level(player)
    for i=1,#time_tb do
        if (xianzai_time - kaiqu_time) >= time_tb[i][1] and (xianzai_time - kaiqu_time) < time_tb[i][2] and level == time_tb[i][3] then
            lualib:SubExp(player, exp, "等级封印", "等级封印")
        end
    end
end