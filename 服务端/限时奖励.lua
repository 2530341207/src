local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/timecount_def")

function xianshi_xianshi(player)

    return ""
end


local rmb_hs = {
    {"圣战戒指",1},
    {"圣战项链",1},
    {"圣战头盔",1},
    {"圣战手镯",1},
    {"法神戒指",1},
    {"法神项链",1},
    {"法神头盔",1},
    {"法神手镯",1},
    {"天尊戒指",1},
    {"天尊项链",1},
    {"天尊头盔",1},
    {"天尊手镯",1},
    {"天魔神甲",1},
    {"圣战宝甲",1},
    {"怒斩",1},
    {"龙牙",1},
    {"逍遥扇",1},
    {"雷霆战戒",2},
    {"雷霆护腕",2},
    {"雷霆项链",2},
    {"雷霆头盔",2},
    {"雷霆战靴",2},
    {"雷霆腰带",2},
    {"雷霆战甲(男)",3},
    {"雷霆战甲(女)",3},
    {"烈焰魔戒",2},
    {"烈焰护腕",2},
    {"烈焰魔盔",2},
    {"烈焰项链",2},
    {"烈焰魔衣(女)",3},
    {"烈焰魔衣(男)",3},
    {"烈焰腰带",2},
    {"烈焰魔靴",2},
    {"光芒道戒",2},
    {"光芒护腕",2},
    {"光芒项链",2},
    {"光芒腰帶",2},
    {"光芒道盔",2},
    {"光芒道靴",2},
    {"光芒道袍(女)",2},
    {"光芒道袍(男)",2},
    {"开天",3},
    {"玄天",3},
    {"镇天",3},
    {"战神戒指",5},
    {"战神手镯",5},
    {"战神项链",5},
    {"战神头盔",5},
    {"战神腰带",5},
    {"战神战靴",5},
    {"战神刀",5},
    {"战神铠甲(男)",5},
    {"战神铠甲(女)",5},
    {"真魂道戒",5},
    {"真魂护腕",5},
    {"真魂项链",5},
    {"真魂腰带",5},
    {"真魂道盔",5},
    {"真魂道靴",5},
    {"真魂玄扇",5},
    {"真魂道袍(女)",5},
    {"真魂道袍(男)",5},
    {"圣魔魔戒",5},
    {"圣魔护腕",5},
    {"圣魔项链",5},
    {"圣魔腰带",5},
    {"圣魔魔盔",5},
    {"圣魔魔靴",5},
    {"圣魔权杖",5},
    {"圣魔法袍(男)",5},
    {"圣魔法袍(女)",5},

    {"星王战戒",10},
    {"星王护腕(战)",10},
    {"星王项链(战)",10},
    {"星王头盔(战)",10},
    {"星王腰带(战)",10},
    {"星王战靴",10},
    {"星王战刃",10},
    {"星王战甲(男)",10},
    {"星王战甲(女)",10},
    {"星王道戒",10},
    {"星王护腕(道)",10},
    {"星王项链(道)",10},
    {"星王腰带(道)",10},
    {"星王头盔(道)",10},
    {"星王道靴",10},
    {"星王道剑",10},
    {"星王道袍(男)",10},
    {"星王道袍(女)",10},
    {"星王魔戒",10},
    {"星王护腕(法)",10},
    {"星王项链(法)",10},
    {"星王腰带(法)",10},
    {"星王头盔(法)",10},
    {"星王魔靴",10},
    {"星王法杖",10},
    {"星王法袍(男)",10},
    {"星王法袍(女)",10},

    {"狂雷战戒",20},
    {"狂雷护腕",20},
    {"狂雷战链",20},
    {"狂雷头盔",20},
    {"狂雷腰带",20},
    {"狂雷战靴",20},
    {"狂雷之剑",20},
    {"狂雷战甲(女)",20},
    {"狂雷战甲(男)",20},
    {"通云道戒",20},
    {"通云护腕",20},
    {"通云项链",20},
    {"通云腰带",20},
    {"通云头盔",20},
    {"通云道靴",20},
    {"通云剑",20},
    {"通云道袍(男)",20},
    {"通云道袍(女)",20},
    {"逆火魔戒",20},
    {"逆火护腕",20},
    {"逆火项链",20},
    {"逆火腰带",20},
    {"逆火头盔",20},
    {"逆火魔靴",20},
    {"逆火杖",20},
    {"逆火法袍(男)",20},
    {"逆火法袍(女)",20},
}
local a = 1
local am = 1
local l = 1
local lm = 1
function xianshi_dianji(player)

    local sj =  lualib:GetDBNum("xsjlks")
    if lualib:GetClientType(player) == 0 then
        local num = #rmb_hs
        local b = 10 -- 每页显示数量
        local ye = math.floor(num/b)
        --local ye1 = ye * b
        local ye1 = 1
        if num%b == 0 then
            ye = ye
            ye1 = (ye-1) * b
        else
            ye1 = ye * b
            ye = ye + 1
        end

        local msg = "\n\n"
        if sj <= 0 then
            msg=msg.."     #COLORCOLOR_YELLOW#当前活动状态：#COLORCOLOR_GREENG#正在进行中！~~~\n"
        else
            msg=msg.."     #COLORCOLOR_YELLOW#当前活动状态：#COLORCOLOR_RED#距离开启时间剩余["..sj.."秒]！~~~\n"
        end
        msg = msg.."   #COLORCOLOR_GRAY#┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅#COLOREND#\n"
        local n = a+b-1
        if n >= num then
            n=num
        end
        for i=a,n do
            if lualib:GetDBStr(rmb_hs[i][1]) ~= "" then
                msg = msg.."#COLORCOLOR_ORANGE#   √第一个得到：#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#奖励："..rmb_hs[i][2].."元充值　#COLORCOLOR_RED#[已被领取]  #COLORCOLOR_BLUE#获奖人：#COLOREND#"..lualib:GetDBStr(rmb_hs[i][1]).."\n"
            else
                msg = msg.."#COLORCOLOR_ORANGE#   √第一个得到：#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#奖励："..rmb_hs[i][2].."元充值　#COLORCOLOR_RED#[尚未领取]  #COLORCOLOR_BLUE#获奖人：#COLORCOLOR_GREENG#暂无\n"
            end
        end
        msg = msg.."   #COLORCOLOR_GRAY#┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅#COLOREND#\n"
        if a == 1 then
            msg = msg.."                                页("..l.."/"..(ye)..")        <@unp *01*[下一页]> \n"
        elseif a== ye1+1 then
            msg = msg.."                <@down *01*[上一页]>        页("..l.."/"..(ye)..")\n"
        else
            msg = msg.."                <@down *01*[上一页]>        页("..l.."/"..(ye)..")        <@unp *01*[下一页]> \n"
        end


        local str = [[<form default_parent="NpcTalk,Container">]]
        str=str.."<script><![CDATA["..[[
				em = 1
				color = {"#fe0101","#fe01d7","#1301fe","#01e9fe","#01fe01","#fef501"}
				function info(pm)
				WndAddTimer(this,"NpcTalk,Container",13,1000,"text_color")
				end
				function text_color()

				end
					]]..
                "]]></script>"
        str = str .. "<edit id=标题 x=20 y=6 w=500 h=20   text=为了提高玩家打装备积极性,第一个从怪物身上获得装备有充值奖励(合成与冲级奖励无效)  text_color=#fff600/>	"
        str = str .. "<edit id=标题1 x=20 y=260 w=500 h=20   text=温馨提示：为保证奖励公平公正即时有效,奖励在怪物身上获得后的第一时间发放给玩家 text_color=#00ff42 />	"
        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"
        lualib:NPCTalkDetail(player, msg, 550, 320)
    else
        local num = #rmb_hs
        --lualib:SysMsg_SendBroadcastMsg(tostring(rmb_hs[69][1]), "num")

        local b = 4 -- 每页显示数量
        local ye = math.floor(num/b)
        local ye1 = ye * b
        if num%b == 0 then
            ye = ye
            ye1 = (ye-1) * b
        else
            ye1 = ye * b
            ye = ye + 1
        end
        local msg = ""
        if sj <= 0 then
            msg=msg.."#COLORCOLOR_YELLOW#当前活动状态：#COLORCOLOR_GREENG#装备首爆正在进行中！~~~\n"
        else
            msg=msg.."#COLORCOLOR_YELLOW#当前活动状态：#COLORCOLOR_RED#装备首爆开启时间剩余["..sj.."秒]！~~~\n"
        end
        msg = msg.."#COLORCOLOR_GRAY#┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅#COLOREND#\n"
        local n = am+b-1
        if n >= num then
            n=num
        end
        for i=am,n do
            if lualib:GetDBStr(rmb_hs[i][1]) ~= "" then
                msg = msg.."#COLORCOLOR_ORANGE#√第一个得到：#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#奖励："..rmb_hs[i][2].."元充值\n#COLORCOLOR_RED#[已被领取]  #COLORCOLOR_BLUE#获奖人：#COLOREND#"..lualib:GetDBStr(rmb_hs[i][1]).."\n"
            else
                msg = msg.."#COLORCOLOR_ORANGE#√第一个得到：#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#奖励："..rmb_hs[i][2].."元充值\n#COLORCOLOR_RED#[尚未领取]  #COLORCOLOR_BLUE#获奖人：#COLORCOLOR_GREENG#暂无\n"
            end
        end
        msg = msg.."#COLORCOLOR_GRAY#┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅#COLOREND#\n"
        if am == 1 then
            msg = msg.."                页("..lm.."/"..(ye)..")        <@unpm *01*[下一页]> \n"
        elseif am== ye1+1 then
            msg = msg.."    <@downm *01*[上一页]>        页("..lm.."/"..(ye)..")\n"
        else
            msg = msg.."    <@downm *01*[上一页]>        页("..lm.."/"..(ye)..")        <@unpm *01*[下一页]> \n"
        end
        lualib:NPCTalkDetail(player, msg, 550, 320)
    end

    return ""
