local lua_path = lualib:IO_GetLuaPath()
local package_path = package.path
package.path = string.format("%s;%s?.lua;%s?", package_path, lua_path, lua_path)
require("system/timecount_def")

function xianshi_xianshi(player)

    return ""
end


local rmb_hs = {
    {"ʥս��ָ",1},
    {"ʥս����",1},
    {"ʥսͷ��",1},
    {"ʥս����",1},
    {"�����ָ",1},
    {"��������",1},
    {"����ͷ��",1},
    {"��������",1},
    {"�����ָ",1},
    {"��������",1},
    {"����ͷ��",1},
    {"��������",1},
    {"��ħ���",1},
    {"ʥս����",1},
    {"ŭն",1},
    {"����",1},
    {"��ң��",1},
    {"����ս��",2},
    {"��������",2},
    {"��������",2},
    {"����ͷ��",2},
    {"����սѥ",2},
    {"��������",2},
    {"����ս��(��)",3},
    {"����ս��(Ů)",3},
    {"����ħ��",2},
    {"���滤��",2},
    {"����ħ��",2},
    {"��������",2},
    {"����ħ��(Ů)",3},
    {"����ħ��(��)",3},
    {"��������",2},
    {"����ħѥ",2},
    {"��â����",2},
    {"��â����",2},
    {"��â����",2},
    {"��â����",2},
    {"��â����",2},
    {"��â��ѥ",2},
    {"��â����(Ů)",2},
    {"��â����(��)",2},
    {"����",3},
    {"����",3},
    {"����",3},
    {"ս���ָ",5},
    {"ս������",5},
    {"ս������",5},
    {"ս��ͷ��",5},
    {"ս������",5},
    {"ս��սѥ",5},
    {"ս��",5},
    {"ս������(��)",5},
    {"ս������(Ů)",5},
    {"������",5},
    {"��껤��",5},
    {"�������",5},
    {"�������",5},
    {"������",5},
    {"����ѥ",5},
    {"�������",5},
    {"������(Ů)",5},
    {"������(��)",5},
    {"ʥħħ��",5},
    {"ʥħ����",5},
    {"ʥħ����",5},
    {"ʥħ����",5},
    {"ʥħħ��",5},
    {"ʥħħѥ",5},
    {"ʥħȨ��",5},
    {"ʥħ����(��)",5},
    {"ʥħ����(Ů)",5},

    {"����ս��",10},
    {"��������(ս)",10},
    {"��������(ս)",10},
    {"����ͷ��(ս)",10},
    {"��������(ս)",10},
    {"����սѥ",10},
    {"����ս��",10},
    {"����ս��(��)",10},
    {"����ս��(Ů)",10},
    {"��������",10},
    {"��������(��)",10},
    {"��������(��)",10},
    {"��������(��)",10},
    {"����ͷ��(��)",10},
    {"������ѥ",10},
    {"��������",10},
    {"��������(��)",10},
    {"��������(Ů)",10},
    {"����ħ��",10},
    {"��������(��)",10},
    {"��������(��)",10},
    {"��������(��)",10},
    {"����ͷ��(��)",10},
    {"����ħѥ",10},
    {"��������",10},
    {"��������(��)",10},
    {"��������(Ů)",10},

    {"����ս��",20},
    {"���׻���",20},
    {"����ս��",20},
    {"����ͷ��",20},
    {"��������",20},
    {"����սѥ",20},
    {"����֮��",20},
    {"����ս��(Ů)",20},
    {"����ս��(��)",20},
    {"ͨ�Ƶ���",20},
    {"ͨ�ƻ���",20},
    {"ͨ������",20},
    {"ͨ������",20},
    {"ͨ��ͷ��",20},
    {"ͨ�Ƶ�ѥ",20},
    {"ͨ�ƽ�",20},
    {"ͨ�Ƶ���(��)",20},
    {"ͨ�Ƶ���(Ů)",20},
    {"���ħ��",20},
    {"�����",20},
    {"�������",20},
    {"�������",20},
    {"���ͷ��",20},
    {"���ħѥ",20},
    {"�����",20},
    {"�����(��)",20},
    {"�����(Ů)",20},
}
local a = 1
local am = 1
local l = 1
local lm = 1
function xianshi_dianji(player)

    local sj =  lualib:GetDBNum("xsjlks")
    if lualib:GetClientType(player) == 0 then
        local num = #rmb_hs
        local b = 10 -- ÿҳ��ʾ����
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
            msg=msg.."     #COLORCOLOR_YELLOW#��ǰ�״̬��#COLORCOLOR_GREENG#���ڽ����У�~~~\n"
        else
            msg=msg.."     #COLORCOLOR_YELLOW#��ǰ�״̬��#COLORCOLOR_RED#���뿪��ʱ��ʣ��["..sj.."��]��~~~\n"
        end
        msg = msg.."   #COLORCOLOR_GRAY#��������������������������������������������������������������������������������#COLOREND#\n"
        local n = a+b-1
        if n >= num then
            n=num
        end
        for i=a,n do
            if lualib:GetDBStr(rmb_hs[i][1]) ~= "" then
                msg = msg.."#COLORCOLOR_ORANGE#   �̵�һ���õ���#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#������"..rmb_hs[i][2].."Ԫ��ֵ��#COLORCOLOR_RED#[�ѱ���ȡ]  #COLORCOLOR_BLUE#���ˣ�#COLOREND#"..lualib:GetDBStr(rmb_hs[i][1]).."\n"
            else
                msg = msg.."#COLORCOLOR_ORANGE#   �̵�һ���õ���#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#������"..rmb_hs[i][2].."Ԫ��ֵ��#COLORCOLOR_RED#[��δ��ȡ]  #COLORCOLOR_BLUE#���ˣ�#COLORCOLOR_GREENG#����\n"
            end
        end
        msg = msg.."   #COLORCOLOR_GRAY#��������������������������������������������������������������������������������#COLOREND#\n"
        if a == 1 then
            msg = msg.."                                ҳ("..l.."/"..(ye)..")        <@unp *01*[��һҳ]> \n"
        elseif a== ye1+1 then
            msg = msg.."                <@down *01*[��һҳ]>        ҳ("..l.."/"..(ye)..")\n"
        else
            msg = msg.."                <@down *01*[��һҳ]>        ҳ("..l.."/"..(ye)..")        <@unp *01*[��һҳ]> \n"
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
        str = str .. "<edit id=���� x=20 y=6 w=500 h=20   text=Ϊ�������Ҵ�װ��������,��һ���ӹ������ϻ��װ���г�ֵ����(�ϳ���弶������Ч)  text_color=#fff600/>	"
        str = str .. "<edit id=����1 x=20 y=260 w=500 h=20   text=��ܰ��ʾ��Ϊ��֤������ƽ������ʱ��Ч,�����ڹ������ϻ�ú�ĵ�һʱ�䷢�Ÿ���� text_color=#00ff42 />	"
        msg = str .. "<text><![CDATA["..msg.."]]></text></form>"
        lualib:NPCTalkDetail(player, msg, 550, 320)
    else
        local num = #rmb_hs
        --lualib:SysMsg_SendBroadcastMsg(tostring(rmb_hs[69][1]), "num")

        local b = 4 -- ÿҳ��ʾ����
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
            msg=msg.."#COLORCOLOR_YELLOW#��ǰ�״̬��#COLORCOLOR_GREENG#װ���ױ����ڽ����У�~~~\n"
        else
            msg=msg.."#COLORCOLOR_YELLOW#��ǰ�״̬��#COLORCOLOR_RED#װ���ױ�����ʱ��ʣ��["..sj.."��]��~~~\n"
        end
        msg = msg.."#COLORCOLOR_GRAY#������������������������������������������������������#COLOREND#\n"
        local n = am+b-1
        if n >= num then
            n=num
        end
        for i=am,n do
            if lualib:GetDBStr(rmb_hs[i][1]) ~= "" then
                msg = msg.."#COLORCOLOR_ORANGE#�̵�һ���õ���#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#������"..rmb_hs[i][2].."Ԫ��ֵ\n#COLORCOLOR_RED#[�ѱ���ȡ]  #COLORCOLOR_BLUE#���ˣ�#COLOREND#"..lualib:GetDBStr(rmb_hs[i][1]).."\n"
            else
                msg = msg.."#COLORCOLOR_ORANGE#�̵�һ���õ���#COLORCOLOR_BROWN#"..lualib:KeyName2Name(rmb_hs[i][1],4).." #COLORCOLOR_MAGENTA#������"..rmb_hs[i][2].."Ԫ��ֵ\n#COLORCOLOR_RED#[��δ��ȡ]  #COLORCOLOR_BLUE#���ˣ�#COLORCOLOR_GREENG#����\n"
            end
        end
        msg = msg.."#COLORCOLOR_GRAY#������������������������������������������������������#COLOREND#\n"
        if am == 1 then
            msg = msg.."                ҳ("..lm.."/"..(ye)..")        <@unpm *01*[��һҳ]> \n"
        elseif am== ye1+1 then
            msg = msg.."    <@downm *01*[��һҳ]>        ҳ("..lm.."/"..(ye)..")\n"
        else
            msg = msg.."    <@downm *01*[��һҳ]>        ҳ("..lm.."/"..(ye)..")        <@unpm *01*[��һҳ]> \n"
        end
        lualib:NPCTalkDetail(player, msg, 550, 320)
    end

    return ""
