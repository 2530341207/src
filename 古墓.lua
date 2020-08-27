local require_item = "神秘宝盒"
local require_monster = {"盗墓贼", 15, 19}
local box_owner = "box_owner"
local map_award_timer = 1111
local map_end_timer = 11111
local award_gold_num = 1000
local yuanbao_num = 5
local apply_timer_num = 10

local avatar_table = {20000, 20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010, 20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020, 20021, 20022, 20023, 20024, 20025, 20026, 20027, 20028, 20029, 20030, 20031, 20032, 20033, 20034, 20035, 20036, 20037, 20038, 20039, 20040, 20042, 20043, 20044, 20045, 20046, 20047, 20048, 20049, 20050, 20051, 20052, 20053, 20054, 20055, 20056, 20057, 20058, 20059, 20060, 20061, 20062, 20063, 20064, 20065, 20066, 20067, 20068, 20069, 20070, 20071, 20072, 20073, 20074, 20075, 20076, 20077, 20078, 20079, 20080, 20081, 20082, 20083, 20084, 20085, 20086, 20087, 20089, 20092, 20093, 20094, 20095, 20096, 20097, 20098, 20099, 20100, 20101, 20102, 20103, 20104, 20105, 20106, 20107, 20108, 20109, 20110, 20118, 20119, 20120, 20121, 20122, 20123, 20124, 20125, 20126, 30000, 30001, 30002, 30003, 30004, 30005, 30006, 30007, 30008, 30009, 30010, 30011, 30012, 30013, 30014, 30015, 30016, 30017, 30018, 30019, 30020, 30021, 30022, 30023, 30024, 30025, 30026, 30027, 30028, 30029, 30030, 30031, 30032, 30033, 30034, 30035, 30036, 30037, 30038, 30039, 30040, 30041, 30042, 30043, 30044, 30045}


function on_map_create(map)
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_trigger_enter_map")

    lualib:Debug("古墓地图建创回调！")

    local monster = lualib:Map_GenSingleMonster(map, require_monster[2],
            require_monster[3], 6, 3, require_monster[1], false)
    if monster == ""  then
        lualib:Error(require_monster[1].."刷新失败！")
        return
    end

    lualib:Debug(require_monster[1].."刷新成功！")
    local map_ = CMap:new()
    map_:init(map)
    map_:set_monster(monster)

    lualib:AddTrigger(map, lua_trigger_item_appear, "on_trigger_item_appear")
    lualib:AddTrigger(map, lua_trigger_item_pickup, "on_trigger_item_pickup")
    lualib:AddTrigger(map, lua_trigger_item_drop, "on_trigger_item_drop")
    lualib:AddTrigger(map, lua_trigger_leave_map, "on_trigger_leave_map")
    lualib:AddTrigger(map, lua_trigger_pre_die, "on_trigger_pre_die")
    lualib:AddTrigger(map, lua_trigger_pre_item_apply, "on_trigger_pre_item_apply")
    lualib:AddTimer(map, 100, 1000, -1, "add_exp")
    lualib:AddTimer(map, 1222, 1000, -1, "add_bangyuan")
    lualib:AddTimer(map, map_award_timer, 5000, -1, "on_timer_award")
    lualib:AddTimer(map, map_end_timer, 1500000, 1, "on_timer_end")
end

function add_bangyuan(map)
    local playerList = lualib:Map_GetMapPlayers(map, true)
    for i=1,#playerList do
        lualib:AddBindIngot(playerList[i],1,"古墓泡点","古墓泡点")
    end
end

function add_exp(map)
    local exp = 50000
    local exp_max = 2500
    local exp_min = 1000
    local player_sl = lualib:Map_GetPlayerCount(map,true)
    local playerList = lualib:Map_GetMapPlayers(map, true)
    for i=1,#playerList do
        map_player = playerList[i]
        if exp/player_sl >= exp_max then
            lualib:AddExp(map_player,exp_max,"古墓泡点","古墓泡点")
        elseif exp/player_sl < exp_max and exp/player_sl > exp_min then
            lualib:AddExp(map_player,exp/player_sl,"古墓泡点","古墓泡点")
        elseif exp/player_sl <= exp_min then
            lualib:AddExp(map_player,exp_min,"古墓泡点","古墓泡点")
        end

    end
