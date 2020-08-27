function main(npc, player)
    lualib:AddShop(npc, 1)
    local msg = "\n  大人，近来可好，有什么能帮您的。\n"
    msg = msg..""
    msg = msg.."  #OFFSET<X:0,Y:5>##IMAGE1902700037##OFFSET<X:0,Y:-1># <@OpenShop#1 *01*买>武器                <@SellItem#1 *01*卖>武器\n  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@ShowRepire#1 *01*修理>武器\n  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@ShowRepireEx#1 *01*特殊修理>\n"
    msg = msg..""
    --msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@maincaihe *01*拆解>盾牌\n"
    --msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700017##OFFSET<X:0,Y:-1># <@fengyinjiesao *01*鉴定>说明\n"
    msg = msg.."  #OFFSET<X:0,Y:3>##IMAGE1902700017##OFFSET<X:0,Y:-1># <@talk *01*打听>命运之刃的消息 \n"
    msg = msg.."  #OFFSET<X:0,Y:5>##IMAGE<ID:1902700034>##OFFSET<X:0,Y:-2># <@leave *01*离开>\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function OpenShop(npc, player, id)
    lualib:OpenShop(npc, player, tonumber(id))
    return ""
end

function ShowRepire(npc, player)
    lualib:ShowForm(player, "修理表单")
    return ""
end

function ShowRepireEx(npc, player)
    lualib:ShowForm(player, "特殊修理表单")
    return ""
end

function SellItem(npc, player, id)
    lualib:ShowForm(player, "卖出物品表单")
    return ""
end

function leave(player)
    return ""
end


