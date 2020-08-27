local monster_table={
    [45]={"45级副本","45级副本","45级副本","45级副本","45级副本头领"},
    [50]={"50级怪","50级怪","50级怪","50级怪","50级boss"},
    [54]={"54级怪","54级怪","54级怪","54级怪","54级boss"},
    [57]={"57级怪","57级怪","57级怪","57级怪","57级boss"},
    [60]={"60级怪","60级怪","60级怪","60级怪","60级boss"},
    [65]={"65级怪","65级怪","65级怪","65级怪","65级boss"},
}

function on_map_create(map)
    lualib:AddTimer(map,1,2000,-1,"on_ai")
    lualib:AddTrigger(map,lua_trigger_leave_map, "on_leave_map")
    lualib:AddTrigger(map, lua_trigger_enter_map, "on_enter_map");
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


    local map = lualib:MapGuid(player)
    local i=lualib:GetInt(player,"fuben_dengji")
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][1],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][2],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][3],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][4],5,false)
    lualib:Map_GenMonster(map,24,32,20,lualib:GenRandom(1,8),monster_table[i][5],1,false)
end

function on_ai(map)
    if lualib:Map_GetMonsterCount(map,"",true,true)==0 then
        local playerList = lualib:Map_GetMapPlayers(map, true)
        lualib:SetInt(playerList[1],"fuben_jiangli",1)
        lualib:Player_MapMoveXY(playerList[1],"龙城",140,127,0)
        lualib:Map_DestroyDgn(map)
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
    lualib:Map_DestroyDgn(map)
end
