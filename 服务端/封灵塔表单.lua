function main(player)
    lualib:ShowFormWithContent(player,"form�ļ���","������")

    return ""
end

local countryName = {
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

function accept(player)
    local country = lualib:GetStr(player,"countryName")
    local name = lualib:Name(player)
    local countryList = lualib:GetDBStr(country.."excessiveRanking")            --��ְ���а�
    local countryRanking = lualib:GetDBStr(country.."Ranking")                  --�������а�
    local list = lualib:StrSplit(countryList,"#")
    local ranking = lualib:StrSplit(countryRanking,"#")
    --�ж�Ԫ������
    if lualib:GetIngot(player) < 5000 then
        lualib:MsgBox(player,"����Ԫ������5000���޷�ʹ�ô˹��ܣ�")
        return ""
    end
    --�ж��Ƿ��Ѿ��ѹ���û�м�����������
    if country == "" then
        lualib:MsgBox(player,"���Ѿ������κι��ң������ظ������")
        return ""
    end
    --ɾ���ػ���
    lualib:DelayCall(player,1,"warGodForm:resetPlayerHeroAllValue",country)
    --ɾ��ԭ�й��ҹ�ְbuff
    for i=1,#countryPosition do
        if  lualib:HasBuff(player,countryPosition[i]) then
            lualib:DelBuff(player,countryPosition[i])
        end
    end
    lualib:DelBuff(player,country)
    --ɾ��ԭ�й��Ҿ���Ԫ��
    local countryIntegral = lualib:SetDBNumEx(name..country.."countryIntegral",0,2)
    --ɾ����ְ���а��н�ɫ��Ϣ
    lualib:SetDBStrEx(country.."excessiveRanking","",6)
    for i,v in pairs(list) do
        if v ~= name and v ~= "" then
            lualib:SetDBStrEx(country.."excessiveRanking",lualib:GetDBStr(country.."excessiveRanking").."#"..v,6)
        end
    end
    --lualib:SysMsg_SendBroadcastMsg(countryList.."||"..countryRanking,"����")
    --ɾ���������а��н�ɫ��Ϣ
    lualib:SetDBStrEx(country.."Ranking","",6)
    for i,v in pairs(ranking) do
        if v ~= name and v ~= "" then
            lualib:SetDBStrEx(country.."Ranking",lualib:GetDBStr(country.."Ranking").."#"..v,6)
        end
    end
    lualib:DelayCall(player,1,"������:refresh","")
    countryList = lualib:GetDBStr(country.."excessiveRanking")            --��ְ���а�
    countryRanking = lualib:GetDBStr(country.."Ranking")                  --�������а�


    --ɾ��"_na_"�����й�������
    local str = ""
    for i=1,#countryName do
        if country == countryName[i] then
            lualib:SetInt(player,"panbian",i)
        end
    end
    lualib:SetStr(player,"Country",str)
    --ɾ�����ұ�ʶ
    lualib:SetStr(player,"countryName","")
    --ɾ��Ԫ��
    if lualib:Player_SubIngot(player,5000,false,"�ѹ��۳�Ԫ��","��������") == false then
        lualib:MsgBox(player,"�۳�Ԫ��ʧ�ܣ�����ϵ�ͷ�����")
        return ""
    end
    --��ճ齱����
    lualib:DelayCall(player,1,"country:main","")
    lualib:ShowFormWithContent(player,"form�ļ���","country")
    lualib:ShowFormWithContent(player,"�ű���","tower.close()")
    lualib:SysPromptMsg(player,"�ѳ��ɹ���������ѡ����ң���!")


    return ""
end