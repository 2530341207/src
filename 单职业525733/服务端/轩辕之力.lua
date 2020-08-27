---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ya.
--- DateTime: 2020/4/20 12:41
---
local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")

local violentGold = {   --所需元宝，所需轩辕币
    28888,
    20
}

local open = 0  --是否开启过狂暴之力（1开启，0未开启）

-----------------------图标显示-----------------------------
function xuanyuan_show(player,line,pos)
    AddSEIcon(player, line, pos, "轩辕之力", 1852800410, "轩辕之力", "main", "", "轩辕之力")
    return true
end



-------------------图标被点击-----------------------
function main(player)
    local id = lualib:UserID(player)
    local str = ""
    if lualib:GetDBNum("violent"..id) == 1 then
        open = 1
    else
        open = 0
    end
    str = "open = " .. serialize(open)
    lualib:ShowFormWithContent(player,"脚本表单",str)
    lualib:ShowFormWithContent(player, "form文件表单", "轩辕之力")
    return ""
end

function receive(player,num)
    local num = tonumber(num)
    local id = lualib:UserID(player)
    if lualib:GetDBNum("violent"..id) == 1 then
        lualib:MsgBox(player,"您已经拥有请勿重复点击！！")
        return ""
    end

    if num == 1 then
        if lualib:Player_SubIngot(player,violentGold[num],false,"狂暴之力","狂暴之力")  then
            lualib:AddBuff(player,"狂暴之力",0)
            lualib:SetDBNum("violent"..id,1)
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")

        else
            lualib:MsgBox(player,"您的轩辕币不足！！")
            return ""
        end

    end

    if num == 2 then
        if lualib:Player_SubIntegral(player,violentGold[num],"狂暴之力","狂暴之力")  then
            lualib:AddBuff(player,"狂暴之力",0)
            lualib:SetDBNum("violent"..id,1)
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】获得狂暴之力！！！击杀可获得元宝34444元宝","狂暴之力")

        else
            lualib:MsgBox(player,"您的轩辕币不足！！")
            return ""
        end
    end
    lualib:ShowFormWithContent(player,"脚本表单",[[violent.update()]])
    return ""
end
