local advanceTable = {
    {65,"����ħ��",5},
    {68,"����",3},
    {75,"����ս��",2}
}

function main(npc, player)
    local client_type = lualib:GetClientType(player)
    local msg = ""
    if client_type == 0 then
        msg = msg.. "#COLORCOLOR_GOLD#�弶���� Hot~                 #COLOREND# #COLORCOLOR_RED# �����������꼴ֹ #COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ����        ��Ʒ          ��������       ����/δ��         ����#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED# 65�� #COLOREND#       ����ħ��X1    ȫ������         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward65").."#COLOREND##COLORCOLOR_SKYBLUE#/5#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#1 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_RED# 68�� #COLOREND#       ����X1        ȫ������         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward68").."#COLOREND##COLORCOLOR_SKYBLUE#/3#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#2 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_RED# 75�� #COLOREND#       ����ս��X1    ȫ������         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward75").."#COLOREND##COLORCOLOR_SKYBLUE#/2#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#3 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#        �ﵽ�ȼ����ɻ�����߽�Ʒ��������ҳ��~~#COLOREND#\n"
    elseif client_type == 2 then

        msg = msg.."#COLORCOLOR_GOLD#�弶���� Hot~                 #COLOREND# #COLORCOLOR_RED# �����������꼴ֹ #COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ����    ��Ʒ          ��������    ����/δ��    ����#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED# 65�� #COLOREND#    ����ħ��X1    ȫ������    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward65").."#COLOREND##COLORCOLOR_SKYBLUE#/5#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#1 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_RED# 68�� #COLOREND#    ����X1        ȫ������    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward68").."#COLOREND##COLORCOLOR_SKYBLUE#/3#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#2 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_RED# 75�� #COLOREND#    ����ս��X1    ȫ������    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward75").."#COLOREND##COLORCOLOR_SKYBLUE#/2#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#3 *01*����ȡ��>\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#        �ﵽ�ȼ����ɻ�����߽�Ʒ��������ҳ��~~#COLOREND#\n"
    end

    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end
function receive(npc,player,num)
    num = tonumber(num)
    local level = lualib:Level(player)
    if level < advanceTable[num][1] then
        return "��δ�ﵽ��ȡ�ȼ���������������������"
    end
    if lualib:GetInt(player,"advance"..num) ~= 0 then
        return "���Ѿ���ȡ������Ʒ�ˣ������ظ���ȡ������"
    end
    if lualib:GetDBNum("reward"..advanceTable[num][1]) >= advanceTable[num][3] then
        return "�����Ѿ�����ȡ���ˣ�����һ����ץ������������"
    end
    lualib:AddItem(player,advanceTable[num][2],1,true,"�弶����","Ya�弶����")
    lualib:SetInt(player,"advance"..num,1)
    lualib:SetDBNum("reward"..advanceTable[num][1],lualib:GetDBNum("reward"..advanceTable[num][1])+1)
    lualib:MsgBox(player,"��ȡ�����ɹ�������")
    return ""
end