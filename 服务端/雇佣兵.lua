local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")


function main(player)
    local a = {}
    a[1] = lualib:Gender(player)
    a[2] = lualib:GetInt(player,"zhuansheng")
    str = "ZSSystem_xx = "..serialize(a)
    lualib:ShowFormWithContent(player, "�ű���", str);
    lualib:ShowFormWithContent(player, "form�ļ���", "ת������");
    return""
end

local map_name = {
    {"��ͷ",1,55,50,0},
    {"��Ʒ����",2,57,100,0},
    {"��Ʒ̫ʷة",3,59,200,0},
    {"��Ʒ����ʷ",4,60,300,0},
    {"��Ʒ������",5,62,500,0},
    {"��Ʒ��»���",6,64,1000,1000},
    {"��Ʒ��ξة",7,66,2000,2000},
    {"��Ʒ������",8,68,3000,3000},
    {"��Ʒ��»ѫ",9,70,5000,5000},
    {"һƷ��˾ͽ",10,72,7000,10000},
    {"����о�",11,74,10000,15000},
    {"�ĵ��Ӿ�",12,76,15000,20000},
    {"���Ȳ���",13,78,20000,25000},
    {"���Ⱥ��",14,80,25000,30000},
    {"һ�ȹ���",15,82,30000,35000},
    {"���������",16,85,40000,40000},
}
local shux = {6,7,8,9,10,11,12,13,14,15}

local shuz = {
    {50,1},
    {60,2},
    {70,3},
    {80,4},
    {90,5},
    {100,6},
    {120,7},
    {140,8},
    {160,9},
    {180,10},
    {200,11},
    {220,12},
    {240,13},
    {260,14},
    {280,15},
    {300,16},
}


function mv(player,num)
    local user_id = lualib:UserID(player)
    local je = lualib:GetInt(player,"zhuansheng")
    local num  = tonumber(num)
    if map_name[num] == nil then
        lualib:MsgBox(player,"ϵͳ�򿪴�������´�")
        return""
    end

    if je >= num then
        lualib:MsgBox(player,"��ת���ȼ���ӵ���ˣ�")
        return""
    end

    if (num-1) ~= je then
        lualib:MsgBox(player,"ת���밴�յȼ�˳��ת����")
        return""
    end

    if lualib:ItemCount(player, "ת������") < map_name[num][4] then
        lualib:MsgBox(player,"ת������,��������"..map_name[num][4].."!")
        return ""
    end
    if lualib:GetDBNum("bxb"..user_id) < map_name[num][5] then
        lualib:MsgBox(player,"�����Ҳ���"..map_name[num][5].."��!   ")
        return" "
    end
    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id)-map_name[num][5],4)
    lualib:DelItem(player, "ת������", map_name[num][4], 2, "ת������", "ת������")
    lualib:SetInt(player,"zhuansheng",map_name[num][2])
    for i=1,#shux do
        tAttrPair = lualib:GetDynamicAttr(player,(80+i))
        iAttrVale =  tAttrPair["attr_value"]
        lualib:SetDynamicAttr(player,(80+i),shux[i],iAttrVale+shuz[num][2])
    end
    tAttrPair = lualib:GetDynamicAttr(player,80)
    iAttrVale =  tAttrPair["attr_value"]
    lualib:SetDynamicAttr(player,80,3,iAttrVale+shuz[num][1])
    lualib:SetStr(player,"player_name1","�d"..map_name[num][1].."�d")
    lualib:SetStr(player, "_na_", ""..lualib:GetStr(player,"MonthlyCardStr").."\n"..lualib:GetStr(player,"player_name1").."\n"..lualib:GetStr(player,"zanzhu").."")
    lualib:NotifyVar(player, "_na_")
    --lualib:AddTimer(player, 1314520, 1000, -1, "set_color")
    local s = "#COLORCOLOR_ORANGE#��ϲ���#COLORCOLOR_MAGENTA#["..lualib:Name(player).."]��#COLORCOLOR_ORANGE#�����#COLORCOLOR_MAGENTA#�d"..map_name[num][1].."�d#COLORCOLOR_ORANGE#,���Դ������������ר����ͼ����"
    lualib:SysMsg_SendBroadcastColor(s, "", 7, 7)
    return main(player)
end

function set_color(player, id)
    --[[local color = {
        "#ff0000",
        "#00ff1e",
        "#00aeff",
        "#fcff00",
        "#ff00f0",
        "#ff9c00",
        "#00fcff",

    }
    local no = lualib:GetTempInt(player, "color") + 1
    lualib:SetStr(player, "_tc_", color[math.min(#color, no)])
    lualib:NotifyVar(player, "_tc_")
    if no >= #color then
        lualib:SetTempInt(player, "color", 0)
    else
        lualib:SetTempInt(player, "color", no)
    end]]
end