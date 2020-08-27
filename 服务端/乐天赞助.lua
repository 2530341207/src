local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/timecount_def")
require("system/serializer")
function zanzhu_xianshi(player)

    return ""
end

function zanzhu_dianji(player)
    local user_id = lualib:UserID(player)
    local g = lualib:Gender(player)
    local t = {}
    local je =  (lualib:GetTotalBill(player)/100) - lualib:GetDBNum("zzqk"..user_id)
    t[1] = je + lualib:GetDBNum("ljczje"..user_id)
    t[2] = lualib:GetDBNum("zanzhu"..user_id)
    t[3] = g
    t[4] =  lualib:GetInt(player,"zanzhu")
    t[5] =  lualib:GetInt(player,"zzqh")
    local str1 = "ZZDSSystem_table = "..serialize(t);
    lualib:ShowFormWithContent(player, "�ű���", str1);
    lualib:ShowFormWithContent(player,"form�ļ���","������ʹ")
    return""
end

local zanzhudj = {
    {50,0},
    {100,1},
    {300,2},
    {500,3},
    {1000,4},
    {2000,5},
    {5000,6},
}

local shux = {196,197,81,82}
local shuxz = {
    {2,2,4,4},
    {4,4,7,7},
    {6,6,10,10},
    {8,8,14,14},
    {11,11,19,19},
    {15,15,25,25},
    {20,20,32,32},
}


local cb = {"��ͭ������ʹ","����������ʹ","�ƽ�������ʹ","�׽�������ʹ","����������ʹ","��ʯ������ʹ","����������ʹ"}
local cd = {"��ͭ����","��������","�ƽ�����","�׽�����","��������","��ʯ����","��������"}
function kaitong(player,num)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local je =  lualib:GetTotalBill(player)/100
    je = je + lualib:GetDBNum("ljczje"..user_id)
    local dj =  lualib:GetDBNum("zanzhu"..user_id)
    local dj1 =  lualib:GetInt(player,"zanzhu")
    if dj >= num then
        lualib:MsgBox(player,"�õȼ������ѿ�ͨ���ˣ�")
        return""
    end
    if dj ~= zanzhudj[num][2] then
        lualib:MsgBox(player,"�밴˳��ͨ��")
        return""
    end
    if dj1 ~= zanzhudj[num][2] then
        lualib:MsgBox(player,"�밴˳��ͨ��")
        return""
    end
    if je < zanzhudj[num][1] then
        lualib:MsgBox(player,"��ֵ����["..zanzhudj[num][1].."]Ԫ��")
        return""
    end
    lualib:SetDBNumEx("zanzhu"..user_id,num,2)
    lualib:SetInt(player,"zanzhu",num)
    lualib:SetDynamicAttr(player,52,shux[1],shuxz[num][1])
    lualib:SetDynamicAttr(player,54,shux[2],shuxz[num][2])
    lualib:SetDynamicAttr(player,56,shux[3],shuxz[num][3])
    lualib:SetDynamicAttr(player,57,shux[4],shuxz[num][4])
    lualib:AddBuff(player,cd[num],0)
    if num == 5 then
        lualib:SetStr(player, "_tc_", "GREENG")
        lualib:NotifyVar(player, "_tc_")
    elseif num == 6 then
        lualib:SetStr(player, "_tc_", "BLUE")
        lualib:NotifyVar(player, "_tc_")
    elseif num == 7 then
        lualib:SetStr(player, "_tc_", "MAGENTA")
        lualib:NotifyVar(player, "_tc_")
    end
    local s = "#COLORCOLOR_YELLOW#������ʹ#COLORCOLOR_BLUE#����ϲ���#COLORCOLOR_ORANGE#��"..lualib:Name(player).."��#COLORCOLOR_BLUE#�ɹ����������;#COLORCOLOR_MAGENTA#["..cb[num].."]#COLORCOLOR_BLUE#--���Դ������,�ڶ���Ȩ������ã���"
    lualib:SysMsg_SendBroadcastColor(s, "", 1, 12)
    local user_id = lualib:UserID(player)
    if num == 7 then
        lualib:SetDBNumEx("zzqk"..user_id,lualib:GetDBNum("zzqk"..user_id)+5000,4)
    end
    local t = {}
    local g = lualib:Gender(player)
    local je =  lualib:GetTotalBill(player)/100
    t[1] = je + lualib:GetDBNum("ljczje"..user_id)
    t[2] = lualib:GetDBNum("zanzhu"..user_id)
    t[3] = g
    t[4] =  lualib:GetInt(player,"zanzhu")
    t[5] =  lualib:GetInt(player,"zzqh")
    local str1 = "ZZDSSystem_table = "..serialize(t);
    lualib:ShowFormWithContent(player, "�ű���", str1);
    local str1 = "ZZDSSystem.Initialize()"
    lualib:ShowFormWithContent(player, "�ű���", str1);
    return""
