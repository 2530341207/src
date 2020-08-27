local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")
require("system/timecount_def")  --加载界面布局

lualib:SetFormAllowFunc({"ButtonFirstLingQu","show_first_bill_gift_main"})

local zhongzhidu = 50 --充值多少给首冲


--首充奖励的物品绑定道具表格--格式为物品KeyName,物品数量,物品绑定或者不绑定

local item_gift_table =
{
    {
        {"首充平底锅",1,1},
        {"未鉴定的符文",60,1},
        {"赤月坐骑",1,1},
        {"赤月之翼",1,1},
        {"雷霆时装(男)",1,1},
    }
}

-------------------------------------------------------------------------

--获取日充数量(数据投递)
function GetPlayerDayDB(player)
    local id = tostring(lualib:UserID(player))
    local user_id = lualib:UserID(player)
    local job = lualib:Job(player)
    local gender = lualib:Gender(player)
    if gender == 1 then
        item_gift_table[1][5][1] = "雷霆时装(男)"
    else
        item_gift_table[1][5][1] = "雷霆时装(女)"
    end
    --整合元宝表
    local new_table = {}
    local all_table=item_gift_table[job]
    new_table["all_cz"] = math.floor((lualib:GetTotalBill(player)/100) + lualib:GetDBNum("ljczje"..user_id))
    new_table["all_ds_num"]	= zhongzhidu		--累计充值领取变量
    --获取保存的数据
    lualib:ShowFormWithContent(player,"form文件表单","新首充礼包#"..serialize(all_table).."#"..serialize(new_table))

    return ""
end

---------图标显示---------
function first_bill_gift_xianshi(player)--新首充礼包
    local id = tostring(lualib:UserID(player))
    local all_count = lualib:GetDBNum(id.."|first_cz_num1")
    if all_count  < 1 then
        if lualib:GetClientType(player) == 0 then
            AddSEIcon(player,1, -2, "新首充礼包表单", 1906100005, "新首充礼包表单", "show_first_bill_gift_main", "首充礼包", "首充礼包!")
        end
    end
    return ""
end

function guanbi_xianshi(player)
    DelIcon(player,"新首充礼包表单")
end
-------------------图标被点击-----------------------
function show_first_bill_gift_main(player)
    GetPlayerDayDB(player)
    return ""

end
---------------------
function close(player)
    return ""
end

--客户端调用，日充领奖
--充值礼包laye提交
function ButtonFirstLingQu(player,param)
    local id = tostring(lualib:UserID(player))
    local user_id = lualib:UserID(player)
    local job = lualib:Job(player)
    local all_yuanbao = (lualib:GetTotalBill(player)/100)  + lualib:GetDBNum("ljczje"..user_id)
    local all_count = lualib:GetDBNum(id.."|first_cz_num1")	--首次充值领取变量
    local gender = lualib:Gender(player)
    if gender == 1 then
        item_gift_table[1][5][1] = "雷霆时装(男)"
    else
        item_gift_table[1][5][1] = "雷霆时装(女)"
    end
    if all_yuanbao < zhongzhidu  then
        lualib:MsgBox(player, "你的充值不够"..zhongzhidu.."元，不能领取该首充礼包，请前往官网充值!")
        return ""
    end
    if all_count > 0 then
        lualib:MsgBox(player, "您已经领取过首充礼包了!")
        return ""
    end

    if lualib:BagFree(player,true,false,false) < 6 then
        lualib:MsgBox(player, "背包空间不够，不能领取,请整理6格以上的背包再进行领取！")
        return ""
    end



    local lq_item = nil
    local lq_item = item_gift_table[job]

    if lq_item ~= nil then

        lualib:SetDBNumEx(id.."|first_cz_num1",1,2)
        for i=1,(#lq_item) do
            lualib:AddSingleItem(player, lq_item[i][1], lq_item[i][2], lq_item[i][3], "首次充值给物品", "首次礼包")

        end
        lualib:SysPromptMsg(player, "领取 "..zhongzhidu.." 首次充值礼包成功！" )
        guanbi_xianshi(player)

    else
        lualib:NPCTalk(player,"非法操作，你已经被记录在案！")
        lualib:Error(lualib:Name(player).."非法操作礼包领取，记录在案！")
    end
    return ""
end
