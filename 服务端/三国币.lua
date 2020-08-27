function main(player,itemGuid)
    local item  = lualib:KeyName(itemGuid)
    local count = lualib:ItemCount(player,item)
    if count < 10 then
        lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id) + 1,2)
    else
        lualib:SysMsg_SendInputDlg(player, 1, "��������", 60, 30, "delItem",item)
        return false
    end
    return true
end

function delItem(id, player, str, param)
    local num = tonumber(str)
    local user_id = lualib:UserID(player)
    local count = lualib:ItemCount(player,param)
    if tostring(type(num)) ~= "number" then
        lualib:SysPromptMsg(player,"���������֣�")
        return ""
    end

    if count < num then
        lualib:SysPromptMsg(player,"��������Ҳ���"..num.."�������������룡")
        return ""
    end

    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id) + ingotDonation[num][2],2)
    lualib:DelItem(player,param,num,2,"ʹ��������","ʹ�������ҵ���")

    return ""
end