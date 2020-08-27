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
        lualib:SysMsg_SendRoleTalk(npc, "����������"..shi.."Сʱ"..fen.."��"..miao.."�����ʽ��������Դ������ǰ2���ӹ�����")

        local time_ = time - lualib:GetAllTime() - 120
        ----------------------------1
        if time_ <= 0 and lualib:GetDBStr("fyzj_1") == "" then
            local playerList = lualib:Map_GetMapPlayers(map, true)
            if #playerList == 0 then
                lualib:SetDBStr("fyzj_1", "����")
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
                        lualib:SysMsg_SendBroadcastMsg("���1","2")
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#��ḣԵ����һ:#COLORCOLOR_WHITE#���["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#���������½����Ե���˽���#COLORCOLOR_YELLOW#��ֵ50Ԫ�ֽ��ֵ!", "", 1, 12);
                        jilu = jilu + 1
                        lualib:SetDBStr("fyzj_"..jilu, lualib:Name(v1))
                        lualib:SetInt(v1, "zz_1", 1)
                        lualib:AddSingleItem(player, "��ֵ��50Ԫ", 1, 1, "�����", "��������")
                        lualib:SetInt(v1,"dht_dq", lualib:GetInt(v1,"dht_dq") + 500000)
                    end
                end
            end
            if lualib:GetDBStr("fyzj_1") == "" then
                lualib:SetDBStr("fyzj_1", "����")
            end
            jilu = 0
        end


        ----------------------------2
        if time_ <= 0 and lualib:GetDBStr("fuyuan") == "" then
            local playerList = lualib:Map_GetMapPlayers(map, true)
            if #playerList == 0 then
                lualib:SetDBStr("fuyuan", "û����һ�ȡ")
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
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#��ḣԵ������:#COLORCOLOR_WHITE#���["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#���������½����Ե���˽���#COLORCOLOR_YELLOW#88Ԫ�ֽ��ֵ", "", 1, 12);
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#��ḣԵ������:#COLORCOLOR_WHITE#���["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#���������½����Ե���˽���#COLORCOLOR_YELLOW#88Ԫ�ֽ��ֵ", "", 1, 12);
                        lualib:SysMsg_SendBroadcastColor("#COLORCOLOR_YELLOW#��ḣԵ������:#COLORCOLOR_WHITE#���["..lualib:Name(v1).."] #COLORCOLOR_PURPLE#���������½����Ե���˽���#COLORCOLOR_YELLOW#88Ԫ�ֽ��ֵ", "", 1, 12);
                        lualib:SetDBStr("fuyuan", lualib:Name(v1))
                        lualib:AddSingleItem(player, "��ֵ��100Ԫ", 1, 1, "�����", "��������")
                        break
                    end
                end
            end
            if lualib:GetDBStr("fuyuan") == "" then
                lualib:SetDBStr("fuyuan", "û����һ�ȡ")
            end
        end
    else
        lualib:DisableTimer(npc, 1)
    end
end

