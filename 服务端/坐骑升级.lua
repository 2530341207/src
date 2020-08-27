-- ������� �ͻ��˽ű��ļ� 2017��9��15�� 16:52:08 Powered By QQ20606919 Design--



GodWing = {}

GodWing.Handle = 0

GodWing.Verify = {--��Ȩ����ID
    ["915"] = 1,
    ["6"] = 1,
}

local position = {
    {-10,20,500,500},
    {-90,-30,600,600},
    {20,70,400,400},
    {-90,-30,600,600},
    {-90,-50,600,600},
    {-90,-20,600,600},
    {-130,-70,700,700},
    {-90,-30,600,600},
    {-110,-80,600,600},
    {-220,-130,800,800},
    {-180,-130,800,800},
    {-190,-130,800,800},
}

function GodWing.main()
    local handle = GetWindow(nil, "�������")
    if handle ~= 0 then WndClose(handle) end
    local str = [[
	<form>
		<dialog id=������� x=0 y=0 w=600 h=500 image=1803700001 fitsize=1 npc=]]..godwing_npc..[[ center=1 savepos=1 OnInit=GodWing.Init>
			<image id=������ x=0 y=0 image=1803700001 type=flat w=409 h=330/>
			<image id=ͼ x=35 y=55 w=535 h=430 image=1803700018 fitsize=1/>
			<image id=�� x=29 y=325 w=351 h=3 type=flat image=1800000034/>
			<richedit id="����" x="252" y="11" w="100" h="20" text="]]..godwing_t.name..[[����" text_color="YELLOW" font="SIMLI18"/>
		    <button id="�ر�" x="525" y="5" image="1850000423" OnLButtonClick="GodWing.Closed" />
			<image id="����չʾ" x=33 y=0 image=0 fitsize=true/>
			<edit id="��3" x=250 y=250 w=200 h=16 text_color="#D3D2D0" text="��������"/>
			<image id="�Ź���" x=111 y=352 w=188 h=28 image=1800000325,1800000326,1800000327,1800000328,1800000333,1800000329,1800000330,1800000331,1800000332 revmsg=1/>
			<richedit id="������ʾ1" x=200 y=280 w=400 h=15 text_color="GREENG" text="�������鿴��������"/>
			<richedit id="������ʾ2" x=200 y=300 w=400 h=15 text_color="GREENG" text="�������鿴��������"/>

			<image id="��1" x=42 y=310 image=1800900018 fitsize=1 w=150 h=50/>
			<edit id="��1" x=80 y=330 w=200 h=16 text_color="BROWN2" text="��ǰ���"/>
			<image id=��1 x=85 y=363 w=69 h=69 fitsize=1 image=1800000080/>
			<itemctrl id=��Ʒ1 x=92 y=369 w=60 h=60 use_back=0/>
			<image id="��2" x=395 y=310 image=1800900018 fitsize=1 w=150 h=50/>
			<edit id="��2" x=431 y=330 w=200 h=16 text_color="BROWN2" text="�½�Ԥ��"/>
			<image id=��2 x=437 y=363 w=69 h=69 fitsize=1 image=1800000080/>
			<itemctrl id=��Ʒ2 x=444 y=369 w=60 h=60 use_back=0/>
			<image id="�׼�" x=500 y=80 image=1802300002/>
			<richedit id="�ֽ�" x=504 y=80 w=100 h=15 font="SIMLI18" text_color="#FF0000" text="һ\n��"/>
			<button id="����" x=220 y=420 image=1852600003 text="��ѽ���" text_color="GOLD2" OnLButtonClick=GodWing.UpLv/>
		</dialog>
	</form>
	]]
    GenFormByString(str)
end

