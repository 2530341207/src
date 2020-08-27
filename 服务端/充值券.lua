local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("form/新排行榜")
local chongzhi = {
    ["充值卡10元"] = 1000,
    ["充值卡50元"] = 5000,
    ["充值卡100元"] = 10000,

}
function main(player,item)
    local player_name = lualib:Name(player)
    local key = lualib:KeyName(item)
    local id = lualib:UserID(player)				--取得玩家的帐号ID.
    lualib:SetDBNum("define_bill"..id,lualib:GetDBNum("define_bill"..id)+chongzhi[key])
    lualib:SysMsg_SendWarnMsg(player, "你充值了"..chongzhi[key].."元宝")
    lualib:SysMsg_SendBroadcastColor("恭喜玩家“"..player_name.."”在线充值获得" .. chongzhi[key] ..  "元宝","[充值提示]", 2, 11)
    lualib:Player_AddIngot(player, chongzhi[key], false, "加元宝：使用元宝道具", player)
    Creat_tage_blee(player)
    lualib:DelayCall(player, 1, "公告牌:chongzhi_paihang", "")
    return true
end
