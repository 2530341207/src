local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)


function on_create(npc)
    lualib:AddTimerEx(npc, 1, 1000, -1, "daojishi", "")
end

function daojishi(npc)
    local map  = lualib:MapGuid(npc)
    local now = lualib:Now()
    local Start = lualib:GetConstVar("StartServerTime")
    local Test = lualib:GetConstVar("TestServerTime")
    local time1 = lualib:Str2Time(now)
    local time2 = lualib:Str2Time(Start)
    local time3 = lualib:Str2Time(Test)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)

    if time1 < time2 and time1 > time3 then
        local time_ = time - lualib:GetAllTime()
        local shi = math.floor(time_ / 3600)
        local fen = math.floor(time_ % 3600 / 60)
        local miao = time_ % 60
        lualib:SysMsg_SendRoleTalk(npc, "服务器将在"..shi.."小时"..fen.."分"..miao.."秒后正式启动，福源奖开区前2分钟公布。")

        local time_ = time - lualib:GetAllTime() - 120
        ----------------------------1
        if time_ <= 0 and lualib:GetDBStr("fyzj_1") == "" then
            local playerList = lualib:Map_GetMapPlayers(map, true)
            if #playerList == 0 then
                lualib:SetDBStr("fyzj_1", "暂无")
                return
            end

            local sl = 0
            for k1, v1 in pairs(playerList) do
                if lualib:GetTotalBill(v1) > 2000 or lualib:GetInt(v1, "csfy") > 0 then
                    sl = sl + 1
                end
            end
            if sl > 5 then
                sl = 5
            end

            local jilu = 0
            for k1, v1 in pairs(playerList) do
                if jilu <= sl then
                    if lualib:GetTotalBill(v1) > 2000 or lualib:GetInt(v1, "csfy") > 0 then
                        lualib:SysMsg_SendBroadcastMsg("获得1","2")
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#广结福缘福利一:#COLORCOLOR_WHITE#玩家["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#获得了新区陆地神缘幸运奖励#COLORCOLOR_YELLOW#价值50元现金充值!", "", 1, 12);
                        jilu = jilu + 1
                        lualib:SetDBStr("fyzj_"..jilu, lualib:Name(v1))
                        lualib:SetInt(v1, "zz_1", 1)
                        lualib:AddSingleItem(player, "充值卡50元", 1, 1, "开区活动", "大秦王宫")
                        lualib:SetInt(v1,"dht_dq", lualib:GetInt(v1,"dht_dq") + 500000)
                    end
                end
            end
            if lualib:GetDBStr("fyzj_1") == "" then
                lualib:SetDBStr("fyzj_1", "暂无")
            end
            jilu = 0
        end


        ----------------------------2
        if time_ <= 0 and lualib:GetDBStr("fuyuan") == "" then
            local playerList = lualib:Map_GetMapPlayers(map, true)
            if #playerList == 0 then
                lualib:SetDBStr("fuyuan", "没有玩家获取")
                return
            end
            local sl = 0
            for k1, v1 in pairs(playerList) do
                if lualib:GetTotalBill(v1) > 2000 or lualib:GetInt(v1, "csfy") > 0 then
                    sl = sl + 1
                end
            end
            local sj = lualib:GenRandom(1, sl)
            local sl = 0
            for k1, v1 in pairs(playerList) do
                if lualib:GetTotalBill(v1) > 2000 or lualib:GetInt(v1, "csfy") > 0 then
                    sl = sl + 1

                    if sj == sl then
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#广结福缘福利二:#COLORCOLOR_WHITE#玩家["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#获得了新区陆地神缘幸运奖励#COLORCOLOR_YELLOW#88元现金充值", "", 1, 12);
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#广结福缘福利二:#COLORCOLOR_WHITE#玩家["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#获得了新区陆地神缘幸运奖励#COLORCOLOR_YELLOW#88元现金充值", "", 1, 12);
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#广结福缘福利二:#COLORCOLOR_WHITE#玩家["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#获得了新区陆地神缘幸运奖励#COLORCOLOR_YELLOW#88元现金充值", "", 1, 12);
                        lualib:SetDBStr("fuyuan", lualib:Name(v1))
                        lualib:AddSingleItem(player, "充值卡100元", 1, 1, "开区活动", "大秦王宫")
                        break
                    end
                end
            end
            if lualib:GetDBStr("fuyuan") == "" then
                lualib:SetDBStr("fuyuan", "没有玩家获取")
            end
        end
    else
        lualib:DisableTimer(npc, 1)
    end
