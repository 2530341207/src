local path = "龙城, 188, 680, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 190, 680, 0,    龙城, 186, 682, 0,    龙城, 188, 676, 0,    龙城, 188, 680, 0,	龙城, 174, 666, 0,	龙城, 159, 641, 0,	龙城, 158, 632, 0,	龙城, 156, 606, 0,	龙城, 150, 600, 0,	龙城, 140, 600, 0,	龙城, 139, 583, 0,	龙城, 139, 577, 0,	龙城, 143, 572, 0,	龙城, 141, 560, 0,	龙城, 139, 551, 0,	龙城, 141, 537, 0,	龙城, 143, 523, 0,	龙城, 150, 510, 0,	龙城, 150, 502, 0,	龙城, 144, 496, 0,	龙城, 141, 484, 0,	龙城, 139, 474, 0,	龙城, 137, 446, 0,	龙城, 135, 431, 0,	龙城, 135, 415, 0,	龙城, 128, 410, 0,	龙城, 118, 410, 0,	龙城, 115, 404, 0,	龙城, 113, 396, 0,	龙城, 105, 392, 0,	龙城, 102, 388, 0,	龙城, 99, 376, 0,	龙城, 99, 368, 0,	龙城, 95, 356, 0,	龙城, 86, 357, 0,	龙城, 86, 351, 0,	龙城, 90, 345, 0,	龙城, 86, 334, 0,	龙城, 86, 324, 0,	龙城, 86, 311, 0,	龙城, 80, 303, 0,	龙城, 82, 292, 0,	龙城, 82, 270, 0,	龙城, 86, 266, 0,	龙城, 83, 256, 0,	龙城, 83, 227, 0,	龙城, 77, 221, 0,	龙城, 77, 211, 0,	龙城, 73, 203, 0,	龙城, 67, 197, 0,	龙城, 63, 193, 0,	龙城, 47, 193, 0,	龙城, 47, 192, 0,	龙城, 36, 113, 0,	龙城, 34, 97, 0,	龙城, 18, 97, 0,	龙城, 17, 97, 0,	东临城, 424, 393, 0,	东临城, 422, 389, 0,	东临城, 388, 355, 0"

gQuestMap =
{
    {3001, "QuestAccept3001", "","*01*任务: 押镖", ""}
}
gQuestNum = table.getn(gQuestMap)
local Escorter = --领任务用
{
    campaign_id = 12,        --活动id
    req_npc = "龙城军需官",  --押送接任务NPC
    str_gold = "扣金币：接镖车护送任务",
    str_ingot = "扣元宝：接镖车护送任务",
    req_gold = 0,            --押送需求金币5000
    color_flag =             --押送颜色标识
    {
        --镖车颜色          ,元宝花费   ,                ,镖车名字  ,广播 ,镖车keyname
        {"#COLORCOLOR_WHITE#",   0,         "#COLOREND#", "镖车·普", false, "镖车·普"},
        {"#COLORCOLOR_GREENG#",  15,       "#COLOREND#", "镖车·极", false, "镖车·极"},
        {"#COLORCOLOR_BLUE#",    15,       "#COLOREND#", "镖车·珍", false, "镖车·珍"},
        {"#COLORCOLOR_PURPLE#",   15,       "#COLOREND#", "镖车·绝", true, "镖车·绝"},
        {"#COLORCOLOR_GOLD#" ,    15,       "#COLOREND#", "镖车·神", true, "镖车·神"},
    },
    cur_color = "escort_color",--当前镖车颜色
    cur_level = "cur_level",   --存放镖车主人的等级
    cur_guid = "cur_guid",     --存放镖车主人的GUID
    life = 3600,               --镖车存在时间
    cur_dest = "cur_dest",     --保存镖车目的地
    escort_dest = "东临城军需官"
}
--------------------------------------------------------------------------------
function Escorter:VerifyLevel(player)
    return lualib:VerifyCampLevel(player, self.campaign_id)
end

function Escorter:VerifyCampaign(player)
    return lualib:VerifyCampCount(player, self.campaign_id)
end

function Escorter:JoinCampaign(player)
    lualib:JoinCamp(player, self.campaign_id, 0)
