local x = 56	--比赛结束后传送坐标

local y = 50	--比赛结束后传送坐标

local times = 60	--多少秒后开始比赛

local _times = 600	--多少秒后开始双方扣血

local pct = 90	--奖励百分比1-100之间

local buff = "比武"	--擂台赛的双方给予buff索引名[设置为下线、死亡、跳图都不保存]

local _buff = "观众"	--观赛者进入地图给予的buff索引名[设置为下线、死亡、跳图都不保存]

local __buff = "比武限时"	--时间超过某个值后给玩家添加每秒扣血的buff索引名[设置为下线、死亡、跳图都不保存]

local time_t = {
    [30] = "距离比赛开始还有30秒开始。",
    [40] = "距离比赛开始还有20秒开始。",
    [50] = "距离比赛开始还有10秒开始。",
    [55] = "距离比赛开始还有5秒开始。",
    [56] = "距离比赛开始还有4秒开始。",
    [57] = "距离比赛开始还有3秒开始。",
    [58] = "距离比赛开始还有2秒开始。",
    [59] = "距离比赛开始还有1秒开始。",
}

function on_map_create(map)
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map")
    lualib:AddTrigger(map, lua_trigger_leave_map, "on_leave_map")
    lualib:AddTrigger(map, lua_trigger_player_post_die, "on_post_player_die")
    lualib:AddTrigger(map, lua_trigger_player_relive, "on_player_relive")
end

function on_player_relive(player, param)
    lualib:Player_Relive(player, "", x, y, 1, 98)
    lualib:AddBuff(player, _buff, 0)
    local hero = lualib:GetCurrentHero(player)
    if hero ~= "" then
        lualib:AddBuff(hero, _buff, 0)
        local map = lualib:MapGuid(player)
        lualib:Player_MapMoveXY(hero, lualib:KeyName(map), x, y, 1)
    end
    return false
end

function on_leave_map(player)
    if lualib:GUIDType(player) == 0 then
        on_post_player_die(player)
    end
end

function on_post_player_die(player)

    local map = lualib:MapGuid(player)

    local data = lualib:GetStr(map, "rolelist")

    if data == "" then return end

    local tb = lualib:StrSplit(data, "#")

    if tb[1] ~= player and tb[4] ~= player then return end

    local killer = tb[1]

    if player == tb[1] then
        killer = tb[4]
    end

    local tb = lualib:StrSplit(data, "#")
    local ingot = math.floor(tonumber(tb[3]) * 2 * pct / 100)
    if killer ~= "" then
        lualib:AddIngot(killer, ingot, "擂台赛", map)
        lualib:SysMsg_SendBroadcastMsg("系统提示："..lualib:Name(killer).."在比武中取得了胜利，赢得"..ingot.."元宝。", "")
        lualib:Player_MapMoveXY(killer, lualib:KeyName(map), x, y, 1)
    end
    local hero = lualib:GetCurrentHero(killer)
    if hero ~= "" then
        lualib:AddBuff(hero, _buff, 0)
        lualib:Player_MapMoveXY(hero, lualib:KeyName(map), x, y, 1)
    end
    lualib:AddBuff(killer, _buff, 0)
    lualib:SetStr(map, "rolelist", "")
    lualib:DisableTimer(map, 2)
end

function on_check(map, id, role, _role)

    local second = lualib:GetInt(map, "second_ex") + 1
    lualib:SetInt(map, "second_ex", second)

    if time_t[second] ~= nil then
        lualib:SysMsg_SendMapMsg(map, time_t[second])
    end

    if second < times then return end

    if second == times then
        if lualib:Player_IsOnline(role) then
            lualib:DelBuff(role, buff)
        end
        if lualib:Player_IsOnline(_role) then
            lualib:DelBuff(_role, buff)
        end
        local msg = "擂台比赛正式开始，谁能站在擂台上站到最后即为胜利，请耐心等待系统评定。"
        lualib:SysMsg_SendMapMsg(map, msg)
        return end

    if second >= times + _times then
        if not lualib:HasBuff(role, __buff) then
            lualib:AddBuff(role, __buff, 0)
        end
        if not lualib:HasBuff(_role, __buff) then
            lualib:AddBuff(_role, __buff, 0)
        end
    end
end

function on_enter_map(player)
    local map = lualib:MapGuid(player)
    local data = lualib:GetStr(map, "rolelist")
    if data ~= "" then
        local tb = lualib:StrSplit(data, "#")
        local second = lualib:GetInt(map, "second_ex")
        if player == tb[1] or player == tb[4] or lualib:GetHeroLord(player) == tb[1] or lualib:GetHeroLord(player) == tb[4] then
            lualib:AddBuff(player, buff, times - second)
        else
            lualib:AddBuff(player, _buff, 0)
        end
    else
        lualib:AddBuff(player, _buff, 0)
    end
    if lualib:GUIDType(player) == 0 then
        local servant_t = lualib:Player_GetServantList(player)
        if #servant_t > 0 then
            for _, v in pairs(servant_t) do
                lualib:Monster_Remove(v)
            end
        end
    end
end