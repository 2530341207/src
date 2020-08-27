local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/timecount_def")
require("system/serializer")
require("system/logic_def_lua")



local talk_t = {"如果你不满意装备的属性，可以进行精炼属性修改。", "解除封印可以使你的装备获得额外的属性能力。", "精炼装备和精炼转移可以使你的武器装备的威力更上一层。"}

function on_create(npc)
    lualib:AddTimer(npc, 1, 25000, -1, "on_timer_talk")
end

function on_timer_talk(npc, timer_id)

    lualib:SysMsg_SendRoleTalk(npc, talk_t[lualib:GenRandom(1, #talk_t)])

end

function main(npc, player)
    if lualib:GetClientType(player) == 2 then
        local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#===============#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#==============#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
        msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
        msg = msg.."#COLORCOLOR_LIGHTBROWN#╔━━━━╗　╔━━━━╗　╔━━━━╗　╔━━━━━╗#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED##COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@InfoItemRefine *01*装备精炼>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@FengYin *01*解除封印>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jinglianzhuanyi *01*精炼转移>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jingliangaibian *01*高级元灵珠>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED##COLOREND#\n"
        msg = msg.."#COLORCOLOR_LIGHTBROWN#╚━━━━╝　╚━━━━╝　╚━━━━╝　╚━━━━━╝#COLOREND#\n"

        msg = msg.."#COLORCOLOR_LIGHTBROWN#╔━━━━╗　╔━━━━╗　╔━━━━━╗　╔━━━━╗#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED##COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@xyun *01*项链幸运>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@zhuanyi *01*幸运转移>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@hecheng *01*高级鉴定符>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN##COLOREND#<@zhufuyou *01*幸运合成>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃\n"
        msg = msg.."#COLORCOLOR_LIGHTBROWN#╚━━━━╝　╚━━━━╝　╚━━━━━╝　╚━━━━╝#COLOREND#\n"


        msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"

        return msg

    else
        local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
        msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
        msg = msg.."　#COLORCOLOR_LIGHTBROWN#╔━━━━╗　╔━━━━╗　╔━━━━╗　╔━━━━━╗#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED#●#COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@InfoItemRefine *01*装备精炼>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@FengYin *01*解除封印>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jinglianzhuanyi *01*精炼转移>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@jingliangaibian *01*高级元灵珠>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND#\n"
        msg = msg.."　#COLORCOLOR_LIGHTBROWN#╚━━━━╝　╚━━━━╝　╚━━━━╝　╚━━━━━╝#COLOREND#\n"

        msg = msg.."　#COLORCOLOR_LIGHTBROWN#╔━━━━╗　╔━━━━╗　╔━━━━━╗　╔━━━━╗#COLOREND#\n"
        msg = msg.."#COLORCOLOR_RED#●#COLOREND##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@xyun *01*项链幸运>#OFFSET<X:-2,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@zhuanyi *01*幸运转移>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@hecheng *01*高级鉴定符>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND##COLORCOLOR_RED#●#COLOREND##OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃#COLOREND#<@zhufuyou *01*幸运合成>#OFFSET<X:-1,Y:0>##COLORCOLOR_LIGHTBROWN#┃\n"
        msg = msg.."　#COLORCOLOR_LIGHTBROWN#╚━━━━╝　╚━━━━╝　╚━━━━━╝　╚━━━━╝#COLOREND#\n"

        msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"

        return msg
    end
end

function xyun(npc, player)
    local item_guid = lualib:Player_GetItemGuid(player, 9)
    local equip_name = "当前没有携带项链"
    if item_guid ~= "" and item_guid ~= nil then
        equip_name = lualib:Name(item_guid)
    end
    local msg = "只要你能支付10000荣耀点即可为你身上所携带的项链增加幸运...\n#COLORCOLOR_PURPLE#项链最高只能增加3点幸运...#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:0>##IMAGE1902700041##OFFSET<X:0,Y:-1>#当前项链:  #COLORCOLOR_BLUE#"..equip_name.."#COLOREND#\n\n"
    msg = msg.."#OFFSET<X:0,Y:0>##IMAGE1902700032##OFFSET<X:0,Y:-1>#<@luck_ex *01*「确定升级」>              <@zhuanyi *01*「幸运转移」>\n\n"
    msg = msg.."#COLORCOLOR_ORANGE#▂▂▂▂▂本领有限,升级项链成功率只有30%哟▂▂▂▂▂#COLOREND#\n"
    msg = msg.."                                              #OFFSET<X:0,Y:5>##IMAGE1902700014##OFFSET<X:0,Y:-2>#<@Leave *01*「离开」>\n"
    return msg
end


function luck_ex(npc,player)
    local item_guid = lualib:Player_GetItemGuid(player, 9)		--项链的GUID
    local wq_guid = lualib:Player_GetItemGuid(player, 1)		--武器的GUID
    local r = lualib:GenRandom(1, 100)
    if item_guid == "" then
        return "您没有装备项链!\n \n#IMAGE<ID:1902700019>#<@main *01*「返回」>"
    end

    if lualib:GetIntegral(player)<10000 then
        return "您的荣耀点不足!\n                                               #OFFSET<X:0,Y:5>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回首页」>"
    end

    local luck_role_t = lualib:LuckCurse(player)
    local luck_curse_xl = lualib:Equip_GetLuckCurse("", item_guid)
    local luck_curse_wq = lualib:Equip_GetLuckCurse("", wq_guid)
    local luck_curse = luck_role_t - luck_curse_wq

    if luck_curse_xl >= 3 then
        return "您的项链已经幸运到顶级了!\n                                               #OFFSET<X:0,Y:5>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回首页」>"
    end
    --if luck_curse_xl < luck_curse then
    --luck_curse = luck_curse_xl
    --end


    if not lualib:Player_SubIntegral(player, 10000, "提升幸运属性1", player) then
        return "扣除荣耀点失败!\n \n#IMAGE<ID:1902700019>#<@main *01*「返回」>"
    end
    local jlv = 30
    if luck_curse_xl == 1 then
        jlv = 20
    elseif luck_curse_xl == 2 then
        jlv = 8
    end


    if r >= jlv then
        if lualib:Equip_SetLuckCurse(player, item_guid, luck_curse_xl + 1) == false then
            return "提升幸运失败!请联系管理！\n                                               #OFFSET<X:0,Y:5>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回首页」>"
        end

        local s = "恭喜玩家:【"..lualib:Name(player).."】通过【幸运大师】，提升了项链的幸运！"
        lualib:SysMsg_SendBroadcastColor(s, "", 1, 3)
        return "您的项链成功加了幸运!"
    end
    return "很遗憾，您这次的幸运属性提升失败，下次可能会成功！加油！\n \n#IMAGE<ID:1902700019>#<@main *01*「返回」>"
end



function zhuanyi(npc, player)
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player,"form文件表单","幸运转")
        return ""
    else
        lualib:ShowFormWithContent(player,"form文件表单","幸运转移")
        return ""
    end
end



function heccs(npc, player)
    if lualib:GetClientType(player) == 2 then
    else
        local content = serialize(item_table["战士"])
        lualib:ShowFormWithContent(player, "装备合成表单", content)
    end
    return ""
end


function shenl(npc, player)
    lualib:ShowFormWithContent(player,"form文件表单","神炼属性")
    return ""
end

function shenz(npc, player)
    lualib:ShowFormWithContent(player,"form文件表单","神炼转移")
    return ""
end



function jipin(npc, player)
    lualib:DelayCall(player, 1, "极品进阶表单:show", "")
    return ""
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
    local msg = " #COLORCOLOR_RED#㊣#COLOREND##COLORCOLOR_GOLD#=================#COLOREND##COLORCOLOR_RED#欢迎光临装备精炼系统#COLOREND##COLORCOLOR_GOLD#================#COLOREND##COLORCOLOR_RED#㊣#COLOREND#\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"

    msg = msg.."#OFFSET<X:0,Y:5>##COLORCOLOR_RED#㈠：#COLOREND##COLORCOLOR_ORANGE#封印解除可以让装备得到意想不到的属性！#COLOREND#\n"
    msg = msg.."#COLORCOLOR_RED#㈡：#COLOREND##COLORCOLOR_ORANGE#封印鉴定时最高可获得3条属性，鉴定后右机率获得暴击、吸血等稀有属性！#COLOREND#\n"
    msg = msg.."#COLORCOLOR_RED#㈢：#COLOREND##COLORCOLOR_ORANGE#可以重置封印属性，但重置后获得什么属性就看你运气咯！#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-2>##COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."　　　　　　　　　　　　　　　　　　　　　　　　#OFFSET<X:0,Y:2>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01* [返回]>\n"
    return msg

end

function zhufuyou(npc,player)

    local msg = ""
    msg = msg.."#COLORCOLOR_GREENG#              超级祝福油炼制 \n"
    msg = msg.."#COLORCOLOR_BROWN#────────────────────────#COLOREND#\n"
    msg = msg.."#IMAGE1902700037##COLORCOLOR_GREENG#<@enter#1  *01*金币炼制>=50祝福神油+500W金币(成功率百分之50)#COLOREND#        \n\n"
    msg = msg.."#IMAGE1902700037##COLORCOLOR_GREENG#<@enter#2  *01*元宝炼制>=50祝福神油+1000元宝(成功率百分之50)#COLOREND#        \n\n"
    msg = msg.."#IMAGE1902700037##COLORCOLOR_GREENG#<@enter#3  *01*元宝炼制>=60祝福神油+5000元宝(成功率百分之百)#COLOREND#        \n"
    msg = msg.."#COLORCOLOR_BROWN#────────────────────────#COLOREND#\n"


    return msg
end

local tab = {
    [1] = {
        --战士
        {"超级祝福油",100},
    },
    [2] = {
        {"超级祝福油",100},
    },
    [3] = {
        {"超级祝福油",100},
    },
}

--每一级的兑换概率
local pre = {
    --成功概率，材料key，材料数量，消耗金币，元宝
    {50,"祝福油",50,5000000,0},
    {50,"祝福油",50,0,1000},
    {100,"祝福油",50,0,5000},
}

function enter(npc,player,param)
    local name = lualib:Name(player)
    param = tonumber(param)
    if lualib:ItemCount(player,pre[param][2]) < pre[param][3] then
        return "你的材料不足"
    end
    if not lualib:Player_IsGoldEnough(player,pre[param][4],false) then
        return "你的金币不足"
    end
    if not lualib:Player_IsIngotEnough(player,pre[param][5],false) then
        return "你的元宝不足"
    end

    lualib:DelItem(player,pre[param][2],pre[param][3],2,"幸运合成","幸运合成")
    lualib:Player_SubGold(player,pre[param][4],false,"幸运合成","幸运合成")
    lualib:Player_SubIngot(player,pre[param][5],false,"幸运合成","幸运合成")

    local to = lualib:GenRandom(1,100)
    if to <= pre[param][1] then
        local rig = tab[param]

        local all = 0
        for i = 1,#rig do
            all = all + rig[i][2]
        end

        local big = 0
        local small = lualib:GenRandom(1,all)
        for i = 1,#rig do
            big = big + rig[i][2]
            if small <= big then
                lualib:AddItem(player,rig[i][1],1,false,"幸运合成","幸运合成")
                lualib:SysMsg_SendBroadcastColor("恭喜玩家【"..name.."】合成了"..rig[i][1].."！", "", 1, 11)
                break
            end
        end

        return "恭喜您合成超级祝福油！      \n \n<@enter#1 *01*「继续合成」>"

    else
        return "不好意思，我手艺退化，未能帮您合成，您下次在来吧"
    end
end

function InfoItemRefine(npc, player)
    if lualib:GetClientType(player) == 2 then
        lualib:ShowFormWithContent(player,"form文件表单","装备精炼")
        return ""
    else
        lualib:ShowForm(player, "精炼表单2")

        return ""
    end
end
function FengYin(npc, player)
    lualib:ShowForm(player, "鉴定表单")

    return ""
end

function jinglianzhuanyi(npc, player)
    lualib:ShowForm(player, "精炼转移表单")

    return ""
end

local synthesis = {
    {
        ["material"]="灵元珠",
        ["item"]="高级灵元珠",
        ["ingots"] = 1000,
        ["itemNum"] = 5
    },
    {
        ["material"]="封印鉴定符",
        ["item"]="超级鉴定符",
        ["ingots"] = 1000,
        ["itemNum"] = 5
    }
}

function jingliangaibian(npc, player)
    if lualib:GetIngot(player) < synthesis[1].ingots  then
        lualib:MsgBox(player,"您的元宝不足!!!")
        return ""
    end
    if lualib:ItemCount(player,synthesis[1].material) < synthesis[1].itemNum then
        lualib:MsgBox(player,"您的"..synthesis[1].material.."不足"..synthesis[1].itemNum.."个!!!")
        return ""
    end
    lualib:Player_SubIngot(player,synthesis[1].ingots,false,"合成超级灵元珠扣除元宝","装备大师")
    lualib:DelItem(player,synthesis[1].material,synthesis[1].itemNum,2,"合成超级灵元珠扣除元宝","装备大师")
    lualib:AddItem(player,synthesis[1].item,1,false,"合成超级灵元珠", "装备大师")
    lualib:MsgBox(player,"合成成功！")
    return ""
end

function hecheng(npc,player)
    if lualib:GetIngot(player) < synthesis[2].ingots  then
        lualib:MsgBox(player,"您的元宝不足!!!")
        return ""
    end
    if lualib:ItemCount(player,synthesis[2].material) < synthesis[2].itemNum then
        lualib:MsgBox(player,"您的"..synthesis[2].material.."不足"..synthesis[2].itemNum.."个!!!")
        return ""
    end
    lualib:Player_SubIngot(player,synthesis[2].ingots,false,"合成超级鉴定符扣除元宝","装备大师")
    lualib:DelItem(player,synthesis[2].material,synthesis[2].itemNum,2,"合成超级鉴定符扣除物品","装备大师")
    lualib:AddItem(player,synthesis[2].item,1,false,"合成超级鉴定符", "装备大师")
    lualib:MsgBox(player,"合成成功！")
    return ""
end