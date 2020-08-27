local advanceTable = {
    {65,"凤天魔甲",5},
    {68,"开天",3},
    {75,"冰龙战刃",2}
}

function main(npc, player)
    local client_type = lualib:GetClientType(player)
    local msg = ""
    if client_type == 0 then
        msg = msg.. "#COLORCOLOR_GOLD#冲级奖励 Hot~                 #COLOREND# #COLORCOLOR_RED# 名额有限领完即止 #COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# 级别        奖品          奖励类型       已领/未领         操作#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED# 65级 #COLOREND#       凤天魔甲X1    全部奖励         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward65").."#COLOREND##COLORCOLOR_SKYBLUE#/5#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#1 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_RED# 68级 #COLOREND#       开天X1        全部奖励         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward68").."#COLOREND##COLORCOLOR_SKYBLUE#/3#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#2 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_RED# 75级 #COLOREND#       冰龙战刃X1    全部奖励         [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward75").."#COLOREND##COLORCOLOR_SKYBLUE#/2#COLOREND#]         #IMAGE<ID:1902700042>#<@receive#3 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# --------------------------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#        达到等级即可获得上诉奖品！！！大家冲吧~~#COLOREND#\n"
    elseif client_type == 2 then

        msg = msg.."#COLORCOLOR_GOLD#冲级奖励 Hot~                 #COLOREND# #COLORCOLOR_RED# 名额有限领完即止 #COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# 级别    奖品          奖励类型    已领/未领    操作#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED# 65级 #COLOREND#    凤天魔甲X1    全部奖励    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward65").."#COLOREND##COLORCOLOR_SKYBLUE#/5#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#1 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_RED# 68级 #COLOREND#    开天X1        全部奖励    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward68").."#COLOREND##COLORCOLOR_SKYBLUE#/3#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#2 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_RED# 75级 #COLOREND#    冰龙战刃X1    全部奖励    [#COLORCOLOR_GOLD#"..lualib:GetDBNum("reward75").."#COLOREND##COLORCOLOR_SKYBLUE#/2#COLOREND#]    #IMAGE<ID:1902700042>#<@receive#3 *01*【领取】>\n"
        msg = msg.."#COLORCOLOR_SKYBLUE# ----------------------------------------------------#COLOREND#\n"
        msg = msg.."#COLORCOLOR_SKYBLUE#        达到等级即可获得上诉奖品！！！大家冲吧~~#COLOREND#\n"
    end

    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end
function receive(npc,player,num)
    num = tonumber(num)
    local level = lualib:Level(player)
    if level < advanceTable[num][1] then
        return "您未达到领取等级，请升级后再来！！！"
    end
    if lualib:GetInt(player,"advance"..num) ~= 0 then
        return "您已经领取过该物品了，不能重复领取！！！"
    end
    if lualib:GetDBNum("reward"..advanceTable[num][1]) >= advanceTable[num][3] then
        return "奖励已经被领取完了，请下一个区抓紧练级！！！"
    end
    lualib:AddItem(player,advanceTable[num][2],1,true,"冲级奖励","Ya冲级奖励")
    lualib:SetInt(player,"advance"..num,1)
    lualib:SetDBNum("reward"..advanceTable[num][1],lualib:GetDBNum("reward"..advanceTable[num][1])+1)
    lualib:MsgBox(player,"领取奖励成功！！！")
    return ""
end