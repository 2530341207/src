Fashion = {}

Fashion.items = fashion_tab

Fashion.Pos = 1

function Fashion.main()
    local handle = GetWindow(nil, "ʱװ����")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
	<form>
		<dialog id=ʱװ���� x=0 y=0 w=700 h=600  image=0 center=1 close=0 savepos=1 magic=1 OnInit=Fashion.Init>
			<image id="�ұ���" x=-25 y=-50 w=700 h=600 image="4000800000" fitsize=true/>
			
			<wnd id="wnd1" x=0 y=0 w=309 h=395>
				<image id="�ұ���" x=368 y=76 w=245 h=415  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<image id="�󱳾�" x=30 y=76 w=342 h=415 type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="����1" x=455 y=80 w=200 h=15 text_color="BROWN" text="���ʱװ����"/>
				<richedit id="����1" x=375 y=125 w=200 h=15 text_color="white" text="��    ����"/>
				<richedit id="����2" x=375 y=165 w=200 h=15 text_color="white" text="ħ    ����"/>
				<richedit id="����3" x=375 y=205 w=200 h=15 text_color="white" text="��    ����"/>
				<richedit id="����4" x=375 y=245 w=200 h=15 text_color="white" text="ħ    ����"/>
				<richedit id="����5" x=375 y=285 w=200 h=15 text_color="white" text="��    ����"/>
				<richedit id="����6" x=375 y=325 w=200 h=15 text_color="white" text="�������ʣ�"/>
				<richedit id="����7" x=375 y=365 w=200 h=15 text_color="white" text="���ﱬ�ʣ�"/>
				<richedit id="����8" x=375 y=405 w=200 h=15 text_color="white" text="�������ʣ�"/>
				<richedit id="��ʾ1" x=475 y=125 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ2" x=475 y=165 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ3" x=475 y=205 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ4" x=475 y=245 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ5" x=475 y=285 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ6" x=475 y=325 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="��ʾ7" x=475 y=365 w=200 h=15 text_color="YELLOW" text="0"/>
				<richedit id="��ʾ8" x=475 y=405 w=200 h=15 text_color="YELLOW" text="0"/>


				<itemctrl id=���� x=83 y=383 w=44 h=44 use_back=false revmsg=false/>
				<itemctrl id=�·� x=177 y=295 w=44 h=44 use_back=false />


				<button id="��ҳ" x="40" y="270" image="1800000192" param=1 OnLButtonClick="Fashion.MakePage"/>
				<button id="��ҳ" x="303" y="270" image="1800000196" param=2 OnLButtonClick="Fashion.MakePage"/>

				<image id="�����" x=95 y=445 image="1805900017"/>
				<edit id="������" x="150" y="455" w="200" h="20" text_color="YELLOW" text="" font="SIMLI18"  />

				<button id="��ȡ" x="425" y="450" image="1804100010" index=1 text="��ȡ" text_color="GOLD2" param=2 OnLButtonClick="Fashion.MakeOK" />
				<button id="����" x="515" y="450" image="1804100010" index=1 text="����" text_color="GOLD2" param=1 OnLButtonClick="Fashion.MakeOK" />
			</wnd>
			<wnd id="wnd2" x=0 y=0 w=309 h=395>
				<image id="wnd2_bgk1" x="31" y="78" w="580" h="410" image="1802400002" fitsize=true />

				<image id="wnd2_bgk2" x="100" y="85" w="100" h="30"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<image id="wnd2_bgk3" x="270" y="85" w="100" h="30"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<image id="wnd2_bgk4" x="440" y="85" w="100" h="30"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="wnd2_txt1" x="110" y="90" w="80" h="20" text="����ʱװ" text_color="YELLOW" font="system"/>
				<richedit id="wnd2_txt2" x="280" y="90" w="80" h="20" text="����ʱװ" text_color="YELLOW" font="system"/>
				<richedit id="wnd2_txt3" x="450" y="90" w="80" h="20" text="����ʱװ" text_color="YELLOW" font="system"/>

				<image id="wnd2_line1" x="150" y="173" w="2" h="90" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line2" x="320" y="173" w="2" h="60" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line3" x="490" y="173" w="2" h="90" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line4" x="150" y="263" w="140" h="2" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line5" x="360" y="263" w="132" h="2" image="1808900012" fitsize="true" gray="false" />

				<image id="��Ʒ�򱳾�1" x="110" y="120" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="��Ʒ��1" x="123" y="135" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="1" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="��Ʒ�򱳾�2" x="280" y="120" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="��Ʒ��2" x="293" y="135" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="2" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="��Ʒ�򱳾�3" x="450" y="120" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="��Ʒ��3" x="463" y="135" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="3" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="��Ʒ�򱳾�4" x="280" y="220" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="��Ʒ��4" x="293" y="235" w="55" h="55"  init_item=""  use_back="false" />

				<richedit id="wnd2_txt4" x="160" y="300" w="500" h="20" text="����ͬ��ʱװ���Ժϳ�һ��S��ʱװ" text_color="DARK" font="system"/>
				<richedit id="wnd2_txt5" x="120" y="330" w="500" h="20" text="�ϳ���ҪԪ�����Һϳɵ�S��ʱװ�����ںϳ�" text_color="DARK" font="system"/>
				<richedit id="wnd2_txt6" x="160" y="360" w="500" h="20" text="�ϳ�ʱװ,��ʱװ����������������" text_color="DARK" font="system"/>
				<richedit id="wnd2_txt7" x="230" y="395" w="100" h="20" text="����Ԫ����" text_color="YELLOW" font="system"/>
				<image id="wnd2_bgk5" x="330" y="390" w="90" h="30"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="wnd2_txt8" x="340" y="395" w="80" h="20" text="288888" text_color="GREENG" font="system"/>
				<button id="wnd2_btn1" x="180" y="430" image="1852500055" text="�Զ�����" text_color="GOLD2" param=1 OnLButtonClick="Fashion.into" />
				<button id="wnd2_btn2" x="340" y="430" image="1852500055" text="ʱװ�ϳ�" text_color="GOLD2" param=1 OnLButtonClick="Fashion.synthesis" />

			</wnd>
			<richedit id="����" x="250" y="0" w="100" h="20" text="ʱװ����" text_color="YELLOW" font="SIMLI18"/>
			<button id="ʱװ����" x="50" y="45" image="1804100010" text="����" text_color="GOLD2" param=1 OnLButtonClick="Fashion.duanzao" />
			<button id="ʱװǿ��" x="125" y="45" image="1804100010" text="ǿ��" text_color="GOLD2" param=1 OnLButtonClick="Fashion.qianghua" />
			<button id="�ر�" x="550" y="-16" image="4000230000" OnLButtonClick="Fashion.Closed" />
		</dialog>
	</form>
	]]
    GenFormByString(str)
    local Handle = GetWindow(nil,"ʱװ����,wnd2")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
    end
