local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/serializer")

local  monsterBoss = {
    "上古斑斓虎",
    "素云雪妖",
    "捕灵鬼鲛",
    "黑炎凤凰",
    "异界兽王"
}

function Init_system_Start()
    lualib:AddTimerEx("0",20200422,1000,-1,"世界BOSS:refreshMonster","")
    lualib:DelayCall("0",1,"世界BOSS:restartRefresh","")

    lualib:AddTrigger("0", lua_trigger_monster_post_die, "on_post_monster_die") --怪物死亡触发
    lualib:AddTrigger("0", lua_trigger_player_pre_die, "pre_player_die") --玩家死亡前触发
    lualib:AddTrigger("0",  lua_trigger_login, "on_login") --玩家上线时回调
    lualib:AddTrigger("0", 394, "on_billinex") --玩家充值强制触发
end

function main()
    if lualib:GetDBNum("tyfSystem") == 0 then
        Init_system_Start()       --加载时生效
        lualib:SetDBNum("tyfSystem", 1)
    end

end

function on_login(player)

    local id = lualib:UserID(player)
    if lualib:GetDBNum("violent"..id) == 1 then
        if lualib:HasBuff(player,"狂暴之力") ~= true then
            lualib:AddBuff(player,"狂暴之力",0)
        end
    end
end

function on_post_monster_die(monster, killer)
    local monster = lualib:KeyName(monster)

    for i=1,#monsterBoss do
        if monster == monsterBoss[i] then
            lualib:SetDBNum("世界BOSS"..i,0)
        end
    end
end

local kbzl = 34444  --狂暴之力击杀元宝

function pre_player_die(player, killer)
    local id = lualib:UserID(player)
    if lualib:GetDBNum("violent"..id) == 1 then
        lualib:DelBuff(player,"狂暴之力")
        lualib:SetDBNum("violent"..id,0)
        lualib:Player_AddIngot(killer,kbzl,false,"狂暴之力给予击杀者元宝","狂暴之力")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(killer).."】击杀了玩家【"..lualib:KeyName(player).."】，获得玩家【"..lualib:KeyName(killer).."】狂暴之力奖励34444元宝！！！","狂暴之力")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(killer).."】击杀了玩家【"..lualib:KeyName(player).."】，获得玩家【"..lualib:KeyName(killer).."】狂暴之力奖励34444元宝！！！","狂暴之力")
        lualib:SysMsg_SendBroadcastMsg("玩家【"..lualib:KeyName(killer).."】击杀了玩家【"..lualib:KeyName(player).."】，获得玩家【"..lualib:KeyName(killer).."】狂暴之力奖励34444元宝！！！","狂暴之力")
    end
end

function on_billinex(id, yb)
    lualib:SetDBNumEx("ljcz"..id,lualib:GetDBNum("ljcz"..id)+yb,2)
    lualib:SetDBNumEx("mrcz"..id..lualib:GetAllDays(0),lualib:GetDBNum("mrcz"..id..lualib:GetAllDays(0)),2)
end

main()