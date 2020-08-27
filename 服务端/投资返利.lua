local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")


local rmuq_tb = {
    1 * 24 * 60 * 60, --开区后时间
    -60 * 60, --开区前时间
    0.1, --奖励倍数
    { 50000,    10 },   --{投资金额，名额}
    { 30000,    50 },
    { 10000,    100 },
}

local investment = {}

function Rmuq(player)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --开区时间字符串
    local startTime = lualib:Str2Time(startTimeStr)                 --开区时间
    local currentTimeStr = lualib:Now()                             --当前时间字符串
    local currentTime = lualib:Str2Time(currentTimeStr)                             --当前时间
    local investmentTime = 0                                        --投资时间
    local id = lualib:UserID(player)
    local nowTime = currentTime - startTime
    local nowTimeCount = math.ceil(nowTime/(24*60*60))
    local data = ""
    local investmentCount = 0

    if  nowTime > rmuq_tb[2] and currentTime - startTime < rmuq_tb[1] then
        investmentTime = 1
        for i = 1,3 do
            table.insert(investment,i,lualib:GetDBNum("investmentYb"..id..i))
        end

        for i = 4,6 do
            table.insert(investment,i,0)
        end

        for i = 7,9 do
            table.insert(investment,i,lualib:GetDBNum("investmentCount"..id..(i-6)))
        end
    else
        investmentTime = 0
        for i = 1,3 do
            table.insert(investment,i,lualib:GetDBNum("investmentYb"..id..i))
        end

        for i=1,3 do
            if investment[i] == 1  then
                table.insert(investment,i+3,lualib:GetDBNum("interest"..id..(nowTimeCount - 1)..i))
            else
                table.insert(investment,i+3,0)
            end
        end

        for i = 7,9 do
            table.insert(investment,i,lualib:GetDBNum("investmentCount"..id..(i-6)))
        end
    end

    data = "investment="..serialize(investment) ..";investmentTime="..serialize(investmentTime)
    lualib:ShowFormWithContent(player, "脚本表单", data)
    lualib:ShowFormWithContent(player, "form文件表单", "元宝投资")
    return ""
end


function rmuq(player, num)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --开区时间字符串
    local startTime = lualib:Str2Time(startTimeStr)                 --开区时间
    local currentTimeStr = lualib:Now()                             --当前时间字符串
    local currentTime = lualib:Str2Time(currentTimeStr)                             --当前时间
    local id = lualib:UserID(player)
    local num = tonumber(num)
    local data = ""
    local nowTime = currentTime - startTime

    if  nowTime > rmuq_tb[2] and currentTime - startTime < rmuq_tb[1] then
        if  lualib:GetDBNum("investmentYb"..id..num) == 1 then
            lualib:MsgBox(player,"您已经投资过该项！！")
            return ""
        end

        if not lualib:Player_SubIngot(player,rmuq_tb[num+3][1],false,"元宝投资成功扣除元宝","投资返利") then
            lualib:MsgBox(player,"您的元宝不足，请充值后再来！！！")
            return ""
        end

        lualib:SetDBNum("investmentYb"..id..num,1)
        lualib:SetDBNum("investmentCount"..id..num,lualib:GetDBNum("investmentCount"..id..num)+1)
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player) .."在元宝投资返利npc处投资】"..rmuq_tb[num+3][1].."元宝！！！","元宝投资返利")
        lualib:MsgBox(player,"投资成功！！！")
        investment[num] = 1
        data = "investment="..serialize(investment)
        lualib:ShowFormWithContent(player,"脚本表单",data)
        lualib:ShowFormWithContent(player,"脚本表单",[[fqpgrmuq.update()]])
    else
        lualib:MsgBox(player,"投资时间未到或是已经结束！！")
    end
    return ""
end

function wybc(player, num)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --开区时间字符串
    local startTime = lualib:Str2Time(startTimeStr)                 --开区时间
    local currentTimeStr = lualib:Now()                             --当前时间字符串
    local currentTime = lualib:Str2Time(currentTimeStr)                             --当前时间
    local id = lualib:UserID(player)
    local num = tonumber(num)
    local nowTime = currentTime - startTime
    local nowTimeCount = math.ceil(nowTime/(24*60*60))
    local addIngotCount = 0
    local data = ""
    if  lualib:GetDBNum("investmentYb"..id..num) == 0 then
        lualib:MsgBox(player,"请先投资，再来领取奖励！！")
        return ""
    end

    if nowTime > 24 * 60 * 60 and nowTime < 8 * 24 * 60 *60 then
        if nowTimeCount > 8 then
            return "活动已经结束"
        end

        if nowTimeCount == 1 then
            if lualib:GetDBNum("principal"..id..num) == 1 then
                lualib:MsgBox(player,"本金已经领取，请明日再来领取利息！！！")
                return ""
            end
            lualib:AddIngot(player,rmuq_tb[num+3][1],"元宝投资返利本金","元宝投资")
            lualib:SetDBNum("principal"..id..num,1)
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】领取投资返利本金【"..rmuq_tb[num+3][1].."元宝】","投资返利")
            lualib:MsgBox(player,"领取本金成功！！！")
            return ""
        else
            if lualib:GetDBNum("principal"..id..num) ~= 1 then
                lualib:AddIngot(player,rmuq_tb[num+3][1],"元宝投资返利本金","元宝投资")
                lualib:SetDBNum("principal"..id..num,1)
                lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】领取投资返利本金【"..rmuq_tb[num+3][1].."元宝】","投资返利")
            end
            if lualib:GetDBNum("interest"..id..(nowTimeCount - 1)..num) == 1 then
                lualib:MsgBox(player,"今日利息已领取，请明日再来领取利息！！！")
                return ""
            end
            lualib:SetDBNum("interest"..id..(nowTimeCount - 1)..num,1)
            lualib:AddIngot(player,rmuq_tb[num+3][1]*rmuq_tb[3],"元宝投资返利本金","元宝投资")
            addIngotCount = rmuq_tb[num+3][1]*rmuq_tb[3]
            lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(player).."】领取投资返利利息【"..addIngotCount.."元宝】","投资返利")
            investment[num+3] = 1
            data = "investment="..serialize(investment)
            lualib:ShowFormWithContent(player, "脚本表单", data)
            lualib:ShowFormWithContent(player, "form文件表单", "元宝投资")
        end
    else
        lualib:SysPromptMsg(player, "领取时间未开始或是已经结束！！！")
        return ""
    end
    return ""
end