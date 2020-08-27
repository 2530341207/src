worldBoss = {}
local _Handle = 0
local bossRelated = {	--怪物模型图片ID，table(第一个描述，第二个描述，难度星数个数)，table(怪物会掉落的物品1，物品2..(写8个))
	{1221000400,{"开区两小时","两小时",3},{"太初血符","太初令牌","太初血符","太初血符","太初血符","太初血符","太初血符","太初血符"}},
	{693300400,{"开区五小时","五小时",3},{"太初血符","两仪令牌","太初血符","太初血符","太初血符","太初血符","太初血符","太初血符"}},
	{687700400,{"开区八小时","八小时",4},{"太初血符","三才令牌","太初血符","太初血符","太初血符","太初血符","太初血符","太初血符"}},
	{694500400,{"开区十二小时","十二小时",5},{"太初血符","四象令牌","太初血符","太初血符","太初血符","太初血符","太初血符","太初血符"}},
	{1302900400,{"开区二十四小时","二十四小时",6},{"太初血符","五行令牌","太初血符","太初血符","太初血符","太初血符","太初血符","太初血符"}}
}
function worldBoss.Main()
    local handle = GetWindow(nil, "frame")
    if handle ~= 0 then WndClose(handle) end
    local str =[[
		<form>
            <dialog id="frame" image="4000800000" w="900" h="700" close="false" esc_close="true" drag="true" center="true" revmsg="true" OnInit="worldBoss.UIInit"  >
                <image id="img1" x="73" y="145" w="745" h="480" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
                <richedit id="txt1" x="398" y="66" w="100" h="20" text="世界BOSS" text_color="DARK" canedit="false" font="SIMLI18" />

				<wnd id="wnd2" x="287" y="140" w="300" h="350">
                    <image id="img2" x="-250" y="-150" w="800" h="800" type="animate" image="1221000400" fitsize="true" gray="false" />
                    <richedit id="wnd2Txt1" x="125" y="330" w="60" h="15" text="未刷新" text_color="BLUE" canedit="false" font="system" />
                </wnd>

				<wnd id="wnd1" x="76" y="141" w="200" h="350">
                    <image id="wnd1img1" x="10" y="20" w="210" h="70" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1img2" x="10" y="110" w="210" h="70" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1img3" x="10" y="200" w="210" h="70" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1img4" x="10" y="290" w="210" h="70" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1img5" x="10" y="380" w="210" h="70" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd1img6" x="50" y="50" w="170" h="10" image="1801000014" fitsize="true" gray="false" image_color="WHITE" />
					<image id="wnd1img7" x="50" y="140" w="170" h="10" image="1801000014" fitsize="true" gray="false" image_color="WHITE" />
					<image id="wnd1img8" x="50" y="230" w="170" h="10" image="1801000014" fitsize="true" gray="false" image_color="WHITE" />
					<image id="wnd1img9" x="50" y="320" w="170" h="10" image="1801000014" fitsize="true" gray="false" image_color="WHITE" />
					<image id="wnd1img10" x="50" y="410" w="170" h="10" image="1801000014" fitsize="true" gray="false" image_color="WHITE" />
					<image id="wnd1img11" x="0" y="20" w="70" h="70" image="1899100093" fitsize="true" revmsg="true" image_color="WHITE" OnLButtonUp="worldBoss.update" param="1"/>
					<image id="wnd1img12" x="0" y="110" w="70" h="70" image="1899100131" fitsize="true" revmsg="true" image_color="WHITE" OnLButtonUp="worldBoss.update" param="2"/>
					<image id="wnd1img13" x="0" y="200" w="70" h="70" image="1899100076" fitsize="true" revmsg="true" image_color="WHITE" OnLButtonUp="worldBoss.update" param="3"/>
					<image id="wnd1img14" x="0" y="290" w="70" h="70" image="1899100145" fitsize="true" revmsg="true" image_color="WHITE" OnLButtonUp="worldBoss.update" param="4"/>
					<image id="wnd1img15" x="0" y="380" w="70" h="70" image="1899100188" fitsize="true" revmsg="true" image_color="WHITE" OnLButtonUp="worldBoss.update" param="5"/>
					<richedit id="wnd1ttx1" x="85" y="30" w="120" h="15" text="[世界BOSS]" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx2" x="85" y="120" w="120" h="15" text="[世界BOSS]" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx3" x="85" y="210" w="120" h="15" text="[世界BOSS]" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx4" x="85" y="300" w="120" h="15" text="[世界BOSS]" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx5" x="85" y="390" w="120" h="15" text="[世界BOSS]" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx6" x="95" y="60" w="80" h="15" text="斑斓巨虎" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx7" x="95" y="150" w="80" h="15" text="素云雪妖" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx8" x="95" y="240" w="80" h="15" text="捕灵鬼鲛" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx9" x="95" y="330" w="80" h="15" text="黑炎凤凰" text_color="GOLD" canedit="false" font="system" />
					<richedit id="wnd1ttx10" x="95" y="420" w="80" h="15" text="异界兽王" text_color="GOLD" canedit="false" font="system" />
				</wnd>

                <wnd id="wnd3" x="550" y="160" w="200" h="480">
					<image id="wnd3Img1" x="0" y="0" w="250" h="430" type="around" image="1855027000,1855027002,1855027006,1855027008,1855027004,1855027001,1855027007,1855027003,1855027005" fitsize="true" gray="false" />
					<image id="wnd3Img2" x="5" y="35" w="70" h="1" image="1855500002" fitsize="true" gray="false" />
					<image id="wnd3Img3" x="170" y="130" w="70" h="1" image="1855500002" fitsize="true" gray="false" />
					<richedit id="wnd3Txt1" x="80" y="24" w="80" h="15" text="BOSS介绍" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd3Txt2" x="9" y="47" w="90" h="15" text="降临时间:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd3Txt3" x="9" y="70" w="90" h="15" text="刷新时间:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd3Txt4" x="9" y="92" w="90" h="15" text="击杀难度:" text_color="DARKGOLD" canedit="false" font="system" />
					<richedit id="wnd3Txt6" x="100" y="47" w="150" h="15" text="开区后两小时" text_color="WhITE" canedit="false" font="system" />
					<richedit id="wnd3Txt7" x="100" y="70" w="150" h="15" text="两小时" text_color="WhITE" canedit="false" font="system" />

					<image id="wnd3Img4" x="170" y="35" w="70" h="1" image="1855500002" fitsize="true" gray="false" />
					<image id="wnd3Img5" x="5" y="130" w="70" h="1" image="1855500002" fitsize="true" gray="false" />
					<richedit id="wnd3Txt5" x="80" y="123" w="80" h="15" text="物品掉落" text_color="DARKGOLD" canedit="false" font="system" />

					<image id="wnd3Img10" x="15" y="160" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img11" x="70" y="160" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img12" x="125" y="160" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img13" x="180" y="160" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img14" x="15" y="230" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img15" x="70" y="230" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img16" x="125" y="230" w="50" h="50" image="1857060003" fitsize="true" gray="false" />
					<image id="wnd3Img17" x="180" y="230" w="50" h="50" image="1857060003" fitsize="true" gray="false" />

					<itemctrl id="wnd3Item1" x="15" y="160" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item2" x="70" y="160" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item3" x="125" y="160" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item4" x="180" y="160" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item5" x="15" y="230" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item6" x="70" y="230" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item7" x="125" y="230" w="50" h="50"  is_bound="false" init_item="" />
					<itemctrl id="wnd3Item8" x="180" y="230" w="50" h="50"  is_bound="false" init_item="" />

					<button id="wnd3Btn" x="50" y="300" w="137" h="47" image="1851500004" text="挑战" text_color="GOLD"  shine="true" param="1" OnLButtonClick="worldBoss.submit"/>
				</wnd>
				<button id="wndColse" x="800" y="50" w="137" h="47" image="4000230000"  OnLButtonClick="worldBoss.close"/>
            </dialog>
        </form>
	]]
    GenFormByString(str)
    _Handle = GetWindow(nil, "frame,wnd3")
    for i=1,6 do
        local _ImgHandle = GUI:ImageCreate(_Handle,"wnd3txtImg"..i,1802400026,100+(i-1)*(20),92)
        if _ImgHandle ~= 0 then
			if i <= bossRelated[1][2][3] then
				ImageSetImageID(_ImgHandle,"",1802400025)
			end
        end
    end
	for i=1,8 do
		local _ItemHandle = GetWindow(nil, "frame,wnd3,wnd3Item"..i)
		if _ItemHandle ~= nil then
			UI:Lua_RDItemCtrlShowQualityBG(_ItemHandle, false)
			RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",bossRelated[1][3][i],1,false)
		end
	end
	--修改是否刷新

	local _EditHandle = GetWindow(0,"frame,wnd2,wnd2Txt1")
	if _EditHandle ~= 0 then
		GUI:RichEditClear(_EditHandle)
		if sfsx[1] == 1 then
			GUI:RichEditAppendString(_EditHandle,"已刷新")
		else
			GUI:RichEditAppendString(_EditHandle,"未刷新")
		end

	end

