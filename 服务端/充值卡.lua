local chongzhi = {
    ["充值卡1元"] = 100,
    ["充值卡2元"] = 200,
    ["充值卡5元"] = 500,
    ["充值卡10元"] = 1000,
    ["充值卡20元"] = 2000,
    ["充值卡50元"] = 5000,
    ["充值卡100元"] = 10000,
    ["充值卡500元"] = 50000,
    ["充值卡1000元"] = 100000,
}

local uniquePlayers = {
    ["1904174055"] =  "白玉堂",
    ["fazq1595"] =  "亚峰",
    ["yza123456"] = "嗲嗲",
}



function main(player,item)
    local player_name = lualib:Name(player)
    local key = lualib:KeyName(item)
    local yb = chongzhi[key]
    local fandain = yb / 5
    local chongzhi_yb = lualib:GetDayInt(player,"chongzhi_yb")
    lualib:Item_Destroy("", item,"充值卡", player)


    local id = lualib:UserID(player)				--取得玩家的帐号ID.

    local define_total = lualib:GetDBNum("define_bill"..id)

    lualib:SetDBNumEx("define_bill"..id, define_total + (chongzhi[key]),2)

    lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..player_name.."”在线充值获得" .. yb ..  "元宝","[充值提示]", 2, 12)


    if key == "充值卡1000元"  then
        lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..player_name.."”在线充值获得" .. yb * 0.2 ..  "元宝","[充值提示]", 2, 12)
        lualib:SetDBNumEx("LJCZL"..id,lualib:GetDBNum("LJCZL"..id)+1200,4)
        lualib:SetDBNumEx("GQHDCZ"..id,lualib:GetDBNum("GQHDCZ"..id)+1200,4)
        lualib:SetDBNumEx("define_bill"..id, lualib:GetDBNum("define_bill"..id) + (chongzhi[key])*0.2,2)
        lualib:DelayCall(player, 300, "抢充礼包:leap", "")

    end

    if key ~= "充值卡1元" and key ~= "充值卡2元" and key ~= "充值卡5元"  then
        local accountName = lualib:AccountName(player)
        local chName = lualib:Name(player)
        if uniquePlayers[accountName] == chName then
            lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..player_name.."”在线充值获得" .. yb * 0.2 ..  "元宝","[充值提示]", 2, 12)
            lualib:Player_AddIngot(player, yb * 0.2, false, "加元宝：使用元宝道具", player)
            local define_bill = lualib:GetDBNum("chongzhi_lb"..id)
            lualib:SetDBNumEx("chongzhi_lb"..id, define_bill + 1.2 * yb,2)
        end
    end

    lualib:Player_AddIngot(player, yb, false, "加元宝：使用元宝道具", player)

    lualib:SetDayInt(player,"chongzhi_yb",chongzhi_yb+yb/100)

    lualib:DelayCall (player,10,"公告牌:chongzhi_paihang","")

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
            local s = "【"..item_name.."】掉落在"..item_map_name.."["..item_map_x..":"..item_map_y.."]！"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        elseif player_name == "攻杀" then
            return
        else
            local s = "【"..player_name.."】在"..item_map_name.."击杀"..m_name.."爆出了【"..item_name.."】！"
            lualib:SysMsg_SendBroadcastColor(s, "", 7, 13)
        end
    else
        return
    end
end