function cha1(npc, player)

    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#====================�����ǡ�=================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        for i = 1, 5 do
            if lualib:GetDBStr("fyzj_"..i) == "" then
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[����]#COLOREND#\n"
                else
                    msg = msg.."    #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[����]#COLOREND#"
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
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#==============================�����ǡ�===========================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        for i = 1, 5 do
            if lualib:GetDBStr("fyzj_"..i) == "" then
                if i == 3 or i == 6 or i == 9 or i == 12 or i == 15 or i == 18 or i == 21 or i == 24 or i == 27 then
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[����]#COLOREND#\n"
                else
                    msg = msg.."      #COLORCOLOR_RED##COLORCOLOR_SKYBLUE#[����]#COLOREND#"
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
        xywj = "����"
    end
    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#====================�����ǡ�=================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        msg = msg.."#COLORCOLOR_RED#��ḣԵ��������#COLORCOLOR_SKYBLUE#�����["..xywj.."]#COLOREND#\n"
        lualib:NPCTalkDetailEx(npc, player, msg, 500, 250)
        return ""
    else
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#==============================�����ǡ�===========================#COLOREND##COLORCOLOR_RED##COLOREND#\n\n"
        msg = msg.."      #COLORCOLOR_RED#��ḣԵ��������#COLORCOLOR_SKYBLUE#�����["..xywj.."]#COLOREND#\n"
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
    local qu = "��ʽ��"
    local chouqu = "��Ե�ѳ�ȡ���!"
    if time1 < time2 and time1 > time3 then
        qu = "�ȴ���"
    end

    if lualib:GetDBStr("fuyuan") == "" then
        qu = "�ȴ���"
        local time_ = time - lualib:GetAllTime() - 120
        local shi = math.floor(time_ / 3600)
        local fen = math.floor(time_ % 3600 / 60)
        local miao = time_ % 60
        local time_ = time - lualib:GetAllTime() - 120
        chouqu = "��Ե����"..shi.."Сʱ"..fen.."��"..miao.."����ȡ!����������!"
    end

    local xywj = lualib:GetDBStr("fuyuan")
    if xywj == "" then
        xywj = "����"
    end
    if qu == "��ʽ��" then
        chouqu = "��Ե�ѳ�ȡ���!"
    end
    local db = "δ���"
    if lualib:GetTotalBill(player) > 0 or lualib:GetInt(player, "csfy") > 0 then
        db = "�Ѵ��"
    end

    if lualib:GetClientType(player) == 2 then
        local msg = "#COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#======================�����ǡ�===================#COLOREND##COLORCOLOR_RED##COLOREND#\n"
        msg = msg.."#COLORCOLOR_ORANGE#��ӭ����[".. lualib:GetZoneName() .."],��ǰ��Ϊ��"..qu.."#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#��ʽ����ʱ�䣺"..Start.."#COLOREND#\n"

        msg = msg.."#COLORCOLOR_RED#��ḣԵ��#COLORCOLOR_SKYBLUE#��ʽ����ǰ2����ǰϵͳ����1��2�Ƚ����˶����#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED#�齱ʱ�䣺#COLORCOLOR_GOLD#����Ե�ʸ�:"..db.."��#COLORCOLOR_PURPLE# "..chouqu.."#COLOREND#\n"

        msg = msg.."#COLORCOLOR_RED#����һ��#COLORCOLOR_MAGENTA#��ȡ5�����˶� ����50Ԫ��ֵ#COLOREND#   <@cha1 *01*���н�������>\n"
        msg = msg.."#COLORCOLOR_RED#��������#COLORCOLOR_MAGENTA#��ȡ1�����˶� ����100Ԫ��ֵ#COLOREND#  <@cha2 *01*���н�������>\n"

        msg = msg.."#COLORCOLOR_GOLD#����ֵ���20Ԫ���ϽԿɻ�ò����ḣԵ1-2�Ƚ��齱�ʸ񣡽�������ص�#COLOREND#\n"
        msg = msg.."#COLORCOLOR_GOLD#ϵͳ��ǰ1���ӹ����񽱸�Ե��ң���ﵽҪ���߱������ߡ�#COLOREND#\n\n"


        msg = msg.."������   <@jian *01*������������>����             <@lk *01*���Һ�æ��>"
        lualib:NPCTalkDetailEx(npc, player, msg, 500, 250)
        return ""
    else
        local msg = "\n\n #COLORCOLOR_RED##COLOREND##COLORCOLOR_GOLD#================================�����ǡ�=============================#COLOREND##COLORCOLOR_RED##COLOREND#\n"
        msg = msg.."����#COLORCOLOR_ORANGE#��ӭ����[".. lualib:GetZoneName() .."],��ǰ��Ϊ��"..qu.."#COLOREND#\n"
        msg = msg.."����#COLORCOLOR_SKYBLUE#��ʽ����ʱ�䣺"..Start.."#COLOREND#\n"

        msg = msg.."����#COLORCOLOR_RED#��ḣԵ��#COLORCOLOR_SKYBLUE#������ʽ����2����ǰ���У�ϵͳ�����ȡ�������#COLOREND#\n"
        msg = msg.."    #COLORCOLOR_RED#�齱ʱ�䣺#COLORCOLOR_GOLD#����Ե�ʸ�:"..db.."��#COLORCOLOR_PURPLE# "..chouqu.."#COLOREND#\n"

        msg = msg.."����#COLORCOLOR_RED#����һ��#COLORCOLOR_MAGENTA#��ȡ5��������� ����50Ԫ��ֵ#COLOREND#   <@cha1 *01*���鿴�н�������>\n"
        msg = msg.."����#COLORCOLOR_RED#��������#COLORCOLOR_MAGENTA#��ȡ 1��������� ����100Ԫ��ֵ#COLOREND#          <@cha2 *01*���鿴�н�������>\n"

        msg = msg.."����#COLORCOLOR_GOLD#����ֵ���20Ԫ���ϽԿɻ�ò����ḣԵ1-2�Ƚ��齱�ʸ񣡽�������ص�#COLOREND#\n"
        msg = msg.."����#COLORCOLOR_GOLD#ϵͳ��ǰ1���ӹ����񽱸�Ե��ң���ﵽҪ���߱������ߡ�#COLOREND#\n\n"


        msg = msg.."������     <@jian *01*���������ǡ�>����                 ��<@lk *01*���Һ�æ��>"
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
        return "\n\n  ��ǰ������δ��ʽ����!\n\n��������������"..shi.."Сʱ"..fen.."��"..miao.."�����ʽ���������ڱ���ͼ���ĵȴ�!!!\n \n"

    end
    lualib:Player_MapMove(player,"��������һ")
    return ""
end

function lk(npc, player)
    return ""
end


