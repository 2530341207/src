local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local data =  {
    {
        {"吕布时装", {"时装碎片", 888}, 888,"吕布装备武器","时装碎片","2%","2%"},--锻造时装 + {所需材料+数量} + 消耗元宝 + 时装武器（显示用）+ 抽取所得材料 + 人物爆率 + 防爆几率
    },
    {
        {"海皇时装", {"时装碎片", 888}, 888,"海皇装备武器","时装碎片","2%","2%"},
    },
    {
        {"许褚时装", {"时装碎片", 888}, 888,"许褚装备武器","时装碎片","2%","2%"},
    },
    {
        {"大圣时装", {"时装碎片", 888}, 888,"大圣装备武器","时装碎片","2%","2%"},
    },
    {
        {"赵云时装", {"时装碎片", 888}, 888,"赵云装备武器","时装碎片","2%","2%"},
    },
}

local fashionsRelated = {   --时装keyname,合成后的时装keyname
    {"吕布时装","吕布时装SS",288888},
    {"海皇时装","海皇时装SS",288888},
    {"许褚时装","许褚时装SS",288888},
    {"大圣时装","大圣时装SS",288888},
    {"赵云时装","赵云时装SS",288888},
}

function show(player)
    local str = " fashion_tab = "..serialize(data) .. ";fashionsRelated = ".. serialize(fashionsRelated)
    lualib:ShowFormWithContent(player, "脚本表单", str)
    lualib:ShowFormWithContent(player, "form文件表单", "时装锻造Wnd")
    return ""
end

function main(player, pos, idx, types)
    local pos = tonumber(pos)
    local idx = tonumber(idx)
    local types = tonumber(types)
    if data == nil then
        lualib:MsgBox(player, "NPC索引名数据错误,仔细检查数据表单.")
        return ""
    end
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player, "请至少保留一个背包空间。")
        return "请至少保留一个背包空间。"
    end
    local t = data[pos][idx]
    --锻造
    if types == 1 then
        if lualib:ItemCount(player, t[2][1]) < t[2][2] then
            lualib:MsgBox(player, "抱歉，您的“时装碎片”不足。")
            return "抱歉，您的“时装碎片”不足。"
        end
        lualib:DelItem(player, t[2][1], t[2][2], 2, "时装锻造", "时装锻造")
        lualib:AddItem(player, t[1], 1, false, "时装锻造", "时装锻造")
        lualib:MsgBox(player, "恭喜您成功锻造出“".. lualib:KeyName2Name(t[1], 4) .."”。")
        return "恭喜您成功锻造出“".. lualib:KeyName2Name(t[1], 4) .."”。"
    end

    --抽取
    if types == 2 then
        local r = math.random(1,5)
        if not lualib:SubIngot(player, t[3], "时装锻造", "时装锻造") then
            lualib:MsgBox(player, "抱歉，您的元宝不足。")
            return "抱歉，您的元宝不足。"
        end
        lualib:AddItem(player, t[5], r, false, "时装锻造", "时装锻造")
        lualib:MsgBox(player, "恭喜您抽取获得“".. lualib:KeyName2Name(t[5], 4) .."”。")
        return "恭喜您抽取获得“".. lualib:KeyName2Name(t[5], 4) .."”。"
    end
end

function automaticallyPlaced(player)

    local fashionsCount = {}
    local str = ""
    for i=1,#fashionsRelated do
        fashionsCount[i] = lualib:ItemCountEx(player,fashionsRelated[i][1],2,false,true,false,false)
    end
    str = "fashionsRelated = ".. serialize(fashionsRelated) .. ";fashionsCount = ".. serialize(fashionsCount)
    lualib:ShowFormWithContent(player,"脚本表单",str)
    lualib:ShowFormWithContent(player,"脚本表单",[[Fashion.update()]])

    return ""
end

function Synthesis(player,keyname)
    local num = 0 --传回来的keyname在fashionsRelated第几个
    for i=1,#fashionsRelated do
        if keyname == fashionsRelated[i][1] then
            num = i
        end
    end
    if lualib:GetIngot(player) > fashionsRelated[num][3] then
        if lualib:Player_SubIngot(player, fashionsRelated[num][3], false, "扣元宝:原因", "发起人") ~= true then
            lualib:MsgBox(player,"扣除元宝失败！请联系管理员")
            return
        end
    else
        lualib:MsgBox(player,"元宝不足！！")
    end
    if lualib:ItemCountEx(player,keyname,2,false,true,false,false) < 3 then
        lualib:MsgBox(player,"您的背包里的时装【"..keyname.."】不足三件，无法合成！！！")
    end
    lualib:DelItem(player,keyname,3,2,"合成高级时装删除材料","时装锻造表单")
    lualib:AddItem(player,fashionsRelated[num][2],1,false,"合成高级时装","时装锻造表单")
    lualib:MsgBox(player,"合成【"..fashionsRelated[num][2].."】成功！！！")

    lualib:ShowFormWithContent(player,"脚本表单",[[Fashion.clearFashion()]])
    return ""
end
