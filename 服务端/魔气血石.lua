--item/魔气血石.lua
--说明: 1.在角色上线函数中需添加代码	lualib:DelayCall(player, 1, "魔气血石:on_login", "")
--		2.若非新引擎, 没有集成触发器类型常量, 请自行require脚本logic_def_lua.lua
--		3.由于存储变量更改, tips中代码请自行修改

local storages = {
    --[KeyName] = {存储值, HP回复, MP回复, 回复间隔(s)}
    ["魔血石1"] = {250000, 50,50, 5},
    ["魔血石2"] = {250000, 80, 80, 5},
    ["魔血石3"] = {250000, 100, 100, 5},
    ["魔血石4"] = {250000, 150, 150, 5},
    ["魔血石5"] = {250000, 200, 200, 5},
    ["魔血石6"] = {250000, 250, 250, 5},
    ["魔血石7"] = {250000, 300, 300, 5},
    ["魔血石8"] = {250000, 400, 400, 5},
    ["魔血石9"] = {250000, 500, 500, 5},
    ["魔血石10"] = {100000, 290, 290, 5},
    ["魔血石11"] = {100000, 320, 320, 5},
    ["魔血石12"] = {100000, 350, 350, 5},
    ["魔血石13"] = {100000, 380, 380, 5},
    ["魔血石14"] = {100000, 420, 420, 5},
    ["魔血石15"] = {100000, 500, 500, 5},
    ["魔血石16"] = {100000, 600, 600, 5},
}
local site = 422							--石头所放的装备位置
local script = "魔气血石"				--本脚本的脚本名
local cur_store = "cur_store"			--当前存储值变量名
local total_store = "total_store"		--存储值上限变量名

local xunzhang = {
    --HP百分比
    ["魔血石1"] = 1,
    ["魔血石2"] = 2,
    ["魔血石3"] = 3,
    ["魔血石4"] = 4,
    ["魔血石5"] = 6,
    ["魔血石6"] = 8,

}

function on_create(item)
    local key = lualib:KeyName(item)
    lualib:AddTimer(item, 1, 500, 1, "sourceset")
    if storages[key] == nil then
        return
    end
    if storages[key][1] > 0 then
        local store = storages[key][1]
        lualib:SetInt(item, cur_store, store)
        lualib:SetInt(item, total_store, store)
        lualib:NotifyVar(item, cur_store)
        lualib:NotifyVar(item, total_store)
    end
end

function sourceset(item)

end

function on_login(player)
    local item = lualib:Player_GetItemGuid(player, site)
    if item ~= "" then
        on_post_equip(player, item)
    end
end



function OnStateInit()
    if lualib:GetCurScriptName() == script then
        if not lualib:HasTrigger("0", lua_trigger_post_equip, "on_post_equip") then
            lualib:AddTrigger("0", lua_trigger_post_equip, "on_post_equip")
        end
        if not lualib:HasTrigger("0", lua_trigger_post_un_equip, "on_post_un_equip") then
            lualib:AddTrigger("0", lua_trigger_post_un_equip, "on_post_un_equip")
        end
    end
end

function on_post_equip(player, item)

    local key = lualib:KeyName(item)
    if storages[key] == nil then
        return
    end
    local timeId = lualib:GenTimerId(item)
    local x = lualib:AddTimer(item, timeId, 1000 * storages[key][4], -1, "on_timer_reply")
    lualib:SysMsg_SendBroadcastMsg(tostring(x),"魔气血石")
end

function on_post_un_equip(player, item)
    local key = lualib:KeyName(item)
    if storages[key] == nil then
        return
    end
    local x = lualib:ClearTimer(item)
    lualib:SysMsg_SendBroadcastMsg(tostring(x),"魔气血石2")
end

function on_timer_reply(item, id)
    lualib:SysMsg_SendBroadcastMsg(lualib:KeyName(item).."]333]","魔气血石")
    local player = lualib:Item_GetRole(item)

    if player == "" then
        lualib:DisableTimer(item, id)
        return
    end
    local key = lualib:KeyName(item)
    local t = storages[key]
    if t == nil then
        lualib:DisableTimer(item, id)
        return
    end

    local iSite = lualib:Item_GetSite("", item)
    if iSite ~= site then
        lualib:DisableTimer(item, id)
        return
    end

    if lualib:Player_IsDie(player) then
        return
    end

    local store = lualib:GetInt(item, cur_store)
    if store <= 0 then
        local name = lualib:Name(item)
        lualib:Item_Destroy("", item, "道具销毁:存储值为0", player)
        lualib:SysPromptMsg(player, name.."消耗完自动销毁")
        return
    else

        local cur_hp, hp, cur_mp, mp = 0, 0, 0, 0
        if t[2] > 0 then

            cur_hp = lualib:Hp(player, false)
            local lmt_hp = lualib:Hp(player, true)
            hp = GetValue(cur_hp, lmt_hp, store, key, 2,player)
        end
        if hp > 0 then
            store = store - hp

            lualib:SetHp(player, cur_hp + hp, false)
            lualib:ShowRoleHPRef("", player, hp)		--玩家头顶飘hp值

        end
        if t[3] > 0 then
            cur_mp = lualib:Mp(player, false)
            local lmt_mp = lualib:Mp(player, true)
            mp = GetValue(cur_mp, lmt_mp, store, key, 3,player)
        end
        if mp > 0 then
            store = store - mp

            lualib:SetMp(player, cur_mp + mp, false)

        end

        if hp > 0 or mp > 0 then
            if lualib:GenRandom(1, 20) == 1 then
                lualib:NotifyVar(item, cur_store)
            end
        end
    end
end

function GetValue(cur, lmt, val, key, k,player)
    local result = lmt - cur

    if result > val then
        result = val
    end
    local la = storages[key][k]
    hashorse = lualib:Attr(player, 41)
    if hashorse > 0 then
        la = la+(la*(hashorse/100))
    end
    if result > la then
        result = la
    end

    return result
end