end

function worldBoss.UIInit(this)

end

function worldBoss.update(this)
	local num = tonumber(GUI:WndGetParam(this))
	--修改对应boss动画
	local _ImgHandle = GetWindow(0,"frame,wnd2,img2")
	if _ImgHandle ~= nil then
		ImageSetImageID(_ImgHandle,"",bossRelated[num][1])
		GUI:ImageSetAnimateEnable(_ImgHandle,true,100)
	end
	--设置挑战按钮的自定义参数
	local _BtnHandle = GetWindow(0,"frame,wnd3,wnd3Btn")
	if _BtnHandle ~= nil then
		GUI:WndSetParam(_BtnHandle,num)
	end
	--修改介绍文字
	for i=1,2 do
		local _EditHandle = GetWindow(0,"frame,wnd3,wnd3Txt"..(i+5))
		GUI:RichEditClear(_EditHandle)
		GUI:RichEditAppendString(_EditHandle,bossRelated[num][2][i])
	end
	--修改难度星
	for i=1,bossRelated[num][2][3] do
        local _ImgHandle = GetWindow(0,"frame,wnd3,wnd3txtImg"..i)
        if _ImgHandle ~= 0 then
			ImageSetImageID(_ImgHandle,"",1802400025)
        end
    end
	--修改掉落的物品显示
	for i=1,8 do
		local _ItemHandle = GetWindow(nil, "frame,wnd3,wnd3Item"..i)
		if _ItemHandle ~= nil then
			RDItemCtrlSetGUIDataPropByKeyName(_ItemHandle,"",bossRelated[num][3][i],1,false)
		end
	end
	--修改怪物是否刷新
	local _EditHandle = GetWindow(0,"frame,wnd2,wnd2Txt1")
	if _EditHandle ~= 0 then
		GUI:RichEditClear(_EditHandle)
		if sfsx[num] == 1 then
			GUI:RichEditAppendString(_EditHandle,"已刷新")
		else
			GUI:RichEditAppendString(_EditHandle,"未刷新")
		end

	end

end

function worldBoss.submit(this)
	local num = GUI:WndGetParam(this)
	UI:Lua_SubmitForm("世界BOSS", "receive", tostring(num))
end

function worldBoss.close(this)
	WndClose(0,"frame")
end

worldBoss.Main()