function GodWing.Init(this)
    GodWing.Handle = this


    --WndAddEffect(this, "��Ʒ1", 3020101000, -28, -28, 150, 0)
    --WndAddEffect(this, "��Ʒ2", 3020101000, -28, -28, 150, 0)


    RichEditClear(nil, "�������,������ʾ1")
    RichEditClear(nil, "�������,������ʾ2")
    local lv = godwing_lv
    local nlv = math.min(lv+1, #godwing_t)
    local tab = godwing_t[nlv]

    if tab.cls ~= nil then
        RichEditAppendString(nil, "�������,������ʾ1", "���Ĳ��ϣ�"..GodWing.KeyName2Name(tab.cls[1]).."��"..tab.cls[2].."")
    end
    if tab.ite ~= nil then
        RichEditAppendString(nil, "�������,������ʾ2", "����װ����"..GodWing.KeyName2Name(tab.ite[1]).."��"..tab.ite[2].."")
    end

    GodWing.Update(godwing_lv)
end

function GodWing.Update(lv)
    local this = GodWing.Handle
    local nlv = math.min(lv+1, #godwing_t)
    local tab = godwing_t[nlv]
    RichEditClear(this, "�ֽ�")
    RichEditAppendString(this, "�ֽ�", tab.lvs)

    local _Handle = GetWindow(this,"���չʾ")
    if _Handle ~= nil then
        GUI:WndSetPosM(_Handle,position[nlv][1],position[nlv][2])
        GUI:WndSetSizeM(_Handle,position[nlv][3],position[nlv][4])
        GUI:ImageSetAnimateEnable(_Handle,true,200)
        ImageSetImageID(this, "����չʾ", tab.img[1])
    end

    if lv + 1 > #godwing_t then
        RichEditClear(this, "����ֵ")
        RichEditAppendString(this, "����ֵ", godwing_t.max)
        RDItemCtrlSetGUIDataPropByKeyName(this, "��Ʒ1", tab.key, 1, false)
        RDItemCtrlSetGUIDataPropByKeyName(this, "��Ʒ2", tab.key, 1, false)
        WndSetEnableM(this, "����", false)

        local tip = "["
        tip = tip..tipText(godwing_t.max, "#FF0000","system")
        tip = tip.."{}]"
        WndSetTipInfo(this, "����", tip)
        WndSetTipInfo(this, "�Ź���", tip)
    else
        RDItemCtrlSetGUIDataPropByKeyName(this, "��Ʒ2", tab.key, 1, false)
        if godwing_t[lv] ~= nil then
            RDItemCtrlSetGUIDataPropByKeyName(this, "��Ʒ1", godwing_t[lv].key, 1, false)
        end
        local tip = "["
        tip = tip..tipText("��"..GodWing.KeyName2Name(tab.key).."������\n", "#FF0000","system")
        if tab.ybs ~= nil then
            tip = tip..tipLine()..tipText("����Ԫ����"..tab.ybs.."\n", "PURPLE","system")
        end
        if tab.jbs ~= nil then
            tip = tip..tipLine()..tipText("���Ľ�ң�"..tab.jbs.."\n", "YELLOW","system")
        end
        if tab.cls ~= nil then
            tip = tip..tipLine()..tipText("���Ĳ��ϣ�"..GodWing.KeyName2Name(tab.cls[1]).."��"..tab.cls[2].."\n", "ORANGE","system")
        end
        if tab.ite ~= nil then
            tip = tip..tipLine()..tipText("����װ����"..GodWing.KeyName2Name(tab.ite[1]).."��"..tab.ite[2].."\n", "ORANGE","system")
        end
        tip = tip.."{}]"
        WndSetTipInfo(this, "����", tip)
        WndSetTipInfo(this, "�Ź���", tip)
    end
end

function GodWing.UpLv(this)
    local script = [[UI:Lua_SubmitForm("��������", "main", ]]..string.format("%q", godwing_lv.."#"..godwing_npc)..[[)]]
    local str = "#COLORCOLOR_GREENG#��ȷ��Ҫ����#COLORCOLOR_PURPLE#��"..GodWing.KeyName2Name(godwing_t[godwing_lv+1].key).."��#COLORCOLOR_GREENG#��"
    MessageBox(1, str, script)
end

function GodWing.KeyName2Name(KeyName)
    if UI:Lua_GetItemTemplateHandleByKeyName(KeyName) then
        if UI:Lua_GetItemTemplatePropByHandle(LuaRet, ITEM_PROP_NAME) then
            return LuaRet
        end
    end
    return KeyName
end

function GodWing.Closed(this)
    WndClose(this, "parent")
end

GodWing.main()