local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/Amark�ͻ��˴���")
require("system/AmarkMsg")

local DouLiInfoT = {
    {"�ƶ���", 100},
    {"�ݶ���", 500},
    {"����", 1000, "GREENG"},
    {"��ն���1", 2000, "GREENG"},
    {"��ն���2", 5000, "SKYBLUE"},
    {"�ƽ���", 10000, "PURPLE"},
}

local ColorT = {
    [3] = "GREENG",
    [4] = "GREENG",
    [5] = "SKYBLUE",
    [6] = "PURPLE",
}

function main(npc, player)
    PlayerData(player)
    lualib:ShowFormWithContent(player,"form�ļ���","Amark����ʹ��")
    return ""
end

function PlayerData(player)
    local AccountName = lualib:AccountName(player)
    local PlayerGold = math.floor( lualib:GetTotalBill(player) / 100 )
    lualib:ShowFormWithContent(player,"�ű���"," AmarkZzds_PlayerGold = "..PlayerGold)
    lualib:ShowFormWithContent(player,"�ű���"," AmarkZzds_Ling = "..lualib:GetDBNum("Amark_������ȡ_"..AccountName))
    local table_t = DouLiInfoT
    for i=1, #table_t do
        table_t[i][3] = lualib:KeyName2Name(table_t[i][1], 4)
    end
    lualib:ShowFormWithContent(player,"�ű���"," AmarkZzdsT = ".. Amark_FormTable( table_t))
    return ""
end

function ChongZhi(player)
    if lualib:GetMobileClientType(player) < 0 then
        local name = lualib:Player_GetStrProp(player,  lua_role_user_name)
        local userid = lualib:Player_GetAccountID(player)
        local grpid = lualib:GetGroupId()
        local GetZoneId = lualib:GetZoneId()
        local msg = "https://pay.hzyotoy.com/index.do?mod=pay&act=step1&serverid="..GetZoneId.."&userid="..userid
        lualib:SysMsg_SendWebPage(player, msg)
    else
        lualib:ShowFormWithContent(player,"�ű���","PaymentWindowType = 2")
        lualib:ShowFormWithContent(player,"�ű���","CL:OnPaymentWindow()")
    end
    return ""
end

function LingQu(player, param)
    local AccountName = lualib:AccountName(player)
    local param = tonumber(param)
    if DouLiInfoT[param] == nil then
        return ""
    end
    local Ling = lualib:GetDBNum("Amark_������ȡ_"..AccountName)
    local PlayerGold = math.floor( lualib:GetTotalBill(player) / 100 )
    if PlayerGold < DouLiInfoT[param][2] then
        lualib:MsgBox(player, "��Ǹ����ֵ����"..DouLiInfoT[param][2].."Ԫ��")
        return ""
    end
    if Ling + 1 ~= param then
        lualib:MsgBox(player, "�밴��˳����ȡ��")
        return ""
    end
    local DouLi = lualib:Player_GetItemGuid(player, 19)
    if DouLi ~= "" then
        lualib:Item_Destroy("", DouLi, "", "")
    end
    lualib:AddItem(player, DouLiInfoT[param][1], 1, true, "������ȡ", "������ȡ")
    lualib:SetVipLevel(player, param)
    lualib:TakeOnEx(player, DouLiInfoT[param][1], 0)
    lualib:SetDBNum("Amark_������ȡ_"..AccountName, Ling + 1)
    if ColorT[Ling + 1] ~= nil then
        lualib:Player_SetNameColor(player, ColorT[Ling + 1])
    end
    PlayerData(player)
    lualib:ShowFormWithContent(player,"�ű���"," AmarkZzds.InitEx() ")
    return ""
end