local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)

local jine = {
    ["小红包"] = {1,50},
    ["中红包"] = {51,100},
    ["大红包"] = {101,200},
}

function main(player,item)
    local key = lualib:KeyName(item)
    local random = lualib:GenRandom(jine[key][1],jine[key][2])
    lualib:AddIngot(player,random, "使用元宝红包", "红包")
    lualib:SysPromptMsg(player,"恭喜获得"..random.."元宝")
    return true
end

lualib:SysMsg_SendBroadcastMsg("玛法大陆勇士["..lualib:KeyName(killer).."]将→→龙的传人["..lualib:KeyName(player).."]击杀获得500元宝，强力围观中！！！
", "[国际要闻]")


local job = lualib:Job(player)
if job == 1 then
    lualib:Player_AddSkill(player, "基本剑术4级")
    lualib:Player_AddSkill(player, "攻杀剑术4级")
    lualib:Player_AddSkill(player, "刺杀剑术4级")
    lualib:Player_AddSkill(player, "半月弯刀4级")
    lualib:Player_AddSkill(player, "野蛮冲撞4级")
    lualib:Player_AddSkill(player, "烈火剑法4级")

elseif job == 2 then
    lualib:Player_AddSkill(player, "火球术4级")
    lualib:Player_AddSkill(player, "抗拒火环4级")
    lualib:Player_AddSkill(player, "诱惑之光4级")
    lualib:Player_AddSkill(player, "雷电术4级")
    lualib:Player_AddSkill(player, "烈焰火海4级")
    lualib:Player_AddSkill(player, "瞬息移动4级")
    lualib:Player_AddSkill(player, "爆裂火焰4级")
    lualib:Player_AddSkill(player, "疾光电影4级")
    lualib:Player_AddSkill(player, "地狱雷光4级")
    lualib:Player_AddSkill(player, "圣言术4级")
    lualib:Player_AddSkill(player, "魔法盾4级")
    lualib:Player_AddSkill(player, "冰咆哮4级")

elseif job == 3 then
    lualib:Player_AddSkill(player, "治愈术4级")
    lualib:Player_AddSkill(player, "精神力战法4级")
    lualib:Player_AddSkill(player, "施毒术4级")
    lualib:Player_AddSkill(player, "隐身术4级")
    lualib:Player_AddSkill(player, "灵魂火符4级")
    lualib:Player_AddSkill(player, "召唤骷髅4级")
    lualib:Player_AddSkill(player, "集体隐身术4级")
    lualib:Player_AddSkill(player, "幽灵盾4级")
    lualib:Player_AddSkill(player, "神圣战甲术4级")
    lualib:Player_AddSkill(player, "困魔咒4级")
    lualib:Player_AddSkill(player, "群体治愈术4级")
    lualib:Player_AddSkill(player, "召唤灵兽4级")
end

if lualib:Job(player) == 1 and lualib:Level(pleyer) > 48 then
    lualib:DelSkill(player,"召唤灵兽4级")
    lualib:AddSkill(player,"召唤白虎4级")
end