end

Fashion.Init = function(this)
    Fashion.handle = this

    local _GUIHandle = GUI:WndFindWindow(this, "wnd1,����")
    if _GUIHandle ~= 0 then
        GUI:WndSetPosM(_GUIHandle, 108, 27)
        GUI:WndSetSizeM(_GUIHandle, 50, 240)
        GUI:ItemCtrlSetBigIcon(_GUIHandle, 1)
        GUI:ItemCtrlSetBigIconOffset(_GUIHandle, 218, 285)
        GUI:ImageSetDrawCenter(_GUIHandle,true)
    end

    local _FashionEquimentHandle = GUI:WndFindWindow(this, "wnd1,�·�")
    if _FashionEquimentHandle ~= 0 then
        GUI:ItemCtrlSetItemDataAutoManager(_FashionEquimentHandle,true)
        GUI:ItemCtrlSetBigIcon(_FashionEquimentHandle, 1)
        GUI:ImageSetDrawCenter(_FashionEquimentHandle, true)
        GUI:WndSetSizeM(_FashionEquimentHandle, 80, 150)
        GUI:ItemCtrlSetBigIconOffset(_FashionEquimentHandle, 218, 285)
        if CL:GetPlayerSelfProperty32(181) then
            local _Gender = LuaRet
            if _Gender == 1 then
                GUI:ItemCtrlSetDefaultImage(_FashionEquimentHandle, 1990401001)
            else
                GUI:ItemCtrlSetDefaultImage(_FashionEquimentHandle, 1990401002)
            end
        end
    end


    Fashion.Updata()
