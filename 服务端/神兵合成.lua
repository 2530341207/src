local clothes_t = {--衣服材料必须写在第三个位置，不要改动
    [1] = {{{"神器精华", 80}, {"陨铁", 80}, {"屠龙", 1}, {"域类装备", 1}}, 500000, "古剑无名", 100},	--{{材料+数量}....}+元宝+目标物品+成功几率百分比
    [2] = {{{"神器精华", 80}, {"陨铁", 80}, {"屠龙", 1}, {"域类装备", 1}}, 500000, "龙血宝刀", 100},
    [3] = {{{"神器精华", 80}, {"陨铁", 80}, {"屠龙", 1}, {"域类装备", 1}}, 500000, "幽冥鬼斩", 100},
    [4] = {{{"神器精华", 80}, {"陨铁", 80}, {"嗜魂法杖", 1}, {"域类装备", 1}}, 500000, "七星法杖", 100},
    [5] = {{{"神器精华", 80}, {"陨铁", 80}, {"嗜魂法杖", 1}, {"域类装备", 1}}, 500000, "火灵权杖", 100},
    [6] = {{{"神器精华", 80}, {"陨铁", 80}, {"嗜魂法杖", 1}, {"域类装备", 1}}, 500000, "寒玉剑", 100},
    [7] = {{{"神器精华", 80}, {"陨铁", 80}, {"六道轮回拂", 1}, {"域类装备", 1}}, 500000, "火冥宝剑", 100},
    [8] = {{{"神器精华", 80}, {"陨铁", 80}, {"六道轮回拂", 1}, {"域类装备", 1}}, 500000, "毒龙剑", 100},
    [9] = {{{"神器精华", 80}, {"陨铁", 80}, {"六道轮回拂", 1}, {"域类装备", 1}}, 500000, "孔雀翎", 100},
}

local clothes1_t = {--衣服材料必须写在第三个位置，不要改动
    [1] = {{{"神器精华", 80}, {"陨铁", 80},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1}}, 500000, "古剑无名", 100},	--{{材料+数量}....}+元宝+目标物品+成功几率百分比
    [2] = {{{"神器精华", 80}, {"陨铁", 80},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1}}, 500000, "龙血宝刀", 100},
    [3] = {{{"神器精华", 80}, {"陨铁", 80},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1},{"圣火令",1}}, 500000, "幽冥鬼斩", 100},
}

local tab = {
    ["域类装备"] = {"铜域项链", "铜域手镯", "铜域戒指", "铜域头盔", "水域戒指", "水域项链", "水域手镯", "水域头盔", "土域戒指", "土域项链", "土域头盔", "土域手镯"},--域类装备都要加进来
}


local huishou_t = {
    {"裁决之杖", "陨铁", 2, 6, 500000},--目标道具 + 回收后给予材料 + 给予数量小 + 给予数量大(大小之间随机) + 消耗金币
    {"龙纹剑", "陨铁", 2, 6, 500000},
    {"骨玉权杖", "陨铁", 2, 6, 500000},
    {"怒斩", "神器精华", 2, 6, 500000},
    {"龙牙", "神器精华", 2, 6, 500000},
    {"逍遥扇", "神器精华", 2, 6, 500000},
}


