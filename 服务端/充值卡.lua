local chongzhi = {
    ["��ֵ��1Ԫ"] = 100,
    ["��ֵ��2Ԫ"] = 200,
    ["��ֵ��5Ԫ"] = 500,
    ["��ֵ��10Ԫ"] = 1000,
    ["��ֵ��20Ԫ"] = 2000,
    ["��ֵ��50Ԫ"] = 5000,
    ["��ֵ��100Ԫ"] = 10000,
    ["��ֵ��500Ԫ"] = 50000,
    ["��ֵ��1000Ԫ"] = 100000,
}

local uniquePlayers = {
    ["1904174055"] =  "������",
    ["fazq1595"] =  "�Ƿ�",
    ["yza123456"] = "����",
}



function main(player,item)
    local player_name = lualib:Name(player)
    local key = lualib:KeyName(item)
    local yb = chongzhi[key]
    local fandain = yb / 5
    local chongzhi_yb = lualib:GetDayInt(player,"chongzhi_yb")
    lualib:Item_Destroy("", item,"��ֵ��", player)


    local id = lualib:UserID(player)				--ȡ����ҵ��ʺ�ID.

    local define_total = lualib:GetDBNum("define_bill"..id)

    lualib:SetDBNumEx("define_bill"..id, define_total + (chongzhi[key]),2)

    lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..player_name.."�����߳�ֵ���" .. yb ..  "Ԫ��","[��ֵ��ʾ]", 2, 12)


    if key == "��ֵ��1000Ԫ"  then
        lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..player_name.."�����߳�ֵ���" .. yb * 0.2 ..  "Ԫ��","[��ֵ��ʾ]", 2, 12)
        lualib:SetDBNumEx("LJCZL"..id,lualib:GetDBNum("LJCZL"..id)+1200,4)
        lualib:SetDBNumEx("GQHDCZ"..id,lualib:GetDBNum("GQHDCZ"..id)+1200,4)
        lualib:SetDBNumEx("define_bill"..id, lualib:GetDBNum("define_bill"..id) + (chongzhi[key])*0.2,2)
        lualib:DelayCall(player, 300, "�������:leap", "")

    end

    if key ~= "��ֵ��1Ԫ" and key ~= "��ֵ��2Ԫ" and key ~= "��ֵ��5Ԫ"  then
        local accountName = lualib:AccountName(player)
        local chName = lualib:Name(player)
        if uniquePlayers[accountName] == chName then
            lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..player_name.."�����߳�ֵ���" .. yb * 0.2 ..  "Ԫ��","[��ֵ��ʾ]", 2, 12)
            lualib:Player_AddIngot(player, yb * 0.2, false, "��Ԫ����ʹ��Ԫ������", player)
            local define_bill = lualib:GetDBNum("chongzhi_lb"..id)
            lualib:SetDBNumEx("chongzhi_lb"..id, define_bill + 1.2 * yb,2)
        end
    end

    lualib:Player_AddIngot(player, yb, false, "��Ԫ����ʹ��Ԫ������", player)

    lualib:SetDayInt(player,"chongzhi_yb",chongzhi_yb+yb/100)

    lualib:DelayCall (player,10,"������:chongzhi_paihang","")

    return true
end

function on_create(item)
    lualib:AddTimerEx(item, 1, 500, 1, "tip", "")
end

function tip(item)
    local item_name = lualib:Name(item)
    local item_map_guid = lualib:MapGuid(item)
    local item_map_name = lualib:Name(item_map_guid)
    local item_map_x = lualib:X(item)
    local item_map_y = lualib:Y(item)
    local item_role = lualib:ItemRole(item)
    local player_name = lualib:Name(item_role)

    local drophost = lualib:ItemDropHost(item)
    local m_name = ""

    if lualib:Monster_IsMonster(drophost) then
        m_name = lualib:Name(drophost)
    end

    if item_map_x < 20000 then
        if player_name == "" then
            local s = "��"..item_name.."��������"..item_map_name.."["..item_map_x..":"..item_map_y.."]��"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        elseif player_name == "��ɱ" then
            return
        else
            local s = "��"..player_name.."����"..item_map_name.."��ɱ"..m_name.."�����ˡ�"..item_name.."����"
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        end
    else
        return
    end
end