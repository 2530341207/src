local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local weeks = {--此处代表星期2.4.6攻城[可增加或者减少]
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
    [6] = 1,
    [7] = 1,
}


local awards = {--新区攻城活动奖励
    {	ingot=50000, 		--第1次
         nums = 5,			--需空格子
         {{"魂石", 3000}, {"荣耀石：50000点", 1}, },
         {{"九级强化石", 2}, {"+4附魔锦囊", 1}, }
    },
    {	ingot=20000, 		--第2次
         nums = 5,			--需空格子
         {{"魂石", 2000}, {"荣耀石：5000点", 1}, },
         {{"金砖", 1}, {"天赐神石", 2}, }
    },
    {	ingot=20000, 		--第3次
         nums = 5,			--需空格子
         {{"魂石", 2000}, {"荣耀石：5000点", 1}, },
         {{"金砖", 1}, {"天赐神石", 2}, }
    }
}

local awardsEx = {	--老区攻城活动奖励
    ingot=20000,
    nums = 5,			--需空格子
    {{"魂石", 2000}, {"荣耀石：5000点", 1}, },
    {{"金砖", 1}, {"天赐神石", 2}, },
}


local chuansong_tb = {
    {30000,{"龙城", 563, 265}},--前往神歌城
    {10000,{"龙城", 612, 316}},--一号点
    {10000,{"龙城", 543, 311}},--二号点
    {10000,{"龙城", 603, 250}},--三号点
}

local countryPosition  = {
    "国王",
    "丞相",
    "大将军",
}

function atfd(player)
    local shachen_hh = "暂无行会占领"
    local shachen_cz = "无人当选"
    local shachen_zl1 = "无人当选"
    local shachen_zl2 = "无人当选"

    if lualib:IsCastleWarStart("神歌城") == false then
        local shachen_name =  lualib:GetCastleOwnFamily("神歌城")
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

    local msg1 = "#COLORCOLOR_RED#本期攻城活动奖励如下：#COLOREND#\n\n";
    msg1 = msg1 .. "#COLORCOLOR_YELLOW#元宝奖励：#COLOREND#\n";

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

    local kaishi  = lualib:QueryCastleStart("神歌城")
    local strT = lualib:Time2Str("%Y-%m-%d %H:%M:%S", kaishi)

    lualib:ShowFormWithContent(player, "form文件表单", "攻城战#"..shachen_hh.."#"..shachen_cz.."#"..shachen_zl1.."#"..shachen_zl2.."#"..strT.."#"..serialize(t).."#"..serialize(chuansong_tb))
    return ""
end

function wfudhk(player, dian)
    local dian = tonumber(dian)
    if not lualib:Player_SubGold(player, chuansong_tb[dian][1],true,"传送沙城",player) then
        if not lualib:Player_SubGold(player, chuansong_tb[dian][1],false,"传送沙城",player) then
            return "进入攻城区域需要 绑定金币或者金币"..chuansong_tb[dian][1].."！"
        end
    end
    lualib:Player_MapMoveXY(player, chuansong_tb[dian][2][1], chuansong_tb[dian][2][2], chuansong_tb[dian][2][3], 5)
    return ""
end

function wybcuqdd(player)


    local family = lualib:GuildGuid(player)
    if family == "" then
        return "失败：您没有行会。"
    end

    if lualib:GetCastleOwnFamily("神歌城") ~= lualib:GetFamilyName(player) then
        return "抱歉您所在的行会没有占领神歌城或者只是城堡临时拥有者！"
    end

    if lualib:Player_IsGuildLeader(player) == false then
        return "失败：您不是神歌城城主，没有权利领取！"
    end

    local hour = tonumber(lualib:Time2Str("%H",0))
    if hour < 22 then
        return "失败：奖励领取时间攻城结束当天：22：00-23：59！"
    end

    local var = family..lualib:GetAllDays(0)
    if lualib:GetDBNum(var) > 0 then
        return "失败：本奖励只限一个名额！"
    end

    local lingqu = lualib:GetDBNum("gongchengcishu")
    if lingqu > 0 then
        local week = lualib:GetWeek(0)
        if weeks[week] == nil then
            return "失败：今天没有发起攻城。"
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
        return "背包不足";
    end

    local name = lualib:Name(player);
    if not lualib:AddIngot(player, t.ingot, "增加元宝: 攻城奖励", player) then
        lualib:Error("玩家["..name.."]领取攻城奖励元宝失败");
        return "领取奖励失败";
    end

    for k, v in ipairs(t[1]) do
        if not lualib:AddItem(player, v[1], v[2], false, "给予道具: 攻城奖励", player) then
            lualib:Error("玩家["..name.."]领取攻城奖励["..v[1].."*"..v[2].."]失败");
        end
    end

    local r = lualib:GenRandom(1, #t[2]);
    if not lualib:AddItem(player, t[2][r][1], t[2][r][2], false, "给予道具: 攻城奖励", player) then
        lualib:Error("玩家["..name.."]领取攻城奖励["..t[2][r][1].."*"..t[2][r][2].."]失败");
    end

    lualib:SetDBNumEx(var, 1, 2)
    lualib:SetDBNumEx("gongchengcishu", lingqu + 1, 6)
    lualib:SysMsg_SendBroadcastMsg("恭喜神歌城城主【"..lualib:Name(player).."】成功领取【"..t.ingot.."】元宝", "神歌城")
    return ""

end
	