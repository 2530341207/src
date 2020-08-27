local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local hero1 =[[ {
{{"金条",3},{"书页",30},{"金刚石",100}},
{{"金条",2},{"书页",20},{"金刚石",50}},
{{"金条",1},{"书页",10},{"金刚石",20}},
}]]

local hero_a = loadstring("return "..hero1)();
function 抢充礼包(player)
    if lualib:GetClientType(player) == 0 then
        AddSEIcon(player, 1, -2, "抢充礼包", 1906100049, "抢充礼包", "showns2", "每日抢充", "每日抢充!")
    end
    return ""
end


function showns2(player)
    local user_id = lualib:UserID(player)
    if lualib:GetDBNum("GQHD"..user_id) ~= lualib:GetAllDays(0) then
        lualib:SetDBNum("GQHD"..user_id,lualib:GetAllDays(0))
        lualib:SetDBNumEx("GQHDCZ"..user_id,0,4)
    end
    local zuori = {}
    for i=1,3 do
        if lualib:GetDBStr("paihang"..i) == "" then
            zuori[i] = "虚位以待"
        else
            zuori[i] = lualib:GetDBStr("paihang"..i)
        end
    end
    str = "PzSystem_esp = "..hero1	--发送装备列表
    lualib:ShowFormWithContent(player, "脚本表单", str);
    str = "PzSystem_wup = "..serialize(zuori)	--发送装备列表
    lualib:ShowFormWithContent(player, "脚本表单", str);
    str = "PzSystem_zuori = "..lualib:GetDBNum("GQHDCZ"..user_id)
    lualib:ShowFormWithContent(player, "脚本表单", str);
    local chongzhi_table = {};
    local chongzhi_str = lualib:IO_GetCustomVarStr("chongzhi_paihang_day")
    if chongzhi_str ~= "" then
        chongzhi_table = json.decode(chongzhi_str)
    end
    str = "PzSystem_jinri = "..serialize(chongzhi_table)	--今日充值排行
    lualib:ShowFormWithContent(player, "脚本表单", str);
    lualib:ShowFormWithContent(player, "form文件表单", "抢充礼包");
    leap(player)
    return""
end




function on_billinax(id,yb)

    if lualib:GetDBNum("GQHD"..id) ~= lualib:GetAllDays(0) then
        lualib:SetDBNum("GQHD"..id,lualib:GetAllDays(0))
        lualib:SetDBNumEx("GQHDCZ"..id,0,4)
    end
    local rmb = yb/100
    lualib:SetDBNumEx("LJCZL"..id,lualib:GetDBNum("LJCZL"..id)+rmb,4)
    lualib:SetDBNumEx("GQHDCZ"..id,lualib:GetDBNum("GQHDCZ"..id)+rmb,4)
end

function leap(player)
    local user_id = lualib:UserID(player)
    if lualib:GetDBNum("GQHD"..user_id) ~= lualib:GetAllDays(0) then
        lualib:SetDBNum("GQHD"..user_id,lualib:GetAllDays(0))
        lualib:SetDBNumEx("GQHDCZ"..user_id,0,4)
    end
    local elp = lualib:GetDBNum("GQHDCZ"..user_id)
    if  elp >  0  then
        chongzhi_paihang(player)
    end
end


function chongzhi_paihang(player)
    local user_id = lualib:UserID(player)
    local jine = lualib:GetDBNum("GQHDCZ"..user_id)
    if jine ~= 0 then
        local player_name = lualib:KeyName(player)
        local id = lualib:AccountName(player)
        local chongzhi_table = {}
        local chongzhi_str = lualib:IO_GetCustomVarStr("chongzhi_paihang_day")
        if chongzhi_str ~= "" then
            chongzhi_table = json.decode(chongzhi_str)
        end
        if chongzhi_table[3] ~= nil and chongzhi_table ~= nil then
            if chongzhi_table[3].jine == nil or jine > chongzhi_table[3].jine then
            else
                return
            end
        end
        local zai = false
        for i=1,3 do
            if chongzhi_table[i] == nil then
                break
            end

            if player_name == chongzhi_table[i].name then
                chongzhi_table[i].jine = jine
                zai = true
                break
            end

            if id == chongzhi_table[i].id then
                if player_name == chongzhi_table[i].name then
                    chongzhi_table[i].jine = jine
                    zai = true
                    break
                else
                    chongzhi_table[i].name = player_name
                    zai = true
                    break
                end
            end
        end
        if zai == false then
            chongzhi_table[#chongzhi_table+1] = {}
            chongzhi_table[#chongzhi_table].name = player_name
            chongzhi_table[#chongzhi_table].jine = jine
            chongzhi_table[#chongzhi_table].id = id
        end
        table.sort(chongzhi_table,function(v1,v2)return v1.jine > v2.jine end)
        for i=4,#chongzhi_table do
            chongzhi_table[i] = nil
        end

        lualib:SetDBStr("chongzhi_paihang_day",json.encode(chongzhi_table))
    end
    return true
end

function lingqujiangli(player)
    local name = lualib:Name(player)
    if name ~= lualib:GetDBStr("paihang1") and name ~= lualib:GetDBStr("paihang2") and  name ~= lualib:GetDBStr("paihang3")   then
        lualib:MsgBox(player,"您昨日没有获奖")
        return ""
    end
    if lualib:GetBagFree(player) < 3  then
        lualib:MsgBox(player,"包裹空间不足3")
        return ""
    end

    for i=1,3 do
        if name == lualib:GetDBStr("paihang"..i) then
            if lualib:GetDBNum("lingjian"..i) >= 1 then
                lualib:MsgBox(player,"对不起您已领取奖励")
                return""
            end
            lualib:AddItem(player,hero_a[i][1][1],hero_a[i][1][2],false,"抢充奖励", player)
            lualib:AddItem(player,hero_a[i][2][1],hero_a[i][2][2],true,"抢充奖励", player)
            lualib:AddItem(player,hero_a[i][3][1],hero_a[i][3][2],false,"抢充奖励", player)
            lualib:SysMsg_SendBroadcastColor("恭喜玩家【"..name.."】参与每日抢充活动,获取[第"..i.."名],再接再厉", "", 1, 12)
            lualib:SysMsg_SendBroadcastColor("恭喜玩家【"..name.."】参与每日抢充活动,获取[第"..i.."名],再接再厉", "", 1, 12)
            lualib:SetDBNum("lingjian"..i,1)
        end
    end
    return""
end

function tonum()
    local chongzhi_str = lualib:IO_GetCustomVarStr("chongzhi_paihang_day")
    if chongzhi_str ~= "" then
        chongzhi_table = json.decode(chongzhi_str)
    end
    for i=1,3 do
        lualib:SetDBStr("paihang"..i,"")
    end
    if chongzhi_str ~= "" then
        for i=1,3 do
            if chongzhi_table[i] ~= nil then
                if chongzhi_table[i].name ~= nil then
                    if chongzhi_table[i].jine > 100 then
                        lualib:SetDBStr("paihang"..i,chongzhi_table[i].name)
                    end
                end
            end
        end
    end

    for i=1,3 do
        lualib:SetDBNum("lingjian"..i,0)
    end
    lualib:IO_SetCustomVarStr("chongzhi_paihang_day","")
    lualib:SysMsg_SendBroadcastColor("新一轮抢充活动开启,昨日获奖玩家请在今日内领取排名奖励！", "", 1, 12)
    lualib:SysMsg_SendBroadcastColor("新一轮抢充活动开启,昨日获奖玩家请在今日内领取排名奖励！", "", 1, 12)
end