end

function lingq(player,num)
    
    local num = tonumber(num)
    if lualib:GetDBStr(rmb_hs[num][1]) ~= "" then
        lualib:SysWarnMsg(player, "�ý����ѱ���ȡ����")
        return xianshi_dianji(player)
    end
    if lualib:ItemCount(player, rmb_hs[num][1]) < 1 then
        lualib:SysWarnMsg(player, "��������û��["..rmb_hs[num][1].."],�Ͻ�ȥѰ�Ұɣ�")
        return xianshi_dianji(player)
    end
    lualib:SetDBStr(rmb_hs[num][1],lualib:Name(player))
    local s = "#COLORCOLOR_YELLOW#��ʱ����#COLORCOLOR_BROWN#����ϲ���#COLORCOLOR_MAGENTA#��"..lualib:Name(player).."��#COLORCOLOR_BROWN#����ӵ��#COLORCOLOR_GREENG#["..rmb_hs[num][1].."]#COLORCOLOR_BROWN#ϵͳ�Զ�����#COLORCOLOR_RED#("..rmb_hs[num][2].."Ԫ�ֽ��ֵ)#COLORCOLOR_BROWN#����,����ʿ��ץ����ɱ����Ѱ��װ���ɣ�"
    lualib:SysMsg_SendBroadcastColor(s, "", 1, 11)

    lualib:AddIngot(player, rmb_hs[num][2]*100, "����ҵ����", lualib:Name(player))
    local user_id = lualib:UserID(player)
    local today = lualib:GetAllDays(0)
    lualib:SetDBNumEx("bxb"..user_id,lualib:GetDBNum("bxb"..user_id)+(rmb_hs[num][2]*20),4)
    lualib:SetDBNumEx("mrczje"..today..user_id,lualib:GetDBNum("mrczje"..today..user_id)+rmb_hs[num][2],4)
    lualib:SysMsg_SendWarnMsg(player, "���ֵ��"..(rmb_hs[num][2]*100).."Ԫ��")
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
