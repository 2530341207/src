local ace = {
    ["天下第一男战士"]  =  {1,1804400035},
    ["天下第一女战士"]  =  {2,1804400036},
    ["天下第一男法师"]  =  {3,1804400037},
    ["天下第一女法师"]  =  {4,1804400038},
    ["天下第一男道士"]  =  {5,1804400039},
    ["天下第一女道士"]  =  {6,1804400040},
}
local lce = {
    ["天下第一男战士"]  =  "攻击",
    ["天下第一女战士"]  =  "攻击",
    ["天下第一男法师"]  =  "魔攻",
    ["天下第一女法师"]  =  "魔攻",
    ["天下第一男道士"]  =  "道术",
    ["天下第一女道士"]  =  "道术",
}
local zhis = {
    [1] = 11,
    [2] = 12,
    [3] = 21,
    [4] = 22,
    [5] = 31,
    [6] = 32,


}


function main(npc,player)
    local npc_name = lualib:KeyName(npc)
    if ace[npc_name] == nil then
        return"NPC挂错了脚本！请联系管理员"
    end
    local num =  ace[npc_name][1]
    local djph_table = {}
    local djph_str = lualib:GetDBStr("na"..zhis[num])
    if djph_str ~= "" then
        djph_table = json.decode(djph_str)
    else
        djph_table[1] = "暂无"
        djph_table[2] = "0"
        djph_table[3] = "暂无"
        djph_table[4] = "0"
    end
    if lualib:GetClientType(player) == 0 then
        local msg = "\n"
        msg = msg.."   #COLORCOLOR_GREENG#╔═════════════════════════════╗#COLORCOLOR_RED#\n"
        msg = msg.."   #COLORCOLOR_GREENG#‖#COLORCOLOR_GOLD#"..npc_name.."#COLORCOLOR_GREENG#‖天下第一不是人人都能有的只有强者才配顶封号‖#COLORCOLOR_RED#\n"
        msg = msg.."   #COLORCOLOR_GREENG#╚═════════════════════════════╝#COLORCOLOR_RED#\n"
        --msg = msg.."    #COLORCOLOR_GREENG#纷扰乱世，群雄逐鹿！谁能在烽烟四起的世界里成为主宰者！！#COLOREND#\n"
        msg = msg.."    #COLORCOLOR_YELLOW#上榜人物：#COLOREND#"..djph_table[1]..""
        msg = msg.."          #COLORCOLOR_YELLOW#所属行会：#COLOREND#"..djph_table[3].."\n\n"
        msg = msg.."    #COLORCOLOR_YELLOW#他的等级：#COLOREND#"..djph_table[2]..""
        msg = msg.."              #COLORCOLOR_YELLOW#他的"..lce[npc_name].."：#COLOREND#"..djph_table[4].."#COLORCOLOR_RED#(等级相同比较"..lce[npc_name]..")\n\n"
        msg = msg.."    #COLORCOLOR_YELLOW#获得特效：#COLOREND#天下第一称号"
        msg = msg.."    #COLORCOLOR_YELLOW#获得属性：#COLOREND#攻魔道0-3 \n\n"
        msg = msg.."    #COLORCOLOR_GREENG#<@shenqing *01*申请"..npc_name..">\n"
        local str = [[<form default_parent="NpcTalk,Container">]]
        str=str.."<script><![CDATA["..[[
				em = 1
				color = {"#fe0101","#fe01d7","#1301fe","#01e9fe","#01fe01","#fef501"}
				function info(pm)
					WndAddTimer(this,"NpcTalk,Container",35,500,"text_color")
				end
				function text_color()
				EditSetTextColor(this,"NpcTalk,Container,标题",mkcolor(color[em]))
				if em >= 6 then
				em = 1
				else
				em = em+1
				end
				end
					]]..
                "]]></script>"
        str = str .."<image id=特效 x=280 y=0 image="..ace[npc_name][2].." />"
        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"
        --lualib:NPCTalkDetailEx(npc, player, msg, 580, 250)
        return msg
    else
        local msg = "    #COLORCOLOR_GREENG#天下第一不是人人都能有的只有强者才配顶封号#COLOREND#\n\n"
        msg = msg.."    #COLORCOLOR_YELLOW#上榜人物：#COLOREND#"..djph_table[1]..""
        msg = msg.."          #COLORCOLOR_YELLOW#所属国家：#COLOREND#"..djph_table[3].."\n\n"
        msg = msg.."    #COLORCOLOR_YELLOW#他的等级：#COLOREND#"..djph_table[2]..""
        msg = msg.."              #COLORCOLOR_YELLOW#他的"..lce[npc_name].."：#COLOREND#"..djph_table[4].."#COLORCOLOR_RED#(等级相同比较"..lce[npc_name]..")\n\n"
        msg = msg.."    #COLORCOLOR_YELLOW#获得特效：#COLOREND#天下第一称号"
        msg = msg.."    #COLORCOLOR_YELLOW#获得属性：#COLOREND#攻魔道0-3 \n\n"
        msg = msg.."    #COLORCOLOR_GREENG#<@shenqing *01*申请"..npc_name..">\n"
        local str = [[<form default_parent="NpcTalk,Container">]]
        str=str.."<script><![CDATA["..[[
						em = 1
						color = {"#fe0101","#fe01d7","#1301fe","#01e9fe","#01fe01","#fef501"}
						function info(pm)
							WndAddTimer(this,"NpcTalk,Container",35,500,"text_color")
						end
						function text_color()
						EditSetTextColor(this,"NpcTalk,Container,标题",mkcolor(color[em]))
						if em >= 6 then
						em = 1
						else
						em = em+1
						end
						end
							]]..
                "]]></script>"
        str = str .."<image id=特效 x=280 y=0 image="..ace[npc_name][2].." />"
        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"
        --lualib:NPCTalkDetailEx(npc, player, msg, 580, 250)
        return msg
    end
