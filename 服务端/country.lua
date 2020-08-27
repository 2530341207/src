local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
local countryName = {
    "魏国",
    "蜀国",
    "吴国"
}

function main(player)
    local panbian = lualib:GetInt(player,"panbian")
    local data = "pb=" .. serialize(panbian)

    lualib:ShowFormWithContent(player,"form文件表单","country")
    lualib:ShowFormWithContent(player,"脚本表单",data)
end

function receive(player,num)
    local num = tonumber(num)
    local name =  lualib:KeyName(player)
    local country = lualib:GetStr(player,"countryName")
    local str = ""
    --判断是否加入国家
    if country ~= "" then
        lualib:MsgBox(player,"你已经加入了"..country.."！不能再加入其他国家了！")
        return ""
    end

    if lualib:SetStr(player,"countryName",countryName[num]) then
        lualib:MsgBox(player,"您加入了"..countryName[num].."！")
        lualib:SysMsg_SendBroadcastMsg(tostring("恭喜["..name.."]加入"..countryName[num].."!!!"), "系统公告")
    else
        lualib:MsgBox(player,"系统出现错误，请联系客服处理！")
    end
    lualib:AddBuff(player,countryName[num],0)
    
    str = "【"..countryName[num].."】"
    lualib:SetInt(player,"panbian",0)
    lualib:SetStr(player,"Country",str)
    return ""
end