end

function cha1(npc, player)

    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#====================【土城】=================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        for i = 1, 5 do
            if lualib:GetDBStr("fyzj_"..i) == "" then
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[暂无]#COLOREND#\n"
                else
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[暂无]#COLOREND#"
                end
            else
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#["..lualib:GetDBStr("fyzj_"..i).."]#COLOREND#\n"
                else
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#["..lualib:GetDBStr("fyzj_"..i).."]#COLOREND#"
                end
            end
        end
        lualib:NPCTalkDetailEx(npc, player, msg, 500, 250)
        return ""
    else
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#==============================【土城】===========================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        for i = 1, 5 do
            if lualib:GetDBStr("fyzj_"..i) == "" then
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[暂无]#COLOREND#\n"
                else
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[暂无]#COLOREND#"
                end
            else
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#["..lualib:GetDBStr("fyzj_"..i).."]#COLOREND#\n"
                else
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#["..lualib:GetDBStr("fyzj_"..i).."]#COLOREND#"
                end
            end
        end
        local str = "<form default_parent=NpcTalk>"

        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"

        lualib:NPCTalkDetailEx(npc, player, msg, 500, 300)
        return ""
    end
end

function cha2(npc, player)
    local xywj = lualib:GetDBStr("fuyuan")
    if xywj == "" then
        xywj = "暂无"
    end
    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#====================【土城】=================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        msg = msg.."#COLORCOLOR_RED#广结福缘福利二：#COLORCOLOR_SKYBLUE#获奖玩家["..xywj.."]#COLOREND#\n"
        lualib:NPCTalkDetailEx(npc, player, msg, 500, 250)
        return ""
    else
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#==============================【土城】===========================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        msg = msg.."      #COLORCOLOR_RED#广结福缘福利二：#COLORCOLOR_SKYBLUE#获奖玩家["..xywj.."]#COLOREND#\n"
        local str = "<form default_parent=NpcTalk>"


        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"

        lualib:NPCTalkDetailEx(npc, player, msg, 500, 300)
        return ""
    end
end

