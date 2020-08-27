local runesTable = {
    {"符文1","1级符文",20},
    {"符文2","2级符文",15},
    {"符文3","3级符文",7},
    {"符文4","4级符文",4},
    {"符文5","5级符文",3},
    {"符文6","6级符文",1},
}

local demandHlb = {1500,750}

function main(npc, player)
    local msg = "#COLORCOLOR_GOLD#                        永 恒 符 文 鉴 定                 #COLOREND#\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_RED# 符文获取方式 ：#COLOREND# #COLORCOLOR_GOLD#所有符文绑定不可掉落，不可丢弃#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# 只有未鉴定的符文才可以鉴定#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# 符文鉴定相关：鉴定相关收费：1500元宝 回复未鉴定收费：750元宝#COLOREND#\n\n"
    msg = msg.."#COLORCOLOR_SKYBLUE# 鉴定有几率出1级到6级符文#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700042>#<@Identification *01*【我要鉴定符文】>     #IMAGE<ID:1902700042>#<@initialization *01*【符文恢复初始】>\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end
function Identification(npc,player)
    local num = weights(runesTable)                                   --随机值
    local user_id = lualib:UserID(player)
    local itemGuid = lualib:BagItemList(player,true,false,false)
    local item = ""

    for i = 1,#itemGuid do
        if lualib:KeyName(itemGuid[i]) == "未鉴定的符文" then
            item = lualib:KeyName(itemGuid[i])
        end
    end
    if item == "" then
        lualib:MsgBox(player,"您的背包没有未鉴定的符文！")
        return ""
    end
    if not lualib:Player_IsIngotEnough(player,demandHlb[1],false) then
        lualib:MsgBox(player,"您的元宝不足！")
        return ""
    end
    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player,"背包不足无法鉴定！")
        return ""
    end

    lualib:SubIngot(player, demandHlb[1], "鉴定符文扣除元宝","Ya符文鉴定")
    lualib:DelItem(player, "未鉴定的符文", 1, 2, "符文鉴定", "Ya符文鉴定")
    lualib:AddItem(player,runesTable[num][1],1,true,"鉴定符文","Ya符文鉴定")
    lualib:MsgBox(player,"恭喜您鉴定出【"..runesTable[num][2].."】！")
    lualib:SysMsg_SendBroadcastMsg("恭喜玩家"..lualib:KeyName(player) .."鉴定出符文【".. runesTable[num][2] .."】","符文鉴定")
    return ""
end

function initialization(npc,player)
    local num = weights(runesTable)                                   --随机值
    local user_id = lualib:UserID(player)
    local itemName = ""                                               --初始化道具名称
    local itemGuid = lualib:BagItemList(player,true,false,false)
    for j = 1,#runesTable do
        for i = 1,#itemGuid do
            if lualib:KeyName(itemGuid[i]) == runesTable[j][1] then
                itemName = lualib:KeyName(itemGuid[i])
                break
            end
        end
        if itemName ~= "" then
            break
        end
    end


    if itemName == "" then
        lualib:MsgBox(player,"你背包中没有可初始化的装备！")
        return ""
    end

    if not lualib:Player_IsIngotEnough(player,demandHlb[2],false) then
        lualib:MsgBox(player,"您的元宝不足！")
        return ""
    end

    if lualib:GetBagFree(player) < 1 then
        lualib:MsgBox(player,"背包不足无法还原！")
        return ""
    end

    lualib:SubIngot(player, demandHlb[1], "初始化符文扣除元宝","Ya符文鉴定")
    lualib:DelItem(player, itemName, 1, 2, "还原符文", "Ya符文鉴定")
    lualib:AddItem(player,"未鉴定的符文",1,true,"还原符文","Ya符文鉴定")
    lualib:MsgBox(player,"还原成功！")
    return ""
end

function weights(table)                 --table 格式 table = {{...,权重值},{...,权重值},{...,权重值}...}


    local random = 0            --随机值
    local max = 0               --取值范围
    local value = 0             --比较值
    local num = 0               --返回值
    for i=1,#table do
        max = table[i][#table[i]] + max
    end

    random = lualib:GenRandom(1,max)
    for i=1,#table do

        if random > value then
            num = i
        else
            break
        end
        value = value + table[i][#table[i]]
    end

    return num
end