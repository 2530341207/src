local sponsorTable = {
    {50,"首充折凳","赤炎之心","赤月坐骑",15000},
    {50,"首充平底锅","赤炎之心","赤月坐骑",15000},
    {450,{"正气时装（男）","正气时装（女）"},"掉落5","赤月之翼",150000},
}

function main(npc, player)
    local msg = "#COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临赞助界面#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# 为了让玩家体验一个长久、公平、公正、游戏环境#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# 特设赞助大使元宝比例1:100充值后自动转为火龙币 火龙币比例 1:1#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# 本服坚毅大金玩家只需要领取第一个50顶赞礼包即可#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700035>#<@InfoItemRefine *01*【领取赞助】>\n\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 430, 240)
    return""
end
-------------------------------------------------------------------------------------------幸运项链
function InfoItemRefine(npc, player)
    local msg = "#COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临赞助界面#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE# 您的赞助是对我们最大的支持！！！  您当前的火龙币:".. lualib:GetInt(player,"hlb") .."#COLOREND#\n\n"
    msg = msg .. "#COLORCOLOR_RED#【赞助50火龙币】#COLOREND# = 运9折凳*1 + 未鉴定的骰子*1 + 赤月坐骑*1 + 1.5w元宝      #IMAGE<ID:1902700035>#<@sponsor#1 *01*【领取赞助】>\n\n"
    msg = msg .. "#COLORCOLOR_RED#【赞助50火龙币】#COLOREND# = 运9平底锅*1 + 未鉴定的骰子*1 + 赤月坐骑*1 + 1.5w元宝    #IMAGE<ID:1902700035>#<@sponsor#2 *01*【领取赞助】>\n\n"
    msg = msg .. "#COLORCOLOR_RED#【赞助450火龙币】#COLOREND# = 时装*1 + 50爆率 + 赤月之翼*1 + 15w元宝                  #IMAGE<ID:1902700035>#<@sponsor#3 *01*【领取赞助】>"
    lualib:NPCTalkDetailEx(npc, player, msg, 500, 240)
    return""
end

function sponsor(npc,player,num)
    num = tonumber(num)
    local hlb = lualib:GetInt(player,"hlb")
    if num == 1 or num == 2 then
        if lualib:GetInt(player,"sponsor1") ~= 0 then
            return "您已经领取过50元赞助，不能再次领取相同赞助！！！"
        end
        if hlb < sponsorTable[num][1] then
            return "您的火龙币不足！！！"
        end
        lualib:SetInt(player,"hlb",hlb-sponsorTable[num][1])
        for i=2 , (#sponsorTable[num]-1) do
            lualib:AddItem(player,sponsorTable[num][i],1,true,"赞助奖励物品","Ya赞助大使")
        end
        lualib:Player_AddIngot(player,sponsorTable[num][5],false,"赞助奖励元宝","Ya赞助大使")
        lualib:MsgBox(player,"您成功获得50元赞助礼包！！！")
        lualib:SetInt(player,"sponsor1",1)
        return ""
    else
        local gender = lualib:Gender(player)
        if lualib:GetInt(player,"sponsor2") ~= 0 then
            return "您已经领取了所有赞助了！！！"
        end
        if lualib:GetInt(player,"sponsor1") ~= 1 then
            return "请先赞助50元，再来点击该赞助！！！"
        end
        if hlb < sponsorTable[num][1] then
            return "您的火龙币不足！！！"
        end
        lualib:AddItem(player,sponsorTable[num][2][gender],1,true,"赞助奖励物品","Ya赞助大使")

        lualib:AddTitle(player, 60)
        lualib:ApplyTitle(player, 60)
        lualib:AddItem(player,sponsorTable[num][4],1,true,"赞助奖励物品","Ya赞助大使")
        lualib:Player_AddIngot(player,sponsorTable[num][5],false,"赞助奖励元宝","Ya赞助大使")
        lualib:MsgBox(player,"您成功获得450元赞助礼包！！！")
        lualib:SetInt(player,"sponsor2",1)
    end
    return ""
end