function main(npc, player)
    local now = lualib:Now()
    local Start = lualib:GetConstVar("StartServerTime")
    local Test = lualib:GetConstVar("TestServerTime")
    local time1 = lualib:Str2Time(now)
    local time2 = lualib:Str2Time(Start)
    local time3 = lualib:Str2Time(Test)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)
    local qu = "正式区"
    local chouqu = "福缘已抽取完毕!"
    if time1 < time2 and time1 > time3 then
        qu = "等待区"
    end

    if lualib:GetDBStr("fuyuan") == "" then
        qu = "等待区"
        local time_ = time - lualib:GetAllTime() - 120
        local shi = math.floor(time_ / 3600)
        local fen = math.floor(time_ % 3600 / 60)
        local miao = time_ % 60
        local time_ = time - lualib:GetAllTime() - 120
        chouqu = "福缘将在"..shi.."小时"..fen.."分"..miao.."秒后抽取!并公布名单!"
    end

    local xywj = lualib:GetDBStr("fuyuan")
    if xywj == "" then
        xywj = "暂无"
    end
    if qu == "正式区" then
        chouqu = "福缘已抽取完毕!"
    end
    local db = "未达标"
    if lualib:GetTotalBill(player) > 0 or lualib:GetInt(player, "csfy") > 0 then
        db = "已达标"
    end

    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#======================【土城】===================#COLOREND##COLORCOLOR_RED##COLOREND#\n"
        msg = msg.."#COLORCOLOR_ORANGE#欢迎来到[".. lualib:GetZoneName() .."],当前区为："..qu.."#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#正式开区时间："..Start.."#COLOREND#\n"

        msg = msg.."#COLORCOLOR_RED#广结福缘：#COLORCOLOR_SKYBLUE#正式开区前2分钟前系统会抽出1至2等奖幸运儿玩家#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED#抽奖时间：#COLORCOLOR_GOLD#【福缘资格:"..db.."】#COLORCOLOR_PURPLE# "..chouqu.."#COLOREND#\n"

        msg = msg.."#COLORCOLOR_RED#福利一：#COLORCOLOR_MAGENTA#抽取5名幸运儿 奖励50元充值#COLOREND#   <@cha1 *01*「中奖名单」>\n"
        msg = msg.."#COLORCOLOR_RED#福利二：#COLORCOLOR_MAGENTA#抽取1名幸运儿 奖励100元充值#COLOREND#  <@cha2 *01*「中奖名单」>\n"

        msg = msg.."#COLORCOLOR_GOLD#凡充值金额20元以上皆可获得参与广结福缘1-2等奖抽奖资格！奖项可以重叠#COLOREND#\n"
        msg = msg.."#COLORCOLOR_GOLD#系统提前1分钟公布获奖福缘玩家，请达到要求者保持在线。#COLOREND#\n\n"


        msg = msg.."　　　   <@jian *01*「进入练级」>　　             <@lk *01*「我很忙」>"
        lualib:NPCTalkDetailEx(npc, player, msg, 500, 250)
        return ""
    else
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#================================【土城】=============================#COLOREND##COLORCOLOR_RED##COLOREND#\n"
        msg = msg.."　　#COLORCOLOR_ORANGE#欢迎来到[".. lualib:GetZoneName() .."],当前区为："..qu.."#COLOREND#\n"
        msg = msg.."　　#COLORCOLOR_SKYBLUE#正式开区时间："..Start.."#COLOREND#\n"

        msg = msg.."　　#COLORCOLOR_RED#广结福缘：#COLORCOLOR_SKYBLUE#距离正式开区2分钟前举行，系统随机抽取幸运玩家#COLOREND#\n"
        msg = msg.."    #COLORCOLOR_RED#抽奖时间：#COLORCOLOR_GOLD#【福缘资格:"..db.."】#COLORCOLOR_PURPLE# "..chouqu.."#COLOREND#\n"

        msg = msg.."　　#COLORCOLOR_RED#福利一：#COLORCOLOR_MAGENTA#抽取5名幸运玩家 奖励50元充值#COLOREND#   <@cha1 *01*「查看中奖名单」>\n"
        msg = msg.."　　#COLORCOLOR_RED#福利二：#COLORCOLOR_MAGENTA#抽取 1名幸运玩家 奖励100元充值#COLOREND#          <@cha2 *01*「查看中奖名单」>\n"

        msg = msg.."　　#COLORCOLOR_GOLD#凡充值金额20元以上皆可获得参与广结福缘1-2等奖抽奖资格！奖项可以重叠#COLOREND#\n"
        msg = msg.."　　#COLORCOLOR_GOLD#系统提前1分钟公布获奖福缘玩家，请达到要求者保持在线。#COLOREND#\n\n"


        msg = msg.."　　　     <@jian *01*「进入主城」>　　                 　<@lk *01*「我很忙」>"
        local str = "<form default_parent=NpcTalk>"

        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"

        lualib:NPCTalkDetailEx(npc, player, msg, 500, 300)
        return ""
    end
end

function jian(npc, player)
    lualib:SetPanelSize(npc, 500, 250)
    local now = lualib:Now()
    local Start = lualib:GetConstVar("StartServerTime")
    local Test = lualib:GetConstVar("TestServerTime")
    local time1 = lualib:Str2Time(now)
    local time2 = lualib:Str2Time(Start)
    local time3 = lualib:Str2Time(Test)
    local time = lualib:GetConstVar("StartServerTime")
    time = lualib:Str2Time(time)
    if time1 < time2 and time1 > time3 then
        local time_ = time - lualib:GetAllTime()
        local shi = math.floor(time_ / 3600)
        local fen = math.floor(time_ % 3600 / 60)
        local miao = time_ % 60
        return "\n\n  当前服务器未正式开放!\n\n　　服务器将在"..shi.."小时"..fen.."分"..miao.."秒后正式启动，请在本地图耐心等待!!!\n \n"

    end
    lualib:Player_MapMove(player,"新手练级一")
    return ""
end

function lk(npc, player)
    return ""
end


