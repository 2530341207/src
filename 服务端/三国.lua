local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/tools")
local ingotDonation = { --捐献元宝数量 ，国家经验（三国币比例），国家元宝
    {100,100,10},
    {1000,1000,100}
}

local countryLevel = {                  --国家等级经验
    2000,
    5000,
    10000,
    20000,
    40000,
    80000,
    160000,
    320000,
    640000
}

local country = {
    "魏国",
    "蜀国",
    "吴国"
}

local countryPosition  = {
    "国王",
    "丞相",
    "大将军",
    "大司马",
    "大都督",
}

local countryReward = {     --邮件格式
    {
        "中级复活丹",5,1,
        "火焰令",5,1
    },
    {
        "中级复活丹",4,1,
        "火焰令",4,1
    },
    {
        "中级复活丹",3,1,
        "火焰令",3,1
    },
    {
        "中级复活丹",2,1,
        "火焰令",2,1
    },
    {
        "中级复活丹",1,1,
        "火焰令",1,1
    }
}

local rewardProportion = {
    0.1,0.05,0.03,0.02,0.01
}

local countryLevelBuff = {
    "一级国家",
    "二级国家",
    "三级国家",
    "四级国家",
    "五级国家",
    "六级国家",
    "七级国家",
    "八级国家",
    "九级国家"
}

local countryCopy = {}

local listTable = {}

local listUpate =  {}

function main(player)
    local name =  lualib:KeyName(player)    --玩家名字
    local countryName = lualib:GetStr(player,"countryName")               --所属国家
    local countryIngots = lualib:GetDBNum(countryName.."元宝")            --国家元宝
    local countryIntegral = lualib:GetDBNum(name..countryName.."countryIntegral")        --玩家积分
    local str = ""
    local exp = 0
    listTable = {}
    listUpate =  {}
    if countryName == "" then
        lualib:MsgBox(player,"请正规操作，第二次发现非正规操作直接封号！！！！")
        return ""
    end
    list(player)
    local strSplit = lualib:GetDBStr(countryName.."updateRanking")
    local str = ""
    local strTable = lualib:StrSplit(strSplit,"#")

    for i=2,#strTable do

        listUpate[i-1] = strTable[i]
    end

    countryCopy[1] = countryName
    local copyNum = 1
    for i=1,#country do
        if country[i] ~= countryName then
            copyNum = copyNum + 1
            countryCopy[copyNum] = country[i]
        end
    end

    for i=1,#countryCopy do
        local countryExp = lualib:GetDBNum(countryCopy[i].."经验")               --国家经验
        local exp = countryExp
        local count = 0
        local num = 0
        local level = 0
        for j=1,#countryLevel do
            count =  count + countryLevel[j]
            if countryExp - count < 0 then
                level = j
                for k=1,level-1 do
                    exp = exp - countryLevel[k]
                end
                break
            end
        end
        str = str .. countryCopy[i] .."#".. level .."#"..exp.."#"
    end

    local data = "countryLevel = "..serialize(countryLevel)..";countryIngots = " .. serialize(countryIngots)..";countryIntegral = " .. serialize(countryIntegral)..";str="..serialize(str)..";listTable = "..serialize(listTable)..";listUpate =" .. serialize(listUpate)
    lualib:ShowFormWithContent(player,"form文件表单","三国")
    lualib:ShowFormWithContent(player,"脚本表单",data)
    return ""
end

function receive(player,num)

    local name =  lualib:KeyName(player)    --玩家名字
    local num = tonumber(num)               --客户端传回数据num
    --local id = lualib:UserID(player)        --玩家的帐号ID

    local countryName = lualib:GetStr(player,"countryName")

    --扣除元宝加积分和国家经验
    if countryName == "" then
        lualib:MsgBox(player,"请先加入国家，在捐献元宝！！")
        return ""
    end
    if lualib:Player_SubIngot(player,ingotDonation[num][1],false,"国家捐献元宝","三国脚本") == false then
        lualib:MsgBox(player,"元宝不足，无法捐赠！")
        return ""
    end

    lualib:SetInt(player,lualib:GetInt(player,"bxb") + ingotDonation[num][2])
    lualib:SetDBNumEx(name..countryName.."countryIntegral",lualib:GetDBNum(name..countryName.."countryIntegral") + ingotDonation[num][2],2)           --玩家积分
    lualib:SetDBNumEx(countryName.."经验",lualib:GetDBNum(countryName.."经验") + ingotDonation[num][3],2)               --国家经验
    lualib:SetDBNumEx(countryName.."元宝",math.floor(lualib:GetDBNum(countryName.."元宝")) + ingotDonation[num][3],2)               --国家元宝

    local name1 = lualib:GetDBNum(name..countryName.."countryIntegral")
    local name2 = lualib:GetDBNum(countryName.."经验")
    local name3 = lualib:GetDBNum(countryName.."元宝")

    --排序

    lualib:SetDBStrEx(countryName.."Ranking",lualib:GetDBStr(countryName.."Ranking").."#"..name,6)
    local str = lualib:GetDBStr(countryName.."Ranking")
    --lualib:SysMsg_SendBroadcastMsg(tostring(str),"捐献")

    local playerGuid = lualib:StrSplit(str,"#")
    local guidTab = table_unique(playerGuid)          --去重

    lualib:SetDBStrEx(countryName.."Ranking","",6)         --清空变量
    for k,v in pairs(guidTab) do
        if v ~= "" then
            lualib:SetDBStrEx(countryName.."Ranking",lualib:GetDBStr(countryName.."Ranking").."#"..v,6)  --添加去重之后的变量
        end
    end
    local str1 = lualib:GetDBStr(countryName.."Ranking")

    list(player)              --排行榜
    refresh(player)

    return ""
