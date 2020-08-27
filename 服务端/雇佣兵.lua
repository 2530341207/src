local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")


function main(player)
    local a = {}
    a[1] = lualib:Gender(player)
    a[2] = lualib:GetInt(player,"zhuansheng")
    str = "ZSSystem_xx = "..serialize(a)
    lualib:ShowFormWithContent(player, "脚本表单", str);
    lualib:ShowFormWithContent(player, "form文件表单", "转生修仙");
    return""
end

local map_name = {
    {"捕头",1,55,50,0},
    {"九品县令",2,57,100,0},
    {"八品太史丞",3,59,200,0},
    {"七品侍御史",4,60,300,0},
    {"六品左仆射",5,62,500,0},
    {"五品光禄大夫",6,64,1000,1000},
    {"四品卫尉丞",7,66,2000,2000},
    {"三品中书令",8,68,3000,3000},
    {"二品光禄勋",9,70,5000,5000},
    {"一品大司徒",10,72,7000,10000},
    {"五等男爵",11,74,10000,15000},
    {"四等子爵",12,76,15000,20000},
    {"三等伯爵",13,78,20000,25000},
    {"二等侯爵",14,80,25000,30000},
    {"一等公爵",15,82,30000,35000},
    {"天子令诸侯",16,85,40000,40000},
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
        lualib:MsgBox(player,"系统打开错误请从新打开")
        return""
    end

    if je >= num then
        lualib:MsgBox(player,"该转生等级已拥有了！")
        return""
    end

    if (num-1) ~= je then
        lualib:MsgBox(player,"转生请按照等级顺序转生！")
        return""
    end

    if lualib:ItemCount(player, "转生材料") < map_name[num][4] then
        lualib:MsgBox(player,"转生材料,数量不足"..map_name[num][4].."!")
        return ""
    end
    if lualib:GetDBNum("bxb"..user_id) < map_name[num][5] then
        lualib:MsgBox(player,"三国币不足"..map_name[num][5].."点!   ")
        return" "
    end
    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id)-map_name[num][5],4)
    lualib:DelItem(player, "转生材料", map_name[num][4], 2, "转生修仙", "转生修仙")
    lualib:SetInt(player,"zhuansheng",map_name[num][2])
    for i=1,#shux do
        tAttrPair = lualib:GetDynamicAttr(player,(80+i))
        iAttrVale =  tAttrPair["attr_value"]
        lualib:SetDynamicAttr(player,(80+i),shux[i],iAttrVale+shuz[num][2])
    end
    tAttrPair = lualib:GetDynamicAttr(player,80)
    iAttrVale =  tAttrPair["attr_value"]
    lualib:SetDynamicAttr(player,80,3,iAttrVale+shuz[num][1])
    lualib:SetStr(player,"player_name1","卍"..map_name[num][1].."卍")
    lualib:SetStr(player, "_na_", ""..lualib:GetStr(player,"MonthlyCardStr").."\n"..lualib:GetStr(player,"player_name1").."\n"..lualib:GetStr(player,"zanzhu").."")
    lualib:NotifyVar(player, "_na_")
    --lualib:AddTimer(player, 1314520, 1000, -1, "set_color")
    local s = "#COLORCOLOR_ORANGE#恭喜玩家#COLORCOLOR_MAGENTA#["..lualib:Name(player).."]　#COLORCOLOR_ORANGE#完成了#COLORCOLOR_MAGENTA#卍"..map_name[num][1].."卍#COLORCOLOR_ORANGE#,属性大幅提升，更有专属地图特享！"
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