end

function qianghua(player)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local je =  lualib:GetTotalBill(player)/100
    je = je + lualib:GetDBNum("ljczje"..user_id) -lualib:GetDBNum("zzqk"..user_id)
    local dj = lualib:GetInt(player,"zanzhu")
    if dj < 7 then
        lualib:MsgBox(player,"����δ��ͨȫ������,�޷�ǿ����")
        return""
    end
    if je < 5000 then
        lualib:MsgBox(player,"��ǰ��ֵ����5000�޷�ǿ��")
        return""
    end
    lualib:SetDBNumEx("zzqk"..user_id,lualib:GetDBNum("zzqk"..user_id)+5000,4)
    local tAttrPair1 = lualib:GetDynamicAttr(player, 53); local iAttrVale1 =  tAttrPair1["attr_value"];
    local tAttrPair2 = lualib:GetDynamicAttr(player, 58); local iAttrVale2 =  tAttrPair2["attr_value"];
    lualib:SetDynamicAttr(player,53,81,iAttrVale1+5)
    lualib:SetDynamicAttr(player,55,82,iAttrVale1+5)
    lualib:SetDynamicAttr(player,58,196,iAttrVale2+2)
    lualib:MsgBox(player,"ǿ���ɹ������Ի������")
    lualib:SetInt(player,"zzqh",lualib:GetInt(player,"zzqh")+1)
    return zanzhu_dianji(player)
end

local item_t ={
    {"����1",{"BOS�ٻ���","BOS�ٻ���"}},
    {"����2",{"������","������"}},
    {"����3",{"����8","����8"}},
    {"����4",{"����9","����9"}},
    {"����5",{"����10","����10"}},
    {"����6",{"����11","����11"}},
    {"����7",{"����12","����12"}},
}

function lj1(player,num)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local g = lualib:Gender(player)
    local zt =  lualib:GetDBNum("zanzhulj"..user_id..num)
    local dj = lualib:GetInt(player,"zanzhu")
    if dj < num then
        lualib:MsgBox(player,"����δ��ͨ�õȼ�����,�޷���ȡ�õȼ�������")
        return""
    end
    if zt ~= 0 then
        lualib:MsgBox(player,"�ý�������ȡ���ˣ�")
        return""
    end

    lualib:AddItem(player,item_t[num][2][g],1,true,"��������", player)
    lualib:SetDBNumEx("zanzhulj"..user_id..num,1,2)
    lualib:SysMsg_SendPromptMsg(player, "��ȡ�ɹ���")
    return""
end

function lj2(player,num)
    local user_id = lualib:UserID(player)
    local num = tonumber(num)
    local g = lualib:Gender(player)
    local day =  lualib:GetAllDays(0)
    local zt =  lualib:GetDBNum("zanzhulj"..user_id..num..day)
    local dj = lualib:GetInt(player,"zanzhu")
    if dj < num then
        lualib:MsgBox(player,"����δ��ͨ�õȼ�����,�޷���ȡ�õȼ�������")
        return""
    end
    if zt ~= 0 then
        lualib:MsgBox(player,"�ý�������ȡ���ˣ�")
        return""
    end

    lualib:AddItem(player,item_t[num][1],1,true,"��������", player)
    lualib:SetDBNumEx("zanzhulj"..user_id..num..day,1,2)
    lualib:SysMsg_SendPromptMsg(player, "��ȡ�ɹ���")
    return""
end