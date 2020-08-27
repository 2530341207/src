Fashion = {}

Fashion.items = fashion_tab

Fashion.Pos = 1

function Fashion.main()
    local handle = GetWindow(nil, "时装界面")
    if handle ~= 0 then WndClose(handle) return end
    local str = [[
	<form>
		<dialog id=时装界面 x=0 y=0 w=800 h=700  image=0 center=1 close=0 savepos=1 magic=1 OnInit=Fashion.Init>
			<image id="右背景" x=-50 y=-100 w=800 h=700 image="4000030000" fitsize=true/>
			<wnd id="wnd1" x=0 y=0 w=309 h=395>
				<image id="右背景" x=398 y=56 w=240 h=430  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="标题1" x=485 y=75 w=200 h=15 text_color="BROWN" text="左侧时装属性"/>
				<richedit id="属性1" x=405 y=120 w=200 h=15 text_color="white" text="防    御："/>
				<richedit id="属性2" x=405 y=160 w=200 h=15 text_color="white" text="魔    御："/>
				<richedit id="属性3" x=405 y=200 w=200 h=15 text_color="white" text="攻    击："/>
				<richedit id="属性4" x=405 y=240 w=200 h=15 text_color="white" text="魔    法："/>
				<richedit id="属性5" x=405 y=280 w=200 h=15 text_color="white" text="道    术："/>
				<richedit id="属性6" x=405 y=320 w=200 h=15 text_color="white" text="暴击几率："/>
				<richedit id="属性7" x=405 y=360 w=200 h=15 text_color="white" text="人物爆率："/>
				<richedit id="属性8" x=405 y=400 w=200 h=15 text_color="white" text="防爆几率："/>
				<richedit id="显示1" x=505 y=120 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示2" x=505 y=160 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示3" x=505 y=200 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示4" x=505 y=240 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示5" x=505 y=280 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示6" x=505 y=320 w=200 h=15 text_color="YELLOW" text="0-0"/>
				<richedit id="显示7" x=505 y=360 w=200 h=15 text_color="YELLOW" text="0"/>
				<richedit id="显示8" x=505 y=400 w=200 h=15 text_color="YELLOW" text="0"/>



				<image id="特效" x="88" y="135" image="1062000000" type=animate/>
				<itemctrl id=武器 x=103 y=383 w=44 h=44 use_back=false revmsg=false/>
				<itemctrl id=衣服 x=197 y=295 w=44 h=44 use_back=false />


				<button id="上页" x="50" y="270" image="1800000192" param=1 OnLButtonClick="Fashion.MakePage"/>
				<button id="下页" x="363" y="270" image="1800000196" param=2 OnLButtonClick="Fashion.MakePage"/>

				<image id="标题框" x=122 y=455 image="1805900017"/>
				<edit id="标题名" x="196" y="465" w="200" h="20" text_color="YELLOW" text="" font="SIMLI18"  />

				<button id="抽取" x="425" y="450" image="1804100010" index=1 text="抽取" text_color="GOLD2" param=2 OnLButtonClick="Fashion.MakeOK" />
				<button id="锻造" x="515" y="450" image="1804100010" index=1 text="锻造" text_color="GOLD2" param=1 OnLButtonClick="Fashion.MakeOK" />
			</wnd>
			<wnd id="wnd2" x=0 y=0 w=309 h=395>
				<image id="wnd2_bgk1" x="30" y="50" w="650" h="460" image="1808400014" fitsize=true />

				<image id="wnd2_bgk2" x="148" y="70" w="80" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<image id="wnd2_bgk3" x="322" y="70" w="80" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<image id="wnd2_bgk4" x="508" y="70" w="80" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="wnd2_txt1" x="163" y="73" w="80" h="20" text="放入时装" text_color="YELLOW" font="system"/>
				<richedit id="wnd2_txt2" x="337" y="73" w="80" h="20" text="放入时装" text_color="YELLOW" font="system"/>
				<richedit id="wnd2_txt3" x="523" y="73" w="80" h="20" text="放入时装" text_color="YELLOW" font="system"/>

				<image id="wnd2_line1" x="188" y="173" w="2" h="90" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line2" x="362" y="173" w="2" h="60" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line3" x="548" y="173" w="2" h="90" image="1808900012" fitsize="true" gray="false" />
				<image id="wnd2_line4" x="188" y="263" w="140" h="2" image="1809000008" fitsize="true" gray="false" />
				<image id="wnd2_line5" x="400" y="263" w="150" h="2" image="1809000008" fitsize="true" gray="false" />

				<image id="物品框背景1" x="148" y="103" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="物品框1" x="162" y="118" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="1" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="物品框背景2" x="322" y="105" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="物品框2" x="335" y="120" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="2" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="物品框背景3" x="508" y="107" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="物品框3" x="520" y="120" w="55" h="55" auto_manage="true" rbtn_use="false" invalid="true" is_bound="false" init_item="" use_back="false" param="3" OnLButtonClick="Fashion.onBtnC" OnItemMoveIn="Fashion.OnItemMoveIn" />

				<image id="物品框背景4" x="323" y="221" w="80" h="80" image="1806500008" fitsize="true" gray="false"/>
				<itemctrl id="物品框4" x="335" y="235" w="55" h="55"  init_item=""  use_back="false" />

				<richedit id="wnd2_txt4" x="220" y="300" w="500" h="20" text="三件同样时装可以合成一件S级时装" text_color="DARK" font="SIMLI18"/>
				<richedit id="wnd2_txt5" x="188" y="330" w="500" h="20" text="合成需要元宝并且合成的S级时装不能在合成" text_color="DARK" font="SIMLI18"/>
				<richedit id="wnd2_txt6" x="220" y="360" w="500" h="20" text="合成时装,把时装放入上面三个框内" text_color="DARK" font="SIMLI18"/>
				<richedit id="wnd2_txt7" x="280" y="390" w="100" h="20" text="所需元宝：" text_color="YELLOW" font="SIMLI18"/>
				<image id="wnd2_bgk5" x="370" y="390" w="90" h="20"  type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize=true/>
				<richedit id="wnd2_txt8" x="390" y="393" w="80" h="20" text="288888" text_color="GREENG" font="system"/>
				<button id="wnd2_btn1" x="220" y="430" image="1852500055" text="自动放入" text_color="GOLD2" param=1 OnLButtonClick="Fashion.into" />
				<button id="wnd2_btn2" x="360" y="430" image="1852500055" text="时装合成" text_color="GOLD2" param=1 OnLButtonClick="Fashion.synthesis" />

			</wnd>
			<richedit id="标题" x="295" y="-20" w="100" h="20" text="时装锻造" text_color="YELLOW" font="SIMLI18"/>
			<button id="时装锻造" x="50" y="20" image="1804100010" text="时装锻造" text_color="GOLD2" param=1 OnLButtonClick="Fashion.duanzao" />
			<button id="时装强化" x="125" y="20" image="1804100010" text="时装强化" text_color="GOLD2" param=1 OnLButtonClick="Fashion.qianghua" />
			<button id="关闭" x="603" y="-16" image="4000230000" OnLButtonClick="Fashion.Closed" />
		</dialog>
	</form>
	]]
    GenFormByString(str)
    local Handle = GetWindow(nil,"时装界面,wnd2")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
    end
