local map_t = {
    {"赤壁之战", 53, 158, 45, {"等级卷", 1}, 3600, 5000},--副本索引名+X+Y+等级+{道具+数量}+副本存在时间+消耗金币
    {"官渡之战", 105, 120, 50, {"等级卷", 2}, 3600, 5000},
    {"夷陵之战", 63, 171, 55, {"等级卷", 4}, 3600, 5000},
    {"街亭之战", 136, 125, 60, {"等级卷", 6}, 3600, 5000},
}

local map_count = {
    {"cbzz",10},
    {"gdzz",7},
    {"ylzz",5},
    {"jtzz",3}
}

function main(npc, player)
    if lualib:GetClientType(player) == 2 then
        local msg = "\n"
        msg = msg .."#COLORCOLOR_DARK#《赤壁之战》     #COLORCOLOR_GREENG#材料：#COLORCOLOR_RED#需挑战令*1 金币*5000   #POS<X:400>#<@team#1 *01*[组队挑战副本]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#《官渡之战》     #COLORCOLOR_GREENG#材料：#COLORCOLOR_RED#需挑战令*2 金币*5000   #POS<X:400>#<@team#2 *01*[组队挑战副本]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#《夷陵之战》     #COLORCOLOR_GREENG#材料：#COLORCOLOR_RED#需挑战令*4 金币*5000   #POS<X:400>#<@team#3 *01*[组队挑战副本]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#《街亭之战》     #COLORCOLOR_GREENG#材料：#COLORCOLOR_RED#需挑战令*6 金币*5000   #POS<X:400>#<@team#4 *01*[组队挑战副本]>"


        lualib:NPCTalkDetailEx(npc, player, msg, 435, 390)


    else
        local msg = ""
        local str = "<form default_parent=NpcTalk,Container>"


        str = str .."<wnd id=赤壁之战 x=15 y=20>"
        str = str .."<image id=九宫格1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=九宫格2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=标题 x=20 y=3 w=180 h=20 text_color=SKYBLUE text=赤壁之战 font=SIMLI18/>"
        str = str .."<richedit id=内容 x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#副本说明：45级可进入;每人每天可进入10次;每次进入刷出一只人界BOSS等怪物挑战\n#COLORCOLOR_RED#进入条件：挑战令*1 金币*5000(收取队长)\n#COLORCOLOR_GREENG#攻略提示：地图内无法召唤侍女，副本BOSS必爆一个3级宝石碎片\"/>"
        str = str .."<image id=星星1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:65>#<@team#1 *01*[组队挑战副本]>"

        str = str .."<wnd id=官渡之战 x=15 y=103>"
        str = str .."<image id=九宫格1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=九宫格2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=标题 x=20 y=3 w=180 h=20 text_color=SKYBLUE text=官渡之战 font=SIMLI18/>"
        str = str .."<richedit id=内容 x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#副本说明：50级可进入;每人每天可进入7次;每次进入刷出一只人界BOSS等怪物挑战\n#COLORCOLOR_RED#进入条件：挑战令*2 金币*5000(收取队长)\n#COLORCOLOR_GREENG#攻略提示：地图内无法召唤侍女，副本BOSS必爆一个3级宝石碎片\"/>"
        str = str .."<image id=星星1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:148>#<@team#2 *01*[组队挑战副本]>"


        str = str .."<wnd id=夷陵之战 x=15 y=186>"
        str = str .."<image id=九宫格1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=九宫格2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=标题 x=20 y=3 w=180 h=20 text_color=SKYBLUE text=夷陵之战 font=SIMLI18/>"
        str = str .."<richedit id=内容 x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#副本说明：55级可进入;每人每天可进入5次;每次进入刷出一只人界BOSS等怪物挑战\n#COLORCOLOR_RED#进入条件：挑战令*4 金币*5000(收取队长)\n#COLORCOLOR_GREENG#攻略提示：地图内无法召唤侍女，副本BOSS必爆一个3级宝石碎片\"/>"
        str = str .."<image id=星星1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:231>#<@team#3 *01*[组队挑战副本]>"

        str = str .."<wnd id=街亭之战 x=15 y=269>"
        str = str .."<image id=九宫格1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=九宫格2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=标题 x=20 y=3 w=180 h=20 text_color=SKYBLUE text=街亭之战 font=SIMLI18/>"
        str = str .."<richedit id=内容 x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#副本说明：60级可进入;每人每天可进入3次;每次进入刷出一只人界BOSS等怪物挑战\n#COLORCOLOR_RED#进入条件：挑战令*6 金币*5000(收取队长)\n#COLORCOLOR_GREENG#攻略提示：地图内无法召唤侍女，副本BOSS必爆一个3级宝石碎片\"/>"
        str = str .."<image id=星星1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=星星4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=星星7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:314>#<@team#4 *01*[组队挑战副本]>"


        msg = str .."<text><![CDATA["..msg.."]]></text></form>"
        lualib:NPCTalkDetailEx(npc, player, msg, 435, 390)

    end
    return ""