end

function Escorter:VerifyGold(player)
    return lualib:Player_IsGoldEnough(player, self.req_gold, false)
end

function Escorter:SubGold(player)
    return lualib:Player_SubGold(player, self.req_gold, false,
            self.str_gold, self.req_npc)
end

function Escorter:VerifyIngot(player, ingot)
    return lualib:Player_IsIngotEnough(player, ingot, false)
end

function Escorter:SubIngot(player, ingot)
    return lualib:Player_SubIngot(player, ingot, false,
            self.str_ingot, self.req_npc)
end

function Escorter:SetColor(player, color)
    lualib:SetInt(player, self.cur_color, color)
end

function Escorter:GetColor(player)
    return lualib:GetInt(player, self.cur_color)
end

function Escorter:GenColor(player)
    local color = self:GetColor(player)
    if color == #self.color_flag then return nil, nil end

    color = math.random(1, #self.color_flag)
    return color, self.color_flag[color][2]
end

function Escorter:IsEscorterDied(player)
    if lualib:IsEscorterDied(player) then
        self:SetColor(player, 0)
        return true
    end
    return false
end
--------------------------------------------------------------------------------
local talk_t = {"我相信恶魔再多，也无法阻止人类走向东临城的脚步。", "押镖押镖，你押的可不是镖，而是传说。", "金镖银镖，不如拉满粮食的白镖。"}

function on_create(npc)
    lualib:AddTimer(npc, 1, 310000, -1, "on_timer_talk")
end

function on_timer_talk(npc, timer_id)

    lualib:SysMsg_SendRoleTalk(npc, talk_t[lualib:GenRandom(1, #talk_t)])

end

function main(npc, player)
    local msg = "    东临城乃是人类与妖魔激战之地，需要大量的物资，我正在召集有志者押送镖车前往东临城，以支援前线的人们，你愿意去吗？\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."    35级后，你可每天到我这里来免费押送3次镖#COLORCOLOR_GREENG#(VIP每天可5次)#COLOREND#，完成后会获得大量的非绑定金币，以及大量特殊物品哦！\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."#IMAGE<ID:1902700037>##OFFSET<X:0,Y:-1>#<@Accept *01*「押镖」>                #OFFSET<X:0,Y:1>##IMAGE<ID:1902700017>#<@jieshao *01*「押镖介绍」>\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n \n"
    msg = msg.."                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700034>##OFFSET<X:0,Y:-2>#<@likai *01*「离开」>\n"
    for i, v in ipairs(gQuestMap) do
        if v[2] ~= "" then
            if lualib:CanAcceptQuest(player, v[1]) == true then
                msg = msg.."<@"..v[2].." "..v[4]..">\n"
            end
        end

        if v[3] ~= "" then
            if lualib:CanAccomplishQuest(player, v[1]) == true then
                msg = msg.."<@"..v[3].." "..v[5]..">\n"
            end
        end
    end
    return msg
end

function Accept(npc, player)
    if not Escorter:VerifyLevel(player) then
        return "你级别不够，请35级后再来吧！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    end

    if Escorter:IsEscorterDied(player) then
        return "当前没有镖车任务，你可以领取押镖任务！\n \n \n \n \n #OFFSET<X:0,Y:-5>##IMAGE1902700033##OFFSET<X:0,Y:-1>#<@AcceptEx *01*「确认」>\n \n                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    else
        local cur_color = Escorter:GetColor(player)
        if cur_color ~= #Escorter.color_flag then
            return "当前镖车为"..Escorter.color_flag[cur_color][1]
                    ..Escorter.color_flag[cur_color][4]
                    ..Escorter.color_flag[cur_color][3]..
                    "，你可以刷新更高级押镖任务！\n \n \n \n \n #OFFSET<X:0,Y:-5>##IMAGE1902700033##OFFSET<X:0,Y:-1>#<@StartEscort *01*「确认」>\n \n                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        else
            return "当前镖车为"..Escorter.color_flag[cur_color][1]
                    ..Escorter.color_flag[cur_color][4]
                    ..Escorter.color_flag[cur_color][3]..
                    "，已达到最高镖车等级！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
    end
end

function jieshao(npc, player)
    local msg = "35级后，你可每天到我这里来免费押送3次镖#COLORCOLOR_GREENG#(VIP每天可5次)#COLOREND#，完成后会获得大量的非绑定金币，以及大量特殊物品哦！\n"
    msg = msg.."#COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."#COLORCOLOR_YELLOW# 1.镖车品质分为：普、极、珍、绝、神；玩家第一次接取时随机生 成镖车品质，如果对镖车品质不满意，可以使用循环魔咒刷新！#COLOREND#\n "
    msg = msg.."#COLORCOLOR_YELLOW#2.这世界上有人以劫镖为生，因为劫取镖车后获得的镖银，也能换 取大量好处！所以你要额外小心那些人！#COLOREND#\n"
    msg = msg.."#OFFSET<X:0,Y:-8>##COLORCOLOR_BROWN#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂#COLOREND#\n"
    msg = msg.."                                            #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    return msg
end

function AcceptEx(npc, player)
    if Escorter:VerifyCampaign(player) then
        Escorter:JoinCampaign(player)
        lualib:SetInt(player, "yabiao", 0)
        return StartEscort(npc, player)
    else
        local vip_level = lualib:GetVipLevel(player)
        local yabiao_vip = lualib:GetInt(player, "yabiao")
        if vip_level > 0 and yabiao_vip <= 2 then
            Escorter:JoinCampaign(player)
            lualib:SetInt(player, "yabiao", yabiao_vip + 1)
            return StartEscort(npc, player)
        else
            return "你不累么，先休息一下，明天再来吧！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
    end
    --[[
        if not Escorter:VerifyCampaign(player) then
            return "你不累么，先休息一下，明天再来吧！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-5>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
        Escorter:JoinCampaign(player)
        return StartEscort(npc, player)]]
end

function StartEscort(npc, player)
    local cur_color = Escorter:GetColor(player)

    if Escorter:IsEscorterDied(player) then
        local init_color, init_ingot = Escorter:GenColor(player)
        return RefreshEx(npc, player, init_color, init_ingot, cur_color)
    end

    local new_color = nil
    local new_ingot = nil
    local msg = "当前镖车为"..Escorter.color_flag[cur_color][1]
            ..Escorter.color_flag[cur_color][4]
            ..Escorter.color_flag[cur_color][3].."。"

    if cur_color ~= #Escorter.color_flag then
        new_color, new_ingot = Escorter:GenColor(player)
        msg = msg.."你可以使用#COLORCOLOR_RED#循环魔咒#COLOREND#重新生成镖车品质，每次刷新消耗1个循环魔咒！\n \n \n \n \n"
        --[[    ..Escorter.color_flag[new_color][1]
            ..Escorter.color_flag[new_color][4]
        ..Escorter.color_flag[new_color][3].."。]]
        msg = msg.."#OFFSET<X:6,Y:-5>##IMAGE1902700032##OFFSET<X:0,Y:-1>#<@Refresh#"..new_color.."#"..new_ingot.."#"..cur_color.." *01*「刷新」>\n"
    else
        msg = msg.."\n \n \n"
    end

    msg = msg.."                                                  #OFFSET<X:0,Y:0>##IMAGE1902700019##OFFSET<X:0,Y:-2>#<@main *01*「返回」>\n"
    return msg
end

function RefreshEx(npc, player, color, ingot, old_color)
    local cur_color = tonumber(color)
    local cur_ingot = tonumber(ingot)
    old_color = tonumber(old_color)

    if Escorter:IsEscorterDied(player) then
        if old_color ~= Escorter:GetColor(player) then
            return "你的镖车任务已经失败了！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
    end

    if not Escorter:VerifyGold(player) then
        return "呃，常言道有鬼能使钱推磨，，呃呃！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    end

    if not Escorter:SubGold(player) then
        return "呃，我还没收到你的钱呢！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    end

    local monster = Escorter.color_flag[cur_color][6]
    if monster == nil then return "唉呀呀，镖车故障了！！！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>" end

    if not lualib:GenEscorter(player, monster, Escorter.life) then --lualib:GenTraveler(player, monster, Escorter.life, path) then
        return "呃。。。请确保镖车在你附近！！！\n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>"
    end

    lualib:SetInt(lualib:GetEscorter(player), Escorter.cur_level, lualib:Level(player))
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_dest, Escorter.escort_dest)
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_guid, player)

    if Escorter.color_flag[cur_color][5] then
        lualib:SysMsg_SendCenterMsg(1, lualib:Name(player).."接到了"
                ..Escorter.color_flag[cur_color][4]..
                "任务，祝他一路顺风！嘿嘿，希望劫镖的玩家看不见他……看不见他……", "")
    end

    lualib:SysMsg_SendPromptMsg(player, "镖车刷新成功！")
    Escorter:SetColor(player, cur_color)
    return StartEscort(npc, player)
end


function Refresh(npc, player, color, ingot, old_color)
    local cur_color = tonumber(color)
    local cur_ingot = tonumber(ingot)
    old_color = tonumber(old_color)

    if Escorter:IsEscorterDied(player) then
        if old_color ~= Escorter:GetColor(player) then
            return "你的镖车任务已经失败了！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
    end

    if not Escorter:VerifyGold(player) then
        return "呃，常言道有鬼能使钱推磨，，呃呃！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
    end

    --[[if not Escorter:VerifyIngot(player, cur_ingot) then
        return "找我办事怎么可以没有元宝呢！？\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>"
    end]]
    if cur_color ~= #Escorter.color_flag then
        if lualib:ItemCountByKey(player, "循环魔咒", true, false, false, 2) < 1 then
            return "呃，如果没有循环魔咒，我可不会帮你的！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
    end
    --[[
        if not Escorter:SubGold(player) then
            return "呃，我还没收到你的钱呢！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@main *01*「返回」>"
        end
        ]]

    --[[if not Escorter:SubIngot(player, cur_ingot) then
        return "找我办事怎么可以没有元宝呢！？\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>"
    end]]

    local monster = Escorter.color_flag[cur_color][6]
    if cur_color ~= #Escorter.color_flag then

        if monster == nil then return "唉呀呀，镖车故障了！！！\n \n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>" end

    end

    if not lualib:GenEscorter(player, monster, Escorter.life) then --lualib:GenTraveler(player, monster, Escorter.life, path) then
        return "呃。。。请确保镖车在你附近！！！\n \n \n \n \n \n                                                  #OFFSET<X:0,Y:-4>##IMAGE<ID:1902700019>##OFFSET<X:0,Y:-2>#<@StartEscort *01*「返回」>"
    end

    if not lualib:DelItem(player, "循环魔咒", 1, 2, "刷新镖车", "刷新镖车") then
        return "呃，刷新镖车失败了"
    end

    lualib:SetInt(lualib:GetEscorter(player), Escorter.cur_level, lualib:Level(player))
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_dest, Escorter.escort_dest)
    lualib:SetStr(lualib:GetEscorter(player), Escorter.cur_guid, player)

    if Escorter.color_flag[cur_color][5] then
        lualib:SysMsg_SendCenterMsg(1, lualib:Name(player).."接到了"
                ..Escorter.color_flag[cur_color][4]..
                "任务，祝他一路顺风！嘿嘿，希望劫镖的玩家看不见他……看不见他……", "")
    end

    lualib:SysMsg_SendPromptMsg(player, "镖车刷新成功！")
    Escorter:SetColor(player, cur_color)
    return StartEscort(npc, player)
end
---3001接
function QuestAccept3001(npc,player)
    msg = "东临城出现了大量的妖魔，人们日夜鏖战，伤亡惨重，需要大量的军需物资，勇士，你愿意押送物资前往东临城吗？\n \n"
    msg = msg.."<@Accept3001 *01* 我愿意！>\n"
    return msg
end


function Accept3001(npc, player)
    if lualib:AcceptQuest(player, 3001) == true then
        return "你要小心，在押送镖车前往东临城的路上，不要距离镖车太远，更有可能会遇到强盗的拦截，你要打起十二万分的精神来才行。"
    else
        return "任务接取失败"
    end
end