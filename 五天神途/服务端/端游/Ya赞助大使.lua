local sponsorTable = {
    {50,"�׳��۵�","����֮��","��������",15000},
    {50,"�׳�ƽ�׹�","����֮��","��������",15000},
    {450,{"����ʱװ���У�","����ʱװ��Ů��"},"����5","����֮��",150000},
}

function main(npc, player)
    local msg = "#COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ������������#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# Ϊ�����������һ�����á���ƽ����������Ϸ����#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# ����������ʹԪ������1:100��ֵ���Զ�תΪ������ �����ұ��� 1:1#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# �������������ֻ��Ҫ��ȡ��һ��50�����������#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700035>#<@InfoItemRefine *01*����ȡ������>\n\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 430, 240)
    return""
end
-------------------------------------------------------------------------------------------��������
function InfoItemRefine(npc, player)
    local msg = "#COLORCOLOR_RED#�I#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#��ӭ������������#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#�I#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# ���������Ƕ���������֧�֣�����  ����ǰ�Ļ�����:".. lualib:GetInt(player,"hlb") .."#COLOREND#\n\n"
    msg = msg .. "#COLORCOLOR_RED#������50�����ҡ�#COLOREND# = ��9�۵�*1 + δ����������*1 + ��������*1 + 1.5wԪ��      #IMAGE<ID:1902700035>#<@sponsor#1 *01*����ȡ������>\n\n"
    msg = msg .. "#COLORCOLOR_RED#������50�����ҡ�#COLOREND# = ��9ƽ�׹�*1 + δ����������*1 + ��������*1 + 1.5wԪ��    #IMAGE<ID:1902700035>#<@sponsor#2 *01*����ȡ������>\n\n"
    msg = msg .. "#COLORCOLOR_RED#������450�����ҡ�#COLOREND# = ʱװ*1 + 50���� + ����֮��*1 + 15wԪ��                  #IMAGE<ID:1902700035>#<@sponsor#3 *01*����ȡ������>"
    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end

function sponsor(npc,player,num)
    num = tonumber(num)
    local hlb = lualib:GetInt(player,"hlb")
    if num == 1 or num == 2 then
        if lualib:GetInt(player,"sponsor1") ~= 0 then
            return "���Ѿ���ȡ��50Ԫ�����������ٴ���ȡ��ͬ����������"
        end
        if hlb < sponsorTable[num][1] then
            return "���Ļ����Ҳ��㣡����"
        end
        lualib:SetInt(player,"hlb",hlb-sponsorTable[num][1])
        for i=2 , (#sponsorTable[num]-1) do
            lualib:AddItem(player,sponsorTable[num][i],1,true,"����������Ʒ","Ya������ʹ")
        end
        lualib:Player_AddIngot(player,sponsorTable[num][5],false,"��������Ԫ��","Ya������ʹ")
        lualib:MsgBox(player,"���ɹ����50Ԫ�������������")
        lualib:SetInt(player,"sponsor1",1)
        return ""
    else
        local gender = lualib:Gender(player)
        if lualib:GetInt(player,"sponsor2") ~= 0 then
            return "���Ѿ���ȡ�����������ˣ�����"
        end
        if lualib:GetInt(player,"sponsor1") ~= 1 then
            return "��������50Ԫ���������������������"
        end
        if hlb < sponsorTable[num][1] then
            return "���Ļ����Ҳ��㣡����"
        end
        lualib:AddItem(player,sponsorTable[num][2][gender],1,true,"����������Ʒ","Ya������ʹ")

        lualib:AddTitle(player, 60)
        lualib:ApplyTitle(player, 60)
        lualib:AddItem(player,sponsorTable[num][4],1,true,"����������Ʒ","Ya������ʹ")
        lualib:Player_AddIngot(player,sponsorTable[num][5],false,"��������Ԫ��","Ya������ʹ")
        lualib:MsgBox(player,"���ɹ����450Ԫ�������������")
        lualib:SetInt(player,"sponsor2",1)
    end
    return ""
end