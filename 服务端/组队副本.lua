local map_t = {
    {"���֮ս", 53, 158, 45, {"�ȼ���", 1}, 3600, 5000},--����������+X+Y+�ȼ�+{����+����}+��������ʱ��+���Ľ��
    {"�ٶ�֮ս", 105, 120, 50, {"�ȼ���", 2}, 3600, 5000},
    {"����֮ս", 63, 171, 55, {"�ȼ���", 4}, 3600, 5000},
    {"��֮ͤս", 136, 125, 60, {"�ȼ���", 6}, 3600, 5000},
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
        msg = msg .."#COLORCOLOR_DARK#�����֮ս��     #COLORCOLOR_GREENG#���ϣ�#COLORCOLOR_RED#����ս��*1 ���*5000   #POS<X:400>#<@team#1 *01*[�����ս����]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#���ٶ�֮ս��     #COLORCOLOR_GREENG#���ϣ�#COLORCOLOR_RED#����ս��*2 ���*5000   #POS<X:400>#<@team#2 *01*[�����ս����]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#������֮ս��     #COLORCOLOR_GREENG#���ϣ�#COLORCOLOR_RED#����ս��*4 ���*5000   #POS<X:400>#<@team#3 *01*[�����ս����]>\n\n\n"
        msg = msg .."#COLORCOLOR_DARK#����֮ͤս��     #COLORCOLOR_GREENG#���ϣ�#COLORCOLOR_RED#����ս��*6 ���*5000   #POS<X:400>#<@team#4 *01*[�����ս����]>"


        lualib:NPCTalkDetailEx(npc, player, msg, 435, 390)


    else
        local msg = ""
        local str = "<form default_parent=NpcTalk,Container>"


        str = str .."<wnd id=���֮ս x=15 y=20>"
        str = str .."<image id=�Ź���1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=�Ź���2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=���� x=20 y=3 w=180 h=20 text_color=SKYBLUE text=���֮ս font=SIMLI18/>"
        str = str .."<richedit id=���� x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#����˵����45���ɽ���;ÿ��ÿ��ɽ���10��;ÿ�ν���ˢ��һֻ�˽�BOSS�ȹ�����ս\n#COLORCOLOR_RED#������������ս��*1 ���*5000(��ȡ�ӳ�)\n#COLORCOLOR_GREENG#������ʾ����ͼ���޷��ٻ���Ů������BOSS�ر�һ��3����ʯ��Ƭ\"/>"
        str = str .."<image id=����1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:65>#<@team#1 *01*[�����ս����]>"

        str = str .."<wnd id=�ٶ�֮ս x=15 y=103>"
        str = str .."<image id=�Ź���1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=�Ź���2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=���� x=20 y=3 w=180 h=20 text_color=SKYBLUE text=�ٶ�֮ս font=SIMLI18/>"
        str = str .."<richedit id=���� x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#����˵����50���ɽ���;ÿ��ÿ��ɽ���7��;ÿ�ν���ˢ��һֻ�˽�BOSS�ȹ�����ս\n#COLORCOLOR_RED#������������ս��*2 ���*5000(��ȡ�ӳ�)\n#COLORCOLOR_GREENG#������ʾ����ͼ���޷��ٻ���Ů������BOSS�ر�һ��3����ʯ��Ƭ\"/>"
        str = str .."<image id=����1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:148>#<@team#2 *01*[�����ս����]>"


        str = str .."<wnd id=����֮ս x=15 y=186>"
        str = str .."<image id=�Ź���1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=�Ź���2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=���� x=20 y=3 w=180 h=20 text_color=SKYBLUE text=����֮ս font=SIMLI18/>"
        str = str .."<richedit id=���� x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#����˵����55���ɽ���;ÿ��ÿ��ɽ���5��;ÿ�ν���ˢ��һֻ�˽�BOSS�ȹ�����ս\n#COLORCOLOR_RED#������������ս��*4 ���*5000(��ȡ�ӳ�)\n#COLORCOLOR_GREENG#������ʾ����ͼ���޷��ٻ���Ů������BOSS�ر�һ��3����ʯ��Ƭ\"/>"
        str = str .."<image id=����1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:231>#<@team#3 *01*[�����ս����]>"

        str = str .."<wnd id=��֮ͤս x=15 y=269>"
        str = str .."<image id=�Ź���1 x=0 y=0 w=370 h=82 type=around image=1900300091,1900300092,1900300093,1900300094,1900300095,1900300096,1900300097,1900300098,1900300099/>"
        str = str .."<image id=�Ź���2 x=112 y=3 w=253 h=76 type=around image=1900190004,1900190006,1900190005,1900190007,1900190008,1900190000,1900190001,1900190002,1900190003 gray=1/>"
        str = str .."<richedit id=���� x=20 y=3 w=180 h=20 text_color=SKYBLUE text=��֮ͤս font=SIMLI18/>"
        str = str .."<richedit id=���� x=120 y=6 w=240 h=20 text=\"#COLORCOLOR_DARK#����˵����60���ɽ���;ÿ��ÿ��ɽ���3��;ÿ�ν���ˢ��һֻ�˽�BOSS�ȹ�����ս\n#COLORCOLOR_RED#������������ս��*6 ���*5000(��ȡ�ӳ�)\n#COLORCOLOR_GREENG#������ʾ����ͼ���޷��ٻ���Ů������BOSS�ر�һ��3����ʯ��Ƭ\"/>"
        str = str .."<image id=����1 x=8 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����2 x=22 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����3 x=36 y=24 type=normal image=1900340293/>"
        str = str .."<image id=����4 x=50 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����5 x=64 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����6 x=78 y=24 type=normal image=1900340295/>"
        str = str .."<image id=����7 x=92 y=24 type=normal image=1900340295/></wnd>"
        msg = msg .."#POS<X:30,Y:314>#<@team#4 *01*[�����ս����]>"


        msg = str .."<text><![CDATA["..msg.."]]></text></form>"
        lualib:NPCTalkDetailEx(npc, player, msg, 435, 390)

    end
    return ""
end

function team(npc, player, idx)
    idx = tonumber(idx)

    if lualib:Player_HasTeam(player) == false then
        lualib:MsgBox(player, "����δ��ӡ�")
        return ""
    end
    local guid = lualib:GetStr(player, "zuduimap")
    if guid ~= "" and lualib:Map_IsDgnExist(guid) then
        lualib:Player_SetDgnTicket(player, guid)
        lualib:Player_EnterDgn(player, map_t[idx][1], map_t[idx][2], map_t[idx][3], 0)
    else
        local name = lualib:Name(player)
        if not lualib:Player_IsTeamLeader(player) then
            lualib:MsgBox(player, "ֻ�жӳ������ʸ�����Ա���롣")
            return ""
        end
        local players = lualib:Player_GetTeamList(player)
        for i,v in pairs(players) do
            if lualib:GetDayInt(players[i],map_count[idx][1]) >= map_count[idx][2] then
                lualib:MsgBox(player, "��Ǹ�������д�����ս�ø������Ѵ�������޵Ķ�Ա��")
                return ""
            end
        end
        if lualib:GetGold(player) < map_t[idx][7] then
            lualib:MsgBox(player, "��Ǹ����û���㹻�Ľ����ս��")
            return ""
        end
        if lualib:ItemCount(player, map_t[idx][5][1]) < map_t[idx][5][2] then
            lualib:MsgBox(player, "��������û������Ҫ�ĵ��ߡ�")
            return ""
        end
        local req, member = check(player, players, idx)
        if req == false then
            lualib:MsgBox(player, "["..member.."]�ȼ��������볬���ӳ�10��")
            return ""
        end
        local map = lualib:Map_CreateDgn(map_t[idx][1], true, map_t[idx][6])
        if map == "" then
            return "�������ݲ����ڡ�"
        end
        lualib:SubGold(player, map_t[idx][7], "��ս����", "��ս����")
        lualib:DelItem(player, map_t[idx][5][1], map_t[idx][5][2], 2, "��ս����", "��ս����")
        for i = 1, #players do
            lualib:SetStr(players[i], "zuduimap", map)
            lualib:Player_SetDgnTicket(players[i], map)
            lualib:Player_EnterDgn(players[i], map_t[idx][1], map_t[idx][2], map_t[idx][3], 0)
            lualib:SetDayInt(players[i],map_count[idx][1],lualib:GetDayInt(players[idx],map_count[i][1]) + 1)
        end

        lualib:SysMsg_SendBroadcastMsg(name.."�����Լ����ŶӴ�����"..map_t[idx][1].."�����Ϊ�������ɣ�", "")
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