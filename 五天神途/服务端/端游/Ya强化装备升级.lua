local equipmentAttr = {
    [1] = {                             --����
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30,30,30,10,10},
        {"��������","����ħ��","����ս��","����ħ��","��������","����ս��"}
    },
    [2] = {                             --ͷ��
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ħ��","����ս��"}
    },
    [3] = {                             --������
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [4] = {                             --������
        {10,12,14,6,5},                 --�﹥���ߣ�ħ�����ߣ��������ߣ����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [5] = {                             --�·�
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30,30,30,10,10},
        {"��������","�������","��������","�������"}
    },
    [7] = {                             --Ь��
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħѥ","������ѥ","����սѥ","����ħѥ","������ѥ","����սѥ"}
    },
    [8] = {                             --����
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [9] =  {                            --����
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [10] = {                            --�����
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [11] = {                            --�ҽ���
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ħ��","��������","����ս��","����ħ��","��������","����ս��"}
    },
    [12] = {                            --ѫ��
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"����ѫ��","����ѫ��"}
    },
    [19] = {                            --����
        {10,12,14,16,6,8},              --�﹥���ߣ�ħ�����ߣ��������ߣ����У����,ħ��
        {50,50,50,50,50,30},
        {"��������","��������"}
    },
}

local attributeName = {"�﹥����","ħ������","��������","����","���","ħ��"}
local ingots = {500,500,500,500,500,500}      --������Ӧ��������Ҫ��Ԫ��

function main(npc, player)
    local msg = "#COLORCOLOR_RED#ע�⣺ʢ����������ϵ�����ǿ��6�㣬ʢ����������һ���������10��#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE#       ��ħ����ħ500Ԫ����������1�㡾30%�ɹ��ʡ�\n        ����׼������������Ʒ500Ԫ������׼��Ҫ500Ԫ����\n      ע�⣺�����Ҫ������װ������װ�����ڡ�#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   �������������Щ����������Щ����������Щ�����������#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ��#COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:0,Y:-2># <@InfoItemRefine#1 *01*��������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># �� #COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#5 *01*�·�����>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0># �� #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#19 *01*��������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># �� #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#12 *01*ѫ������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># ��#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   �������������੤���������੤���������੤����������#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ��#COLOREND##OFFSET<X:0,Y:-2>##OFFSET<X:0,Y:0># <@InfoItemRefine#2 *01*ͷ������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># �� #COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#9 *01*��������>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0># �� #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#8 *01*��������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># �� #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#7 *01*Ь������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># ��#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   �������������੤���������੤���������੤����������#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ��#COLOREND##OFFSET<X:0,Y:-2>##OFFSET<X:0,Y:0>#<@InfoItemRefine#10 *01*���ָ����>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#��#COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#11 *01*�ҽ�ָ����>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0>#��#COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#3 *01*����������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#��#COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#4 *01*����������>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#��#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   �������������ة����������ة����������ة�����������#COLOREND#\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 430, 240)
    return""
end

function InfoItemRefine(npc, player,num)
    num = tonumber(num)

    local msg = "\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#1#"..num.." *01*������������>#COLORCOLOR_RED#     ���� ��ǿ��1���Ե� ��Ҫ->300Ԫ��#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#2#"..num.." *01*������ħ����>#COLORCOLOR_RED#     ħ�� ��ǿ��1���Ե� ��Ҫ->300Ԫ��#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#3#"..num.." *01*������������>#COLORCOLOR_RED#     ���� ��ǿ��1���Ե� ��Ҫ->300Ԫ��#COLOREND#\n\n"
    if num == 1 then
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#4#"..num.." *01*��������׼��>#COLORCOLOR_RED#     ��׼ ��ǿ��1���Ե� ��Ҫ->500Ԫ��#COLOREND#\n\n"
    end

    if num ~= 9 and num ~= 1 then
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#5#"..num.." *01*������������>#COLORCOLOR_RED#     ���� ��ǿ��1���Ե� ��Ҫ->300Ԫ��#COLOREND#\n\n"
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#6#"..num.." *01*������ħ����>#COLORCOLOR_RED#     ħ�� ��ǿ��1���Ե� ��Ҫ->300Ԫ��#COLOREND#\n\n"
    end

    msg = msg.."#COLORCOLOR_GREENG#��ܰ��ʾ�������Ҫ������װ������װ�����ϣ�#COLOREND#"
    msg = msg.."  #IMAGE<ID:1902700019>#<@main *01*�����ء�>"
    return msg
end

function strengthen(npc,player,type,num)
    num = tonumber(num)
    type = tonumber(type)
    local item_guid = lualib:Player_GetItemGuid(player, num)
    local da = "_da8"..type
    local dv = "_dv8"..type
    local attrValue = lualib:GetInt(item_guid,dv)
    local ranomMax = equipmentAttr[num][2][attrValue+1]
    local random = lualib:GenRandom(1,100)
    local itemName = lualib:KeyName(item_guid)
    local name = ""

    for i = 1, #equipmentAttr[num][3] do
        if lualib:KeyName(item_guid) == equipmentAttr[num][3][i] then
            name = equipmentAttr[num][3][i]
        end
    end

    if name == "" then
        return "��װ����ǰ���ʹ�ǿ������npcǿ����\n \n<@InfoItemRefine#"..num.." *01*����>\n"
    end

    if item_guid == "" then
        return "���װ���������Ͻ���������\n \n<@InfoItemRefine#"..num.." *01*����>\n"
    end

    if attrValue >= #equipmentAttr[num][2] then
        lualib:MsgBox(player,"��ǰ�����Ѿ�Ϊ"..dv..",�Ѿ������������ֵ!!!")
        return ""
    end

    if not lualib:Player_SubIngot(player,ingots[type],false,"װ��ǿ���۳�Ԫ��","װ��ǿ���۳�Ԫ��") then
        return "Ԫ�����㣡"
    end

    if random > equipmentAttr[num][2][attrValue+1] then
        return "ǿ��ʧ�ܣ���������\n \n<@InfoItemRefine#"..num.." *01*����>"
    end

    lualib:SetInt(item_guid,da,equipmentAttr[num][1][type])
    lualib:SetInt(item_guid,dv,attrValue+1)
    lualib:Item_NotifyUpdate("",item_guid)
    lualib:MsgBox(player,"�����ɹ����ɹ�������"..attributeName[type].."����1�㡿������")
    return "ǿ���ɹ�����������\n \n<@InfoItemRefine#"..num.." *01*����>"
end
