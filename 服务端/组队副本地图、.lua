local monster = {
    ["赤壁之战"] = {
        {"45级副本", 8, 8, 200, 20},--索引名+X+Y+范围+数量
        {"45级副本头领", 88, 102, 1, 1},
    },
    ["官渡之战"] = {
        {"50级怪", 8, 8, 200, 20},--索引名+X+Y+范围+数量
        {"50级boss", 77, 56, 1, 1},
    },
    ["夷陵之战"] = {
        {"57级怪", 8, 8, 300, 20},--索引名+X+Y+范围+数量
        {"57级boss", 133, 102, 1, 1},
    },
    ["街亭之战"] = {
        {"60级怪", 8, 8, 200, 20},--索引名+X+Y+范围+数量
        {"60级boss", 89, 74, 1, 1},
    },
    ["《海魔宫》"] = {
        {"海魔宫1", 8, 8, 200, 5},--索引名+X+Y+范围+数量
        {"海魔宫2", 8, 8, 200, 5},
        {"海魔宫3", 8, 8, 200, 5},
        {"海魔宫BOSS", 163, 57, 1, 1},
    },
    ["《忘川河》"] = {
        {"忘川河1", 8, 8, 200, 5},--索引名+X+Y+范围+数量
        {"忘川河2", 8, 8, 200, 5},
        {"忘川河3", 8, 8, 200, 5},
        {"忘川河BOSS", 83, 152, 1, 1},
    },
    ["《黄泉路》"] = {
        {"黄泉路1", 8, 8, 200, 5},--索引名+X+Y+范围+数量
        {"黄泉路2", 8, 8, 200, 5},
        {"黄泉路3", 8, 8, 200, 5},
        {"黄泉路BOSS", 41, 30, 1, 1},
    },
    ["《忘情台》"] = {
        {"忘情台1", 8, 8, 200, 5},--索引名+X+Y+范围+数量
        {"忘情台2", 8, 8, 200, 5},
        {"忘情台3", 8, 8, 200, 5},
        {"忘情台BOSS", 38, 27, 1, 1},
    },
}

function on_map_create(map, mapkey)
    lualib:AddTimer(map, 1, 1000, -1, "on_check")
    lualib:AddTrigger(map, lua_trigger_leave_map, "on_leave_map")                        --玩家离开地图触发
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map");
    if monster[mapkey] ~= nil then
        for _, v in ipairs(monster[mapkey]) do
            lualib:Map_GenMonster(map, v[2], v[3], v[4], lualib:GenRandom(1, 8), v[1], v[5], false)
        end
    end
end

function on_enter_map(player)

    if lualib:HasBuff(player,"2倍经验") then
        --删除buff
        lualib:DelBuff(player, "2倍经验")          --取消身上的buff
        lualib:SysPromptMsg(player, "副本取消补偿经验效果")
    end

    if lualib:HasBuff(player,"4倍经验") then
        --删除buff
        lualib:DelBuff(player, "4倍经验")          --取消身上的buff
        lualib:SysPromptMsg(player, "副本取消补偿经验效果")
    end

    if lualib:HasBuff(player,"6倍经验") then
        --删除buff
        lualib:DelBuff(player, "6倍经验")          --取消身上的buff
        lualib:SysPromptMsg(player, "副本取消补偿经验效果")
    end

    if lualib:HasBuff(player,"8倍经验") then
        --删除buff
        lualib:DelBuff(player, "8倍经验")          --取消身上的buff
        lualib:SysPromptMsg(player, "副本取消补偿经验效果")
    end

    if lualib:HasBuff(player,"10倍经验") then
        lualib:DelBuff(player, "10倍经验")          --取消身上的buff
        lualib:SysPromptMsg(player, "副本取消补偿经验效果")
    end

end

function on_check(map)
    local list = lualib:Map_GetMapPlayers(map, true)
    for _, v in ipairs(list) do
        if not lualib:Player_HasTeam(v) then
            lualib:Player_GoHome(v)
        end
    end
end

function on_leave_map(player)
    local level = lualib:Level(player)
    local max = lualib:GetDBNum("最高等级")
    if level > max then
        max = level
        lualib:SetDBNumEx("最高等级", level, 2)
    end
    if max >= 1 then
        if max - level >= 7 then
            lualib:AddBuff(player, "10倍经验", 7200)
            lualib:SysPromptMsg(player, "相差和最高等级相差7级以上添加10倍经验")
        elseif max - level >= 6 then
            lualib:AddBuff(player, "8倍经验", 7200)
            lualib:SysPromptMsg(player, "相差和最高等级相差6级以上添加8倍经验")
        elseif max - level >= 5 then
            lualib:AddBuff(player, "6倍经验", 7200)
            lualib:SysPromptMsg(player, "相差和最高等级相差5级以上添加6倍经验")
        elseif max - level >= 4 then
            lualib:AddBuff(player, "4倍经验", 7200)
            lualib:SysPromptMsg(player, "相差和最高等级相差4级以上添加4倍经验")
        elseif max - level >= 3 then
            lualib:AddBuff(player, "2倍经验", 7200)
            lualib:SysPromptMsg(player, "相差和最高等级相差3级以上添加2倍经验")
        end
    end
    local map = lualib:MapGuid(player)
    local count = lualib:Map_GetPlayerCount(map, false)
    if count <= 1 then
        lualib:Map_DestroyDgn(map)
    end
end