function main_ex(npc, player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."　#COLORCOLOR_LIGHTBROWN#╔━━━━╗　╔━━━━╗　╔━━━━╗　╔━━━━╗#COLOREND#\n"
    msg = msg.."#COLORCOLOR_RED#●#COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@InfoItemRefine *01*装备精炼>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@FengYin *01*解除封印>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jinglianzhuanyi *01*精炼转移>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jingliangaibian *01*精炼改变>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND#\n"
    msg = msg.."　#COLORCOLOR_LIGHTBROWN#╚━━━━╝　╚━━━━╝　╚━━━━╝　╚━━━━╝#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."　#OFFSET<X:0,Y:4>##IMAGE<ID:1902700017>#<@jinglianjiesao *01*[精炼说明]>#IMAGE<ID:1902700017>#<@fengyinjiesao *01*[封印说明]>#IMAGE<ID:1902700017>#<@zhuanyijiesao *01*[转移说明]>#IMAGE<ID:1902700017>#<@gaibianjieshao *01*[改变说明]>\n"
    return msg
end

function zhuanyijiesao(npc, player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."玩家可以利用#COLORCOLOR_GOLD#转神石#COLOREND#将精炼属性转移到同类型装备上，#COLORCOLOR_GOLD#转神石#COLOREND#拥有多种级别，可以对应转移不同级别的精炼属性.\n"
    msg = msg.."玩家在游戏中可通过怪物掉落和活动的方式获得#COLORCOLOR_GOLD#转神石#COLOREND#！\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."　　　　　　　　　　　　　　　　　            　　#OFFSET<X:0,Y:1>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [返回]>\n"
    return msg
end


function gaibianjieshao(npc, player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."玩家可以利用#COLORCOLOR_GOLD#灵元精粹#COLOREND#将精炼属性改变成此装备可精炼的其他类型属性。\n"
    msg = msg.."玩家在游戏中可通过活动的方式获得#COLORCOLOR_GOLD#灵元精粹#COLOREND#！\n"
    msg = msg.."#COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."　　　　　　　　　　　　　　　　　        　    　#OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [返回]>\n"
    return msg
end


function jinglianjiesao(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#●#COLOREND#　精炼一共分为15个等级，等级越高，精炼成功概率越低，灵\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#　　元珠消耗也越大，小心哦，精炼失败可是会掉级的哦\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@main *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao1 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao1(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#●#COLOREND#　不同部分装备所精炼的属性类型不同，但同时只能精炼一\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#　　种属性\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao2 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao2(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-6>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."#OFFSET<X:0,Y:-4>##COLORCOLOR_RED#●#COLOREND#　玩家携带全套精炼+6、+9、+12、+15的装备会有附加属性！而\n \n"
    msg = msg.."#OFFSET<X:0,Y:-2>#　　且人物属性界面会显示精炼徽章！\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao1 *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao3 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#"
    return msg
end




function zbxiayiye(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-9>##COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#========================================================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n \n"
    msg = msg.."　　　 #OFFSET<X:0,Y:-5>##COLORCOLOR_BLUE#╔╦╦╦╦╦╦╦╗　　　╔╦╦╦╦╦╦╦╗#COLOREND#\n"
    msg = msg.."　　　 #OFFSET<X:0,Y:-4>##COLORCOLOR_BLUE#╠#COLOREND#<@shuxingduiying *01*装备对应的属性>#OFFSET<X:-2,Y:0>##COLORCOLOR_BLUE#╬╬╬╬╬#COLOREND#<@fujia *01*装备附加的属性>#OFFSET<X:-2,Y:0>##COLORCOLOR_BLUE#╣#COLOREND#\n"
    msg = msg.."　　　 #OFFSET<X:0,Y:-4>##COLORCOLOR_BLUE#╚╩╩╩╩╩╩╩╝　╬　╚╩╩╩╩╩╩╩╝#COLOREND#\n"
    msg = msg.."　　　　　 #OFFSET<X:0,Y:-3>##COLORCOLOR_RED#卍#COLOREND##COLORCOLOR_GOLD#═══════════════#COLOREND##COLORCOLOR_RED#卐#COLOREND#\n \n"

    msg = msg.."　#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>#<@jinglianjiesao *01*「上一页」>　#OFFSET<X:1,Y:0>##COLORCOLOR_GOLD#　　　　　　　　　　　#COLOREND#　#IMAGE<ID:1902700019>#<@main *01*「返回首页」>\n\n"

    return msg
end


function jinglianjiesao3(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_RED#装备可精炼的属性#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#【   武器、戒指　 #OFFSET<X:2,Y:0>#】#COLOREND##COLORCOLOR_RED#→→→#COLOREND##COLORCOLOR_ORANGE#物攻上限、魔攻上限、道术上限#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#【衣服、头盔、鞋子】#COLOREND##COLORCOLOR_RED#→→→#COLOREND##COLORCOLOR_ORANGE#物防上限、魔防上限#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:0>##COLORCOLOR_GOLD#【项链、手镯、坐骑】#COLOREND##COLORCOLOR_RED#→→→#COLOREND##COLORCOLOR_ORANGE#HP上限、MP上限#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_BLUE#以上属性都为百分比，能整体提升自身属性。#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao2 *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao4 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n \n"
    return msg
end

function jinglianjiesao4(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#佩戴全套+6装备属性：\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#物防上限　提升　百分之三　#COLORCOLOR_RED#●#COLOREND#物攻上限　提升　百分之三\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#魔防上限　提升　百分之三　#COLORCOLOR_RED#●#COLOREND#魔攻上限　提升　百分之三\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#*HP*上限　#OFFSET<X:1,Y:0>#提升　百分之三　#COLORCOLOR_RED#●#COLOREND#道术上限　提升　百分之三\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#●#COLOREND#*MP*上限　#OFFSET<X:1,Y:0>#提升　#OFFSET<X:1,Y:0>#百分之三\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao3 *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao5 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao5(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#佩戴全套+9装备属性：\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#物防上限　提升　百分之六　#COLORCOLOR_RED#●#COLOREND#物攻上限　提升　百分之六\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#魔防上限　提升　百分之六　#COLORCOLOR_RED#●#COLOREND#魔攻上限　提升　百分之六\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#*HP*上限　#OFFSET<X:1,Y:0>#提升　百分之六　#COLORCOLOR_RED#●#COLOREND#道术上限　提升　百分之六\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#●#COLOREND#*MP*上限　#OFFSET<X:1,Y:0>#提升　#OFFSET<X:1,Y:0>#百分之六\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao4 *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao6 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao6(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#佩戴全套+12装备属性：\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#物防上限　提升百分之十　#COLORCOLOR_RED#●#COLOREND#物攻上限　提升百分之十\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#魔防上限　提升百分之十　#COLORCOLOR_RED#●#COLOREND#魔攻上限　提升百分之十\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#*HP*上限　#OFFSET<X:1,Y:0>#提升百分之十　#COLORCOLOR_RED#●#COLOREND#道术上限　提升百分之十\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#●#COLOREND#*MP*上限　#OFFSET<X:1,Y:0>#提升百分之十\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao5 *01*「上一页」>　　　　　　　　　　　　　      <@jinglianjiesao7 *01*「下一页」>#OFFSET<X:0,Y:2>##IMAGE<ID:1902700043>##OFFSET<X:0,Y:-2>#\n"
    return msg
end

function jinglianjiesao7(npc , player)
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:2>#佩戴全套+15装备属性：\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#物防上限　提升百分之十五　#COLORCOLOR_RED#●#COLOREND#物攻上限　提升百分之十五\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#魔防上限　提升百分之十五　#COLORCOLOR_RED#●#COLOREND#魔攻上限　提升百分之十五\n"
    msg = msg.."#OFFSET<X:0,Y:2>##COLORCOLOR_RED#●#COLOREND#*HP*上限　#OFFSET<X:1,Y:0>#提升百分之十五　#COLORCOLOR_RED#●#COLOREND#道术上限　提升百分之十五\n"
    msg = msg.."#OFFSET<X:0,Y:-1>##COLORCOLOR_RED#●#COLOREND#*MP*上限　#OFFSET<X:1,Y:0>#提升百分之十五\n"
    msg = msg.."#OFFSET<X:0,Y:-10>##COLORCOLOR_LIGHTBROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-3>##IMAGE<ID:1902700038>##OFFSET<X:0,Y:-2>#<@jinglianjiesao7 *01*「上一页」>　　　　　　　　　　　　       #OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*返回首页>\n"
    return msg
end


function fengyinjiesao(npc , player)
    local msg = ""
    msg = msg.."①：装备鉴定可以让装备增加意想不到的属性！\n"
    msg = msg.."②：装备鉴定时最高可获得3条属性，鉴定后有几率获得暴击，吸     血等稀有属性！\n"
    msg = msg.."③：可以重复鉴定，但获得什么属性就看你的运气咯！\n"
    msg = msg.."\n\n"
    msg = msg.."#OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@FengYin *01*装备鉴定>\n"
    msg = msg.."#OFFSET<X:0,Y:5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2># <@main *01*返回>\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg

end

function InfoItemRefine(npc, player)
    lualib:ShowForm(player, "精炼表单2")

    return ""
end

function FengYin(npc, player)
    --[[local msg = ""
    local StartServerTime = lualib:GetConstVar("StartServerTime")
    local StartServerTime_int = lualib:Str2Time(StartServerTime)
    local times = lualib:GetAllTime()
    local timesStr = lualib:Time2Str( "%Y-%m-%d %H:%M:%S", times)

    local time_cha = times - StartServerTime_int

    if time_cha < 86400 * 5 then 	--(5天)
        msg = msg .. "#OFFSET<X:0,Y:2>##COLORCOLOR_GREENG#封印鉴定系统将在开服5天后开启，请5天后再来！~\n"
        msg = msg.."　　　　　　　　　　　　　　　　　　　　　　　　#OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [返回]>\n"
        return msg
    end--]]

    --lualib:ShowForm(player, "鉴定表单")
    lualib:ShowFormWithContent(player, "form文件表单", "装备鉴定2")

    return ""
end

function jinglianzhuanyi(npc, player)
    lualib:ShowForm(player, "精炼转移表单")

    return ""
end

function jingliangaibian(npc, player)
    lualib:ShowForm(player, "精炼改变表单")

    return ""
end

-----命运任务-----

function talk(npc, player)
    if lualib:Level(player) < 35 then
        lualib:SetPanelSize(npc, 400, 200)
        return "\n 人的智慧是无穷的，虽说我们没有神魔强悍的体魄，但我们可以\n 依靠外物，好的兵器自然能提升你的实力，据传有一只武器可以\n 掌握命运，不知你是否听说。\n\n\n  #COLORCOLOR_MAGENTA#引发命运任务条件：等级达到35级，携带3块纯度15以上金矿。#COLOREND#\n  #COLORCOLOR_MAGENTA#命运之刃获取说明：随机获取命运!"
    end
    local msg = ""
    local itemName = {"金矿石15", "金矿石16", "金矿石17", "金矿石18", "金矿石19", "金矿石20"}
    local count = 0
    for i = 1, #itemName do
        count = count + lualib:ItemCountByKey(player, itemName[i], true, false, false, 2)
    end

    local my_quest = lualib:GetInt(player, "my_quest")

    if count > 0 and my_quest == 0 then
        lualib:SetInt(player, "my_quest", 1)
        msg = [[\n  你包里发光的是什么?难道是金矿?
		这些好的矿石你是怎么得来的，
		看样你是想让我为你铸造命运之刃了\n\n



		<@talk *01*继续对话>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    if my_quest == 1 and count >= 3 then
        msg = [[\n  虽说你是龙卫传人，
		我理应亲自为你铸造命运之刃，但毕竟我年纪大了，
		这样吧你把矿石给我，然后去找我的师弟他会帮你的，
		放心吧我们可是师出同门。\n\n
		
		<@give *01*好的给你> 
		<@refuse *01*拒绝>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    if my_quest == 2 then
        msg = [[\n  真不好意思，
		我光顾着看这些矿石了，
		我的师弟就是巫山城的李铁匠。\n\n


		
		<@leave *01*好的，谢谢>]]
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end

    msg = "\n 人的智慧是无穷的，虽说我们没有神魔强悍的体魄，但我们可以\n 依靠外物，好的兵器自然能提升你的实力，据传有一只武器可以\n 掌握命运，不知你是否听说。\n\n"
    --msg = msg.."#OFFSET<X:0,Y:3>##IMAGE1902700035##OFFSET<X:0,Y:-1># <@maincaihe *01*拆解锻造>盾牌\n\n\n\n"
    --msg = msg.."<@leave *01*知道了> \n"
    msg = msg.." #COLORCOLOR_MAGENTA#引发命运任务条件：人物等级达到35，携带3块纯度15以上金矿。#COLOREND#\n"
    msg = msg.." #COLORCOLOR_MAGENTA#命运之刃获取说明：随机获取命运!#COLOREND#\n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg

end

function refuse(npc, player)
    local msg = [[\n 什么？不能那样做？哦，看来你是在怀疑我。
	这么不相信人啊？
	你如果还这样坚持，以后我也有可能不和你做交易
	你还坚持拒绝吗？\n
	
	
	 <@give *01*好的给你>
	 <@refuseEx *01*还是拒绝> \n]]
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function refuseEx(npc, player)
    local msg = "\n 金矿那么珍贵吗?\n 这样我就没办法了?你走吧!\n \n\n\n\n\n\n"
    --msg = msg.."<@leave *01*关闭对话> \n"
    lualib:SetPanelSize(npc, 400, 200)
    return msg
end

function give(npc, player)
    local msg = ""
    local count = 0
    local itemName = {"金矿石15", "金矿石16", "金矿石17", "金矿石18", "金矿石19", "金矿石20"}
    local delItem = {}
    for i = 1, #itemName do
        count = count + lualib:ItemCountByKey(player, itemName[i], true, false, false, 2)
    end

    if count < 3  then
        msg = "\n 人的智慧是无穷的，虽说我们没有神魔强悍的体魄，但我们可以\n 依靠外物，好的兵器自然能提升你的实力，据传有一只武器可以\n 掌握命运，不知你是否听说。\n 引发命运任务条件：人物等级达到35，携带3块纯度15以上金矿。\n \n \n"
        --msg = msg.."<@leave *01*关闭对话> \n"
        lualib:SetPanelSize(npc, 400, 200)
        return msg
    end
    local x = 0
    for i = 1, #itemName do
        local itemCount = lualib:ItemCount(player,itemName[i])
        x = #delItem
        for j=1,itemCount do
            delItem[x+j] = itemName[i]
        end

        if #delItem >= 3 then
            for k = 1, 3 do
                lualib:DelItem(player,delItem[k],1,2,"命运之刃任务","武器店")
            end
            lualib:SetInt(player, "dddddd   d   dddddddd", 2)
            lualib:SetPanelSize(npc, 400, 200)
            return "\n  好纯的矿石，不错不错。快去找我师弟吧，还站在这里干嘛。\n\n \n \n\n \n \n  <@talk *01*你还没有告诉我去哪寻找你的师弟>"
        end

    end

    return msg
end


--------拆分------


--请注意连接"#"后面跟的装备索引名   chai_ex#圆盾  比如这样

local chai_t = {--索引名 = {随机最小值. 随机最大值. 给予的材料索引名, 消耗金币}
    ["圆盾"] = {1, 5, "玄铁", 100000},
    ["自由之盾"] = {5, 10, "玄铁", 10000},
}

local he_t = {--索引名 = {{材料...},{对应数量...},消耗金币}
    ["传说之盾"] = {{"自由之盾", "玄铁", "精灵之骨"}, {1, 50, 5}, 1000000},
    ["自由之盾"] = {{"圆盾", "玄铁", "精灵之骨"}, {1, 20, 2}, 500000},
}

function maincaihe(npc, player)
    local msg = [[
    客官您好，我可以帮你把低级的盾牌拆解成为#COLORCOLOR_GOLD#“玄铁”#COLOREND#，每次拆解随机获得数量。玄铁是锻造高级盾牌必备材料，下面就选择你要进行的操作吧。
	
#IMAGE1902700035#<@chai *01*拆解>盾牌        #COLORCOLOR_GREENG#请将需要拆解的盾牌放在背包#COLOREND#
#IMAGE1902700035#<@he *01*锻造>高级盾牌    #COLORCOLOR_GREENG#请将锻造需要的材料放在背包#COLOREND#
	
]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end


function chai(npc, player)
    local msg = [[
请选择您要拆解的盾牌：


#IMAGE1902700035#<@chai_ex#圆盾 *01*拆解>圆盾        #COLORCOLOR_GREENG#拆解后随机获得1~5块玄铁#COLOREND#

	]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end

function chai_ex(npc, player, key)
    lualib:SetPanelSize(npc, 400, 188)
    if lualib:ItemCount(player, key) < 1 then
        return "您的背包中并没有“#COLORCOLOR_GREENG#"..key.."#COLOREND#”。"
    end
    if lualib:GetBagFree(player) < 1 then
        return "您的背包空间不足一格。"
    end
    if not lualib:SubGold(player, chai_t[key][4], "盾牌拆解", npc) then
        return "您的金币不足“#COLORCOLOR_GREENG#"..chai_t[key][4].."#COLOREND#”。"
    end
    if not lualib:DelItem(player, key, 1, 2, "盾牌拆解", npc) then
        return "删除盾牌失败。"
    end
    local rnd = lualib:GenRandom(chai_t[key][1], chai_t[key][2])
    lualib:AddItem(player, chai_t[key][3], rnd, false, "盾牌拆解", npc)
    return "恭喜您成功拆解“#COLORCOLOR_GREENG#"..key.."#COLOREND#”，获得 #COLORCOLOR_GREENG#"..rnd.."#COLOREND# 颗#COLORCOLOR_GREENG#"..chai_t[key][3].."#COLOREND#。\n\n\n<@chai_ex#圆盾 *01*继续>拆解圆盾\n"
end


function he(npc, player)
    local msg = [[
请选择您要锻造的盾牌：


#IMAGE1902700035#<@he_ex#自由之盾 *01*锻造>自由之盾    #COLORCOLOR_GREENG#    圆盾+玄铁20个+精灵之骨2个+ 50万金币#COLOREND#
#IMAGE1902700035#<@he_ex#传说之盾 *01*锻造>传说之盾    #COLORCOLOR_GREENG#自由之盾+玄铁50个+精灵之骨5个+100万金币#COLOREND#

	]]
    lualib:SetPanelSize(npc, 400, 188)
    return msg
end


function he_ex(npc, player, key)
    lualib:SetPanelSize(npc, 400, 188)
    if lualib:GetBagFree(player) < 1 then
        return "您的背包空间不足一格。"
    end
    for i = 1, #he_t[key][1] do
        if lualib:ItemCount(player, he_t[key][1][i]) < he_t[key][2][i] then
            return "您的背包中并没有足够数量的“#COLORCOLOR_GREENG#"..he_t[key][1][i].."#COLOREND#”。"
        end
    end
    if lualib:GetGold(player) < he_t[key][3] then
        return "抱歉，您的金币不足#COLORCOLOR_GREENG#"..he_t[key][3].."#COLOREND#。"
    end
    for k = 1, #he_t[key][1] do
        if not lualib:DelItem(player, he_t[key][1][k], he_t[key][2][k], 2, "盾牌锻造", npc) then
            return "删除原材料失败。"
        end
    end
    if not lualib:SubGold(player, he_t[key][3], "盾牌锻造", npc) then
        return "扣除金币失败。"
    end
    lualib:AddItem(player, key, 1, false, "盾牌锻造", npc)
    lualib:SysMsg_SendBroadcastColor("玩家【"..lualib:Name(player).."】历尽千辛万苦终于成功锻造出绝世珍品“"..lualib:KeyName2Name(key, 4).."”", "系统通知", 7, 13)
    return "恭喜您成功锻造“#COLORCOLOR_GREENG#"..key.."#COLOREND#”。"
end