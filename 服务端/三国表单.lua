local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/tools")
local ingotDonation = { --����Ԫ������ �����Ҿ��飬��һ���
    {100,100,10},
    {1000,1000,100}
}

local countryLevel = {                  --���ҵȼ�����
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
    "κ��",
    "���",
    "���"
}

local countryPosition  = {
    "����",
    "ة��",
    "�󽫾�",
    "��˾��",
    "�󶼶�",
}

local countryReward = {     --�ʼ���ʽ
    {
        "�м����",5,1,
        "������",5,1
    },
    {
        "�м����",4,1,
        "������",4,1
    },
    {
        "�м����",3,1,
        "������",3,1
    },
    {
        "�м����",2,1,
        "������",2,1
    },
    {
        "�м����",1,1,
        "������",1,1
    }
}

local rewardProportion = {
    0.1,0.05,0.03,0.02,0.01
}

local countryLevelBuff = {
    "һ������",
    "��������",
    "��������",
    "�ļ�����",
    "�弶����",
    "��������",
    "�߼�����",
    "�˼�����",
    "�ż�����"
}

local countryCopy = {}

local listTable = {}

local listUpate =  {}

function main(player)

    local name =  lualib:KeyName(player)    --�������
    local countryName = lualib:GetStr(player,"countryName")               --��������
    local countryIngots = lualib:GetDBNum(countryName.."Ԫ��")            --����Ԫ��
    local countryIntegral = lualib:GetDBNum(name..countryName.."countryIntegral")        --��һ���
    local str = ""
    local exp = 0
    if countryName == "" then
        lualib:MsgBox(player,"������������ڶ��η��ַ��������ֱ�ӷ�ţ�������")
        return ""
    end
    listTable = {}
    listUpate =  {}
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
        local countryExp = lualib:GetDBNum(countryCopy[i].."����")               --���Ҿ���
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
    lualib:ShowFormWithContent(player,"form�ļ���","����")
    lualib:ShowFormWithContent(player,"�ű���",data)
    return ""
end

function receive(player,num)

    local name =  lualib:KeyName(player)    --�������
    local num = tonumber(num)               --�ͻ��˴�������num
    --local id = lualib:UserID(player)        --��ҵ��ʺ�ID

    local countryName = lualib:GetStr(player,"countryName")

    --�۳�Ԫ���ӻ��ֺ͹��Ҿ���
    if countryName == "" then
        lualib:MsgBox(player,"���ȼ�����ң��ھ���Ԫ������")
        return ""
    end
    if lualib:Player_SubIngot(player,ingotDonation[num][1],false,"���Ҿ���Ԫ��","�����ű�") == false then
        lualib:MsgBox(player,"�۳�Ԫ��ʧ�ܣ�����ϵ�ͷ�����")
        return ""
    end

    lualib:SetDBNumEx(name..countryName.."countryIntegral",lualib:GetDBNum(name..countryName.."countryIntegral") + ingotDonation[num][2],2)           --��һ���


    lualib:SetDBNumEx(countryName.."����",lualib:GetDBNum(countryName.."����") + ingotDonation[num][3],2)               --���Ҿ���
    lualib:SetDBNumEx(countryName.."Ԫ��",math.floor(lualib:GetDBNum(countryName.."Ԫ��")) + ingotDonation[num][3],2)               --����Ԫ��

    local name1 = lualib:GetDBNum(name..countryName.."countryIntegral")
    local name2 = lualib:GetDBNum(countryName.."����")
    local name3 = lualib:GetDBNum(countryName.."Ԫ��")

    --����

    lualib:SetDBStrEx(countryName.."Ranking",lualib:GetDBStr(countryName.."Ranking").."#"..name,6)
    local str = lualib:GetDBStr(countryName.."Ranking")
    --lualib:SysMsg_SendBroadcastMsg(tostring(str),"����")

    local playerGuid = lualib:StrSplit(str,"#")
    local guidTab = table_unique(playerGuid)          --ȥ��

    lualib:SetDBStrEx(countryName.."Ranking","",6)         --��ձ���
    for k,v in pairs(guidTab) do
        if v ~= "" then
            lualib:SetDBStrEx(countryName.."Ranking",lualib:GetDBStr(countryName.."Ranking").."#"..v,6)  --���ȥ��֮��ı���
        end
    end
    local str1 = lualib:GetDBStr(countryName.."Ranking")

    list(player)              --���а�
    refresh(player)

    return ""
end

function receiveIngots(player,num)              --��ȡ��ְ����
    local countryName = lualib:GetStr(player,"countryName")
    local num = tonumber(num)
    local countryIngots = lualib:GetDBNum(countryName.."Ԫ��")
    local ingots = math.floor(countryIngots * rewardProportion[num] )               --��ְ����Ԫ��
    countryIngots = countryIngots - ingots
    lualib:SetDBNumEx(countryName.."Ԫ��",countryIngots,2)
    lualib:MailToPlayer("����ϵͳ",player,countryPosition[num].."����",0,ingots,countryReward[num])
    lualib:SysMsg_SendBroadcastMsg(countryName..countryPosition[num].."��ȡ�˹�ְ����","ϵͳ����")
    lualib:SysMsg_SendPromptMsg(player,countryPosition[num].."�����Ѿ����͵������У���ע����գ�����")
    return ""
end

function refresh(player)                --�޸Ľ���
    local id = lualib:UserID(player)
    local name = lualib:KeyName(player)
    local countryName = lualib:GetStr(player,"countryName")               --��������
    local countryIngots = lualib:GetDBNum(countryName.."Ԫ��")            --����Ԫ��
    local countryIntegral = lualib:GetDBNum(name..countryName.."countryIntegral")    --��һ���
    local str = ""
    local exp = 0
    listTable = {}
    list(player)
    lualib:SysMsg_SendBroadcastMsg(tostring(lualib:GetDBStr(countryName.."Ranking")),"refresh")

    for i=1,#countryCopy do
        local countryExp = lualib:GetDBNum(countryCopy[i].."����")               --���Ҿ���
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
        lualib:SysMsg_SendBroadcastMsg(tostring(listTable[i].name).."\\"..tostring(listTable[i].integral), "����")
    end
    local data = "countryLevel = "..serialize(countryLevel)..";countryIngots = " .. serialize(countryIngots)..";countryIntegral = " .. serialize(countryIntegral).. ";str="..serialize(str)..";listTable = "..serialize(listTable)
    lualib:ShowFormWithContent(player,"�ű���",data)
    lualib:ShowFormWithContent(player,"�ű���",[[resources.upData()]])

end

function list(player)
    local countryName = lualib:GetStr(player,"countryName")               --��������
    local str = lualib:GetDBStr(countryName.."Ranking")
    local playerName = lualib:StrSplit(str,"#")

    for i=2,#playerName do
        lualib:SysMsg_SendBroadcastMsg(tostring(playerName[i]),"����")
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

function upateList()                                                        --ÿ�ո��»�ù�ְ����
    for i=1,#country do
        lualib:SetDBStrEx(country[i].."updateRanking",lualib:GetDBStr(country[i].."excessiveRanking"),6)
        local upateList = lualib:GetDBStr(country[i].."updateRanking")
        for j=1,#countryPosition do
            lualib:SetDBNum(country[i]..countryPosition[j].."Reward",1)
        end
    end
end

function levelUpAddBuff(player)                                                --���ݹ��ҵȼ����buff
    local countryName = lualib:GetStr(player,"countryName")
    local countryExp = lualib:GetDBNum(countryName.."����")               --���Ҿ���
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