end

local sx = {
    {77,76},
    {79,78},
    {81,80},
    {83,82},
    {85,84},
}

Fashion.Updata = function(types)
    RDItemCtrlSetGUIDataPropByKeyName(nil, "ʱװ����,wnd1,�·�", Fashion.items[Fashion.Pos][1][1], 1, false)
    RDItemCtrlSetGUIDataPropByKeyName(nil, "ʱװ����,wnd1,����", Fashion.items[Fashion.Pos][1][4], 1, false)
    EditSetTextM(nil, "ʱװ����,wnd1,������", Fashion.KeyName2Name(Fashion.items[Fashion.Pos][1][1]))

    local GUIHandle = GetWindow(nil,"ʱװ����,wnd1,�·�")
    local a = 0
    local b = 0
    local item = GUI:ItemCtrlGetGUIData(GUIHandle)
    UI:Lua_GetItemGUIDataPropByType(item,3)
    local id = LuaRet
    for i,v in pairs(sx) do
        if UI:Lua_GetItemTemplatePropByID(id,v[1]) ~= nil then
            a = LuaRet
        end

        if UI:Lua_GetItemTemplatePropByID(id,v[2]) ~= nil then
            b = LuaRet
        end
        local Handle = GetWindow(nil,"ʱװ����,wnd1,��ʾ"..i)
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, ""..a.."-"..b)
    end

    if UI:Lua_GetItemTemplatePropByID(id,102) ~= nil then
        a = LuaRet
    end

    local Handle = GetWindow(nil,"ʱװ����,wnd1,��ʾ6")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, ""..a.."%")
    end

    local Handle = GetWindow(nil,"ʱװ����,wnd1,��ʾ7")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, tostring(Fashion.items[Fashion.Pos][1][6]))
    end

    local Handle = GetWindow(nil,"ʱװ����,wnd1,��ʾ8")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, tostring(Fashion.items[Fashion.Pos][1][7]))
    end

    local tip1, tip2 = "", ""
    if Fashion.items[Fashion.Pos][1][2] ~= nil then
        tip1 = "������Ҫ:\n\n"..Fashion.KeyName2Name(Fashion.items[Fashion.Pos][1][2][1]).." * "..Fashion.items[Fashion.Pos][1][2][2]
        tip2 = "��ȡ��Ҫ:\n\nԪ�� * "..Fashion.items[Fashion.Pos][1][3]
    end


    WndSetTipInfo(nil, "ʱװ����,wnd1,����", "["..tipText(tip1, mkcolor("GREENG")).."{}]")
    WndSetTipInfo(nil, "ʱװ����,wnd1,��ȡ", "["..tipText(tip2, mkcolor("GREENG")).."{}]")
end

function Fashion.KeyName2Name(KeyName)
    if UI:Lua_GetItemTemplateHandleByKeyName(KeyName) then
        if UI:Lua_GetItemTemplatePropByHandle(LuaRet, ITEM_PROP_NAME) then
            return LuaRet
        end
    end
    return KeyName
end

Fashion.MakePage = function(this)
    local par = WndGetParam(this, nil)
    if par == 1 then
        if Fashion.Pos > 1 then
            Fashion.Pos = Fashion.Pos - 1
            Fashion.Updata()
        end
    elseif par == 2 then
        if Fashion.Pos < #Fashion.items then
            Fashion.Pos = Fashion.Pos + 1
            Fashion.Updata()
        end
    end
end

Fashion.duanzao = function(this)

    local Handle = GetWindow(nil,"ʱװ����,wnd2")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
        Handle = GetWindow(nil,"ʱװ����,wnd1")
        GUI:WndSetVisible(Handle,true)
    end
    Fashion.Pos = 1
    Fashion.Updata()
end

Fashion.qianghua = function(this)

    local Handle = GetWindow(nil,"ʱװ����,wnd1")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
        Handle = GetWindow(nil,"ʱװ����,wnd2")
        GUI:WndSetVisible(Handle,true)
    end

end

