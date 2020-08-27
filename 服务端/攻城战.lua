local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local weeks = {--�˴���������2.4.6����[�����ӻ��߼���]
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
}


local awards = {--�������ǻ����
    {	ingot=50000, 		--��1��
         nums = 5,			--��ո���
         {{"��ʯ", 3000}, {"��ҫʯ��50000��", 1}, },
         {{"�ż�ǿ��ʯ", 2}, {"+4��ħ����", 1}, }
    },
    {	ingot=20000, 		--��2��
         nums = 5,			--��ո���
         {{"��ʯ", 2000}, {"��ҫʯ��5000��", 1}, },
         {{"��ש", 1}, {"�����ʯ", 2}, }
    },
    {	ingot=20000, 		--��3��
         nums = 5,			--��ո���
         {{"��ʯ", 2000}, {"��ҫʯ��5000��", 1}, },
         {{"��ש", 1}, {"�����ʯ", 2}, }
    }
}

local awardsEx = {	--�������ǻ����
    ingot=20000,
    nums = 5,			--��ո���
    {{"��ʯ", 2000}, {"��ҫʯ��5000��", 1}, },
    {{"��ש", 1}, {"�����ʯ", 2}, },
}


local chuansong_tb = {
    {30000,{"����", 563, 265}},--ǰ������
    {10000,{"����", 612, 316}},--һ�ŵ�
    {10000,{"����", 543, 311}},--���ŵ�
    {10000,{"����", 603, 250}},--���ŵ�
}

local countryPosition  = {
    "����",
    "ة��",
    "�󽫾�",
}

function atfd(player)
    local shachen_hh = "�����л�ռ��"
    local shachen_cz = "���˵�ѡ"
    local shachen_zl1 = "���˵�ѡ"
    local shachen_zl2 = "���˵�ѡ"

    if lualib:IsCastleWarStart("����") == false then
        local shachen_name =  lualib:GetCastleOwnFamily("����")
        shachen_hh = shachen_name

        if shachen_name ~= "" then

            local countryList = lualib:GetDBStr(shachen_name.."updateRanking")
            local listTable = lualib:StrSplit(countryList,"#")


            if listTable[2] ~= nil then
                shachen_cz = listTable[2]
            end
            if listTable[3] ~= nil then
                shachen_zl1 = listTable[3]
            end
            if listTable[4] ~= nil then
                shachen_zl2 = listTable[4]
            end

        end
    end

    local msg1 = "#COLORCOLOR_RED#���ڹ��ǻ�������£�#COLOREND#\n\n";
    msg1 = msg1 .. "#COLORCOLOR_YELLOW#Ԫ��������#COLOREND#\n";

    local lingqu = lualib:GetDBNum("gongchengcishu")
    local t = {}
    if lualib:GetDBNum("NewOrOld") > 1 then
        t = awardsEx
    else
        if awards[lingqu+1] ~= nil then
            t = awards[lingqu+1]
        else
            t = awards[#awards]
        end
    end

    local kaishi  = lualib:QueryCastleStart("����")
    local strT = lualib:Time2Str("%Y-%m-%d %H:%M:%S", kaishi)

    lualib:ShowFormWithContent(player, "form�ļ���", "����ս#"..shachen_hh.."#"..shachen_cz.."#"..shachen_zl1.."#"..shachen_zl2.."#"..strT.."#"..serialize(t).."#"..serialize(chuansong_tb))
    return ""
end

function wfudhk(player, dian)
    local dian = tonumber(dian)
    if not lualib:Player_SubGold(player, chuansong_tb[dian][1],true,"����ɳ��",player) then
        if not lualib:Player_SubGold(player, chuansong_tb[dian][1],false,"����ɳ��",player) then
            return "���빥��������Ҫ �󶨽�һ��߽��"..chuansong_tb[dian][1].."��"
        end
    end
    lualib:Player_MapMoveXY(player, chuansong_tb[dian][2][1], chuansong_tb[dian][2][2], chuansong_tb[dian][2][3], 5)
    return ""
end

function wybcuqdd(player)


    local family = lualib:GuildGuid(player)
    if family == "" then
        return "ʧ�ܣ���û���лᡣ"
    end

    if lualib:GetCastleOwnFamily("����") ~= lualib:GetFamilyName(player) then
        return "��Ǹ�����ڵ��л�û��ռ�����ǻ���ֻ�ǳǱ���ʱӵ���ߣ�"
    end

    if lualib:Player_IsGuildLeader(player) == false then
        return "ʧ�ܣ����������ǳ�����û��Ȩ����ȡ��"
    end

    local hour = tonumber(lualib:Time2Str("%H",0))
    if hour < 22 then
        return "ʧ�ܣ�������ȡʱ�乥�ǽ������죺22��00-23��59��"
    end

    local var = family..lualib:GetAllDays(0)
    if lualib:GetDBNum(var) > 0 then
        return "ʧ�ܣ�������ֻ��һ�����"
    end

    local lingqu = lualib:GetDBNum("gongchengcishu")
    if lingqu > 0 then
        local week = lualib:GetWeek(0)
        if weeks[week] == nil then
            return "ʧ�ܣ�����û�з��𹥳ǡ�"
        end
    end

    local t = {}
    if lualib:GetDBNum("NewOrOld") > 1 then
        t = awardsEx
    else
        if awards[lingqu+1] ~= nil then
            t = awards[lingqu+1]
        else
            t = awards[#awards]
        end
    end

    if lualib:BagFree(player, true, false, false) < t.nums then
        return "��������";
    end

    local name = lualib:Name(player);
    if not lualib:AddIngot(player, t.ingot, "����Ԫ��: ���ǽ���", player) then
        lualib:Error("���["..name.."]��ȡ���ǽ���Ԫ��ʧ��");
        return "��ȡ����ʧ��";
    end

    for k, v in ipairs(t[1]) do
        if not lualib:AddItem(player, v[1], v[2], false, "�������: ���ǽ���", player) then
            lualib:Error("���["..name.."]��ȡ���ǽ���["..v[1].."*"..v[2].."]ʧ��");
        end
    end

    local r = lualib:GenRandom(1, #t[2]);
    if not lualib:AddItem(player, t[2][r][1], t[2][r][2], false, "�������: ���ǽ���", player) then
        lualib:Error("���["..name.."]��ȡ���ǽ���["..t[2][r][1].."*"..t[2][r][2].."]ʧ��");
    end

    lualib:SetDBNumEx(var, 1, 2)
    lualib:SetDBNumEx("gongchengcishu", lingqu + 1, 6)
    lualib:SysMsg_SendBroadcastMsg("��ϲ���ǳ�����"..lualib:Name(player).."���ɹ���ȡ��"..t.ingot.."��Ԫ��", "����")
    return ""

end
	