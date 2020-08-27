local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")


local rmuq_tb = {
    1 * 24 * 60 * 60, --������ʱ��
    -60 * 60, --����ǰʱ��
    0.1, --��������
    { 50000,    10 },   --{Ͷ�ʽ�����}
    { 30000,    50 },
    { 10000,    100 },
}

local investment = {}

function Rmuq(player)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --����ʱ���ַ���
    local startTime = lualib:Str2Time(startTimeStr)                 --����ʱ��
    local currentTimeStr = lualib:Now()                             --��ǰʱ���ַ���
    local currentTime = lualib:Str2Time(currentTimeStr)                             --��ǰʱ��
    local investmentTime = 0                                        --Ͷ��ʱ��
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
    lualib:ShowFormWithContent(player, "�ű���", data)
    lualib:ShowFormWithContent(player, "form�ļ���", "Ԫ��Ͷ��")
    return ""
end


function rmuq(player, num)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --����ʱ���ַ���
    local startTime = lualib:Str2Time(startTimeStr)                 --����ʱ��
    local currentTimeStr = lualib:Now()                             --��ǰʱ���ַ���
    local currentTime = lualib:Str2Time(currentTimeStr)                             --��ǰʱ��
    local id = lualib:UserID(player)
    local num = tonumber(num)
    local data = ""
    local nowTime = currentTime - startTime

    if  nowTime > rmuq_tb[2] and currentTime - startTime < rmuq_tb[1] then
        if  lualib:GetDBNum("investmentYb"..id..num) == 1 then
            lualib:MsgBox(player,"���Ѿ�Ͷ�ʹ������")
            return ""
        end

        if not lualib:Player_SubIngot(player,rmuq_tb[num+3][1],false,"Ԫ��Ͷ�ʳɹ��۳�Ԫ��","Ͷ�ʷ���") then
            lualib:MsgBox(player,"����Ԫ�����㣬���ֵ������������")
            return ""
        end

        lualib:SetDBNum("investmentYb"..id..num,1)
        lualib:SetDBNum("investmentCount"..id..num,lualib:GetDBNum("investmentCount"..id..num)+1)
        lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(player) .."��Ԫ��Ͷ�ʷ���npc��Ͷ�ʡ�"..rmuq_tb[num+3][1].."Ԫ��������","Ԫ��Ͷ�ʷ���")
        lualib:MsgBox(player,"Ͷ�ʳɹ�������")
        investment[num] = 1
        data = "investment="..serialize(investment)
        lualib:ShowFormWithContent(player,"�ű���",data)
        lualib:ShowFormWithContent(player,"�ű���",[[fqpgrmuq.update()]])
    else
        lualib:MsgBox(player,"Ͷ��ʱ��δ�������Ѿ���������")
    end
    return ""
end

function wybc(player, num)
    local startTimeStr = lualib:GetConstVar("StartServerTime")      --����ʱ���ַ���
    local startTime = lualib:Str2Time(startTimeStr)                 --����ʱ��
    local currentTimeStr = lualib:Now()                             --��ǰʱ���ַ���
    local currentTime = lualib:Str2Time(currentTimeStr)                             --��ǰʱ��
    local id = lualib:UserID(player)
    local num = tonumber(num)
    local nowTime = currentTime - startTime
    local nowTimeCount = math.ceil(nowTime/(24*60*60))
    local addIngotCount = 0
    local data = ""
    if  lualib:GetDBNum("investmentYb"..id..num) == 0 then
        lualib:MsgBox(player,"����Ͷ�ʣ�������ȡ��������")
        return ""
    end

    if nowTime > 24 * 60 * 60 and nowTime < 8 * 24 * 60 *60 then
        if nowTimeCount > 8 then
            return "��Ѿ�����"
        end

        if nowTimeCount == 1 then
            if lualib:GetDBNum("principal"..id..num) == 1 then
                lualib:MsgBox(player,"�����Ѿ���ȡ��������������ȡ��Ϣ������")
                return ""
            end
            lualib:AddIngot(player,rmuq_tb[num+3][1],"Ԫ��Ͷ�ʷ�������","Ԫ��Ͷ��")
            lualib:SetDBNum("principal"..id..num,1)
            lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(player).."����ȡͶ�ʷ�������"..rmuq_tb[num+3][1].."Ԫ����","Ͷ�ʷ���")
            lualib:MsgBox(player,"��ȡ����ɹ�������")
            return ""
        else
            if lualib:GetDBNum("principal"..id..num) ~= 1 then
                lualib:AddIngot(player,rmuq_tb[num+3][1],"Ԫ��Ͷ�ʷ�������","Ԫ��Ͷ��")
                lualib:SetDBNum("principal"..id..num,1)
                lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(player).."����ȡͶ�ʷ�������"..rmuq_tb[num+3][1].."Ԫ����","Ͷ�ʷ���")
            end
            if lualib:GetDBNum("interest"..id..(nowTimeCount - 1)..num) == 1 then
                lualib:MsgBox(player,"������Ϣ����ȡ��������������ȡ��Ϣ������")
                return ""
            end
            lualib:SetDBNum("interest"..id..(nowTimeCount - 1)..num,1)
            lualib:AddIngot(player,rmuq_tb[num+3][1]*rmuq_tb[3],"Ԫ��Ͷ�ʷ�������","Ԫ��Ͷ��")
            addIngotCount = rmuq_tb[num+3][1]*rmuq_tb[3]
            lualib:SysMsg_SendBroadcastMsg("��ҡ�"..lualib:KeyName(player).."����ȡͶ�ʷ�����Ϣ��"..addIngotCount.."Ԫ����","Ͷ�ʷ���")
            investment[num+3] = 1
            data = "investment="..serialize(investment)
            lualib:ShowFormWithContent(player, "�ű���", data)
            lualib:ShowFormWithContent(player, "form�ļ���", "Ԫ��Ͷ��")
        end
    else
        lualib:SysPromptMsg(player, "��ȡʱ��δ��ʼ�����Ѿ�����������")
        return ""
    end
    return ""
end