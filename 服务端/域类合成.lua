local clothes_t = {--衣服材料必须写在第三个位置，不要改动
    {
        {
            {
                { "战纹舍利", 10 },
                { "圣战戒指", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "铜域戒指",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "战纹舍利", 10 },
                { "圣战手镯", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "铜域手镯",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "战纹舍利", 10 },
                { "圣战项链", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "铜域项链",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "战纹舍利", 10 },
                { "圣战头盔", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "铜域头盔",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
    },
    {
        {
            {
                { "道纹舍利", 10 },
                { "天尊戒指", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "土域戒指",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "道纹舍利", 10 },
                { "天尊手镯", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "土域手镯",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "道纹舍利", 10 },
                { "天尊项链", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "土域项链",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "道纹舍利", 10 },
                { "天尊头盔", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "土域头盔",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
    },
    {
        {
            {
                { "法纹舍利", 10 },
                { "法神戒指", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "水域戒指",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "法纹舍利", 10 },
                { "法神手镯", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "水域手镯",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "法纹舍利", 10 },
                { "法神项链", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "水域项链",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
        {
            {
                { "法纹舍利", 10 },
                { "法神头盔", 1 },
                { "赤月装备", 1 }
            },
            10000,
            "水域头盔",
            10
        }, --{{材料+数量}....}+元宝+目标物品+成功几率百分比
    }
}



local tab = {
    ["赤月装备"] = {"圣火令"},--赤月装备都要加进来

}

function main(npc, player)
    local msg = [[
\n  年轻人，我老了，岁月不饶人，千年过去了，一些锻造高端装备的秘法都快遗忘了，还好兄台你来了？

  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#1 *01*合成铜域>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#2 *01*合成土域>
  #OFFSET<Y:5>##IMAGE1902700037# #OFFSET<Y:-1>#<@hcclothes#3 *01*合成水域>
  #OFFSET<X:2,Y:5>##IMAGE1902700034# #OFFSET<Y:-1>#<@leave *01*离开>
]]
    lualib:SetPanelSize(npc, 420, 188)
    return msg
end

function hcclothes(npc, player,num)
    local num = tonumber(num)
    local msg = [[
\n  您好，请选择您要合成的装备，消耗的舍利子可通过分解赤月装备得。

  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#1 *01*]]..clothes_t[num][1][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#2 *01*]]..clothes_t[num][2][3]..[[>
  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#3 *01*]]..clothes_t[num][3][3]..[[>     #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcontent#]]..num..[[#4 *01*]]..clothes_t[num][4][3]..[[>
]]
    lualib:SetPanelSize(npc, 420, 200)
    return msg
end


function hcontent(npc, player,num, idx)
    local num = tonumber(num)
    local idx = tonumber(idx)

    lualib:SetPanelSize(npc, 420, 220)
    local msg = "\n  合成“"..lualib:KeyName2Name(clothes_t[num][idx][3],4).."”需要以下条件：\n\n"
    msg = msg.. "  需求装备："..lualib:KeyName2Name(clothes_t[num][idx][1][2][1],4).."×"..clothes_t[num][idx][1][3][2].."\n"
    msg = msg.. "  需求材料：对应职业舍利子×10\n"
    msg = msg.. "  需求其他：圣火令×1（反贼头目掉落）\n"
    msg = msg.. "  成功几率：10%（10次必成），高级合成几率100%,手续费15万元宝\n"
    msg = msg.. "  温馨提示：失败后只保留主件装备，其他材料扣除\n\n"
    msg = msg.. "  #OFFSET<Y:5>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..num.."#"..idx.."#1 *01*高级合成>"
    msg = msg.. "  #OFFSET<Y:1>##IMAGE1902700036# #OFFSET<Y:-1>#<@hcclothesex#"..num.."#"..idx.."#2 *01*10000元宝合成>\n"
    return msg
end


function hcclothesex(npc, player, num ,idx, types)
    lualib:SetPanelSize(npc, 420, 188)
    local idx = tonumber(idx)
    local num = tonumber(num)
    local ingot = clothes_t[num][idx][2]
    local target = clothes_t[num][idx][3]
    if lualib:GetBagFree(player) <= 0 then
        return "背包空间不足一格！"
    end
    if types == "2" then
        if lualib:GetIngot(player) < ingot then
            return "\n  抱歉，您的元宝不足"..ingot.."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
        end
    end
    if types == "1" then
        if lualib:GetIngot(player) < 250000 then
            return "\n  抱歉，您的元宝不足150000！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..idx.." *01*返回上页>"
        end
    end

    for k, v in ipairs(clothes_t[num][idx][1]) do
        if tab[v[1]] ~= nil then
            local ttt = ""
            for _, m in ipairs(tab[v[1]]) do
                if lualib:ItemCount(player, m) >= v[2] then
                    ttt = m
                    break
                end
            end
            if ttt == "" then
                return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*返回上页>"
            end
        else
            if lualib:ItemCount(player, v[1]) < v[2] then
                return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*返回上页>"
            end
        end
    end

    local fail = lualib:GenRandom(1, 100) > clothes_t[num][idx][4]
    --lualib:SysMsg_SendBroadcastMsg(tostring(fail), "dijia")

    if types == "1" then
        fail = false
    end
    if lualib:GetInt(player,"caifeng") == 15 then
        fail = false
    end

    for k, v in ipairs(clothes_t[num][idx][1]) do
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
                    return "\n  抱歉，背包中"..v[1].."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*返回上页>"
                end
            end
        else
            if fail and types == "2" and k == 3 then

            else
                if not lualib:DelItem(player, v[1], v[2], 2, "删除:材料制作", npc) then
                    return "\n  抱歉，背包中"..lualib:KeyName2Name(v[1],4).."数量不足"..v[2].."个！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*返回上页>"
                end
            end
        end
    end

    if types == "2" then
        if not lualib:SubIngot(player, ingot, "扣元宝：衣服合成", npc) then
            return "失败：系统错误！"
        end
    end
    if types == "1" then
        if not lualib:SubIngot(player, 150000, "扣元宝：衣服合成", npc) then
            return "失败：系统错误！"
        end
    end
    if fail then
        lualib:SetInt(player,"caifeng",lualib:GetInt(player,"caifeng")+1)
        return "\n 很遗憾，本次合成新衣服失败了。"
    end

    lualib:AddItem(player, target, 1, false, "给物品：材料制作", npc)

    local msg = "恭喜玩家【"..lualib:Name(player).."】成功合成“"..lualib:KeyName2Name(target,4).."”，真实人品爆发了。"
    lualib:SetInt(player,"caifeng",0)
    lualib:SysMsg_SendBroadcastMsg(msg, "系统")

    return "\n  恭喜您成功合成"..lualib:KeyName2Name(target, 4).."！\n\n\n\n#IMAGE1902700038##OFFSET<Y:-1># <@hcclothes#"..num.."#"..idx.." *01*返回上页>"
end


function leave(npc, player)
    return ""
end