Fashion.MakeOK = function(this)
    local types = WndGetParam(this)
    local index = WndGetProperty(this, nil, "index")
    UI:Lua_SubmitForm("ʱװ�����", "main", Fashion.Pos.."#"..index.."#"..types)
end

Fashion.Closed = function(this)
    local handle =  GetWindow(nil, "ʱװ����")
    if handle ~= 0 then
        WndCloseM(handle, nil)
    end
end

function Fashion.OnItemMoveIn(this, GUIData, DragIn, GUID, ItemId, KeyName, ItemPos, IsBound, Count) --�ֶ�����ʱװ
	local num = tonumber(GUI:WndGetParam(this))
    local sameCount = 0		--������ͬʱװ������Ʒ���е�����
	local itemNum = 0		--ʱװkeyname��Ӧ��fashionsRelated�еĵ�һ��

	if CL:GetItemTemplatePropByID(ItemId,ITEM_PROP_SUBTYPE) then
        if LuaRet ~= 16 then
			CL:ShowTypeMsg(3,"���������Ʒ����ʱװ������")
            return false
        end
    end

    for i=1,3 do
        if i ~= num then
            local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��"..i)
            if RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") ~= "" and RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") ~= KeyName then --�ж��Ƿ������ͬʱװ

				CL:ShowTypeMsg(3,"�������ͬ��ʱװ������")
                return false
            end
            if RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") == KeyName then
                sameCount = sameCount + 1
            end
        end
    end



    if sameCount ==2 then		--������ͬ��ʱװ ������Ҫ�ϳ�ʱװ��ģ��
		for i=1,#fashionsRelated do
			if KeyName == fashionsRelated[i][1] then
				itemNum = i
			end
		end
        local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��4")
        RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[itemNum][2],1,false)
    end

    return true
end

function Fashion.into(this)		--�Զ�����ʱװ
	UI:Lua_SubmitForm("ʱװ�����", "automaticallyPlaced", "")
end

local itemKeyName = ""

function Fashion.update() --�Զ�����
	local num = 0
	for i=1,#fashionsCount do
		if fashionsCount[i] >= 3 then
			num = 1
			for j=1,3 do
				local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��"..j)
				RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[i][1],1,false)
			end
			itemKeyName = fashionsRelated[i][1]
			local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��4")
			RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[i][2],1,false)
		end
	end
	if num == 0 then
		CL:ShowTypeMsg(3,"���ı�����û������һ����ʱװ����")
	end
end

function Fashion.synthesis(this)	--�ϳ�ʱװ
	local num = 0 --������Ʒ���е�����
	local itemName = "" 	--��Ʒ���е�ʱװkeyname
	for i = 1,3 do
		local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��"..i)
		if GUI:ItemCtrlGetGUIDataPropByType(_ItemHandle,ITEMGUIDATA_ITEMID)	then --���ģ��ID
			itemID = LuaRet
		end

		if itemID ~= 0 then
			if CL:GetItemTemplatePropByID(itemID,ITEM_PROP_KEYNAME) then	--�����Ʒ��keyname
				itemName = LuaRet
			end
		end

		if itemName ~= "" then	--������Ʒ�����м�ʱװ
			num = num + 1
		end
	end

	if num ~= 3 then
		CL:ShowTypeMsg(3,"���ȷ�������ʱװ�ڵ���ϳɣ�����")
		return false
	end

	UI:Lua_SubmitForm("ʱװ�����", "Synthesis",tostring(itemName))
end

function Fashion.onBtnC(this)
	local num = 0
	for i=1,3 do
		local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��"..i)
		if GUI:ItemCtrlGetGUIDataPropByType(_ItemHandle,ITEMGUIDATA_ITEMID)	then --���ģ��ID
			itemID = LuaRet
		end

		if itemID ~= 0 then
			num = num + 1
		end
	end
	if num ~= 3 then
		local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��4")
		GUI:ItemCtrlClearItemData(_ItemHandle)
	end
end

function Fashion.clearFashion()
	for i=1,4 do
		local _ItemHandle = GetWindow(0,"ʱװ����,wnd2,��Ʒ��"..i)
		GUI:ItemCtrlClearItemData(_ItemHandle)
	end
end

Fashion.main()