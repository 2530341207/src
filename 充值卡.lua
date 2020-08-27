local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local jine = {
    ["充值卡1元"] = 1,
    ["充值卡2元"] = 2,
    ["充值卡5元"] = 5,
    ["充值卡10元"] = 10,
    ["充值卡20元"] = 20,
    ["充值卡50元"] = 50,
    ["充值卡100元"] = 100,
    ["充值卡500元"] = 500,
    ["充值卡1000元"] = 1000,
}
local bs = 100
local sbl = 0.3

function main(player,item)
    local user_id = lualib:UserID(player)		--取得玩家的帐号ID.
    local today = lualib:GetAllDays(0)
    local key = lualib:KeyName(item)
    local playername = lualib:Name(player)
    local rechargeAmount = lualib:GetTotalBill(player) + 100000 --使用充值卡上榜额度（元宝）
    local chongzhi_card = lualib:GetDBNum("ljczje"..user_id)*100
    lualib:SysMsg_SendBroadcastMsg(tostring(chongzhi_card),"111")
    local yb = jine[key] * 100
    if  jine[key]  == nil then
        lualib:MsgBox(player,"道具挂错了脚本")
        return false
    end
    lualib:SetDBNumEx("claimAmount"..user_id,chongzhi_card,2)
    if jine[key] > 50 then
        lualib:AddIngot(player, jine[key]*bs*(sbl+1), "人民币点道具", lualib:Name(player))
        lualib:SetDBNumEx("mrczje"..today..user_id,lualib:GetDBNum("mrczje"..today..user_id)+jine[key]*(sbl+1),4)
        lualib:SetDBNumEx("ljczje"..user_id,lualib:GetDBNum("ljczje"..user_id)+jine[key]*(sbl+1),4)
        lualib:Item_Destroy(player, item, "使用代金卷", player)
        local s = "#COLORCOLOR_MAGENTA#充值提示#COLORCOLOR_BLUE#：玩家#COLORCOLOR_ORANGE#「"..playername.."」#COLORCOLOR_BLUE#在线充值#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs).."元宝，祝您游戏愉快!"
        local s1= "#COLORCOLOR_MAGENTA#充值提示#COLORCOLOR_BLUE#：玩家#COLORCOLOR_ORANGE#「"..playername.."」#COLORCOLOR_BLUE#在线充值#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs*sbl).."元宝，祝您游戏愉快!"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
        lualib:SysMsg_SendBroadcastColor(s1, "", 1, 12)
        lualib:SysMsg_SendWarnMsg(player, "你充值了"..(jine[key]*bs*(sbl+1)).."元宝")
        --每日抢充
    	if lualib:GetDBNum("GQHD"..user_id) ~= lualib:GetAllDays(0) then
            lualib:SetDBNum("GQHD"..user_id,lualib:GetAllDays(0))
            lualib:SetDBNumEx("GQHDCZ"..user_id,0,4)
        end
        lualib:SetDBNumEx("LJCZL"..user_id,lualib:GetDBNum("LJCZL"..user_id)+(jine[key]*(sbl+1)),4)
        lualib:SetDBNumEx("GQHDCZ"..user_id,lualib:GetDBNum("GQHDCZ"..user_id)+(jine[key]*(sbl+1)),4)
        lualib:DelayCall(player,300,"抢充礼包:leap", "")
        lualib:DelayCall(player,1000,"新排行榜:Creat_tage_blee","")
    else
        if (lualib:GetDBNum("claimAmount"..user_id) + yb) <= rechargeAmount then
            lualib:SetDBNumEx("claimAmount"..user_id,lualib:GetDBNum("claimAmount"..user_id) + yb,2)
            lualib:SetDBNumEx("ljczje"..user_id,lualib:GetDBNum("ljczje"..user_id)+jine[key],4)
            lualib:AddIngot(player, jine[key]*bs, "人民币点道具", lualib:Name(player))
            lualib:Item_Destroy(player, item, "使用代金卷", player)
            local s = "#COLORCOLOR_MAGENTA#充值提示#COLORCOLOR_BLUE#：玩家#COLORCOLOR_ORANGE#「"..playername.."」#COLORCOLOR_BLUE#在线充值#COLORCOLOR_MAGENTA##IMAGE1800000401#"..(jine[key]*bs).."元宝，祝您游戏愉快!"
            lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
            lualib:SysMsg_SendWarnMsg(player, "你充值了"..(jine[key]*bs).."元宝")
            lualib:DelayCall(player,1000,"新排行榜:Creat_tage_blee","")
            --提示剩余上榜金额
            lualib:SysPromptMsg(player," 您的已使用额度为："..lualib:GetDBNum("claimAmount"..user_id).."！")
            lualib:SysPromptMsg(player," 您的充值卡可上榜额度:"..rechargeAmount.."元宝！")
            lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..player_name.."”在线充值获得" .. yb ..  "元宝","[充值提示]", 2, 12)
        else
            lualib:AddIngot(player, jine[key]*bs, "人民币点道具", lualib:Name(player))
            lualib:Item_Destroy(player, item, "使用代金卷", player)
            lualib:SysMsg_SendWarnMsg(player, "你获得了"..(jine[key]*bs).."元宝")
            lualib:SysPromptMsg(player," 您充值卡可上榜的额度已到达上线，只可获取元宝!")
            lualib:SysPromptMsg(player," 您的充值卡可上榜额度:"..rechargeAmount.."元宝！")
            lualib:SysPromptMsg(player," 您的充值卡可上榜额度已使用："..lualib:GetDBNum("claimAmount"..id).."！")
            lualib:SysPromptMsg(player," 充值卡可上榜额度为：1000元 + 您已充值元宝额度！(原来已上榜的不清楚)")
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
            local s = "【"..item_name.."】掉落在"..item_map_name.."["..item_map_x..":"..item_map_y.."]！"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
        else
            local s = "【"..item_name.."】掉落在"..item_map_name.."的["..item_map_x..":"..item_map_y.."]！！！"
            local s1 = "#IMAGE1900300001#["..player_name.."]人品爆发了，在"..item_map_name.."["..item_map_x..":"..item_map_y.."]打出了一个".."【"..item_name.."】！！！"
            lualib:SysMsg_SendCenterMsg(1, s, "")
            lualib:SysMsg_SendBroadcastColor(s1, "", 1, 12)
        end
    else
        return
    end
end
