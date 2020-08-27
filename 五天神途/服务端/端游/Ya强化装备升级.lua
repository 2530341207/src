local equipmentAttr = {
    [1] = {                             --武器
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30,30,30,10,10},
        {"冰龙道刃","冰龙魔刃","冰龙战刃","完美魔刃","完美道刃","完美战刃"}
    },
    [2] = {                             --头盔
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔盔","冰龙道盔","冰龙战盔","完美魔盔","完美道盔","完美魔盔","完美战盔"}
    },
    [3] = {                             --左手镯
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔镯","冰龙道镯","冰龙战镯","完美魔镯","完美道镯","完美战镯"}
    },
    [4] = {                             --右手镯
        {10,12,14,6,5},                 --物攻上线，魔攻上线，道攻上线，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔镯","冰龙道镯","冰龙战镯","完美魔镯","完美道镯","完美战镯"}
    },
    [5] = {                             --衣服
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30,30,30,10,10},
        {"冰龙神袍","冰龙神甲","完美神袍","完美神甲"}
    },
    [7] = {                             --鞋子
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔靴","冰龙道靴","冰龙战靴","完美魔靴","完美道靴","完美战靴"}
    },
    [8] = {                             --腰带
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔带","冰龙道带","冰龙战带","完美魔带","完美道带","完美战带"}
    },
    [9] =  {                            --项链
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔链","冰龙道链","冰龙战链","完美魔链","完美道链","完美战链"}
    },
    [10] = {                            --左戒子
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔戒","冰龙道戒","冰龙战戒","完美魔戒","完美道戒","完美战戒"}
    },
    [11] = {                            --右戒子
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙魔戒","冰龙道戒","冰龙战戒","完美魔戒","完美道戒","完美战戒"}
    },
    [12] = {                            --勋章
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙勋章","完美勋章"}
    },
    [19] = {                            --斗笠
        {10,12,14,16,6,8},              --物攻上线，魔攻上线，道攻上线，命中，物防,魔防
        {50,50,50,50,50,30},
        {"冰龙斗笠","完美斗笠"}
    },
}

local attributeName = {"物攻上线","魔攻上线","道攻上线","命中","物防","魔防"}
local ingots = {500,500,500,500,500,500}      --升级对应该属性需要的元宝

function main(npc, player)
    local msg = "#COLORCOLOR_RED#注意：盛世龙腾首饰系列最高强化6点，盛世龙腾武器一度最高提升10点#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:4>##COLORCOLOR_SKYBLUE#       攻魔道防魔500元宝几率提升1点【30%成功率】\n        除精准外升级必须物品500元宝，精准需要500元宝，\n      注意：请把你要升级的装备带在装备栏内。#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ┌─────┬─────┬─────┬─────┐#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   │#COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:0,Y:-2># <@InfoItemRefine#1 *01*武器升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │ #COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#5 *01*衣服升级>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0># │ #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#19 *01*斗笠升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │ #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#12 *01*勋章升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ├─────┼─────┼─────┼─────┤#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   │#COLOREND##OFFSET<X:0,Y:-2>##OFFSET<X:0,Y:0># <@InfoItemRefine#2 *01*头盔升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │ #COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#9 *01*项链升级>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0># │ #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#8 *01*腰带升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │ #COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#7 *01*鞋子升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0># │#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   ├─────┼─────┼─────┼─────┤#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   │#COLOREND##OFFSET<X:0,Y:-2>##OFFSET<X:0,Y:0>#<@InfoItemRefine#10 *01*左戒指升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#│#COLOREND##OFFSET<X:0,Y:2>##OFFSET<X:-2,Y:-2>#<@InfoItemRefine#11 *01*右戒指升级>#COLORCOLOR_BROWN##OFFSET<X:0,Y:0>#│#COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#3 *01*左手镯升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#│#COLOREND##OFFSET<X:0,Y:0>#<@InfoItemRefine#4 *01*右手镯升级>#COLORCOLOR_BROWN##OFFSET<X:-2,Y:0>#│#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#   └─────┴─────┴─────┴─────┘#COLOREND#\n"
    lualib:NPCTalkDetailEx(npc, player, msg, 430, 240)
    return""
end

function InfoItemRefine(npc, player,num)
    num = tonumber(num)

    local msg = "\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#1#"..num.." *01*【升级攻击】>#COLORCOLOR_RED#     攻击 ：强化1属性点 需要->300元宝#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#2#"..num.." *01*【升级魔攻】>#COLORCOLOR_RED#     魔法 ：强化1属性点 需要->300元宝#COLOREND#\n\n"
    msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#3#"..num.." *01*【升级道攻】>#COLORCOLOR_RED#     道术 ：强化1属性点 需要->300元宝#COLOREND#\n\n"
    if num == 1 then
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#4#"..num.." *01*【升级精准】>#COLORCOLOR_RED#     精准 ：强化1属性点 需要->500元宝#COLOREND#\n\n"
    end

    if num ~= 9 and num ~= 1 then
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#5#"..num.." *01*【升级防御】>#COLORCOLOR_RED#     防御 ：强化1属性点 需要->300元宝#COLOREND#\n\n"
        msg = msg.."#IMAGE<ID:1902700017>#<@strengthen#6#"..num.." *01*【升级魔御】>#COLORCOLOR_RED#     魔御 ：强化1属性点 需要->300元宝#COLOREND#\n\n"
    end

    msg = msg.."#COLORCOLOR_GREENG#温馨提示：请把你要升级的装备戴在装备栏上！#COLOREND#"
    msg = msg.."  #IMAGE<ID:1902700019>#<@main *01*「返回」>"
    return msg
end

function strengthen(npc,player,type,num)
    num = tonumber(num)
    type = tonumber(type)
    local item_guid = lualib:Player_GetItemGuid(player, num)
    local da = "_da8"..type
    local dv = "_dv8"..type
    local attrValue = lualib:GetInt(item_guid,dv)
    local ranomMax = equipmentAttr[num][2][attrValue+1]
    local random = lualib:GenRandom(1,100)
    local itemName = lualib:KeyName(item_guid)
    local name = ""

    for i = 1, #equipmentAttr[num][3] do
        if lualib:KeyName(item_guid) == equipmentAttr[num][3][i] then
            name = equipmentAttr[num][3][i]
        end
    end

    if name == "" then
        return "该装备请前往皇宫强化升级npc强化！\n \n<@InfoItemRefine#"..num.." *01*返回>\n"
    end

    if item_guid == "" then
        return "请把装备穿戴身上进行升级！\n \n<@InfoItemRefine#"..num.." *01*返回>\n"
    end

    if attrValue >= #equipmentAttr[num][2] then
        lualib:MsgBox(player,"当前属性已经为"..dv..",已经升至最大属性值!!!")
        return ""
    end

    if not lualib:Player_SubIngot(player,ingots[type],false,"装备强化扣除元宝","装备强化扣除元宝") then
        return "元宝不足！"
    end

    if random > equipmentAttr[num][2][attrValue+1] then
        return "强化失败！！！！！\n \n<@InfoItemRefine#"..num.." *01*返回>"
    end

    lualib:SetInt(item_guid,da,equipmentAttr[num][1][type])
    lualib:SetInt(item_guid,dv,attrValue+1)
    lualib:Item_NotifyUpdate("",item_guid)
    lualib:MsgBox(player,"提升成功！成功提升【"..attributeName[type].."属性1点】！！！")
    return "强化成功！！！！！\n \n<@InfoItemRefine#"..num.." *01*返回>"
end