end

Fashion.Init = function(this)
    Fashion.handle = this

    local _GUIHandle = GUI:WndFindWindow(this, "wnd1,武器")
    if _GUIHandle ~= 0 then
        GUI:WndSetPosM(_GUIHandle, 108, 27)
        GUI:WndSetSizeM(_GUIHandle, 50, 240)
        GUI:ItemCtrlSetBigIcon(_GUIHandle, 1)
        GUI:ItemCtrlSetBigIconOffset(_GUIHandle, 218, 285)
        GUI:ImageSetDrawCenter(_GUIHandle,true)
    end

    local _FashionEquimentHandle = GUI:WndFindWindow(this, "wnd1,衣服")
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
    RDItemCtrlSetGUIDataPropByKeyName(nil, "时装界面,wnd1,衣服", Fashion.items[Fashion.Pos][1][1], 1, false)
    RDItemCtrlSetGUIDataPropByKeyName(nil, "时装界面,wnd1,武器", Fashion.items[Fashion.Pos][1][4], 1, false)
    EditSetTextM(nil, "时装界面,wnd1,标题名", Fashion.KeyName2Name(Fashion.items[Fashion.Pos][1][1]))

    local GUIHandle = GetWindow(nil,"时装界面,wnd1,衣服")
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
        local Handle = GetWindow(nil,"时装界面,wnd1,显示"..i)
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, ""..a.."-"..b)
    end

    if UI:Lua_GetItemTemplatePropByID(id,102) ~= nil then
        a = LuaRet
    end

    local Handle = GetWindow(nil,"时装界面,wnd1,显示6")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, ""..a.."%")
    end

    local Handle = GetWindow(nil,"时装界面,wnd1,显示7")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, tostring(Fashion.items[Fashion.Pos][1][6]))
    end

    local Handle = GetWindow(nil,"时装界面,wnd1,显示8")
    if Handle ~= 0 then
        GUI:RichEditClear(Handle)
        GUI:RichEditAppendString(Handle, tostring(Fashion.items[Fashion.Pos][1][7]))
    end

    local tip1, tip2 = "", ""
    if Fashion.items[Fashion.Pos][1][2] ~= nil then
        tip1 = "锻造需要:\n\n"..Fashion.KeyName2Name(Fashion.items[Fashion.Pos][1][2][1]).." * "..Fashion.items[Fashion.Pos][1][2][2]
        tip2 = "抽取需要:\n\n元宝 * "..Fashion.items[Fashion.Pos][1][3]
    end


    WndSetTipInfo(nil, "时装界面,wnd1,锻造", "["..tipText(tip1, mkcolor("GREENG")).."{}]")
    WndSetTipInfo(nil, "时装界面,wnd1,抽取", "["..tipText(tip2, mkcolor("GREENG")).."{}]")
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

    local Handle = GetWindow(nil,"时装界面,wnd2")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
        Handle = GetWindow(nil,"时装界面,wnd1")
        GUI:WndSetVisible(Handle,true)
    end
    Fashion.Pos = 1
    Fashion.Updata()