end

function receiveIngots(player,num)              --领取官职奖励
    local countryName = lualib:GetStr(player,"countryName")
    local num = tonumber(num)
    local countryIngots = lualib:GetDBNum(countryName.."元宝")
    local ingots = math.floor(countryIngots * rewardProportion[num] )               --官职奖励元宝
    countryIngots = countryIngots - ingots
    lualib:SetDBNumEx(countryName.."元宝",countryIngots,2)

    --lualib:SysMsg_SendBroadcastMsg(tostring(num),"领取奖励")

    lualib:MailToPlayer("国家系统",player,countryPosition[num].."奖励",0,ingots,countryReward[num])
    lualib:SysMsg_SendBroadcastMsg(countryName..countryPosition[num].."领取了官职奖励","系统公告")
    lualib:SysMsg_SendPromptMsg(player,countryPosition[num].."奖励已经发送到邮箱中，请注意查收！！！")
    return ""
end

function refresh(player)                --修改界面
    local id = lualib:UserID(player)
    local name = lualib:KeyName(player)
    local countryName = lualib:GetStr(player,"countryName")               --所属国家
    local countryIngots = lualib:GetDBNum(countryName.."元宝")            --国家元宝
    local countryIntegral = lualib:GetDBNum(name..countryName.."countryIntegral")    --玩家积分
    local str = ""
    local exp = 0
    listTable = {}
    list(player)
    lualib:SysMsg_SendBroadcastMsg(tostring(lualib:GetDBStr(countryName.."Ranking")),"refresh")

    for i=1,#countryCopy do
        local countryExp = lualib:GetDBNum(countryCopy[i].."经验")               --国家经验
        local exp = countryExp
        local count = 0
        local num = 0
        local level = 0

        for j=1,#countryLevel do
            count =  count + countryLevel[j]
            if countryExp - count < 0 then
                level = j
                for k=1,level-1 do
                    exp = exp - countryLevel[k]
                end
                break
            end
        end

        str = str .. countryCopy[i] .."#".. level .."#"..exp.."#"
    end
    for i=1,#listTable do
        lualib:SysMsg_SendBroadcastMsg(tostring(listTable[i].name).."\\"..tostring(listTable[i].integral), "排序")
    end
    local data = "countryLevel = "..serialize(countryLevel)..";countryIngots = " .. serialize(countryIngots)..";countryIntegral = " .. serialize(countryIntegral).. ";str="..serialize(str)..";listTable = "..serialize(listTable)
    lualib:ShowFormWithContent(player,"脚本表单",data)
    lualib:ShowFormWithContent(player,"脚本表单",[[resources.upData()]])

end

function list(player)
    local countryName = lualib:GetStr(player,"countryName")               --所属国家
    local str = lualib:GetDBStr(countryName.."Ranking")
    local playerName = lualib:StrSplit(str,"#")

    for i=2,#playerName do
        lualib:SysMsg_SendBroadcastMsg(tostring(playerName[i]),"排行")
        local insertTable = {}
        local name = playerName[i]
        local integral = lualib:GetDBNum(name..countryName.."countryIntegral")
        table.insert(insertTable,"integral")
        insertTable.integral = integral
        table.insert(insertTable,"name")
        insertTable.name = name
        table.insert(listTable,insertTable)
    end

    table.sort(listTable,function(a,b) return a.integral>b.integral end )
    lualib:SetDBStrEx(countryName.."excessiveRanking","",6)
    for i in pairs(listTable) do
        local name  = listTable[i].name
        lualib:SetDBStrEx(countryName.."excessiveRanking",lualib:GetDBStr(countryName.."excessiveRanking").."#"..name,6)
    end
end

function upateList()                                                        --每日更新获得官职的人
   lualib:SysMsg_SendBroadcastMsg("来了","upateList")

    for i=1,#country do
        lualib:SetDBStrEx(country[i].."updateRanking",lualib:GetDBStr(country[i].."excessiveRanking"),6)
        local upateList = lualib:GetDBStr(country[i].."updateRanking")
        for j=1,#countryPosition do
            lualib:SetDBNum(country[i]..countryPosition[j].."Reward",1)
        end
    end
end

function levelUpAddBuff(player)                                                --根据国家等级添加buff
    local countryName = lualib:GetStr(player,"countryName")
    local countryExp = lualib:GetDBNum(countryName.."经验")               --国家经验
    local level = 0
    local count = 0
    for i=1,#countryLevel do
        count =  count + countryLevel[i]
        if countryExp - count < 0 then
            level = i
            break
        end
    end

    if lualib:HasBuff(player,countryLevelBuff[level]) == false then
        lualib:AddBuff(player,countryLevelBuff[level],0)
    end
    return ""
end