end

function lingq(player,num)
    
    local num = tonumber(num)
    if lualib:GetDBStr(rmb_hs[num][1]) ~= "" then
        lualib:SysWarnMsg(player, "该奖励已被领取过了")
        return xianshi_dianji(player)
    end
    if lualib:ItemCount(player, rmb_hs[num][1]) < 1 then
        lualib:SysWarnMsg(player, "您包裹里没有["..rmb_hs[num][1].."],赶紧去寻找吧！")
        return xianshi_dianji(player)
    end
    lualib:SetDBStr(rmb_hs[num][1],lualib:Name(player))
    local s = "#COLORCOLOR_YELLOW#限时奖励#COLORCOLOR_BROWN#：恭喜玩家#COLORCOLOR_MAGENTA#「"..lualib:Name(player).."」#COLORCOLOR_BROWN#率先拥有#COLORCOLOR_GREENG#["..rmb_hs[num][1].."]#COLORCOLOR_BROWN#系统自动发放#COLORCOLOR_RED#("..rmb_hs[num][2].."元现金充值)#COLORCOLOR_BROWN#奖励,请勇士们抓紧击杀怪物寻找装备吧！"
    lualib:SysMsg_SendBroadcastColor(s, "", 1, 11)

    lualib:AddIngot(player, rmb_hs[num][2]*100, "人民币点道具", lualib:Name(player))
    local user_id = lualib:UserID(player)
    local today = lualib:GetAllDays(0)
    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id)+(rmb_hs[num][2]*20),4)
    lualib:SetDBNumEx("mrczje"..today..user_id,lualib:GetDBNum("mrczje"..today..user_id)+rmb_hs[num][2],4)
    lualib:SysMsg_SendWarnMsg(player, "你充值了"..(rmb_hs[num][2]*100).."元宝")
    return xianshi_dianji(player)
end

function unpm(player)
    if am >= 128 then
        return xianshi_dianji(player)
    end
    am = am+4
    lm = lm +1
    return xianshi_dianji(player)
end

function downm(player)
    if am <= 1 then
        return xianshi_dianji(player)
    end
    am = am-4
    lm = lm -1
    return xianshi_dianji(player)
end

function unp(player)
    if a >= 130 then
        return xianshi_dianji(player)
    end
    a = a+10
    l = l +1
    return xianshi_dianji(player)
end

function down(player)
    if a <= 1 then
        return xianshi_dianji(player)
    end
    a = a-10
    l = l -1
    return xianshi_dianji(player)
end