end

function on_trigger_enter_map(player)

    local i = lualib:GenRandom(1, #avatar_table)
    local avatar = avatar_table[i]
    --lualib:AddAvataBuff(player, avatar, "武斗场变身", "海魔砸晕", 0)

    local player_name = lualib:Name(player)
    local msg = "#OFFSET<X:80,Y:-0>##COLORCOLOR_BROWN#[温馨小贴士]#COLOREND#\n"
    msg = msg .. "#OFFSET<X:-20,Y:-20>##IMAGE<ID:1989905002>#\n"
    msg = msg .."#OFFSET<X:70,Y:-25>##COLORCOLOR_RED#→→爱瑶\n \n#COLOREND#"
    msg = msg .."#OFFSET<X:5,Y:-10>##COLORCOLOR_YELLOW#嗨~亲爱的[#COLORCOLOR_GREENG#"..player_name.."#COLOREND##COLORCOLOR_YELLOW#],请你听我说：\n#COLOREND#"
    msg = msg .."#OFFSET<X:5,Y:0>##COLORCOLOR_BROWN#━━━━━━━━━━━━━━━━#COLOREND#\n"
    msg = msg .."#OFFSET<X:5,Y:0>##COLORCOLOR_BROWN#1.古墓内的盗贼身上藏有一个神秘宝盒，拿到它就能每几秒获得大量元宝\n \n#COLOREND#"
    msg = msg .."#OFFSET<X:5,Y:0>##COLORCOLOR_BROWN#2.古墓内的怪物都是玩家变身的，你要格外小心!\n \n#COLOREND#"
    msg = msg .."#OFFSET<X:5,Y:0>##COLORCOLOR_BROWN#3.开启神秘宝盒可以随机获得一件宝物，你才是最强的，我看好你哟，加油^_^#COLOREND#"
    lualib:NPCTalkDetail(player, msg, 265, 310)
end

function on_trigger_item_appear(map, item, item_id, item_name, x, y)
    if item_name ~= require_item then
        return
    end

    local item_ = CItem:new()
    item_:init(item_name)
    item_:drop_notify(map, x, y)
end

function on_trigger_item_pickup(player, item, item_id, item_name)
    if not lualib:Player_IsPlayer(player) then
        return
    end
    if item_name ~= require_item then
        return
    end

    local map = lualib:Player_GetGuidProp(player, lua_role_current_map_id)
    if map == "" then
        return
    end

    local item_ = CItem:new()
    item_:init(item_name)
    item_:pickup_event(player, map)
    item_:pickup_notify(player)
end

function on_trigger_item_drop(player, item, item_id, item_name)
    if item_name ~= require_item then
        return
    end

    local map = lualib:Player_GetGuidProp(player, lua_role_current_map_id)
    if map == "" then
        return
    end

    local item_ = CItem:new()
    item_:init(item_name)
    item_:drop_event(player, map)
end

function on_trigger_leave_map(player)

    local map = lualib:Player_GetGuidProp(player, lua_role_current_map_id)
    if map == "" then
        return
    end

    local map_ = CMap:new()
    map_:init(map)


    if player ~= map_:get_var() then
        return
    end

    local item_ = CItem:new()
    item_:init(require_item)
    item_:drop_item(player)
    item_:drop_event(player, map)
end


function on_trigger_pre_die(actor, killer)
    if not lualib:Player_IsPlayer(actor) then
        return true
    end

    local map = lualib:Player_GetGuidProp(actor, lua_role_current_map_id)
    if map == "" then
        return true
    end

    local map_ = CMap:new()
    map_:init(map)
    if actor ~= map_:get_var() then
        return true
    end

    local item_ = CItem:new()
    item_:init(require_item)
    item_:drop_item(actor)
    item_:drop_event(actor, map)

    return true
end

function on_trigger_pre_item_apply(player, item, item_id, item_name)
    if item_name ~= require_item then
        return true
    end

    local map = lualib:Player_GetGuidProp(player, lua_role_current_map_id)
    local map_ = CMap:new()
    map_:init(map)

    local count = map_:get_count()
    if count == 0 then
        local item_ = CItem:new()
        item_:init(require_item)
        item_:drop_event(player, map)
        lualib:DisableTimer(map, map_end_timer)
        return true
    else
        lualib:SysMsg_SendWarnMsg(player, require_item.."构造太复杂了，"..count.."分钟后才可以打开！")
        return false
    end
end

function on_timer_award(map, timer_id)
    local map_ = CMap:new()
    map_:init(map)

    local player = map_:get_var()
    if player == "" then
        return
    end

    --lualib:Player_AddGold(player, award_gold_num, false, "加金币：神秘宝盒BUFF", "古墓副本：神秘宝盒BUFF")
    lualib:Player_AddIngot(player, yuanbao_num, false, "加元宝：神秘宝盒BUFF", "古墓副本：神秘宝盒BUFF")
    lualib:SysMsg_SendBroadcastColor(lualib:Player_GetStrProp(player, lua_role_user_name).."→→被宝盒的神秘力量笼罩，获得了#OFFSET<X:13,Y:0>##IMAGE<ID:1902700032>##IMAGE<ID:1902700032>##IMAGE<ID:1902700032>##IMAGE<ID:1902700032>##IMAGE<ID:1902700032>#大量元宝！", "古墓", 12, 1)
end

function on_timer_item_apply(map, timer_id)
    local map_ = CMap:new()
    map_:init(map)

    local count = map_:get_count() - 1
    if count > 0 then
        lualib:SysMsg_SendMapMsg(map, require_item.."还有"..count.."分钟就可以开启了！")
    else
        lualib:SysMsg_SendMapMsg(map, require_item.."已经可以开启了！")
    end
    map_:set_count(count)
end

function on_timer_end(map, timer_id)
    local map_ = CMap:new()
    map_:init(map)

    local monster = map_:get_monster()
    if lualib:Monster_IsExist(monster) and (not lualib:Monster_IsDie(monster)) then
        lualib:Monster_Kill(monster)
    end

    local player = map_:get_var()
    if player ~= "" then
        local item_ = CItem:new()
        item_:init(require_item)
        item_:drop_item(player)
        item_:drop_event(player, map)
    end

    local map_width = lualib:Map_GetWidth(map)
    local map_height = lualib:Map_GetHeight(map)
    if map_width < map_height then map_width = map_height end
    lualib:Map_ClearItem(map, 0, 0, map_width, require_item)

    if "" == lualib:Map_GenItem(map, require_monster[2], require_monster[3], CDropGroup:drop(), 1, false, 120) then
        lualib:Error("古墓地图上刷物品失败！")
    end
    lualib:SysMsg_SendMapMsg(map, "【古墓】即将关闭"..require_item.."上的神秘力量消退，从中掉落了一个上古神器，遗失在在古墓中！")
end

function on_map_destroy(map)
    lualib:ClearTrigger(map)
    lualib:DisableTimer(map, map_award_timer)
end
------------------------------------------------------------------------------------------------------------------------------------
CItem =
{
    name = "",
    is_init = false,
    owner_effect = {"古墓夺宝", "精英光环"},
    owner_times = 600
}

function CItem:init(item_name)
    self.name = item_name
    self.is_init = true
end

function CItem:drop_notify(map, x, y)
    if self.is_init == false then
        return
    end
    lualib:SysMsg_SendMapMsg(map,
            self.name.."掉落在坐标【"..x.."，"..y.."】！")
end

function CItem:pickup_notify(player)
    local name = lualib:Player_GetStrProp(player, lua_role_user_name)
    local map = lualib:Player_GetGuidProp(player, lua_role_current_map_id)
    local x = lualib:Player_GetPosX(player)
    local y = lualib:Player_GetPosY(player)
    lualib:SysMsg_SendMapMsg(map,
            self.name.."被【"..name.."】- 坐标【"..x.."，"..y.."】捡起来了！宝盒具有千年诅咒，死亡后必定掉落！请小心保护！")
end

function CItem:pickup_event(player, map)
    local map_ = CMap:new()
    map_:init(map)
    map_:set_var(player)
    map_:set_item_timer_apply()

    for _, v in pairs(self.owner_effect) do
        if not lualib:Player_AddBuff(player, v, self.owner_times) then
            --lualib:Error("玩加添加BUFF"..v.."出错！")
            return
        end
    end
end

function CItem:drop_event(player, map)
    local map_ = CMap:new()
    map_:init(map)
    map_:clear_var()
    map_:clear_item_timer_apply()

    for _, v in pairs(self.owner_effect) do
        if not lualib:Player_DelBuff(player, v) then
            lualib:Error("玩家删除BUFF"..v.."出错！")
            return
        end
    end
end

function CItem:drop_item(player)
    if not lualib:Player_DropItem(player, self.name) then
        lualib:Error("玩家掉落"..require_item.."出错！")
    end
end

function CItem:new(item)
    item = item or {}
    setmetatable(item, self)
    self.__index = self
    return item
end
--------------------------------------------------------------------------------------------------------------------------------------
CMap =
{
    guid = "",
    custom_var = "gmfb_custom_var_box_owner",
    custom_count = "gmfb_custom_var_box_count",
    custom_monster = "gmfb_custom_var_monster",
    is_init = false
}

function CMap:init(map)
    self.guid = map
    self.is_init = true
end

function CMap:set_count(value)
    lualib:Map_SetCustomVarInt(self.guid, self.custom_count, value)
end

function CMap:clear_count()
    lualib:Map_SetCustomVarInt(self.guid, self.custom_count, 0)
end

function CMap:get_count()
    return lualib:Map_GetCustomVarInt(self.guid, self.custom_count)
end

function CMap:set_var(value)
    lualib:Map_SetCustomVarStr(self.guid, self.custom_var, value)
end

function CMap:clear_var()
    lualib:Map_SetCustomVarStr(self.guid, self.custom_var, "")
end

function CMap:get_var()
    return lualib:Map_GetCustomVarStr(self.guid, self.custom_var)
end

function CMap:set_monster(monster)
    lualib:Map_SetCustomVarStr(self.guid, self.custom_monster, monster)
end

function CMap:get_monster()
    return lualib:Map_GetCustomVarStr(self.guid, self.custom_monster)
end

function CMap:set_item_timer_apply()
    if not lualib:AddTimer(self.guid, 111111, 60000, apply_timer_num, "on_timer_item_apply") then
        lualib:Error(require_item.."添加延时打开定时器出错")
        return
    end
    self:set_count(apply_timer_num)
end

function CMap:clear_item_timer_apply()
    if not lualib:DisableTimer(self.guid, 111111) then
        --lualib:Error(require_item.."删除延时打开定时器出错")
        return
    end
    self:clear_count()
end

function CMap:new(map)
    map = map or {}
    setmetatable(map, self)
    self.__index = self
    return map
end
------------------------------------------------------------------------------------------------------------------------------------
CDropGroup =
{
    items = {
        {"赤峰战甲(男)", 1000},
        {"赤峰战甲(女)", 1000},
        {"阎罗长袍(男)", 1000},
        {"阎罗长袍(女)", 1000},
        {"光明道袍(男)", 1000},
        {"光明道袍(女)", 1000},
        {"审判", 1000},
        {"忘机", 1000},
        {"囚龙", 1000},
        {"十杀", 334},
        {"龙渊", 443},
        {"天瀑", 223}
    }
}

function CDropGroup:drop()
    local max,qujian = 0,0
    for k = 1, #self.items do
        max = max + self.items[k][2]
    end
    local rnd = lualib:GenRandom(1, max)
    for i = 1, #self.items do
        qujian = qujian + self.items[i][2]
        if rnd <= qujian then
            return self.items[i][1]
        end
    end
end
