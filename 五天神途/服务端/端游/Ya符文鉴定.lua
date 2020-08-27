local runesTable = {
    {"����1","1������",20},
    {"����2","2������",15},
    {"����3","3������",7},
    {"����4","4������",4},
    {"����5","5������",3},
    {"����6","6������",1},
}

local demandHlb = {1500,750}

function main(npc, player)
    local msg = "#COLORCOLOR_GOLD#                        �� �� �� �� �� ��                 #COLOREND#\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_RED# ���Ļ�ȡ��ʽ ��#COLOREND# #COLORCOLOR_GOLD#���з��İ󶨲��ɵ��䣬���ɶ���#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# ֻ��δ�����ķ��Ĳſ��Լ���#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# ���ļ�����أ���������շѣ�1500Ԫ�� �ظ�δ�����շѣ�750Ԫ��#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# �����м��ʳ�1����6������#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700042>#<@Identification *01*����Ҫ�������ġ�>     #IMAGE<ID:1902700042>#<@initialization *01*�����Ļָ���ʼ��>\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end
function Identification(npc,player)
    local num = weights(runesTable)                                   --���ֵ
    local user_id = lualib:UserID(player)
    local itemGuid = lualib:BagItemList(player,true,false,false)
    local item = ""

    for i = 1,#itemGuid do
        if lualib:KeyName(itemGuid[i]) == "δ�����ķ���" then
            item = lualib:KeyName(itemGuid[i])
        end
    end
    if item == "" then
        lualib:MsgBox(player,"���ı���û��δ�����ķ��ģ�")
        return ""
    end
    if not lualib:Player_IsIngotEnough(player,demandHlb[1],false) then
        lualib:MsgBox(player,"����Ԫ�����㣡")
        return ""
    end
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player,"���������޷�������")
        return ""
    end

    lualib:SubIngot(player, demandHlb[1], "�������Ŀ۳�Ԫ��","Ya���ļ���")
    lualib:DelItem(player, "δ�����ķ���", 1, 2, "���ļ���", "Ya���ļ���")
    lualib:AddItem(player,runesTable[num][1],1,true,"��������","Ya���ļ���")
    lualib:MsgBox(player,"��ϲ����������"..runesTable[num][2].."����")
    lualib:SysMsg_SendBroadcastMsg("��ϲ���"..lualib:KeyName(player) .."���������ġ�".. runesTable[num][2] .."��","���ļ���")
    return ""
end

function initialization(npc,player)
    local num = weights(runesTable)                                   --���ֵ
    local user_id = lualib:UserID(player)
    local itemName = ""                                               --��ʼ����������
    local itemGuid = lualib:BagItemList(player,true,false,false)
    for j = 1,#runesTable do
        for i = 1,#itemGuid do
            if lualib:KeyName(itemGuid[i]) == runesTable[j][1] then
                itemName = lualib:KeyName(itemGuid[i])
                break
            end
        end
        if itemName ~= "" then
            break
        end
    end


    if itemName == "" then
        lualib:MsgBox(player,"�㱳����û�пɳ�ʼ����װ����")
        return ""
    end

    if not lualib:Player_IsIngotEnough(player,demandHlb[2],false) then
        lualib:MsgBox(player,"����Ԫ�����㣡")
        return ""
    end

    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player,"���������޷���ԭ��")
        return ""
    end

    lualib:SubIngot(player, demandHlb[1], "��ʼ�����Ŀ۳�Ԫ��","Ya���ļ���")
    lualib:DelItem(player, itemName, 1, 2, "��ԭ����", "Ya���ļ���")
    lualib:AddItem(player,"δ�����ķ���",1,true,"��ԭ����","Ya���ļ���")
    lualib:MsgBox(player,"��ԭ�ɹ���")
    return ""
end

function weights(table)                 --table ��ʽ table = {{...,Ȩ��ֵ},{...,Ȩ��ֵ},{...,Ȩ��ֵ}...}


    local random = 0            --���ֵ
    local max = 0               --ȡֵ��Χ
    local value = 0             --�Ƚ�ֵ
    local num = 0               --����ֵ
    for i=1,#table do
        max = table[i][#table[i]] + max
    end

    random = lualib:GenRandom(1,max)
    for i=1,#table do

        if random > value then
            num = i
        else
            break
        end
        value = value + table[i][#table[i]]
    end

    return num
end