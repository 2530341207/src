local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local jine = {
    ["��ֵ��1Ԫ"] = 1,
    ["��ֵ��2Ԫ"] = 2,
    ["��ֵ��5Ԫ"] = 5,
    ["��ֵ��10Ԫ"] = 10,
    ["��ֵ��20Ԫ"] = 20,
    ["��ֵ��50Ԫ"] = 50,
    ["��ֵ��100Ԫ"] = 100,
    ["��ֵ��500Ԫ"] = 500,
    ["��ֵ��1000Ԫ"] = 1000,
}
local bs = 100
local sbl = 0.3

function main(player,item)
    local user_id = lualib:UserID(player)		--ȡ����ҵ��ʺ�ID.
    local today = lualib:GetAllDays(0)
    local key = lualib:KeyName(item)
    local playername = lualib:Name(player)
    local rechargeAmount = lualib:GetTotalBill(player) + 100000 --ʹ�ó�ֵ���ϰ��ȣ�Ԫ����
    local chongzhi_card = lualib:GetDBNum("ljczje"..user_id)*100
    lualib:SysMsg_SendBroadcastMsg(tostring(chongzhi_card),"111")
    local yb = jine[key] * 100
    if  jine[key]  == nil then
        lualib:MsgBox(player,"���߹Ҵ��˽ű�")
        return false
    end
    lualib:SetDBNumEx("claimAmount"..user_id,chongzhi_card,2)
    if jine[key] > 50 then
        lualib:AddIngot(player, jine[key]*bs*(sbl+1), "����ҵ����", lualib:Name(player))
        lualib:SetDBNumEx("mrczje"..today..user_id,lualib:GetDBNum("mrczje"..today..user_id)+jine[key]*(sbl+1),4)
        lualib:SetDBNumEx("ljczje"..user_id,lualib:GetDBNum("ljczje"..user_id)+jine[key]*(sbl+1),4)
        lualib:Item_Destroy(player, item, "ʹ�ô����", player)
        local s = "#COLORCOLOR_MAGENTA#��ֵ��ʾ#COLORCOLOR_BLUE#�����#COLORCOLOR_ORANGE#��"..playername.."��#COLORCOLOR_BLUE#���߳�ֵ#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs).."Ԫ����ף����Ϸ���!"
        local s1= "#COLORCOLOR_MAGENTA#��ֵ��ʾ#COLORCOLOR_BLUE#�����#COLORCOLOR_ORANGE#��"..playername.."��#COLORCOLOR_BLUE#���߳�ֵ#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs*sbl).."Ԫ����ף����Ϸ���!"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
        lualib:SysMsg_SendBroadcastColor(s1, "", 1, 12)
        lualib:SysMsg_SendWarnMsg(player, "���ֵ��"..(jine[key]*bs*(sbl+1)).."Ԫ��")
        --ÿ������
    	if lualib:GetDBNum("GQHD"..user_id) ~= lualib:GetAllDays(0) then
            lualib:SetDBNum("GQHD"..user_id,lualib:GetAllDays(0))
            lualib:SetDBNumEx("GQHDCZ"..user_id,0,4)
        end
        lualib:SetDBNumEx("LJCZL"..user_id,lualib:GetDBNum("LJCZL"..user_id)+(jine[key]*(sbl+1)),4)
        lualib:SetDBNumEx("GQHDCZ"..user_id,lualib:GetDBNum("GQHDCZ"..user_id)+(jine[key]*(sbl+1)),4)
        lualib:DelayCall(player,300,"�������:leap", "")
        lualib:DelayCall(player,1000,"�����а�:Creat_tage_blee","")
    else
        if (lualib:GetDBNum("claimAmount"..user_id) + yb) <= rechargeAmount then
            lualib:SetDBNumEx("claimAmount"..user_id,lualib:GetDBNum("claimAmount"..user_id) + yb,2)
            lualib:SetDBNumEx("ljczje"..user_id,lualib:GetDBNum("ljczje"..user_id)+jine[key],4)
            lualib:AddIngot(player, jine[key]*bs, "����ҵ����", lualib:Name(player))
            lualib:Item_Destroy(player, item, "ʹ�ô����", player)
            local s = "#COLORCOLOR_MAGENTA#��ֵ��ʾ#COLORCOLOR_BLUE#�����#COLORCOLOR_ORANGE#��"..playername.."��#COLORCOLOR_BLUE#���߳�ֵ#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs).."Ԫ����ף����Ϸ���!"
            lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
            lualib:SysMsg_SendWarnMsg(player, "���ֵ��"..(jine[key]*bs).."Ԫ��")
            lualib:DelayCall(player,1000,"�����а�:Creat_tage_blee","")
            --��ʾʣ���ϰ���
            lualib:SysPromptMsg(player," ������ʹ�ö��Ϊ��"..lualib:GetDBNum("claimAmount"..user_id).."��")
            lualib:SysPromptMsg(player," ���ĳ�ֵ�����ϰ���:"..rechargeAmount.."Ԫ����")
            lualib:SysMsg_SendBroadcastColor("��ϲ��ҡ�"..player_name.."�����߳�ֵ���" .. yb ..  "Ԫ��","[��ֵ��ʾ]", 2, 12)
        else
            lualib:AddIngot(player, jine[key]*bs, "����ҵ����", lualib:Name(player))
            lualib:Item_Destroy(player, item, "ʹ�ô����", player)
            lualib:SysMsg_SendWarnMsg(player, "������"..(jine[key]*bs).."Ԫ��")
            lualib:SysPromptMsg(player," ����ֵ�����ϰ�Ķ���ѵ������ߣ�ֻ�ɻ�ȡԪ��!")
            lualib:SysPromptMsg(player," ���ĳ�ֵ�����ϰ���:"..rechargeAmount.."Ԫ����")
            lualib:SysPromptMsg(player," ���ĳ�ֵ�����ϰ�����ʹ�ã�"..lualib:GetDBNum("claimAmount"..id).."��")
            lualib:SysPromptMsg(player," ��ֵ�����ϰ���Ϊ��1000Ԫ + ���ѳ�ֵԪ����ȣ�(ԭ�����ϰ�Ĳ����)")
        end
    end

    return false
end



function on_create(item)


end

function tip(item)
    local item_name = lualib:Name(item)
    local item_map_guid = lualib:MapGuid(item)
    local item_map_name = lualib:Name(item_map_guid)
    local item_map_x = lualib:X(item)
    local item_map_y = lualib:Y(item)
    local item_role = lualib:ItemRole(item)
    local player_name = lualib:Name(item_role)

    if item_map_x < 20000 then
        if player_name == "" then
            local s = "��"..item_name.."��������"..item_map_name.."["..item_map_x..":"..item_map_y.."]��"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
        else
            local s = "��"..item_name.."��������"..item_map_name.."��["..item_map_x..":"..item_map_y.."]������"
            local s1 = "#IMAGE1900300001#["..player_name.."]��Ʒ�����ˣ���"..item_map_name.."["..item_map_x..":"..item_map_y.."]�����һ��".."��"..item_name.."��������"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s1, "", 1, 12)
        end
    else
        return
    end
end
