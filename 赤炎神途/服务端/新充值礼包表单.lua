local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")


local Items = {	--领取奖励金额，奖励1。。。
    {50,"幸运钥匙", "首充礼包", "开光印"},
    {200,"幸运钥匙", "坐骑3", "开光印"},
    {500,"幸运钥匙", "坐骑4", "开光印"},
    {1000,"幸运钥匙", "坐骑5", "开光印"},

    {2000,"幸运钥匙", "坐骑6", "开光印"},
}

local Nums = {	--奖励数量1。。。
    {1,5, 1, 5},
    {2,20, 1, 20},
    {3,50, 1, 50},
    {4,100, 1, 100},

    {5,200, 1, 200},

}

function WndRefresh(player)

    local id = lualib:UserID(player)		--取得玩家的帐号ID.

    local bill_numss = lualib:GetDBNum("bill_nums_xin_"..id)		--奖励领取次数
    local bill_ingots = lualib:GetDBNum("define_bill"..id)/100
    local xs = 1
    for i=5,#Items do
        if bill_ingots < Items[i][1]	 then
            xs = i
            break
        else if bill_ingots > Items[#Items][1] then
            xs = #Items
        end

        end
    end
    --num：领取次数，bill_ingot：充值金额；Item:Items的Table ；Nums：Num的Table ;xs:显示可以看到奖励
    local data = "num = "..serialize(bill_numss)..";ingot = "..serialize(bill_ingots)..";Item = "..serialize(Items)..";Nums = "..serialize(Nums)..";xs = "..serialize(xs)
    lualib:ShowFormWithContent(player, "脚本表单", data)
    lualib:ShowFormWithContent(player, "form文件表单", "新充值礼包")
    return ""
end

function GetAward(player, num)
    local index = tonumber(num)
    local id = lualib:UserID(player)
    local bill_ingot = lualib:GetDBNum("define_bill"..id)/100

    local bill_nums = lualib:GetDBNum("bill_nums_xin_"..id)			--奖励领取次数
    lualib:SysPromptMsg(player,""..bill_nums..";"..index)
    if index ~= bill_nums + 1  then
        lualib:SysPromptMsg(player, "请不要修改客户端参数!")
        return ""
    end

    if Items[index] == nil then
        lualib:SysPromptMsg(player, "没有可领取的奖品")
        lualib:AddTimerEx(player, 13138, 1, 1, "WndRefresh","")
        return ""
    end

    if bill_ingot < Items[index][1] then
        lualib:SysPromptMsg(player, "无法领取奖励！只要充值金额达到"..Items[index][1].."元便能领取喔！")
        lualib:AddTimerEx(player, 13139, 1, 1, "WndRefresh","")
        return ""
    end

    if lualib:GetBagFree(player) < Nums[index][1] then
        lualib:SysMsg_SendWarnMsg(player, "包裹不足"..Nums[index][1].."个空位！请整理以后再来！")
        lualib:AddTimerEx(player, 13140, 1, 1, "WndRefresh","")
        return ""
    end

    for i=2,#Items[index] do
        if lualib:AddItem(player,Items[index][i],Nums[index][i],false,"累计充值","累计充值") == false then
            lualib:SysMsg_SendWarnMsg(player, "道具错误，请联系客服")
            lualib:AddTimerEx(player, 13141, 1, 1, "WndRefresh","")
        end
    end
    lualib:SetDBNumEx("bill_nums_xin_"..id, index, 2) 	--领取次数增加
    lualib:SysMsg_SendWarnMsg(player, "充值礼包领取成功，请打开包裹查收！")
    lualib:AddTimerEx(player, 13142, 1, 1, "WndRefresh","")
    return ""
end



function Recharge(player)
    local grpid = lualib:GetGroupId()
    local msg = "http://pay.hzyotoy.com/index.do?mod=pay&groupid=" .. grpid
    lualib:SysMsg_SendWebPage(player, msg)
    return ""
end