function main(npc, player)
    local msg = [[
\n  您好，我是干将，最近莫邪不知道去哪了，应该去寻找宝剑去了，客观是否找我帮忙？

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishou *01*分解武器>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hechengs *01*合成武器>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes *01*合成神兵>
  #OFFSET<X:2,Y:5>##IMAGE1902700034# #OFFSET<Y:-1>#<@leave *01*离开>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end


function huishou(npc, player)
    local msg = [[
\n  您好，请选择您要分解的武器，可随机获得2-6个神器精华与陨铁，每次消耗  500000金币。

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#1 *01*分解]]..huishou_t[1][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#2 *01*分解]]..huishou_t[2][1]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#3 *01*分解]]..huishou_t[3][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#4 *01*分解]]..huishou_t[4][1]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#5 *01*分解]]..huishou_t[5][1]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@huishouex#6 *01*分解]]..huishou_t[6][1]..[[>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end


function huishouex(npc, player, idx)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local count = lualib:ItemCount(player, huishou_t[idx][1])
    if count < 1 then
        return "\n  您背包中没有我需要的武器。"
    end
    if lualib:GetGold(player) < count * huishou_t[idx][5] then
        return "\n  您的金币不足".. count * huishou_t[idx][5] .."，无法分解。"
    end
    local total = 0
    for i = 1, count do
        total = total + lualib:GenRandom(huishou_t[idx][3], huishou_t[idx][4])
    end
    if not lualib:DelItem(player, huishou_t[idx][1], count, 2, "衣服分解", npc) then
        return "扣除材料失败。"
    end
    if lualib:SubGold(player, count * huishou_t[idx][5], "衣服分解", npc) == false then
        return "\n  扣除金币失败。"
    end
    lualib:AddItem(player, huishou_t[idx][2], total, false, "衣服分解", npc)
    lualib:MsgBox(player, "恭喜您获得["..(total).."]张["..huishou_t[idx][2].."]。")
    return main(npc, player)
end

function hechengs(npc, player)
    local msg = [[
\n  您好，请选择您要合成的武器，消耗的材料怪物或者稀有怪物产出。

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#1 *01*]]..clothes1_t[1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#2 *01*]]..clothes1_t[2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hecheng#3 *01*]]..clothes1_t[3][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end

function hcclothes(npc, player)
    local msg = [[
\n  您好，请选择您要合成的武器，消耗的神器精华与陨铁可通过分解获得。

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#1 *01*]]..clothes_t[1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#2 *01*]]..clothes_t[2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#3 *01*]]..clothes_t[3][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#4 *01*]]..clothes_t[4][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#5 *01*]]..clothes_t[5][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#6 *01*]]..clothes_t[6][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#7 *01*]]..clothes_t[7][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#8 *01*]]..clothes_t[8][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#9 *01*]]..clothes_t[9][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end

function hecheng(npc, player, idx)
    local idx = tonumber(idx)
    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  合成“"..lualib:KeyName2Name(clothes1_t[idx][3],4).."”需要以下条件：\n\n"
    msg = msg.. "  需求装备："..lualib:KeyName2Name(clothes1_t[idx][1][3][1],4).."×"..clothes1_t[idx][1][3][2].."\n"
    msg = msg.. "  需求材料：神器图纸1-4号\n"
    msg = msg.. "  需求其他：圣战首饰×1（不包括武器）\n"
    msg = msg.. "  成功几率：100%\n"
    msg = msg.. "  温馨提示：合成失败所有材料消失，使用元宝合成保证主武器不消失\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hechengex#"..idx.."#1 *01*神兵合成>       "
    -- msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#2 *01*10000元宝合成>\n"
    return msg
end


function hcontent(npc, player, idx)
    local idx = tonumber(idx)
    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  合成“"..lualib:KeyName2Name(clothes_t[idx][3],4).."”需要以下条件：\n\n"
    msg = msg.. "  需求装备："..lualib:KeyName2Name(clothes_t[idx][1][3][1],4).."×"..clothes_t[idx][1][3][2].."\n"
    msg = msg.. "  需求材料：神器精华×20＋陨铁×80\n"
    msg = msg.. "  需求其他：域类首饰×1（不包括武器）\n"
    msg = msg.. "  成功几率：100%\n"
    msg = msg.. "  温馨提示：合成失败所有材料消失，使用元宝合成保证主武器不消失\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#1 *01*神兵合成>       "
    -- msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..idx.."#2 *01*10000元宝合成>\n"
    return msg
end

function hechengex(npc, player, idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local ingot = clothes1_t[idx][2]
    local target = clothes1_t[idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "背包空间不足一格！"
    end
    if types == "1" then
        if lualib:GetIngot(player) < ingot then
            return "\n  抱歉，您的元宝不足"..ingot.."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
        end
    end

    for k, v in ipairs(clothes1_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes1_t[idx][4]

    for k, v in ipairs(clothes1_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) > 0 then
                    ttt = m
                    break
                end
            end
            if ttt ~= "" then
                if not lualib:DelItem(player, ttt, v[2], 2, "删除:材料制作", npc) then
                    return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
                end
            end
        else
            if fail and types == "1" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "删除:材料制作", npc) then
                    return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
                end
            end
        end
    end

    if types == "1" then
        if not lualib:SubIngot(player, ingot, "扣元宝：衣服合成", npc) then
            return "失败：系统错误！"
        end
    end

    if fail then
        return "\n 很遗憾，本次合成上古神兵失败了。"
    end

    lualib:AddItem(player, target, 1, false, "给物品：材料制作", npc)

    local msg = "恭喜玩家【"..lualib:Name(player).."】成功合成“"..lualib:KeyName2Name(target,4).."”，真实人品爆发了。"
    lualib:SysMsg_SendBroadcastMsg(msg, "系统")

    return "\n  恭喜您成功合成"..lualib:KeyName2Name(target, 4).."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hecheng#"..idx.." *01*返回上页>"
end

function hcclothesex(npc, player, idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local ingot = clothes_t[idx][2]
    local target = clothes_t[idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "背包空间不足一格！"
    end
    if types == "1" then
        if lualib:GetIngot(player) < ingot then
            return "\n  抱歉，您的元宝不足"..ingot.."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
        end
    end

    for k, v in ipairs(clothes_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes_t[idx][4]

    for k, v in ipairs(clothes_t[idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) > 0 then
                    ttt = m
                    break
                end
            end
            if ttt ~= "" then
                if not lualib:DelItem(player, ttt, v[2], 2, "删除:材料制作", npc) then
                    return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
                end
            end
        else
            if fail and types == "1" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "删除:材料制作", npc) then
                    return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
                end
            end
        end
    end

    if types == "1" then
        if not lualib:SubIngot(player, ingot, "扣元宝：衣服合成", npc) then
            return "失败：系统错误！"
        end
    end

    if fail then
        return "\n 很遗憾，本次合成上古神兵失败了。"
    end

    lualib:AddItem(player, target, 1, false, "给物品：材料制作", npc)

    local msg = "恭喜玩家【"..lualib:Name(player).."】成功合成“"..lualib:KeyName2Name(target,4).."”，真实人品爆发了。"
    lualib:SysMsg_SendBroadcastMsg(msg, "系统")

    return "\n  恭喜您成功合成"..lualib:KeyName2Name(target, 4).."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
end


function leave(npc, player)
    return ""
end