end

function team(npc, player, idx)
    idx = tonumber(idx)

    if lualib:Player_HasTeam(player) == false then
        lualib:MsgBox(player, "你尚未组队。")
        return ""
    end
    local guid = lualib:GetStr(player, "zuduimap")
    if guid ~= "" and lualib:Map_IsDgnExist(guid) then
        lualib:Player_SetDgnTicket(player, guid)
        lualib:Player_EnterDgn(player, map_t[idx][1], map_t[idx][2], map_t[idx][3], 0)
    else
        local name = lualib:Name(player)
        if not lualib:Player_IsTeamLeader(player) then
            lualib:MsgBox(player, "只有队长才有资格带领队员进入。")
            return ""
        end
        local players = lualib:Player_GetTeamList(player)
        for i,v in pairs(players) do
            if lualib:GetDayInt(players[i],map_count[idx][1]) >= map_count[idx][2] then
                lualib:MsgBox(player, "抱歉，队伍中存在挑战该副本的已达次数上限的队员！")
                return ""
            end
        end
        if lualib:GetGold(player) < map_t[idx][7] then
            lualib:MsgBox(player, "抱歉，您没有足够的金币挑战。")
            return ""
        end
        if lualib:ItemCount(player, map_t[idx][5][1]) < map_t[idx][5][2] then
            lualib:MsgBox(player, "您背包里没有我需要的道具。")
            return ""
        end
        local req, member = check(player, players, idx)
        if req == false then
            lualib:MsgBox(player, "["..member.."]等级不足或距离超过队长10格。")
            return ""
        end
        local map = lualib:Map_CreateDgn(map_t[idx][1], true, map_t[idx][6])
        if map == "" then
            return "副本数据不存在。"
        end
        lualib:SubGold(player, map_t[idx][7], "挑战副本", "挑战副本")
        lualib:DelItem(player, map_t[idx][5][1], map_t[idx][5][2], 2, "挑战副本", "挑战副本")
        for i = 1, #players do
            lualib:SetStr(players[i], "zuduimap", map)
            lualib:Player_SetDgnTicket(players[i], map)
            lualib:Player_EnterDgn(players[i], map_t[idx][1], map_t[idx][2], map_t[idx][3], 0)
            lualib:SetDayInt(players[i],map_count[idx][1],lualib:GetDayInt(players[idx],map_count[i][1]) + 1)
        end

        lualib:SysMsg_SendBroadcastMsg(name.."带领自己的团队闯入了"..map_t[idx][1].."，大家为他们祈祷吧！", "")
    end
    return ""
end

function check(player, players, idx)
    for i = 1, #players do
        if player ~= players[i] and lualib:Distance(player, players[i]) > 10 then
            return false, lualib:Name(players[i])
        end
        if lualib:Level(players[i]) < map_t[idx][4] then
            return false, lualib:Name(players[i])
        end
    end
    return true
end