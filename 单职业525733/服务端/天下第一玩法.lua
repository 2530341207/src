local path = "����, 188, 680, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 190, 680, 0,    ����, 186, 682, 0,    ����, 188, 676, 0,    ����, 188, 680, 0,	����, 174, 666, 0,	����, 159, 641, 0,	����, 158, 632, 0,	����, 156, 606, 0,	����, 150, 600, 0,	����, 140, 600, 0,	����, 139, 583, 0,	����, 139, 577, 0,	����, 143, 572, 0,	����, 141, 560, 0,	����, 139, 551, 0,	����, 141, 537, 0,	����, 143, 523, 0,	����, 150, 510, 0,	����, 150, 502, 0,	����, 144, 496, 0,	����, 141, 484, 0,	����, 139, 474, 0,	����, 137, 446, 0,	����, 135, 431, 0,	����, 135, 415, 0,	����, 128, 410, 0,	����, 118, 410, 0,	����, 115, 404, 0,	����, 113, 396, 0,	����, 105, 392, 0,	����, 102, 388, 0,	����, 99, 376, 0,	����, 99, 368, 0,	����, 95, 356, 0,	����, 86, 357, 0,	����, 86, 351, 0,	����, 90, 345, 0,	����, 86, 334, 0,	����, 86, 324, 0,	����, 86, 311, 0,	����, 80, 303, 0,	����, 82, 292, 0,	����, 82, 270, 0,	����, 86, 266, 0,	����, 83, 256, 0,	����, 83, 227, 0,	����, 77, 221, 0,	����, 77, 211, 0,	����, 73, 203, 0,	����, 67, 197, 0,	����, 63, 193, 0,	����, 47, 193, 0,	����, 47, 192, 0,	����, 36, 113, 0,	����, 34, 97, 0,	����, 18, 97, 0,	����, 17, 97, 0,	���ٳ�, 424, 393, 0,	���ٳ�, 422, 389, 0,	���ٳ�, 388, 355, 0"

gQuestMap =
{
    {3001, "QuestAccept3001", "","*01*����: Ѻ��", ""}
}
gQuestNum = table.getn(gQuestMap)
local Escorter = --��������
{
    campaign_id = 12,        --�id
    req_npc = "���Ǿ����",  --Ѻ�ͽ�����NPC
    str_gold = "�۽�ң����ڳ���������",
    str_ingot = "��Ԫ�������ڳ���������",
    req_gold = 0,            --Ѻ��������5000
    color_flag =             --Ѻ����ɫ��ʶ
    {
        --�ڳ���ɫ          ,Ԫ������   ,                ,�ڳ�����  ,�㲥 ,�ڳ�keyname
        {"#COLORCOLOR_WHITE#",   0,         "#COLOREND#", "�ڳ�����", false, "�ڳ�����"},
        {"#COLORCOLOR_GREENG#",  15,       "#COLOREND#", "�ڳ�����", false, "�ڳ�����"},
        {"#COLORCOLOR_BLUE#",    15,       "#COLOREND#", "�ڳ�����", false, "�ڳ�����"},
        {"#COLORCOLOR_PURPLE#",   15,       "#COLOREND#", "�ڳ�����", true, "�ڳ�����"},
        {"#COLORCOLOR_GOLD#" ,    15,       "#COLOREND#", "�ڳ�����", true, "�ڳ�����"},
    },
    cur_color = "escort_color",--��ǰ�ڳ���ɫ
    cur_level = "cur_level",   --����ڳ����˵ĵȼ�
    cur_guid = "cur_guid",     --����ڳ����˵�GUID
    life = 3600,               --�ڳ�����ʱ��
    cur_dest = "cur_dest",     --�����ڳ�Ŀ�ĵ�
    escort_dest = "���ٳǾ����"
}
--------------------------------------------------------------------------------
function Escorter:VerifyLevel(player)
    return lualib:VerifyCampLevel(player, self.campaign_id)
end

function Escorter:VerifyCampaign(player)
    return lualib:VerifyCampCount(player, self.campaign_id)
end

function Escorter:JoinCampaign(player)
    lualib:JoinCamp(player, self.campaign_id, 0)
end

function Escorter:VerifyGold(player)
    return lualib:Player_IsGoldEnough(player, self.req_gold, false)
