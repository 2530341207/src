---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Admin.
--- DateTime: 2020/5/19 12:43
---
local timeNum =  0
function receive(player)
    local level = lualib:Level(player)
    if level < 70 then
        lualib:MsgBox(player,"您的等级不足！！请75级以后再来参加！")
        return ""
    end

    if lualib:GetDBNum("fishing") == 1 then
        lualib:Player_MapMoveXY(player,"新西域",115,164,3)
    else
        lualib:MsgBox(player,"活动尚未开始！")
    end
    return ""
end

function active()
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --开区时间字符串
    local startTime = lualib:Str2Time(startTimeStr)                 --开区时间
    local currentTimeStr = lualib:Now()                             --当前时间字符串
    local currentTime = lualib:Str2Time(currentTimeStr)                             --当前时间
    local activitOne = lualib:Str2Time("2020-05-01 14:00:00")                             --当前时间
    local activitTwo = lualib:Str2Time("2020-05-01 22:30:00")                             --当前时间
    local fristTime = startTime % (24 * 60 * 60)
    local map = lualib:Map_GetMapGuid("新西域")
    if (currentTime - startTime) / (70 *60) == 0 then
        lualib:SetDBNum("fishing",1)
        lualib:AddTimer("0", 2020052541, 1000, -1, "fishingOver")
        timeNum = 0
    end

    if ((currentTime - activitOne) % (24 * 60 * 60) == 0 or (currentTime - activitTwo) % (24 * 60 * 60) == 0) and (currentTime > startTime) then
        lualib:AddTimer("0", 2020052541, 1000, -1, "fishingOver")
        lualib:SetDBNum("fishing",1)
        timeNum = 0
    end
end

function fishingOver()
    timeNum = timeNum + 1
    if timeNum == 60*5 then
        lualib:SetDBNum("guild",0)
        lualib:DisableTimer("0",2020052541)
    end
end
