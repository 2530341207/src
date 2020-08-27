    local width = 420	--对话框宽度

    local heigh = 210	--对话框高度

    local max = 100000	--下注最大元宝

    local min = 1000	--下注最小元宝

    local times = 180	--时间【单位秒】意思过了180秒如果没人攻擂直接结束

    local timeId = 1	--定时器ID

    local mapkey = "擂台"	--地图索引名[普通地图]

    local x = 42	--摆擂者传送mapkey位置X

    local y = 43	--摆擂者传送mapkey位置Y

    local _x = 43	--攻擂者传送mapkey位置_X

    local _y = 45	--攻擂者传送mapkey位置_Y

    local __x = 41	--观众传送位置

    local __y = 49	--观众传送位置

    local level = 20	--等级限制

    local gold = 50000	--购买门票消耗金币

    local buff = "比武"	--参赛者进入地图给予的buff索引名[设置为下线、死亡、跳图都不保存]

    function main(npc, player)
        return main_ex(player)
    end

    function main_ex(player)
        local msg = [[
    \n  擂台是解决争端和切磋技艺的地方。
      你可以在此摆下擂台，邀请天下英雄来战。

    \n  #IMAGE1902700033# #OFFSET<Y:-2>#<@bai *01*我要摆擂>
      #IMAGE1902700018# #OFFSET<Y:-2>#<@gong *01*我要攻擂>
      #IMAGE1902700018# #OFFSET<Y:-2>#<@levelMap *01*离开>
      #IMAGE1902700037# #OFFSET<Y:-2>#<@buy *01*买张门票观看(5万金币)>
      #IMAGE1902700030# #OFFSET<Y:-2>#<@search *01*了解比武规则>
        ]]
        if lualib:Level(player) < level then
            msg = "\n  你的身子骨还很弱，过些时候再来吧。"
        end
        lualib:NPCTalkDetail(player, msg, width, heigh)
        return ""
    end

    function levelMap(player)
        lualib:Player_MapMoveXY(player,"龙城", 255, 270, 5)
        return ""
    end

    function bai(player)
        local map = lualib:Map_GetMapGuid(mapkey)
        lualib:SetPanelSize(player, width, heigh)
        if map == "" then
            return "获取地图数据失败。\n\n\n<@main_ex *01*[返回首页]>"
        end
        if lualib:GetStr(map, "rolelist") ~= "" then
            return "\n  当前已经有人在摆擂了，请稍等再来。\n\n\n  <@main_ex *01*[返回首页]>"
        end
        lualib:SysMsg_SendInputDlg(player, 18, "请输入您要摆擂的元宝", 60, 8, "bai_ex", "")
        return ""
    end

    function bai_ex(id, player, ingot)

        if tonumber(ingot) == nil then
            lualib:MsgBox(player, "请输入一个纯数字。")
            return end

        local ingot = math.floor(tonumber(ingot))
        if ingot < min or ingot > max then
            lualib:MsgBox(player, "请输入一个"..min.."-"..max.."的数字！")
            return end

        local map = lualib:Map_GetMapGuid(mapkey)
        if lualib:GetStr(map, "rolelist") ~= "" then
            return "当前已经有人在摆擂了，请稍等再来。\n\n\n<@main_ex *01*[返回首页]>"
        end

        if not lualib:SubIngot(player, ingot, "擂台赛", map) then
            lualib:MsgBox(player, "抱歉，您的元宝不足。")
            return end

        local name = lualib:Name(player)

        lualib:SetStr(map, "rolelist", player.."#"..name.."#"..ingot)

        local msg = "[系统消息]:"..name.."摆下"..ingot.."元宝擂台，如果需要攻擂，请找擂台管理员。"

        lualib:SysMsg_SendBroadcastMsg(msg, "")

        lualib:MsgBox(player, "摆擂成功，请耐心等待攻擂者。")

        lualib:SetInt(map, "second_ex", 0)

        lualib:SetInt(map, "second", 0)

        lualib:AddTimerEx(map, timeId, 1000, -1, "check", name.."#"..ingot)
    end

    function check(map, id, name, ingot)
        local player = lualib:Name2Guid(name)

        local msg = "系统提示："..name.."摆下"..ingot.."元宝擂台，江湖人士无人应战，系统退回擂台元宝。"
        lualib:SysMsg_SendBroadcastMsg(tostring(player).."||||"..tostring(name),"111")

        if player == "" or lualib:IsOffline(player) then
            lualib:Mail("擂台赛", name, "由于您中途下线，擂台赛结束，系统返还您押注的元宝。", 0, tonumber(ingot), {})
            lualib:SetStr(map, "rolelist", "")
            lualib:SetInt(map, "second", 0)
            lualib:SysMsg_SendBroadcastMsg(msg, "")
            lualib:DisableTimer(map, id)
            return end
        local second = lualib:GetInt(map, "second") + 1

        if second >= times then
            lualib:SetStr(map, "rolelist", "")
            lualib:SetInt(map, "second", 0)
            lualib:SysMsg_SendBroadcastMsg(msg, "")
            lualib:AddIngot(player, tonumber(ingot), "擂台赛返还", map)
            lualib:DisableTimer(map, id)
            return end

        lualib:SetInt(map, "second", second)
    end


    function gong(player)
        lualib:SetPanelSize(player, width, heigh)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            return "\n  当前还没人摆擂，无法攻擂。\n\n\n  <@main_ex *01*[返回首页]>"
        end

        local tb = lualib:StrSplit(data, "#")

        if lualib:Name2Guid(tb[2]) == "" or lualib:IsOffline(tb[1]) then
            return "当前还没人摆擂，无法攻擂。\n\n\n<@main_ex *01*[返回首页]>"
        end

        if tb[1] == player then
            lualib:MsgBox(player, "抱歉，您不能攻自己摆下的擂台。")
            return end

        if #tb > 3 then
            lualib:MsgBox(player, "您来晚了，已经有人攻擂了。")
            return end

        if lualib:GetIngot(player) < tonumber(tb[3]) then
            return "\n  当前摆擂的元宝为，您的元宝不足"..tb[3].."，无法进行攻擂。\n\n\n  <@main_ex *01*[返回首页]>"
        end

        local str = "#COLORCOLOR_RED#                攻擂确认！\n\n"
        str = str.."#COLORCOLOR_YELLOW#攻擂元宝为（"..tb[3].."），您确定攻擂吗？\n\n"
        str = str.."#BUTTON0#确定#BUTTONEND##BUTTON1#取消#BUTTONEND#"
        lualib:SysMsg_SendMsgDlg(player, 1000, str, 100, "gong_ex", tb[3])
        return ""
    end

    function gong_ex(dlg_id, player, BUTTON_ID, ingot)

        if BUTTON_ID == 1 then return end

        ingot = tonumber(ingot)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            lualib:MsgBox(player, "当前还没人摆擂，无法攻擂。")
        return end

        local tb = lualib:StrSplit(data, "#")

        if ingot ~= tonumber(tb[3]) then
            lualib:MsgBox(player, "获取数据出错。")
         return end

        if lualib:Name2Guid(tb[2]) == "" or lualib:IsOffline(tb[1]) then
            lualib:MsgBox(player, "当前还没人摆擂，无法攻擂。")
            return end

        if tb[1] == player then
            lualib:MsgBox(player, "抱歉，您不能攻自己摆下的擂台。")
            return end

        if #tb > 3 then
            lualib:MsgBox(player, "您来晚了，已经有人攻擂了。")
            return end

        if not lualib:SubIngot(player, ingot, "攻擂", map) then
            lualib:MsgBox(player, "抱歉，您的元宝不足，无法攻擂。")
        return end

        lualib:SetStr(map, "rolelist", data.."#"..player)

        lualib:DisableTimer(map, timeId)

        lualib:AddBuff(tb[1], buff, 60)
        local hero = lualib:GetCurrentHero(tb[1])
        if hero ~= "" then
            lualib:Player_MapMoveXY(hero, mapkey, x, y, 1)
            lualib:AddBuff(hero, buff, 60)
        end
        lualib:Player_MapMoveXY(tb[1], mapkey, x, y, 1)

        lualib:AddBuff(player, buff, 60)
        local _hero = lualib:GetCurrentHero(player)
        if _hero ~= "" then
            lualib:Player_MapMoveXY(_hero, mapkey, x, y, 1)
            lualib:AddBuff(_hero, buff, 60)
        end
        lualib:Player_MapMoveXY(player, mapkey, _x, _y, 1)

        local msg = "系统提示："..tb[2].."摆下"..ingot.."元宝擂台，遭到了"..lualib:Name(player).."的挑战。1分钟后开始比赛，玩家可以买票入场观看。"

        lualib:SysMsg_SendBroadcastMsg(msg, "")

        lualib:AddTimerEx(map, 2, 1000, -1, "擂台赛竞技场:on_check", tb[1].."#"..player)
    end

    function buy(player)
        lualib:SetPanelSize(player, width, heigh)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            return "\n  当前还没有人摆擂，您无法观赛。\n\n\n  <@main_ex *01*[返回首页]>"
        end

        local tb = lualib:StrSplit(data, "#")

        if #tb <= 3 then
            return "\n  当前擂台赛还未开始，您无法观赛。\n\n\n  <@main_ex *01*[返回首页]>"
        end

        if not lualib:SubGold(player, gold, "观看擂台赛", player) then
            return "\n  您的金币不足，无法观赛。\n\n\n  <@main_ex *01*[返回首页]>"
        end

        lualib:Player_MapMoveXY(player, mapkey, __x, __y, 1)

        return ""
    end

    function search(player)
        local msg = [[
    \n  1、摆擂有人攻擂后自动传送擂台，1分钟后开始战斗。
      2、比赛擂台场禁止使用药品。
      3、擂台死亡不掉落装备。
      4、擂台不可以使用随机。
      5、观众席观众不可以使用任何技能。
      6、如有人正在比武，需要等结束后方可再次发起摆擂。
      7、摆擂或攻擂获胜均可获得双方押金总和的90%。
      8、元宝押金必须在1000—100000之间。
        ]]
        lualib:SetPanelSize(player, width, heigh)
        return msg
    end