-- 坐骑锻造 客户端脚本文件 2017年9月15日 16:52:08 Powered By QQ20606919 Design--



GodWing = {}

GodWing.Handle = 0

GodWing.Verify = {--授权代理ID
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
    local handle = GetWindow(nil, "坐骑锻造")
    if handle ~= 0 then WndClose(handle) end
    local str = [[
	<form>
		<dialog id=坐骑锻造 x=0 y=0 w=600 h=500 image=1803700001 fitsize=1 npc=]]..godwing_npc..[[ center=1 savepos=1 OnInit=GodWing.Init>
			<image id=主背景 x=0 y=0 image=1803700001 type=flat w=409 h=330/>
			<image id=图 x=35 y=55 w=535 h=430 image=1803700018 fitsize=1/>
			<image id=线 x=29 y=325 w=351 h=3 type=flat image=1800000034/>
			<richedit id="标题" x="252" y="11" w="100" h="20" text="]]..godwing_t.name..[[锻造" text_color="YELLOW" font="SIMLI18"/>
		    <button id="关闭" x="525" y="5" image="1850000423" OnLButtonClick="GodWing.Closed" />
			<image id="坐骑展示" x=33 y=0 image=0 fitsize=true/>
			<edit id="字3" x=250 y=250 w=200 h=16 text_color="#D3D2D0" text="进阶条件"/>
			<image id="九宫格" x=111 y=352 w=188 h=28 image=1800000325,1800000326,1800000327,1800000328,1800000333,1800000329,1800000330,1800000331,1800000332 revmsg=1/>
			<richedit id="文字提示1" x=200 y=280 w=400 h=15 text_color="GREENG" text="鼠标移入查看锻造条件"/>
			<richedit id="文字提示2" x=200 y=300 w=400 h=15 text_color="GREENG" text="鼠标移入查看锻造条件"/>

			<image id="题1" x=42 y=310 image=1800900018 fitsize=1 w=150 h=50/>
			<edit id="字1" x=80 y=330 w=200 h=16 text_color="BROWN2" text="当前佩戴"/>
			<image id=框1 x=85 y=363 w=69 h=69 fitsize=1 image=1800000080/>
			<itemctrl id=物品1 x=92 y=369 w=60 h=60 use_back=0/>
			<image id="题2" x=395 y=310 image=1800900018 fitsize=1 w=150 h=50/>
			<edit id="字2" x=431 y=330 w=200 h=16 text_color="BROWN2" text="下阶预览"/>
			<image id=框2 x=437 y=363 w=69 h=69 fitsize=1 image=1800000080/>
			<itemctrl id=物品2 x=444 y=369 w=60 h=60 use_back=0/>
			<image id="阶级" x=500 y=80 image=1802300002/>
			<richedit id="字阶" x=504 y=80 w=100 h=15 font="SIMLI18" text_color="#FF0000" text="一\n阶"/>
			<button id="进阶" x=220 y=420 image=1852600003 text="免费进阶" text_color="GOLD2" OnLButtonClick=GodWing.UpLv/>
		</dialog>
	</form>
	]]
    GenFormByString(str)
end

function GodWing.Init(this)
    GodWing.Handle = this


    --WndAddEffect(this, "物品1", 3020101000, -28, -28, 150, 0)
    --WndAddEffect(this, "物品2", 3020101000, -28, -28, 150, 0)


    RichEditClear(nil, "坐骑锻造,文字提示1")
    RichEditClear(nil, "坐骑锻造,文字提示2")
    local lv = godwing_lv
    local nlv = math.min(lv+1, #godwing_t)
    local tab = godwing_t[nlv]

    if tab.cls ~= nil then
        RichEditAppendString(nil, "坐骑锻造,文字提示1", "消耗材料："..GodWing.KeyName2Name(tab.cls[1]).."×"..tab.cls[2].."")
    end
    if tab.ite ~= nil then
        RichEditAppendString(nil, "坐骑锻造,文字提示2", "消耗装备："..GodWing.KeyName2Name(tab.ite[1]).."×"..tab.ite[2].."")
    end

    GodWing.Update(godwing_lv)
end

function GodWing.Update(lv)
    local this = GodWing.Handle
    local nlv = math.min(lv+1, #godwing_t)
    local tab = godwing_t[nlv]
    RichEditClear(this, "字阶")
    RichEditAppendString(this, "字阶", tab.lvs)

    local _Handle = GetWindow(this,"翅膀展示")
    if _Handle ~= nil then
        GUI:WndSetPosM(_Handle,position[nlv][1],position[nlv][2])
        GUI:WndSetSizeM(_Handle,position[nlv][3],position[nlv][4])
        GUI:ImageSetAnimateEnable(_Handle,true,200)
        ImageSetImageID(this, "坐骑展示", tab.img[1])
    end

    if lv + 1 > #godwing_t then
        RichEditClear(this, "消耗值")
        RichEditAppendString(this, "消耗值", godwing_t.max)
        RDItemCtrlSetGUIDataPropByKeyName(this, "物品1", tab.key, 1, false)
        RDItemCtrlSetGUIDataPropByKeyName(this, "物品2", tab.key, 1, false)
        WndSetEnableM(this, "进阶", false)

        local tip = "["
        tip = tip..tipText(godwing_t.max, "#FF0000","system")
        tip = tip.."{}]"
        WndSetTipInfo(this, "进阶", tip)
        WndSetTipInfo(this, "九宫格", tip)
    else
        RDItemCtrlSetGUIDataPropByKeyName(this, "物品2", tab.key, 1, false)
        if godwing_t[lv] ~= nil then
            RDItemCtrlSetGUIDataPropByKeyName(this, "物品1", godwing_t[lv].key, 1, false)
        end
        local tip = "["
        tip = tip..tipText("“"..GodWing.KeyName2Name(tab.key).."”锻造\n", "#FF0000","system")
        if tab.ybs ~= nil then
            tip = tip..tipLine()..tipText("消耗元宝："..tab.ybs.."\n", "PURPLE","system")
        end
        if tab.jbs ~= nil then
            tip = tip..tipLine()..tipText("消耗金币："..tab.jbs.."\n", "YELLOW","system")
        end
        if tab.cls ~= nil then
            tip = tip..tipLine()..tipText("消耗材料："..GodWing.KeyName2Name(tab.cls[1]).."×"..tab.cls[2].."\n", "ORANGE","system")
        end
        if tab.ite ~= nil then
            tip = tip..tipLine()..tipText("消耗装备："..GodWing.KeyName2Name(tab.ite[1]).."×"..tab.ite[2].."\n", "ORANGE","system")
        end
        tip = tip.."{}]"
        WndSetTipInfo(this, "进阶", tip)
        WndSetTipInfo(this, "九宫格", tip)
    end
end

function GodWing.UpLv(this)
    local script = [[UI:Lua_SubmitForm("坐骑锻造表单", "main", ]]..string.format("%q", godwing_lv.."#"..godwing_npc)..[[)]]
    local str = "#COLORCOLOR_GREENG#您确定要锻造#COLORCOLOR_PURPLE#“"..GodWing.KeyName2Name(godwing_t[godwing_lv+1].key).."”#COLORCOLOR_GREENG#吗？"
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