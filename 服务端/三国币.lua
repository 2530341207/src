function main(player,itemGuid)
    local item  = lualib:KeyName(itemGuid)
    local count = lualib:ItemCount(player,item)
    if count < 10 then
        lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id) + 1,2)
    else
        lualib:SysMsg_SendInputDlg(player, 1, "输入数量", 60, 30, "delItem",item)
        return false
    end
    return true
end

function delItem(id, player, str, param)
    local num = tonumber(str)
    local user_id = lualib:UserID(player)
    local count = lualib:ItemCount(player,param)
    if tostring(type(num)) ~= "number" then
        lualib:SysPromptMsg(player,"请输入数字！")
        return ""
    end

    if count < num then
        lualib:SysPromptMsg(player,"你的三国币不足"..num.."个，请重新输入！")
        return ""
    end

    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id) + ingotDonation[num][2],2)
    lualib:DelItem(player,param,num,2,"使用三国币","使用三国币道具")

    return ""
end