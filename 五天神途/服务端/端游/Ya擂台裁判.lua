    local width = 420	--�Ի�����

    local heigh = 210	--�Ի���߶�

    local max = 100000	--��ע���Ԫ��

    local min = 1000	--��ע��СԪ��

    local times = 180	--ʱ�䡾��λ�롿��˼����180�����û�˹���ֱ�ӽ���

    local timeId = 1	--��ʱ��ID

    local mapkey = "��̨"	--��ͼ������[��ͨ��ͼ]

    local x = 42	--�����ߴ���mapkeyλ��X

    local y = 43	--�����ߴ���mapkeyλ��Y

    local _x = 43	--�����ߴ���mapkeyλ��_X

    local _y = 45	--�����ߴ���mapkeyλ��_Y

    local __x = 41	--���ڴ���λ��

    local __y = 49	--���ڴ���λ��

    local level = 20	--�ȼ�����

    local gold = 50000	--������Ʊ���Ľ��

    local buff = "����"	--�����߽����ͼ�����buff������[����Ϊ���ߡ���������ͼ��������]

    function main(npc, player)
        return main_ex(player)
    end

    function main_ex(player)
        local msg = [[
    \n  ��̨�ǽ�����˺��д輼�յĵط���
      ������ڴ˰�����̨����������Ӣ����ս��

    \n  #IMAGE1902700033# #OFFSET<Y:-2>#<@bai *01*��Ҫ����>
      #IMAGE1902700018# #OFFSET<Y:-2>#<@gong *01*��Ҫ����>
      #IMAGE1902700018# #OFFSET<Y:-2>#<@levelMap *01*�뿪>
      #IMAGE1902700037# #OFFSET<Y:-2>#<@buy *01*������Ʊ�ۿ�(5����)>
      #IMAGE1902700030# #OFFSET<Y:-2>#<@search *01*�˽�������>
        ]]
        if lualib:Level(player) < level then
            msg = "\n  ������ӹǻ���������Щʱ�������ɡ�"
        end
        lualib:NPCTalkDetail(player, msg, width, heigh)
        return ""
    end

    function levelMap(player)
        lualib:Player_MapMoveXY(player,"����", 255, 270, 5)
        return ""
    end

    function bai(player)
        local map = lualib:Map_GetMapGuid(mapkey)
        lualib:SetPanelSize(player, width, heigh)
        if map == "" then
            return "��ȡ��ͼ����ʧ�ܡ�\n\n\n<@main_ex *01*[������ҳ]>"
        end
        if lualib:GetStr(map, "rolelist") ~= "" then
            return "\n  ��ǰ�Ѿ������ڰ����ˣ����Ե�������\n\n\n  <@main_ex *01*[������ҳ]>"
        end
        lualib:SysMsg_SendInputDlg(player, 18, "��������Ҫ���޵�Ԫ��", 60, 8, "bai_ex", "")
        return ""
    end

    function bai_ex(id, player, ingot)

        if tonumber(ingot) == nil then
            lualib:MsgBox(player, "������һ�������֡�")
            return end

        local ingot = math.floor(tonumber(ingot))
        if ingot < min or ingot > max then
            lualib:MsgBox(player, "������һ��"..min.."-"..max.."�����֣�")
            return end

        local map = lualib:Map_GetMapGuid(mapkey)
        if lualib:GetStr(map, "rolelist") ~= "" then
            return "��ǰ�Ѿ������ڰ����ˣ����Ե�������\n\n\n<@main_ex *01*[������ҳ]>"
        end

        if not lualib:SubIngot(player, ingot, "��̨��", map) then
            lualib:MsgBox(player, "��Ǹ������Ԫ�����㡣")
            return end

        local name = lualib:Name(player)

        lualib:SetStr(map, "rolelist", player.."#"..name.."#"..ingot)

        local msg = "[ϵͳ��Ϣ]:"..name.."����"..ingot.."Ԫ����̨�������Ҫ���ޣ�������̨����Ա��"

        lualib:SysMsg_SendBroadcastMsg(msg, "")

        lualib:MsgBox(player, "���޳ɹ��������ĵȴ������ߡ�")

        lualib:SetInt(map, "second_ex", 0)

        lualib:SetInt(map, "second", 0)

        lualib:AddTimerEx(map, timeId, 1000, -1, "check", name.."#"..ingot)
    end

    function check(map, id, name, ingot)
        local player = lualib:Name2Guid(name)

        local msg = "ϵͳ��ʾ��"..name.."����"..ingot.."Ԫ����̨��������ʿ����Ӧս��ϵͳ�˻���̨Ԫ����"
        lualib:SysMsg_SendBroadcastMsg(tostring(player).."||||"..tostring(name),"111")

        if player == "" or lualib:IsOffline(player) then
            lualib:Mail("��̨��", name, "��������;���ߣ���̨��������ϵͳ������Ѻע��Ԫ����", 0, tonumber(ingot), {})
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
            lualib:AddIngot(player, tonumber(ingot), "��̨������", map)
            lualib:DisableTimer(map, id)
            return end

        lualib:SetInt(map, "second", second)
    end


    function gong(player)
        lualib:SetPanelSize(player, width, heigh)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            return "\n  ��ǰ��û�˰��ޣ��޷����ޡ�\n\n\n  <@main_ex *01*[������ҳ]>"
        end

        local tb = lualib:StrSplit(data, "#")

        if lualib:Name2Guid(tb[2]) == "" or lualib:IsOffline(tb[1]) then
            return "��ǰ��û�˰��ޣ��޷����ޡ�\n\n\n<@main_ex *01*[������ҳ]>"
        end

        if tb[1] == player then
            lualib:MsgBox(player, "��Ǹ�������ܹ��Լ����µ���̨��")
            return end

        if #tb > 3 then
            lualib:MsgBox(player, "�������ˣ��Ѿ����˹����ˡ�")
            return end

        if lualib:GetIngot(player) < tonumber(tb[3]) then
            return "\n  ��ǰ���޵�Ԫ��Ϊ������Ԫ������"..tb[3].."���޷����й��ޡ�\n\n\n  <@main_ex *01*[������ҳ]>"
        end

        local str = "#COLORCOLOR_RED#                ����ȷ�ϣ�\n\n"
        str = str.."#COLORCOLOR_YELLOW#����Ԫ��Ϊ��"..tb[3].."������ȷ��������\n\n"
        str = str.."#BUTTON0#ȷ��#BUTTONEND##BUTTON1#ȡ��#BUTTONEND#"
        lualib:SysMsg_SendMsgDlg(player, 1000, str, 100, "gong_ex", tb[3])
        return ""
    end

    function gong_ex(dlg_id, player, BUTTON_ID, ingot)

        if BUTTON_ID == 1 then return end

        ingot = tonumber(ingot)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            lualib:MsgBox(player, "��ǰ��û�˰��ޣ��޷����ޡ�")
        return end

        local tb = lualib:StrSplit(data, "#")

        if ingot ~= tonumber(tb[3]) then
            lualib:MsgBox(player, "��ȡ���ݳ���")
         return end

        if lualib:Name2Guid(tb[2]) == "" or lualib:IsOffline(tb[1]) then
            lualib:MsgBox(player, "��ǰ��û�˰��ޣ��޷����ޡ�")
            return end

        if tb[1] == player then
            lualib:MsgBox(player, "��Ǹ�������ܹ��Լ����µ���̨��")
            return end

        if #tb > 3 then
            lualib:MsgBox(player, "�������ˣ��Ѿ����˹����ˡ�")
            return end

        if not lualib:SubIngot(player, ingot, "����", map) then
            lualib:MsgBox(player, "��Ǹ������Ԫ�����㣬�޷����ޡ�")
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

        local msg = "ϵͳ��ʾ��"..tb[2].."����"..ingot.."Ԫ����̨���⵽��"..lualib:Name(player).."����ս��1���Ӻ�ʼ��������ҿ�����Ʊ�볡�ۿ���"

        lualib:SysMsg_SendBroadcastMsg(msg, "")

        lualib:AddTimerEx(map, 2, 1000, -1, "��̨��������:on_check", tb[1].."#"..player)
    end

    function buy(player)
        lualib:SetPanelSize(player, width, heigh)

        local map = lualib:Map_GetMapGuid(mapkey)

        local data = lualib:GetStr(map, "rolelist")
        if data == "" then
            return "\n  ��ǰ��û���˰��ޣ����޷�������\n\n\n  <@main_ex *01*[������ҳ]>"
        end

        local tb = lualib:StrSplit(data, "#")

        if #tb <= 3 then
            return "\n  ��ǰ��̨����δ��ʼ�����޷�������\n\n\n  <@main_ex *01*[������ҳ]>"
        end

        if not lualib:SubGold(player, gold, "�ۿ���̨��", player) then
            return "\n  ���Ľ�Ҳ��㣬�޷�������\n\n\n  <@main_ex *01*[������ҳ]>"
        end

        lualib:Player_MapMoveXY(player, mapkey, __x, __y, 1)

        return ""
    end

    function search(player)
        local msg = [[
    \n  1���������˹��޺��Զ�������̨��1���Ӻ�ʼս����
      2��������̨����ֹʹ��ҩƷ��
      3����̨����������װ����
      4����̨������ʹ�������
      5������ϯ���ڲ�����ʹ���κμ��ܡ�
      6�����������ڱ��䣬��Ҫ�Ƚ����󷽿��ٴη�����ޡ�
      7�����޻��޻�ʤ���ɻ��˫��Ѻ���ܺ͵�90%��
      8��Ԫ��Ѻ�������1000��100000֮�䡣
        ]]
        lualib:SetPanelSize(player, width, heigh)
        return msg
    end