end

function Escorter:SubGold(player)
    return lualib:Player_SubGold(player, self.req_gold, false,
            self.str_gold, self.req_npc)
end

function Escorter:VerifyIngot(player, ingot)
    return lualib:Player_IsIngotEnough(player, ingot, false)
end

function Escorter:SubIngot(player, ingot)
    return lualib:Player_SubIngot(player, ingot, false,
            self.str_ingot, self.req_npc)
end

function Escorter:SetColor(player, color)
    lualib:SetInt(player, self.cur_color, color)
end

function Escorter:GetColor(player)
    return lualib:GetInt(player, self.cur_color)
end

function Escorter:GenColor(player)
    local color = self:GetColor(player)
    if color == #self.color_flag then return nil, nil end

    color = math.random(1, #self.color_flag)
    return color, self.color_flag[color][2]
end

function Escorter:IsEscorterDied(player)
    if lualib:IsEscorterDied(player) then
        self:SetColor(player, 0)
        return true
    end
    return false
end
--------------------------------------------------------------------------------
local talk_t = {"�����Ŷ�ħ�ٶ࣬Ҳ�޷���ֹ���������ٳǵĽŲ���", "Ѻ��Ѻ�ڣ���Ѻ�Ŀɲ����ڣ����Ǵ�˵��", "�������ڣ�����������ʳ�İ��ڡ�"}

function on_create(npc)
    lualib:AddTimer(npc, 1, 310000, -1, "on_timer_talk")
end

function on_timer_talk(npc, timer_id)

    lualib:SysMsg_SendRoleTalk(npc, talk_t[lualib:GenRandom(1, #talk_t)])

end

function main(npc, player)
    local msg = "    ���ٳ�������������ħ��ս֮�أ���Ҫ���������ʣ��������ټ���־��Ѻ���ڳ�ǰ�����ٳǣ���֧Ԯǰ�ߵ����ǣ���Ը��ȥ��\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."    35�������ÿ�쵽�����������Ѻ��3����#COLORCOLOR_GREENG#(VIPÿ���5��)#COLOREND#����ɺ���ô����ķǰ󶨽�ң��Լ�����������ƷŶ��\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."#IMAGE<ID:1902700037>##OFFSET<X:0,Y:-1>#<@Accept *01*��Ѻ�ڡ�>                #OFFSET<X:0,Y:1>##IMAGE<ID:1902700017>#<@jieshao *01*��Ѻ�ڽ��ܡ�>\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n \n"
    msg = msg.."                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700034>##OFFSET<X:0,Y:-2>#<@likai *01*���뿪��>\n"
    for i, v in ipairs(gQuestMap) do
        if v[2] ~= "" then
            if lualib:CanAcceptQuest(player, v[1]) == true then
                msg = msg.."<@"..v[2].." "..v[4]..">\n"
            end
        end

        if v[3] ~= "" then
            if lualib:CanAccomplishQuest(player, v[1]) == true then
                msg = msg.."<@"..v[3].." "..v[5]..">\n"
            end
        end
    end
    return msg
end

function Accept(npc, player)
    if not Escorter:VerifyLevel(player) then
        return "�㼶�𲻹�����35���������ɣ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    end

    if Escorter:IsEscorterDied(player) then
        return "��ǰû���ڳ������������ȡѺ������\n \n \n \n \n #OFFSET<X:0,Y:-5>##IMAGE1902700033##OFFSET<X:0,Y:-1>#<@AcceptEx *01*��ȷ�ϡ�>\n \n                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    else
        local cur_color = Escorter:GetColor(player)
        if cur_color ~= #Escorter.color_flag then
            return "��ǰ�ڳ�Ϊ"..Escorter.color_flag[cur_color][1]
                    ..Escorter.color_flag[cur_color][4]
                    ..Escorter.color_flag[cur_color][3]..
                    "�������ˢ�¸��߼�Ѻ������\n \n \n \n \n #OFFSET<X:0,Y:-5>##IMAGE1902700033##OFFSET<X:0,Y:-1>#<@StartEscort *01*��ȷ�ϡ�>\n \n                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        else
            return "��ǰ�ڳ�Ϊ"..Escorter.color_flag[cur_color][1]
                    ..Escorter.color_flag[cur_color][4]
                    ..Escorter.color_flag[cur_color][3]..
                    "���Ѵﵽ����ڳ��ȼ���\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
    end
end

function jieshao(npc, player)
    local msg = "35�������ÿ�쵽�����������Ѻ��3����#COLORCOLOR_GREENG#(VIPÿ���5��)#COLOREND#����ɺ���ô����ķǰ󶨽�ң��Լ�����������ƷŶ��\n"
    msg = msg.."#COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."#COLORCOLOR_YELLOW# 1.�ڳ�Ʒ�ʷ�Ϊ���ա������䡢��������ҵ�һ�ν�ȡʱ����� ���ڳ�Ʒ�ʣ�������ڳ�Ʒ�ʲ����⣬����ʹ��ѭ��ħ��ˢ�£�#COLOREND#\n "
    msg = msg.."#COLORCOLOR_YELLOW#2.�������������Խ���Ϊ������Ϊ��ȡ�ڳ����õ�������Ҳ�ܻ� ȡ�����ô���������Ҫ����С����Щ�ˣ�#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-8>##COLORCOLOR_BROWN#�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y�y#COLOREND#\n"
    msg = msg.."                                            #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    return msg
end

function AcceptEx(npc, player)
    if Escorter:VerifyCampaign(player) then
        Escorter:JoinCampaign(player)
        lualib:SetInt(player, "yabiao", 0)
        return StartEscort(npc, player)
    else
        local vip_level = lualib:GetVipLevel(player)
        local yabiao_vip = lualib:GetInt(player, "yabiao")
        if vip_level > 0 and yabiao_vip <= 2 then
            Escorter:JoinCampaign(player)
            lualib:SetInt(player, "yabiao", yabiao_vip + 1)
            return StartEscort(npc, player)
        else
            return "�㲻��ô������Ϣһ�£����������ɣ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
    end
    --[[
        if not Escorter:VerifyCampaign(player) then
            return "�㲻��ô������Ϣһ�£����������ɣ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
        Escorter:JoinCampaign(player)
        return StartEscort(npc, player)]]
end

function StartEscort(npc, player)
    local cur_color = Escorter:GetColor(player)

    if Escorter:IsEscorterDied(player) then
        local init_color, init_ingot = Escorter:GenColor(player)
        return RefreshEx(npc, player, init_color, init_ingot, cur_color)
    end

    local new_color = nil
    local new_ingot = nil
    local msg = "��ǰ�ڳ�Ϊ"..Escorter.color_flag[cur_color][1]
            ..Escorter.color_flag[cur_color][4]
            ..Escorter.color_flag[cur_color][3].."��"

    if cur_color ~= #Escorter.color_flag then
        new_color, new_ingot = Escorter:GenColor(player)
        msg = msg.."�����ʹ��#COLORCOLOR_RED#ѭ��ħ��#COLOREND#���������ڳ�Ʒ�ʣ�ÿ��ˢ������1��ѭ��ħ�䣡\n \n \n \n \n"
        --[[    ..Escorter.color_flag[new_color][1]
            ..Escorter.color_flag[new_color][4]
        ..Escorter.color_flag[new_color][3].."��]]
        msg = msg.."#OFFSET<X:6,Y:-5>##IMAGE1902700032##OFFSET<X:0,Y:-1>#<@Refresh#"..new_color.."#"..new_ingot.."#"..cur_color.." *01*��ˢ�¡�>\n"
    else
        msg = msg.."\n \n \n"
    end

    msg = msg.."                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>\n"
    return msg
end

function RefreshEx(npc, player, color, ingot, old_color)
    local cur_color = tonumber(color)
    local cur_ingot = tonumber(ingot)
    old_color = tonumber(old_color)

    if Escorter:IsEscorterDied(player) then
        if old_color ~= Escorter:GetColor(player) then
            return "����ڳ������Ѿ�ʧ���ˣ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
    end

    if not Escorter:VerifyGold(player) then
        return "�������Ե��й���ʹǮ��ĥ����������\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    end

    if not Escorter:SubGold(player) then
        return "�����һ�û�յ����Ǯ�أ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    end

    local monster = Escorter.color_flag[cur_color][6]
    if monster == nil then return "��ѽѽ���ڳ������ˣ�����\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>" end

    if not lualib:GenEscorter(player, monster, Escorter.life) then --lualib:GenTraveler(player, monster, Escorter.life, path) then
        return "����������ȷ���ڳ����㸽��������\n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>"
    end

    lualib:SetInt(lualib:GetEscorter(player), Escorter.cur_level, lualib:Level(player))
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_dest, Escorter.escort_dest)
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_guid, player)

    if Escorter.color_flag[cur_color][5] then
        lualib:SysMsg_SendCenterMsg(1, lualib:Name(player).."�ӵ���"
                ..Escorter.color_flag[cur_color][4]..
                "����ף��һ·˳�磡�ٺ٣�ϣ�����ڵ���ҿ�����������������������", "")
    end

    lualib:SysMsg_SendPromptMsg(player, "�ڳ�ˢ�³ɹ���")
    Escorter:SetColor(player, cur_color)
    return StartEscort(npc, player)
end


function Refresh(npc, player, color, ingot, old_color)
    local cur_color = tonumber(color)
    local cur_ingot = tonumber(ingot)
    old_color = tonumber(old_color)

    if Escorter:IsEscorterDied(player) then
        if old_color ~= Escorter:GetColor(player) then
            return "����ڳ������Ѿ�ʧ���ˣ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
    end

    if not Escorter:VerifyGold(player) then
        return "�������Ե��й���ʹǮ��ĥ����������\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
    end

    --[[if not Escorter:VerifyIngot(player, cur_ingot) then
        return "���Ұ�����ô����û��Ԫ���أ���\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>"
    end]]
    if cur_color ~= #Escorter.color_flag then
        if lualib:ItemCountByKey(player, "ѭ��ħ��", true, false, false, 2) < 1 then
            return "�������û��ѭ��ħ�䣬�ҿɲ������ģ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
    end
    --[[
        if not Escorter:SubGold(player) then
            return "�����һ�û�յ����Ǯ�أ�\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*�����ء�>"
        end
        ]]

    --[[if not Escorter:SubIngot(player, cur_ingot) then
        return "���Ұ�����ô����û��Ԫ���أ���\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>"
    end]]

    local monster = Escorter.color_flag[cur_color][6]
    if cur_color ~= #Escorter.color_flag then

        if monster == nil then return "��ѽѽ���ڳ������ˣ�����\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>" end

    end

    if not lualib:GenEscorter(player, monster, Escorter.life) then --lualib:GenTraveler(player, monster, Escorter.life, path) then
        return "����������ȷ���ڳ����㸽��������\n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*�����ء�>"
    end

    if not lualib:DelItem(player, "ѭ��ħ��", 1, 2, "ˢ���ڳ�", "ˢ���ڳ�") then
        return "����ˢ���ڳ�ʧ����"
    end

    lualib:SetInt(lualib:GetEscorter(player), Escorter.cur_level, lualib:Level(player))
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_dest, Escorter.escort_dest)
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_guid, player)

    if Escorter.color_flag[cur_color][5] then
        lualib:SysMsg_SendCenterMsg(1, lualib:Name(player).."�ӵ���"
                ..Escorter.color_flag[cur_color][4]..
                "����ף��һ·˳�磡�ٺ٣�ϣ�����ڵ���ҿ�����������������������", "")
    end

    lualib:SysMsg_SendPromptMsg(player, "�ڳ�ˢ�³ɹ���")
    Escorter:SetColor(player, cur_color)
    return StartEscort(npc, player)
end
---3001��
function QuestAccept3001(npc,player)
    msg = "���ٳǳ����˴�������ħ��������ҹ��ս���������أ���Ҫ�����ľ������ʣ���ʿ����Ը��Ѻ������ǰ�����ٳ���\n \n"
    msg = msg.."<@Accept3001 *01* ��Ը�⣡>\n"
    return msg
end


function Accept3001(npc, player)
    if lualib:AcceptQuest(player, 3001) == true then
        return "��ҪС�ģ���Ѻ���ڳ�ǰ�����ٳǵ�·�ϣ���Ҫ�����ڳ�̫Զ�����п��ܻ�����ǿ�������أ���Ҫ����ʮ����ֵľ��������С�"
    else
        return "�����ȡʧ��"
    end
end