end


local val = {10,12,14}
local zhi = {{"男战士","女战士"},{"男法师","女法师"},{"男道士","女道士"}}
local zy = {"攻击","魔攻","道术"}
local title = {{"天下第一男战士","天下第一女战士"},{"天下第一男法师","天下第一女法师"},{"天下第一男道士","天下第一女道士"}}




function shenqing(npc,player)
    local job = lualib:Job(player) 	   --取得角色职业
    local gen = lualib:Gender(player)  --取得角色性别
    local shux = lualib:Attr(player,val[job])	--取得角色攻击属性
    local name = lualib:Name(player)  --取得角色名
    local level = lualib:Level(player)
    local ja = lualib:GetDBStr("na"..job..gen)	 --取得排行名字
    local jb = lualib:GetDBNum("nb"..job..gen)  --取得排行等级
    local jc = lualib:GetDBNum("nc"..job..gen)  --取得排行攻击
    if level < 35 then
        return"天下第一申请：只对35级以上玩家开放"
    end
    local djph_table = {}
    local djph_str = lualib:GetDBStr("na"..job..gen)
    if djph_str ~= "" then
        djph_table = json.decode(djph_str)
    end
    if djph_table[1] == nil then    --如果排行为空则设置其为天下第一
        djph_table[1] = name
        djph_table[2] = level
        if lualib:GuildGuid(player) == "" then
            djph_table[3] = "暂无行会"
        else
            djph_table[3] = lualib:Name(lualib:GuildGuid(player))
        end
        djph_table[4] = shux
        lualib:SetDBStr("na"..job..gen,json.encode(djph_table))
    elseif djph_table[1] == name then    --如果第一名等于该玩家
        lualib:MsgBox(player,"您已是当前"..title[job][gen].."")
        return""
    else
        if  djph_table[2] > level then   --如果不是最高等级
            lualib:MsgBox(player,"您不是最高等级")
            return""
        elseif djph_table[2] < level  then --如果是最高等级
            target_Guid = lualib:Name2Guid(djph_table[1])
            if target_Guid ~= "" then
                lualib:DelBuff(target_Guid,title[job][gen])
            end
            djph_table[1] = name
            djph_table[2] = level
            if lualib:GuildGuid(player) == "" then
                djph_table[3] = "暂无行会"
            else
                djph_table[3] = lualib:Name(lualib:GuildGuid(player))
            end
            djph_table[4] = shux
            lualib:SetDBStr("na"..job..gen,json.encode(djph_table))
        elseif djph_table[2] == level 	 then 	--如果等级相同
            if shux <= djph_table[4]  then
                lualib:MsgBox(player,"您不是最高"..zy[job].."")
                return""
            elseif shux > djph_table[4] then   --如果是最高攻击
                target_Guid = lualib:Name2Guid(djph_table[1])
                if target_Guid ~= "" then
                    lualib:DelBuff(target_Guid,title[job][gen])
                end
                djph_table[1] = name
                djph_table[2] = level
                if lualib:GuildGuid(player) == "" then
                    djph_table[3] = "暂无行会"
                else
                    djph_table[3] = lualib:Name(lualib:GuildGuid(player))
                end
                djph_table[4] = shux
                lualib:SetDBStr("na"..job..gen,json.encode(djph_table))
            end
        end
    end
    lualib:AddBuff(player,title[job][gen],0)
    lualib:MsgBox(player,"恭喜您成为天下第一"..zhi[job][gen].."")
    lualib:SysMsg_SendBroadcastColor("恭喜玩家【"..name.."】以["..level.."]级,["..shux.."]"..zy[job]..",成功抢夺天下第一"..zhi[job][gen].."", "", 1, 12)
    return""
end