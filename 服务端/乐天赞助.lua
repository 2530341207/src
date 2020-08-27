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
    lualib:ShowFormWithContent(player, "脚本表单", str1);
    lualib:ShowFormWithContent(player,"form文件表单","赞助大使")
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


local cb = {"青铜赞助大使","白银赞助大使","黄金赞助大使","白金赞助大使","铂金赞助大使","钻石赞助大使","三国赞助大使"}
local cd = {"青铜赞助","白银赞助","黄金赞助","白金赞助","铂金赞助","钻石赞助","三国赞助"}
function kaitong(player,num)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local je =  lualib:GetTotalBill(player)/100
    je = je + lualib:GetDBNum("ljczje"..user_id)
    local dj =  lualib:GetDBNum("zanzhu"..user_id)
    local dj1 =  lualib:GetInt(player,"zanzhu")
    if dj >= num then
        lualib:MsgBox(player,"该等级赞助已开通过了！")
        return""
    end
    if dj ~= zanzhudj[num][2] then
        lualib:MsgBox(player,"请按顺序开通！")
        return""
    end
    if dj1 ~= zanzhudj[num][2] then
        lualib:MsgBox(player,"请按顺序开通！")
        return""
    end
    if je < zanzhudj[num][1] then
        lualib:MsgBox(player,"充值金额不足["..zanzhudj[num][1].."]元！")
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
    local s = "#COLORCOLOR_YELLOW#赞助大使#COLORCOLOR_BLUE#：恭喜玩家#COLORCOLOR_ORANGE#「"..lualib:Name(player).."」#COLORCOLOR_BLUE#成功加入久玩神途#COLORCOLOR_MAGENTA#["..cb[num].."]#COLORCOLOR_BLUE#--属性大幅提升,众多特权免费享用！！"
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
    lualib:ShowFormWithContent(player, "脚本表单", str1);
    local str1 = "ZZDSSystem.Initialize()"
    lualib:ShowFormWithContent(player, "脚本表单", str1);
    return""
end

function qianghua(player)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local je =  lualib:GetTotalBill(player)/100
    je = je + lualib:GetDBNum("ljczje"..user_id) -lualib:GetDBNum("zzqk"..user_id)
    local dj = lualib:GetInt(player,"zanzhu")
    if dj < 7 then
        lualib:MsgBox(player,"你尚未开通全部赞助,无法强化！")
        return""
    end
    if je < 5000 then
        lualib:MsgBox(player,"当前充值金额不足5000无法强化")
        return""
    end
    lualib:SetDBNumEx("zzqk"..user_id,lualib:GetDBNum("zzqk"..user_id)+5000,4)
    local tAttrPair1 = lualib:GetDynamicAttr(player, 53); local iAttrVale1 =  tAttrPair1["attr_value"];
    local tAttrPair2 = lualib:GetDynamicAttr(player, 58); local iAttrVale2 =  tAttrPair2["attr_value"];
    lualib:SetDynamicAttr(player,53,81,iAttrVale1+5)
    lualib:SetDynamicAttr(player,55,82,iAttrVale1+5)
    lualib:SetDynamicAttr(player,58,196,iAttrVale2+2)
    lualib:MsgBox(player,"强化成功！属性获得提升")
    lualib:SetInt(player,"zzqh",lualib:GetInt(player,"zzqh")+1)
    return zanzhu_dianji(player)
end

local item_t ={
    {"福利1",{"BOS召唤令","BOS召唤令"}},
    {"福利2",{"赤炎令","赤炎令"}},
    {"福利3",{"福利8","福利8"}},
    {"福利4",{"福利9","福利9"}},
    {"福利5",{"福利10","福利10"}},
    {"福利6",{"福利11","福利11"}},
    {"福利7",{"福利12","福利12"}},
}

function lj1(player,num)
    local num = tonumber(num)
    local user_id = lualib:UserID(player)
    local g = lualib:Gender(player)
    local zt =  lualib:GetDBNum("zanzhulj"..user_id..num)
    local dj = lualib:GetInt(player,"zanzhu")
    if dj < num then
        lualib:MsgBox(player,"你尚未开通该等级赞助,无法领取该等级奖励！")
        return""
    end
    if zt ~= 0 then
        lualib:MsgBox(player,"该奖励已领取过了！")
        return""
    end

    lualib:AddItem(player,item_t[num][2][g],1,true,"赞助奖励", player)
    lualib:SetDBNumEx("zanzhulj"..user_id..num,1,2)
    lualib:SysMsg_SendPromptMsg(player, "领取成功！")
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
        lualib:MsgBox(player,"你尚未开通该等级赞助,无法领取该等级奖励！")
        return""
    end
    if zt ~= 0 then
        lualib:MsgBox(player,"该奖励已领取过了！")
        return""
    end

    lualib:AddItem(player,item_t[num][1],1,true,"赞助奖励", player)
    lualib:SetDBNumEx("zanzhulj"..user_id..num..day,1,2)
    lualib:SysMsg_SendPromptMsg(player, "领取成功！")
    return""
end