end

Fashion.qianghua = function(this)

    local Handle = GetWindow(nil,"时装界面,wnd1")
    if Handle ~= 0 then
        GUI:WndSetVisible(Handle,false)
        Handle = GetWindow(nil,"时装界面,wnd2")
        GUI:WndSetVisible(Handle,true)
    end

end

Fashion.MakeOK = function(this)
    local types = WndGetParam(this)
    local index = WndGetProperty(this, nil, "index")
    UI:Lua_SubmitForm("时装锻造表单", "main", Fashion.Pos.."#"..index.."#"..types)
end

Fashion.Closed = function(this)
    local handle =  GetWindow(nil, "时装界面")
    if handle ~= 0 then
        WndCloseM(handle, nil)
    end
end

function Fashion.OnItemMoveIn(this, GUIData, DragIn, GUID, ItemId, KeyName, ItemPos, IsBound, Count) --手动放入时装
    local num = tonumber(GUI:WndGetParam(this))
    local sameCount = 0		--放入相同时装进入物品框中的数量
    local itemNum = 0		--时装keyname对应到fashionsRelated中的第一个

    if CL:GetItemTemplatePropByID(ItemId,ITEM_PROP_SUBTYPE) then
        if LuaRet ~= 16 then
            CL:ShowTypeMsg(3,"您放入的物品不是时装！！！")
            return false
        end
    end

    for i=1,3 do
        if i ~= num then
            local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框"..i)
            if RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") ~= "" and RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") ~= KeyName then --判断是否放入相同时装

                CL:ShowTypeMsg(3,"请放入相同的时装！！！")
                return false
            end
            if RDItemCtrlGetGUIDataKeyName(_ItemHandle,"") == KeyName then
                sameCount = sameCount + 1
            end
        end
    end



    if sameCount ==2 then		--三件相同的时装 生成需要合成时装的模型
        for i=1,#fashionsRelated do
            if KeyName == fashionsRelated[i][1] then
                itemNum = i
            end
        end
        local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框4")
        RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[itemNum][2],1,false)
    end

    return true
end

function Fashion.into(this)		--自动放入时装
    UI:Lua_SubmitForm("时装锻造表单", "automaticallyPlaced", "")
end

local itemKeyName = ""

function Fashion.update() --自动放入
    local num = 0
    for i=1,#fashionsCount do
        if fashionsCount[i] >= 3 then
            num = 1
            for j=1,3 do
                local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框"..j)
                RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[i][1],1,false)
            end
            itemKeyName = fashionsRelated[i][1]
            local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框4")
            RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",fashionsRelated[i][2],1,false)
        end
    end
    if num == 0 then
        CL:ShowTypeMsg(3,"您的背包里没有三件一样的时装！！")
    end
end

function Fashion.synthesis(this)	--合成时装
    local num = 0 --放入物品框中的数量
    local itemName = "" 	--物品框中的时装keyname
    for i = 1,3 do
        local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框"..i)
        if GUI:ItemCtrlGetGUIDataPropByType(_ItemHandle,ITEMGUIDATA_ITEMID)	then --获得模版ID
            itemID = LuaRet
        end

        if itemID ~= 0 then
            if CL:GetItemTemplatePropByID(itemID,ITEM_PROP_KEYNAME) then	--获得物品的keyname
                itemName = LuaRet
            end
        end

        if itemName ~= "" then	--计算物品框中有几时装
            num = num + 1
        end
    end

    if num ~= 3 then
        CL:ShowTypeMsg(3,"请先放入三件时装在点击合成！！！")
        return false
    end

    UI:Lua_SubmitForm("时装锻造表单", "Synthesis",tostring(itemName))
end

function Fashion.onBtnC(this)
    local num = 0
    for i=1,3 do
        local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框"..i)
        if GUI:ItemCtrlGetGUIDataPropByType(_ItemHandle,ITEMGUIDATA_ITEMID)	then --获得模版ID
            itemID = LuaRet
        end

        if itemID ~= 0 then
            num = num + 1
        end
    end
    if num ~= 3 then
        local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框4")
        GUI:ItemCtrlClearItemData(_ItemHandle)
    end
end

function Fashion.clearFashion()
    for i=1,4 do
        local _ItemHandle = GetWindow(0,"时装界面,wnd2,物品框"..i)
        GUI:ItemCtrlClearItemData(_ItemHandle)
    end
end

Fashion.main()